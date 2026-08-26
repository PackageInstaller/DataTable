-- chunkname: @modules/logic/versionactivity3_5/schoolstart/view/V3a5_SchoolStartView.lua

module("modules.logic.versionactivity3_5.schoolstart.view.V3a5_SchoolStartView", package.seeall)

local V3a5_SchoolStartView = class("V3a5_SchoolStartView", BaseView)

function V3a5_SchoolStartView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_FullBG")
	self._simageDec = gohelper.findChildSingleImage(self.viewGO, "root/#simage_Dec")
	self._txtNum = gohelper.findChildText(self.viewGO, "root/left/Prop/#txt_Num")
	self._gocarditem = gohelper.findChild(self.viewGO, "root/left/grid/#go_carditem")
	self._txttime = gohelper.findChildText(self.viewGO, "root/right/Time/#txt_time")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_task")
	self._gotaskitem = gohelper.findChild(self.viewGO, "root/right/#scroll_task/Viewport/Content/#go_taskitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goBigRewardGet = gohelper.findChild(self.viewGO, "root/left/Reward/#go_Get")
	self._goBigRewardCanGet = gohelper.findChild(self.viewGO, "root/left/Reward/go_CanGet")
	self._btnBigReward = gohelper.findChildButton(self.viewGO, "root/left/Reward/#btn_bigClick")
	self._btnAllReward = gohelper.findChildButton(self.viewGO, "root/left/Reward/#btn_Click")
	self._txttips = gohelper.findChildText(self.viewGO, "root/left/txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a5_SchoolStartView:addEvents()
	self._btnBigReward:AddClickListener(self._onClickBigRewardItem, self)
	self._btnAllReward:AddClickListener(self._showAllRewardList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refreshTask, self)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, self._refreshTask, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._refreshTask, self)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, self._refreshTask, self)
	V3a5_SchoolStartController.instance:registerCallback(V3a5_SchoolStartEvent.OnFlipGridGridReply, self._onFlipGridGridReply, self)
	V3a5_SchoolStartController.instance:registerCallback(V3a5_SchoolStartEvent.OnGetBigRewardReply, self._onGetBigRewardReply, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function V3a5_SchoolStartView:removeEvents()
	self._btnBigReward:RemoveClickListener()
	self._btnAllReward:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, self._refreshTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, self._refreshTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, self._refreshTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, self._refreshTask, self)
	V3a5_SchoolStartController.instance:unregisterCallback(V3a5_SchoolStartEvent.OnFlipGridGridReply, self._onFlipGridGridReply, self)
	V3a5_SchoolStartController.instance:unregisterCallback(V3a5_SchoolStartEvent.OnGetBigRewardReply, self._onGetBigRewardReply, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)

	if self._itemList then
		for index, item in ipairs(self._itemList) do
			if item and item.btnClick then
				item.btnClick:RemoveClickListener()
			end
		end

		self._itemList = nil
	end
end

function V3a5_SchoolStartView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refreshItemStatus()
	end
end

function V3a5_SchoolStartView:_editableInitView()
	self._animTime = 1.1

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.SchoolStart
	}, self._refreshTask, self)

	self._actId = ActivityEnum.Activity.V3a5_SchoolStart
	self._config = V3a5_SchoolStartConfig.instance:get228ConfigById(self._actId)
	self._rowcolitemList = self:getUserDataTb_()

	self:_createRewardItemMap()
	V3a5_SchoolStartRpc.instance:sendGet228InfoRequest(self._actId, self.updateUI, self)
end

function V3a5_SchoolStartView:_onClickBigRewardItem()
	if not self._actInfo.getFinalBonus and V3a5_SchoolStartModel.instance:checkAllReceive() then
		V3a5_SchoolStartRpc.instance:sendAct228GetFinalBonusRequest(self._actId)
	end
end

function V3a5_SchoolStartView:_showAllRewardList()
	ViewMgr.instance:openView(ViewName.V3a5_SchoolStartRewardView)
end

function V3a5_SchoolStartView:updateUI()
	self._actInfo = V3a5_SchoolStartModel.instance:getActInfo(self._actId)

	if self._config then
		if not string.nilorempty(self._config.cost) then
			local config = string.splitToNumber(self._config.cost, "#")

			self._costId = config and config[2]
		end

		if not string.nilorempty(self._config.finalReward) then
			self._finalRewardCo = string.splitToNumber(self._config.finalReward, "#")
		end
	end

	self:_refreshCount()
	self:_refreshRewardItemMap()
	self:_refreshTime()
	self:_refreshBigReward()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneMinuteSecond)
end

function V3a5_SchoolStartView:_refreshBigReward()
	if self._actInfo then
		if not self._actInfo.getFinalBonus then
			local isGetBigReward = false

			gohelper.setActive(self._goBigRewardGet, isGetBigReward)

			local canGet = V3a5_SchoolStartModel.instance:checkAllReceive()
			local isCanGet = canGet and not isGetBigReward

			gohelper.setActive(self._goBigRewardCanGet, isCanGet)
			gohelper.setActive(self._btnAllReward, not isCanGet)

			self._txttips.text = canGet and luaLang("p_v3a5_schoolstartview_Tips2") or luaLang("p_v3a5_schoolstartview_Tips")
		end
	end
