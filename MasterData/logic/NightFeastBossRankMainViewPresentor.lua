-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossRankMainViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossRankMainViewPresentor", package.seeall)

local NightFeastBossRankMainViewPresentor = class("NightFeastBossRankMainViewPresentor", ViewPresentor)

function NightFeastBossRankMainViewPresentor:ctor()
	NightFeastBossRankMainViewPresentor.super.ctor(self)
end

function NightFeastBossRankMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossRankMainViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossrankmainview.prefab"
	}
end

function NightFeastBossRankMainViewPresentor:buildViews()
	return {
		NightFeastBossRankMainView.New()
	}
end

return NightFeastBossRankMainViewPresentor
