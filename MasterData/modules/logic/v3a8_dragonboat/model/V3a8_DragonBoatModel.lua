-- chunkname: @modules/logic/v3a8_dragonboat/model/V3a8_DragonBoatModel.lua

module("modules.logic.v3a8_dragonboat.model.V3a8_DragonBoatModel", package.seeall)

local V3a8_DragonBoatModel = class("V3a8_DragonBoatModel", Activity241Model)

function V3a8_DragonBoatModel:ctor(...)
	V3a8_DragonBoatModel.super.ctor(self, ...)
end

function V3a8_DragonBoatModel:reInit()
	V3a8_DragonBoatModel.super.reInit(self)
	self:_internal_set_config(V3a8_DragonBoatConfig.instance)
end

function V3a8_DragonBoatModel:_onReceiveAct241GetInfoReply(...)
	V3a8_DragonBoatController.instance:dispatchEvent(Activity241Event.onReceiveAct241GetInfoReply, ...)
end

function V3a8_DragonBoatModel:_onReceiveAct241VoteReply(...)
	V3a8_DragonBoatController.instance:dispatchEvent(Activity241Event.onReceiveAct241VoteReply, ...)
end

function V3a8_DragonBoatModel:_onReceiveAct241GetBonusReply(...)
	V3a8_DragonBoatController.instance:dispatchEvent(Activity241Event.onReceiveAct241GetBonusReply, ...)
end

function V3a8_DragonBoatModel:getVoteSimpleInfo()
	if not self._tmpVoteSimpleInfo then
		self:cacheVoteSimpleInfo()
	end

	return self._tmpVoteSimpleInfo
end

function V3a8_DragonBoatModel:cacheVoteSimpleInfo()
	self._tmpVoteSimpleInfo = GlobalVoteModel.instance:getSimpleInfo(self:voteId())
end

function V3a8_DragonBoatModel:bBlueWin()
	local info = self._tmpVoteSimpleInfo

	if not info then
		return false
	end

	if info.totVotedCnt <= 0 then
		return false
	end

	if not info.opId2VoteCnt[V3a8_DragonBoatEnum.Op.Blue] then
		local blueCnt = 0

		if not info.opId2VoteCnt[V3a8_DragonBoatEnum.Op.Red] then
			local redCnt = 0

			return redCnt <= blueCnt
		end
	end
end

function V3a8_DragonBoatModel:bRedWin()
	local info = self._tmpVoteSimpleInfo

	if not info then
		return false
	end

	if info.totVotedCnt <= 0 then
		return false
	end

	return not self:bBlueWin()
end

function V3a8_DragonBoatModel:hasTicketNum()
	local CO = self:config():getAct241CO()
	local currency = CurrencyModel.instance:getCurrency(CO.ticketCurrencyId)

	return (currency or nil) and (currency.quantity or 0)
end

function V3a8_DragonBoatModel:displayMaxTicketNum()
	local CO = self:config():getAct241CO()
	local ticketLimit = CO.ticketLimit

	return GameUtil.clamp(self:hasTicketNum(), 0, ticketLimit)
end

function V3a8_DragonBoatModel:isExpired(day)
	if not self:isActOnLine() then
		return false
	end

	if isDebugBuild then
		assert(day > 0)
	end

	if not self:isOpenedVoteFinal() then
		return false
	end

	return day > self:getBonusVotes()
end

function V3a8_DragonBoatModel:isClaimed(optDay)
	if not self:isActOnLine() then
		return false
	end

	if not optDay then
		return self:getBonusVotes() >= self:votedCount()
	else
		if isDebugBuild then
			assert(optDay > 0)
		end

		return optDay <= self:getBonusVotes()
	end
end

function V3a8_DragonBoatModel:isClaimable(optDay)
	if not self:isActOnLine() then
		return false
	end

	local votedCount = self:votedCount()

	if votedCount <= 0 then
		return false
	end

	local getBonusVotes = self:getBonusVotes()

	if not optDay then
		return getBonusVotes < votedCount
	else
		if isDebugBuild then
			assert(optDay > 0)
		end

		return getBonusVotes < optDay and optDay <= votedCount
	end
end

function V3a8_DragonBoatModel:bFinalBonusClaimable()
	local actId = self:config():getVoteFinalResultActId()

	return ActivityType101Model.instance:isType101RewardCouldGet(actId, 1)
end

function V3a8_DragonBoatModel:bFinalBonusClaimed()
	local actId = self:config():getVoteFinalResultActId()

	return ActivityType101Model.instance:isType101RewardGet(actId, 1)
end

function V3a8_DragonBoatModel:isOpenedVoteFinal()
	local actId = self:config():getVoteFinalResultActId()

	return ActivityHelper.getActivityStatus(actId, true) == ActivityEnum.ActivityStatus.Normal
end

V3a8_DragonBoatModel.instance = V3a8_DragonBoatModel.New()

return V3a8_DragonBoatModel
