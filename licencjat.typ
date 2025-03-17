#set par(
  justify: true,
  leading: 0.52em,
)

#let title = [
  Modelowanie procesów ewolucyjnych za pomocą automatów komórkowych
]

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
)

#align(center, text(16pt)[
  *#title*
])

#align(center, text(14pt)[
  Gabriel Kaszewski
])

#set heading(numbering: "1.")

= Streszczenie
Chciałem napisać symulację ewolucji populacji organizmów w środowisku; symulację zainspirowanymi
automatami komórkowymi poprzez prostotę zasad, które prowadzą do złożonych zachowań. W pracy
wykorzystałem język *Rust* z biblioteką *Bevy* do napisania symulacji oraz *Python* z pakietem
bibliotek do analizy danych do wizualizacji wyników. Wynikiem pracy jest program, który symuluje
ewolucję organizmów, użytkownik może wprowadzić różne parametry, które wpływają na zachowanie ewolucji i obserwować jak zmieniają się populacje organizmów w zależności od tych parametrów.

= Wprowadzenie
Celem pracy jest zbadanie możliwości modelowania procesów ewolucyjnych przy wykorzystaniu automatów komórkowych i *Entity Component System*, który w dalszej części pracy będzie przedstawiany jako *ECS*. Praca ma na celu nie tylko pogłębienie teorytycznych podstaw modelowania ewolucji przy użyciu dyskretnych metod obliczeniowych, ale także popularyzację nowoczesnych technik programistycznych.

Symulację napisałem w języku Rust z wykorzystaniem biblioteki *Bevy*, która jest oparta na *ECS* i dostarcza wszystkie potrzebne komponenty do stworzenia projektu multimedialnego. Do wizualizacji danych użyłem języka *Python* z całym pakietem bibliotek do analizy danych takich jak *NumPy*, *Matplotlib*, *Pandas*.
= Entity Component System
== Wstęp
*ECS* to współczesna architektura oprogramowania stosowana głównie w grach komputerowych oraz symulacjach. Umożliwia ona elastyczne i wydajne zarządzanie złożonymi systemami. Główną ideą *ECS* jest oddzielenie danych (komponentów) od logiki (systemów) oraz traktowanie encji jako jedynie identyfikatorów, co pozwala na łatwiejsze skalowanie, modyfikację oraz optymalizację (np. w kontekście wielowątkowości). W tym rozdziale postaram się przybliżyć podstawowe pojęcia związane z *ECS* jego strukturę oraz zalety.
== Encje
*Encje* (ang. _entities_) stanowią podstawowy element *ECS*. Są one reprezentowane najczęściej jako unikalne identyfikatory (np. liczby całkowite) i same w sobie nie zawierają żadnych danych, ani elementów logicznych. Encje są "nosicielami" komponentów, które definiują ich właściwości. Dzięki temu, encje zajmują mało miejsca w pamięci, a zarządzanie nimi - np. tworzenie, usuwanie czy modyfikacja - odbywa się w sposób efektywny, ponieważ nie wymaga to przeszukiwania złożonych struktur danych.
== Komponenty
*Komponenty* (ang. _components_) to struktury danych, które zawierają właściwości lub stany encji. Każdy komponent jest dedykowany określonej właściwości obiektu, np. pozycji, prędkości czy "zdrowiu". W *ECS* komponenty nie zawierają żadnej logiki, są one jedynie kontenerami na dane. Z racji tego, że ich główną rolą jest przechowywanie informacji, są one zazwyczaj proste i niezależne od siebie. Co więcej, komponenty powinny być rozdzielane na mniejsze, wyspecjalizowane jednostki. Dzięki temu systemy mogą operować na dokładnie tych danych, które są im potrzebne, co sprzyja modularności i łatwości wprowadzaniu zmian, a przez to wydajności.
== Systemy
*Systemy* (ang. _systems_) to moduły odpowiedzialne za logikę działania symulacji albo gry. Operują one na zbiorach encji, które posiadają określone komponenty. Przykładowo, system odpowiedzialny za ruch będzie aktualizował pozycje encji, które posiadają komponent _Pozycja_ oraz _Prędkość_. Systemy wykonują swoje operacje cyklicznie (np. w każdej klatce gry) i mogą być projektowane tak, aby działały niezależnie od siebie.
== Świat
*Świat* w kontekście *ECS* to kontener, który przechowuje wszystkie encje, komponenty i systemy danego projektu. Stanowi centralny punkt, za pomocą którego systemy mogą uzyskać dostęp do danych i komunikować się między sobą. 
== Zalety Entity Component System
Architektura *ECS* posiada szereg korzyści:
- *Modularność*: Oddzielenie danych od logiki umożliwia łatwe modyfikowanie i rozszerzanie funkcjonalności bez wpływu na całą strukturę aplikacji.
- *Wydajność*: Komponenty są przechowywane w pamięci w sposób ciągły, co sprzyja lokalności danych i pozwala na efektywne operacje na nich, ponieważ procesor o wiele szybciej uzyska dostęp do danych, które znajdują się w tzw. _cache'u_ niż z pamięci RAM.
- *Elastyczność*: Można łatwo dodawać lub usuwać funkcjonalności przez modyfikację lub dodanie nowych komponentów i systemów.
- *Skalowalność*:  *ECS* doskonale nadaje się do obsługi dużej liczby encji, co jest szczególnie ważne w symulacjach oraz grach z wieloma interaktywnymi obiektami.
- *Łatwość debugowania i testowania*: Dzięki modułowej budowie, testowanie i debugowanie poszczególnych komponentów i systemów jest znacznie prostsze.
== Wielowątkowość w Entity Component System
Jednym z kluczowych atutów *ECS* jest możliwość łatwego wykorzystania wielowątkowości. Dzięki wyraźnemu oddzieleniu systemów, które operują na niepowiązanych zestawach komponentów, można równolegle przetwarzać dane w różnych wątkach. To podejście nie tylko zwiększa wydajność symulacji, ale także pozwala na lepsze wykorzystanie współczesnych procesorów wielordzeniowych. W praktyce oznacza to, że systemy nie muszą blokować siebie nawzajem, co znacznie poprawia skalowalność i responsywność aplikacji.
== Podsumowanie
*ECS* to nowoczesne podejście do projektowania systemów, które wyróżnia się modularnością, wydajnością i elastycznością.
Dzięki oddzieleniu encji, komponentów i systemów możliwe jest tworzenie skomplikowanych symulacji
oraz gier w sposób przejrzysty i łatwy do skalowania. Dodatkową zaletą jest możliwość równoległego
przetwarzania, co jest kluczowe w aplikacjach wymagających wysokiej wydajności.
*ECS* stanowi doskonałą bazę do implementacji symulatorów oraz innych systemów, w których liczy
się szybkie przetwarzanie dużej liczby obiektów, co czyni go idealnym narzędziem w kontekście
bioinformatyki i modelowania ewolucyjnego.
= Automaty komórkowe
== Wstęp
*Automaty komórkowe* (ang. _cellular automata_) to dyskretne modele obliczeniowe, w których przestrzeń 
symulacji dzielona jest na regularną siatkę komórek. Każda komórka może znajdować się w jednym, ze stanów,
które należa do zbioru dyskretnego i ograniczonego, a jej ewolucja odbywa się według ustalonych reguł,
zależnych od stanów sąsiadujących komórek. Metoda ta umożliwia badanie złożonych układów i procesów
dynamicznych przy wykorzystaniu prostych reguł lokalnych, co czyni automaty komórkowe atrakcyjnym narzędziem
w symulacjach biologicznych, fizycznych oraz społecznych.

Pierwsze idee dotyącze automatów komórkowych pojawiły się już w latach 40. XX wieku,
gdy John von Neumann i Stanisław Ulam badali samoreplikujące się układy. Jednak prawdziwy rozwój tej
dziedziny nastąpił w kolejnych dekadach, kiedy to naukowcy zaczęli systematycznie wykorzystywać te modele
do badania dynamiki złożonych układów. Jednym z przełomowych momentów była publikacja _gry w życie_
(ang. _Game of Life_) autorstwa Johna Conwaya w 1970 roku, która stała się symbolem możliwości generowania
złożonych struktur przy użyciu bardzo prostych zasad @gardner_mathematical_1970. W latach 80. i 90.
automaty komórkowe znalazły szerokie zastosowanie w badaniach nad zjawiskami
samoorganizacji oraz samoorganizującej się krytyczności (ang. _Self-Organized Criticality_) @PhysRevLett.59.381, czyli
zdolności układów dynamicznych do spontanicznego przechodzenia w stan krytyczny. Stały się również inspiracją
dla badań nad sztucznym życiem, modelując emergentne zachowania przypominające procesy biologiczne @PhysRevLett.68.1244.

== Definicja
Automat komórkowy definiuje się jako system składający się z trzech podstawowych elementów:
- *Siatka komórek*: Przestrzeń, w której każda komórka ma określoną pozycję (np. w układzie regularnym, takim jak kwadratowa lub heksagonalna siatka).
- *Zbiór stanów*: Dyskretny zbiór wartości, które mogą przyjmować poszczególne komórki (np. 0 lub 1, kolor, liczba, itp.).
- *Reguły przejścia*: Zbiór zasad, według których stan każdej komórki jest aktualizowany w kolejnych krokach czasowych, zależnie od stanów sąsiadów. Aktualizacja zwykle odbywa się synchronicznie dla wszystkich komórek.

Takie podejście umożliwia analizę, jak proste reguł lokalne mogą prowadzić do powstawania skomplikowanych, globalnych wzorców i struktur. @Ilachinski
== Przykłady
Najbardziej znanym przykładem automatu komórkowego jest gra w życie Johna Conwaya @gardner_mathematical_1970, w której proste zasady dotyczące narodzin, przetrwania i śmierci komórek prowadzą do złożonych, często nieprzewidywalnych zachowań. Inne przykłady obejmują:

- *Elementarne automaty komórkowe*: Badane przez Stephena Wolframa, gdzie komórki mają tylko dwa stany, a reguły są określone na podstawie stanu sąsiadów w jednym wymiarze. Przykłady takich reguł to reguła 30 czy reguła 110 @LANGTON1986120.
- *Automaty oparte o inne struktury siatek*: Automaty działające na siatkach heksagonalnych lub trójwymiarowych, które mogą lepiej modelować niektóre procesy naturalne.
- *Specjalistyczne modele*: Automaty komórkowe stosowane w modelowaniu wzrostu tkanek, rozprzestrzeniania się epidemii czy dynamiki ruchu tłumu. @PhysRevLett.71.4083, @Kauffman

