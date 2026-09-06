-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotTaskViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendCarrotTaskViewPresentor", package.seeall)

local DefendCarrotTaskViewPresentor = class("DefendCarrotTaskViewPresentor", ViewPresentor)

function DefendCarrotTaskViewPresentor:ctor()
	DefendCarrotTaskViewPresentor.super.ctor(self)
end

function DefendCarrotTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendCarrotTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrottaskview.prefab"
	}
end

function DefendCarrotTaskViewPresentor:buildViews()
	return {
		DefendCarrotTaskView.New()
	}
end

return DefendCarrotTaskViewPresentor
