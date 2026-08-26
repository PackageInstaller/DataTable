-- chunkname: @modules/logic/versionactivity3_6/enter/view/subview/VersionActivity3_6DungeonEnterView.lua

module("modules.logic.versionactivity3_6.enter.view.subview.VersionActivity3_6DungeonEnterView", package.seeall)

local VersionActivity3_6DungeonEnterView = class("VersionActivity3_6DungeonEnterView", VersionActivityFixedDungeonEnterView)

function VersionActivity3_6DungeonEnterView:onInitView()
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
	self._btnBoard = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Board")
	self._txtpapernum = gohelper.findChildTextMesh(self.viewGO, "#btn_Board/#txt_num")
	self._goboardreddot = gohelper.findChild(self.viewGO, "#btn_Board/#go_reddot")
	self._goblack = gohelper.findChild(self.viewGO, "black")
	self._btndormitorymode = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_dormitorymode")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_6DungeonEnterView:addEvents()
	VersionActivity3_6DungeonEnterView.super.addEvents(self)
	self._btnBoard:AddClickListener(self._btnBoardOnClick, self)
	self._btndormitorymode:AddClickListener(self._btndormitoryOnClick, self)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self.refreshPaperCount, self)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnTaskUpdate, self.refreshPaperCount, self)
	CommandStationController.instance:registerCallback(CommandStationEvent.OneClickClaimReward, self.refreshPaperCount, self)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnGetCommandPostInfo, self.refreshPaperCount, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onGetTaskBonus, self)
end

function VersionActivity3_6DungeonEnterView:removeEvents()
	VersionActivity3_6DungeonEnterView.super.removeEvents(self)
	self._btnBoard:RemoveClickListener()
	self._btndormitorymode:RemoveClickListener()
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self.refreshPaperCount, self)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnTaskUpdate, self.refreshPaperCount, self)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OneClickClaimReward, self.refreshPaperCount, self)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnGetCommandPostInfo, self.refreshPaperCount, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._onGetTaskBonus, self)
end

function VersionActivity3_6DungeonEnterView:_btndormitoryOnClick()
	V3a6YaMiController.instance:openMainView(false)
end

function VersionActivity3_6DungeonEnterView:_editableInitView()
	VersionActivity3_6DungeonEnterView.super._editableInitView(self)

	self._gobg = gohelper.findChild(self.viewGO, "#simage_bg")
	self._videoComp = VersionActivityVideoComp.get(self._gobg, self)
	self._animator = self.viewGO:GetComponent("Animator")

	RedDotController.instance:addRedDot(self._goboardreddot, RedDotEnum.DotNode.CommandStationTask)
end

function VersionActivity3_6DungeonEnterView:onDestroyView()
	VersionActivity3_6DungeonEnterView.super.onDestroyView(self)
	self._videoComp:destroy()

	local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if container and container:isOpen() and container.viewGO and self._fullviewParent then
		gohelper.addChildPosStay(self._fullviewParent, container.viewGO)
		gohelper.setActive(container.viewGO, false)
	end

	TaskDispatcher.cancelTask(self._onVideoStart, self)
end

function VersionActivity3_6DungeonEnterView:_btnBoardOnClick()
	CommandStationController.instance:openCommandStationPaperView()
end

function VersionActivity3_6DungeonEnterView:onOpenFinish()
	self._videoPath = VersionActivity3_6Enum.EnterLoopVideoName

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

function VersionActivity3_6DungeonEnterView:_onVideoStart()
	TaskDispatcher.cancelTask(self._onVideoStart, self)
	self._videoComp:setStartCallback()

	self._animator.speed = 1
end

function VersionActivity3_6DungeonEnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self._videoComp:play(self._videoPath, true)
end

function VersionActivity3_6DungeonEnterView:_setVideoAsLastSibling()
	local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if container and container:isOpen() and container.viewGO then
		gohelper.setAsLastSibling(container.viewGO)
	end
end

function VersionActivity3_6DungeonEnterView:playLogoAnim(animName)
	if not self._gologo then
		local go = gohelper.findChild(self.viewGO, "logo")

		self._gologo = go:GetComponent(typeof(UnityEngine.Animator))
	end

	self._gologo:Play(animName, 0, 0)
end

function VersionActivity3_6DungeonEnterView:refreshUI()
	VersionActivity3_6DungeonEnterView.super.refreshUI(self)
	self:refreshPaperCount()
end

function VersionActivity3_6DungeonEnterView:_onGetTaskBonus()
	CommandStationRpc.instance:sendGetCommandPostInfoRequest()
end

function VersionActivity3_6DungeonEnterView:refreshPaperCount()
	local finishCount = 0
	local totalCount = 0
	local nowVersion = CommandStationConfig.instance:getCurVersionId()
	local paperList = CommandStationConfig.instance:getPaperList()

	for _, v in ipairs(paperList) do
		if v.versionId == nowVersion then
			totalCount = v.allNum

			break
		end
	end

	local taskMos = CommandStationTaskListModel.instance.allNormalTaskMos

	if taskMos and #taskMos > 0 then
		for _, mo in ipairs(taskMos) do
			if mo.config.versionId == nowVersion and mo.finishCount > 0 then
				finishCount = finishCount + 1
			end
		end
	end

	finishCount = Mathf.Clamp(finishCount, 0, totalCount)
	self._txtpapernum.text = string.format("%d/%d", finishCount, totalCount)
end

return VersionActivity3_6DungeonEnterView
