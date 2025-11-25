#  Meal Recipes App

Оваа апликација е изработена како дел од Лабораториска вежба 2 од предметот **Mobile Information Systems.**
Целта е да се развие Flutter апликација која ги прикажува категориите на јадења, 
листата на рецепти и детален приказ користејќи го јавниот API TheMealDB.

---

##  Функционалности

- 1.Почетен екран – Листа на категории
  - Се преземаат сите категории од API:https://www.themealdb.com/api/json/v1/1/categories.php
  - Секоја категорија се прикажува на картичка со:
    - Име
    - Слика
    - Краток опис
- 2.Екран со јадења по категорија
  - При избор на категорија, се преземаат сите јадења во таа категорија:https://www.themealdb.com/api/json/v1/1/filter.php?c={category}
  - Јадењата се прикажуваат во grid layout со слика и име.
  - Поддржано пребарување на јадења во рамки на категоријата.
- 3. Детален приказ на рецепт
  - API: https://www.themealdb.com/api/json/v1/1/lookup.php?i={id}
  - Деталниот приказ содржи:
    - Слика од јадењето
    - Име
    - Список со состојки
    - Детални инструкции
    - YouTube линк (ако постои)
- 4. Random Recipe of the Day
    - API: https://www.themealdb.com/api/json/v1/1/random.php
    - Ја отвора страницата со деталите за случајно избрано јадење.
---

##  Структура на проектот
```
lib/
│
├── models/
│     ├── category.dart
│     └── meal.dart
│
├── services/
│     └── meal_api_service.dart
│
├── screens/
│     ├── categories_screen.dart
│     ├── meals_by_category_screen.dart
│     └── meal_detail_screen.dart
│
└── widgets/
      ├── category_card.dart
      └── meal_grid_item.dart
```

##  Како да ја стартувате апликацијата?

1. **Клонирај го репозиториумот:**
   ```bash
    git clone https://github.com/marijabeleska/Mobile-information-systems.git
   
````
2. Со помош на командата cd(change directory) влези во фолдерот:
    cd lab_2_meal_recipes_app
3.Отвори го проектот во Android Studio или VS Code

4.Инсталирај ги зависностите:
flutter pub get

5.Стартувај апликација:
flutter run

Автор
Марија Белеска
ФИНКИ — Универзитет „Св. Кирил и Методиј“, Скопје
Предмет: Мобилни информациски системи
