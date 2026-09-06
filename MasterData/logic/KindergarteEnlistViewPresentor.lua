-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteEnlistViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergarteEnlistViewPresentor", package.seeall)

local KindergarteEnlistViewPresentor = class("KindergarteEnlistViewPresentor", ViewPresentor)

function KindergarteEnlistViewPresentor:ctor()
	KindergarteEnlistViewPresentor.super.ctor(self)
end

function KindergarteEnlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergarteEnlistViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergarteenlistview.prefab"
	}
end

function KindergarteEnlistViewPresentor:buildViews()
	return {
		KindergarteEnlistView.New()
	}
end

return KindergarteEnlistViewPresentor
