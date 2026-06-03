// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGameSessionModelCollection on Isar {
  IsarCollection<GameSessionModel> get gameSessionModels => this.collection();
}

const GameSessionModelSchema = CollectionSchema(
  name: r'GameSessionModel',
  id: -6004531957099909852,
  properties: {
    r'actions': PropertySchema(
      id: 0,
      name: r'actions',
      type: IsarType.objectList,
      target: r'ActionRecord',
    ),
    r'endTime': PropertySchema(
      id: 1,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'gameId': PropertySchema(
      id: 2,
      name: r'gameId',
      type: IsarType.string,
    ),
    r'isGameOver': PropertySchema(
      id: 3,
      name: r'isGameOver',
      type: IsarType.bool,
    ),
    r'players': PropertySchema(
      id: 4,
      name: r'players',
      type: IsarType.objectList,
      target: r'PlayerRecord',
    ),
    r'startTime': PropertySchema(
      id: 5,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'winnerId': PropertySchema(
      id: 6,
      name: r'winnerId',
      type: IsarType.string,
    )
  },
  estimateSize: _gameSessionModelEstimateSize,
  serialize: _gameSessionModelSerialize,
  deserialize: _gameSessionModelDeserialize,
  deserializeProp: _gameSessionModelDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'gameId': IndexSchema(
      id: -1012023815008531514,
      name: r'gameId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'gameId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'PlayerRecord': PlayerRecordSchema,
    r'ActionRecord': ActionRecordSchema
  },
  getId: _gameSessionModelGetId,
  getLinks: _gameSessionModelGetLinks,
  attach: _gameSessionModelAttach,
  version: '3.1.0+1',
);

int _gameSessionModelEstimateSize(
  GameSessionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.actions.length * 3;
  {
    final offsets = allOffsets[ActionRecord]!;
    for (var i = 0; i < object.actions.length; i++) {
      final value = object.actions[i];
      bytesCount += ActionRecordSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.gameId.length * 3;
  bytesCount += 3 + object.players.length * 3;
  {
    final offsets = allOffsets[PlayerRecord]!;
    for (var i = 0; i < object.players.length; i++) {
      final value = object.players[i];
      bytesCount += PlayerRecordSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.winnerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _gameSessionModelSerialize(
  GameSessionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<ActionRecord>(
    offsets[0],
    allOffsets,
    ActionRecordSchema.serialize,
    object.actions,
  );
  writer.writeDateTime(offsets[1], object.endTime);
  writer.writeString(offsets[2], object.gameId);
  writer.writeBool(offsets[3], object.isGameOver);
  writer.writeObjectList<PlayerRecord>(
    offsets[4],
    allOffsets,
    PlayerRecordSchema.serialize,
    object.players,
  );
  writer.writeDateTime(offsets[5], object.startTime);
  writer.writeString(offsets[6], object.winnerId);
}

GameSessionModel _gameSessionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GameSessionModel();
  object.actions = reader.readObjectList<ActionRecord>(
        offsets[0],
        ActionRecordSchema.deserialize,
        allOffsets,
        ActionRecord(),
      ) ??
      [];
  object.endTime = reader.readDateTimeOrNull(offsets[1]);
  object.gameId = reader.readString(offsets[2]);
  object.isGameOver = reader.readBool(offsets[3]);
  object.isarId = id;
  object.players = reader.readObjectList<PlayerRecord>(
        offsets[4],
        PlayerRecordSchema.deserialize,
        allOffsets,
        PlayerRecord(),
      ) ??
      [];
  object.startTime = reader.readDateTime(offsets[5]);
  object.winnerId = reader.readStringOrNull(offsets[6]);
  return object;
}

P _gameSessionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<ActionRecord>(
            offset,
            ActionRecordSchema.deserialize,
            allOffsets,
            ActionRecord(),
          ) ??
          []) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readObjectList<PlayerRecord>(
            offset,
            PlayerRecordSchema.deserialize,
            allOffsets,
            PlayerRecord(),
          ) ??
          []) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _gameSessionModelGetId(GameSessionModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _gameSessionModelGetLinks(GameSessionModel object) {
  return [];
}

void _gameSessionModelAttach(
    IsarCollection<dynamic> col, Id id, GameSessionModel object) {
  object.isarId = id;
}

extension GameSessionModelByIndex on IsarCollection<GameSessionModel> {
  Future<GameSessionModel?> getByGameId(String gameId) {
    return getByIndex(r'gameId', [gameId]);
  }

  GameSessionModel? getByGameIdSync(String gameId) {
    return getByIndexSync(r'gameId', [gameId]);
  }

  Future<bool> deleteByGameId(String gameId) {
    return deleteByIndex(r'gameId', [gameId]);
  }

  bool deleteByGameIdSync(String gameId) {
    return deleteByIndexSync(r'gameId', [gameId]);
  }

  Future<List<GameSessionModel?>> getAllByGameId(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'gameId', values);
  }

  List<GameSessionModel?> getAllByGameIdSync(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'gameId', values);
  }

  Future<int> deleteAllByGameId(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'gameId', values);
  }

  int deleteAllByGameIdSync(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'gameId', values);
  }

  Future<Id> putByGameId(GameSessionModel object) {
    return putByIndex(r'gameId', object);
  }

  Id putByGameIdSync(GameSessionModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'gameId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGameId(List<GameSessionModel> objects) {
    return putAllByIndex(r'gameId', objects);
  }

  List<Id> putAllByGameIdSync(List<GameSessionModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'gameId', objects, saveLinks: saveLinks);
  }
}