Te przykłady pokazują, że automaty komórkowe są niezwykle wszechstronnym narzędziem, które znalazło zastosowanie zarówno w teorii, jak i w praktycznych zastosowaniach.
= Mój model
Zainspirowany automatami komórkowymi postanowiłem zrobić symulację ewolucji populacji organizmów.

Plansza, bądź świat w którym odbywa się symulacja jest dwuwymiarową siatką, gdzie każdy kafelek może być jednym z czterech rodzajów: woda, las, pustynia i trawa. Każdy typ terenu ma swoje własne właściwości jak np. *dostępność pożywienia*, *prędkość odnowy pożywienia*, jak szybko i chętnie organizmy poruszają się po nim.

W mojej symulacji mam dwa rodzaje organizmów: bierne i drapieżniki. Bierne organizmy dostają energię z jedzenia, które jest na danym kafelku. Drapieżniki z kolei dostają energię z jedzenia biernych organizmów. Każdy organizm ma swoje własne cechy jak *energia*, *prędkość*, *rozmiar*, *próg rozmnażania*, *tolerancja terenu*, drapieżniki mają dodatkowo *wydajność polowania* i *próg głodu*.

Organizm i drapieżnik potrzebuje energii, by żyć. Jeśli zabraknie tego zasobu, jednostka ginie.
Natomiast, jeśli organizm przekroczy próg rozmnażania, to tworzy nową jednostkę. Co krok czasowy każda jednostka zużywa energię, co więcej im większa bądź szybsza jednostka, tym więcej energii zużywa. Drapieżniki polują na organizmy, gdy ich energia spadnie poniżej progu głodu. Celem drapieżnika jest najbliższy organizm. Każdy drapieżnik ma zasięg polowania, który wynosi jedną komórkę. Wydajność polowania wpływa na to ile energii drapieżnik dostanie z jedzenia.

W sytuacji, gdy na jednej komórce znajduje się więcej niż jeden organizm, to pożywienie dostaje w pierwszej kolejności organizm, który jest największy. Ilość uzyskanej energii z jedzenia również zależy od rodzaju terenu, na którym znajduje się organizm i jego przystosowania do tego terenu.
Natomiast jeśli na jednej komórce znajduje się więcej organizmów, bądź drapieżników niż ustawiony limit to nadwyżka ginie z powodu przeludnienia.

Podczas rozmnażania organizm dziedziczy cechy rodzica, ale również może wystąpić mutacja cech.
Mutacja polega na zmianie cechy o losowa wartość z przedziału, który zależy od mutacji. Dziecko zaczyna z połową energii rodzica. Takie same zachowanie rozmnażania i mutacji występuje u drapieżników.

== Implementacja
Kod źródłowy jest podzielony na dwie części: symulacja napisana w języku *Rust* z wykorzystaniem biblioteki *Bevy* oraz wizualizacja wyników w języku *Python* z wykorzystaniem bibliotek *Matplotlib*, *NumPy* i *Pandas*.

Zacznę od prezentacji kodu symulacji i jego objaśnienia.

== Symulacja

#show figure: set align(left)

#figure(```rust
use std::error::Error;
use std::fmt::Display;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::Write;

use bevy::prelude::*;
use bevy::utils::hashbrown::HashMap;
use noise::NoiseFn;
use noise::Perlin;
use rand::prelude::*;
use serde::Deserialize;
use serde::Serialize;
```, caption: "Importy",)

W listingu 1 przedstawione są importy, które są potrzebne do napisania symulacji. W symulacji wykorzystuję kilka bibliotek z biblioteki standardowej języka *Rust*, takich jak `std::error::Error` do obsługi błędów, `std::fs` do operacji na plikach, `std::io::Write` do zapisywania danych do pliku. Wykorzystuję również bibliotekę `bevy` do tworzenia gry, `noise` do generowania szumu, który później wykorzystuję do stworzenia planszy, która w miarę przypomina rzeczywisty świat, `rand` do generowania liczb losowych oraz `serde` do serializacji i deserializacji danych, które później wykorzystuję do wizualizacji wyników w języku *Python*.


#figure(```rust
#[derive(Deserialize, Debug, Serialize, Clone)]
struct BiomeDataConfig {
    food_availabilty: f32,
    max_food_availabilty: f32,
}

#[derive(Deserialize, Debug, Resource, Serialize, Clone)]
pub struct Config {
    width: usize,
    height: usize,
    initial_organisms: usize,
    initial_predators: usize,
    headless: bool,
    log_data: bool,
    forest: BiomeDataConfig,
    desert: BiomeDataConfig,
    water: BiomeDataConfig,
    grassland: BiomeDataConfig,
    initial_organism_energy: f32,
    initial_predator_energy: f32,
    initial_organism_speed: f32,
    initial_predator_speed: f32,
    initial_organism_size: f32,
    initial_predator_size: f32,
    initial_organism_reproduction_threshold: f32,
    initial_predator_reproduction_threshold: f32,
    initial_predator_hunting_efficiency: f32,
    initial_predator_satiation_threshold: f32,
    organism_mutability: f32,
    predator_mutability: f32,
    overcrowding_threshold_for_organisms: usize,
    overcrowding_threshold_for_predators: usize,
    max_total_entities: usize,
    seed: u64,
}
```, caption: "Struktury konfiguracyjne")

W listingu 2 przedstawione są struktury konfiguracyjne, które są wykorzystywane do konfiguracji symulacji. Struktura `BiomeDataConfig` przechowuje informacje o dostępności pożywienia na danym terenie oraz maksymalnej dostępności pożywienia. Struktura `Config` przechowuje informacje o szerokości i wysokości planszy, liczbie początkowych organizmów i drapieżników, czy symulacja ma być uruchomiona w trybie bez okna, czy dane mają być zapisywane do pliku, a także parametry początkowe dla organizmów i drapieżników, takie jak _energia_, _prędkość_, _rozmiar_, _próg rozmnażania_, _wydajność polowania_, _próg głodu_, _mutowalność cech_, _próg przeludnienia_ oraz _ziarno generatora liczb losowych_. Struktura ta jest serializowana i deserializowana za pomocą biblioteki `serde` oraz jest dostępna jako zasób w *Bevy*, co powoduje, że jest dostępna dla każdego systemu.

Ziarno jest potrzebne, by symulacja była deterministyczna, a dane były zawsze takie same, co jest ważne przy testowaniu i reprodukowaniu wyników. Plik konfiguracyjny jest w formacie *TOML* i wygląda następująco:
```toml
width = 100
height = 100
initial_organisms = 5
initial_predators = 2
headless = false
log_data = true
initial_organism_energy = 3.0
initial_predator_energy = 15.0
initial_organism_speed = 1.0
initial_predator_speed = 1.5
initial_organism_size = 1.2
initial_predator_size = 1.0
initial_organism_reproduction_threshold = 5.0
initial_predator_reproduction_threshold = 16.0
initial_predator_hunting_efficiency = 1.5
initial_predator_satiation_threshold = 14.0
organism_mutability = 0.1
predator_mutability = 0.05
overcrowding_threshold_for_organisms = 25
overcrowding_threshold_for_predators = 10
seed = 420692137
max_total_entities = 10000

[forest]
food_availabilty = 0.2
max_food_availabilty = 2600.0
temperature = 20.0
humidity = 0.6

[desert]
food_availabilty = 0.01
max_food_availabilty = 300.0
temperature = 35.0
humidity = 0.1

[water]
food_availabilty = 0.0
max_food_availabilty = 0.0
temperature = 15.0
humidity = 0.9

[grassland]
food_availabilty = 0.1
max_food_availabilty = 1500.0
temperature = 25.0
humidity = 0.4
```
Dzięki temu, że symulacja wczytuje plik konfiguracyjny, można łatwo zmieniać parametry symulacji bez konieczności zmiany kodu źródłowego i ponownej kompilacji programu.

#figure(```rust
#[derive(Debug, Clone, PartialEq, Eq, Hash, Serialize, Copy)]
pub enum Biome {
    Forest,
    Desert,
    Water,
    Grassland,
}

#[derive(Debug, Clone, Serialize)]
pub struct Tile {
    pub biome: Biome,
    pub temperature: f32,
    pub humidity: f32,
    pub food_availabilty: f32,
}


#[derive(Debug, Resource, Serialize, Clone)]
pub struct World {
    pub width: usize,
    pub height: usize,
    pub grid: Vec<Vec<Tile>>,
}
```, caption: "Struktury reprezentujące świat")

W listingu 3 przedstawione są struktury reprezentujące świat, w którym odbywa się symulacja. Enum `Biome` reprezentuje rodzaje terenów, które mogą występować na planszy, takie jak las, pustynia, woda, łąka. Struktura `Tile` reprezentuje pojedynczy kafelek na planszy i przechowuje informacje o rodzaju terenu, temperaturze, wilgotności oraz dostępności pożywienia. Struktura `World` przechowuje informacje o szerokości i wysokości planszy oraz dwuwymiarową tablicę kafelków. `World` jest zasobem w *Bevy*, co oznacza, że jest dostępny dla wszystkich systemów, podobnie jak `Config`.

#figure(```rust
impl Display for Biome {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Biome::Forest => write!(f, "Forest"),
            Biome::Desert => write!(f, "Desert"),
            Biome::Water => write!(f, "Water"),
            Biome::Grassland => write!(f, "Grassland"),
        }
    }
}


impl Tile {
    pub fn regenerate_food(&mut self, config: &Config) {
        match self.biome {
            Biome::Forest => {
                if self.food_availabilty > config.forest.max_food_availabilty {
                    return;
                }

                self.food_availabilty += config.forest.food_availabilty;
            }
            Biome::Desert => {
                if self.food_availabilty > config.desert.max_food_availabilty {
                    return;
                }

                self.food_availabilty += config.desert.food_availabilty;
            }
            Biome::Grassland => {
                if self.food_availabilty > config.grassland.max_food_availabilty {
                    return;
                }

                self.food_availabilty += config.grassland.food_availabilty;
            }
            _ => {}
        }
    }
}
```, caption: "Implementacje metod dla struktur Biome i Tile")

#figure(```rust
impl World {
    pub fn new(width: usize, height: usize, random_seed: u64) -> Self {
        let mut rng = StdRng::seed_from_u64(random_seed);
        let seed = rng.gen::<u32>();

        let perlin = Perlin::new(seed);
        let scale = 10.0;

        let mut grid = vec![vec![]; height];
        for y in 0..height {
            for x in 0..width {
                let noise_value = perlin.get([x as f64 / scale, y as f64 / scale]);

                let biome = if noise_value < -0.3 {
                    Biome::Water
                } else if noise_value < -0.1 {
                    Biome::Desert
                } else if noise_value < 0.5 {
                    Biome::Grassland
                } else {
                    Biome::Forest
                };

                grid[y].push(Tile {
                    biome,
                    temperature: 20.0,
                    humidity: 0.5,
                    food_availabilty: rng.gen_range(1.0..100.0),
                });
            }
        }

        Self {
            width,
            height,
            grid,
        }
    }
}

