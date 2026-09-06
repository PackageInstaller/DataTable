-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartelevelViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergartelevelViewPresentor", package.seeall)

local KindergartelevelViewPresentor = class("KindergartelevelViewPresentor", ViewPresentor)

function KindergartelevelViewPresentor:ctor()
	KindergartelevelViewPresentor.super.ctor(self)
end

function KindergartelevelViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KindergartelevelViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergartelevelview.prefab"
	}
end

function KindergartelevelViewPresentor:buildViews()
	return {
		KindergartelevelView.New()
	}
end

return KindergartelevelViewPresentor
