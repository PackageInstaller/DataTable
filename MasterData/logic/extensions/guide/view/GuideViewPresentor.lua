-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideViewPresentor.lua

module("logic.extensions.guide.view.GuideViewPresentor", package.seeall)

local M = class("GuideViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Guide_guideview
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, GuideView.New())

	return views
end

return M
