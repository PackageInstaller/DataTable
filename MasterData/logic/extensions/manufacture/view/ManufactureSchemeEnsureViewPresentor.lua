-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureSchemeEnsureViewPresentor.lua

module("logic.extensions.manufacture.view.ManufactureSchemeEnsureViewPresentor", package.seeall)

local M = class("ManufactureSchemeEnsureViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_hint_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ManufactureSchemeEnsureView.New())

	return views
end

return M
