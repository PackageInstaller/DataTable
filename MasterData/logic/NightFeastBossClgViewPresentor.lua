-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossClgViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossClgViewPresentor", package.seeall)

local NightFeastBossClgViewPresentor = class("NightFeastBossClgViewPresentor", ViewPresentor)

function NightFeastBossClgViewPresentor:ctor()
	NightFeastBossClgViewPresentor.super.ctor(self)
end

function NightFeastBossClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossClgViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossclgview.prefab"
	}
end

function NightFeastBossClgViewPresentor:buildViews()
	return {
		NightFeastBossClgView.New()
	}
end

return NightFeastBossClgViewPresentor
