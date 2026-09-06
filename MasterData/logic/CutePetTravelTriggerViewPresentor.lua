-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutePetTravelTriggerViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetTravelTriggerViewPresentor", package.seeall)

local CutePetTravelTriggerViewPresentor = class("CutePetTravelTriggerViewPresentor", ViewPresentor)

function CutePetTravelTriggerViewPresentor:ctor()
	CutePetTravelTriggerViewPresentor.super.ctor(self)
end

function CutePetTravelTriggerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutePetTravelTriggerViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepettraveltriggerview.prefab"
	}
end

function CutePetTravelTriggerViewPresentor:buildViews()
	return {
		CutePetTravelTriggerView.New()
	}
end

return CutePetTravelTriggerViewPresentor
