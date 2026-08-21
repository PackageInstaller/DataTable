-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterCompareViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterCompareViewPresentor", package.seeall)

local M = class("HandbookMonsterCompareViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_mosterdata_preview_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookMonsterCompareView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
