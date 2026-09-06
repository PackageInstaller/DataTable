-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/controller/DivineteshamuclgController.lua

module("logic.extensions.divineteshamuclg.controller.DivineteshamuclgController", package.seeall)

local DivineteshamuclgController = class("DivineteshamuclgController", BaseController)

function DivineteshamuclgController:ctor()
	return
end

function DivineteshamuclgController:onInit()
	self:onReset()
end

function DivineteshamuclgController:onReset()
	self._saveChangeSetId = 0
end

function DivineteshamuclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(247)
end

function DivineteshamuclgController:onNotifyChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(self._onBattleEnd, self)

	self._notifyClgMsg = msg
end

function DivineteshamuclgController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if not self._notifyClgMsg then
		return false
	end

	local msg = self._notifyClgMsg

	self._notifyClgMsg = nil

	local res = msg.res

	if not res.isWin then
		return false
	end

	UIStateManager.instance:push(ViewName.DivineteshamuclgresultView, msg)

	return true
end

function DivineteshamuclgController:onSaveRes(msg)
	if msg.changeSetId > 0 then
		self._saveChangeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

function DivineteshamuclgController:showChangeSet()
	if self._saveChangeSetId > 0 then
		MaterialController.instance:showChangeSetInTemp(self._saveChangeSetId)

		self._saveChangeSetId = 0
	end
end

DivineteshamuclgController.instance = DivineteshamuclgController.New()

return DivineteshamuclgController