end

function V3a5_SchoolStartView:onOpen()
	local parentGO = self.viewParam.parent

	self._actId = self.viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)
end

function V3a5_SchoolStartView:_getRewardIdByIndex(index)
	if not self._actInfo or not self._actInfo.rewardIds then
		return
	end

	self._rewardIdList = self._actInfo.rewardIds

	if not self._rewardIdList[index] then
		return self._rewardIdList[index]
	end
end

function V3a5_SchoolStartView:_createRewardItemMap()
	self._itemList = self:getUserDataTb_()

	local col = V3a5_SchoolStartEnum.GridSize.Col
	local row = V3a5_SchoolStartEnum.GridSize.Row

	for i = 1, row do
		self._rowcolitemList[i] = self:getUserDataTb_()

		for j = 1, col do
			local index = (i - 1) * col + j
			local item = self:_createItem(i, j, index)

			self._itemList[index] = item
			self._rowcolitemList[i][j] = item
		end
	end
end

function V3a5_SchoolStartView:_refreshRewardItemMap()
	if self._itemList then
		self._actInfo = V3a5_SchoolStartModel.instance:getActInfo(self._actId)

		for index, item in pairs(self._itemList) do
			local rewardId = self:_getRewardIdByIndex(item.index)
			local rewardConfig = V3a5_SchoolStartConfig.instance:getRewardConfigById(rewardId)

			if rewardConfig and not string.nilorempty(rewardConfig.reward) then
				local co = string.splitToNumber(rewardConfig.reward, "#")
				local type, id, num = co[1], co[2], co[3]
				local config, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

				if config then
					item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.goRewardItem)

					item.itemIcon:setMOValue(type, id, num, nil, true)
					item.itemIcon:isShowQuality(false)
					item.itemIcon:isShowCount(false)
					gohelper.setActive(item.goRewardItem, false)
					gohelper.setActive(item.goNumbg, false)

					item.txtNum.text = "×" .. num

					UISpriteSetMgr.instance:setV3a5SchoolStartSprite(item.imageRareBg, "v3a5_schoolstart_itemquality" .. config.rare)
				end
			end

			if self._actInfo then
				item.state = self._actInfo.gridStates[index] or V3a5_SchoolStartEnum.GridState.NotGet
			end

			if self._count then
				local canClick = self._count > 0

				gohelper.setActive(item.goNotGet, item.state == V3a5_SchoolStartEnum.GridState.NotGet and not canClick)
				gohelper.setActive(item.goCanGet, item.state == V3a5_SchoolStartEnum.GridState.NotGet and canClick)
				gohelper.setActive(item.goRewardItem, item.state == V3a5_SchoolStartEnum.GridState.HasGet)
				gohelper.setActive(item.goNumbg, item.state == V3a5_SchoolStartEnum.GridState.HasGet)

				if item.state == V3a5_SchoolStartEnum.GridState.HasGet then
					gohelper.setActive(item.btnClick.gameObject, false)
				end
			end
		end
	end

	self._currentCreateRow = 1

	TaskDispatcher.runRepeat(self._showItemAnim, self, 0.01, V3a5_SchoolStartEnum.GridSize.Row)
end

function V3a5_SchoolStartView:_showItemAnim()
	if self._currentCreateRow >= V3a5_SchoolStartEnum.GridSize.Row then
		TaskDispatcher.cancelTask(self._showItemAnim, self)
	end

	local list = self._rowcolitemList[self._currentCreateRow]

	if list then
		for _, item in ipairs(list) do
			gohelper.setActive(item.go, true)
		end
	end

	self._currentCreateRow = self._currentCreateRow + 1
end

function V3a5_SchoolStartView:_createItem(row, col, index)
	local item = {}
	local go = gohelper.cloneInPlace(self._gocarditem, "item_" .. row .. "_" .. col)

	item.go = go
	item.row = row
	item.col = col
	item.index = index

	if self._actInfo then
		item.state = self._actInfo.gridStates[index] or V3a5_SchoolStartEnum.GridState.NotGet
	end

	item.goOptional = gohelper.findChild(go, "go_optional")
	item.goRewardItem = gohelper.findChild(go, "go_optional/go_item")
	item.imageRareBg = gohelper.findChildImage(go, "go_optional/image_rare")
	item.goNumbg = gohelper.findChild(go, "go_optional/itemnumbg")
	item.txtNum = gohelper.findChildText(go, "go_optional/itemnumbg/txt_itemnum")
	item.goNotGet = gohelper.findChild(go, "go_notget")
	item.goCanGet = gohelper.findChild(go, "go_canget")
	item.btnClick = gohelper.findChildButton(item.go, "#btn_click")

	item.btnClick:AddClickListener(self._onClickItem, self, item)

	item.animator = item.goOptional:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(item.go, false)

	return item
