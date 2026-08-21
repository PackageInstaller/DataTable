-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualMainViewPresentor.lua

module("logic.extensions.controlaction.view.manual.ManualMainViewPresentor", package.seeall)

local M = class("ManualMainViewPresentor", ViewPresentor)

M.Url_View = ResName.Regulatory_manual_panel

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ManualMainView.New())
	table.insert(views, ManualDetailView.New())

	return views
end

return M
