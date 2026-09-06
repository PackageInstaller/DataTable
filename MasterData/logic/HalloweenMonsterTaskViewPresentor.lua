-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenMonsterTaskViewPresentor.lua

module("logic.extensions.halloweenguest.view.HalloweenMonsterTaskViewPresentor", package.seeall)

local HalloweenMonsterTaskViewPresentor = class("HalloweenMonsterTaskViewPresentor", ViewWithGuidePresentor)

function HalloweenMonsterTaskViewPresentor:ctor()
	HalloweenMonsterTaskViewPresentor.super.ctor(self)
end

function HalloweenMonsterTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HalloweenMonsterTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/halloweenguest/halloweenmonstertaskview.prefab"
	}
end

function HalloweenMonsterTaskViewPresentor:buildViews()
	return {
		HalloweenMonsterTaskView.New()
	}
end

return HalloweenMonsterTaskViewPresentor
