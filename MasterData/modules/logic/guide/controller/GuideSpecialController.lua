-- chunkname: @modules/logic/guide/controller/GuideSpecialController.lua

module("modules.logic.guide.controller.GuideSpecialController", package.seeall)

local GuideSpecialController = class("GuideSpecialController", BaseController)

function GuideSpecialController:onInitFinish()
	self._guideJumpHandler = GuideJumpHandler.New()
end

function GuideSpecialController:reInit()
	self._guideJumpHandler:reInit()
end

GuideSpecialController.instance = GuideSpecialController.New()

return GuideSpecialController
