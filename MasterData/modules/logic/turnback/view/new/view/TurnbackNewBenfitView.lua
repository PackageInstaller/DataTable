-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewBenfitView.lua

module("modules.logic.turnback.view.new.view.TurnbackNewBenfitView", package.seeall)

local TurnbackNewBenfitView = class("TurnbackNewBenfitView", BaseView)

function TurnbackNewBenfitView:onInitView()
	self._btnturnbackmonthcard = gohelper.findChildButtonWithAudio(self.viewGO, "bg/content/turnbackmonthcard/#btn_turnbackmonthcard")
	self._txtdoublereward = gohelper.findChildText(self.viewGO, "bg/content/doublereward/frame/txt_doublereward2/#txt_doublereward")
	self._gounlock = gohelper.findChild(self.viewGO, "bg/content/turnbackmonthcard/go_unlocked")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "bg/content/doublereward/frame/go_time/#txt_remainTime")
	self._btndoublereward = gohelper.findChildButtonWithAudio(self.viewGO, "bg/content/doublereward/#btn_doublereward")
	self._godoublerewardfinish = gohelper.findChild(self.viewGO, "bg/content/doublereward/go_finish")
	self._canvasgroupmonthcard = gohelper.findChild(self.viewGO, "bg/content/turnbackmonthcard/frame"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._btngreet = gohelper.findChildButtonWithAudio(self.viewGO, "bg/content/greet/#btn_greet")
	self._gogreetbuyed = gohelper.findChild(self.viewGO, "bg/content/greet/go_unlocked")
	self._txtsearchremaintime = gohelper.findChildText(self.viewGO, "bg/content/search/go_time/#txt_remainTime")
	self._goAllFinish = gohelper.findChild(self.viewGO, "bg/content/search/#go_allFinished")
	self._canvasgroupgreet = gohelper.findChild(self.viewGO, "bg/content/greet/frame"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._godoublerewarddec = gohelper.findChild(self.viewGO, "bg/content/doublereward/frame/dec")
	self._searchItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewBenfitView:addEvents()
	self._btnturnbackmonthcard:AddClickListener(self._btnturnbackmonthcardOnClick, self)
	self._btndoublereward:AddClickListener(self._btndoublerewardOnClick, self)
	self._btngreet:AddClickListener(self._btngreetOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._onChargeBuySuccess, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshUI, self)
end

function TurnbackNewBenfitView:removeEvents()
	self._btnturnbackmonthcard:RemoveClickListener()
	self._btndoublereward:RemoveClickListener()
	self._btngreet:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._onChargeBuySuccess, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.refreshUI, self)

	for index, item in ipairs(self._searchItemList) do
		item.btnclick:RemoveClickListener()
	end
end

function TurnbackNewBenfitView:_btndoublerewardOnClick()
	if self.jumptab[2] ~= 0 then
		GameFacade.jump(self.jumptab[2])
	end
end

function TurnbackNewBenfitView:_btnturnbackmonthcardOnClick()
	if TurnbackModel.instance:getMonthCardShowState() == false then
		return
	end

	logNormal("onClickMonthCard")

	local turnBackMo = TurnbackModel.instance:getCurTurnbackMo()
	local config = turnBackMo.config
	local storePackageMo = StoreModel.instance:getGoodsMO(config.monthCardAddedId)

	StoreController.instance:openPackageStoreGoodsView(storePackageMo)
end

function TurnbackNewBenfitView:_btngreetOnClick()
	if not TurnbackModel.instance:getBuyDoubleBonus() then
		ViewMgr.instance:openView(ViewName.TurnbackDoubleRewardChargeView)
	else
		TurnbackModel.instance:setTargetCategoryId(TurnbackEnum.ActivityId.NewTaskView)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)
	end
end

function TurnbackNewBenfitView:_btnturnbackpackageOnClick()
	if self.jumptab[1] ~= 0 then
		GameFacade.jump(self.jumptab[1])
	end
end

function TurnbackNewBenfitView:_editableInitView()
	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.index = i
		item.go = gohelper.findChild(self.viewGO, "bg/content/search/node" .. i)
		item.golock = gohelper.findChild(item.go, "lock")
		item.gotxtlock = gohelper.findChild(item.go, "lock/#txt_locked")
		item.gounlock = gohelper.findChild(item.go, "unlock")
		item.golockreward = gohelper.findChild(item.go, "lock/bg/reward")
		item.gounlockreward = gohelper.findChild(item.go, "unlock/bg/reward")
		item.gofinishing = gohelper.findChild(item.go, "unlock/#go_finishing")
		item.txtfinishing = gohelper.findChildText(item.go, "unlock/#go_finishing/#txt_time")
		item.gocanget = gohelper.findChild(item.go, "unlock/#go_canget")
		item.btnclick = gohelper.findChildButton(item.go, "unlock/#go_canget/btn_click")
		item.gohasget = gohelper.findChild(item.go, "unlock/#go_hasget")
		item.txtunlock = gohelper.findChildText(item.go, "unlock/#go_finishing/#txt_time")
		item.animtor = item.go:GetComponent(typeof(UnityEngine.Animator))

		table.insert(self._searchItemList, item)
	end
