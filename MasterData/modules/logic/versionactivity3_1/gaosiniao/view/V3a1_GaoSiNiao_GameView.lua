-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView", package.seeall)

local V3a1_GaoSiNiao_GameView = class("V3a1_GaoSiNiao_GameView", BaseView)

function V3a1_GaoSiNiao_GameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._goPiecePanel = gohelper.findChild(self.viewGO, "#go_PiecePanel")
	self._gopieceItem = gohelper.findChild(self.viewGO, "#go_PiecePanel/#go_pieceItem")
	self._goMap = gohelper.findChild(self.viewGO, "#go_Map")
	self._goItem = gohelper.findChild(self.viewGO, "#go_Map/#go_Item")
	self._godragItem = gohelper.findChild(self.viewGO, "#go_dragItem")
	self._imagedrag = gohelper.findChildImage(self.viewGO, "#go_dragItem/#image_drag")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function V3a1_GaoSiNiao_GameView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V3a1_GaoSiNiao_GameView:ctor(...)
	V3a1_GaoSiNiao_GameView.super.ctor(self, ...)

	self._bagObjList = {}
	self._gridObjList = {}
end

function V3a1_GaoSiNiao_GameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.V3a1_GaoSiNiao_GameView_Reset, MsgBoxEnum.BoxType.Yes_No, self._restartYesCallback, nil, nil, self, nil, nil)
end

function V3a1_GaoSiNiao_GameView:_restartYesCallback()
	UIBlockHelper.instance:startBlock(self.viewName, 3)
	self.viewContainer:track_reset()

	self._tmpBagDataList = nil
	self._tmpGridDataList = nil

	self:_dragContext():_critical_beforeClear()
	self.viewContainer:restart()
	self:_dragContext():reset(self, self._godragItemTran, self._imagedrag)
	TaskDispatcher.cancelTask(self._restartDelayRefresh, self)
	TaskDispatcher.runDelay(self._restartDelayRefresh, self, 0.33)
	self._playAnim_reset(self, self._onResetAnimDone, self)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_reset)
end

function V3a1_GaoSiNiao_GameView:_onResetAnimDone()
	UIBlockHelper.instance:endBlock(self.viewName)
end

function V3a1_GaoSiNiao_GameView:_restartDelayRefresh()
	self:_refresh()
end

function V3a1_GaoSiNiao_GameView:_btnCloseOnClick()
	if not self._allowEmptyClose then
		return
	end

	self.viewContainer:exitGame()
end

function V3a1_GaoSiNiao_GameView:_onReceiveAct210FinishEpisodeReply()
	self._allowEmptyClose = true

	self:_setShowCompleted(true)
end

function V3a1_GaoSiNiao_GameView:completeGame()
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_win)

	for _, item in ipairs(self._gridObjList) do
		item:onCompleteGame()
	end

	self.viewContainer:completeGame()
	self:_setShowCompleted(true)
end

function V3a1_GaoSiNiao_GameView:_dragContext()
	return self.viewContainer:dragContext()
end

function V3a1_GaoSiNiao_GameView:_editableInitView()
	self._btnCloseGo = self._btnClose.gameObject
	self._btnresetGo = self._btnreset.gameObject
	self._godragItemTran = self._godragItem.transform
	self._TargetGo = gohelper.findChild(self.viewGO, "Target")
	self._goMapGridCmp = self._goMap:GetComponent(gohelper.Type_GridLayoutGroup)
	self._goMapTran = self._goMap.transform

	gohelper.setActive(self._gopieceItem, false)
	gohelper.setActive(self._goItem, false)
	gohelper.setActive(self._godragItem, false)

	self._gofinishAnimator = self._gofinish:GetComponent(gohelper.Type_Animator)
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)

	self:_setShowCompleted(false)
end

function V3a1_GaoSiNiao_GameView:onUpdateParam()
	self._tmpBagDataList = nil
	self._tmpGridDataList = nil

	self:_dragContext():reset(self, self._godragItemTran, self._imagedrag)

	local _, col = self.viewContainer:rowCol()

	self._goMapGridCmp.constraintCount = col

	self:_refresh()
end

function V3a1_GaoSiNiao_GameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_open2)
	self:onUpdateParam()
	self.addEventCb(self, GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveAct210FinishEpisodeReply, self._onReceiveAct210FinishEpisodeReply, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._onFinishGuideLastStep, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideFail, self._onFinishGuideFail, self)
end

function V3a1_GaoSiNiao_GameView:_onFinishGuideLastStep(guideId)
	if guideId ~= self.viewContainer:guideId() then
		return
	end

	self.viewContainer:saveHasPlayedGuide()
	self.viewContainer:trackMO():onGameStart()
end

function V3a1_GaoSiNiao_GameView:_onFinishGuideFail()
	self.viewContainer:saveHasPlayedGuide()
	self.viewContainer:trackMO():onGameStart()

	local guideId = self.viewContainer:guideId()

	self.viewContainer:directFinishGuide(guideId)
end

function V3a1_GaoSiNiao_GameView:onOpenFinish()
	local isPlayingGuide = self:_playGuide()

	if not isPlayingGuide then
		self.viewContainer:trackMO():onGameStart()
	end
end

