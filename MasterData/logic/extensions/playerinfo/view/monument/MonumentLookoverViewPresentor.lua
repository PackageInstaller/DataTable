-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentLookoverViewPresentor.lua

module("logic.extensions.playerinfo.view.monument.MonumentLookoverViewPresentor", package.seeall)

local M = class("MonumentLookoverViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Symptom_syndrome_main_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MonumentLookoverView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
