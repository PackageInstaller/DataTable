-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleLightFloorViewPresentor.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleLightFloorViewPresentor", package.seeall)

local HolyDragonTempleLightFloorViewPresentor = class("HolyDragonTempleLightFloorViewPresentor", ViewPresentor)

function HolyDragonTempleLightFloorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonTempleLightFloorViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragontemple/holydragontemplelightfloorview.prefab"
	}
end

function HolyDragonTempleLightFloorViewPresentor:buildViews()
	return {
		HolyDragonTempleLightFloorView.New()
	}
end

function HolyDragonTempleLightFloorViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyDragonTempleLightFloorViewPresentor
