-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/gohome/GoHomeTabFrameWorkMainViewPresentor.lua

module("logic.extensions.playerreturn.view.gohome.GoHomeTabFrameWorkMainViewPresentor", package.seeall)

local GoHomeTabFrameWorkMainViewPresentor = class("GoHomeTabFrameWorkMainViewPresentor", ViewPresentor)

function GoHomeTabFrameWorkMainViewPresentor:ctor()
	GoHomeTabFrameWorkMainViewPresentor.super.ctor(self)
end

function GoHomeTabFrameWorkMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoHomeTabFrameWorkMainViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/gohome/gohometabframeworkmainview.prefab"
	}
end

function GoHomeTabFrameWorkMainViewPresentor:buildViews()
	return {
		GoHomeTabFrameWorkMainView.New()
	}
end

return GoHomeTabFrameWorkMainViewPresentor
