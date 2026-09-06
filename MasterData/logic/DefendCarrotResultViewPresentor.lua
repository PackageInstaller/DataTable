-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotResultViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendCarrotResultViewPresentor", package.seeall)

local DefendCarrotResultViewPresentor = class("DefendCarrotResultViewPresentor", ViewPresentor)

function DefendCarrotResultViewPresentor:ctor()
	DefendCarrotResultViewPresentor.super.ctor(self)
end

function DefendCarrotResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendCarrotResultViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotresultview.prefab"
	}
end

function DefendCarrotResultViewPresentor:buildViews()
	return {
		DefendCarrotResultView.New()
	}
end

return DefendCarrotResultViewPresentor
