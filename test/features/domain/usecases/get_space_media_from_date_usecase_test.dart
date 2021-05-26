import 'package:app/core/errors/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/domain/entities/space_media_entity.dart';
import 'package:app/features/domain/repositories/space_media_repository.dart';
import 'package:app/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}
void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  final tSpaceMedia = SpaceMediaEntity(
    description: 'Description test', 
    mediaType: 'image test', 
    title: 'title test', 
    mediaUrl: 'mediaUrl tests'
  );

  final tDate = DateTime(2021, 02, 02);

  test('should get space media entity for a given date from the repository', () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer((_) async => Right<Failure, SpaceMediaEntity>(tSpaceMedia));

    final result = await usecase(tDate);
    expect(result, Right<Failure, SpaceMediaEntity>(tSpaceMedia));
    verify(() => repository);
  });

    test('should return a ServerFailure when don\'t succeed', () async {
      // Arrange  
      when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer((_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));
      // Act
      final result = await usecase(tDate);
      // Assert
      expect(result, Left(ServerFailure()));
      verify(() => repository);
  });
}