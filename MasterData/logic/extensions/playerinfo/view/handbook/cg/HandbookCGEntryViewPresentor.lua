-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/cg/HandbookCGEntryViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.cg.HandbookCGEntryViewPresentor", package.seeall)

local M = class("HandbookCGEntryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_cg_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookCGEntryView.New())

	return views
end

return M
