-- chunkname: @modules/logic/fight/view/work/FightWorkAutoSeason2ChangeHero.lua

module("modules.logic.fight.view.work.FightWorkAutoSeason2ChangeHero", package.seeall)

local FightWorkAutoSeason2ChangeHero = class("FightWorkAutoSeason2ChangeHero", BaseWork)

function FightWorkAutoSeason2ChangeHero:ctor(opeList, index)
	self._opList = opeList
	self._index = index
	self._beginRoundOp = self._opList[index]
end

function FightWorkAutoSeason2ChangeHero:onStart()
	if not self._beginRoundOp then
		self:onDone(true)

		return
	end

	TaskDispatcher.runDelay(self._delayDone, self, 30)

	local subUid = self._opList[self._index - 2].toId
	local changedUid = self._opList[self._index - 1].toId

	self._toId = self._beginRoundOp.toId

	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self, LuaEventSystem.Low)
	FightController.instance:registerCallback(FightEvent.ReceiveChangeSubHeroReply, self._onReceiveChangeSubHeroReply, self)
	FightController.instance:registerCallback(FightEvent.ChangeSubHeroExSkillReply, self._onChangeSubHeroExSkillReply, self)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Season2AutoChangeHero)
	FightRpc.instance:sendChangeSubHeroRequest(subUid, changedUid)
end

function FightWorkAutoSeason2ChangeHero:_onRoundSequenceFinish()
	if not self._changedSkill then
		self._changedSkill = true
	else
		self:clearWork()

		return
	end

	FightRpc.instance:sendChangeSubHeroExSkillRequest(self._toId)
end

function FightWorkAutoSeason2ChangeHero:_onReceiveChangeSubHeroReply(resultCode)
	if resultCode ~= 0 then
		self:onDone(true)
	end
end

function FightWorkAutoSeason2ChangeHero:_onChangeSubHeroExSkillReply(resultCode)
	if resultCode ~= 0 then
		self:onDone(true)
	end
end

function FightWorkAutoSeason2ChangeHero:_delayDone()
	self:onDone(true)
end

function FightWorkAutoSeason2ChangeHero:clearWork()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Season2AutoChangeHero)
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.ReceiveChangeSubHeroReply, self._onReceiveChangeSubHeroReply, self)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	FightController.instance:unregisterCallback(FightEvent.ChangeSubHeroExSkillReply, self._onChangeSubHeroExSkillReply, self)
end

return FightWorkAutoSeason2ChangeHero