impl Default for World {
    fn default() -> Self {
        Self::new(10, 10, 0)
    }
}
```, caption: "Implementacje metod dla struktury World")

W listingach 4 i 5 przedstawione są implementacje metod dla struktur `Biome` i `Tile` oraz `World`. Metoda `Display` dla `Biome` pozwala na wyświetlenie nazwy terenu w bardziej przyjazny dla użytkownika sposób. Metoda `regenerate_food` dla `Tile` pozwala na odnowienie pożywienia na danym kafelku w zależności od rodzaju terenu. Jedzenie nie odnawia się w nieskończoność, jeśli zostanie osiągniety limit dla danego terenu, żywność nie jest dalej odnawiana. Dla wody nie odnawiam jedzenia, ponieważ w mojej implementacji założyłem, że woda nie jest terenem, na którym mogą żyć jednostki. Metoda `new` dla `World` tworzy nowy świat o podanej szerokości i wysokości, generując teren na podstawie szumu *Perlin'a* z wykorzystaniem ziarna generatora liczb losowych. Metoda `Default` dla `World` tworzy domyślny świat o szerokości 10 i wysokości 10 z ziarnem 0. Dzięki wykorzystaniu szumu *Perlin'a* teren jest bardziej naturalny i przypomina rzeczywisty świat, a jaki rodzaj terenu występuje na danym kafelku zależy od wartości szumu.
Dla wartości szumu mniejszych niż -0.3 teren jest wodny, dla wartości mniejszych niż -0.1 pustynny, dla wartości mniejszych niż 0.5 łąkowy, a dla pozostałych las. Dla każdego kafelka generuję również temperaturę, wilgotność oraz dostępność pożywienia, która jest losowa.

#figure(```rust
#[derive(Component, Serialize, Clone)]
pub struct Organism {
    pub energy: f32,
    pub speed: f32,
    pub size: f32,
    pub reproduction_threshold: f32,
    pub biome_tolerance: HashMap<Biome, f32>,
}

#[derive(Component, Serialize, Copy, Clone)]
pub struct Predator {
    pub energy: f32,
    pub speed: f32,
    pub size: f32,
    pub reproduction_threshold: f32,
    pub hunting_efficiency: f32,
    pub satiation_threshold: f32,
}

#[derive(Component, Debug, Serialize, Copy, Clone)]
pub struct Position {
    pub x: usize,
    pub y: usize,
}

#[derive(Component)]
pub struct TileComponent {
    pub biome: Biome,
}

```, caption: "Komponenty w symulacji")

W listingu 6 przedstawione są struktury reprezentujące jednostki. Struktura `Organism` reprezentuje organizm i przechowuje informacje o energii, prędkości, rozmiarze, progu rozmnażania oraz tolerancji terenu. Tolerancja terenu jest mapą, która przechowuje informacje o tolerancji organizmu na dany teren. Struktura `Predator` reprezentuje drapieżnika i przechowuje informacje o energii, prędkości, rozmiarze, progu rozmnażania, wydajności polowania oraz progu głodu. Struktura `Position` przechowuje informacje o pozycji jednostki na planszy. Struktura `TileComponent` przechowuje informacje o rodzaju terenu na danym kafelku. Ten komponent jest wykorzystywany do wyświetlania odpowiedniego koloru kafelka w zależności od rodzaju terenu na planszy. Wszystkie te struktury są *komponentami* w *ECS* i są dostępne dla systemów.

#figure(```rust
#[derive(Default, Resource, Serialize)]
pub struct Generation(pub usize);

const TILE_SIZE_IN_PIXELS: f32 = 32.0;
```, caption: "Zasób przechowujący informacje o generacji oraz stała przechowująca rozmiar kafelka w pikselach")

W powyższym listingu przedstawiony jest zasób `Generation`, który przechowuje informacje o aktualnym pokoleniu w symulacji oraz stała `TILE_SIZE_IN_PIXELS`, która przechowuje rozmiar kafelka w pikselach.

#figure(```rust
fn main() {
    let config = get_config();

    println!("{:?}", config);

    let headless = config.headless;
    let mut app = App::new();

    match headless {
        true => {
            app.add_plugins(MinimalPlugins);
        }
        false => {
            app.add_plugins(DefaultPlugins);
        }
    }

    app.insert_resource(World::new(config.width, config.height, config.seed))
        .insert_resource(config)
        .insert_resource(Generation(0))
        .add_systems(
            Startup,
            (
                spawn_world,
                spawn_organisms,
                spawn_predators,
                initialize_log_file,
            ),
        )
        .add_systems(Update, hunting)
        .add_systems(
            Update,
            (
                render_organisms,
                render_predators,
                organism_movement,
                predator_movement,
                organism_sync,
                predator_sync,
                despawn_dead_organisms,
                despawn_dead_predators,
                regenerate_food,
                consume_food,
                overcrowding,
                biome_adaptation,
                reproduction,
                predator_reproduction,
                increment_generation,
                log_organism_data,
                log_world_data,
                handle_camera_movement,
            )
                .after(hunting),
        )
        .run();
}
```, caption: "Główna funkcja programu")

W listingu 8 przedstawiona jest główna funkcja programu, od której zaczyna się wykonywanie kodu. Na samym początku wczytywany jest plik konfiguracyjny i wypisywana jest jego treść do punktu wyjścia. Następnie pobieram z ustawień konfiguracyjnych flagę, która odpowiada za to czy symulacja powinna być uruchomiona w trybie bezokienkowym czy okienkowym. Tworzę zmienną `app`, która przechowuje aplikację *Bevy*. W zależności od wartości flagi dodaję odpowiednie wtyczki. Wtyczka `MinimalPlugins` dodaje minimalny zestaw wtyczek, który jest potrzebny do uruchomienia symulacji w trybie bezokienkowym, a wtyczka `DefaultPlugins` dodaje domyślny zestaw wtyczek, który jest potrzebny do uruchomienia symulacji w trybie okienkowym. Następnie wstawiam zasób `World` z nowym światem, któremu przekazuję ustawienia z pliku konfiguracyjnego, zasób `Config` z ustawieniami konfiguracyjnymi, zasób `Generation` z aktualnym pokoleniem oraz dodaję systemy, które mają zostać wykonane w trakcie działania symulacji. Są dwie kategorie systemów `Startup` i `Update`, systemy należące do grupy `Startup` zostaną odpalone tylko raz na początku symulacji, a systemy z grupy `Update` będą wykonywane w każdej klatce gry. Systemy z grupy `Startup` odpowiadają za inicjalizację symulacji oraz potrzebnych plików do zapisywania danych. Systemy z grupy `Update` odpowiadają za aktualizację stanu symulacji, ruch jednostek, polowanie, rozmnażanie, zapisywanie danych, obsługę kamery oraz usuwanie martwych jednostek. Na końcu uruchamiam symulację za pomocą metody `run`. Systemy są wykonywane równolegle, co pozwala na zwiększenie wydajności symulacji. Poza systemem `hunting`, który jest wykonywany przed systemami: `render_organisms`, `render_predators`, `organism_movement`, `predator_movement`, `organism_sync`, `predator_sync`, `despawn_dead_organisms`, `despawn_dead_predators`, `regenerate_food`, `consume_food`, `overcrowding`, `biome_adaptation`, `reproduction`, `predator_reproduction`, `increment_generation`, `log_organism_data`, `log_world_data`, `handle_camera_movement`. Jest to spowodowane tym, że gdy organizm zostanie zjedzony, to musi zniknąć z planszy, przez co czasami gdy system odpowiedzialny za polowanie się wykonywał to próbował zjeść organizm, który już nie istniał i powodowało to błąd krytyczny w programie. W ten sposób unikam tego problemu. Niestety powoduje to, że planer (ang. _scheduler_) musi wykonać więcej pracy i może to wpłynąć na wydajność symulacji.

#figure(```rust
fn spawn_world(
    mut commands: Commands,
    world: Res<World>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    let tile_size = Vec2::new(TILE_SIZE_IN_PIXELS, TILE_SIZE_IN_PIXELS);

    let shape = meshes.add(Rectangle::new(tile_size.x, tile_size.y));

    for (y, row) in world.grid.iter().enumerate() {
        for (x, tile) in row.iter().enumerate() {
            let color = match tile.biome {
                Biome::Forest => Color::hsl(120.0, 1.0, 0.1),
                Biome::Desert => Color::hsl(60.0, 1.0, 0.5),
                Biome::Water => Color::hsl(240.0, 1.0, 0.5),
                Biome::Grassland => Color::hsl(100.0, 1.0, 0.7),
            };

            commands
                .spawn((Mesh2d(shape.clone()), MeshMaterial2d(materials.add(color))))
                .insert(TileComponent {
                    biome: tile.biome.clone(),
                })
                .insert(Transform {
                    translation: Vec3::new(x as f32 * tile_size.x, y as f32 * tile_size.y, 0.0),
                    ..Default::default()
                });
        }
    }

    let center_x = world.width as f32 * TILE_SIZE_IN_PIXELS / 2.0;
    let center_y = world.height as f32 * TILE_SIZE_IN_PIXELS / 2.0;

    commands.spawn((
        Camera2d::default(),
        Transform::from_xyz(center_x, center_y, 10.0),
    ));
}
```, caption: "System tworzący świat")

W listingu 9 przedstawiony jest system `spawn_world`, który odpowiada za stworzenie świata na podstawie danych z zasobu `World`. Dla każdego kafelka na planszy tworzony jest odpowiedni kolor w zależności od rodzaju terenu. Następnie tworzony jest kafelek na planszy z odpowiednim kolorem i pozycją. Na końcu tworzona jest kamera, która śledzi planszę. Kamera znajduje się w środku planszy i ma wysokość 10.0 jednostek.

#figure(```rust
fn spawn_organisms(mut commands: Commands, world: Res<World>, config: Res<Config>) {
    let mut rng = StdRng::seed_from_u64(config.seed);
    let organism_count = config.initial_organisms;

    for _ in 0..organism_count {
        let x = rng.gen_range(0..world.width);
        let y = rng.gen_range(0..world.height);

        let tile_biome = &world.grid[y][x].biome;

        let biome_tolerance = get_biome_tolerance(tile_biome, config.seed);

        commands.spawn((
            Organism {
                energy: config.initial_organism_energy,
                speed: config.initial_organism_speed,
                size: config.initial_organism_size,
                reproduction_threshold: config.initial_organism_reproduction_threshold,
                biome_tolerance,
            },
            Position { x, y },
        ));
    }
}
```, caption: "System tworzący organizmy")

#figure(```rust
fn get_biome_tolerance(tile_biome: &Biome, seed: u64) -> HashMap<Biome, f32> {
    let mut biome_tolerance = HashMap::new();
    let mut rng = StdRng::seed_from_u64(seed);

    for biome in &[Biome::Forest, Biome::Desert, Biome::Water, Biome::Grassland] {
        let tolerance = if *biome == *tile_biome {
            rng.gen_range(1.0..1.5)
        } else {
            rng.gen_range(0.1..0.8)
        };

        biome_tolerance.insert(biome.clone(), tolerance);
    }

    biome_tolerance
}
```, caption: "Funkcja generująca tolerancję terenu dla organizmu")

Listing 10 przedstawia system `spawn_organisms`, który odpowiada za stworzenie organizmów na planszy. Dla każdego organizmu losowana jest pozycja na planszy. Następnie dla każdego organizmu tworzona jest tolerancja terenu na podstawie rodzaju terenu, na którym znajduje się organizm. Tolerancja terenu jest mapą, która przechowuje informacje o tolerancji organizmu na dany teren. Im bliżej tolerancji terenu do 1.0, tym organizm lepiej przystosowany jest do danego terenu. Im bliżej tolerancji terenu do 0.0, tym organizm gorzej przystosowany jest do danego terenu. Tolerancja terenu jest losowana z przedziału [0.1, 0.8] dla terenów, na których organizm nie znajduje się oraz z przedziału [1.0, 1.5] dla terenu, na którym organizm znajduje się. W ten sposób organizmy są bardziej przystosowane do terenu, na którym się znajdują.

#figure(```rust
fn spawn_predators(mut commands: Commands, world: Res<World>, config: Res<Config>) {
    let mut rng = StdRng::seed_from_u64(config.seed);
    let predator_count = config.initial_predators;

    for _ in 0..predator_count {
        let x = rng.gen_range(0..world.width);
        let y = rng.gen_range(0..world.height);

        commands.spawn((
            Predator {
                energy: config.initial_predator_energy,
                speed: config.initial_predator_speed,
                size: config.initial_predator_size,
                reproduction_threshold: config.initial_predator_reproduction_threshold,
                hunting_efficiency: config.initial_predator_hunting_efficiency,
                satiation_threshold: config.initial_predator_satiation_threshold,
            },
            Position { x, y },
        ));
    }
}
```, caption: "System tworzący drapieżniki")

Listing 12 przedstawia system `spawn_predators`, który odpowiada za stworzenie drapieżników na planszy. Dla każdego drapieżnika losowana jest pozycja na planszy. Następnie dodaję drapieżnika na planszę z odpowiednimi parametrami początkowymi.

#figure(```rust
fn render_organisms(
    mut commands: Commands,
    query: Query<(Entity, &Position), (Without<Predator>, Without<Mesh2d>)>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    let tile_size = Vec2::new(TILE_SIZE_IN_PIXELS, TILE_SIZE_IN_PIXELS);
    let organism_size = Vec2::new(16.0, 16.0);

    let shape = meshes.add(Circle::new((organism_size.x) / 2.0));

    let color = Color::linear_rgb(0.0, 155.0, 12.0);

    for (entity, position) in query.iter() {
        commands.entity(entity).insert((
            Mesh2d(shape.clone()),
            MeshMaterial2d(materials.add(color)),
            Transform::from_xyz(
                position.x as f32 * tile_size.x,
                position.y as f32 * tile_size.y,
                1.0,
            ),
        ));
    }
}
```, caption: "System wyświetlający organizmy")

#figure(```rust

