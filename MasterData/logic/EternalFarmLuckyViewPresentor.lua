-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmLuckyViewPresentor.lua

module("logic.extensions.eternalfarm.view.EternalFarmLuckyViewPresentor", package.seeall)

local EternalFarmLuckyViewPresentor = class("EternalFarmLuckyViewPresentor", ViewPresentor)

function EternalFarmLuckyViewPresentor:ctor()
	EternalFarmLuckyViewPresentor.super.ctor(self)
end

function EternalFarmLuckyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalFarmLuckyViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalfarm/eternalfarmluckyview.prefab"
	}
end

function EternalFarmLuckyViewPresentor:buildViews()
	return {
		EternalFarmLuckyView.New()
	}
end

return EternalFarmLuckyViewPresentor
