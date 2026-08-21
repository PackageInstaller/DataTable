-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/facade/SeasonFacade.lua

module("logic.extensions.season.facade.SeasonFacade", package.seeall)

local M = class("SeasonFacade")

function M:isSeasonOpen(showToast)
	if self:isSysTaskOpen(showToast) and self:isActivityOpen(showToast) then
		return true
	end

	return false
end

function M:isActivityOpen(showToast)
	if self:hasActivityOpen() and SeasonModel.instance:getSeasonId() > 0 then
		return true
	end

	if showToast then
		FloatWordMgr.instance:show(lang("tip_season_1"))
	end

	return false
end

function M:hasActivityOpen()
	local list = ActivityController.instance:getActivitiesByLogicType(ActivityEnum.LogicType.SEASON)

	return #list > 0
end

function M:enterSeasonMainView(showToast)
	if self:isSeasonOpen(showToast) then
		ViewMgr.instance:open(ViewName.SeasonNewMain)
	end
end

function M:enterBuyVipView()
	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.SeasonVip, true) then
		ViewMgr.instance:open(ViewName.SeasonBuyVip)
	end
end

function M:isSysTaskOpen(showToast)
	return SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Task, showToast)
end

M.instance = M.New()

return M
