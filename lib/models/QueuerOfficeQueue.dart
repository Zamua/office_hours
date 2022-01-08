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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the QueuerOfficeQueue type in your schema. */
@immutable
class QueuerOfficeQueue extends Model {
  static const classType = const _QueuerOfficeQueueModelType();
  final String id;
  final Queuer? _queuer;
  final OfficeQueue? _officequeue;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Queuer get queuer {
    try {
      return _queuer!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  OfficeQueue get officequeue {
    try {
      return _officequeue!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const QueuerOfficeQueue._internal({required this.id, required queuer, required officequeue}): _queuer = queuer, _officequeue = officequeue;
  
  factory QueuerOfficeQueue({String? id, required Queuer queuer, required OfficeQueue officequeue}) {
    return QueuerOfficeQueue._internal(
      id: id == null ? UUID.getUUID() : id,
      queuer: queuer,
      officequeue: officequeue);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueuerOfficeQueue &&
      id == other.id &&
      _queuer == other._queuer &&
      _officequeue == other._officequeue;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("QueuerOfficeQueue {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("queuer=" + (_queuer != null ? _queuer!.toString() : "null") + ", ");
    buffer.write("officequeue=" + (_officequeue != null ? _officequeue!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  QueuerOfficeQueue copyWith({String? id, Queuer? queuer, OfficeQueue? officequeue}) {
    return QueuerOfficeQueue(
      id: id ?? this.id,
      queuer: queuer ?? this.queuer,
      officequeue: officequeue ?? this.officequeue);
  }
  
  QueuerOfficeQueue.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _queuer = json['queuer']?['serializedData'] != null
        ? Queuer.fromJson(new Map<String, dynamic>.from(json['queuer']['serializedData']))
        : null,
      _officequeue = json['officequeue']?['serializedData'] != null
        ? OfficeQueue.fromJson(new Map<String, dynamic>.from(json['officequeue']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'queuer': _queuer?.toJson(), 'officequeue': _officequeue?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "queuerOfficeQueue.id");
  static final QueryField QUEUER = QueryField(
    fieldName: "queuer",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Queuer).toString()));
  static final QueryField OFFICEQUEUE = QueryField(
    fieldName: "officequeue",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (OfficeQueue).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "QueuerOfficeQueue";
    modelSchemaDefinition.pluralName = "QueuerOfficeQueues";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: QueuerOfficeQueue.QUEUER,
      isRequired: true,
      targetName: "queuerID",
      ofModelName: (Queuer).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: QueuerOfficeQueue.OFFICEQUEUE,
      isRequired: true,
      targetName: "officequeueID",
      ofModelName: (OfficeQueue).toString()
    ));
  });
}

class _QueuerOfficeQueueModelType extends ModelType<QueuerOfficeQueue> {
  const _QueuerOfficeQueueModelType();
  
  @override
  QueuerOfficeQueue fromJson(Map<String, dynamic> jsonData) {
    return QueuerOfficeQueue.fromJson(jsonData);
  }
}