//
//  InterestsViewController.swift
//  Dame Veneno
//
//  Created by Jose Antonio Córdoba Gómez on 30/12/17.
//  Copyright © 2017 Jose Antonio Córdoba Gómez. All rights reserved.
//

// @Todo: Que cuando pulses un elemento del collection view se reprozdca / pause el reproductor
// @Todo: Detectar un pulso largo -> compartir
// @Todo: Vincular el botón al speech-recognizer

import UIKit
import BWWalkthrough
import Speech
import AVFoundation
import AVKit
import GSMessages

class InterestsViewController: UIViewController,BWWalkthroughViewControllerDelegate,  SFSpeechRecognizerDelegate, AVAudioPlayerDelegate
{
    
    enum SpeechStatus {
        case ready
        case recognizing
        case unavailable
    }
    
    var player : AVAudioPlayer?
    var reproduciendo = false;
    
    var status : SpeechStatus = SpeechStatus.unavailable
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "es-ES"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var microfono : UIImageView!
    @IBOutlet weak var DameVeneno: UILabel!
    
    var interests = ElementoVeneno.capturarElementosVeneno()
    let cellScaling: CGFloat = 0.6
    
    var estaGrabando : Bool = false
    
    @objc func manejadorPulsacionLarga(gesture : UILongPressGestureRecognizer!) {
        if gesture.state != .ended {
            return
        }
        
        let p = gesture.location(in: self.collectionView)
        
        if let indexPath = self.collectionView.indexPathForItem(at: p) {
            // get the cell at indexPath (the one you long pressed)
            let cell = self.collectionView.cellForItem(at: indexPath)
            // do stuff with the cell
            //print("Pulsacion larga detectada:", self.interests[indexPath.item].titulo)
            self.compartir(audioSinExtension: self.interests[indexPath.item].archivo)
            // Compartir
        } else {
            print("couldn't find index path")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.player?.delegate = self
        self.speechRecognizer?.delegate = self
        
        self.showMessage("Recuerda no tener el dispositivo en silencio", type: .success,options:
            [.animation(.slide),
            .animationDuration(0.85),
            .autoHide(true),
            .height(64.0),
            .hideOnTap(true),
            .margin(.zero),
            .padding(.init(top: 10, left: 30, bottom: 10, right: 30)),
            .position(.bottom),
            .textNumberOfLines(2)
            ]
        )

        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
            case .denied:
                isButtonEnabled = false
                print("El usuario ha inhabilitado el reconocimiento")
            case .restricted:
                isButtonEnabled = false
                print("El reconocimiento no está disponible en el dispositivo")
            case .notDetermined:
                isButtonEnabled = false
                print("Reconomiento no habilitado aún")
            }
        }
        
        let userDefaults = UserDefaults.standard
        
