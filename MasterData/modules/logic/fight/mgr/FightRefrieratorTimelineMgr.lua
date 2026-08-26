-- chunkname: @modules/logic/fight/mgr/FightRefrieratorTimelineMgr.lua

module("modules.logic.fight.mgr.FightRefrieratorTimelineMgr", package.seeall)

local FightRefrieratorTimelineMgr = class("FightRefrieratorTimelineMgr", FightBaseClass)

function FightRefrieratorTimelineMgr:onConstructor()
	self:com_registMsg(FightMsgId.CardRemoveRefrieratorTimeline, self.onCardRemoveRefrieratorTimeline)
	self:com_registMsg(FightMsgId.CardAddRefrieratorTimeline, self.onCardAddRefrieratorTimeline)
end

function FightRefrieratorTimelineMgr:onCardRemoveRefrieratorTimeline()
	if self.removeWork then
		return
	end

	local entityData = self:getEntityData()

	if entityData then
		local entity = FightGameMgr.entityMgr:getById(entityData.id)

		if entity then
			local fightStepData = FightDef_pb.FightStep()

			fightStepData.fromId = entityData.id
			fightStepData.toId = entityData.id
			self.removeWork = entity.skill:registTimelineWork("nuola_315101_skill4", fightStepData)

			self.removeWork:registFinishCallback(self.onCardRemoveTimelineDone, self)
			self.removeWork:start()
			AudioMgr.instance:trigger(385012)
		end
	end
end

function FightRefrieratorTimelineMgr:onCardRemoveTimelineDone()
	self.removeWork = nil
end

function FightRefrieratorTimelineMgr:onCardAddRefrieratorTimeline()
	if self.addWork then
		FightMsgMgr.replyMsg(FightMsgId.CardAddRefrieratorTimeline, self.addWork)

		return
	end

	local entityData = self:getEntityData()

	if entityData then
		local entity = FightGameMgr.entityMgr:getById(entityData.id)

		if entity then
			local fightStepData = FightDef_pb.FightStep()

			fightStepData.fromId = entityData.id
			fightStepData.toId = entityData.id
			self.addWork = entity.skill:registTimelineWork("nuola_315101_skill3", fightStepData)

			self.addWork:registFinishCallback(self.onCardAddTimelineDone, self)
			self.addWork:start()
			AudioMgr.instance:trigger(385013)
			FightMsgMgr.replyMsg(FightMsgId.CardAddRefrieratorTimeline, self.addWork)
		end
	end
end

function FightRefrieratorTimelineMgr:onCardAddTimelineDone()
	self.addWork = nil
end

function FightRefrieratorTimelineMgr:getEntityData()
	if self.entityData then
		return self.entityData
	end

	local mySideList = FightDataHelper.entityMgr:getMyNormalList()

	for i = 1, #mySideList do
		local entity = mySideList[i]

		if entity:hasBuffActId(10034) then
			self.entityData = entity

			break
		end
	end

	return self.entityData
end

function FightRefrieratorTimelineMgr:onDestructor()
	return
end

return FightRefrieratorTimelineMgr