end

function V3a5_SchoolStartView:_onClickItem(item)
	if item.state == V3a5_SchoolStartEnum.GridState.NotGet and not self._cannotClick then
		if self._count and self._count > 0 then
			V3a5_SchoolStartRpc.instance:sendAct228FlipGridRequest(self._actId, item.row - 1, item.col - 1)

			self._clickIndex = item.index
		else
			GameFacade.showToast(ToastEnum.V3a5_SchoolStartViewTip)
		end
	end
end

function V3a5_SchoolStartView:_refreshTime()
	if not self._txttime then
		TaskDispatcher.cancelTask(self._refreshTime, self)

		return
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self._actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txttime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end
	end
end

function V3a5_SchoolStartView:_refreshTask()
	V3a5_SchoolStartTaskListModel.instance:setTaskList()
	self:_refreshCount()
end

function V3a5_SchoolStartView:_onUpdateTaskList(msg)
	if msg and self:_isRefreshTask(msg.taskInfo) then
		self:_refreshTask()
	end
end

function V3a5_SchoolStartView:_isRefreshTask(taskInfo)
	if not taskInfo then
		return
	end

	for i = 1, #taskInfo do
		if taskInfo[i].type == TaskEnum.TaskType.SchoolStart then
			return true
		end
	end
end

function V3a5_SchoolStartView:_refreshItemStatus()
	if self._itemList then
		self._actInfo = V3a5_SchoolStartModel.instance:getActInfo(self._actId)

		for index, item in pairs(self._itemList) do
			if self._actInfo then
				item.state = self._actInfo.gridStates[index] or V3a5_SchoolStartEnum.GridState.NotGet
			end

			if self._count then
				local canClick = self._count > 0

				gohelper.setActive(item.goNotGet, item.state == V3a5_SchoolStartEnum.GridState.NotGet and not canClick)
				gohelper.setActive(item.goCanGet, item.state == V3a5_SchoolStartEnum.GridState.NotGet and canClick)
				gohelper.setActive(item.goRewardItem, item.state == V3a5_SchoolStartEnum.GridState.HasGet)
				gohelper.setActive(item.goNumbg, item.state == V3a5_SchoolStartEnum.GridState.HasGet)

				if item.state == V3a5_SchoolStartEnum.GridState.HasGet then
					gohelper.setActive(item.btnClick.gameObject, false)
				end
			end
		end
	end
end

function V3a5_SchoolStartView:_refreshCount()
	local currencyMo = CurrencyModel.instance:getCurrency(self._costId)

	self._count = 0

	if currencyMo and currencyMo.quantity then
		self._count = currencyMo.quantity
	end

	if not self._txtNum then
		return
	end

	self._txtNum.text = "×" .. self._count
end

function V3a5_SchoolStartView:_onFlipGridGridReply()
	local indexList = V3a5_SchoolStartModel.instance:getChangeIndexList()

	if indexList and #indexList > 0 then
		local isMutil = #indexList > 1

		for _, index in ipairs(indexList) do
			self:playAnim(index, isMutil)
		end

		if isMutil then
			if not AudioEnum3_5.SchoolStart.play_ui_kaixue_jingxi then
				local audioId = AudioEnum3_5.SchoolStart.play_ui_kaixue_putong

				AudioMgr.instance:trigger(audioId)
			end
		end
	end

	self._cannotClick = true

	TaskDispatcher.runDelay(self._playAnimCallBack, self, self._animTime)
	self:_refreshBigReward()
	self:_refreshCount()
	self:_refreshItemStatus()
end

function V3a5_SchoolStartView:_onGetBigRewardReply()
	gohelper.setActive(self._goBigRewardGet, true)
	gohelper.setActive(self._goBigRewardCanGet, false)
	gohelper.setActive(self._btnAllReward, true)
end

function V3a5_SchoolStartView:playAnim(index, isMutil)
	if not self._itemList then
		return
	end

	local item = self._itemList[index]

	item.state = V3a5_SchoolStartEnum.GridState.HasGet
	self._actInfo.gridStates[index] = item.state

	gohelper.setActive(item.goRewardItem, true)
	gohelper.setActive(item.goNumbg, true)
	gohelper.setActive(item.goNotGet, false)
	gohelper.setActive(item.goCanGet, false)
	gohelper.setActive(item.btnClick.gameObject, false)

	if item and item.animator then
		local animName = isMutil and "open2" or "open1"

		item.animator:Play(animName, 0, 0)
	end
end

function V3a5_SchoolStartView:_playAnimCallBack()
	V3a5_SchoolStartController.instance:popupRewardView()
	V3a5_SchoolStartModel.instance:clearChangeIndexList()

	self._cannotClick = false
end

function V3a5_SchoolStartView:onClose()
	return
end

function V3a5_SchoolStartView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	TaskDispatcher.cancelTask(self._playAnimCallBack, self)
	TaskDispatcher.cancelTask(self._showItemAnim, self)
end

return V3a5_SchoolStartView
