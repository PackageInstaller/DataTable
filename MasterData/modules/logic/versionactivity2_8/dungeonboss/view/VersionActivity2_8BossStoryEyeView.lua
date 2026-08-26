-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossStoryEyeView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEyeView", package.seeall)

local VersionActivity2_8BossStoryEyeView = class("VersionActivity2_8BossStoryEyeView", BaseView)

function VersionActivity2_8BossStoryEyeView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8BossStoryEyeView:addEvents()
	return
end

function VersionActivity2_8BossStoryEyeView:removeEvents()
	return
end

function VersionActivity2_8BossStoryEyeView:_editableInitView()
	return
end

function VersionActivity2_8BossStoryEyeView:onUpdateParam()
	return
end

VersionActivity2_8BossStoryEyeView.camerControllerPath = "bossstory_eye_camera"

function VersionActivity2_8BossStoryEyeView:onOpen()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
	self.addEventCb(self, FightController.instance, FightEvent.ModifyDelayTime, self._onModifyDelayTime, self)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscHandler, self)
end

function VersionActivity2_8BossStoryEyeView:_onEscHandler()
	return
end

function VersionActivity2_8BossStoryEyeView:_onModifyDelayTime(param)
	if self._animLength then
		param.time = self._animLength
	end
end

function VersionActivity2_8BossStoryEyeView:_onHeroGroupExit()
	local animator = self.viewGO:GetComponent("Animator")

	if animator then
		animator:Play("end", 0, 0)
	end

	self:_playCameraAnim()
	TaskDispatcher.runDelay(self._animDone, self, self._animLength)
end

function VersionActivity2_8BossStoryEyeView:getRes(abPath, assetPath)
	local assetItem = self.viewContainer._abLoader:getAssetItem(abPath)

	if assetItem then
		return assetItem:GetResource(assetPath)
	end

	return nil
end

function VersionActivity2_8BossStoryEyeView:_playCameraAnim()
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._rawController = self._cameraAnimator.runtimeAnimatorController
	self._rawEnabled = self._cameraAnimator.enabled
	self._cameraAnimator.enabled = true
	self._cameraAnimator.runtimeAnimatorController = self:getRes(FightHelper.getCameraAniPath(VersionActivity2_8BossStoryEyeView.camerControllerPath), ResUrl.getCameraAnim(VersionActivity2_8BossStoryEyeView.camerControllerPath))

	local animName = "bossstory_camera_eye"

	self._cameraAnimator:Play(animName, 0, 0)

	self._animLength = 2.2

	AudioMgr.instance:trigger(AudioEnum2_8.BossStory.play_ui_fuleyuan_boss_eye_open)
end

function VersionActivity2_8BossStoryEyeView:_animDone()
	self:closeThis()
end

function VersionActivity2_8BossStoryEyeView:onClose()
	if self._cameraAnimator then
		self._cameraAnimator.enabled = self._rawEnabled
		self._cameraAnimator.runtimeAnimatorController = self._rawController
	end

	TaskDispatcher.cancelTask(self._animDone, self)
end

function VersionActivity2_8BossStoryEyeView:onDestroyView()
	return
end

return VersionActivity2_8BossStoryEyeView
