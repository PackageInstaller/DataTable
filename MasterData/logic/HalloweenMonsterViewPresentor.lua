-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenMonsterViewPresentor.lua

module("logic.extensions.halloweenguest.view.HalloweenMonsterViewPresentor", package.seeall)

local HalloweenMonsterViewPresentor = class("HalloweenMonsterViewPresentor", ViewWithGuidePresentor)

function HalloweenMonsterViewPresentor:ctor()
	HalloweenMonsterViewPresentor.super.ctor(self)
end

function HalloweenMonsterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HalloweenMonsterViewPresentor:dependWhatResources()
	return {
		"ui/views/halloweenguest/halloweenmonsterview.prefab"
	}
end

function HalloweenMonsterViewPresentor:buildViews()
	return {
		HalloweenMonsterView.New()
	}
end

return HalloweenMonsterViewPresentor
