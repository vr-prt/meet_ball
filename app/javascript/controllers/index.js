// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import GameFormController from "./game_form_controller"
application.register("game-form", GameFormController)

import GameShowController from "./game_show_controller"
application.register("game-show", GameShowController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import TomSelectController from "./tom_select_controller"
application.register("tom-select", TomSelectController)
