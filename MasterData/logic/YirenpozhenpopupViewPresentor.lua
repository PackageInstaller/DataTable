-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/YirenpozhenpopupViewPresentor.lua

module("logic.extensions.yirenpozhen.view.YirenpozhenpopupViewPresentor", package.seeall)

local YirenpozhenpopupViewPresentor = class("YirenpozhenpopupViewPresentor", ViewPresentor)

function YirenpozhenpopupViewPresentor:ctor()
	YirenpozhenpopupViewPresentor.super.ctor(self)
end

function YirenpozhenpopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YirenpozhenpopupViewPresentor:dependWhatResources()
	return {
		"ui/views/yirenpozhen/yirenpozhenpopupview.prefab"
	}
end

function YirenpozhenpopupViewPresentor:buildViews()
	return {
		YirenPozhenPopupView.New()
	}
end

return YirenpozhenpopupViewPresentor
