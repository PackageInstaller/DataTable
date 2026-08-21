-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/controller/RankController.lua

module("logic.extensions.rank.controller.RankController", package.seeall)

local M = class("RankController", BaseController)
local playerPrefs_showTeam = "rank_show_team"
local mainViewRankType = {
	CommEnum.RankEnum.Collection,
	CommEnum.RankEnum.Level,
	CommEnum.RankEnum.ClimbTower,
	CommEnum.RankEnum.AirWorkShop,
	CommEnum.RankEnum.MainLine
}

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.GET_VALID_RANK, self._onGetValidRank, self)
end

function M:enterRankMainView()
	if self:isSystemOpen(true) then
		RankAgent.instance:sendGetRankInfoRequest()
	end
end

function M:_onGetValidRank(_, validRanks)
	if ViewMgr.instance:isOpen(ViewName.RankView) then
		return
	end

	if validRanks then
		for i = 1, #validRanks do
			local rankId = validRanks[i]

			if self:isMainViewRank(rankId) and not RankConfig.instance:isLastRank(rankId) then
				ViewMgr.instance:open(ViewName.RankView, validRanks)

				return
			end
		end
	end

	FloatWordMgr.instance:show(lang("rank_no_open"))
end

function M:isSystemOpen(showLogTips)
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Rank, showLogTips)

	return isOpen
end

function M:isMainViewRank(rankId)
	local rankType = RankConfig.instance:getRankType(rankId)

	for _, type in ipairs(mainViewRankType) do
		if rankType == type then
			return true
		end
	end

	return false
end

function M:setIsShowTeam(isShowTeam)
	local value = isShowTeam and 0 or -1

	UnityEngine.PlayerPrefs.SetInt(playerPrefs_showTeam, value)
	UnityEngine.PlayerPrefs.Save()
end

function M:getIsShowTeam()
	local value = UnityEngine.PlayerPrefs.GetInt(playerPrefs_showTeam)

	return value >= 0
end

M.instance = M.New()

return M
