-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/readyforwar/view/ReadyforwarmainViewPresentor.lua

module("logic.extensions.readyforwar.view.ReadyforwarmainViewPresentor", package.seeall)

local ReadyforwarmainViewPresentor = class("ReadyforwarmainViewPresentor", ViewPresentor)

function ReadyforwarmainViewPresentor:ctor()
	ReadyforwarmainViewPresentor.super.ctor(self)
end

function ReadyforwarmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReadyforwarmainViewPresentor:dependWhatResources()
	return {
		"ui/views/readyforwar/readyforwarmainview.prefab"
	}
end

function ReadyforwarmainViewPresentor:buildViews()
	return {
		ReadyforwarmainView.New()
	}
end

return ReadyforwarmainViewPresentor
