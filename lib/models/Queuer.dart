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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Queuer type in your schema. */
@immutable
class Queuer extends Model {
  static const classType = const _QueuerModelType();
  final String id;
  final String? _name;
  final List<String>? _officeQueueIds;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  List<String>? get officeQueueIds {
    return _officeQueueIds;
  }
  
  const Queuer._internal({required this.id, name, officeQueueIds}): _name = name, _officeQueueIds = officeQueueIds;
  
  factory Queuer({String? id, String? name, List<String>? officeQueueIds}) {
    return Queuer._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      officeQueueIds: officeQueueIds != null ? List<String>.unmodifiable(officeQueueIds) : officeQueueIds);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Queuer &&
      id == other.id &&
      _name == other._name &&
      DeepCollectionEquality().equals(_officeQueueIds, other._officeQueueIds);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Queuer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("officeQueueIds=" + (_officeQueueIds != null ? _officeQueueIds!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Queuer copyWith({String? id, String? name, List<String>? officeQueueIds}) {
    return Queuer(
      id: id ?? this.id,
      name: name ?? this.name,
      officeQueueIds: officeQueueIds ?? this.officeQueueIds);
  }
  
  Queuer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _officeQueueIds = json['officeQueueIds']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'officeQueueIds': _officeQueueIds
  };

  static final QueryField ID = QueryField(fieldName: "queuer.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField OFFICEQUEUEIDS = QueryField(fieldName: "officeQueueIds");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Queuer";
    modelSchemaDefinition.pluralName = "Queuers";
    
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
      key: Queuer.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Queuer.OFFICEQUEUEIDS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}

class _QueuerModelType extends ModelType<Queuer> {
  const _QueuerModelType();
  
  @override
  Queuer fromJson(Map<String, dynamic> jsonData) {
    return Queuer.fromJson(jsonData);
  }
}