extension GameSessionModelQueryWhereSort
    on QueryBuilder<GameSessionModel, GameSessionModel, QWhere> {
  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GameSessionModelQueryWhere
    on QueryBuilder<GameSessionModel, GameSessionModel, QWhereClause> {
  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhereClause>
      gameIdEqualTo(String gameId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'gameId',
        value: [gameId],
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterWhereClause>
      gameIdNotEqualTo(String gameId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [],
              upper: [gameId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [gameId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [gameId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [],
              upper: [gameId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension GameSessionModelQueryFilter
    on QueryBuilder<GameSessionModel, GameSessionModel, QFilterCondition> {
  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      actionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      actionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      actionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      actionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      actionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      actionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      endTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      endTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      endTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gameId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gameId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gameId',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      gameIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gameId',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      isGameOverEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGameOver',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      playersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'players',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      playersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'players',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      playersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'players',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      playersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'players',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      playersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'players',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      playersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'players',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'winnerId',
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'winnerId',
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'winnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'winnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'winnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'winnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'winnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'winnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'winnerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      winnerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'winnerId',
        value: '',
      ));
    });
  }
}

extension GameSessionModelQueryObject
    on QueryBuilder<GameSessionModel, GameSessionModel, QFilterCondition> {
  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      actionsElement(FilterQuery<ActionRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'actions');
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterFilterCondition>
      playersElement(FilterQuery<PlayerRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'players');
    });
  }
}

extension GameSessionModelQueryLinks
    on QueryBuilder<GameSessionModel, GameSessionModel, QFilterCondition> {}

extension GameSessionModelQuerySortBy
    on QueryBuilder<GameSessionModel, GameSessionModel, QSortBy> {
  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByGameId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByGameIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByIsGameOver() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameOver', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByIsGameOverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameOver', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByWinnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerId', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      sortByWinnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerId', Sort.desc);
    });
  }
}

extension GameSessionModelQuerySortThenBy
    on QueryBuilder<GameSessionModel, GameSessionModel, QSortThenBy> {
  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByGameId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByGameIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByIsGameOver() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameOver', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByIsGameOverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameOver', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByWinnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerId', Sort.asc);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QAfterSortBy>
      thenByWinnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerId', Sort.desc);
    });
  }
}

extension GameSessionModelQueryWhereDistinct
    on QueryBuilder<GameSessionModel, GameSessionModel, QDistinct> {
  QueryBuilder<GameSessionModel, GameSessionModel, QDistinct>
      distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QDistinct> distinctByGameId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gameId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QDistinct>
      distinctByIsGameOver() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGameOver');
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QDistinct>
      distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<GameSessionModel, GameSessionModel, QDistinct>
      distinctByWinnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'winnerId', caseSensitive: caseSensitive);
    });
  }
}

extension GameSessionModelQueryProperty
    on QueryBuilder<GameSessionModel, GameSessionModel, QQueryProperty> {
  QueryBuilder<GameSessionModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<GameSessionModel, List<ActionRecord>, QQueryOperations>
      actionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actions');
    });
  }

  QueryBuilder<GameSessionModel, DateTime?, QQueryOperations>
      endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<GameSessionModel, String, QQueryOperations> gameIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gameId');
    });
  }

  QueryBuilder<GameSessionModel, bool, QQueryOperations> isGameOverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGameOver');
    });
  }

  QueryBuilder<GameSessionModel, List<PlayerRecord>, QQueryOperations>
      playersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'players');
    });
  }

  QueryBuilder<GameSessionModel, DateTime, QQueryOperations>
      startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<GameSessionModel, String?, QQueryOperations> winnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'winnerId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PlayerRecordSchema = Schema(
  name: r'PlayerRecord',
  id: 2018535135121942839,
  properties: {
    r'isEliminated': PropertySchema(
      id: 0,
      name: r'isEliminated',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'playerId': PropertySchema(
      id: 2,
      name: r'playerId',
      type: IsarType.string,
    ),
    r'score': PropertySchema(
      id: 3,
      name: r'score',
      type: IsarType.long,
    ),
    r'turnOrder': PropertySchema(
      id: 4,
      name: r'turnOrder',
      type: IsarType.long,
    )
  },
  estimateSize: _playerRecordEstimateSize,
  serialize: _playerRecordSerialize,
  deserialize: _playerRecordDeserialize,
  deserializeProp: _playerRecordDeserializeProp,
);

int _playerRecordEstimateSize(
  PlayerRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.playerId.length * 3;
  return bytesCount;
}

