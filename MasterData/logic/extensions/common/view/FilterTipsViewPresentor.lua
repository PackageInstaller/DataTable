-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/FilterTipsViewPresentor.lua

module("logic.extensions.common.view.FilterTipsViewPresentor", package.seeall)

local M = class("FilterTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Common_team_filter_tips,
		ResName.Common_team_filter_tab
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FilterTipsView.New())

	return views
end

return M