fn render_predators(
    mut commands: Commands,
    query: Query<(Entity, &Position), (Without<Organism>, Without<Mesh2d>)>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    let tile_size = Vec2::new(TILE_SIZE_IN_PIXELS, TILE_SIZE_IN_PIXELS);
    let organism_size = Vec2::new(16.0, 16.0);

    let color = Color::srgb(255.0, 0.0, 0.0);
    let shape = meshes.add(Rectangle::new(organism_size.x, organism_size.y));

    for (entity, position) in query.iter() {
        commands.entity(entity).insert((
            Mesh2d(shape.clone()),
            MeshMaterial2d(materials.add(color)),
            Transform::from_xyz(
                position.x as f32 * tile_size.x,
                position.y as f32 * tile_size.y,
                1.0,
            ),
        ));
    }
}
```, caption: "System wyświetlający drapieżniki")

Listingi 13 i 14 przedstawiają systemy `render_organisms` i `render_predators`, które odpowiadają za wyświetlenie organizmów i drapieżników na planszy. Dla każdego organizmu i drapieżnika tworzony jest odpowiedni kolor i kształt, a następnie tworzony jest odpowiedni obiekt na planszy z odpowiednim kolorem i pozycją. Organizmy są wyświetlane jako koła, a drapieżniki jako prostokąty. Organizmy są zielonkawe, a drapieżniki czerwone. W tych systemach argumenty funkcji są wyjątkowe dla ECS. `Query` jest strukturą, która przechowuje zbiór encji, które spełniają określone kryteria. W tym przypadku zwraca encje, które dla systemu `render_organisms` nie posiadają komponentu `Predator` oraz `Mesh2d`, a dla systemu `render_predators` nie posiadają komponentu `Organism` oraz `Mesh2d`. Natomiast posiadają komponent `Position`. Dzięki temu system dostaje tylko te encje, które zawierają tylko te dane, które są mu potrzebne do działania.

#show figure: set block(breakable: true)

#figure(```rust
fn organism_movement(
    mut query: Query<(&mut Position, &mut Organism)>,
    world: Res<World>,
    config: Res<Config>,
) {
    let directions: Vec<(isize, isize)> = vec![
        (-1, -1),
        (0, -1),
        (1, -1),
        (-1, 0),
        (1, 0),
        (-1, 1),
        (0, 1),
        (1, 1),
    ];

    let mut rng = StdRng::seed_from_u64(config.seed);

    for (mut position, mut organism) in query.iter_mut() {
        if organism.energy <= 0.0 {
            continue;
        }

        let mut best_direction = (0, 0);
        let mut best_cost = f32::MAX;

        for (dx, dy) in directions.iter() {
            let new_x = (position.x as isize + dx).clamp(0, (world.width - 1) as isize) as usize;
            let new_y = (position.y as isize + dy).clamp(0, (world.height - 1) as isize) as usize;
            let tile = &world.grid[new_y][new_x];

            let base_cost = match tile.biome {
                Biome::Water => 100.0,
                Biome::Desert => 50.0,
                Biome::Grassland => 10.0,
                Biome::Forest => 20.0,
            };

            let tolerance = organism.biome_tolerance.get(&tile.biome).unwrap_or(&1.0);
            let cost = base_cost / tolerance;

            let cost = cost + rng.gen_range(0.0..5.0);

            if cost < best_cost {
                best_cost = cost;
                best_direction = (*dx, *dy);
            }
        }

        position.x =
            (position.x as isize + best_direction.0).clamp(0, (world.width - 1) as isize) as usize;
        position.y =
            (position.y as isize + best_direction.1).clamp(0, (world.height - 1) as isize) as usize;

        let energy_to_consume = 0.1 * organism.speed * organism.size;

        organism.energy -= energy_to_consume;

        let tile = &world.grid[position.y][position.x];
        if tile.biome == Biome::Water {
            organism.energy = -1.0;
        }
    }
}
```, caption: "System odpowiedzialny za ruch organizmów")

W listingu 15 przedstawiony jest system `organism_movement`, który odpowiada za ruch organizmów na planszy. Dla każdego organizmu losowana jest nowa pozycja na planszy. Następnie dla każdego organizmu obliczam najlepszy kierunek ruchu na podstawie kosztu ruchu. Koszt ruchu zależy od rodzaju terenu, na którym znajduje się organizm oraz tolerancji terenu. Im większa tolerancja terenu, tym mniejszy koszt ruchu. Im mniejsza tolerancja terenu, tym większy koszt ruchu. Koszt ruchu jest losowany z przedziału [0.0, 5.0]. Następnie obliczam nową pozycję organizmu na planszy oraz obliczam zużytą energię na podstawie prędkości i rozmiaru organizmu. Jeśli organizm znajduje się na wodzie, to ustawiam jego energię na -1.0, co oznacza, że organizm umiera. W ten sposób organizmy są bardziej przystosowane do terenu, na którym się znajdują. Ruch jest dozwolony w 8 kierunkach: góra, dół, lewo, prawo oraz po skosach. Energia organizmu zmniejsza się w zależności od prędkości i rozmiaru organizmu. Im większa prędkość i rozmiar organizmu, tym więcej energii zużywa na ruch.

#figure(```rust
fn predator_movement(
    mut predator_query: Query<(&mut Position, &mut Predator)>,
    prey_query: Query<(&Position, &Organism), Without<Predator>>,
    world: Res<World>,
    config: Res<Config>,
) {
    let directions: Vec<(isize, isize)> = vec![
        (-1, -1),
        (0, -1),
        (1, -1),
        (-1, 0),
        (1, 0),
        (-1, 1),
        (0, 1),
        (1, 1),
    ];
    let mut rng = StdRng::seed_from_u64(config.seed);

    for (mut predator_position, mut predator) in predator_query.iter_mut() {
        if predator.energy <= 0.0 {
            continue;
        }

        let mut closest_prey: Option<&Position> = None;
        let mut min_distance = f32::MAX;
        let predator_range_attack = 1.0;

        for (prey_position, _) in prey_query.iter() {
            let dx = predator_position.x as f32 - prey_position.x as f32;
            let dy = predator_position.y as f32 - prey_position.y as f32;
            let distance = dx * dx + dy * dy;

            if distance < min_distance && distance <= predator_range_attack {
                min_distance = distance;
                closest_prey = Some(prey_position);
            }
        }

        if let Some(prey_position) = closest_prey {
            let dx = prey_position.x as isize - predator_position.x as isize;
            let dy = prey_position.y as isize - predator_position.y as isize;

            predator_position.x = (predator_position.x as isize + dx.signum())
                .clamp(0, (world.width - 1) as isize) as usize;
            predator_position.y = (predator_position.y as isize + dy.signum())
                .clamp(0, (world.height - 1) as isize) as usize;
        } else {
            let mut best_direction = (0, 0);
            let mut best_cost = f32::MAX;

            for (dx, dy) in directions.iter() {
                let new_x = (predator_position.x as isize + dx).clamp(0, (world.width - 1) as isize)
                    as usize;
                let new_y = (predator_position.y as isize + dy)
                    .clamp(0, (world.height - 1) as isize) as usize;

                let tile = &world.grid[new_y][new_x];

                let cost = match tile.biome {
                    Biome::Water => 100.0,
                    Biome::Desert => 10.0,
                    Biome::Grassland => 5.0,
                    Biome::Forest => 6.0,
                };

                let cost = cost + rng.gen_range(0.0..5.0);

                if cost < best_cost {
                    best_cost = cost;
                    best_direction = (*dx, *dy);
                }
            }

            predator_position.x = (predator_position.x as isize + best_direction.0)
                .clamp(0, (world.width - 1) as isize) as usize;
            predator_position.y = (predator_position.y as isize + best_direction.1)
                .clamp(0, (world.height - 1) as isize) as usize;
        }

        predator.energy -= 0.1 * predator.speed * predator.size;
    }
}
```, caption: "System odpowiedzialny za ruch drapieżników")
System `predator_movement` przedstawiony w listingu 16 odpowiada za ruch drapieżników na planszy. Dla każdego drapieżnika obliczam najbliższą ofiarę. Jeśli ofiara znajduje się w zasięgu ataku drapieżnika, to drapieżnik rusza w jej kierunku. Jeśli ofiara nie znajduje się w zasięgu ataku drapieżnika, to drapieżnik rusza w losowym kierunku. Ruch drapieżnika jest dozwolony w 8 kierunkach: góra, dół, lewo, prawo oraz po skosach. Energia drapieżnika zmniejsza się w zależności od prędkości i rozmiaru drapieżnika. Im większa prędkość i rozmiar drapieżnika, tym więcej energii zużywa na ruch. Jeśli drapieżnik znajdzie się na wodzie, to ustawiam jego energię na -1.0, co oznacza, że drapieżnik umiera. Dystans jest dystansem euklidesowym między drapieżnikiem a ofiarą.

W obu systemach `organism_movement` i `predator_movement` sprawdzam czy dana jednostka posiada dodatnią energię, by w ogóle mogła się ruszać.

#figure(```rust
fn despawn_dead_organisms(mut commands: Commands, query: Query<(Entity, &Organism)>) {
    for (entity, organism) in query.iter() {
        if organism.energy <= 0.0 {
            commands.entity(entity).despawn_recursive();
        }
    }
}

