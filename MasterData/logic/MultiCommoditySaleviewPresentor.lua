-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/MultiCommoditySaleviewPresentor.lua

module("logic.extensions.dressactivityshop.view.MultiCommoditySaleviewPresentor", package.seeall)

local MultiCommoditySaleviewPresentor = class("MultiCommoditySaleviewPresentor", ViewPresentor)

function MultiCommoditySaleviewPresentor:ctor()
	MultiCommoditySaleviewPresentor.super.ctor(self)
end

function MultiCommoditySaleviewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MultiCommoditySaleviewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/multicommoditysaleview.prefab"
	}
end

function MultiCommoditySaleviewPresentor:buildViews()
	return {
		MultiCommoditySaleview.New()
	}
end

return MultiCommoditySaleviewPresentor
