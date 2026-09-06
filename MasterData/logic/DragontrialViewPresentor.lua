-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrialViewPresentor", package.seeall)

local DragontrialViewPresentor = class("DragontrialViewPresentor", ViewPresentor)

function DragontrialViewPresentor:ctor()
	DragontrialViewPresentor.super.ctor(self)
end

function DragontrialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrialViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrialview.prefab"
	}
end

function DragontrialViewPresentor:buildViews()
	return {
		DragontrialView.New()
	}
end

return DragontrialViewPresentor