        // Comprobar en el inicio de la vista
        if !userDefaults.bool(forKey: "walkthroughPresented") {
            showWalkthrough()
            userDefaults.set(true, forKey: "walkthroughPresented")
            userDefaults.synchronize()
        }
        

        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        microfono.isUserInteractionEnabled = true
        microfono.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureREcognizerText = UITapGestureRecognizer(target: self, action:#selector(labelTapped(tapGestureRecognizer:)))
        DameVeneno.isUserInteractionEnabled = true
        DameVeneno.addGestureRecognizer(tapGestureREcognizerText)

        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(InterestsViewController.manejadorPulsacionLarga))
        collectionView.addGestureRecognizer(lpgr)
        
    }
    
    
    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        let recognitionRequest = self.recognitionRequest
        recognitionRequest?.shouldReportPartialResults = true
        
        
        
        
        recognitionTask = self.speechRecognizer?.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                isFinal = (result?.isFinal)!
                if(isFinal){
                    self.procesarTexto(texto: (result?.bestTranscription.formattedString)!)
                }
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                //self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        
    }
    

    
    
    @IBAction func showWalkthrough(){
        
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "PasitosAyuda", bundle: nil)
        let walkthrough = stb.instantiateViewController(withIdentifier: "walk") as! BWWalkthroughViewController

        let page_one = stb.instantiateViewController(withIdentifier: "walk1")
        let page_two = stb.instantiateViewController(withIdentifier: "walk2")
        let page_three = stb.instantiateViewController(withIdentifier: "walk3")
        let page_four = stb.instantiateViewController(withIdentifier: "walk4")
        let page_five = stb.instantiateViewController(withIdentifier: "walk5")
        
        walkthrough.delegate = self
        walkthrough.add(viewController:page_one)
        walkthrough.add(viewController:page_two)
        walkthrough.add(viewController:page_three)
        walkthrough.add(viewController:page_four)
        walkthrough.add(viewController:page_five)
        
        self.present(walkthrough, animated: true, completion: nil)
    }
    
    func walkthroughPageDidChange(_ pageNumber: Int) {
        print("Current Page \(pageNumber)")
    }
    
    func walkthroughCloseButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    
    func procesarTexto(texto: String){
        print(texto)
        self.player?.stop()
        self.reproduciendo = false
        if(texto.contains("Cómo te llamas") || texto.contains("como te llamas") || texto.contains("cómo te llamas")){
            if arc4random() % 3 == 0{
                playSound(audioSinExtension: "polaca")
            }else{
                playSound(audioSinExtension: "cristina")
            }
        }else if(texto.contains("cómo me llamo") || texto.contains("Cómo me llamo") || texto.contains("cómo me llamo")){
            playSound(audioSinExtension: "canalla")
        }else if(texto.contains("Qué vamos a comer") || texto.contains("menú") || texto.contains("comer")){
            playSound(audioSinExtension: "deto")
        }else if(texto.contains("conoces a marisol") || texto.contains("Conoces a marisol") || texto.contains("aceite de aviones") || texto.contains("cartujana")){
            playSound(audioSinExtension: "aceite")
        }else if(texto.contains("sentir") || texto.contains("empanada")){
            playSound(audioSinExtension: "aceituna")
        }else if(texto.contains("puedo pasar") || texto.contains("adelante")){
            playSound(audioSinExtension: "adelante")
        }else if(texto.contains("dieta") || texto.contains("mi madre")){
            playSound(audioSinExtension: "aDieta")
        }else if(texto.contains("a la mierda")){
            playSound(audioSinExtension: "alamierda")
        }else if(texto.contains("me he tomado") || texto.contains("ambipur")){
            playSound(audioSinExtension: "ambipur")
        }else if(texto.contains("te llevas bien") || texto.contains("con la veneno")){
            playSound(audioSinExtension: "amiga")
        }else if(texto.contains("androcur") || texto.contains("que hace") || texto.contains("obesa")){
            if arc4random()%2 == 0 {
                playSound(audioSinExtension: "androcur")
            }else{
                playSound(audioSinExtension: "obesa")
            }
        }else if(texto.contains("que pelicula te gusta") || texto.contains("que película te gusta") || texto.contains("película favorita") || texto.contains("pelicula favorita")){
            playSound(audioSinExtension: "woman")
        }else if(texto.contains("tacones") || texto.contains("caminar")){
            playSound(audioSinExtension: "aprende")
        }else if(texto.contains("aprieta")){
            playSound(audioSinExtension: "aprieta")
        }else if(texto.contains("arcancia")){
            playSound(audioSinExtension: "arcancia")
        }else if(texto.contains("así") || texto.contains("a si") || texto.contains("mismo")){
            playSound(audioSinExtension: "ashin")
        }else if(texto.contains("ATS") || texto.contains("perro") || texto.contains("enfermero")){
            playSound(audioSinExtension: "ATS")
        }else if(texto.contains("te han comparado") || texto.contains("me han comparado") || texto.contains("bellezas")){
            playSound(audioSinExtension: "bellezas")
        }else if(texto.contains("voy por la calle") || texto.contains("me dan besos") || texto.contains("te dan besos")){
            playSound(audioSinExtension: "besos")
        }else if(texto.contains("eres una ladrona") || texto.contains("boxer")){
            playSound(audioSinExtension: "boxer")
        }else if(texto.contains("venid") || texto.contains("llamalos") || texto.contains("que vengan")){
            playSound(audioSinExtension: "veniPaCa")
        }else if(texto.contains("todo en esta vida") || texto.contains("que tienes") || texto.contains("salud") || texto.contains("dinero") || texto.contains("amor")) {
            playSound(audioSinExtension: "vida")
        }else if(texto.contains("figir") || texto.contains("la voz")){
            playSound(audioSinExtension: "vos")
        }else if(texto.contains("uy")){
            playSound(audioSinExtension: "uy")
        }else if(texto.contains("úrsula") || texto.contains("ursula")){
            playSound(audioSinExtension: "ursula")
        }else if(texto.contains("tú no") || texto.contains("tu no") || texto.contains("elegías al cliente") || texto.contains("al cliente")){
            playSound(audioSinExtension: "tuno")
        }else if(texto.contains("coche")){
            playSound(audioSinExtension: "tresruedas")
        }else if(texto.contains("braguitas") || texto.contains("bragas") || texto.contains("lengüetazos") || texto.contains("mi marido")){
            if arc4random() % 2 == 0 {
                self.playSound(audioSinExtension: "braguitas")
            }else if arc4random() % 2 == 0{
                self.playSound(audioSinExtension: "nollevobravas")
            }else if arc4random() % 2 == 0{
                self.playSound(audioSinExtension: "sillevobragas")
            }else {
                self.playSound(audioSinExtension: "si")
            }
        }else if(texto.contains("brevas") || texto.contains("atraganto")){
            playSound(audioSinExtension: "brevas")
        }else if(texto.contains("cartier") || texto.contains("brilla") || texto.contains("vistes") || texto.contains("llevas puesto")){
            playSound(audioSinExtension: "brilla")
        }else if(texto.contains("te pareces a mi") || texto.contains("caballo")){
            playSound(audioSinExtension: "caballo")
        }else if(texto.contains("morreaba") || texto.contains("calentona") || texto.contains("con las piernas")){
            playSound(audioSinExtension: "calentona")
        }else if(texto.contains("manda a callar") || texto.contains("silencio")){
            playSound(audioSinExtension: "callaros")
        }else if(texto.contains("callate")){
            playSound(audioSinExtension: "callate")
        }else if(texto.contains("camaleónica") || texto.contains("camaleonica")){
            playSound(audioSinExtension: "camaleonica")
        }else if(texto.contains("sandra") || texto.contains("amigas mias")){
            playSound(audioSinExtension: "camellona")
        }else if(texto.contains("me gusta") || texto.contains("cansa")){
            playSound(audioSinExtension: "cansa")
        }else if(texto.contains("canta veneno") || texto.contains("canta") || texto.contains("canta algo")){
            if arc4random()%2 == 0{
                playSound(audioSinExtension: "cantar")
            }else {
                playSound(audioSinExtension: "canto")
            }
        }else if(texto.contains("sin operar") || texto.contains("triturar la carne") || texto.contains("maquina")){
            playSound(audioSinExtension: "carne")
        }else if(texto.contains("te quiero") || texto.contains("me gustas")){
            playSound(audioSinExtension: "caso")
        }else if(texto.contains("diplomatico")){
            playSound(audioSinExtension: "chuparmamaryfollar")
        }else if(texto.contains("colectivo") || texto.contains("fina")){
            playSound(audioSinExtension: "colectivo")
        }else if(texto.contains("coño") || texto.contains("por que")){
            playSound(audioSinExtension: "conio")
        }else if(texto.contains("donde eres conocida") || texto.contains("te conoce")){
            if arc4random()%2 == 0{
                playSound(audioSinExtension: "conosia")
            }else {
              playSound(audioSinExtension: "conozco")
            }
            
        }else if(texto.contains("criticar") || texto.contains("drogadicta")){
            playSound(audioSinExtension: "criticar")
        }else if(texto.contains("cubata")){
            playSound(audioSinExtension: "cubata")
        }else if(texto.contains("cuernos")){
            playSound(audioSinExtension: "cuernos")
        }else if(texto.contains("cuerpo")){
            if arc4random()%2 == 0{
                playSound(audioSinExtension: "cuerpo")
            }else {
                playSound(audioSinExtension: "cuerpoCompleto")
            }
            
        }else if(texto.contains("digo")){
            playSound(audioSinExtension: "digo")
        }else if(texto.contains("curriculum") || texto.contains("quien eres") || texto.contains("no eres nada") || texto.contains("tarantula") || texto.contains ("del monton") ||
            texto.contains("del montón")){
            if arc4random() % 2 == 0{
                playSound(audioSinExtension: "curriculum")
            }else{
                playSound(audioSinExtension: "tarantula")
            }
            
        }else if(texto.contains("dedos") || texto.contains("masturbaste") || texto.contains("masturbar")){
            playSound(audioSinExtension: "dedos")
        }else if(texto.contains("denegado")){
            playSound(audioSinExtension: "denegao")
        }else if(texto.contains("diplomatico") || texto.contains("diplomático")){
            playSound(audioSinExtension: "diplomatico")
        }else if(texto.contains("dormir")){
            playSound(audioSinExtension: "dormir")
        }else if(texto.contains("dotado") || texto.contains("la tiene tu marido")){
            playSound(audioSinExtension: "dotado")
        }else if(texto.contains("ejercer")){
            playSound(audioSinExtension: "ejercer")
        }else if(texto.contains("elegías") || texto.contains("elegias") || texto.contains("elegir") || texto.contains("seleccionar")){
            playSound(audioSinExtension: "elegias")
        }else if(texto.contains("rumano")){
            playSound(audioSinExtension: "enRumano")
        }else if(texto.contains("envidia") || texto.contains("envidiosa")){
            if arc4random()%3 == 0{
                playSound(audioSinExtension: "envidiaSana")
            }else if  arc4random()%3 == 1 {
                playSound(audioSinExtension: "envidiosa")
            }else if arc4random() % 2 == 0{
                playSound(audioSinExtension: "lepego")
            }else{
                playSound(audioSinExtension: "toro")
            }
        }else if(texto.contains("escoger")){
            playSound(audioSinExtension: "escoger")
        }else if(texto.contains("españa") || texto.contains("España") || texto.contains("pese") || texto.contains("en este pais") || texto.contains("en éste país")){
            playSound(audioSinExtension: "espania")
        }else if(texto.contains("rabo")){
            playSound(audioSinExtension: "esta")
        }else if(texto.contains("fama")){
            playSound(audioSinExtension: "fama")
        }else if(texto.contains("farmacia") || texto.contains("Farmacia") || texto.contains("señores") || texto.contains("condones") || texto.contains("farmaceuticos") ||
            texto.contains("farmaceúticos")){
            playSound(audioSinExtension: "farmaceuticos")
        }else if(texto.contains("farruquito")){
            playSound(audioSinExtension: "farruquito")
        }else if(texto.contains("fea")){
            playSound(audioSinExtension: "fea")
        }else if(texto.contains("fina")){
            playSound(audioSinExtension: "fisna")
        }else if(texto.contains("futbolista")){
            playSound(audioSinExtension: "furgolista")
        }else if(texto.contains("geronimo") || texto.contains("Geronimo")){
            playSound(audioSinExtension: "geronimo")
        }else if(texto.contains("guapa")){
            playSound(audioSinExtension: "gracias")
        }else if(texto.contains("adios") || texto.contains("Hasta luego") || texto.contains("Adiós")){
            playSound(audioSinExtension: "hastaLuego")
        }else if(texto.contains("higuera") || texto.contains("eres tonta") || texto.contains("caido")){
            playSound(audioSinExtension: "higuera")
        }else if(texto.contains("entiendes") || texto.contains("inculta")){
            playSound(audioSinExtension: "incurta")
        }else if(texto.contains("no te metas") || texto.contains("no me insultes")){
            playSound(audioSinExtension: "insultar")
        }else if(texto.contains("has comprado")){
            if arc4random() % 2 == 0{
                playSound(audioSinExtension: "maritrini")
            }
            else if arc4random() % 2 == 1{
                playSound(audioSinExtension: "labio")
            }else {
                playSound(audioSinExtension: "tiendaErotica")
            }
        }else if(texto.contains("labrar")){
            playSound(audioSinExtension: "labrar")
        }else if(texto.contains("mi libro")){
            playSound(audioSinExtension: "lavidaibaenserio")
        }else if(texto.contains("no") || texto.contains("No")){
            playSound(audioSinExtension: "noQueValoh")
        }else if(texto.contains("tengo que limpiar") || texto.contains("marrana") || texto.contains("limpia")){
            playSound(audioSinExtension: "marranona")
        }else if(texto.contains("Maria") || texto.contains("maria") || texto.contains("mari") || texto.contains("María") || texto.contains("maría")){
            playSound(audioSinExtension: "maria")
        }else if(texto.contains("maradona")){
            playSound(audioSinExtension: "maradona")
        }else if(texto.contains("criticado") || texto.contains("travesti") || texto.contains("Bibiana") || texto.contains("bibiana")){
            playSound(audioSinExtension: "manolo")
        }else if(texto.contains("loca")){
            playSound(audioSinExtension: "loca")
        }else if(texto.contains("te encuentras") || texto.contains("estas") || texto.contains("estás")){
            if arc4random() % 2 == 0{
                playSound(audioSinExtension: "mal")
            }else{
                playSound(audioSinExtension: "mala")
            }
        }else if(texto.contains("manola") || texto.contains("Manola") || texto.contains("Manoli") || texto.contains("manoli") || texto.contains("mano")){
            playSound(audioSinExtension: "manola")
        }else if(texto.contains("perdon") || texto.contains("perdón") || texto.contains("disculpas")){
            playSound(audioSinExtension: "perdon")
        }else if(texto.contains("paquete")){
            playSound(audioSinExtension: "paqueton")
        }else if(texto.contains("poder") || texto.contains("poderío") || texto.contains("poderio")){
            playSound(audioSinExtension: "poderio")
        }else if(texto.contains("personaje")){
           playSound(audioSinExtension: "personaje")
        }else if(texto.contains("obregón") || texto.contains("Obregón") || texto.contains("obregon")){
           playSound(audioSinExtension: "obregon")
        }else if(texto.contains("ojete")){
            playSound(audioSinExtension: "ojete")
        }else if(texto.contains("ordinaria")){
            playSound(audioSinExtension: "ordinaria")
        }else if(texto.contains("si")){
            playSound(audioSinExtension: "si")
        }else if(texto.contains("talco")){
            playSound(audioSinExtension: "talco")
        }else if(texto.contains("toro")){
            playSound(audioSinExtension: "toro")
        }else if(texto.contains("nadie") || texto.contains("todos")){
            playSound(audioSinExtension: "todos")
        }else if(texto.contains("troya") || texto.contains("toya")){
            playSound(audioSinExtension: "toya")
        }else if(texto.contains("calle") || texto.contains("no te he visto")){
            playSound(audioSinExtension: "tarrastro")
        }else if(texto.contains("sombra")){
            playSound(audioSinExtension: "sombra")
        }else if(texto.contains("tetas")){
            playSound(audioSinExtension: "tetas")
        }else if(texto.contains("noche")){
            playSound(audioSinExtension: "tracatra")
        }else if(texto.contains("da igual")){
            playSound(audioSinExtension: "suda")
        }else if(texto.contains("sevillana")){
            playSound(audioSinExtension: "sevillana")
        }else if(texto.contains("labios") || texto.contains("color") || texto.contains("rojo")){
            playSound(audioSinExtension: "rojo")
        }else if(texto.contains("prostituta")){
            playSound(audioSinExtension: "puton")
        }else if(texto.contains("quirofano")){
            playSound(audioSinExtension: "quirofano")
        }else if(texto.contains("casanova") || texto.contains("nova") || texto.contains("pollanova")){
            playSound(audioSinExtension: "pollaleopardo")
        }else if(texto.contains("risa") || texto.contains("mujer")){
            playSound(audioSinExtension: "popeye")
        }else if(texto.contains("reto")){
            playSound(audioSinExtension: "reto")
        }else if(texto.contains("Rocío") || texto.contains("rocío") || texto.contains("Rocio") || texto.contains("rocio")){
            playSound(audioSinExtension: "rocio")
        }else if(texto.contains("rosi") || texto.contains("Rosi") ){
            playSound(audioSinExtension: "rosi")
        }else if(texto.contains("Sandra") || texto.contains("sandra")){
            playSound(audioSinExtension: "sandra")
        }else if(texto.contains("te ve")){
            playSound(audioSinExtension: "setevenlospezones")
        }else if(texto.contains("pues")){
            playSound(audioSinExtension: "pues")
        }else if(texto.contains("te quiere")){
            playSound(audioSinExtension: "quiere")
        }
        
    }
    
    func compartir(audioSinExtension : String){
        
         let urlFile = Bundle.main.url(forResource: audioSinExtension, withExtension: "mp3")
         let activityViewController = UIActivityViewController(activityItems:  [urlFile] , applicationActivities: nil)
         activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
         
         activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.postToWeibo, UIActivityType.postToTencentWeibo, UIActivityType.postToVimeo ]
         // present the view controller
         self.present(activityViewController, animated: true, completion: nil)
        
        
        
