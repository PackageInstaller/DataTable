-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossLevelViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossLevelViewPresentor", package.seeall)

local NightFeastBossLevelViewPresentor = class("NightFeastBossLevelViewPresentor", ViewPresentor)

function NightFeastBossLevelViewPresentor:ctor()
	NightFeastBossLevelViewPresentor.super.ctor(self)
end

function NightFeastBossLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbosslevelview.prefab"
	}
end

function NightFeastBossLevelViewPresentor:buildViews()
	return {
		NightFeastBossLevelView.New()
	}
end

return NightFeastBossLevelViewPresentor
