-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityActiveBuildViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityActiveBuildViewPresentor", package.seeall)

local EternalCityActiveBuildViewPresentor = class("EternalCityActiveBuildViewPresentor", ViewPresentor)

function EternalCityActiveBuildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EternalCityActiveBuildViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcityactivebuildview.prefab"
	}
end

function EternalCityActiveBuildViewPresentor:buildViews()
	return {
		EternalCityActiveBuildView.New()
	}
end

return EternalCityActiveBuildViewPresentor
