-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBagViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityBagViewPresentor", package.seeall)

local EternalCityBagViewPresentor = class("EternalCityBagViewPresentor", ViewPresentor)

function EternalCityBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityBagViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitybagview.prefab"
	}
end

function EternalCityBagViewPresentor:buildViews()
	return {
		EternalCityBagView.New()
	}
end

return EternalCityBagViewPresentor
