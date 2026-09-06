-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotMainViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendCarrotMainViewPresentor", package.seeall)

local DefendCarrotMainViewPresentor = class("DefendCarrotMainViewPresentor", ViewPresentor)

function DefendCarrotMainViewPresentor:ctor()
	DefendCarrotMainViewPresentor.super.ctor(self)
end

function DefendCarrotMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendCarrotMainViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotmainview.prefab"
	}
end

function DefendCarrotMainViewPresentor:buildViews()
	return {
		DefendCarrotMainView.New()
	}
end

return DefendCarrotMainViewPresentor
