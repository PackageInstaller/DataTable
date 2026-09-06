-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenBossViewPresentor.lua

module("logic.extensions.halloweenguest.view.HalloweenBossViewPresentor", package.seeall)

local HalloweenBossViewPresentor = class("HalloweenBossViewPresentor", ViewWithGuidePresentor)

function HalloweenBossViewPresentor:ctor()
	HalloweenBossViewPresentor.super.ctor(self)
end

function HalloweenBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HalloweenBossViewPresentor:dependWhatResources()
	return {
		"ui/views/halloweenguest/halloweenbossview.prefab"
	}
end

function HalloweenBossViewPresentor:buildViews()
	return {
		HalloweenBossView.New()
	}
end

return HalloweenBossViewPresentor
