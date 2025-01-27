class OrderSummaryModel {
  final String orderId;
  final int userId;
  final String address;
  final String region;
  final String userName;
  final int addressId;
  final DateTime orderCreatedAt;
  final String itemId;
  final String itemName;
  final String imageUrl;
  final double itemPrice;
  final int itemStockQuantity;
  final int previousQuantity;
  final int nextQuantity;
  final int transactionQuantity;
  final String transactionType;
  final String orderState;

  OrderSummaryModel({
    this.orderId = '',
    this.userId = 0,
    this.address = '',
    this.region = '',
    this.userName = '',
    this.addressId = 0,
    DateTime? orderCreatedAt,
    this.itemId = '',
    this.itemName = '',
    this.imageUrl = '',
    this.itemPrice = 0.0,
    this.itemStockQuantity = 0,
    this.previousQuantity = 0,
    this.nextQuantity = 0,
    this.transactionQuantity = 0,
    this.transactionType = '',
    this.orderState = '',
  }) : orderCreatedAt = orderCreatedAt ?? DateTime.now();

  /// Factory constructor to create an instance from a map
  factory OrderSummaryModel.fromMap(Map<String, dynamic> map) {
    return OrderSummaryModel(
      orderId: map['order_id'] ?? '',
      userId: map['user_id'] ?? 0,
      address: map['address'] ?? '',
      region: map['region'] ?? '',
      userName: map['user_name'] ?? '',
      addressId: map['adress_id'] ?? 0,
      orderCreatedAt: map['order_created_at'] != null
          ? DateTime.parse(map['order_created_at'])
          : DateTime.now(),
      itemId: map['item_id'] ?? '',
      itemName: map['item_name'] ?? '',
      imageUrl: map['image_url'] ?? '',
      itemPrice: (map['item_price'] as num?)?.toDouble() ?? 0.0,
      itemStockQuantity: map['item_stock_quantity'] ?? 0,
      previousQuantity: map['previous_quantity'] ?? 0,
      nextQuantity: map['next_quantity'] ?? 0,
      transactionQuantity: map['transaction_quantity'] ?? 0,
      transactionType: map['transaction_type'] ?? '',
      orderState: map['state'] ?? '',
    );
  }

  /// Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'address': address,
      'region': region,
      'user_name': userName,
      'adress_id': addressId,
      'order_created_at': orderCreatedAt.toIso8601String(),
      'item_id': itemId,
      'item_name': itemName,
      'image_url': imageUrl,
      'item_price': itemPrice,
      'item_stock_quantity': itemStockQuantity,
      'previous_quantity': previousQuantity,
      'next_quantity': nextQuantity,
      'transaction_quantity': transactionQuantity,
      'transaction_type': transactionType,
      'state': orderState,
    };
  }

  /// Copy the object with modified values
  OrderSummaryModel copyWith({
    String? orderId,
    int? userId,
    String? address,
    String? region,
    String? userName,
    int? addressId,
    DateTime? orderCreatedAt,
    String? itemId,
    String? itemName,
    String? imageUrl,
    double? itemPrice,
    int? itemStockQuantity,
    int? previousQuantity,
    int? nextQuantity,
    int? transactionQuantity,
    String? transactionType,
    String? orderState,
  }) {
    return OrderSummaryModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      region: region ?? this.region,
      userName: userName ?? this.userName,
      addressId: addressId ?? this.addressId,
      orderCreatedAt: orderCreatedAt ?? this.orderCreatedAt,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      imageUrl: imageUrl ?? this.imageUrl,
      itemPrice: itemPrice ?? this.itemPrice,
      itemStockQuantity: itemStockQuantity ?? this.itemStockQuantity,
      previousQuantity: previousQuantity ?? this.previousQuantity,
      nextQuantity: nextQuantity ?? this.nextQuantity,
      transactionQuantity: transactionQuantity ?? this.transactionQuantity,
      transactionType: transactionType ?? this.transactionType,
      orderState: orderState ?? this.orderState,
    );
  }

  /// Check if the object has specific properties (null or empty check)
  bool has({
    String? orderId,
    int? userId,
    String? address,
    String? region,
    String? userName,
    int? addressId,
    String? itemId,
    String? itemName,
    String? imageUrl,
    String? transactionType,
    String? orderState,
  }) {
    return (orderId == null || this.orderId == orderId) &&
        (userId == null || this.userId == userId) &&
        (address == null || this.address == address) &&
        (region == null || this.region == region) &&
        (userName == null || this.userName == userName) &&
        (addressId == null || this.addressId == addressId) &&
        (itemId == null || this.itemId == itemId) &&
        (itemName == null || this.itemName == itemName) &&
        (imageUrl == null || this.imageUrl == imageUrl) &&
        (transactionType == null || this.transactionType == transactionType) &&
        (orderState == null || this.orderState == orderState);
  }

  /// String representation of the object
  @override
  String toString() {
    return 'OrderSummary(orderId: $orderId, userId: $userId, address: $address, region: $region, '
        'userName: $userName, addressId: $addressId, orderCreatedAt: $orderCreatedAt, itemId: $itemId, '
        'itemName: $itemName, imageUrl: $imageUrl, itemPrice: $itemPrice, itemStockQuantity: $itemStockQuantity, '
        'previousQuantity: $previousQuantity, nextQuantity: $nextQuantity, transactionQuantity: $transactionQuantity, '
        'transactionType: $transactionType, orderState: $orderState)';
  }
}
