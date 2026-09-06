-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/view/ElizabethactmainViewPresentor.lua

module("logic.extensions.elizabethgame.view.ElizabethactmainViewPresentor", package.seeall)

local ElizabethactmainViewPresentor = class("ElizabethactmainViewPresentor", ViewPresentor)

function ElizabethactmainViewPresentor:ctor()
	ElizabethactmainViewPresentor.super.ctor(self)
end

function ElizabethactmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElizabethactmainViewPresentor:dependWhatResources()
	return {
		"ui/views/elizabethgame/elizabethactmainview.prefab"
	}
end

function ElizabethactmainViewPresentor:buildViews()
	return {
		ElizabethactmainView.New()
	}
end

return ElizabethactmainViewPresentor
