-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueEventReviewViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueEventReviewViewPresentor", package.seeall)

local M = class("RogueEventReviewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_run_group_report_view,
		ResName.Rungroupexplore_vending_props_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueEventReviewView.New())
	table.insert(views, TitleView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

return M
