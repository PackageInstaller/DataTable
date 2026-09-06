-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrChallengeMainViewPresentor.lua

module("logic.extensions.corpr.view.CorPrChallengeMainViewPresentor", package.seeall)

local CorPrChallengeMainViewPresentor = class("CorPrChallengeMainViewPresentor", ViewPresentor)

function CorPrChallengeMainViewPresentor:ctor()
	CorPrChallengeMainViewPresentor.super.ctor(self)
end

function CorPrChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CorPrChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/corpr/corprchallengemainview.prefab"
	}
end

function CorPrChallengeMainViewPresentor:buildViews()
	return {
		CorPrChallengeMainView.New()
	}
end

return CorPrChallengeMainViewPresentor
