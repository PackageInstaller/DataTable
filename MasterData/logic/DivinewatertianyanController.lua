-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/controller/DivinewatertianyanController.lua

module("logic.extensions.divinewatertianyan.controller.DivinewatertianyanController", package.seeall)

local DivinewatertianyanController = class("DivinewatertianyanController", BaseController)

DivinewatertianyanController.StageType = {
	Water = 2,
	Fire = 1
}

function DivinewatertianyanController:ctor()
	return
end

function DivinewatertianyanController:onInit()
	self:onReset()
end

function DivinewatertianyanController:onReset()
	return
end

function DivinewatertianyanController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(248)
end

function DivinewatertianyanController:onClgNotifyFightRes(msg)
	BattleFacade.instance:registerResultHandler(self._onBattleEnd, self)

	self._notifyClgMsg = msg
end

function DivinewatertianyanController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if not self._notifyClgMsg then
		return false
	end

	local msg = self._notifyClgMsg
	local stageCfg = DivinewatertianyanConfig.instance:getStageCfg(msg.activityId, msg.stageId)

	self._notifyClgMsg = nil

	DivinewatertianyanModel.instance:onBattleSuccessRes(msg)
	UIStateManager.instance:push(ViewName.DivinewatertianyanresultView, msg)

	return true
end

DivinewatertianyanController.instance = DivinewatertianyanController.New()

return DivinewatertianyanController
