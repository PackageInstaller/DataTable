-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/view/PetGainPrizeViewPresentor.lua

module("logic.extensions.timeserverpetgain.view.PetGainPrizeViewPresentor", package.seeall)

local PetGainPrizeViewPresentor = class("PetGainPrizeViewPresentor", ViewPresentor)

function PetGainPrizeViewPresentor:ctor()
	PetGainPrizeViewPresentor.super.ctor(self)
end

function PetGainPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetGainPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/timeserverpetgain/petgainprizeview.prefab"
	}
end

function PetGainPrizeViewPresentor:buildViews()
	return {
		PetGainPrizeView.New()
	}
end

return PetGainPrizeViewPresentor
