-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TipsFlyViewPresentor.lua

module("logic.extensions.tips.view.TipsFlyViewPresentor", package.seeall)

local TipsFlyViewPresentor = class("TipsFlyViewPresentor", ViewPresentor)

function TipsFlyViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/tipsfly.prefab"
	}
end

function TipsFlyViewPresentor:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function TipsFlyViewPresentor:buildViews()
	local views = {}
	local tipsFlyView = TipsFlyView.New()

	table.insert(views, tipsFlyView)

	return views
end

return TipsFlyViewPresentor
