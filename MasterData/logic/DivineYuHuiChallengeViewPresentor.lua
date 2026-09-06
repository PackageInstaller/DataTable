-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuiChallengeViewPresentor.lua

module("logic.extensions.divineyuhui.view.DivineYuHuiChallengeViewPresentor", package.seeall)

local DivineYuHuiChallengeViewPresentor = class("DivineYuHuiChallengeViewPresentor", ViewPresentor)

function DivineYuHuiChallengeViewPresentor:ctor()
	DivineYuHuiChallengeViewPresentor.super.ctor(self)
end

function DivineYuHuiChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineYuHuiChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/divineyuhui/divineyuhuichallengeview.prefab"
	}
end

function DivineYuHuiChallengeViewPresentor:buildViews()
	return {
		DivineYuHuiChallengeView.New()
	}
end

return DivineYuHuiChallengeViewPresentor
