-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossBuffViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossBuffViewPresentor", package.seeall)

local NightFeastBossBuffViewPresentor = class("NightFeastBossBuffViewPresentor", ViewPresentor)

function NightFeastBossBuffViewPresentor:ctor()
	NightFeastBossBuffViewPresentor.super.ctor(self)
end

function NightFeastBossBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossbuffview.prefab"
	}
end

function NightFeastBossBuffViewPresentor:buildViews()
	return {
		NightFeastBossBuffView.New()
	}
end

return NightFeastBossBuffViewPresentor
