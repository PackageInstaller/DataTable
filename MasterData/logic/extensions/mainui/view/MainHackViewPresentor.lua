-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainHackViewPresentor.lua

module("logic.extensions.mainui.view.MainHackViewPresentor", package.seeall)

local M = class("MainHackViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Main_main_hack
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, MainHackView.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.MainHackViewPresentor)
end

return M
