-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossSwitchViewPresentor.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossSwitchViewPresentor", package.seeall)

local NightFeastBossSwitchViewPresentor = class("NightFeastBossSwitchViewPresentor", ViewPresentor)

function NightFeastBossSwitchViewPresentor:ctor()
	NightFeastBossSwitchViewPresentor.super.ctor(self)
end

function NightFeastBossSwitchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NightFeastBossSwitchViewPresentor:dependWhatResources()
	return {
		"ui/views/nightfeastbosschallenge/nightfeastbossswitchview.prefab"
	}
end

function NightFeastBossSwitchViewPresentor:buildViews()
	return {
		NightFeastBossSwitchView.New()
	}
end

return NightFeastBossSwitchViewPresentor
