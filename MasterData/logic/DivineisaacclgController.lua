-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/controller/DivineisaacclgController.lua

module("logic.extensions.divineisaacclg.controller.DivineisaacclgController", package.seeall)

local DivineisaacclgController = class("DivineisaacclgController", BaseController)

function DivineisaacclgController:ctor()
	return
end

function DivineisaacclgController:onInit()
	self:onReset()
end

function DivineisaacclgController:onReset()
	return
end

function DivineisaacclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(236)
end

function DivineisaacclgController:getActivityType()
	return GameEnum.ActivityType.Divineisaacclg
end

function DivineisaacclgController:clgChallengeFinishRes(msg)
	self._finishMsg = msg

	BattleFacade.instance:registerResultHandler(self._onResultHandler, self)
end

function DivineisaacclgController:_onResultHandler()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local msg = self._finishMsg

	self._finishMsg = nil

	if msg then
		UIStateManager.instance:push(ViewName.DivineisaacclgresultView, msg)

		return true
	end

	return false
end

DivineisaacclgController.instance = DivineisaacclgController.New()

return DivineisaacclgController
