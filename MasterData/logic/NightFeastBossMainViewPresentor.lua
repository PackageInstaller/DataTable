-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossMainViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossMainViewPresentor", package.seeall)

local NightFeastBossMainViewPresentor = class("NightFeastBossMainViewPresentor", ViewPresentor)

function NightFeastBossMainViewPresentor:ctor()
	NightFeastBossMainViewPresentor.super.ctor(self)
end

function NightFeastBossMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossMainViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossmainview.prefab"
	}
end

function NightFeastBossMainViewPresentor:buildViews()
	return {
		NightFeastBossMainView.New()
	}
end

return NightFeastBossMainViewPresentor
