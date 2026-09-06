-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/StarGodPlusExchange/controller/StarGodPlusExchangController.lua

module("logic.extensions.stargodplusexchange.controller.StarGodPlusExchangController", package.seeall)

local StarGodPlusExchangController = class("StarGodPlusExchangController", BaseController)

function StarGodPlusExchangController:ctor()
	StarGodPlusExchangController.super.ctor(self)
end

function StarGodPlusExchangController:onInit()
	self:onReset()
end

function StarGodPlusExchangController:onReset()
	return
end

function StarGodPlusExchangController:getInfo()
	StarGodPlusExchangeAgent.instance:sendPM_StarGodPlusExchangeInfoReq()
end

function StarGodPlusExchangController:exchange(idList)
	StarGodPlusExchangeAgent.instance:sendPM_StarGodPlusExchangeReq(idList)
end

StarGodPlusExchangController.instance = StarGodPlusExchangController.New()

return StarGodPlusExchangController
