-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleSkillFormationExtViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleSkillFormationExtViewPresentor", package.seeall)

local FreeScuffleSkillFormationExtViewPresentor = class("FreeScuffleSkillFormationExtViewPresentor", ViewPresentor)

function FreeScuffleSkillFormationExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffleSkillFormationExtViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescuffleskillformationextview.prefab"
	}
end

function FreeScuffleSkillFormationExtViewPresentor:buildViews()
	return {
		FreeScuffleSkillFormationExtView.New()
	}
end

function FreeScuffleSkillFormationExtViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FreeScuffleSkillFormationExtViewPresentor
