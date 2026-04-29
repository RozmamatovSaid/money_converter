enum Status {
  initial,
  loading,
  success,
  error,
  paginate;

  bool get isLoading => this == Status.loading;

  bool get isInitial => this == Status.initial;

  bool get isSuccess => this == Status.success;

  bool get isError => this == Status.error;

  bool get isPaginate => this == Status.paginate;
}
