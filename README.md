# SSO Protocol Buffer Definitions

This repository contains Protocol Buffer (protobuf) definitions for the SSO (Single Sign-On) service. It provides gRPC APIs for user authentication, registration, and role management.

## 📋 Overview

The SSO service handles core authentication operations including user registration, login with JWT token issuance, and role-based access control queries.

## 🏗️ Service Definition

### Auth Service

| Method | Description | Request | Response |
|--------|-------------|---------|----------|
| `Register` | Registers a new user with email and password | `RegisterRequest` | `RegisterResponse` |
| `Authenticate` | Authenticates user credentials and returns JWT tokens | `LoginRequest` | `LoginResponse` |
| `GetRole` | Retrieves the role of a specified user | `GetRoleRequest` | `GetRoleResponse` |

## 📦 Messages

### User

```protobuf
message User {
    uint64 id = 1;
    string email = 2;
}