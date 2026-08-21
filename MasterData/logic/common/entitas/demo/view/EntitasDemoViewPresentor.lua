-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/EntitasDemoViewPresentor.lua

module("logic.common.entitas.demo.view.EntitasDemoViewPresentor", package.seeall)

local M = class("EntitasDemoViewPresentor", ViewPresentor)

M.Url_View = ResName.Entitas_demo_view

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

function M:buildViews()
	local views = {}

	table.insert(views, EntitasDemoView.New())

	return views
end

return M
