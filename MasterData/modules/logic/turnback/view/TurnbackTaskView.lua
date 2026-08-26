-- chunkname: @modules/logic/turnback/view/TurnbackTaskView.lua

module("modules.logic.turnback.view.TurnbackTaskView", package.seeall)

local TurnbackTaskView = class("TurnbackTaskView", BaseView)

function TurnbackTaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._goprocessIcon = gohelper.findChild(self.viewGO, "left/title/#go_progressIcon")
	self._gonoprocessIcon = gohelper.findChild(self.viewGO, "left/title/#go_noprogressIcon")
	self._txtactiveNum = gohelper.findChildText(self.viewGO, "left/title/#txt_activeNum")
	self._imageactiveIcon = gohelper.findChildImage(self.viewGO, "left/title/#txt_activeNum/icon")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_reward")
	self._gobar = gohelper.findChild(self.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_bar")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_bar/#image_progress")
	self._gorewardContent = gohelper.findChild(self.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_rewardItem")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "right/#txt_remainTime")
	self._txtdesc = gohelper.findChildText(self.viewGO, "right/#txt_desc")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_task")
	self._gotaskViewport = gohelper.findChild(self.viewGO, "right/#scroll_task/Viewport")
	self._gotaskContent = gohelper.findChild(self.viewGO, "right/#scroll_task/Viewport/#go_taskContent")
	self._godaytime = gohelper.findChild(self.viewGO, "right/#go_daytime")
	self._gotoggleGroup = gohelper.findChild(self.viewGO, "right/taskToggleGroup")
	self._toggleGroup = self._gotoggleGroup:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_story")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackTaskView:addEvents()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshTaskRedDot, self._refreshRedDot, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._playEndStory, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshBonusPoint, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
end

function TurnbackTaskView:removeEvents()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshTaskRedDot, self._refreshRedDot, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._playEndStory, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshBonusPoint, self)
	self._btnstory:RemoveClickListener()
end

local ToggleIdForLoopType = {
	TurnbackEnum.TaskLoopType.Day,
	TurnbackEnum.TaskLoopType.Long
}
local taskItemCanSeeCount = 4

function TurnbackTaskView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_taskfullbg"))

	self._isFirstEnter = true

	gohelper.setActive(self._gorewardItem, false)

	self._rewardItemTab = self:getUserDataTb_()
	self._taskToggleWraps = self:getUserDataTb_()
	self._toggleRedDotTab = self:getUserDataTb_()
end

function TurnbackTaskView:onUpdateParam()
	return
end

function TurnbackTaskView:onOpen()
	local parentGO = self.viewParam.parent

	self.viewConfig = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)
	self.curTaskLoopType = TurnbackEnum.TaskLoopType.Day
	self.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.bonusPointType, self.bonusPointId = TurnbackConfig.instance:getBonusPointCo(self.curTurnbackId)

	local bonusPointCO = CurrencyConfig.instance:getCurrencyCo(self.bonusPointId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageactiveIcon, bonusPointCO.icon .. "_1")
	gohelper.addChild(parentGO, self.viewGO)
	self:_initComp()
	self:_createTaskBonusItem()
	self:_onToggleValueChanged(1, true)
	self:_refreshUI()

	self._isFirstEnter = false
end

function TurnbackTaskView:_initComp()
	local taskToggleTrans = self._gotoggleGroup.transform
	local toggleCount = taskToggleTrans.childCount

	for i = 1, toggleCount do
		local childGO = taskToggleTrans:GetChild(i - 1)
		local toggleComp = childGO:GetComponent(typeof(UnityEngine.UI.Toggle))

		if toggleComp then
			local toggleWrap = gohelper.onceAddComponent(childGO, typeof(SLFramework.UGUI.ToggleWrap))

			toggleWrap:AddOnValueChanged(self._onToggleValueChanged, self, i)

			self._taskToggleWraps[i] = toggleWrap
		end
	end

	for i = 1, 2 do
		self._toggleRedDotTab[i] = gohelper.findChild(self.viewGO, "right/redDot/#go_reddot" .. i)
	end

	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer._scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(TurnbackEnum.TaskMaskTime - TurnbackEnum.TaskGetAnimTime)