end

function TurnbackNewBenfitView:_initSearchItem()
	self.coList = TurnbackConfig.instance:getSearchTaskCoList(self._turnbackId)

	for index, co in ipairs(self.coList) do
		local item = self._searchItemList[index]

		item.config = co

		local rewardco = string.splitToNumber(co.bonus, "#")
		local type, id, num = rewardco[1], rewardco[2], rewardco[3]

		item.itemlockIcon = IconMgr.instance:getCommonPropItemIcon(item.golockreward)
		item.itemunlockIcon = IconMgr.instance:getCommonPropItemIcon(item.gounlockreward)

		item.itemlockIcon:setMOValue(type, id, num, nil, true)
		item.itemunlockIcon:setMOValue(type, id, num, nil, true)
		item.itemunlockIcon:setCountFontSize(48)
		item.itemlockIcon:setCountFontSize(48)
		item.btnclick:AddClickListener(self._onClickSearchReward, self, item)

		local mo = TurnbackTaskModel.instance:getSearchTaskMoById(item.config.id)
	end
end

function TurnbackNewBenfitView:onUpdateParam()
	return
end

function TurnbackNewBenfitView:_onClickSearchReward(item)
	TaskRpc.instance:sendFinishTaskRequest(item.config.id)
end

function TurnbackNewBenfitView:_onFinishTask()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function TurnbackNewBenfitView:_onChargeBuySuccess()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function TurnbackNewBenfitView:onGetTurnBackInfo()
	self:_refreshMonthCard()
	self:_refreshGreet()
end

function TurnbackNewBenfitView:refreshUI()
	local remainCount, totalCount = TurnbackModel.instance:getAdditionCountInfo()
	local remainStr = "#AC481A"

	self._txtdoublereward.text = string.format("<color=%s>%s</color>/%s", remainStr, remainCount, totalCount)

	self:_refreshRemainTime()
	self:_refreshMonthCard()
	self:_refreshSearchItem()
	self:_refreshGreet()

	local isAllFinish = TurnbackTaskModel.instance:checkOnlineTaskAllFinish()

	gohelper.setActive(self._goAllFinish, isAllFinish)
end

function TurnbackNewBenfitView:_refreshRemainTime()
	self._txtremaintime.text = TurnbackController.instance:refreshRemainTime(self.endTime)
	self._txtsearchremaintime.text = TurnbackController.instance:refreshRemainTime(self.searchEndTime)

	local day, hour, minute = TurnbackModel.instance:getRemainTime(self.endTime)
	local isPass = false

	isPass = day >= 0 and TurnbackModel.instance:isInOpenTime() or true

	gohelper.setActive(self._btndoublereward.gameObject, not isPass)
	gohelper.setActive(self._godoublerewardfinish, isPass)
	gohelper.setActive(self._godoublerewarddec, not isPass)
end

function TurnbackNewBenfitView:_refreshMonthCard()
	local state = TurnbackModel.instance:getMonthCardShowState()

	gohelper.setActive(self._btnturnbackmonthcard.gameObject, state)
	gohelper.setActive(self._gounlock, not state)

	self._canvasgroupmonthcard.alpha = state and 1 or 0.5
end

function TurnbackNewBenfitView:_refreshGreet()
	local state = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(self._btngreet.gameObject, not state)
	gohelper.setActive(self._gogreetbuyed, state)

	self._canvasgroupgreet.alpha = state and 0.5 or 1
end

function TurnbackNewBenfitView:_getEndTime()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local additionalDurationDays = TurnbackConfig.instance:getAdditionDurationDays(turnbackId)
	local mo = TurnbackModel.instance:getCurTurnbackMo()

	return mo.startTime + additionalDurationDays * TimeUtil.OneDaySecond
end

function TurnbackNewBenfitView:_getSeacrhEndTime()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local onlineDurationDays = TurnbackConfig.instance:getOnlineDurationDays(turnbackId)
	local mo = TurnbackModel.instance:getCurTurnbackMo()

	return mo.startTime + onlineDurationDays * TimeUtil.OneDaySecond
