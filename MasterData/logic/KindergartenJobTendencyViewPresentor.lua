-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartenJobTendencyViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergartenJobTendencyViewPresentor", package.seeall)

local KindergartenJobTendencyViewPresentor = class("KindergartenJobTendencyViewPresentor", ViewPresentor)

function KindergartenJobTendencyViewPresentor:ctor()
	KindergartenJobTendencyViewPresentor.super.ctor(self)
end

function KindergartenJobTendencyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergartenJobTendencyViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergartenjobtendencyview.prefab"
	}
end

function KindergartenJobTendencyViewPresentor:buildViews()
	return {
		KindergartenJobTendencyView.New()
	}
end

return KindergartenJobTendencyViewPresentor
