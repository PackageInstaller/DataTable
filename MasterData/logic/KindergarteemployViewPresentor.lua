-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteemployViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergarteemployViewPresentor", package.seeall)

local KindergarteemployViewPresentor = class("KindergarteemployViewPresentor", ViewPresentor)

function KindergarteemployViewPresentor:ctor()
	KindergarteemployViewPresentor.super.ctor(self)
end

function KindergarteemployViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergarteemployViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergarteemployview.prefab"
	}
end

function KindergarteemployViewPresentor:buildViews()
	return {
		KindergarteemployView.New()
	}
end

return KindergarteemployViewPresentor