//
//
//        if let asset = NSDataAsset(name:audioSinExtension){
//            let temporalURL  = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("andaPaqui.mp3")
//
//            do {
//                try asset.data.write(to: temporalURL)
//
//                let activityViewController = UIActivityViewController(activityItems:  [temporalURL] , applicationActivities: nil)
//                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//
//                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.postToWeibo, UIActivityType.postToTencentWeibo, UIActivityType.postToVimeo ]
//                self.present(activityViewController, animated: true, completion: nil)
//            }catch{}
//
//
//        }else{
//
//        }
    }

    


    
    @objc func labelTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("Has tocado Dame Veneno")
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "infoView") as! InformacionViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let newViewController = storyBoard.instantiateViewController(withIdentifier: "infoView") as! InformacionViewController
        //self.present(newViewController, animated: true, completion: nil)
    }
    
    func nukeAllAnimations() {
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            
            tappedImage.image = tappedImage.image!.withRenderingMode(.alwaysTemplate)
            tappedImage.tintColor = UIColor.black
            self.hideMessage()
            
        } else {
            startRecording()
            tappedImage.image = tappedImage.image!.withRenderingMode(.alwaysTemplate)
            tappedImage.tintColor = UIColor.red
            
            self.showMessage("La Veneno te está eschando. Vuelve a pulsar para que procese la respuesta", type: .info ,options:
                [.animation(.slide),
                 .animationDuration(0.35),
                 .autoHide(false),
                 .height(64.0),
                 .hideOnTap(true),
                 .margin(.zero),
                 .padding(.init(top: 10, left: 30, bottom: 10, right: 30)),
                 .position(.bottom),
                 .textNumberOfLines(2)
                ]
            )
        }
    }
    
    
    // Busca el archivo 'audioSinExtension'.mp3
    // Si lo encuentra, lo reproduce
    func playSound(audioSinExtension: String){
        
        if !reproduciendo{
            if let soundURL = Bundle.main.url(forResource: audioSinExtension, withExtension: "mp3") {
                
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
                    try AVAudioSession.sharedInstance().setActive(true)
                    player = try AVAudioPlayer(contentsOf: soundURL)
                    // For iOS 11
                    player = try AVAudioPlayer(contentsOf: soundURL, fileTypeHint: AVFileType.mp3.rawValue)
                    
                    // For iOS versions < 11
                    //player = try AVAudioPlayer(contentsOf: soundURL, fileTypeHint: AVFileTypeMPEGLayer3.rawValue)
                    
                    
                    if let thePlayer = player {
                        thePlayer.prepareToPlay()
                        thePlayer.play()
                        reproduciendo = true
                        self.player?.setVolume(1.0, fadeDuration: 0.0)
                        print("Reproduciendo:", audioSinExtension, ".mp3")
                        
                    }else{
                        print("No se puede establecer el reproducor")
                    }
                }
                catch {
                    print(error)
                }
            }
        }else{
            self.player?.stop()
            reproduciendo = false
            print("Parando el reproductor")
        }
    }

}

extension InterestsViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Hay", interests.count)
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !reproduciendo{
            playSound(audioSinExtension: interests[indexPath.item].archivo)
            reproduciendo = true
        }
        else{
            reproduciendo = false
            self.player?.stop()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaVeneno", for: indexPath) as! InterestCollectionViewCell
        
        cell.interest = interests[indexPath.item]
        
        
        
        return cell
    }
}

extension InterestsViewController : UIScrollViewDelegate, UICollectionViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}



extension UIImage {
    
    public class func gifImageWithData(data: NSData) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source: source)
    }
    
    public class func gifImageWithURL(gifUrl:String) -> UIImage? {
        guard let bundleURL = NSURL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL as URL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a!
            a = b!
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b!
                b = rest
            }
        }
    }
    
    class func gcdForArray(array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(a: val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(index: Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(array: delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
}

// Extensiones de otras clases (UIImage)

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

class AssetExtractor {
    
    static func createLocalUrl(forImageNamed name: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).mp3")
        print("Url generada en funcion", url)
        return url
    }
    
}


