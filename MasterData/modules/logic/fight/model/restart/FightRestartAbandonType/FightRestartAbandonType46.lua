-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType46.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType46", package.seeall)

local FightRestartAbandonType46 = class("FightRestartAbandonType46", FightRestartAbandonTypeBase)

function FightRestartAbandonType46:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
end

function FightRestartAbandonType46:canRestart()
	return true
end

function FightRestartAbandonType46:confirmNotice()
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._onPushEndFight, self, LuaEventSystem.High)
	GameFacade.showMessageBox(MessageBoxIdDefine.RestartStage62, MsgBoxEnum.BoxType.Yes_No, self.yesCallback, self.noCallback, nil, self, self)
end

function FightRestartAbandonType46:yesCallback()
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)

	if self.IS_DEAD then
		ToastController.instance:showToast(-80)

		return
	end

	self:startAbandon()
end

function FightRestartAbandonType46:noCallback()
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)
	FightGameMgr.restartMgr:cancelRestart()
end

function FightRestartAbandonType46:_onPushEndFight()
	FightGameMgr.restartMgr:cancelRestart()
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
end

function FightRestartAbandonType46:startAbandon()
	DungeonFightController.instance:registerCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)
	DungeonFightController.instance:sendEndFightRequest(true, DungeonEnum.EndType.Restart)
end

function FightRestartAbandonType46:_startRequestFight(resultCode)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)

	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end

	self._fight_work:onDone(true)
end

function FightRestartAbandonType46:releaseSelf()
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)
	self:__onDispose()
end

return FightRestartAbandonType46
