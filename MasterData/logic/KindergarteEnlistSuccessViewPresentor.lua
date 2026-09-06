-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteEnlistSuccessViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergarteEnlistSuccessViewPresentor", package.seeall)

local KindergarteEnlistSuccessViewPresentor = class("KindergarteEnlistSuccessViewPresentor", ViewPresentor)

function KindergarteEnlistSuccessViewPresentor:ctor()
	KindergarteEnlistSuccessViewPresentor.super.ctor(self)
end

function KindergarteEnlistSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergarteEnlistSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergarteenlistsuccessview.prefab"
	}
end

function KindergarteEnlistSuccessViewPresentor:buildViews()
	return {
		KindergarteEnlistSuccessView.New()
	}
end

return KindergarteEnlistSuccessViewPresentor
