-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongMainViewPresentor.lua

module("logic.extensions.tongbattle.view.TongMainViewPresentor", package.seeall)

local TongMainViewPresentor = class("TongMainViewPresentor", ViewWithGuidePresentor)

function TongMainViewPresentor:ctor()
	TongMainViewPresentor.super.ctor(self)
end

function TongMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tongbattle/tongmainview.prefab"
	}
end

function TongMainViewPresentor:buildViews()
	return {
		TongMainView.New()
	}
end

return TongMainViewPresentor
