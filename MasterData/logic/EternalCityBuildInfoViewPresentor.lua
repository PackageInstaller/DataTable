-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildInfoViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityBuildInfoViewPresentor", package.seeall)

local EternalCityBuildInfoViewPresentor = class("EternalCityBuildInfoViewPresentor", ViewPresentor)

function EternalCityBuildInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EternalCityBuildInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitybuildinfoview.prefab"
	}
end

function EternalCityBuildInfoViewPresentor:buildViews()
	return {
		EternalCityBuildInfoView.New()
	}
end

return EternalCityBuildInfoViewPresentor