end

function TurnbackNewBenfitView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.config = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)
	self.jumptab = string.splitToNumber(self.config.jumpId, "#")
	self.endTime = self:_getEndTime()
	self.searchEndTime = self:_getSeacrhEndTime()

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_02)
	self:_initSearchItem()
end

function TurnbackNewBenfitView:_refreshSearchItem()
	local needlock = false

	for _, item in ipairs(self._searchItemList) do
		gohelper.setActive(item.gotxtlock, true)
		gohelper.setActive(item.btnclick.gameObject, true)

		local taskmo = TurnbackTaskModel.instance:getSearchTaskMoById(item.config.id)

		if taskmo then
			gohelper.setActive(item.golock, needlock)
			gohelper.setActive(item.gounlock, not needlock)

			if not needlock then
				if taskmo.finishCount > 0 then
					gohelper.setActive(item.gofinishing, false)
					gohelper.setActive(item.gocanget, false)
					gohelper.setActive(item.gohasget, true)

					local state = TurnbackEnum.SearchState.NotFinish

					if not item.state or item.state ~= state then
						item.state = state
					end
				elseif self:checkFinishedTask(taskmo) then
					gohelper.setActive(item.gofinishing, false)
					gohelper.setActive(item.gocanget, true)
					gohelper.setActive(item.gohasget, false)

					local state = TurnbackEnum.SearchState.CanGet

					if not item.state or item.state ~= state then
						item.state = state

						item.animtor:Update(0)
						item.animtor:Play("finishing")
					end
				else
					gohelper.setActive(item.gofinishing, true)
					gohelper.setActive(item.gocanget, false)
					gohelper.setActive(item.gohasget, false)

					local state = TurnbackEnum.SearchState.HasGet

					if not item.state or item.state ~= state then
						item.state = state

						gohelper.setActive(item.golock, false)
						gohelper.setActive(item.gounlock, true)

						if TurnbackController.instance:isPlayFirstUnlockToday(taskmo.id) then
							gohelper.setActive(item.golock, true)
							item.animtor:Update(0)
							item.animtor:Play("unlock")

							function self.afterunlockAnim()
								TaskDispatcher.cancelTask(self.afterunlockAnim, self)
								gohelper.setActive(item.golock, false)
								gohelper.setActive(item.gounlock, true)
								TurnbackController.instance:savePlayUnlockAnim(taskmo.id)
							end

							TaskDispatcher.runDelay(self.afterunlockAnim, self, 0.6)
						end
					end

					self.remainsearchtime = taskmo.config.maxProgress - taskmo.progress
					item.txtfinishing.text = TimeUtil.getFormatTime2(self.remainsearchtime)
					self._currentitem = item

					TaskDispatcher.runRepeat(self._updateSearchRemainTime, self, 1)

					needlock = true
				end
			else
				gohelper.setActive(item.golock, needlock)
				gohelper.setActive(item.gounlock, not needlock)
				item.animtor:Update(0)
				item.animtor:Play("idle")
			end
		else
			local needlock = true

			gohelper.setActive(item.golock, needlock)
			gohelper.setActive(item.gotxtlock, not needlock)
			gohelper.setActive(item.btnclick.gameObject, not needlock)
			gohelper.setActive(item.gounlock, not needlock)
		end
	end
end

function TurnbackNewBenfitView:_updateSearchRemainTime()
	if not self._currentitem or not self.remainsearchtime then
		return
	end

	self.remainsearchtime = self.remainsearchtime - 1

	if self.remainsearchtime > 0 then
		self._currentitem.txtfinishing.text = TimeUtil.getFormatTime2(self.remainsearchtime)
	else
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
		TaskDispatcher.cancelTask(self._updateSearchRemainTime, self)
	end
end

function TurnbackNewBenfitView:checkFinishedTask(taskMo)
	if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
		return true
	end

	return false
end

function TurnbackNewBenfitView:isTaskReceive(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function TurnbackNewBenfitView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		local isAllFinish = TurnbackTaskModel.instance:checkOnlineTaskAllFinish()

		gohelper.setActive(self._goAllFinish, isAllFinish)
	end
end

function TurnbackNewBenfitView:onClose()
	TaskDispatcher.cancelTask(self.afterunlockAnim, self)
	TaskDispatcher.cancelTask(self._updateSearchRemainTime, self)
end

function TurnbackNewBenfitView:onDestroyView()
	TaskDispatcher.cancelTask(self.afterunlockAnim, self)
	TaskDispatcher.cancelTask(self._updateSearchRemainTime, self)
end

return TurnbackNewBenfitView
