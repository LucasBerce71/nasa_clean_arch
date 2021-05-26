import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/errors/failures.dart';
import 'package:app/features/data/datasource/space_media_datasource.dart';
import 'package:app/features/data/models/space_media_model.dart';
import 'package:app/features/data/repositories/space_media_repository_implementation.dart';
import 'package:app/features/domain/entities/space_media_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaDataSource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDataSource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'description test',
    mediaType: 'mediaType test',
    title: 'title test',
    mediaUrl: 'mediaUrl test',
  );

  final tDate = DateTime(2021, 02, 02);

  test('should return space media model when calls the datasource', () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Right<Failure, SpaceMediaEntity>(tSpaceMediaModel));
    verify(() => datasource);
  });

  test('should return a serer failure when the call to datasource is unsucessful', () async {
    // Arrange 
    when(() => datasource).thenThrow(ServerException());
    // Act 
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource);
  });
}
