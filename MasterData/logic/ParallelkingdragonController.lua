-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/controller/ParallelkingdragonController.lua

module("logic.extensions.parallelkingdragon.controller.ParallelkingdragonController", package.seeall)

local ParallelkingdragonController = class("ParallelkingdragonController", BaseController)

function ParallelkingdragonController:ctor()
	return
end

function ParallelkingdragonController:onInit()
	self:onReset()
end

function ParallelkingdragonController:onReset()
	self._notifyClgMsg = nil
end

function ParallelkingdragonController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(253)
end

function ParallelkingdragonController:onNotifyChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(self._onBattleEnd, self)

	self._notifyClgMsg = msg
end

function ParallelkingdragonController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if not self._notifyClgMsg then
		return false
	end

	local msg = self._notifyClgMsg

	self._notifyClgMsg = nil

	if msg.isWin and msg.isPass then
		ParallelkingdragonModel.instance:updateMaxPassStageId(msg.activityId, msg.stageId)
	end

	UIStateManager.instance:push(ViewName.ParallelkingdragonresultView, msg)

	return true
end

ParallelkingdragonController.instance = ParallelkingdragonController.New()

return ParallelkingdragonController
