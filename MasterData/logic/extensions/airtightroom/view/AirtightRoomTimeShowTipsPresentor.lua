-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimeShowTipsPresentor.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimeShowTipsPresentor", package.seeall)

local M = class("AirtightRoomTimeShowTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Airtight_ShowTips_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirtightRoomTimeShowTips.New())

	return views
end

return M
