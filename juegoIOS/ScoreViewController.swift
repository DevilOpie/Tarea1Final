import UIKit
import Foundation
import Supabase
var globalPartidas: [partida] = [] // Array global para almacenar los objetos partida
var punt: Int = 0
struct Gatito: Encodable {
    let name: String
    let score: Int
}
public class ScoreViewController: UIViewController {
    var username: String = ""
    let supaClient = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6aHBwYWlubmhjeWJhcnhiYnFqIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk1NDQxOTEsImV4cCI6MjAxNTEyMDE5MX0.IGHoF3Bmkq1iqdNb3lYL3HEljWYTkqHk4BS7y3QgYhU"
    let supaUrl = "https://ezhppainnhcybarxbbqj.supabase.co/"
    var supabase: SupabaseClient
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        supabase = SupabaseClient(supabaseURL: URL(string: supaUrl)!, supabaseKey: supaClient)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        let supaClient = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6aHBwYWlubmhjeWJhcnhiYnFqIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk1NDQxOTEsImV4cCI6MjAxNTEyMDE5MX0.IGHoF3Bmkq1iqdNb3lYL3HEljWYTkqHk4BS7y3QgYhU"
        let supaUrl = "https://ezhppainnhcybarxbbqj.supabase.co/"
        supabase = SupabaseClient(supabaseURL: URL(string: supaUrl)!, supabaseKey: supaClient)
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        txtLabel.text = "Tu puntuación es: " + String(punt)
        print(punt)
    }
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var txtLabel: UILabel!
    @IBAction func saveButton(_ sender: Any) {
        Task {
            if let user = txtField.text, !user.isEmpty {
                // Crear una instancia de Score
                let newGatito = Gatito(name: user, score: punt)
                print(newGatito)
                do {
                    _ = try await supabase.database
                        .from("user")
                        .insert(values: [newGatito])
                        .execute()
                } catch {
                    print("Error al insertar la fila en la base de datos: \(error)")
                }
                performSegue(withIdentifier: "toRankingView", sender: nil)
            }
        }
    }


}
