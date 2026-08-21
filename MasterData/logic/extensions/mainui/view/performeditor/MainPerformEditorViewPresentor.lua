-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/MainPerformEditorViewPresentor.lua

module("logic.extensions.mainui.view.performeditor.MainPerformEditorViewPresentor", package.seeall)

local M = class("MainPerformEditorViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Main_main_perform_editor_view
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, MainPerformEditorView.New())

	return views
end

return M
