-- chunkname: @modules/logic/fight/view/cardeffect/FightCardRouge2PopMusicWork.lua

module("modules.logic.fight.view.cardeffect.FightCardRouge2PopMusicWork", package.seeall)

local FightCardRouge2PopMusicWork = class("FightCardRouge2PopMusicWork", BaseWork)
local TimeFactor = 1
local dt = 0.033 * TimeFactor

function FightCardRouge2PopMusicWork:ctor()
	self._dt = dt / FightModel.instance:getUISpeed()
end

function FightCardRouge2PopMusicWork:onStart(context)
	self.op = self.context.fightBeginRoundOp

	local needPushMusic = FightRouge2MusicBehaviourHelper.hasMusicNote(self.op) or FightRouge2MusicBehaviourHelper.checkIsMusicSkill(self.op)

	if not needPushMusic then
		return self:onDone(true)
	end

	local checkCardIsFlying = FightDataHelper.operationDataMgr:checkOpIsFlying(self.op)

	if checkCardIsFlying then
		TaskDispatcher.runDelay(self.onWaitCardPlayDelayDone, self, 1)
		FightController.instance:registerCallback(FightEvent.PlayCardFlayFinish, self.onPlayCardFlayFinish, self, LuaEventSystem.High)
	else
		self:startPushMusic()

		return self:onDone(true)
	end
end

function FightCardRouge2PopMusicWork:onWaitCardPlayDelayDone()
	logError("肉鸽2 推球work : 等待打牌结束超时了")
	self:startPushMusic(true)
end

function FightCardRouge2PopMusicWork:onPlayCardFlayFinish(beginRoundOp)
	if beginRoundOp ~= self.op then
		return
	end

	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, self.onPlayCardFlayFinish, self)
	TaskDispatcher.cancelTask(self.onWaitCardPlayDelayDone, self)
	self:startPushMusic()
	self:onDone(true)
end

function FightCardRouge2PopMusicWork:startPushMusic()
	TaskDispatcher.runDelay(self.onPushMusicDelayDone, self, 0.5)

	local roundOp = self.op
	local cardData = roundOp and roundOp.cardData
	local skillId = cardData and cardData.skillId
	local co = skillId and lua_fight_rouge2_music_ball_skill.configDict[skillId]

	if co then
		self:handleMusicSkill(co)
	else
		self:handleNormalSkill()
	end

	FightController.instance:dispatchEvent(FightEvent.Rouge2_OnPlayMusicActive)
end

function FightCardRouge2PopMusicWork:onPushMusicDelayDone()
	logError("肉鸽2 推球work : 推球超时了")
	self:onDone(true)
end

FightCardRouge2PopMusicWork.PushMusicDuration = 0.8

function FightCardRouge2PopMusicWork:handleNormalSkill()
	if self.op then
		local cardData = self.op.cardData
		local musicNote = cardData and cardData.musicNote
		local type = musicNote and musicNote.type

		if not type or type == FightEnum.Rouge2MusicType.None then
			return
		end

		local music = FightDataHelper.rouge2MusicDataMgr:tryPopMusicNote()

		if not music then
			return
		end

		AudioMgr.instance:trigger(20320603)

		local op = FightRouge2MusicBehaviourHelper.addOperation(music.type)

		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
		FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
		FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
		FightController.instance:dispatchEvent(FightEvent.OnPlayRouge2MusicCardFlowDone, op)
	end
end

function FightCardRouge2PopMusicWork:handleMusicSkill(co)
	if self.context.rouge2Music_popBehaviourIdList then
		for _, index in ipairs(self.context.rouge2Music_popBehaviourIdList) do
			FightRouge2MusicBehaviourHelper.runPopBehaviour(index)
		end
	end
end

function FightCardRouge2PopMusicWork:clearWork()
	TaskDispatcher.cancelTask(self.onPushMusicDelayDone, self)
	TaskDispatcher.cancelTask(self.onWaitCardPlayDelayDone, self)
	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, self.onPlayCardFlayFinish, self)
end

return FightCardRouge2PopMusicWork
