package main

import (
	"context"
	"log/slog"
	"os"
	"time"

	"github.com/caarlos0/env/v10"
	"github.com/dead-letter/dead-letter-business-auth/internal/types"
	"github.com/dead-letter/dead-letter-business-auth/pkg/pb"
	"github.com/joho/godotenv"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/alts"
)

var logger *slog.Logger
var config types.Config
var opts []grpc.DialOption

func main() {
	logger = slog.New(slog.NewTextHandler(os.Stdout, nil))
	slog.SetDefault(logger)

	ctx := context.Background()

	if _, err := os.Stat(".env"); err == nil {
		if err := godotenv.Load(); err != nil {
			logger.Error("error loading .env", "err", err)
			return
		}
	}

	if err := env.Parse(&config); err != nil {
		logger.Error("error parsing environment variables", "err", err)
		return
	}

	altsTC := alts.NewClientCreds(alts.DefaultClientOptions())
	opts = append(opts, grpc.WithTransportCredentials(altsTC))

	conn, err := grpc.NewClient(config.DbServiceUrl, opts...)
	if err != nil {
		logger.Error("error connecting to db service", "err", err)
		return
	}
	defer conn.Close()

	vendorClient := pb.NewVendorServiceClient(conn)

	_, err = vendorClient.CreateVendor(ctx, &pb.CreateVendorRequest{
		Id: "417e29a8-3ac6-47da-8f50-b4d784472ec6",
	})
	if err != nil {
		logger.Error("error creating test vendor", "err", err)
		return
	}

	time.Sleep(1 * time.Minute)
}
