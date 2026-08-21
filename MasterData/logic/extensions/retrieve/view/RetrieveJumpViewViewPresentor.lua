-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveJumpViewViewPresentor.lua

module("logic.extensions.retrieve.view.RetrieveJumpViewViewPresentor", package.seeall)

local M = class("RetrieveJumpViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.RetrieveJumpViewView
	}
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

function M:buildViews()
	local views = {}

	table.insert(views, RetrieveJumpMgrView.New())

	return views
end

return M
