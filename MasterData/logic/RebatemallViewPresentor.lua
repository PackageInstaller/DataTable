-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/RebatemallViewPresentor.lua

module("logic.extensions.doubleeleven.view.RebatemallViewPresentor", package.seeall)

local RebatemallViewPresentor = class("RebatemallViewPresentor", ViewPresentor)

function RebatemallViewPresentor:ctor()
	RebatemallViewPresentor.super.ctor(self)
end

function RebatemallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RebatemallViewPresentor:dependWhatResources()
	return {
		"ui/views/doubleeleven/rebatemallview.prefab"
	}
end

function RebatemallViewPresentor:buildViews()
	return {
		RebatemallView.New()
	}
end

return RebatemallViewPresentor
