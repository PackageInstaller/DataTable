-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaMapView.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapView", package.seeall)

local LanShouPaMapView = class("LanShouPaMapView", BaseView)

function LanShouPaMapView:onInitView()
	self._gopath = gohelper.findChild(self.viewGO, "#go_path")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_title/#go_time/#txt_limittime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task", AudioEnum.UI.play_ui_mission_open)
	self._gored = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_task/ani")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._goblack = gohelper.findChild(self.viewGO, "black")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	local goPath = gohelper.findChild(self._goscrollcontent, "path/path_2")

	self._animPath = goPath:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaMapView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnimage_TryBtn:AddClickListener(self._btnimage_TryBtnOnClick, self)
end

function LanShouPaMapView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnimage_TryBtn:RemoveClickListener()
end

function LanShouPaMapView:_btntaskOnClick()
	LanShouPaController.instance:openTaskView()
end

function LanShouPaMapView:_editableInitView()
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local gopath2 = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/path/path_2")

	self._pathAnimator = gopath2:GetComponent(typeof(UnityEngine.Animator))
	self._excessAnimator = self._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	self._blackAnimator = self._goblack:GetComponent(typeof(UnityEngine.Animator))
	self._taskAnimator = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa)
	gohelper.setActive(self._gotime, false)

	self._btnimage_TryBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")
end

function LanShouPaMapView:onOpen()
	self:_initStages()
	self:refreshTime()
	self:_refreshTask()
	self:_addEvents()
end

function LanShouPaMapView:_initStages()
	if self._stageItemList then
		return
	end

	local prefabPath = self.viewContainer:getSetting().otherRes[1]

	self._stageItemList = {}

	local unLockCount = Activity164Model.instance:getUnlockCount()
	local actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	local episodeCfgList = Activity164Config.instance:getEpisodeCoList(actId)
	local selectIndex = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_1LanShouPaSelect .. actId, "1")

	selectIndex = tonumber(selectIndex) or 1
	selectIndex = Mathf.Clamp(selectIndex, 1, unLockCount + 1)

	if episodeCfgList[selectIndex] then
		if not episodeCfgList[selectIndex].id then
			local episodeId = episodeCfgList[1].id

			Activity164Model.instance:setCurEpisodeId(episodeId)

			for i = 1, #episodeCfgList do
				local stageGo = gohelper.findChild(self._gostages, "stage" .. i)
				local cloneGo = self:getResInst(prefabPath, stageGo)
				local stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, LanShouPaMapViewStageItem, self)

				stageItem:refreshItem(episodeCfgList[i], i)
				table.insert(self._stageItemList, stageItem)
			end

			if unLockCount == 0 then
				self._animPath.speed = 0

				self._animPath:Play("go1", 0, 0)
			else
				self._animPath.speed = 1

				self._animPath:Play("go" .. unLockCount, 0, 1)
			end

			self:_setToPos(selectIndex)
		end
	end
end

function LanShouPaMapView:_refreshStageItem(playAnim, episodeId)
	for i = 1, #self._stageItemList do
		local actId = VersionActivity2_1Enum.ActivityId.LanShouPa
		local co = Activity164Config.instance:getActivity164EpisodeCo(actId, i)

		self._stageItemList[i]:refreshItem(co, i)
	end
end

function LanShouPaMapView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.LanShouPa]

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function LanShouPaMapView:_refreshTask()
	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa)

	if hasRewards then
		self._taskAnimator:Play("loop", 0, 0)
	else
		self._taskAnimator:Play("idle", 0, 0)
	end
end

function LanShouPaMapView:_onEpisodeFinish()
	local unLockCount = Activity164Model.instance:getUnlockCount()

	self._animPath.speed = 1

	self._animPath:Play("go" .. unLockCount, 0, 0)
	self._stageItemList[unLockCount]:onPlayFinish()

	if self._stageItemList[unLockCount + 1] then
		self._stageItemList[unLockCount + 1]:onPlayUnlock()
	end

	self:_setToPos(unLockCount)
end

