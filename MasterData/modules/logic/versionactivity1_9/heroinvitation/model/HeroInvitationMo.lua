-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/model/HeroInvitationMo.lua

module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationMo", package.seeall)

local HeroInvitationMo = pureTable("HeroInvitationMo")

function HeroInvitationMo:init(id)
	self.id = id
	self.gainReward = false
	self.cfg = HeroInvitationConfig.instance:getInvitationConfig(id)
	self.state = self:getInvitationState()
end

function HeroInvitationMo:setGainReward(gainReward)
	self.gainReward = gainReward
	self.state = self:getInvitationState()
end

function HeroInvitationMo:isGainReward()
	return self.gainReward
end

function HeroInvitationMo:getInvitationState()
	if self:isGainReward() then
		return HeroInvitationEnum.InvitationState.Finish
	end

	local config = self.cfg

	if DungeonMapModel.instance:elementIsFinished(config.elementId) then
		return HeroInvitationEnum.InvitationState.CanGet
	end

	local openTime = HeroInvitationMo.stringToTimestamp(config.openTime)

	if openTime > ServerTime.now() then
		return HeroInvitationEnum.InvitationState.TimeLocked
	end

	if not DungeonMapModel.instance:getElementById(config.elementId) then
		return HeroInvitationEnum.InvitationState.ElementLocked
	end

	return HeroInvitationEnum.InvitationState.Normal
end

function HeroInvitationMo.stringToTimestamp(str)
	local _, _, y, m1, d, h, m2, s = string.find(str, "(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)")

	if not y or not m1 or not d or not h or not m2 or not s then
		return 0
	end

	local dtTable = {
		year = y,
		month = m1,
		day = d,
		hour = h,
		min = m2,
		sec = s
	}

	return TimeUtil.dtTableToTimeStamp(dtTable) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

return HeroInvitationMo
