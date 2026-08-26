-- chunkname: @modules/logic/sp01/enter/view/VersionActivity2_9EnterViewAnimComp.lua

module("modules.logic.sp01.enter.view.VersionActivity2_9EnterViewAnimComp", package.seeall)

local VersionActivity2_9EnterViewAnimComp = class("VersionActivity2_9EnterViewAnimComp", BaseView)
local FirstHalfBgIndex = 1
local SecondHalfBgIndex = 2
local LockScreenKey = "VersionActivity2_9EnterViewAnimComp"

function VersionActivity2_9EnterViewAnimComp:onInitView()
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_switch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_9EnterViewAnimComp:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	self.addEventCb(self, VersionActivity2_9EnterController.instance, VersionActivity2_9Event.UnlockNextHalf, self._onUnlockNextHalf, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
end

function VersionActivity2_9EnterViewAnimComp:removeEvents()
	self._btnswitch:RemoveClickListener()
end

function VersionActivity2_9EnterViewAnimComp:_btnswitchOnClick()
	local isOpen = ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.EnterView2)

	if not isOpen then
		return
	end

	AssassinHelper.lockScreen(LockScreenKey, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Enter.play_ui_switch)
	self._animator:Play("click", 0, 0)
	self:playCameraAnim()
	self:playHeroTargetAnim("b_click")
	TaskDispatcher.runDelay(self.onSwitchAnimDone, self, VersionActivity2_9Enum.DelaySwitchBgTime)
	TaskDispatcher.runDelay(self.playHeroAnim, self, VersionActivity2_9Enum.DelaySwitchHero2Idle)
	VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.SwitchGroup)
end

function VersionActivity2_9EnterViewAnimComp:onOpen()
	self:loadScene()
end

function VersionActivity2_9EnterViewAnimComp:loadScene()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = gohelper.create3d(sceneRoot, "VersionActivity2_9EnterView")

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, 0, 0)

	local sceneResUrl = self.viewContainer:getSetting().otherRes[1]

	self._sceneGO = self:getResInst(sceneResUrl, self._sceneRoot, "scene")

	self:loadSceneDone()
end

function VersionActivity2_9EnterViewAnimComp:loadSceneDone()
	self:initScene()
	self:initCamera()
end

function VersionActivity2_9EnterViewAnimComp:initScene()
	self._gocanvas = gohelper.findChild(self._sceneGO, "BackGround/#go_bgCanvas")
	self._bgcanvas = self._gocanvas:GetComponent("Canvas")
	self._bgcanvas.worldCamera = CameraMgr.instance:getMainCamera()
	self._backgroundTab = self:getUserDataTb_()
	self._backgroundTab[1] = gohelper.findChild(self._sceneGO, "BackGround/#go_bgCanvas/sp01_m_s17_kv_plant_a")
	self._backgroundTab[2] = gohelper.findChild(self._sceneGO, "BackGround/#go_bgCanvas/sp01_m_s17_kv_plant_b")
	self._bgVideoTab = self:getUserDataTb_()
	self._bgVideoTab[1] = VersionActivityVideoComp.get(self._backgroundTab[1], self)
	self._bgVideoTab[2] = VersionActivityVideoComp.get(self._backgroundTab[2], self)
	self._animator = gohelper.onceAddComponent(self._sceneGO, gohelper.Type_Animator)
	self._godynamicspine = gohelper.findChild(self._sceneGO, "BackGround/spine")
	self._godynamicspineanim = gohelper.findChild(self._sceneGO, "BackGround/spine/aim/spine")
	self._spineAnim = gohelper.onceAddComponent(self._godynamicspineanim, typeof(Spine.Unity.SkeletonAnimation))

	self:refresh()

	self.actId = self.viewParam and self.viewParam.actId

	if self.viewParam then
		self.mainActIdList = self.viewParam.mainActIdList or {}
	end

	local groupIndex = tabletool.indexOf(self.mainActIdList, self.actId) or 1

	self:switchBackGround(groupIndex)
end

function VersionActivity2_9EnterViewAnimComp:initCamera()
	if self._cameraPlayer then
		return
	end

	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
	self._preRuntimeAnimatorController = self._cameraAnimator.runtimeAnimatorController
end

function VersionActivity2_9EnterViewAnimComp:playCameraAnim()
	self:setCameraAnimator()
	self._cameraPlayer:Play("click", self._resetCameraAnimator, self)
end

