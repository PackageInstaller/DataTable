-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveChallengeViewPresentor.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveChallengeViewPresentor", package.seeall)

local NaiLongEvolveChallengeViewPresentor = class("NaiLongEvolveChallengeViewPresentor", ViewPresentor)

function NaiLongEvolveChallengeViewPresentor:ctor()
	NaiLongEvolveChallengeViewPresentor.super.ctor(self)
end

function NaiLongEvolveChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongEvolveChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/nailongevolve/nailongevolvechallengeview.prefab"
	}
end

function NaiLongEvolveChallengeViewPresentor:buildViews()
	return {
		NaiLongEvolveChallengeView.New()
	}
end

return NaiLongEvolveChallengeViewPresentor