end

function TurnbackTaskView:_createTaskBonusItem()
	local taskBonusCount = GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId))

	for index = 1, taskBonusCount do
		local rewardItem = self._rewardItemTab[index]

		if not rewardItem then
			local rewardItem = self:getUserDataTb_()

			rewardItem.go = gohelper.clone(self._gorewardItem, self._gorewardContent, "rewardItem" .. index)
			rewardItem.item = MonoHelper.addNoUpdateLuaComOnceToGo(rewardItem.go, TurnbackTaskBonusItem, {
				index = index,
				parentScrollGO = self._scrollreward.gameObject
			})

			gohelper.setActive(rewardItem.go, true)
			table.insert(self._rewardItemTab, rewardItem)
		end
	end

	for i = taskBonusCount + 1, #self._rewardItemTab do
		gohelper.setActive(self._rewardItemTab[i].go, false)
	end
end

function TurnbackTaskView:_refreshTaskProcessBar(curActiveCount)
	local firstPartH = 26
	local tagH = 52
	local normalPartH = 98
	local endH = 25
	local bonusTab = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)
	local bonusCount = GameUtil.getTabLen(bonusTab)
	local totalHeight = firstPartH + (bonusCount - 1) * normalPartH + bonusCount * tagH + endH

	recthelper.setHeight(self._gobar.transform, totalHeight)

	local nowIndex = 0
	local nowIndexValue = 0
	local nextIndexValue = 0
	local offsetValue = 0
	local processH = 0

	for index, co in ipairs(bonusTab) do
		if curActiveCount >= co.needPoint then
			nowIndex = index
			nowIndexValue = co.needPoint
			nextIndexValue = co.needPoint
		elseif nextIndexValue <= nowIndexValue then
			nextIndexValue = co.needPoint
		end
	end

	if nextIndexValue ~= nowIndexValue then
		offsetValue = (curActiveCount - nowIndexValue) / (nextIndexValue - nowIndexValue)
	end

	processH = nowIndex == 0 and firstPartH * offsetValue or firstPartH + nowIndex * tagH + (nowIndex - 1) * normalPartH + offsetValue * normalPartH

	if nowIndex == bonusCount then
		processH = processH + endH
	end

	recthelper.setHeight(self._imageprogress.transform, processH)
end

function TurnbackTaskView:_onToggleValueChanged(toggleId, isOn)
	if isOn then
		if not self._isFirstEnter then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
		end

		self.curTaskLoopType = ToggleIdForLoopType[toggleId]

		TurnbackTaskModel.instance:refreshList(self.curTaskLoopType)

		self._scrolltask.verticalNormalizedPosition = 1
	end

	for i = 1, #self._taskToggleWraps do
		local txt = gohelper.findChildText(self._taskToggleWraps[i].gameObject, "txt")

		SLFramework.UGUI.GuiHelper.SetColor(txt, self.curTaskLoopType == ToggleIdForLoopType[i] and "#E99B56" or "#ffffff")
		ZProj.UGUIHelper.SetColorAlpha(txt, self.curTaskLoopType == ToggleIdForLoopType[i] and 1 or 0.3)

		local gonormal = gohelper.findChild(self._taskToggleWraps[i].gameObject, "Background/go_normal")
		local goselect = gohelper.findChild(self._taskToggleWraps[i].gameObject, "Background/go_select")

		gohelper.setActive(gonormal, self.curTaskLoopType ~= ToggleIdForLoopType[i])
		gohelper.setActive(goselect, self.curTaskLoopType == ToggleIdForLoopType[i])
	end

	gohelper.setActive(self._godaytime, self.curTaskLoopType == TurnbackEnum.TaskLoopType.Day)
	recthelper.setAnchorY(self._scrolltask.gameObject.transform, self.curTaskLoopType == TurnbackEnum.TaskLoopType.Day and 0 or 50)

	local itemCount = TurnbackTaskModel.instance:getCount()

	recthelper.setHeight(self._scrolltask.gameObject.transform, itemCount <= taskItemCanSeeCount and 496 or 683)

	self._gotaskViewport.transform.offsetMin = itemCount <= taskItemCanSeeCount and Vector2(0, 0) or Vector2(0, self.viewContainer._scrollView._param.cellHeight + self.viewContainer._scrollView._param.cellSpaceV)
