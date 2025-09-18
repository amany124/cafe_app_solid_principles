class Report {
  /// عدد الطلبات المكتملة
  final int totalServed;

  /// إجمالي كل الطلبات (مكتملة + غير مكتملة)
  final int totalOrders;

  /// قائمة بالمشروبات الأكثر مبيعاً
  final List<MapEntry<String, int>> topSelling;

  Report({
    required this.totalServed,
    required this.totalOrders,
    required this.topSelling,
  });
}