function V3a1_GaoSiNiao_GameView:_playGuide()
	local isForbidGuides = GuideController.instance:isForbidGuides()

	if isForbidGuides then
		return false
	end

	local guideId = self.viewContainer:guideId()

	if not guideId or guideId == 0 then
		return false
	end

	if self.viewContainer:hasPlayedGuide() then
		return false
	end

	if self.viewContainer:isGuideRunning(guideId) then
		GuideController.instance:execNextStep(guideId)
	else
		self.addEventCb(self, GuideController.instance, GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
		GuideController.instance:startGudie(guideId)
	end

	return true
end

function V3a1_GaoSiNiao_GameView:_onReceiveFinishGuideReply()
	local guideId = self.viewContainer:guideId()

	if self.viewContainer:isGuideRunning(guideId) then
		GuideController.instance:execNextStep(guideId)
		self.removeEventCb(self, GuideController.instance, GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
	end
end

function V3a1_GaoSiNiao_GameView:onClose()
	GuideStepController.instance:clearStep()
	TaskDispatcher.cancelTask(self._restartDelayRefresh, self)
end

function V3a1_GaoSiNiao_GameView:onDestroyView()
	TaskDispatcher.cancelTask(self._restartDelayRefresh, self)
	GameUtil.onDestroyViewMemberList(self, "_bagObjList")
	GameUtil.onDestroyViewMemberList(self, "_gridObjList")
end

function V3a1_GaoSiNiao_GameView:_getBagDataList()
	self._tmpBagDataList = self._tmpBagDataList or self.viewContainer:bagDataList()

	return self._tmpBagDataList
end

function V3a1_GaoSiNiao_GameView:_getGridDataList()
	self._tmpGridDataList = self._tmpGridDataList or self.viewContainer:gridDataList()

	return self._tmpGridDataList
end

function V3a1_GaoSiNiao_GameView:_refresh()
	self:_refreshBagList()
	self:_refreshGridList()
end

function V3a1_GaoSiNiao_GameView:_refreshBagList()
	local list = self:_getBagDataList()

	for i, data in ipairs(list) do
		local item

		if i > #self._bagObjList then
			item = self:_create_V3a1_GaoSiNiao_GameView_BagItem(i)

			table.insert(self._bagObjList, item)
		else
			item = self._bagObjList[i]
		end

		item:onUpdateMO(data)
		item:setActive(true)
	end

	for i = #list + 1, #self._bagObjList do
		local item = self._bagObjList[i]

		item:setActive(false)
	end
end

function V3a1_GaoSiNiao_GameView:_refreshGridList()
	local list = self:_getGridDataList()

	for i, data in ipairs(list) do
		local item

		if i > #self._gridObjList then
			item = self:_create_V3a1_GaoSiNiao_GameView_GridItem(i)

			table.insert(self._gridObjList, item)
		else
			item = self._gridObjList[i]
		end

		item:onUpdateMO(data)
		item:setActive(true)
	end

	for i = #list + 1, #self._gridObjList do
		local item = self._gridObjList[i]

		item:setActive(false)
	end
end

function V3a1_GaoSiNiao_GameView:_selectNoneAllGrids()
	for _, item in ipairs(self._gridObjList) do
		item:setSelected(false)
	end
end

function V3a1_GaoSiNiao_GameView:onBeginDrag_BagItemObj(...)
	self:_dragContext():onBeginDrag_BagItemObj(...)
end

function V3a1_GaoSiNiao_GameView:onDragging_BagItemObj(...)
	self:_dragContext():onDragging_BagItemObj(...)
end

function V3a1_GaoSiNiao_GameView:onEndDrag_BagItemObj(...)
	self:_dragContext():onEndDrag_BagItemObj(...)
end

function V3a1_GaoSiNiao_GameView:onBeginDrag_GridItemObj(...)
	self:_dragContext():onBeginDrag_GridItemObj(...)
end

function V3a1_GaoSiNiao_GameView:onDragging_GridItemObj(...)
	self:_dragContext():onDragging_GridItemObj(...)
end

function V3a1_GaoSiNiao_GameView:onEndDrag_GridItemObj(...)
	self:_dragContext():onEndDrag_GridItemObj(...)
end

function V3a1_GaoSiNiao_GameView:_create_V3a1_GaoSiNiao_GameView_BagItem(index)
	local go = gohelper.cloneInPlace(self._gopieceItem)
	local item = V3a1_GaoSiNiao_GameView_BagItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a1_GaoSiNiao_GameView:_create_V3a1_GaoSiNiao_GameView_GridItem(index)
	local go = gohelper.cloneInPlace(self._goItem)
	local item = V3a1_GaoSiNiao_GameView_GridItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a1_GaoSiNiao_GameView:_setShowCompleted(isCompleted)
	gohelper.setActive(self._btnCloseGo, isCompleted)
	gohelper.setActive(self._gofinish, isCompleted)
	gohelper.setActive(self._btnresetGo, not isCompleted)
	gohelper.setActive(self._goPiecePanel, not isCompleted)
	gohelper.setActive(self._goBackBtns, not isCompleted)
	gohelper.setActive(self._TargetGo, not isCompleted)

	if isCompleted then
		self._gofinishAnimator:Play(UIAnimationName.Open)
		AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_win2)
	else
		self._gofinishAnimator:Play(UIAnimationName.Idle, -1, 0)
	end
end

function V3a1_GaoSiNiao_GameView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a1_GaoSiNiao_GameView:_playAnim_reset(cb, cbObj)
	self:_playAnim("reset", cb, cbObj)
end

return V3a1_GaoSiNiao_GameView