function LanShouPaMapView:getRemainTimeStr()
	local actMO = ActivityModel.instance:getActMO(VersionActivity2_1Enum.ActivityId.LanShouPa)

	if actMO then
		return string.format(luaLang("activity_warmup_remain_time"), actMO:getRemainTimeStr())
	end

	return string.format(luaLang("activity_warmup_remain_time"), "0")
end

function LanShouPaMapView:onClose()
	self:_removeEvents()
end

function LanShouPaMapView:_onDragBegin(param, pointerEventData)
	self._initDragPos = pointerEventData.position.x
end

function LanShouPaMapView:_onDrag(param, pointerEventData)
	local curSpineRootPosX = recthelper.getAnchorX(self._goscrollcontent.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * LanShouPaEnum.SlideSpeed

	self:setDragPosX(-curSpineRootPosX)
end

function LanShouPaMapView:_onDragEnd(param, pointerEventData)
	return
end

function LanShouPaMapView:_getInfoSuccess(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	LanShouPaController.instance:dispatchEvent(LanShouPaEvent.NewEpisodeUnlock)
	self:_backToLevelView()
end

function LanShouPaMapView:_setToPos(index)
	local actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	local episodeCfgList = Activity164Config.instance:getEpisodeCoList(actId)
	local pos = (index - LanShouPaEnum.MaxShowEpisodeCount) * LanShouPaEnum.MaxSlideX / (#episodeCfgList - LanShouPaEnum.MaxShowEpisodeCount)

	self:setDragPosX(pos)
end

function LanShouPaMapView:_onScreenResize()
	local curSpineRootPosX = recthelper.getAnchorX(self._goscrollcontent.transform)

	self:setDragPosX(-curSpineRootPosX)
end

function LanShouPaMapView:setDragPosX(posX)
	local addLimit = 0
	local width = UnityEngine.Screen.width
	local height = UnityEngine.Screen.height
	local screenRatio = width / height
	local targetRatio = 1.7777777777777777

	if targetRatio - screenRatio < 0 then
		addLimit = (screenRatio / targetRatio - 1) * recthelper.getWidth(self._gopath.transform) / 2
		addLimit = Mathf.Clamp(addLimit, 0, 400)
	end

	posX = addLimit <= LanShouPaEnum.MaxSlideX - addLimit and Mathf.Clamp(posX, addLimit, LanShouPaEnum.MaxSlideX - addLimit) or addLimit

	transformhelper.setLocalPos(self._goscrollcontent.transform, -posX, 0, 0)

	local scenePos = -posX * LanShouPaEnum.SceneMaxX / LanShouPaEnum.MaxSlideX

	LanShouPaController.instance:dispatchEvent(LanShouPaEvent.SetScenePos, scenePos)
end

function LanShouPaMapView:_onEnterGameView()
	self._viewAnimator:Play("close", 0, 0)
end

function LanShouPaMapView:_realEnterGameView()
	self:closeThis()
end

function LanShouPaMapView:_onViewClose(viewName)
	if viewName == ViewName.LanShouPaGameView then
		self._viewAnimator:Play("open", 0, 0)
	end
end

function LanShouPaMapView:_addEvents()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gopath.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, LanShouPaController.instance, LanShouPaEvent.StartEnterGameView, self._onEnterGameView, self)
	self.addEventCb(self, LanShouPaController.instance, LanShouPaEvent.OnEpisodeFinish, self._onEpisodeFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
end

function LanShouPaMapView:_removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self.removeEventCb(self, LanShouPaController.instance, LanShouPaEvent.StartEnterGameView, self._onEnterGameView, self)
	self.removeEventCb(self, LanShouPaController.instance, LanShouPaEvent.OnEpisodeFinish, self._onEpisodeFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
end

function LanShouPaMapView:onDestroyView()
	TaskDispatcher.cancelTask(self._showUnlockFinished, self)

	if self._stageItemList then
		for _, stageItem in ipairs(self._stageItemList) do
			stageItem:onDestroyView()
		end

		self._stageItemList = nil
	end
end

local kJumpId = 10012117

function LanShouPaMapView:_btnimage_TryBtnOnClick()
	GameFacade.jump(kJumpId)
end

return LanShouPaMapView
