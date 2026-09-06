-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbchooseViewPresentor.lua

module("logic.extensions.fbbchallenge.view.FbbchooseViewPresentor", package.seeall)

local FbbchooseViewPresentor = class("FbbchooseViewPresentor", ViewPresentor)

function FbbchooseViewPresentor:ctor()
	FbbchooseViewPresentor.super.ctor(self)
end

function FbbchooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FbbchooseViewPresentor:dependWhatResources()
	return {
		"ui/views/fbbchallenge/fbbchooseview.prefab"
	}
end

function FbbchooseViewPresentor:buildViews()
	return {
		FbbchooseView.New()
	}
end

function FbbchooseViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return FbbchooseViewPresentor