void _playerRecordSerialize(
  PlayerRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isEliminated);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.playerId);
  writer.writeLong(offsets[3], object.score);
  writer.writeLong(offsets[4], object.turnOrder);
}

PlayerRecord _playerRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlayerRecord();
  object.isEliminated = reader.readBool(offsets[0]);
  object.name = reader.readString(offsets[1]);
  object.playerId = reader.readString(offsets[2]);
  object.score = reader.readLong(offsets[3]);
  object.turnOrder = reader.readLong(offsets[4]);
  return object;
}

P _playerRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PlayerRecordQueryFilter
    on QueryBuilder<PlayerRecord, PlayerRecord, QFilterCondition> {
  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      isEliminatedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEliminated',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      playerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playerId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> scoreEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition> scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      turnOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'turnOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      turnOrderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'turnOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      turnOrderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'turnOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayerRecord, PlayerRecord, QAfterFilterCondition>
      turnOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'turnOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlayerRecordQueryObject
    on QueryBuilder<PlayerRecord, PlayerRecord, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ActionRecordSchema = Schema(
  name: r'ActionRecord',
  id: 8828096003582419761,
  properties: {
    r'actionId': PropertySchema(
      id: 0,
      name: r'actionId',
      type: IsarType.string,
    ),
    r'actionType': PropertySchema(
      id: 1,
      name: r'actionType',
      type: IsarType.string,
    ),
    r'ballIndexBefore': PropertySchema(
      id: 2,
      name: r'ballIndexBefore',
      type: IsarType.long,
    ),
    r'expectedBallValue': PropertySchema(
      id: 3,
      name: r'expectedBallValue',
      type: IsarType.long,
    ),
    r'playerId': PropertySchema(
      id: 4,
      name: r'playerId',
      type: IsarType.string,
    ),
    r'playerName': PropertySchema(
      id: 5,
      name: r'playerName',
      type: IsarType.string,
    ),
    r'scoreDelta': PropertySchema(
      id: 6,
      name: r'scoreDelta',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 7,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'wrongBallValue': PropertySchema(
      id: 8,
      name: r'wrongBallValue',
      type: IsarType.long,
    )
  },
  estimateSize: _actionRecordEstimateSize,
  serialize: _actionRecordSerialize,
  deserialize: _actionRecordDeserialize,
  deserializeProp: _actionRecordDeserializeProp,
);

int _actionRecordEstimateSize(
  ActionRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.actionId.length * 3;
  bytesCount += 3 + object.actionType.length * 3;
  bytesCount += 3 + object.playerId.length * 3;
  bytesCount += 3 + object.playerName.length * 3;
  return bytesCount;
}

void _actionRecordSerialize(
  ActionRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.actionId);
  writer.writeString(offsets[1], object.actionType);
  writer.writeLong(offsets[2], object.ballIndexBefore);
  writer.writeLong(offsets[3], object.expectedBallValue);
  writer.writeString(offsets[4], object.playerId);
  writer.writeString(offsets[5], object.playerName);
  writer.writeLong(offsets[6], object.scoreDelta);
  writer.writeDateTime(offsets[7], object.timestamp);
  writer.writeLong(offsets[8], object.wrongBallValue);
}

ActionRecord _actionRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActionRecord();
  object.actionId = reader.readString(offsets[0]);
  object.actionType = reader.readString(offsets[1]);
  object.ballIndexBefore = reader.readLong(offsets[2]);
  object.expectedBallValue = reader.readLong(offsets[3]);
  object.playerId = reader.readString(offsets[4]);
  object.playerName = reader.readString(offsets[5]);
  object.scoreDelta = reader.readLong(offsets[6]);
  object.timestamp = reader.readDateTime(offsets[7]);
  object.wrongBallValue = reader.readLongOrNull(offsets[8]);
  return object;
}

P _actionRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ActionRecordQueryFilter
    on QueryBuilder<ActionRecord, ActionRecord, QFilterCondition> {
  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'actionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'actionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'actionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'actionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionId',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'actionId',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'actionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'actionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'actionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'actionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionType',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      actionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'actionType',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      ballIndexBeforeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ballIndexBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      ballIndexBeforeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ballIndexBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      ballIndexBeforeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ballIndexBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      ballIndexBeforeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ballIndexBefore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      expectedBallValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      expectedBallValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      expectedBallValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      expectedBallValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedBallValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerName',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      playerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playerName',
        value: '',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      scoreDeltaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scoreDelta',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      scoreDeltaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scoreDelta',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      scoreDeltaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scoreDelta',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      scoreDeltaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scoreDelta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      wrongBallValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wrongBallValue',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      wrongBallValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wrongBallValue',
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      wrongBallValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wrongBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      wrongBallValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wrongBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      wrongBallValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wrongBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<ActionRecord, ActionRecord, QAfterFilterCondition>
      wrongBallValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wrongBallValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActionRecordQueryObject
    on QueryBuilder<ActionRecord, ActionRecord, QFilterCondition> {}
