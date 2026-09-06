-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclexiuer/view/MiracleXiuerChallengeViewPresentor.lua

module("logic.extensions.miraclexiuer.view.MiracleXiuerChallengeViewPresentor", package.seeall)

local MiracleXiuerChallengeViewPresentor = class("MiracleXiuerChallengeViewPresentor", ViewPresentor)

function MiracleXiuerChallengeViewPresentor:ctor()
	MiracleXiuerChallengeViewPresentor.super.ctor(self)
end

function MiracleXiuerChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleXiuerChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclexiuer/miraclexiuerchallengeview.prefab"
	}
end

function MiracleXiuerChallengeViewPresentor:buildViews()
	return {
		MiracleXiuerChallengeView.New()
	}
end

return MiracleXiuerChallengeViewPresentor
