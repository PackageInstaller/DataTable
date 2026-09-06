-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossRankViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossRankViewPresentor", package.seeall)

local NightFeastBossRankViewPresentor = class("NightFeastBossRankViewPresentor", ViewPresentor)

function NightFeastBossRankViewPresentor:ctor()
	NightFeastBossRankViewPresentor.super.ctor(self)
end

function NightFeastBossRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossRankViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossrankview.prefab"
	}
end

function NightFeastBossRankViewPresentor:buildViews()
	return {
		NightFeastBossRankView.New()
	}
end

return NightFeastBossRankViewPresentor
