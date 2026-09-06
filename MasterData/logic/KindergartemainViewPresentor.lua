-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartemainViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergartemainViewPresentor", package.seeall)

local KindergartemainViewPresentor = class("KindergartemainViewPresentor", ViewPresentor)

function KindergartemainViewPresentor:ctor()
	KindergartemainViewPresentor.super.ctor(self)
end

function KindergartemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergartemainViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergartemainview.prefab"
	}
end

function KindergartemainViewPresentor:buildViews()
	return {
		KindergartemainView.New()
	}
end

return KindergartemainViewPresentor
