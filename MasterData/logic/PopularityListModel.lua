-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/model/PopularityListModel.lua

module("logic.extensions.popularitylist.model.PopularityListModel", package.seeall)

local PopularityListModel = class("PopularityListModel", BaseModel)

function PopularityListModel:ctor()
	PopularityListModel.super.ctor(self)
end

function PopularityListModel:onInit()
	PopularityListModel.super.onInit(self)
	self:onReset()
end

function PopularityListModel:onReset()
	PopularityListModel.super.onReset(self)

	self._voteItemInfos = {}
	self._voteTypeInfos = {}
	self._yearVersionInfos = {}
end

function PopularityListModel:handlePM_GetSkinVoteCountsRes(msg)
	self._voteItemInfos[msg.activityId] = {}

	for _, v in ipairs(msg.items) do
		self._voteItemInfos[msg.activityId][v.id] = v
	end

	self._voteTypeInfos[msg.activityId] = {}

	for _, v in ipairs(msg.dailyTimes) do
		self._voteTypeInfos[msg.activityId][v.type] = v
	end

	self._yearVersionInfos[msg.activityId] = msg.yearVersionInfo and msg.yearVersionInfo or nil
end

function PopularityListModel:handlePM_SkinVoteRes(msg)
	return
end

function PopularityListModel:handlePM_GainYearVersionPrizeRes(msg)
	return
end

function PopularityListModel:getVoteItemInfo(activityId, id)
	local voteItemInfo

	return (self._voteItemInfos[activityId] or nil) and self._voteItemInfos[activityId][id] or {}
end

function PopularityListModel:getVoteItemCount(activityId, id)
	local voteItemInfo = self:getVoteItemInfo(activityId, id)

	return checknumber(voteItemInfo.count)
end

function PopularityListModel:getVoteTypeInfo(activityId, m_type)
	local voteTypeInfo

	return (self._voteTypeInfos[activityId] or nil) and self._voteTypeInfos[activityId][m_type] or {}
end

function PopularityListModel:getHasVoteIds(activityId, m_type)
	local voteTypeInfo = self:getVoteTypeInfo(activityId, m_type)

	return voteTypeInfo.hasVoteIds or {}
end

function PopularityListModel:getCostTimes(activityId, m_type)
	local voteIds = self:getHasVoteIds(activityId, m_type)

	return #voteIds
end

function PopularityListModel:getExtAddTimes(activityId, m_type)
	local voteTypeInfo = self:getVoteTypeInfo(activityId, m_type)

	return voteTypeInfo.extAddTimes or 0
end

function PopularityListModel:getVipVoteTimes(activityId, m_type)
	local voteTypeInfo = self:getVoteTypeInfo(activityId, m_type)

	return voteTypeInfo.useVipVoteTimes or 0
end

function PopularityListModel:isVersionLogin(activityId, versionId)
	local info = self._yearVersionInfos[activityId]

	return (info or nil) and table.indexof(info.loginVersions, versionId)
end

function PopularityListModel:isHasGainLoginVersionPrize(activityId, versionId)
	local info = self._yearVersionInfos[activityId]

	return (info or nil) and table.indexof(info.gainLoginVersionPrizes, versionId)
end

PopularityListModel.instance = PopularityListModel.New()

return PopularityListModel
