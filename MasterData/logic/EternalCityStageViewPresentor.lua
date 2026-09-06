-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityStageViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityStageViewPresentor", package.seeall)

local EternalCityStageViewPresentor = class("EternalCityStageViewPresentor", ViewPresentor)

function EternalCityStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityStageViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitystageview.prefab"
	}
end

function EternalCityStageViewPresentor:buildViews()
	return {
		EternalCityStageView.New()
	}
end

return EternalCityStageViewPresentor
