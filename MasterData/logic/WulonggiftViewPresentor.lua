-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/WulonggiftViewPresentor.lua

module("logic.extensions.itembag.view.WulonggiftViewPresentor", package.seeall)

local WulonggiftViewPresentor = class("WulonggiftViewPresentor", ViewPresentor)

function WulonggiftViewPresentor:ctor()
	WulonggiftViewPresentor.super.ctor(self)
end

function WulonggiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WulonggiftViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/wulonggiftview.prefab"
	}
end

function WulonggiftViewPresentor:buildViews()
	return {
		WulonggiftView.New()
	}
end

return WulonggiftViewPresentor
