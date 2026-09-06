-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/YirenpozhenmainViewPresentor.lua

module("logic.extensions.yirenpozhen.view.YirenpozhenmainViewPresentor", package.seeall)

local YirenpozhenmainViewPresentor = class("YirenpozhenmainViewPresentor", ViewPresentor)

function YirenpozhenmainViewPresentor:ctor()
	YirenpozhenmainViewPresentor.super.ctor(self)
end

function YirenpozhenmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YirenpozhenmainViewPresentor:dependWhatResources()
	return {
		"ui/views/yirenpozhen/yirenpozhenmainview.prefab"
	}
end

function YirenpozhenmainViewPresentor:buildViews()
	return {
		YirenPozhenMainView.New()
	}
end

return YirenpozhenmainViewPresentor
