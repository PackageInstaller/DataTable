-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityRankViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityRankViewPresentor", package.seeall)

local EternalCityRankViewPresentor = class("EternalCityRankViewPresentor", ViewPresentor)

function EternalCityRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityRankViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcityrankview.prefab"
	}
end

function EternalCityRankViewPresentor:buildViews()
	return {
		EternalCityRankView.New()
	}
end

return EternalCityRankViewPresentor
