-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType29.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType29", package.seeall)

local FightRestartAbandonType29 = class("FightRestartAbandonType29", FightRestartAbandonTypeBase)

function FightRestartAbandonType29:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
end

function FightRestartAbandonType29:canRestart()
	local retryNum = RougeModel.instance:getRougeRetryNum()
	local maxRetryNum = RougeMapConfig.instance:getFightRetryNum()
	local canRestart = retryNum < maxRetryNum

	if not canRestart then
		GameFacade.showToast(ToastEnum.RougeNoEnoughRetryNum)
	end

	return canRestart
end

function FightRestartAbandonType29:confirmNotice()
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._onPushEndFight, self, LuaEventSystem.High)

	local maxNum = RougeMapConfig.instance:getFightRetryNum()
	local curRetryNum = RougeModel.instance:getRougeRetryNum()

	GameFacade.showMessageBox(MessageBoxIdDefine.RougeFightRestartConfirm, MsgBoxEnum.BoxType.Yes_No, self.yesCallback, self.noCallback, nil, self, self, nil, maxNum - curRetryNum)
end

function FightRestartAbandonType29:_onPushEndFight()
	FightGameMgr.restartMgr:cancelRestart()
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
end

function FightRestartAbandonType29:yesCallback()
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)

	if self.IS_DEAD then
		ToastController.instance:showToast(-80)

		return
	end

	self:startAbandon()
end

function FightRestartAbandonType29:noCallback()
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)
	FightGameMgr.restartMgr:cancelRestart()
end

function FightRestartAbandonType29:startAbandon()
	DungeonFightController.instance:registerCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)
	DungeonFightController.instance:sendEndFightRequest(true, DungeonEnum.EndType.Restart)
end

function FightRestartAbandonType29:_startRequestFight(resultCode)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)

	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end

	self._fight_work:onDone(true)
end

function FightRestartAbandonType29:releaseSelf()
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)
	self:__onDispose()
end

return FightRestartAbandonType29
