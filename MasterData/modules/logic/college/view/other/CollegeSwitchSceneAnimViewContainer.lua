-- chunkname: @modules/logic/college/view/other/CollegeSwitchSceneAnimViewContainer.lua

module("modules.logic.college.view.other.CollegeSwitchSceneAnimViewContainer", package.seeall)

local CollegeSwitchSceneAnimViewContainer = class("CollegeSwitchSceneAnimViewContainer", BaseViewContainer)

function CollegeSwitchSceneAnimViewContainer:buildViews()
	return {}
end

function CollegeSwitchSceneAnimViewContainer:onContainerOpen()
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.SwitchScene)

	local animWrap = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._anim = SLFramework.AnimatorPlayer.Get(self.viewGO)

	local animName = CollegeModel.instance.curSceneType == CollegeEnum.SceneType.City and "switch_college" or "switch_map"

	animWrap:AddEventListener(animName, self._delaySwitchScene, self)
	self._anim:Play(animName, self.onPlayFinish, self)
end

function CollegeSwitchSceneAnimViewContainer:_delaySwitchScene()
	self._isSwitchKey = true

	CollegeController.instance:dispatchEvent(CollegeEvent.RealSwitchScene)
end

function CollegeSwitchSceneAnimViewContainer:onPlayFinish()
	self:closeThis()
end

function CollegeSwitchSceneAnimViewContainer:onContainerClose()
	if not self._isSwitchKey then
		CollegeController.instance:dispatchEvent(CollegeEvent.RealSwitchScene)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeSceneTypeEnd)
end

return CollegeSwitchSceneAnimViewContainer