fn despawn_dead_predators(mut commands: Commands, query: Query<(Entity, &Predator)>) {
    for (entity, predator) in query.iter() {
        if predator.energy <= 0.0 {
            commands.entity(entity).despawn_recursive();
        }
    }
}
```, caption: "Systemy usuwające martwe jednostki")

W listingu 17 przedstawione są systemy `despawn_dead_organisms` i `despawn_dead_predators`, które odpowiadają za usuwanie martwych jednostek z planszy. Dla każdej jednostki sprawdzam czy jej energia jest mniejsza lub równa 0.0. Jeśli tak, to usuwam jednostkę z planszy. Warto zauważyć, że używam metody `despawn_recursive`, która usuwa jednostkę wraz z jej dziećmi. Dzięki temu, jeśli jednostka posiada jakieś dzieci, to również zostaną one usunięte z planszy.

#figure(```rust
fn organism_sync(mut query: Query<(&Position, &mut Transform, &Organism)>) {
    for (position, mut transform, organism) in query.iter_mut() {
        transform.translation.x = position.x as f32 * TILE_SIZE_IN_PIXELS;
        transform.translation.y = position.y as f32 * TILE_SIZE_IN_PIXELS;
        transform.scale = Vec3::new(organism.size, organism.size, 1.0);
    }
}

fn predator_sync(mut query: Query<(&Position, &mut Transform, &Predator)>) {
    for (position, mut transform, predator) in query.iter_mut() {
        transform.translation.x = position.x as f32 * TILE_SIZE_IN_PIXELS;
        transform.translation.y = position.y as f32 * TILE_SIZE_IN_PIXELS;
        transform.scale = Vec3::new(predator.size, predator.size, 1.0);
    }
}
```, caption: "Systemy synchronizujące pozycję jednostek")

W listingu 18 przedstawione są systemy `organism_sync` i `predator_sync`, które odpowiadają za synchronizację pozycji jednostek na planszy. Dla każdej jednostki ustawiam odpowiednią pozycję oraz skalę. Pozycja jednostki jest obliczana na podstawie pozycji jednostki na planszy, a skala jednostki jest obliczana na podstawie rozmiaru jednostki.

#figure(```rust
fn regenerate_food(mut world: ResMut<World>, config: Res<Config>) {
    for row in world.grid.iter_mut() {
        for tile in row.iter_mut() {
            tile.regenerate_food(&config);
        }
    }
}
```, caption: "System odnawiający pożywienie na planszy")

W listingu 19 przedstawiony jest system `regenerate_food`, który odpowiada za odnowienie pożywienia na planszy. Dla każdego kafelka na planszy odnawiam pożywienie na podstawie ustawień konfiguracyjnych. Pożywienie odnawia się w zależności od rodzaju terenu. Im bardziej żyzny teren, tym więcej pożywienia jest odnawiane.

#figure(```rust
fn consume_food(mut world: ResMut<World>, mut query: Query<(Entity, &mut Organism, &Position)>) {
    let mut organisms_by_tile: HashMap<(usize, usize), Vec<(Entity, Mut<Organism>)>> =
        HashMap::new();

    for (entity, organism, position) in query.iter_mut() {
        organisms_by_tile
            .entry((position.x, position.y))
            .or_default()
            .push((entity, organism));
    }

    for ((x, y), organisms) in organisms_by_tile.iter_mut() {
        let tile = &mut world.grid[*y][*x];
        if tile.food_availabilty < 0.0 {
            continue;
        }

        organisms.sort_by(|a, b| {
            b.1.size
                .partial_cmp(&a.1.size)
                .unwrap_or(std::cmp::Ordering::Equal)
        });

        let mut remaining_food = tile.food_availabilty;
        for (_, organism) in organisms.iter_mut() {
            if remaining_food <= 0.0 {
                break;
            }

            let food_needed = organism.size * 0.2 * organism.speed;

            let food_consumed = food_needed.min(remaining_food);
            remaining_food -= food_consumed;
            organism.energy += food_consumed * 2.0;

            tile.food_availabilty -= food_consumed;
        }
    }
}
```, caption: "System spożywania dla organizmów")

W listingu 20 przedstawiony jest system `consume_food`, który odpowiada za spożywanie jedzenia przez organizmy. Na początku zbieram organizmy na danym kafelku. Następnie sprawdzam czy na danym kafelku jest dostępne jedzenie. Jeśli nie ma jedzenia, to przechodzę do następnego kafelka. Potem sortuję organizmy na danym kafelku od największego do najmniejszego. Następnie tworzę zmienną, która przechowuje informację o tym ile jedzenia zostało na danym kafelku. Potem dla każdego organizmu obliczam ile jedzenia potrzebuje na podstawie rozmiaru oraz prędkości organizmu. Odejmuję od dostępnego jedzenia ilość jedzenia, którą zjadł organizm. Następnie dodaję energię organizmowi na podstawie zjedzonego jedzenia pomnożonego przez arbitralną wartość 2.0. Na końcu odejmuję zjedzone jedzenie od dostępnego jedzenia na kafelku. Jeśli organizm zje więcej jedzenia niż jest dostępne na kafelku, to zje tylko tyle ile jest dostępne. Natomiast jak jedzenie na kafelku się skończy, to organizmy nie będą mogły zjeść jedzenia z tego kafelka.

#figure(```rust

