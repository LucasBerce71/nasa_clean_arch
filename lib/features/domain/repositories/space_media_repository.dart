import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failures.dart';
import 'package:app/features/domain/entities/space_media_entity.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date);
}