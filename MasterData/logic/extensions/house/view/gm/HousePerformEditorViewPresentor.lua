-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HousePerformEditorViewPresentor.lua

module("logic.extensions.house.view.gm.HousePerformEditorViewPresentor", package.seeall)

local M = class("HousePerformEditorViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_house_perform_editor
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HousePerformEditorView.New())

	return views
end

return M
