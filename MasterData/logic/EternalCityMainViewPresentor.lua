-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityMainViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityMainViewPresentor", package.seeall)

local EternalCityMainViewPresentor = class("EternalCityMainViewPresentor", ViewPresentor)

function EternalCityMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityMainViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitymainview.prefab"
	}
end

function EternalCityMainViewPresentor:buildViews()
	return {
		EternalCityMainView.New()
	}
end

return EternalCityMainViewPresentor
