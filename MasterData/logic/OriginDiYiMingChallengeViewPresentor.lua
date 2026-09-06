-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindiyiming/view/OriginDiYiMingChallengeViewPresentor.lua

module("logic.extensions.origindiyiming.view.OriginDiYiMingChallengeViewPresentor", package.seeall)

local OriginDiYiMingChallengeViewPresentor = class("OriginDiYiMingChallengeViewPresentor", ViewPresentor)

function OriginDiYiMingChallengeViewPresentor:ctor()
	OriginDiYiMingChallengeViewPresentor.super.ctor(self)
end

function OriginDiYiMingChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDiYiMingChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/origindiyiming/origindiyimingchallengeview.prefab"
	}
end

function OriginDiYiMingChallengeViewPresentor:buildViews()
	return {
		OriginDiYiMingChallengeView.New()
	}
end

return OriginDiYiMingChallengeViewPresentor
