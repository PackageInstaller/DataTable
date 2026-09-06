-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartemanageViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergartemanageViewPresentor", package.seeall)

local KindergartemanageViewPresentor = class("KindergartemanageViewPresentor", ViewPresentor)

function KindergartemanageViewPresentor:ctor()
	KindergartemanageViewPresentor.super.ctor(self)
end

function KindergartemanageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergartemanageViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergartemanageview.prefab"
	}
end

function KindergartemanageViewPresentor:buildViews()
	return {
		KindergartemanageView.New()
	}
end

return KindergartemanageViewPresentor
