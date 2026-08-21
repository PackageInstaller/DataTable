-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookMemoryViewPresentor.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookMemoryViewPresentor", package.seeall)

local M = class("RogueHandBookMemoryViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungrouphandbook_run_group_handbook_memory_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHandBookMemoryView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
