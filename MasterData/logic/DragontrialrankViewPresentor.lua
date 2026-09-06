-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialrankViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrialrankViewPresentor", package.seeall)

local DragontrialrankViewPresentor = class("DragontrialrankViewPresentor", ViewPresentor)

function DragontrialrankViewPresentor:ctor()
	DragontrialrankViewPresentor.super.ctor(self)
end

function DragontrialrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrialrankViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrialrankview.prefab"
	}
end

function DragontrialrankViewPresentor:buildViews()
	return {
		DragontrialrankView.New()
	}
end

return DragontrialrankViewPresentor
