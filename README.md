# SSO Protocol Buffers

Shared Protocol Buffer definitions for the SSO (Single Sign-On) ecosystem.

This repository contains versioned gRPC contracts used by all services interacting with the authentication system. It is the single source of truth for API definitions and generated Go bindings.

---

## Features

- Versioned gRPC API (`auth.v1`)
- Protocol Buffer definitions
- Generated Go protobuf models
- Generated Go gRPC client/server interfaces
- Centralized API contract for all services
- Ready for multi-service and multi-language environments

---

## Repository Structure

```
.
├── proto/
│   └── auth/
│       └── v1/
│           └── auth.proto        # API contract
│
├── gen/
│   └── go/
│       └── auth/
│           └── v1/
│               ├── auth.pb.go
│               └── auth_grpc.pb.go
│
├── Makefile
├── go.mod
└── README.md
```

---

# Service

## Auth

The `Auth` service is responsible for authentication and authorization related operations.

| RPC | Description |
|-----|-------------|
| Register | Creates a new user |
| Authenticate | Authenticates user credentials |
| RefreshTokens | Issues a new access token using a refresh token |
| Logout | Invalidates a refresh token |
| GetRole | Returns the role of a user |

---

# API

## Register

Registers a new user.

### Request

```protobuf
message RegisterRequest {
    string email = 1;
    string password = 2;
}
```

### Response

```protobuf
message RegisterResponse {
    uint64 user_id = 1;
}
```

---

## Authenticate

Authenticates user credentials and returns a pair of JWT tokens.

### Request

```protobuf
message LoginRequest {
    string email = 1;
    string password = 2;
    uint64 application_id = 3;
}
```

### Response

```protobuf
message LoginResponse {
    string access_token = 1;
    string refresh_token = 2;
}
```

---

## RefreshTokens

Issues a new access token using a valid refresh token.

### Request

```protobuf
message RefreshTokensRequest {
    string refresh_token = 1;
    uint64 application_id = 2;
}
```

### Response

```protobuf
message LoginResponse {
    string access_token = 1;
    string refresh_token = 2;
}
```

---

## Logout

Revokes a refresh token.

### Request

```protobuf
message LogoutRequest {
    string refresh_token = 1;
}
```

### Response

```protobuf
message LogoutResponse {
    bool success = 1;
}
```

---

## GetRole

Returns the role assigned to a user.

### Request

```protobuf
message GetRoleRequest {
    uint64 user_id = 1;
}
```

### Response

```protobuf
message GetRoleResponse {
    Role role = 1;
}
```

---

# Models

## User

Represents an authenticated user.

```protobuf
message User {
    uint64 id = 1;
    string email = 2;
}
```

---

## Role

```protobuf
enum Role {
    ROLE_UNSPECIFIED = 0;
    ROLE_USER = 1;
    ROLE_ADMIN = 2;
}
```

| Value | Description |
|--------|-------------|
| ROLE_UNSPECIFIED | Unknown role |
| ROLE_USER | Regular user |
| ROLE_ADMIN | Administrator |

---

# Code Generation

## Requirements

- Protocol Buffers compiler (`protoc`)
- `protoc-gen-go`
- `protoc-gen-go-grpc`

Install plugins:

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

Generate Go code:

```bash
make proto
```

or manually

```bash
protoc \
  -I proto \
  proto/auth/v1/auth.proto \
  --go_out=gen/go \
  --go_opt=paths=source_relative \
  --go-grpc_out=gen/go \
  --go-grpc_opt=paths=source_relative
```

---

# Usage

Install the module:

```bash
go get github.com/Mas4trt/protos
```

Import generated package:

```go
import authv1 "github.com/Mas4trt/protos/gen/go/auth/v1"
```

Create a client:

```go
client := authv1.NewAuthClient(conn)
```

Implement a server:

```go
type Server struct {
    authv1.UnimplementedAuthServer
}
```

Register it:

```go
authv1.RegisterAuthServer(grpcServer, server)
```

---

# Versioning

API follows semantic versioning.

New backward-compatible functionality should be added within the current version (`auth.v1`).

Breaking changes require introducing a new package version, for example:

```
auth.v2
```

instead of modifying existing messages or RPC methods.

---

# Compatibility

Generated Go code targets:

- Go 1.26+
- protobuf
- gRPC-Go

Other languages can generate bindings directly from `proto/auth/v1/auth.proto`.

---

# Contributing

When modifying the API:

1. Update `proto/auth/v1/auth.proto`.
2. Regenerate bindings.

```bash
make proto
```

3. Commit both the `.proto` file and generated sources.
4. Avoid breaking existing contracts.
5. Introduce a new API version for incompatible changes.

---

# License

This repository contains shared API contracts used by the SSO platform.