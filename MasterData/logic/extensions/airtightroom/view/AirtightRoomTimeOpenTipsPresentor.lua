-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimeOpenTipsPresentor.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimeOpenTipsPresentor", package.seeall)

local M = class("AirtightRoomTimeOpenTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Airtight_OpenTips_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirtightRoomTimeOpenTips.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
