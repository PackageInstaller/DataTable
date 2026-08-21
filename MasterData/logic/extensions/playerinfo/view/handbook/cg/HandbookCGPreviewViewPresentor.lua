-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/cg/HandbookCGPreviewViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.cg.HandbookCGPreviewViewPresentor", package.seeall)

local M = class("HandbookCGPreviewViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_cg_preview_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookCGPreviewView.New())

	return views
end

return M
