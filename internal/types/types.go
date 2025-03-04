package types

type Config struct {
	AppEnv       string `env:"APP_ENV"`
	DbServiceUrl string `env:"DB_SERVICE_URL"`
}
