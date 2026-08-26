-- chunkname: @modules/logic/room/view/critter/RoomTrainAccelerateView.lua

module("modules.logic.room.view.critter.RoomTrainAccelerateView", package.seeall)

local RoomTrainAccelerateView = class("RoomTrainAccelerateView", BaseView)

function RoomTrainAccelerateView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "itemArea/#simage_bg")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "itemArea/#scroll_item")
	self._goaccelerateItem = gohelper.findChild(self.viewGO, "itemArea/#scroll_item/viewport/content/#go_accelerateItem")
	self._godetailitemtab = gohelper.findChild(self.viewGO, "#go_detailitemtab")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTrainAccelerateView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomTrainAccelerateView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomTrainAccelerateView:_btncloseOnClick()
	self:closeThis()
end

function RoomTrainAccelerateView:_editableInitView()
	self._previewForwardTime = 0
	self._gocontent = gohelper.findChild(self.viewGO, "itemArea/#scroll_item/viewport/content")

	local go = self:getResInst(RoomCritterTrainDetailItem.prefabPath, self._godetailitemtab)

	self.detailItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterTrainDetailItem, self)

	self.detailItem:setFinishCallback(self._btncloseOnClick, self)

	local goTrainProgress = gohelper.findChild(go, "TrainProgress")

	recthelper.setAnchorY(goTrainProgress.transform, -120)

	self.detailItem.addBarValue = gohelper.findChildImage(go, "TrainProgress/ProgressBg/#bar_add")
	self.detailItem.gohasten = gohelper.findChild(go, "TrainProgress/ProgressBg/#image_totalBarValue/hasten")

	gohelper.setActive(self.detailItem.addBarValue, true)
	self.detailItem:setShowStateInfo(false)
end

function RoomTrainAccelerateView:onUpdateParam()
	return
end

function RoomTrainAccelerateView:onOpen()
	self._critterUid = self.viewParam and self.viewParam.critterUid
	self._critterMO = CritterModel.instance:getCritterMOByUid(self._critterUid)

	if not self._critterMO then
		self:closeThis()

		return
	end

	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainCdTime, self._opTranCdTimeUpdate, self)
	end

	self.addEventCb(self, CritterController.instance, CritterEvent.FastForwardTrainReply, self._onForwardTrainReply, self)
	self.detailItem:onUpdateMO(self._critterMO)
	TaskDispatcher.cancelTask(self._onRunCdTimeTask, self)
	TaskDispatcher.runRepeat(self._onRunCdTimeTask, self, 1)
	self:setAccelerateItemList()
end

function RoomTrainAccelerateView:onClose()
	TaskDispatcher.cancelTask(self._onRunCdTimeTask, self)
end

function RoomTrainAccelerateView:onDestroyView()
	self.detailItem:onDestroy()

	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end
end

function RoomTrainAccelerateView:_onRunCdTimeTask()
	if self.viewContainer and self.viewContainer:isOpen() then
		self.viewContainer:dispatchEvent(CritterEvent.UITrainCdTime)
	else
		TaskDispatcher.cancelTask(self._onRunCdTimeTask, self)
	end
end

function RoomTrainAccelerateView:_opTranCdTimeUpdate()
	if self._isPlayBarAnim then
		return
	end

	if not self._critterMO or self._critterMO:isMaturity() or self._critterMO.trainInfo:isTrainFinish() then
		self:closeThis()

		return
	end

	self.detailItem:tranCdTimeUpdate()

	self.detailItem.addBarValue.fillAmount = self:getPreviewPross()
end

function RoomTrainAccelerateView:_onForwardTrainReply()
	if self._critterMO and self._critterMO.trainInfo then
		self._isPlayBarAnim = true

		local startValue = self.detailItem:getBarValue()
		local endValue = self._critterMO.trainInfo:getProcess()

		if self._fadeInTweenId then
			ZProj.TweenHelper.KillById(self._fadeInTweenId)

			self._fadeInTweenId = nil
		end

		gohelper.setActive(self.detailItem.gohasten, false)
		gohelper.setActive(self.detailItem.gohasten, true)

		self._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(startValue, endValue, 0.5, self._fadeUpdate, self._fadeInFinished, self, nil, EaseType.Linear)
	else
		self:_opTranCdTimeUpdate()
	end

	self.viewContainer:dispatchEvent(CritterEvent.FastForwardTrainReply)
end

function RoomTrainAccelerateView:_fadeUpdate(value)
	self.detailItem:setBarValue(value)
end

function RoomTrainAccelerateView:_fadeInFinished()
	self._isPlayBarAnim = false

	self:_opTranCdTimeUpdate()
end

function RoomTrainAccelerateView:setPreviewForwardTime(previewForwardTime)
	self._previewForwardTime = previewForwardTime

	if not self._isPlayBarAnim then
		self.detailItem.addBarValue.fillAmount = self:getPreviewPross()
	end
end

function RoomTrainAccelerateView:getPreviewPross()
	if self._critterMO and self._critterMO.trainInfo then
		local processTime = self._critterMO.trainInfo:getProcessTime() + self._previewForwardTime
		local total = self._critterMO.trainInfo.trainTime

		if total > 0 and processTime > 0 then
			if total < processTime then
				return 1
			end

			return processTime / total
		end
	end

	return 0
end

function RoomTrainAccelerateView:setAccelerateItemList()
	local accelerateItemList = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.CritterAccelerateItem)

	gohelper.CreateObjList(self, self._onSetAccelerateItem, accelerateItemList, self._gocontent, self._goaccelerateItem, RoomTrainAccelerateItem)
end

function RoomTrainAccelerateView:_onSetAccelerateItem(comp, data, index)
	if comp._view == nil then
		comp._view = self

		comp:_editableAddEvents()
	end

	comp:setData(self._critterUid, data.id)
end

return RoomTrainAccelerateView
