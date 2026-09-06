-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenBossRankViewPresentor.lua

module("logic.extensions.halloweenguest.view.HalloweenBossRankViewPresentor", package.seeall)

local HalloweenBossRankViewPresentor = class("HalloweenBossRankViewPresentor", ViewWithGuidePresentor)

function HalloweenBossRankViewPresentor:ctor()
	HalloweenBossRankViewPresentor.super.ctor(self)
end

function HalloweenBossRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HalloweenBossRankViewPresentor:dependWhatResources()
	return {
		"ui/views/halloweenguest/halloweenbossrankview.prefab"
	}
end

function HalloweenBossRankViewPresentor:buildViews()
	return {
		HalloweenBossRankView.New()
	}
end

return HalloweenBossRankViewPresentor
