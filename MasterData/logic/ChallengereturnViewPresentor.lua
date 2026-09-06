-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/ChallengereturnViewPresentor.lua

module("logic.extensions.bonus.view.christmasandnewyear.ChallengereturnViewPresentor", package.seeall)

local ChallengereturnViewPresentor = class("ChallengereturnViewPresentor", ViewPresentor)

function ChallengereturnViewPresentor:ctor()
	ChallengereturnViewPresentor.super.ctor(self)
end

function ChallengereturnViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChallengereturnViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/christmasandnewyear/fullawakengiftview.prefab"
	}
end

function ChallengereturnViewPresentor:buildViews()
	return {
		ChallengereturnView.New()
	}
end

return ChallengereturnViewPresentor
