-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartefacilityViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergartefacilityViewPresentor", package.seeall)

local KindergartefacilityViewPresentor = class("KindergartefacilityViewPresentor", ViewPresentor)

function KindergartefacilityViewPresentor:ctor()
	KindergartefacilityViewPresentor.super.ctor(self)
end

function KindergartefacilityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergartefacilityViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergartefacilityview.prefab"
	}
end

function KindergartefacilityViewPresentor:buildViews()
	return {
		KindergartefacilityView.New()
	}
end

return KindergartefacilityViewPresentor