function VersionActivity2_9EnterViewAnimComp:setCameraAnimator()
	local cameraAnimator = gohelper.findChildComponent(self._sceneGO, "#go_cameraAnim", gohelper.Type_Animator)

	self._cameraAnimator.runtimeAnimatorController = cameraAnimator.runtimeAnimatorController
end

function VersionActivity2_9EnterViewAnimComp:_resetCameraAnimator()
	if self._cameraAnimator then
		self._cameraAnimator.runtimeAnimatorController = self._preRuntimeAnimatorController
	end
end

function VersionActivity2_9EnterViewAnimComp:refresh()
	self:playHeroAnim()
	self:playSceneAnim()
end

function VersionActivity2_9EnterViewAnimComp:playHeroAnim()
	self:playHeroTargetAnim(StoryAnimName.B_IDLE)
end

function VersionActivity2_9EnterViewAnimComp:playSceneAnim()
	self._animator:Play("open", 0, 0)
end

function VersionActivity2_9EnterViewAnimComp:playHeroTargetAnim(animationName)
	if not self._spineAnim then
		return
	end

	if not self._spineAnim:HasAnimation(animationName) then
		return
	end

	self._spineAnim:SetAnimation(BaseSpine.FaceTrackIndex, animationName, true, 0)
end

function VersionActivity2_9EnterViewAnimComp:_onRefreshActivityState(actId)
	if actId ~= VersionActivity2_9Enum.ActivityId.EnterView2 then
		return
	end

	self:refresh()
end

function VersionActivity2_9EnterViewAnimComp:switchBackGround(index)
	for i, gobackground in pairs(self._backgroundTab) do
		local isTarget = index == i

		gohelper.setActive(gobackground, isTarget)

		if isTarget then
			local audioUrl = self:getVideoUrl(index)

			self._bgVideoTab[i]:play(audioUrl, true)
		end
	end

	self._curBgIndex = index
end

function VersionActivity2_9EnterViewAnimComp:getVideoUrl(groupIndex)
	if self.mainActIdList then
		local actId = self.mainActIdList[groupIndex]
		local bgAudioName = actId and VersionActivity2_9Enum.ActId2BgAudioName[actId]

		return langVideoUrl(bgAudioName)
	end
end

function VersionActivity2_9EnterViewAnimComp:onSwitchAnimDone()
	if self._curBgIndex == FirstHalfBgIndex then
		if not SecondHalfBgIndex then
			local targetBgIndex = FirstHalfBgIndex

			self:switchBackGround(targetBgIndex)
			AssassinHelper.lockScreen(LockScreenKey, false)
		end
	end
end

function VersionActivity2_9EnterViewAnimComp:_onOpenViewFinish()
	gohelper.setActive(self._sceneRoot, not self:_isAngViewCoverScene())
end

function VersionActivity2_9EnterViewAnimComp:_onCloseView(viewName)
	if viewName == self.viewName then
		return
	end

	if viewName == ViewName.VersionActivity2_9DungeonMapView then
		return
	end

	gohelper.setActive(self._sceneRoot, not self:_isAngViewCoverScene())
end

function VersionActivity2_9EnterViewAnimComp:_onCloseViewFinish(viewName)
	if viewName ~= ViewName.VersionActivity2_9DungeonMapView then
		return
	end

	gohelper.setActive(self._sceneRoot, not self:_isAngViewCoverScene())
end

function VersionActivity2_9EnterViewAnimComp:_isAngViewCoverScene()
	local isCover = false
	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #viewNameList, 1, -1 do
		local viewName = viewNameList[i]

		if viewName == self.viewName then
			break
		end

		if ViewMgr.instance:isFull(viewName) then
			isCover = true

			break
		end
	end

	return isCover
end

function VersionActivity2_9EnterViewAnimComp:_onUnlockNextHalf()
	self._animator:Play("guid", 0, 0)
end

function VersionActivity2_9EnterViewAnimComp:distroyAudios()
	if self._bgVideoTab then
		for _, video in pairs(self._bgVideoTab) do
			if video then
				video:destroy()
			end
		end
	end
end

function VersionActivity2_9EnterViewAnimComp:onClose()
	AssassinHelper.lockScreen(LockScreenKey, false)
	TaskDispatcher.cancelTask(self.playHeroAnim, self)
	TaskDispatcher.cancelTask(self.onSwitchAnimDone, self)
	self:_resetCameraAnimator()
end

function VersionActivity2_9EnterViewAnimComp:onDestroyView()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return VersionActivity2_9EnterViewAnimComp
