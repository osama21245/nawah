// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemLogsModel {
  final int? userId;
  final int? itemId;
  final String? itemName;
  final String? itemImage;
  final int? previousQuantity;
  final int? transactionQuantity;
  final int? nextQuantity;
  final String? transactionType;
  final DateTime? createdAt;
  ItemLogsModel({
    this.userId,
    this.itemId,
    this.itemName,
    this.itemImage,
    this.previousQuantity,
    this.transactionQuantity,
    this.nextQuantity,
    this.transactionType,
    this.createdAt,
  });

  ItemLogsModel copyWith({
    int? userId,
    int? itemId,
    String? itemName,
    String? itemImage,
    int? previousQuantity,
    int? transactionQuantity,
    int? nextQuantity,
    String? transactionType,
    DateTime? createdAt,
  }) {
    return ItemLogsModel(
      userId: userId ?? this.userId,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemImage: itemImage ?? this.itemImage,
      previousQuantity: previousQuantity ?? this.previousQuantity,
      transactionQuantity: transactionQuantity ?? this.transactionQuantity,
      nextQuantity: nextQuantity ?? this.nextQuantity,
      transactionType: transactionType ?? this.transactionType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'item_id': itemId,
      'item_name': itemName,
      'item_image': itemImage,
      'previous_quantity': previousQuantity,
      'transaction_quantity': transactionQuantity,
      'next_quantity': nextQuantity,
      'transaction_type': transactionType,
      'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory ItemLogsModel.fromMap(Map<String, dynamic> map) {
    return ItemLogsModel(
      userId: map['user_id'] as int? ?? 0,
      itemId: map['item_id'] as int? ?? 0,
      itemName: map['item_name'] as String? ?? "",
      itemImage: map['item_image'] as String? ?? "",
      previousQuantity: map['previous_quantity'] as int? ?? 0,
      transactionQuantity: map['transaction_quantity'] as int? ?? 0,
      nextQuantity: map['next_quantity'] as int? ?? 0,
      transactionType: map['transaction_type'] as String? ?? "",
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemLogsModel.fromJson(String source) =>
      ItemLogsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemLogsModel(userId: $userId, itemId: $itemId, itemName: $itemName, itemImage: $itemImage, previousQuantity: $previousQuantity, transactionQuantity: $transactionQuantity, nextQuantity: $nextQuantity, transactionType: $transactionType, created_at: $createdAt)';
  }

  @override
  bool operator ==(covariant ItemLogsModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.itemId == itemId &&
        other.itemName == itemName &&
        other.itemImage == itemImage &&
        other.previousQuantity == previousQuantity &&
        other.transactionQuantity == transactionQuantity &&
        other.nextQuantity == nextQuantity &&
        other.transactionType == transactionType &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        itemId.hashCode ^
        itemName.hashCode ^
        itemImage.hashCode ^
        previousQuantity.hashCode ^
        transactionQuantity.hashCode ^
        nextQuantity.hashCode ^
        transactionType.hashCode ^
        createdAt.hashCode;
  }
}
