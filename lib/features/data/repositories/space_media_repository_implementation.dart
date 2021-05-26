import 'package:app/core/errors/exceptions.dart';
import 'package:app/features/data/datasource/space_media_datasource.dart';
import 'package:app/features/domain/entities/space_media_entity.dart';
import 'package:app/core/errors/failures.dart';
import 'package:app/features/domain/repositories/space_media_repository.dart';
import 'package:dartz/dartz.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
