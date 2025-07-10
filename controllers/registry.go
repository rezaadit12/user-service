package controllers

import (
	controllers "user-service/controllers/user"
	"user-service/services"
)

type Register struct {
	service services.IServiceRegistry
}

type IControllerRegistry interface {
	GetUserController() controllers.IUserController
}

func NewControllerRegistry(service services.IServiceRegistry) IControllerRegistry {
	return &Register{service: service}
}

func (u *Register) GetUserController() controllers.IUserController {
	return controllers.NewUserController(u.service)
}
