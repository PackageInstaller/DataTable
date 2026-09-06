-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmMainViewPresentor.lua

module("logic.extensions.eternalfarm.view.EternalFarmMainViewPresentor", package.seeall)

local EternalFarmMainViewPresentor = class("EternalFarmMainViewPresentor", ViewPresentor)

function EternalFarmMainViewPresentor:ctor()
	EternalFarmMainViewPresentor.super.ctor(self)
end

function EternalFarmMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalFarmMainViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalfarm/eternalfarmmainview.prefab"
	}
end

function EternalFarmMainViewPresentor:buildViews()
	return {
		EternalFarmMainView.New()
	}
end

return EternalFarmMainViewPresentor
