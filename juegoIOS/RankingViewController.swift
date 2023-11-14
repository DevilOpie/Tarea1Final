import UIKit
import Supabase

struct User: Codable {
    let id: Int
    let name: String
    let score: Int
}

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let supaClient = "YOUR_SUPABASE_API_KEY"
    let supaUrl = "YOUR_SUPABASE_URL"
    var supabase: SupabaseClient
    var users: [User] = []

    @IBOutlet weak var table: UITableView!

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        supabase = SupabaseClient(supabaseURL: URL(string: supaUrl)!, supabaseKey: supaClient)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        supabase = SupabaseClient(supabaseURL: URL(string: supaUrl)!, supabaseKey: supaClient)
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    func Task() async {
           await numberOfRows()
       }

    func numberOfRows() async {
        do {
            let response = try await supabase.database
                .from("users")
                .select()
                .order(column: .desc(column: "score")) // Ordenar por "score" de mayor a menor
                .execute()

            if let data = response.data as? [User] {
                users = data  // Almacena las filas en el arreglo "users"
                // Actualiza el número de filas
                table.reloadData()
            } else {
                print("No se pudieron obtener los registros de la tabla 'users'.")
            }
        } catch {
            print("Error al obtener los registros de la tabla 'users': \(error)")
        }
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Accede a los datos de la fila correspondiente
        let user = users[indexPath.row]
        
        // Configura la celda con los datos del usuario
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "Score: \(user.score)"
        
        return cell
    }
}

