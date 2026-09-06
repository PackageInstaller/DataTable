-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenMainViewPresentor.lua

module("logic.extensions.dragonxiuer.view.YushenMainViewPresentor", package.seeall)

local YushenMainViewPresentor = class("YushenMainViewPresentor", ViewPresentor)

function YushenMainViewPresentor:ctor()
	YushenMainViewPresentor.super.ctor(self)
end

function YushenMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YushenMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/copy/yushenmainview.prefab"
	}
end

function YushenMainViewPresentor:buildViews()
	return {
		YushenMainView.New()
	}
end

return YushenMainViewPresentor
