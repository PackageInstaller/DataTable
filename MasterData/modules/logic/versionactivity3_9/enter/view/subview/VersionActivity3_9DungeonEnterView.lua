-- chunkname: @modules/logic/versionactivity3_9/enter/view/subview/VersionActivity3_9DungeonEnterView.lua

module("modules.logic.versionactivity3_9.enter.view.subview.VersionActivity3_9DungeonEnterView", package.seeall)

local VersionActivity3_9DungeonEnterView = class("VersionActivity3_9DungeonEnterView", VersionActivityFixedDungeonEnterView)

function VersionActivity3_9DungeonEnterView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._gohardModeUnLock = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_hardModeUnLock")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_9DungeonEnterView:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self._chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()
	self.animComp = VersionActivityFixedHelper.getVersionActivitySubAnimatorComp().get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.actId = VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._gobg = gohelper.findChild(self.viewGO, "#simage_bg")
	self._videoComp = VersionActivityVideoComp.get(self._gobg, self)
	self._animator = self.viewGO:GetComponent("Animator")

	RedDotController.instance:addRedDot(self._goreddot, VersionActivityFixedHelper.getVersionActivityDungeonEnterReddotId())
	self:_setDesc()
end

function VersionActivity3_9DungeonEnterView:_onCloseView(viewName)
	if viewName == ViewName.FullScreenVideoView and self.animComp and self.animComp.skipPlayVideo then
		self.animComp:skipPlayVideo()
	end
end

function VersionActivity3_9DungeonEnterView:onDestroyView()
	VersionActivity3_9DungeonEnterView.super.onDestroyView(self)
	self._videoComp:destroy()

	local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if container and container:isOpen() and container.viewGO and self._fullviewParent then
		gohelper.addChildPosStay(self._fullviewParent, container.viewGO)
		gohelper.setActive(container.viewGO, false)
	end

	TaskDispatcher.cancelTask(self._onVideoStart, self)
end

function VersionActivity3_9DungeonEnterView:onOpenFinish()
	self._videoPath = VersionActivity3_9Enum.EnterLoopVideoName

	if self.viewParam and self.viewParam.playVideo and self.viewContainer and self.viewContainer:getFirstOpenActId() == self.actId then
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self._videoComp:loadMedia(self._videoPath)

		self._fullviewParent = nil

		local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

		if container and container:isOpen() and container.viewGO then
			self._fullviewParent = container.viewGO.transform.parent

			gohelper.addChildPosStay(self._gobg, container.viewGO)
		end
	else
		if SDKMgr.instance:isEmulator() then
			TaskDispatcher.cancelTask(self._onVideoStart, self)
			TaskDispatcher.runDelay(self._onVideoStart, self, 2)
			self._animator:Play(UIAnimationName.Open, 0, 0)

			self._animator.speed = 0

			self._videoComp:setStartCallback(self._onVideoStart, self)
		end

		self._videoComp:play(self._videoPath, true)
	end

	self:_setVideoAsLastSibling()
end

function VersionActivity3_9DungeonEnterView:_onVideoStart()
	TaskDispatcher.cancelTask(self._onVideoStart, self)
	self._videoComp:setStartCallback()

	self._animator.speed = 1
end

function VersionActivity3_9DungeonEnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self._videoComp:play(self._videoPath, true)
end

function VersionActivity3_9DungeonEnterView:_setVideoAsLastSibling()
	local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if container and container:isOpen() and container.viewGO then
		gohelper.setAsLastSibling(container.viewGO)
	end
end

function VersionActivity3_9DungeonEnterView:playLogoAnim(animName)
	if not self._gologo then
		local go = gohelper.findChild(self.viewGO, "logo")

		self._gologo = go:GetComponent(typeof(UnityEngine.Animator))
	end

	self._gologo:Play(animName, 0, 0)
end

return VersionActivity3_9DungeonEnterView
