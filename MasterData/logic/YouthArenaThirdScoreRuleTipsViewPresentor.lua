-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdScoreRuleTipsViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdScoreRuleTipsViewPresentor", package.seeall)

local YouthArenaThirdScoreRuleTipsViewPresentor = class("YouthArenaThirdScoreRuleTipsViewPresentor", ViewPresentor)

function YouthArenaThirdScoreRuleTipsViewPresentor:ctor()
	YouthArenaThirdScoreRuleTipsViewPresentor.super.ctor(self)
end

function YouthArenaThirdScoreRuleTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdScoreRuleTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdscoreruletipsview.prefab"
	}
end

function YouthArenaThirdScoreRuleTipsViewPresentor:buildViews()
	return {
		YouthArenaThirdScoreRuleTipsView.New()
	}
end

return YouthArenaThirdScoreRuleTipsViewPresentor
