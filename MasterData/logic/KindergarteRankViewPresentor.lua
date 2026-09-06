-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteRankViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergarteRankViewPresentor", package.seeall)

local KindergarteRankViewPresentor = class("KindergarteRankViewPresentor", ViewPresentor)

function KindergarteRankViewPresentor:ctor()
	KindergarteRankViewPresentor.super.ctor(self)
end

function KindergarteRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergarteRankViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergarterankview.prefab"
	}
end

function KindergarteRankViewPresentor:buildViews()
	return {
		KindergarteRankView.New()
	}
end

return KindergarteRankViewPresentor
