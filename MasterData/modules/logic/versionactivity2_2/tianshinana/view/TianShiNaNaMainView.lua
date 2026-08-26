-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaMainView.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainView", package.seeall)

local TianShiNaNaMainView = class("TianShiNaNaMainView", BaseView)
local SceneMaxX = 43.99266
local MaxSlideX = 3409

function TianShiNaNaMainView:onInitView()
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_title/#go_time/#txt_limittime")
	self._taskAnimator = gohelper.findChild(self.viewGO, "#btn_task/ani"):GetComponent(typeof(UnityEngine.Animator))
	self._gored = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._gopath = gohelper.findChild(self.viewGO, "#go_path")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	self._gostageitem = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages/#go_StageItem")
	self._pathAnims = self:getUserDataTb_()

	for i = 1, 10 do
		self._pathAnims[i] = gohelper.findChild(self._goscrollcontent, "path/path/image" .. i):GetComponent(typeof(UnityEngine.Animator))
		self._pathAnims[i].speed = 0
	end

	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function TianShiNaNaMainView:addEvents()
	CommonDragHelper.instance:registerDragObj(self._gopath, nil, self._onDrag, nil, nil, self, nil, true)
	self._btntask:AddClickListener(self._onClickTask, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EnterLevelScene, self._onEnterLevelScene, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeStarChange, self._onStarChange, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeFinish, self._onEpisodeFinish, self)
end

function TianShiNaNaMainView:removeEvents()
	CommonDragHelper.instance:unregisterDragObj(self._gopath)
	self._btntask:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EnterLevelScene, self._onEnterLevelScene, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeStarChange, self._onStarChange, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeFinish, self._onEpisodeFinish, self)
end

function TianShiNaNaMainView:onOpen()
	self:_refreshTask()
	gohelper.setActive(self._gostageitem, false)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	local stageCoList = TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	local actId = VersionActivity2_2Enum.ActivityId.TianShiNaNa

	self.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	local selectIndex = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. actId, "1")

	selectIndex = tonumber(selectIndex) or 1
	selectIndex = Mathf.Clamp(selectIndex, 1, #stageCoList)

	self:setDragPosX(544.6 * (selectIndex - 1) - recthelper.getWidth(self._gopath.transform) / 2 - 150)

	TianShiNaNaModel.instance.curSelectIndex = selectIndex
	self._stages = {}

	for i = 1, #stageCoList do
		local stageItemRoot = gohelper.findChild(self._gostages, "stage" .. i)

		if stageItemRoot then
			local cloneGo = gohelper.clone(self._gostageitem, stageItemRoot, "root")
			local node1 = gohelper.findChild(cloneGo, "#go_EvenStage")
			local node2 = gohelper.findChild(cloneGo, "#go_OddStage")

			gohelper.setActive(node1, i % 2 == 1)
			gohelper.setActive(node2, i % 2 == 0)
			gohelper.setActive(cloneGo, true)

			self._stages[i] = MonoHelper.addNoUpdateLuaComOnceToGo(i % 2 == 0 and node2 or node1, TianShiNaNaStageItem)

			self._stages[i]:initCo(stageCoList[i], i)
		else
			logError("关卡节点不存在，请找集成处理 stage" .. i)
		end
	end

	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, 60)

	local maxUnLockIndex = TianShiNaNaModel.instance:getUnLockMaxIndex()

	for i = 1, 10 do
		if i <= maxUnLockIndex and stageCoList[i + 1] then
			self._pathAnims[i]:Play("idle", 0, 0)
		else
			self._pathAnims[i]:Play("open", 0, 0)
		end
	end
end

function TianShiNaNaMainView:_onStarChange(index, preStar, star)
	if not self._stages[index + 1] then
		return
	end

	if preStar == 0 and self._pathAnims[index] then
		self._pathAnims[index]:Play("open", 0, 0)

		self._pathAnims[index].speed = 1
	end
end

function TianShiNaNaMainView:_onEpisodeFinish()
	if not self._gopath then
		return
	end

	local actId = VersionActivity2_2Enum.ActivityId.TianShiNaNa
	local selectIndex = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. actId, "1")

	selectIndex = tonumber(selectIndex) or 1
	selectIndex = Mathf.Clamp(selectIndex, 1, #self._stages)

	self:setDragPosX(544.6 * (selectIndex - 1) - recthelper.getWidth(self._gopath.transform) / 2 - 150, true)
end

function TianShiNaNaMainView:_onClickTask()
	ViewMgr.instance:openView(ViewName.TianShiNaNaTaskView)
end

function TianShiNaNaMainView:_btnTrialOnClick()
	local actId = VersionActivity2_2Enum.ActivityId.TianShiNaNa

	if ActivityHelper.getActivityStatus(actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function TianShiNaNaMainView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function TianShiNaNaMainView:refreshTime()
	self._txtlimittime.text = TianShiNaNaHelper.getLimitTimeStr()
end

function TianShiNaNaMainView:_refreshTask()
	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	if hasRewards then
		self._taskAnimator:Play("loop", 0, 0)
	else
		self._taskAnimator:Play("idle", 0, 0)
	end
end

function TianShiNaNaMainView:_onViewClose(viewName)
	if viewName == ViewName.TianShiNaNaLevelView then
		self._viewAnimator:Play("open", 0, 0)
	end
end

function TianShiNaNaMainView:_onEnterLevelScene()
	self._viewAnimator:Play("close", 0, 0)
	UIBlockHelper.instance:startBlock("TianShiNaNaMainView_onEnterLevelScene", 0.34, self.viewName)
	TaskDispatcher.runDelay(self._realEnterGameView, self, 0.34)
end

function TianShiNaNaMainView:_realEnterGameView()
	ViewMgr.instance:openView(ViewName.TianShiNaNaLevelView)
end

function TianShiNaNaMainView:_onDrag(_, pointerEventData)
	local curSpineRootPosX = recthelper.getAnchorX(self._goscrollcontent.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x

	self:setDragPosX(-curSpineRootPosX)
end

function TianShiNaNaMainView:setDragPosX(posX, isTween)
	local addLimit = 0
	local width = UnityEngine.Screen.width
	local height = UnityEngine.Screen.height
	local screenRatio = width / height
	local targetRatio = 1.7777777777777777

	if targetRatio - screenRatio < 0 then
		addLimit = (screenRatio / targetRatio - 1) * recthelper.getWidth(self._gopath.transform) / 2
		addLimit = Mathf.Clamp(addLimit, 0, 400)
	end

	posX = addLimit <= MaxSlideX - addLimit and Mathf.Clamp(posX, addLimit, MaxSlideX - addLimit) or addLimit

	if posX == self._nowDragPosX then
		return
	end

	self:killTween()

	if isTween and self._nowDragPosX then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._nowDragPosX, posX, 0.5, self._onFrameTween, nil, self)
	else
		self._nowDragPosX = posX

		transformhelper.setLocalPos(self._goscrollcontent.transform, -posX, 0, 0)

		local scenePos = -posX * SceneMaxX / MaxSlideX

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.DragMainScene, scenePos)
	end
end

function TianShiNaNaMainView:_onFrameTween(value)
	self._nowDragPosX = value

	transformhelper.setLocalPos(self._goscrollcontent.transform, -value, 0, 0)

	local scenePos = -value * SceneMaxX / MaxSlideX

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.DragMainScene, scenePos)
end

function TianShiNaNaMainView:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function TianShiNaNaMainView:onClose()
	self:killTween()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	TaskDispatcher.cancelTask(self._realEnterGameView, self)
end

return TianShiNaNaMainView
