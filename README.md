# E-Commerce Admin Dashboard

A modern, feature-rich Flutter-based admin dashboard for managing e-commerce operations. This dashboard provides comprehensive tools for monitoring sales, managing products, tracking orders, and analyzing customer data.

## 📸 Screenshots

### Dashboard Overview (Statistics)
![Dashboard Overview](screenshot/Screenshot%201.png)
The main dashboard provides a comprehensive overview with key metrics, interactive charts, and product analytics.

![Statistics View](screenshot/Screenshot%202.png)
Detailed statistics view with sales trends, category analysis, and revenue distribution.

### Products Management
![Products Overview](screenshot/Screenshot%203.png)
Complete product management interface with inventory tracking, stock management, and product categorization.

### Orders Management
![Orders Overview](screenshot/Screenshot%204.png)
Order tracking and management system with status monitoring, customer information, and order history.

### Customer Management
![Customers Overview](screenshot/Screenshot%205.png)
Customer relationship management with activity tracking, customer segmentation, and order history.

## ✨ Features

### 📊 Dashboard & Analytics
- **Real-time Statistics**: Monitor total revenue, average order value, customer count, and product metrics
- **Interactive Charts**: 
  - Sales trend line charts
  - Category sales bar charts
  - Revenue distribution donut charts
- **Data Visualization**: Comprehensive visual representation of business metrics

### 🛍️ Product Management
- Product overview with total products, stock status, and categories
- Product search and filtering capabilities
- Stock management and inventory tracking
- Product categorization system
- SKU management

### 📦 Order Management
- Order tracking with status monitoring (Delivered, Pending, Cancelled)
- Order history and customer details
- Order search functionality
- Order analytics and reporting

### 👥 Customer Management
- Customer overview with active/inactive status tracking
- Customer search and filtering
- Order history per customer
- Customer segmentation and analytics

### 📈 Sales & Inventory
- Sales analytics and reporting
- Inventory management
- Stock level monitoring
- Sales performance tracking

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7.0+
- **State Management**: GetX 4.6.6
- **Charts**: fl_chart 0.69.0
- **Date Formatting**: intl 0.19.0
- **Window Management**: window_manager 0.3.8
- **UI**: Material Design 3

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (3.7.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development on macOS)
- Android SDK (for Android development)

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone <https://github.com/ADILAYOUB/E-Commerce-Admin_Dashboard>
   cd E-Commerce\ Admin_Dashboard
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
```bash
cd android
./gradlew build
```

#### iOS (macOS only)
```bash
cd ios
pod install
```

#### macOS
```bash
cd macos
pod install
```

## 📁 Project Structure

```
lib/
├── controllers/          # State management controllers
│   ├── dashboard_controller.dart
│   ├── product_controller.dart
│   ├── order_controller.dart
│   ├── customers_controller.dart
│   ├── inventory_controller.dart
│   └── sales_controller.dart
├── views/
│   ├── dashboard.dart    # Main dashboard view
│   └── widgets/          # Reusable UI components
│       ├── statistics_section.dart
│       ├── product_section.dart
│       ├── order_section.dart
│       ├── customer_section.dart
│       ├── inventory_section.dart
│       └── sales_section.dart
└── main.dart            # Application entry point
```

## 🎨 UI/UX Features

- **Modern Design**: Clean, intuitive interface with Material Design 3
- **Responsive Layout**: Adapts to different screen sizes
- **Sidebar Navigation**: Easy navigation between different sections
- **Search & Filter**: Advanced search and filtering capabilities
- **Data Tables**: Sortable and paginated data tables
- **Interactive Charts**: Real-time data visualization

## 📊 Dashboard Sections

1. **Statistics**: Overview of key business metrics and analytics
2. **Products**: Product catalog and inventory management
3. **Orders**: Order processing and tracking
4. **Customers**: Customer relationship management
5. **Inventory**: Stock management and monitoring
6. **Sales**: Sales analytics and reporting

## 🔧 Configuration

The application uses GetX for state management. Controllers are initialized in `main.dart`:

```dart
Get.put(DashboardController());
```

## 📝 Development

### Adding New Features

1. Create controller in `lib/controllers/`
2. Create view widget in `lib/views/widgets/`
3. Add navigation item in `DashboardController`
4. Update `_buildContext()` in `dashboard.dart`

### Code Style

The project follows Flutter's recommended linting rules defined in `analysis_options.yaml`.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👤 Author

**Adil Ayoub**

## 📞 Support

For support, email [your-email] or open an issue in the repository.

---

**Note**: This is a Flutter project. For more information about Flutter development, visit:
- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter API Reference](https://api.flutter.dev/)
