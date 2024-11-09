sealed class ApiResponse<T> {
  const ApiResponse();
}

class Success<T> extends ApiResponse<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends ApiResponse<T> {
  final String message;
  const Error(this.message);
}

