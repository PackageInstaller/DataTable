-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleSkillPkFmtExtViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleSkillPkFmtExtViewPresentor", package.seeall)

local FreeScuffleSkillPkFmtExtViewPresentor = class("FreeScuffleSkillPkFmtExtViewPresentor", ViewPresentor)

function FreeScuffleSkillPkFmtExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffleSkillPkFmtExtViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescuffleskillpkfmtextview.prefab"
	}
end

function FreeScuffleSkillPkFmtExtViewPresentor:buildViews()
	return {
		FreeScuffleSkillPkFmtExtView.New()
	}
end

function FreeScuffleSkillPkFmtExtViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FreeScuffleSkillPkFmtExtViewPresentor
