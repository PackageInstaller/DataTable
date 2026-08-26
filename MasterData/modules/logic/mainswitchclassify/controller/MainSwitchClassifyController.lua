-- chunkname: @modules/logic/mainswitchclassify/controller/MainSwitchClassifyController.lua

module("modules.logic.mainswitchclassify.controller.MainSwitchClassifyController", package.seeall)

local MainSwitchClassifyController = class("MainSwitchClassifyController", BaseController)

MainSwitchClassifyController.instance = MainSwitchClassifyController.New()

return MainSwitchClassifyController
