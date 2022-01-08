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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the History type in your schema. */
@immutable
class History extends Model {
  static const classType = const _HistoryModelType();
  final String id;
  final String? _queuerId;
  final String? _officeQueueId;
  final TemporalDateTime? _enqueueTime;
  final TemporalDateTime? _dequeueTime;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get queuerId {
    return _queuerId;
  }
  
  String? get officeQueueId {
    return _officeQueueId;
  }
  
  TemporalDateTime? get enqueueTime {
    return _enqueueTime;
  }
  
  TemporalDateTime? get dequeueTime {
    return _dequeueTime;
  }
  
  const History._internal({required this.id, queuerId, officeQueueId, enqueueTime, dequeueTime}): _queuerId = queuerId, _officeQueueId = officeQueueId, _enqueueTime = enqueueTime, _dequeueTime = dequeueTime;
  
  factory History({String? id, String? queuerId, String? officeQueueId, TemporalDateTime? enqueueTime, TemporalDateTime? dequeueTime}) {
    return History._internal(
      id: id == null ? UUID.getUUID() : id,
      queuerId: queuerId,
      officeQueueId: officeQueueId,
      enqueueTime: enqueueTime,
      dequeueTime: dequeueTime);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is History &&
      id == other.id &&
      _queuerId == other._queuerId &&
      _officeQueueId == other._officeQueueId &&
      _enqueueTime == other._enqueueTime &&
      _dequeueTime == other._dequeueTime;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("History {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("queuerId=" + "$_queuerId" + ", ");
    buffer.write("officeQueueId=" + "$_officeQueueId" + ", ");
    buffer.write("enqueueTime=" + (_enqueueTime != null ? _enqueueTime!.format() : "null") + ", ");
    buffer.write("dequeueTime=" + (_dequeueTime != null ? _dequeueTime!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  History copyWith({String? id, String? queuerId, String? officeQueueId, TemporalDateTime? enqueueTime, TemporalDateTime? dequeueTime}) {
    return History(
      id: id ?? this.id,
      queuerId: queuerId ?? this.queuerId,
      officeQueueId: officeQueueId ?? this.officeQueueId,
      enqueueTime: enqueueTime ?? this.enqueueTime,
      dequeueTime: dequeueTime ?? this.dequeueTime);
  }
  
  History.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _queuerId = json['queuerId'],
      _officeQueueId = json['officeQueueId'],
      _enqueueTime = json['enqueueTime'] != null ? TemporalDateTime.fromString(json['enqueueTime']) : null,
      _dequeueTime = json['dequeueTime'] != null ? TemporalDateTime.fromString(json['dequeueTime']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'queuerId': _queuerId, 'officeQueueId': _officeQueueId, 'enqueueTime': _enqueueTime?.format(), 'dequeueTime': _dequeueTime?.format()
  };

  static final QueryField ID = QueryField(fieldName: "history.id");
  static final QueryField QUEUERID = QueryField(fieldName: "queuerId");
  static final QueryField OFFICEQUEUEID = QueryField(fieldName: "officeQueueId");
  static final QueryField ENQUEUETIME = QueryField(fieldName: "enqueueTime");
  static final QueryField DEQUEUETIME = QueryField(fieldName: "dequeueTime");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "History";
    modelSchemaDefinition.pluralName = "Histories";
    
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
      key: History.QUEUERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: History.OFFICEQUEUEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: History.ENQUEUETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: History.DEQUEUETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _HistoryModelType extends ModelType<History> {
  const _HistoryModelType();
  
  @override
  History fromJson(Map<String, dynamic> jsonData) {
    return History.fromJson(jsonData);
  }
}