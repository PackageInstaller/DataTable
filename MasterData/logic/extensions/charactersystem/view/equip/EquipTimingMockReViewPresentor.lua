-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingMockReViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingMockReViewPresentor", package.seeall)

local M = class("EquipTimingMockReViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_timing_or_reset_show_view_choose_review
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipTimingMockReView.New())

	return views
end

return M
