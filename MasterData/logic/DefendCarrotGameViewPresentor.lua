-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotGameViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendCarrotGameViewPresentor", package.seeall)

local DefendCarrotGameViewPresentor = class("DefendCarrotGameViewPresentor", ViewPresentor)

function DefendCarrotGameViewPresentor:ctor()
	DefendCarrotGameViewPresentor.super.ctor(self)
end

function DefendCarrotGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendCarrotGameViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotgameview.prefab"
	}
end

function DefendCarrotGameViewPresentor:buildViews()
	return {
		DefendCarrotGameView.New()
	}
end

return DefendCarrotGameViewPresentor
