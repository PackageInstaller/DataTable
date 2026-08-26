-- chunkname: @modules/logic/fight/view/cardeffect/FightCardRouge2PushMusicWork.lua

module("modules.logic.fight.view.cardeffect.FightCardRouge2PushMusicWork", package.seeall)

local FightCardRouge2PushMusicWork = class("FightCardRouge2PushMusicWork", BaseWork)

function FightCardRouge2PushMusicWork:onStart(context)
	self.op = self.context.fightBeginRoundOp

	local needPushMusic = FightRouge2MusicBehaviourHelper.hasMusicNote(self.op) or FightRouge2MusicBehaviourHelper.checkIsMusicSkill(self.op)

	if not needPushMusic then
		return self:onDone(true)
	end

	local roundOp = self.op
	local cardData = roundOp and roundOp.cardData
	local skillId = cardData and cardData.skillId
	local co = skillId and lua_fight_rouge2_music_ball_skill.configDict[skillId]

	if co then
		self:handleMusicSkill(co)
	else
		self:handleNormalSkill()
	end

	return self:onDone(true)
end

function FightCardRouge2PushMusicWork:handleNormalSkill()
	if self.op then
		local cardData = self.op.cardData
		local musicNote = cardData and cardData.musicNote
		local type = musicNote and musicNote.type

		if not type or type == FightEnum.Rouge2MusicType.None then
			return
		end

		FightDataHelper.rouge2MusicDataMgr:addMusicType(type, musicNote.blueValue)
	end
end

function FightCardRouge2PushMusicWork:handleMusicSkill(co)
	self.context.rouge2Music_popBehaviourIdList = FightRouge2MusicBehaviourHelper.runSkill(co)
end

function FightCardRouge2PushMusicWork:clearWork()
	TaskDispatcher.cancelTask(self.onPushMusicDelayDone, self)
	TaskDispatcher.cancelTask(self.onWaitCardPlayDelayDone, self)
end

return FightCardRouge2PushMusicWork
