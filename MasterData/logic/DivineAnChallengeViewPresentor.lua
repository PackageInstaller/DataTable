-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnChallengeViewPresentor.lua

module("logic.extensions.divinean.view.DivineAnChallengeViewPresentor", package.seeall)

local DivineAnChallengeViewPresentor = class("DivineAnChallengeViewPresentor", ViewPresentor)

function DivineAnChallengeViewPresentor:ctor()
	DivineAnChallengeViewPresentor.super.ctor(self)
end

function DivineAnChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineAnChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinean/divineanchallengeview.prefab"
	}
end

function DivineAnChallengeViewPresentor:buildViews()
	return {
		DivineAnChallengeView.New()
	}
end

return DivineAnChallengeViewPresentor