fn biome_adaptation(mut query: Query<(&mut Organism, &Position)>, world: Res<World>) {
    for (mut organism, position) in query.iter_mut() {
        let tile = &world.grid[position.y][position.x];
        let tolerance = organism.biome_tolerance.get(&tile.biome).unwrap_or(&1.0);

        match tile.biome {
            Biome::Forest => {
                organism.energy += 0.1 * tolerance;
            }
            Biome::Desert => {
                organism.energy -= 0.1 / tolerance;
            }
            Biome::Water => {
                organism.energy -= f32::MAX;
            }
            Biome::Grassland => {
                organism.energy += 0.05 * tolerance;
            }
        }
    }
}
```, caption: "System adaptacji do terenu dla organizmów")

W listingu 21 przedstawiony jest system `biome_adaptation`, który odpowiada za adaptację organizmów do terenu. Ten system odpowiada za bierne wpływanie na energię organizmów. W zależności od rodzaju terenu, na którym znajduje się organizm, energia organizmu zmniejsza się lub zwiększa. Lasy są bogate w jedzenie, więc organizmy zyskują energię, pustynie są ubogie w jedzenie, więc organizmy tracą energię, woda nie jest dobrym miejscem dla organizmów, więc organizmy tracą całą energię, łąki są dobre do pasienia, więc organizmy zyskują energię. Tolerancja terenu wpływa na to, jak bardzo organizm jest przystosowany do danego terenu, co z kolei zwiększa bądź zmniejsza ilość zyskanej lub utraconej energii.

#figure(```rust
fn reproduction(
    mut commands: Commands,
    mut query: Query<(&mut Organism, &Position)>,
    predators_query: Query<&Predator>,
    world: Res<World>,
    config: Res<Config>,
) {
    let organisms_count = query.iter().count();
    let predators_count = predators_query.iter().count();
    let total_entities = organisms_count + predators_count;

    if total_entities >= config.max_total_entities {
        return;
    }

    let mut rng = StdRng::seed_from_u64(config.seed);

    for (mut organism, position) in query.iter_mut() {
        if organism.energy > organism.reproduction_threshold {
            let mutation_factor = config.organism_mutability;

            let tile_biome = &world.grid[position.y][position.x].biome;

            let mut biome_tolerance = get_biome_tolerance(tile_biome, config.seed);
            for (_, tolerance) in biome_tolerance.iter_mut() {
                *tolerance *= 1.0 + rng.gen_range(-mutation_factor..mutation_factor);
            }

            let reproduction_threshold = organism.reproduction_threshold
                * (1.0 + rng.gen_range(-mutation_factor..mutation_factor));

            let size = organism.size * (1.0 + rng.gen_range(-mutation_factor..mutation_factor));
            let speed = (organism.speed * (1.1 + rng.gen_range(-mutation_factor..mutation_factor)))
                - (size * 0.1);

            let child = Organism {
                energy: organism.energy / 2.0,
                speed: speed,
                size: size,
                reproduction_threshold,
                biome_tolerance,
            };

            let x_offset = rng.gen_range(-1..=1);
            let y_offset = rng.gen_range(-1..=1);

            let child_position = Position {
                x: (position.x as isize + x_offset).clamp(0, world.width as isize - 1) as usize,
                y: (position.y as isize + y_offset).clamp(0, world.height as isize - 1) as usize,
            };

            commands.spawn((child, child_position));

            organism.energy /= 2.0;
        }
    }
}
```, caption: "System rozmnażania dla organizmów")

W listingu 22 przedstawiony jest system `reproduction`, który odpowiada za rozmnażanie organizmów. Dla każdego organizmu sprawdzam czy jego energia jest większa od progu reprodukcji. Jeśli tak, to tworzę nowego potomka na podstawie ustawień konfiguracyjnych. Następnie losuję mutacje dla nowego potomka. Mutacje są losowane z przedziału `[-mutation_factor, mutation_factor]`. Następnie tworzę nowego potomka na podstawie mutacji. Potomek ma połowę energii rodzica, prędkość, rozmiar oraz próg reprodukcji są mutowane. Następnie losuję pozycję potomka w sąsiedztwie rodzica. Na końcu zmniejszam energię rodzica o połowę. Dzięki temu organizmy mogą się rozmnażać i przekazywać swoje cechy potomstwu.

Jeśli liczba organizmów i drapieżników przekroczy maksymalną liczbę jednostek na planszy, to nie będą mogły się rozmnażać. Dzięki temu ograniczam liczbę jednostek na planszy.

#figure(```rust
fn hunting(
    mut commands: Commands,
    mut predator_query: Query<(&mut Predator, &Position)>,
    prey_query: Query<(Entity, &Position, &Organism), Without<Predator>>,
) {
    for (mut predator, predator_position) in predator_query.iter_mut() {
        if predator.energy >= predator.satiation_threshold {
            continue;
        }

        for (prey_entity, prey_position, prey) in prey_query.iter() {
            if predator_position.x == prey_position.x && predator_position.y == prey_position.y {
                let energy_gained = prey.size * predator.hunting_efficiency;
                predator.energy += energy_gained;
                commands.entity(prey_entity).try_despawn_recursive();
                break;
            }
        }
    }
}
```)

W listingu 23 przedstawiony jest system `hunting` odpowiedzialny za polowanie drapieżników na organizmy. Dla każdego drapieżnika sprawdzam czy jego energia jest mniejsza od progu sytości. Jeśli tak, to sprawdzam czy drapieżnik znajduje się na tym samym kafelku co ofiara. Jeśli tak, to drapieżnik zjada ofiarę i zyskuje energię na podstawie rozmiaru ofiary oraz efektywności polowania drapieżnika. Następnie usuwam ofiarę z planszy. Dzięki temu drapieżniki mogą polować na organizmy i zyskiwać energię.

#figure(```rust

fn predator_reproduction(
    mut commands: Commands,
    mut query: Query<(&mut Predator, &Position)>,
    organisms_query: Query<&Organism>,
    world: Res<World>,
    config: Res<Config>,
) {
    let predators_count = query.iter().count();
    let organisms_count = organisms_query.iter().count();
    let total_entities = predators_count + organisms_count;

    if total_entities >= config.max_total_entities {
        return;
    }

    let mut rng = StdRng::seed_from_u64(config.seed);

    for (mut predator, position) in query.iter_mut() {
        if predator.energy > predator.reproduction_threshold {
            let mutation_factor = config.predator_mutability;

            let size = predator.size * (1.0 + rng.gen_range(-mutation_factor..mutation_factor));
            let speed = predator.speed * (1.1 + rng.gen_range(-mutation_factor..mutation_factor))
                - (size * 0.1);

            let child = Predator {
                energy: predator.energy / 2.0,
                speed: speed,
                size: size,
                hunting_efficiency: predator.hunting_efficiency
                    * (1.0 + rng.gen_range(-mutation_factor..mutation_factor)),
                satiation_threshold: predator.satiation_threshold
                    * (1.0 + rng.gen_range(-mutation_factor..mutation_factor)),
                reproduction_threshold: predator.reproduction_threshold
                    * (1.0 + rng.gen_range(-mutation_factor..mutation_factor)),
            };

            let x_offset = rng.gen_range(-1..=1);
            let y_offset = rng.gen_range(-1..=1);

            let child_position = Position {
                x: (position.x as isize + x_offset).clamp(0, world.width as isize - 1) as usize,
                y: (position.y as isize + y_offset).clamp(0, world.height as isize - 1) as usize,
            };

            commands.spawn((child, child_position));

            predator.energy /= 2.0;
        }
    }
}
```, caption: "System rozmnażania dla drapieżników")

System rozmnażania dla drapieżników przedstawiony w listingu 24 działa analogicznie do systemu rozmnażania dla organizmów. Dla każdego drapieżnika sprawdzam czy jego energia jest większa od progu reprodukcji. Jeśli tak, to tworzę nowego potomka na podstawie ustawień konfiguracyjnych. Następnie losuję mutacje dla nowego potomka. Mutacje są losowane z przedziału `[-mutation_factor, mutation_factor]`. Następnie tworzę nowego potomka na podstawie mutacji. Potomek ma połowę energii rodzica, prędkość, rozmiar, efektywność polowania, próg sytości oraz próg reprodukcji są mutowane. Następnie losuję pozycję potomka w sąsiedztwie rodzica. Na końcu zmniejszam energię rodzica o połowę. Dzięki temu drapieżniki mogą się rozmnażać i przekazywać swoje cechy potomstwu.

Analogicznie do systemu reprodukcji organizmów, u drapieżników również sprawdzana jest ilość jednostek na planszy. Jeśli liczba jednostek przekroczy maksymalną liczbę jednostek na planszy, to drapieżniki nie będą mogły się rozmnażać.

#figure(```rust
fn overcrowding(
    mut query: Query<(&mut Organism, &Position)>,
    mut predator_query: Query<(&mut Predator, &Position)>,
    config: Res<Config>,
) {
    let overcrowding_threshold_for_organisms = config.overcrowding_threshold_for_organisms;
    let overcrowding_threshold_for_predators = config.overcrowding_threshold_for_predators;

    let mut organisms_by_tile: HashMap<(usize, usize), Vec<Mut<Organism>>> = HashMap::new();

    for (organism, position) in query.iter_mut() {
        organisms_by_tile
            .entry((position.x, position.y))
            .or_default()
            .push(organism);
    }

    for (_, organisms) in organisms_by_tile.iter_mut() {
        if organisms.len() > overcrowding_threshold_for_organisms {
            organisms.sort_by(|a, b| {
                a.energy
                    .partial_cmp(&b.energy)
                    .unwrap_or(std::cmp::Ordering::Equal)
            });

            let num_to_remove = organisms.len() - overcrowding_threshold_for_organisms;
            for organism in organisms.iter_mut().take(num_to_remove) {
                organism.energy = -1.0;
            }
        }
    }

    let mut predators_by_tile: HashMap<(usize, usize), Vec<Mut<Predator>>> = HashMap::new();

    for (predator, position) in predator_query.iter_mut() {
        predators_by_tile
            .entry((position.x, position.y))
            .or_default()
            .push(predator);
    }

    for (_, predators) in predators_by_tile.iter_mut() {
        if predators.len() > overcrowding_threshold_for_predators {
            predators.sort_by(|a, b| {
                a.energy
                    .partial_cmp(&b.energy)
                    .unwrap_or(std::cmp::Ordering::Equal)
            });

            let num_to_remove = predators.len() - overcrowding_threshold_for_predators;
            for predator in predators.iter_mut().take(num_to_remove) {
                predator.energy = -1.0;
            }
        }
    }
}
```, caption: "System przeludnienia")

System przeludnienia przedstawiony w listingu 25 odpowiada za usuwanie jednostek z planszy, gdy przekroczona zostanie maksymalna liczba jednostek na kafelku. Dla każdego kafelka na planszy zbieram organizmy i drapieżniki. Następnie sprawdzam czy liczba organizmów na kafelku przekracza próg przeludnienia dla organizmów. Jeśli tak, to sortuję organizmy na kafelku od najmniej energii do najwięcej energii. Następnie usuwam organizmy, które przekraczają próg przeludnienia dla organizmów. Analogicznie postępuję z drapieżnikami. Dzięki temu ograniczam liczbę jednostek na kafelku.

#figure(```rust
fn increment_generation(mut generation: ResMut<Generation>) {
    generation.0 += 1;
}
```, caption: "System inkrementacji numeru pokolenia")

W listingu 26 przedstawiony jest najkrótszy system w całym programie. System `increment_generation` odpowiada za inkrementację numeru pokolenia.

#figure(```rust
fn initialize_log_file(config: Res<Config>) {
    if !config.log_data {
        return;
    }

    let world_file = File::create("world_data.jsonl").expect("Failed to create log file");
    world_file.set_len(0).expect("Failed to clear log file");
}
```)

W listingu 27 przedstawiony jest system `initialize_log_file`, który odpowiada za inicjalizację pliku danych symulacji. Jeśli w konfiguracji ustawiono, że dane mają być zapisywane do pliku, to tworzę plik `world_data.jsonl` i czyszczę go. Format pliku `jsonl`
to format JSON, w którym każda linia to osobny obiekt JSON. Dzięki temu mogę łatwo parsować plik JSON linia po linii i dodatkowo ułatwia to zapis danych do pliku wraz z postępem symulacji.

#figure(```rust
fn log_world_data(
    config: Res<Config>,
    world: Res<World>,
    generation: Res<Generation>,
    organisms_query: Query<(&Organism, &Position)>,
    predators_query: Query<(&Predator, &Position)>,
) {
    if !config.log_data {
        return;
    }

    let mut file = OpenOptions::new()
        .create(true)
        .append(true)
        .open("world_data.jsonl")
        .expect("Failed to open log file");

    let organisms_with_position = organisms_query
        .iter()
        .map(|(organism, position)| OrganismWithPosition {
            organism: organism.clone(),
            position: position.clone(),
        })
        .collect::<Vec<_>>();

    let predators_with_position = predators_query
        .iter()
        .map(|(predator, position)| PredatorWithPosition {
            predator: predator.clone(),
            position: position.clone(),
        })
        .collect::<Vec<_>>();

    let export_data = ExportData {
        generation: generation.0,
        world: world.clone(),
        config: config.clone(),
        organisms: organisms_with_position,
        predators: predators_with_position,
    };

    let json = serde_json::to_string(&export_data).expect("Failed to serialize data");

    writeln!(file, "{}", json).expect("Failed to write to log file");
}
```)
W listingu 28 przedstawiony jest system `log_world_data`, który odpowiada za zapis danych symulacji do pliku. Jeśli w konfiguracji ustawiono, że dane mają być zapisywane do pliku, to otwieram plik `world_data.jsonl` w trybie dodawania i tworzenia pliku, a następnie zapisuję dane symulacji do pliku. Dane symulacji zawierają numer pokolenia, stan planszy, ustawienia konfiguracyjne, organizmy oraz drapieżniki na planszy. Dane są zapisywane w formacie JSON.

#figure(```rust
fn handle_camera_movement(
    mut query: Query<(&mut Transform, &Camera)>,
    keys: Res<ButtonInput<KeyCode>>,
) {
    for (mut transform, _) in query.iter_mut() {
        let mut translation = transform.translation;

        if keys.pressed(KeyCode::KeyW) {
            translation.y += 5.0;
        }
        if keys.pressed(KeyCode::KeyS) {
            translation.y -= 5.0;
        }
        if keys.pressed(KeyCode::KeyA) {
            translation.x -= 5.0;
        }
        if keys.pressed(KeyCode::KeyD) {
            translation.x += 5.0;
        }

        transform.translation = translation;
    }
}
```)

System `handle_camera_movement` odpowiada za obsługę ruchu kamery przy pomocy klawiszy `WSAD`.

#figure(```rust
fn load_config() -> Result<Config, Box<dyn Error>> {
    let exe_dir = std::env::current_exe()
        .expect("Failed to get current executable path")
        .parent()
        .expect("Executable must be in a directory")
        .to_path_buf();

    let config_path = exe_dir.join("config.toml");

    let config = fs::read_to_string(config_path)?;
    let config: Config = toml::from_str(&config)?;

    Ok(config)
}



