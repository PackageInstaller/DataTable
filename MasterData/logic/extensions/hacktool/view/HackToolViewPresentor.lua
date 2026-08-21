-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/HackToolViewPresentor.lua

module("logic.extensions.hacktool.view.HackToolViewPresentor", package.seeall)

local M = class("HackToolViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Hacktool_hacktoolpanel
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}
	local mainView = HackToolView.New()

	table.insert(views, mainView)

	return views
end

M.instance = M.New()

return M
