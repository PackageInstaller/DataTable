-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballViewPresentor.lua

module("logic.extensions.football.view.FootballViewPresentor", package.seeall)

local M = class("FootballViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Football_football_matching_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FootballView.New())
	table.insert(views, MoneyView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