fn default_config() -> Config {
    Config {
        width: 10,
        height: 10,
        initial_organisms: 10,
        initial_predators: 1,
        headless: false,
        log_data: false,
        forest: BiomeDataConfig {
            food_availabilty: 1.0,
            max_food_availabilty: 100.0,
        },
        desert: BiomeDataConfig {
            food_availabilty: 1.0,
            max_food_availabilty: 100.0,
        },
        water: BiomeDataConfig {
            food_availabilty: 1.0,
            max_food_availabilty: 100.0,
        },
        grassland: BiomeDataConfig {
            food_availabilty: 1.0,
            max_food_availabilty: 100.0,
        },
        initial_organism_energy: 100.0,
        initial_predator_energy: 100.0,
        initial_organism_speed: 1.0,
        initial_predator_speed: 1.0,
        initial_organism_size: 1.0,
        initial_predator_size: 1.0,
        initial_organism_reproduction_threshold: 100.0,
        initial_predator_reproduction_threshold: 100.0,
        initial_predator_hunting_efficiency: 1.0,
        initial_predator_satiation_threshold: 100.0,
        organism_mutability: 0.1,
        predator_mutability: 0.1,
        overcrowding_threshold_for_organisms: 10,
        overcrowding_threshold_for_predators: 10,
        seed: 0,
        max_total_entities: 1000,
    }
}

fn get_config() -> Config {
    #[cfg(target_arch = "wasm32")]
    let config = default_config();
    #[cfg(not(target_arch = "wasm32"))]
    let config = load_config().expect("Failed to load config file");

    config
}
```, caption: "Funkcje do obsługi konfiguracji")

W listingu 30 przedstawione są funkcje do obsługi konfiguracji. Funkcja `load_config` wczytuje konfigurację z pliku `config.toml`. Funkcja `default_config` zwraca domyślną konfigurację, jeśli nie uda się wczytać konfiguracji z pliku. Funkcja `get_config` zwraca konfigurację. Jeśli program jest uruchomiony w przeglądarce, to zwracana jest domyślna konfiguracja. W przeciwnym przypadku zwracana jest wczytana konfiguracja z pliku.

== Wizualizacja

Teraz omówię kod odpowiedzialny za wizualizację danych i ich obróbkę. Kod jest napisany w języku *Python*.

#figure(```python
import json
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
```, caption: "Importowanie bibliotek")

W pierwszej kolejności importuję potrzebne biblioteki do wizualizacji danych. Biblioteka `json` jest potrzebna do wczytania danych z pliku JSON, biblioteka `numpy` do operacji na macierzach, biblioteka `pandas` do operacji na danych, biblioteka `matplotlib` do tworzenia wykresów, a biblioteka `seaborn` do tworzenia wykresów statystycznych jak wykres mapy cieplnej.

#figure(```python
jsonl_file = "world_data.jsonl"
generations = []
organism_count = 0
predator_count = 0
width, height = None, None

gen_list = []
organism_counts = []
predator_counts = []
biome_counts = {"Forest": [], "Desert": [], "Water": [], "Grassland": []}

heatmap_grid = None
last_snapshot = None

organism_avg_size_list = []
organism_avg_speed_list = []
organism_avg_energy_list = []
predator_avg_size_list = []
predator_avg_speed_list = []
predator_avg_energy_list = []
organism_avg_reproduction_threshold_list = []
predator_avg_reproduction_threshold_list = []
predator_avg_hunting_efficiency_list = []
predator_avg_satiation_threshold_list = []

average_food_per_generation = []
```, caption: "Inicjalizacja zmiennych")

W powyższym listingu tworzę zmienne, które będą mi potrzebne do stworzenia wykresów. Zmienna `jsonl_file` przechowuje ścieżkę do pliku z danymi. Zmienne `generations`, `organism_count`, `predator_count`, `width`, `height` przechowują informacje o pokoleniach, liczbie organizmów, liczbie drapieżników, szerokości i wysokości planszy. Zmienna `gen_list` przechowuje listę pokoleń, `organism_counts` i `predator_counts` przechowują listę liczby organizmów i drapieżników w każdym pokoleniu. Zmienna `biome_counts` przechowuje liczbę kafelków z danym rodzajem terenu w każdym pokoleniu. Zmienna `heatmap_grid` przechowuje mapę cieplną, a `last_snapshot` ostatni stan planszy. Pozostałe zmienne przechowują średnie wartości cech organizmów i drapieżników w każdym pokoleniu.

#figure(```python
with open(jsonl_file, 'r') as f:
    for line in f:
        if not line.strip():
            continue
        data = json.loads(line.strip())
        last_snapshot = data

        generation = data["generation"]
        generations.append(generation)
        organism_count = len(data["organisms"])
        predator_count = len(data["predators"])

        if width is None:
            width, height = data["config"]["width"], data["config"]["height"]
            heatmap_grid = np.zeros((height, width))
        
        gen_list.append(generation)
        organism_counts.append(organism_count)
        predator_counts.append(predator_count)

        if organism_count > 0:
            organism_avg_size_list.append(np.mean([o["organism"]["size"] for o in data["organisms"]]))
            organism_avg_speed_list.append(np.mean([o["organism"]["speed"] for o in data["organisms"]]))
            organism_avg_energy_list.append(np.mean([o["organism"]["energy"] for o in data["organisms"]]))
            organism_avg_reproduction_threshold_list.append(np.mean([o["organism"]["reproduction_threshold"] for o in data["organisms"]]))
        else:
            organism_avg_size_list.append(0)
            organism_avg_speed_list.append(0)
            organism_avg_energy_list.append(0)
            organism_avg_reproduction_threshold_list.append(0)

        if predator_count > 0:
            predator_avg_size_list.append(np.mean([p["predator"]["size"] for p in data["predators"]]))
            predator_avg_speed_list.append(np.mean([p["predator"]["speed"] for p in data["predators"]]))
            predator_avg_energy_list.append(np.mean([p["predator"]["energy"] for p in data["predators"]]))
            predator_avg_reproduction_threshold_list.append(np.mean([p["predator"]["reproduction_threshold"] for p in data["predators"]]))
            predator_avg_hunting_efficiency_list.append(np.mean([p["predator"]["hunting_efficiency"] for p in data["predators"]]))
            predator_avg_satiation_threshold_list.append(np.mean([p["predator"]["satiation_threshold"] for p in data["predators"]]))
        else:
            predator_avg_size_list.append(0)
            predator_avg_speed_list.append(0)
            predator_avg_energy_list.append(0)
            predator_avg_reproduction_threshold_list.append(0)
            predator_avg_hunting_efficiency_list.append(0)
            predator_avg_satiation_threshold_list.append(0)

        for org in data["organisms"]:
            x, y = org["position"]["x"], org["position"]["y"]
            heatmap_grid[y, x] += 1
        for pred in data["predators"]:
            x, y = pred["position"]["x"], pred["position"]["y"]
            heatmap_grid[y, x] += 1

        biome_tally = {"Forest": 0, "Desert": 0, "Water": 0, "Grassland": 0}
        for org in data["organisms"]:
            max_biome = max(org["organism"]["biome_tolerance"], key=org["organism"]["biome_tolerance"].get)
            biome_tally[max_biome] += 1
        for biome in biome_counts:
            biome_counts[biome].append(biome_tally[biome])

        total_food = sum(tile["food_availabilty"] for row in data["world"]["grid"] for tile in row)
        average_food_per_generation.append(total_food / (width * height))

        if len(gen_list) % 100 == 0:
            print(f"Processed {len(gen_list)} generations...")
