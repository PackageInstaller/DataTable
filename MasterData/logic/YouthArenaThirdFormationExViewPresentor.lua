-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdFormationExViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdFormationExViewPresentor", package.seeall)

local YouthArenaThirdFormationExViewPresentor = class("YouthArenaThirdFormationExViewPresentor", ViewPresentor)

function YouthArenaThirdFormationExViewPresentor:ctor()
	YouthArenaThirdFormationExViewPresentor.super.ctor(self)
end

function YouthArenaThirdFormationExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdFormationExViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdformationexview.prefab"
	}
end

function YouthArenaThirdFormationExViewPresentor:buildViews()
	return {
		YouthArenaThirdFormationExView.New()
	}
end

function YouthArenaThirdFormationExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YouthArenaThirdFormationExViewPresentor
