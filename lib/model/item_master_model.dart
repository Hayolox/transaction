// To parse this JSON data, do
//
//     final itemMaterModel = itemMaterModelFromJson(jsonString);

import 'dart:convert';

ItemMaterModel itemMaterModelFromJson(String str) =>
    ItemMaterModel.fromJson(json.decode(str));

String itemMaterModelToJson(ItemMaterModel data) => json.encode(data.toJson());

class ItemMaterModel {
  int? id;
  int? subItemId;
  String? itemNo;
  String? itemName;
  String? itemPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  SubItem? subItem;

  ItemMaterModel({
    this.id,
    this.subItemId,
    this.itemNo,
    this.itemName,
    this.itemPrice,
    this.createdAt,
    this.updatedAt,
    this.subItem,
  });

  factory ItemMaterModel.fromJson(Map<String, dynamic> json) => ItemMaterModel(
        id: json["id"],
        subItemId: json["sub_item_id"],
        itemNo: json["item_no"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        subItem: json["sub_item"] == null
            ? null
            : SubItem.fromJson(json["sub_item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_item_id": subItemId,
        "item_no": itemNo,
        "item_name": itemName,
        "item_price": itemPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sub_item": subItem?.toJson(),
      };
}

class SubItem {
  int? id;
  String? subCode;
  String? subName;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubItem({
    this.id,
    this.subCode,
    this.subName,
    this.createdAt,
    this.updatedAt,
  });

  factory SubItem.fromJson(Map<String, dynamic> json) => SubItem(
        id: json["id"],
        subCode: json["sub_code"],
        subName: json["sub_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_code": subCode,
        "sub_name": subName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
