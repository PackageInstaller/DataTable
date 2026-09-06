-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeUnitPopViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeUnitPopViewPresentor", package.seeall)

local KdChallengeUnitPopViewPresentor = class("KdChallengeUnitPopViewPresentor", ViewPresentor)

function KdChallengeUnitPopViewPresentor:ctor()
	KdChallengeUnitPopViewPresentor.super.ctor(self)
end

function KdChallengeUnitPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KdChallengeUnitPopViewPresentor:dependWhatResources()
	return {
		"ui/views/kingdragonchallenge/kdchallengeunitpopview.prefab"
	}
end

function KdChallengeUnitPopViewPresentor:buildViews()
	return {
		KdChallengeUnitPopView.New()
	}
end

return KdChallengeUnitPopViewPresentor
