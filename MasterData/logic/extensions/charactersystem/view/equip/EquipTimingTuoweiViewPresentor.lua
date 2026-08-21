-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingTuoweiViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingTuoweiViewPresentor", package.seeall)

local M = class("EquipTimingTuoweiViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_euip_tuowei
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipTimingTuoweiView.New())

	return views
end

return M
