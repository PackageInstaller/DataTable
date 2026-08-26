-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp_TaskListModel.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp_TaskListModel", package.seeall)

local V3a6_WarmUp_TaskListModel = class("V3a6_WarmUp_TaskListModel", ListScrollModel)

function V3a6_WarmUp_TaskListModel:_actId()
	return Activity125Config.instance:getWarmUpActId(13612)
end

function V3a6_WarmUp_TaskListModel:_getActivity125MO(optActId)
	return Activity125Model.instance:getById(optActId or self:_actId())
end

function V3a6_WarmUp_TaskListModel:_getRLOC(episodeId, optActId)
	local mo = self:_getActivity125MO(optActId)

	if not mo then
		return nil
	end

	return mo:getRLOC(episodeId)
end

function V3a6_WarmUp_TaskListModel:_getAct125COList(optActId)
	return Activity125Config.instance:getAct125Config(optActId or self:_actId())
end

function V3a6_WarmUp_TaskListModel:refreshList(optActId)
	local COs = self:_getAct125COList(optActId)
	local dataList = {}

	for _, CO in pairs(COs) do
		local rewardBonus
		local episodeId = CO.id
		local isRecevied, localIsPlay, _, canGetReward = self:_getRLOC(episodeId, optActId)
		local rewardList = string.split(string.nilorempty(CO.clientbonus) and CO.bonus or CO.clientbonus or "", "|")

		table.insert(dataList, {
			episodeCO = CO,
			rewardList = rewardList,
			isClaimed = isRecevied,
			isClaimable = canGetReward
		})
	end

	table.sort(dataList, function(a, b)
		local a_isClaimable = a.isClaimable and 1 or 0
		local b_isClaimable = b.isClaimable and 1 or 0

		if a_isClaimable ~= b_isClaimable then
			return b_isClaimable < a_isClaimable
		end

		local a_isClaimed = a.isClaimed and 1 or 0
		local b_isClaimed = b.isClaimed and 1 or 0

		if a_isClaimed ~= b_isClaimed then
			return a_isClaimed < b_isClaimed
		end

		local a_episodeId = a.episodeCO.id
		local b_episodeId = b.episodeCO.id

		return a_episodeId < b_episodeId
	end)
	self:setList(dataList)
end

V3a6_WarmUp_TaskListModel.instance = V3a6_WarmUp_TaskListModel.New()

return V3a6_WarmUp_TaskListModel
