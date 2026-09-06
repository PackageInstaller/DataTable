-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialadvancedViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrialadvancedViewPresentor", package.seeall)

local DragontrialadvancedViewPresentor = class("DragontrialadvancedViewPresentor", ViewPresentor)

function DragontrialadvancedViewPresentor:ctor()
	DragontrialadvancedViewPresentor.super.ctor(self)
end

function DragontrialadvancedViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrialadvancedViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrialadvancedview.prefab"
	}
end

function DragontrialadvancedViewPresentor:buildViews()
	return {
		DragontrialadvancedView.New()
	}
end

return DragontrialadvancedViewPresentor
