-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossRankSubViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossRankSubViewPresentor", package.seeall)

local NightFeastBossRankSubViewPresentor = class("NightFeastBossRankSubViewPresentor", ViewPresentor)

function NightFeastBossRankSubViewPresentor:ctor()
	NightFeastBossRankSubViewPresentor.super.ctor(self)
end

function NightFeastBossRankSubViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossRankSubViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossranksubview.prefab"
	}
end

function NightFeastBossRankSubViewPresentor:buildViews()
	return {
		NightFeastBossRankSubView.New()
	}
end

function NightFeastBossRankSubViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NightFeastBossRankSubViewPresentor
