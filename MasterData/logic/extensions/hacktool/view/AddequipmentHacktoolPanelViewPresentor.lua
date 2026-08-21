-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/AddequipmentHacktoolPanelViewPresentor.lua

module("logic.extensions.hacktool.view.AddequipmentHacktoolPanelViewPresentor", package.seeall)

local M = class("AddequipmentHacktoolPanelViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_addequipment_hacktool_panel,
		ResName.Hacktool_record_d6
	}
end

function M:buildViews()
	local views = {}
	local mainView = AddequipmentHacktoolPanelView.New()

	table.insert(views, mainView)

	return views
end

return M
