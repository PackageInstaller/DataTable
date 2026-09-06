-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrailstrategyViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrailstrategyViewPresentor", package.seeall)

local DragontrailstrategyViewPresentor = class("DragontrailstrategyViewPresentor", ViewPresentor)

function DragontrailstrategyViewPresentor:ctor()
	DragontrailstrategyViewPresentor.super.ctor(self)
end

function DragontrailstrategyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrailstrategyViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrailstrategyview.prefab"
	}
end

function DragontrailstrategyViewPresentor:buildViews()
	return {
		DragontrailstrategyView.New()
	}
end

return DragontrailstrategyViewPresentor
