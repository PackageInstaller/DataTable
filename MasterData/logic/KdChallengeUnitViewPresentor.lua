-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeUnitViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeUnitViewPresentor", package.seeall)

local KdChallengeUnitViewPresentor = class("KdChallengeUnitViewPresentor", ViewPresentor)

function KdChallengeUnitViewPresentor:ctor()
	KdChallengeUnitViewPresentor.super.ctor(self)
end

function KdChallengeUnitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KdChallengeUnitViewPresentor:dependWhatResources()
	return {
		"ui/views/kingdragonchallenge/kdchallengeunitview.prefab"
	}
end

function KdChallengeUnitViewPresentor:buildViews()
	return {
		KdChallengeUnitView.New()
	}
end

return KdChallengeUnitViewPresentor
