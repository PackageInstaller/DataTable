-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmViewPresentor.lua

module("logic.extensions.eternalfarm.view.EternalFarmViewPresentor", package.seeall)

local EternalFarmViewPresentor = class("EternalFarmViewPresentor", ViewPresentor)

function EternalFarmViewPresentor:ctor()
	EternalFarmViewPresentor.super.ctor(self)
end

function EternalFarmViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalFarmViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalfarm/eternalfarmview.prefab"
	}
end

function EternalFarmViewPresentor:buildViews()
	return {
		EternalFarmView.New()
	}
end

return EternalFarmViewPresentor