```, caption: "Przetwarzanie danych")

Wczytuję dane z pliku `world_data.jsonl` i przetwarzam je, co ważne dane przetwarzane są linijka po linijce co jest istotne, gdyż plik może być bardzo duży i w przeciwnym wypadku program mógłby zużyć dużo pamięci, której komputer niekoniecznie posiada. Wczytuję dane o pokoleniu, liczbie organizmów, liczbie drapieżników, szerokości i wysokości planszy. Tworzę mapę cieplną planszy, a także obliczam średnie wartości cech organizmów i drapieżników w każdym pokoleniu. Obliczam również liczbę kafelków z danym rodzajem terenu w każdym pokoleniu oraz średnią ilość jedzenia na planszy. Dodatkowo co 100 pokoleń wypisuję informację o przetworzonych pokoleniach.

#figure(```python
plt.figure(figsize=(10, 5))
plt.plot(gen_list, organism_counts, label="Organisms", color="lime", linewidth=2)
plt.plot(gen_list, predator_counts, label="Predators", color="red", linewidth=2)
plt.xlabel("Generation")
plt.ylabel("Population")
plt.title("Population Over Time")
plt.legend()
plt.grid(True)
plt.savefig('population_trends.png')
```, caption: "Wykres populacji w czasie")

Na powyższym wykresie przedstawiam populację organizmów i drapieżników w czasie. Na osi X znajduje się numer pokolenia, a na osi Y liczba jednostek. Wykres przedstawia zmiany populacji organizmów i drapieżników w czasie.

#figure(```python
plt.figure(figsize=(8, 6))
sns.heatmap(heatmap_grid, cmap="hot", square=True)
plt.title("Population Heatmap")
plt.xlabel("X")
plt.ylabel("Y")
plt.savefig('population_heatmap.png')
```, caption: "Mapa cieplna populacji")

Na powyższym wykresie przedstawiam mapę cieplną populacji. Im jaśniejszy kolor, tym więcej jednostek na danym kafelku. Wykres przedstawia rozmieszczenie jednostek na planszy.

#figure(```python
plt.figure(figsize=(10, 5))
sns.histplot(organism_avg_energy_list, bins=30, color="lime", alpha=0.7, label="Organisms", kde=True)
sns.histplot(predator_avg_energy_list, bins=30, color="red", alpha=0.7, label="Predators", kde=True)
plt.xlabel("Energy Levels")
plt.ylabel("Frequency")
plt.title("Energy Distribution of Organisms and Predators")
plt.legend()
plt.grid(True)
plt.savefig("energy_distribution.png")
```, caption: "Rozkład energii organizmów i drapieżników")

Na powyższym wykresie przedstawiam rozkład energii organizmów i drapieżników. Na osi X znajduje się poziom energii, a na osi Y częstotliwość. Wykres przedstawia rozkład energii organizmów i drapieżników.

#figure(```python
df_biomes = pd.DataFrame(biome_counts, index=generations)
df_biomes.plot(kind="area", stacked=True, figsize=(10, 6), colormap="coolwarm", alpha=0.7)
plt.xlabel("Generation")
plt.ylabel("Organism Count")
plt.title("Biome Preference Trends Over Generations")
plt.legend(title="Biome")
plt.grid(True)
plt.savefig("biome_trends.png")
```, caption: "Trendy preferencji terenowych w czasie")

Na powyższym wykresie przedstawiam trendy preferencji terenowych organizmów w czasie. Na osi X znajduje się numer pokolenia, a na osi Y liczba jednostek. Wykres przedstawia zmiany preferencji terenowych organizmów w czasie. Każdy kolor odpowiada innemu rodzajowi terenu.

#figure(```python
plt.figure(figsize=(10, 5))
plt.plot(gen_list, average_food_per_generation, label="Avg Food Availability", color="orange", linewidth=2)
plt.xlabel("Generation")
plt.ylabel("Average Food Availability")
plt.title("Food Availability Trends Over Generations")
plt.legend()
plt.grid(True)
plt.savefig("food_trends.png")
```, caption: "Trendy dostępności jedzenia w czasie")
Na powyższym wykresie przedstawiam trendy dostępności jedzenia w czasie. Na osi X znajduje się numer pokolenia, a na osi Y średnia dostępność jedzenia. Wykres przedstawia zmiany dostępności jedzenia w czasie.

#figure(```python

food_grid = np.array([[tile["food_availabilty"] for tile in row] for row in last_snapshot["world"]["grid"]])
plt.figure(figsize=(8, 6))
sns.heatmap(food_grid, cmap="YlGnBu", square=True)
plt.title(f"Food Availability Heatmap (Generation {last_snapshot['generation']})")
plt.xlabel("X Position")
plt.ylabel("Y Position")
plt.savefig("food_heatmap.png")
```, caption: "Mapa cieplna dostępności jedzenia")

Na powyższym wykresie przedstawiam mapę cieplną dostępności jedzenia. Im jaśniejszy kolor, tym więcej jedzenia na danym kafelku. Wykres przedstawia dostępność jedzenia na planszy w ostatnim pokoleniu.

#figure(```python
fig, axes = plt.subplots(3, 1, figsize=(10, 12))
axes[0].plot(gen_list, organism_avg_size_list, label="Organisms - Avg Size", color="lime", linewidth=2)
axes[0].plot(gen_list, predator_avg_size_list, label="Predators - Avg Size", color="red", linewidth=2)
axes[0].set_ylabel("Size")
axes[0].set_title("Evolution of Size Over Generations")
axes[0].legend()
axes[0].grid(True)

axes[1].plot(gen_list, organism_avg_speed_list, label="Organisms - Avg Speed", color="blue", linewidth=2)
axes[1].plot(gen_list, predator_avg_speed_list, label="Predators - Avg Speed", color="orange", linewidth=2)
axes[1].set_ylabel("Speed")
axes[1].set_title("Evolution of Speed Over Generations")
axes[1].legend()
axes[1].grid(True)

axes[2].plot(gen_list, organism_avg_energy_list, label="Organisms - Avg Energy", color="yellow", linewidth=2)
axes[2].plot(gen_list, predator_avg_energy_list, label="Predators - Avg Energy", color="blue", linewidth=2)
axes[2].set_xlabel("Generation")
axes[2].set_ylabel("Energy")
axes[2].set_title("Evolution of Energy Over Generations")
axes[2].legend()
axes[2].grid(True)

plt.tight_layout()
plt.savefig("traits_evolution.png")
```, caption: "Wykresy ewolucji cech organizmów i drapieżników")

Na powyższych wykresach przedstawiam ewolucję cech organizmów i drapieżników w czasie. Na pierwszym wykresie przedstawiam średni rozmiar organizmów i drapieżników w czasie. Na drugim wykresie przedstawiam średnią prędkość organizmów i drapieżników w czasie. Na trzecim wykresie przedstawiam średnią energię organizmów i drapieżników w czasie.

#figure(```python
df = pd.DataFrame({
    "Generation": generations,
    "Organism Size": organism_avg_size_list,
    "Predator Size": predator_avg_size_list,
    "Organism Speed": organism_avg_speed_list,
    "Predator Speed": predator_avg_speed_list,
    "Organism Energy": organism_avg_energy_list,
    "Predator Energy": predator_avg_energy_list,
})

plt.figure(figsize=(8, 6))
sns.scatterplot(x="Organism Speed", y="Predator Speed", hue="Generation", size="Generation", sizes=(20, 200), data=df, palette="coolwarm")
plt.xlabel("Organism Speed")
plt.ylabel("Predator Speed")
plt.title("Correlation Between Organism and Predator Speed")
plt.legend(title="Generation", bbox_to_anchor=(1, 1))
plt.savefig("correlation_speed.png")
```, caption: "Korelacja między prędkościami organizmów i drapieżników")

#figure(```python
plt.figure(figsize=(8, 6))
sns.scatterplot(x="Organism Size", y="Predator Size", hue="Generation", size="Generation", sizes=(20, 200), data=df, palette="coolwarm")
plt.xlabel("Organism Size")
plt.ylabel("Predator Size")
plt.title("Correlation Between Organism and Predator Size")
plt.legend(title="Generation", bbox_to_anchor=(1, 1))
plt.savefig("correlation_size.png")
```, caption: "Korelacja między rozmiarami organizmów i drapieżników")

#figure(```python
plt.figure(figsize=(10, 5))
plt.plot(gen_list, organism_avg_reproduction_threshold_list, label="Organisms - Reproduction Threshold", color="lime", linewidth=2)
plt.plot(gen_list, predator_avg_reproduction_threshold_list, label="Predators - Reproduction Threshold", color="red", linewidth=2)
plt.xlabel("Generation")
plt.ylabel("Reproduction Threshold")
plt.title("Reproduction Threshold Evolution Over Generations")
plt.legend()
plt.grid(True)
plt.savefig("reproduction_threshold_trends.png")
```, caption: "Trendy progu reprodukcji w czasie")

#figure(```python
plt.figure(figsize=(10, 5))
plt.plot(gen_list, predator_avg_hunting_efficiency_list, label="Predators - Hunting Efficiency", color="blue", linewidth=2)
plt.xlabel("Generation")
plt.ylabel("Hunting Efficiency")
plt.title("Predator Hunting Efficiency Over Generations")
plt.legend()
plt.grid(True)
plt.savefig("hunting_efficiency_trends.png")
```, caption: "Trendy efektywności polowania drapieżników w czasie")

Powyższe listingi tworzą wykresy korelacji między różnymi cechami organizmów i drapieżników, takimi jak prędkość, rozmiar, energia, próg reprodukcji oraz efektywność polowania. Wykresy przedstawiają zmiany tych cech w czasie.

#figure(```python
df = pd.DataFrame({
    "Generation": generations,
    "Organism Reproduction Threshold": organism_avg_reproduction_threshold_list,
    "Predator Hunting Efficiency": predator_avg_hunting_efficiency_list
})

plt.figure(figsize=(8, 6))
sns.scatterplot(x="Organism Reproduction Threshold", y="Predator Hunting Efficiency",
                hue="Generation", size="Generation", sizes=(20, 200), data=df, palette="coolwarm")
plt.xlabel("Organism Reproduction Threshold")
plt.ylabel("Predator Hunting Efficiency")
plt.title("Correlation Between Reproduction and Hunting Efficiency")
plt.legend(title="Generation", bbox_to_anchor=(1, 1))
plt.savefig("correlation_reproduction_hunting.png")
```, caption: "Korelacja między progiem reprodukcji organizmów i efektywnością polowania drapieżników")

Listing 45 przedstawia korelację między progiem reprodukcji organizmów i efektywnością polowania drapieżników. Na osi X znajduje się próg reprodukcji organizmów, a na osi Y efektywność polowania drapieżników. Wykres przedstawia korelację między tymi dwoma cechami.

== Wyniki

= Podsumowanie

#bibliography("citations.bib", title: "Bibliografia")

= Kod źródłowy
Repozytorium z kodem źródłowym dostępne jest pod adresem:
#show link: underline
#link("https://github.com/GKaszewski/evolution_cellular_automata")
