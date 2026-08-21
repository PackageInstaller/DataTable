-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/HackOptimiseViewPresentor.lua

module("logic.extensions.hacktool.view.HackOptimiseViewPresentor", package.seeall)

local M = class("HackOptimiseViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_hackprofilepanel
	}
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

function M:buildViews()
	local views = {}
	local mainView = HackOptimiseView.New()

	table.insert(views, mainView)

	return views
end

return M
