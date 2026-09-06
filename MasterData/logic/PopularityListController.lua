-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/controller/PopularityListController.lua

module("logic.extensions.popularitylist.controller.PopularityListController", package.seeall)

local PopularityListController = class("PopularityListController", BaseController)

function PopularityListController:ctor()
	PopularityListController.super.ctor(self)
end

function PopularityListController:onInit()
	PopularityListController.super.onInit(self)
	self:onReset()
end

function PopularityListController:onReset()
	PopularityListController.super.onReset(self)

	self._hasVoted = false
end

function PopularityListController:setHasVoted(hasVoted)
	self._hasVoted = hasVoted
end

function PopularityListController:getHasVoted()
	return (self._hasVoted or nil) and (self._hasVoted or false)
end

function PopularityListController:sendPM_GetSkinVoteCountsReq(activityId)
	SkinVoteAgent.instance:sendPM_GetSkinVoteCountsReq(activityId)
end

function PopularityListController:handlePM_GetSkinVoteCountsRes(msg)
	PopularityListModel.instance:handlePM_GetSkinVoteCountsRes(msg)
	self:updateAllRedOfLoginVersionPrize(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PopularityListGetSkinVoteCountsRes)
end

function PopularityListController:sendPM_SkinVoteReq(activityId, id, comment)
	SkinVoteAgent.instance:sendPM_SkinVoteReq(activityId, id, comment)
end

function PopularityListController:handlePM_SkinVoteRes(msg)
	PopularityListModel.instance:handlePM_SkinVoteRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PopularityListSkinVoteRes)
end

function PopularityListController:sendPM_GainYearVersionPrizeReq(activityId, versionId)
	SkinVoteAgent.instance:sendPM_GainYearVersionPrizeReq(activityId, versionId)
end

function PopularityListController:handlePM_GainYearVersionPrizeRes(msg)
	PopularityListModel.instance:handlePM_GainYearVersionPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PopularityListSkinVoteGainYearVersionPrizeRes)
end

function PopularityListController:getCurActivityType()
	return GameEnum.ActivityType.PopularityList
end

function PopularityListController:getCurActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getCurActivityType())
end

function PopularityListController:isInActivityTime(activityId)
	local activityType = self:getCurActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function PopularityListController:getWhatSeason(activityId)
	local activityType = self:getCurActivityType()

	return checkint(activityId % (activityType * 1000))
end

function PopularityListController:getVoteTheItemResultAndTips(activityId, m_type, id, isVipPlan)
	local tips = ""
	local result = GameEnum.ResultCode.Success

	isVipPlan = checkbool(isVipPlan)

	if not isVipPlan then
		if self:isHasVoteTheItem(activityId, m_type, id) then
			result = GameEnum.ResultCode.IsHasVote
			tips = PopularityListConfig.instance:getTextValue("TEXT_7")
		elseif self:getRemainTimes(activityId, m_type) <= 0 then
			result = GameEnum.ResultCode.NotEnoughTimes
			tips = PopularityListConfig.instance:getTextValue("TEXT_6")
		end
	elseif self:isHasVoteTheItem(activityId, m_type, id) then
		result = GameEnum.ResultCode.IsHasVote
		tips = PopularityListConfig.instance:getTextValue("TEXT_10")
	elseif self:getRemainTimes(activityId, m_type) <= 0 then
		result = GameEnum.ResultCode.NotEnoughTimes
		tips = PopularityListConfig.instance:getTextValue("TEXT_9")
	end

	return result, tips
end

function PopularityListController:isHasVoteTheItem(activityId, m_type, id)
	local voteListCfg = PopularityListConfig.instance:getPlBaseData(activityId, m_type)
	local isVipPlan = voteListCfg and checknumber(voteListCfg.vipTimesPlanId) ~= 0 or false

	if not isVipPlan then
		local isHas = false
		local voteIds = PopularityListModel.instance:getHasVoteIds(activityId, m_type)

		for _, v in ipairs(voteIds) do
			if v == id then
				isHas = true

				break
			end
		end

		return isHas
	end

	return false
end

function PopularityListController:getRemainTimes(activityId, m_type)
	local costTimes = PopularityListModel.instance:getCostTimes(activityId, m_type)
	local baseData = PopularityListConfig.instance:getPlBaseData(activityId, m_type)

	if checknumber(baseData.dailyTimesPlanId) > 0 then
		local cfg = PopularityListConfig.instance:getDailyVotePlanData(checknumber(baseData.dailyTimesPlanId)) or {}
		local totalFreeTimes = checknumber(cfg.freeTimes)
		local extAddTimes = PopularityListModel.instance:getExtAddTimes(activityId, m_type)

		return Mathf.Max(totalFreeTimes + extAddTimes - costTimes, 0)
	elseif checknumber(baseData.vipTimesPlanId) > 0 then
		local vipLv = VipModel.instance:getCurVipLv()
		local cfg = PopularityListConfig.instance:getVipVotePlanData(checknumber(baseData.vipTimesPlanId), vipLv) or {}
		local voteTime = PopularityListModel.instance:getVipVoteTimes(activityId, m_type)

		return Mathf.Max(checknumber(cfg.times) - voteTime, 0)
	end
end

function PopularityListController:getGainLoginVersionPrizeResultAndTips(activityId, versionId)
	local tips = ""
	local result = GameEnum.ResultCode.Success

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif not self:isVersionLogin(activityId, versionId) then
		result = GameEnum.ResultCode.Error
		tips = "未参与该版本"
	elseif self:isHasGainLoginVersionPrize(activityId, versionId) then
		result = GameEnum.ResultCode.Error
		tips = "已领取"
	end

	return result, tips
end

function PopularityListController:updateAllRedOfLoginVersionPrize(activityId)
	local isHave = false
	local cfg = PopularityListConfig.instance:getPlYearVersionCfg(activityId)

	if cfg then
		for idx, data in ipairs(cfg) do
			local versionId = data.versionId
			local redId = self:getRedIdOfLoginVersionPrize(activityId, versionId)
			local isActivated = self:isNeedRedOfLoginVersionPrize(activityId, versionId)

			isHave = isHave or isActivated

			RedPointController.instance:setRedPointInfo(redId, isActivated)
		end

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_Popularity_Login, isHave)
	end
end

function PopularityListController:isNeedRedOfLoginVersionPrize(activityId, versionId)
	return self:isCanGetPrizeOfLoginVersion(activityId, versionId)
end

function PopularityListController:getRedIdOfLoginVersionPrize(activityId, versionId)
	return string.format("%s_%s", activityId, versionId)
end

function PopularityListController:isCanGetPrizeOfLoginVersion(activityId, versionId)
	local result = self:getGainLoginVersionPrizeResultAndTips(activityId, versionId)

	return result == GameEnum.ResultCode.Success
end

function PopularityListController:isVersionLogin(activityId, versionId)
	return PopularityListModel.instance:isVersionLogin(activityId, versionId)
end

function PopularityListController:isHasGainLoginVersionPrize(activityId, versionId)
	return PopularityListModel.instance:isHasGainLoginVersionPrize(activityId, versionId)
end

function PopularityListController:getMinVersionId(activityId)
	local cfg = PopularityListConfig.instance:getPlYearVersionCfg(activityId)

	if cfg then
		return 1
	end

	return 0
end

function PopularityListController:getMaxVersionId(activityId)
	local cfg = PopularityListConfig.instance:getPlYearVersionCfg(activityId)

	if cfg then
		local data = cfg[#cfg]

		return data.versionId
	end

	return 0
end

PopularityListController.instance = PopularityListController.New()

return PopularityListController
