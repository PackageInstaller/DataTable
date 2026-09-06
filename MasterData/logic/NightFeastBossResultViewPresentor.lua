-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossResultViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossResultViewPresentor", package.seeall)

local NightFeastBossResultViewPresentor = class("NightFeastBossResultViewPresentor", ViewPresentor)

function NightFeastBossResultViewPresentor:ctor()
	NightFeastBossResultViewPresentor.super.ctor(self)
end

function NightFeastBossResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossResultViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossresultview.prefab"
	}
end

function NightFeastBossResultViewPresentor:buildViews()
	return {
		NightFeastBossResultView.New()
	}
end

return NightFeastBossResultViewPresentor
