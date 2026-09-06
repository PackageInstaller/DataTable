-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitBossBuffViewPresentor.lua

module("logic.extensions.hitboss.view.HitBossBuffViewPresentor", package.seeall)

local HitBossBuffViewPresentor = class("HitBossBuffViewPresentor", ViewPresentor)

function HitBossBuffViewPresentor:ctor()
	HitBossBuffViewPresentor.super.ctor(self)
end

function HitBossBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HitBossBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/hitboss/hitbossbuffview.prefab"
	}
end

function HitBossBuffViewPresentor:buildViews()
	return {
		HitBossBuffView.New()
	}
end

return HitBossBuffViewPresentor
