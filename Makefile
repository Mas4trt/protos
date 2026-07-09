PROTO_DIR=proto
GEN_DIR=gen/go

.PHONY: proto

proto:
	@protoc -I $(PROTO_DIR) \
		$(PROTO_DIR)/auth/v1/auth.proto \
		--go_out=$(GEN_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_out=$(GEN_DIR) \
		--go-grpc_opt=paths=source_relative