-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityProsperityViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityProsperityViewPresentor", package.seeall)

local EternalCityProsperityViewPresentor = class("EternalCityProsperityViewPresentor", ViewPresentor)

function EternalCityProsperityViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EternalCityProsperityViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcityprosperityview.prefab"
	}
end

function EternalCityProsperityViewPresentor:buildViews()
	return {
		EternalCityProsperityView.New()
	}
end

return EternalCityProsperityViewPresentor