end

function TurnbackTaskView:_btnstoryOnClick()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if TurnbackMo then
		::label_11_0::

		local var_11_0 = TurnbackMo.config

		if TurnbackMo.config then
			local storyId = TurnbackMo.config.endStory

			if storyId then
				StoryController.instance:playStory(storyId)
			else
				logError(string.format("TurnbackTaskView endStoryId is nil", storyId))
			end
		end
	end
end

function TurnbackTaskView:_refreshUI()
	local bonusPointMo = CurrencyModel.instance:getCurrency(self.bonusPointId)

	if bonusPointMo then
		if not bonusPointMo.quantity then
			local curActiveCount = 0

			self:_refreshTaskProcessBar(curActiveCount)

			self._txtactiveNum.text = curActiveCount
			self._txtdesc.text = self.viewConfig.actDesc

			gohelper.setActive(self._goprocessIcon, curActiveCount > 0)
			gohelper.setActive(self._gonoprocessIcon, curActiveCount == 0)
			self:_refreshRemainTime()
			self:_refreshRedDot()
			self:_refreshStoryBtn()
		end
	end
end

function TurnbackTaskView:_refreshRedDot()
	local taskLoopTypeDotState = TurnbackTaskModel.instance:getTaskLoopTypeDotState()

	for index, reddotGo in pairs(self._toggleRedDotTab) do
		local loopType = ToggleIdForLoopType[index]

		gohelper.setActive(reddotGo, taskLoopTypeDotState[loopType])
	end
end

function TurnbackTaskView:_refreshRemainTime()
	self._txtremainTime.text = TurnbackController.instance:refreshRemainTime()
end

function TurnbackTaskView:_refreshStoryBtn()
	local config = TurnbackConfig.instance:getTurnbackCo(self.curTurnbackId)

	if config then
		::label_15_0::

		local var_15_0 = StoryModel.instance:isStoryFinished(config.endStory)

		if var_15_0 then
			var_15_0 = self:_canPlayEndStory()

			local canShowBtn = var_15_0

			gohelper.setActive(self._btnstory, canShowBtn)
		end
	end
end

function TurnbackTaskView:_refreshBonusPoint(currencyIds)
	if currencyIds[self.bonusPointId] then
		self:_refreshUI()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRewardItem)
	end
end

function TurnbackTaskView:_playGetRewardFinishAnim(index)
	if not TurnbackModel.instance:isInOpenTime() or not index then
		TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)

		return
	end

	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, TurnbackEnum.TaskGetAnimTime)
end

function TurnbackTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function TurnbackTaskView:_playEndStory(viewName)
	if viewName == ViewName.CommonPropView and self:_canPlayEndStory() then
		local storyId = TurnbackModel.instance:getCurTurnbackMo().config.endStory

		if not StoryModel.instance:isStoryFinished(storyId) then
			StoryController.instance:playStory(storyId, nil, self._refreshStoryBtn, self)
		end
	end
end

function TurnbackTaskView:_canPlayEndStory()
	local curturnbackMo = TurnbackModel.instance:getCurTurnbackMo()
	local totalTaskBonusCount = GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(curturnbackMo.id))

	return #curturnbackMo.hasGetTaskBonus == totalTaskBonusCount
end

function TurnbackTaskView:onClose()
	for i = 1, #self._taskToggleWraps do
		self._taskToggleWraps[i]:RemoveOnValueChanged()
	end

	self._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
end

function TurnbackTaskView:onDestroyView()
	return
end

return TurnbackTaskView
