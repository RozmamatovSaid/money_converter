sealed class Either<L, R> {
  const Either();

  const factory Either.left(L value) = Left<L, R>;
  const factory Either.right(R value) = Right<L, R>;

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L? get leftOrNull => switch (this) {
    Left(value: final value) => value,
    Right() => null,
  };

  R? get rightOrNull => switch (this) {
    Left() => null,
    Right(value: final value) => value,
  };

  L get left => leftOrNull ?? (throw StateError('Tried to read Left from a Right value.'));
  R get right => rightOrNull ?? (throw StateError('Tried to read Right from a Left value.'));

  T fold<T>({required T Function(L left) onLeft, required T Function(R right) onRight}) => switch (this) {
    Left(value: final value) => onLeft(value),
    Right(value: final value) => onRight(value),
  };

  Either<L2, R> mapLeft<L2>(L2 Function(L left) mapper) => switch (this) {
    Left(value: final value) => Either.left(mapper(value)),
    Right(value: final value) => Either.right(value),
  };

  Either<L, R2> map<R2>(R2 Function(R right) mapper) => switch (this) {
    Left(value: final value) => Either.left(value),
    Right(value: final value) => Either.right(mapper(value)),
  };

  Either<L, R2> flatMap<R2>(Either<L, R2> Function(R right) mapper) => switch (this) {
    Left(value: final value) => Either.left(value),
    Right(value: final value) => mapper(value),
  };

  Either<R, L> swap() => switch (this) {
    Left(value: final value) => Either.right(value),
    Right(value: final value) => Either.left(value),
  };

  R getOrElse(R Function(L left) orElse) => switch (this) {
    Left(value: final value) => orElse(value),
    Right(value: final value) => value,
  };
}

final class Left<L, R> extends Either<L, R> {
  const Left(this.value);

  final L value;

  @override
  bool operator ==(Object other) => other is Left<L, R> && other.value == value;

  @override
  int get hashCode => Object.hash(Left<L, R>, value);

  @override
  String toString() => 'Left($value)';
}

final class Right<L, R> extends Either<L, R> {
  const Right(this.value);

  final R value;

  @override
  bool operator ==(Object other) => other is Right<L, R> && other.value == value;

  @override
  int get hashCode => Object.hash(Right<L, R>, value);

  @override
  String toString() => 'Right($value)';
}
