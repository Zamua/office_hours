/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the OfficeQueue type in your schema. */
@immutable
class OfficeQueue extends Model {
  static const classType = const _OfficeQueueModelType();
  final String id;
  final String? _name;
  final List<QueuerOfficeQueue>? _queuers;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  List<QueuerOfficeQueue>? get queuers {
    return _queuers;
  }
  
  const OfficeQueue._internal({required this.id, name, queuers}): _name = name, _queuers = queuers;
  
  factory OfficeQueue({String? id, String? name, List<QueuerOfficeQueue>? queuers}) {
    return OfficeQueue._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      queuers: queuers != null ? List<QueuerOfficeQueue>.unmodifiable(queuers) : queuers);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OfficeQueue &&
      id == other.id &&
      _name == other._name &&
      DeepCollectionEquality().equals(_queuers, other._queuers);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("OfficeQueue {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  OfficeQueue copyWith({String? id, String? name, List<QueuerOfficeQueue>? queuers}) {
    return OfficeQueue(
      id: id ?? this.id,
      name: name ?? this.name,
      queuers: queuers ?? this.queuers);
  }
  
  OfficeQueue.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _queuers = json['queuers'] is List
        ? (json['queuers'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => QueuerOfficeQueue.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'queuers': _queuers?.map((QueuerOfficeQueue? e) => e?.toJson()).toList()
  };

  static final QueryField ID = QueryField(fieldName: "officeQueue.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField QUEUERS = QueryField(
    fieldName: "queuers",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (QueuerOfficeQueue).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "OfficeQueue";
    modelSchemaDefinition.pluralName = "OfficeQueues";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: OfficeQueue.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: OfficeQueue.QUEUERS,
      isRequired: false,
      ofModelName: (QueuerOfficeQueue).toString(),
      associatedKey: QueuerOfficeQueue.OFFICEQUEUE
    ));
  });
}

class _OfficeQueueModelType extends ModelType<OfficeQueue> {
  const _OfficeQueueModelType();
  
  @override
  OfficeQueue fromJson(Map<String, dynamic> jsonData) {
    return OfficeQueue.fromJson(jsonData);
  }
}