import Foundation


@MainActor
class SideBarViewModel: ObservableObject {
    
    @Published
    var flavors: [Flavor] = []
    var filters: [Int] = []
    
    init () {
        if(flavors.isEmpty) {
            updateFlavors()        }
    }
    
    
    func onFilterChange(flavor: Flavor) {

        switch flavor.flavorState {
            case .notMarked:
                let flavorIndex = filters.firstIndex { id in
                    id == flavor.id
                }
                guard let i = flavorIndex else {return}
                filters.remove(at: i)
            case .marked:
            filters.append(flavor.id)
        }
    }
    
             
    @MainActor
    private func updateFlavors() {
        NetworkService.shared.request("flavors.json", type: [Flavor].self) { result in
            switch result {
                case .success(let flavorsFromJson):
                    DispatchQueue.main.async {
                        self.flavors = flavorsFromJson
                    }
                case .failure(let error):
                    print("Error\(error)")
                }
        }
    }
                    
    func onFlavorButtonTapped(flavor: Flavor) {
                        
        let flavorIndex = flavors.firstIndex { flavorInArray in
            flavorInArray.id == flavor.id
        }
        guard let index = flavorIndex else { return }
        switch flavor.flavorState {
            case .notMarked: flavors[index].flavorState = .marked
            case .marked: flavors[index].flavorState = .notMarked
        }
        
        onFilterChange(flavor: flavors[index])
   }

}
