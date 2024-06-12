#set par(
  justify: true,
  leading: 0.52em,
)

#let title = [
  Zastosowanie Entity Component System oraz wielowątkowości do symulacji systemów cząsteczek
]

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
)

#align(center, text(17pt)[
  *#title*
])

#align(center, text(14pt)[
  Gabriel Kaszewski
])

#set heading(numbering: "1.")

= Wprowadzenie
== Cel pracy
Celem pracy jest stworzenie szkieletu (ang. framework) aplikacji do tworzenia wszelakich symulacji systemów cząsteczek.
Przykładowymi symulacjami mogą być: symulacja gazu, płynów, dynamiki białek, co może być przydatne w bioinformatyce.
W tej pracy przykładowym system cząsteczek będzie 'Gra w życie' Johna Conwaya. Wspomniany przeze mnie szkielet powinien
móc umożliwiać tworzenie wydajnej symulacji w oparciu o architekturę ECS (Entity Component System) oraz stosować
w jak najszerszym zakresie techniki wielowątkowości, tam gdzie jest to możliwe i uzasadnione.
== Technologie
W pracy wykorzystam
= Entity Component System
== Wstęp
== Encje
== Komponenty
== Systemy
== Świat
== Zalety Entity Component System
== Wielowątkowość w Entity Component System
== Podsumowanie

= Gra w życie
== Wprowadzenie
== Zastosowanie ECS
== Wielowątkowość
== Optymalizacja przestrzenna
== Podsumowanie
= Szkielet
= Przyszłość
= Podsumowanie
#bibliography("citations.bib", title: "Bibliografia")

