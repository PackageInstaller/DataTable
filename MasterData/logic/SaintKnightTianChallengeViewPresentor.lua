-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/SaintKnightTianChallengeViewPresentor.lua

module("logic.extensions.saintknighttian.view.SaintKnightTianChallengeViewPresentor", package.seeall)

local SaintKnightTianChallengeViewPresentor = class("SaintKnightTianChallengeViewPresentor", ViewPresentor)

function SaintKnightTianChallengeViewPresentor:ctor()
	SaintKnightTianChallengeViewPresentor.super.ctor(self)
end

function SaintKnightTianChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightTianChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttian/saintknighttianstormview.prefab"
	}
end

function SaintKnightTianChallengeViewPresentor:buildViews()
	return {
		SaintKnightTianChallengeView.New()
	}
end

return SaintKnightTianChallengeViewPresentor
