-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBossViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityBossViewPresentor", package.seeall)

local EternalCityBossViewPresentor = class("EternalCityBossViewPresentor", ViewPresentor)

function EternalCityBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityBossViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitybossview.prefab"
	}
end

function EternalCityBossViewPresentor:buildViews()
	return {
		EternalCityBossView.New()
	}
end

return EternalCityBossViewPresentor
