-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/controller/DivinehopeController.lua

module("logic.extensions.divinehope.controller.DivinehopeController", package.seeall)

local DivinehopeController = class("DivinehopeController", BaseController)

function DivinehopeController:ctor()
	return
end

function DivinehopeController:onInit()
	self:onReset()
end

function DivinehopeController:onReset()
	return
end

function DivinehopeController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(254)
end

DivinehopeController.instance = DivinehopeController.New()

return DivinehopeController
