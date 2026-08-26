-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/model/HeroInvitationModel.lua

module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationModel", package.seeall)

local HeroInvitationModel = class("HeroInvitationModel", BaseModel)

function HeroInvitationModel:onInit()
	self:reInit()
end

function HeroInvitationModel:reInit()
	self.finalReward = false

	TaskDispatcher.cancelTask(self.checkInvitationTime, self)
end

function HeroInvitationModel:onGetHeroInvitationInfoReply(info)
	self:clear()
	self:updateInvitationInfo(info.info)
	TaskDispatcher.cancelTask(self.checkInvitationTime, self)
	TaskDispatcher.runRepeat(self.checkInvitationTime, self, 1)
end

function HeroInvitationModel:onGainInviteRewardReply(info)
	self:updateInvitationInfo(info.info)
end

function HeroInvitationModel:onGainFinalInviteRewardReply(info)
	self:updateInvitationInfo(info.info)
end

function HeroInvitationModel:updateInvitationInfo(info)
	if not info then
		return
	end

	if info.gainReward then
		for i = 1, #info.gainReward do
			local mo = self:getInvitationMoById(info.gainReward[i])

			mo:setGainReward(true)
		end
	end

	self.finalReward = info.finalReward
end

function HeroInvitationModel:getInvitationMoById(id)
	local mo = self:getById(id)

	if not mo then
		mo = HeroInvitationMo.New()

		mo:init(id)
		self:addAtLast(mo)
	end

	return mo
end

function HeroInvitationModel:getInvitationState(id)
	local mo = self:getInvitationMoById(id)

	return mo:getInvitationState()
end

function HeroInvitationModel:isGainReward(id)
	local mo = self:getInvitationMoById(id)

	return mo:isGainReward()
end

function HeroInvitationModel:getInvitationFinishCount()
	local invitations = HeroInvitationConfig.instance:getInvitationList()
	local count = #invitations
	local finishCount = 0

	for i, v in ipairs(invitations) do
		local state = self:getInvitationState(v.id)

		if state == HeroInvitationEnum.InvitationState.Finish or state == HeroInvitationEnum.InvitationState.CanGet then
			finishCount = finishCount + 1
		end
	end

	return count, finishCount
end

function HeroInvitationModel:getInvitationHasRewardCount()
	local invitations = HeroInvitationConfig.instance:getInvitationList()
	local count = #invitations
	local finishCount = 0

	for i, v in ipairs(invitations) do
		local state = self:getInvitationState(v.id)

		if state == HeroInvitationEnum.InvitationState.Finish then
			finishCount = finishCount + 1
		end
	end

	return count, finishCount
end

function HeroInvitationModel:checkInvitationTime()
	local invitations = HeroInvitationConfig.instance:getInvitationList()
	local stateChange = false

	if invitations then
		local mo, state

		for i, v in ipairs(invitations) do
			mo = self:getInvitationMoById(v.id)
			state = mo:getInvitationState()

			if state ~= mo.state then
				mo.state = state
				stateChange = true
			end
		end
	end

	if stateChange then
		HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.StateChange)
	end
end

function HeroInvitationModel:getInvitationStateByElementId(id)
	local config = HeroInvitationConfig.instance:getInvitationConfigByElementId(id)

	if not config then
		return
	end

	return self:getInvitationState(config.id)
end

function HeroInvitationModel:isAllFinish()
	local count, finish = self:getInvitationFinishCount()

	return count == finish
end

HeroInvitationModel.instance = HeroInvitationModel.New()

return HeroInvitationModel
