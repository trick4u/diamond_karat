# diamond_karat
 Hired
The app uses the **BLoC (Business Logic Component)** pattern, implemented with the `flutter_bloc` package, to manage state effectively:

- **FilterBloc** (`lib/bloc/filter/filter_bloc.dart`):
  - Manages filter criteria (carat range, lab, shape, color, clarity).
  - Events: `UpdateCaratRange`, `UpdateLab`, `UpdateShape`, `UpdateColor`, `UpdateClarity`, `ApplyFilters`.
  - State: Holds filter values and the resulting filtered list of diamonds.
  - Logic: Applies filters to the full dataset (`DiamondData.getDiamonds()`) and emits the filtered list when `ApplyFilters` is triggered.

- **ResultBloc** (`lib/bloc/result/result_bloc.dart`):
  - Manages the display and sorting of filtered diamonds.
  - Events: `LoadDiamonds`, `SortByPrice`, `SortByCarat`.
  - State: Holds the current list of diamonds to display.
  - Logic: Sorts diamonds by final price or carat weight (ascending/descending) based on user input.

- **CartBloc** (`lib/bloc/cart/cart_bloc.dart`):
  - Manages the cart state, including adding/removing diamonds and calculating summary statistics.
  - Events: `LoadCart`, `AddToCart`, `RemoveFromCart`.
  - State: Holds the list of cart items and summary data (total carat, total price, average price, average discount).
  - Logic: Persists cart data to local storage using `shared_preferences` and updates the state with calculated summaries.

## Persistent Storage Usage

The app uses the `shared_preferences` package to persist the cart data locally:

- **Implementation**: The `CartBloc` handles persistence by:
  - Saving the cart as a JSON-encoded list of diamonds to `shared_preferences` whenever a diamond is added or removed (`_saveCart` method).
  - Loading the cart from storage on app startup (`_loadCartFromStorage` method) and initializing the state.
- **Storage Key**: The cart is stored under the key `'cart'` as a `StringList` of JSON strings.
- **Data Format**: Each `Diamond` object is converted to a JSON map using the `toJson` method and stored, then reconstructed using the `fromJson` factory method when loaded.

## Setup Instructions

To set up and run the Diamond Selection App:

1. **Clone the Repository**:
   ```bash
   git clone <https://github.com/trick4u/diamond_karat.git>
   cd diamond_karat