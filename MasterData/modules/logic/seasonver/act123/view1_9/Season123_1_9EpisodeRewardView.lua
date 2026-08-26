-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EpisodeRewardView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EpisodeRewardView", package.seeall)

local Season123_1_9EpisodeRewardView = class("Season123_1_9EpisodeRewardView", BaseView)

function Season123_1_9EpisodeRewardView:onInitView()
	self._goRwards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rewards/#btn_close")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#go_rewards/#scroll_rewardview")
	self._goContent = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content")
	self._gofillbg = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_fillbg")
	self._gofill = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_fillbg/#go_fill")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_rewardContent/#go_rewarditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_9EpisodeRewardView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.OpenEpisodeRewardView, self.refreshUI, self)
end

function Season123_1_9EpisodeRewardView:removeEvents()
	self._btnClose:RemoveClickListener()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshUI, self)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.OpenEpisodeRewardView, self.refreshUI, self)
end

function Season123_1_9EpisodeRewardView:_btnCloseOnClick()
	self:resetView()
end

function Season123_1_9EpisodeRewardView:_editableInitView()
	self._rewardItems = self:getUserDataTb_()
	self._goContentHLayout = self._goContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
end

function Season123_1_9EpisodeRewardView:onOpen()
	self.actId = self.viewParam.actId
	self.stage = self.viewParam.stage
	self.targetNumList = {}
end

function Season123_1_9EpisodeRewardView:refreshUI()
	local seasonMOTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {}

	Season123EpisodeRewardModel.instance:init(self.actId, seasonMOTasks)
	gohelper.setActive(self._goRwards, true)
	Season123EpisodeRewardModel.instance:setTaskInfoList(self.stage)

	self.itemList = Season123EpisodeRewardModel.instance:getList()

	self:initTargetNumList()

	local stageMOInfo = Season123Model.instance:getActInfo(self.actId):getStageMO(self.stage)

	self.stageMinRound = stageMOInfo.minRound
	self.stageIsPass = stageMOInfo.isPass
	self.defaultProgress = self.targetNumList[1] + 5

	if self.stageMinRound == 0 or not self.stageIsPass then
		self.curProgress = self.defaultProgress or self.stageMinRound
	end

	self:createAndRefreshRewardItem()
	self:refreshProgressBar()
	self:refreshScrollPos()
end

function Season123_1_9EpisodeRewardView:createAndRefreshRewardItem()
	gohelper.CreateObjList(self, self.rewardItemShow, self.itemList, self._gorewardContent, self._gorewardItem)
end

function Season123_1_9EpisodeRewardView:rewardItemShow(obj, data, index)
	obj.name = "rewardItem" .. index

	local txtScore = gohelper.findChildTextMesh(obj, "txt_score")
	local godarkPoint = gohelper.findChild(obj, "darkpoint")
	local golightPoint = gohelper.findChild(obj, "lightpoint")
	local gocontent = gohelper.findChild(obj, "layout")
	local goreward = gohelper.findChild(obj, "layout/go_reward")

	gohelper.setActive(goreward, false)

	local paramList = string.split(data.config.listenerParam, "#")

	txtScore.text = paramList[2]

	local targetProgress = tonumber(paramList[2])

	SLFramework.UGUI.GuiHelper.SetColor(txtScore, targetProgress >= self.curProgress and "#E27F45" or "#9F9F9F")
	gohelper.setActive(godarkPoint, targetProgress < self.curProgress)
	gohelper.setActive(golightPoint, targetProgress >= self.curProgress)

	local itemIconList = self._rewardItems[index]
	local bonusList = GameUtil.splitString2(data.config.bonus, true, "|", "#")

	if not itemIconList then
		itemIconList = {}

		for itemIndex, bonus in ipairs(bonusList) do
			local itemTab = {}

			itemTab.itemGO = gohelper.cloneInPlace(goreward, "item" .. tostring(index))
			itemTab.goItemPos = gohelper.findChild(itemTab.itemGO, "go_itempos")
			itemTab.icon = IconMgr.instance:getCommonPropItemIcon(itemTab.goItemPos)
			itemTab.goHasGet = gohelper.findChild(itemTab.itemGO, "go_hasget")
			itemTab.goCanGet = gohelper.findChild(itemTab.itemGO, "go_canget")
			itemTab.btnCanGet = gohelper.findChildButtonWithAudio(itemTab.itemGO, "go_canget")

			itemTab.btnCanGet:AddClickListener(self.onItemGetClick, self)
			gohelper.setActive(itemTab.itemGO, true)
			itemTab.icon:setMOValue(bonus[1], bonus[2], bonus[3])
			itemTab.icon:setHideLvAndBreakFlag(true)
			itemTab.icon:hideEquipLvAndBreak(true)
			itemTab.icon:setCountFontSize(51)

			itemIconList[itemIndex] = itemTab
		end
	end

	self._rewardItems[index] = itemIconList

	for index, item in pairs(itemIconList) do
		gohelper.setActive(item.goHasGet, data.finishCount >= data.config.maxFinishCount)
		gohelper.setActive(item.goCanGet, data.progress >= data.config.maxProgress and data.hasFinished)
	end
end

function Season123_1_9EpisodeRewardView:onItemGetClick()
	local canGetRewardList = Season123EpisodeRewardModel.instance:getCurStageCanGetReward()

	if #canGetRewardList ~= 0 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season123, 0, canGetRewardList, nil, nil, 0)
	end
end

function Season123_1_9EpisodeRewardView:refreshProgressBar()
	local firstPartH = self._goContentHLayout.padding.left + 98
	local endH = self._goContentHLayout.padding.right + 102 - 20
	local tagH = 40
	local normalPartH = 236
	local firstNum = self.defaultProgress
	local nowIndex = 0
	local nowIndexValue = 0
	local nextIndexValue = 0
	local processH = 0

	for index, targetNum in ipairs(self.targetNumList) do
		if targetNum >= self.curProgress then
			nowIndex = index
			nowIndexValue = targetNum
			nextIndexValue = targetNum
		elseif nowIndexValue <= nextIndexValue then
			nextIndexValue = targetNum
		end
	end

	processH = nowIndex == 0 and (firstNum <= self.curProgress and firstPartH / 2 or firstPartH / 2 + (firstNum - self.curProgress) / (firstPartH / 2)) or firstPartH + nowIndex * tagH + (nowIndex - 1) * normalPartH + ((nextIndexValue ~= nowIndexValue or nil) and (self.curProgress - nowIndexValue) / (nextIndexValue - nowIndexValue)) * normalPartH

	local targetCount = #self.targetNumList

	self.totalWidth = math.max(1287, firstPartH + (targetCount - 1) * normalPartH + targetCount * tagH + endH)

	recthelper.setWidth(self._gofill.transform, (nowIndex == targetCount or nil) and self.totalWidth)
end

function Season123_1_9EpisodeRewardView:initTargetNumList()
	if #self.targetNumList == 0 then
		for index, mo in pairs(self.itemList) do
			local targetNum = tonumber(string.split(mo.config.listenerParam, "#")[2])

			table.insert(self.targetNumList, targetNum)
		end
	end
end

function Season123_1_9EpisodeRewardView:refreshScrollPos()
	local itemWidth = 240
	local itemSpaceH = 36
	local getCurCanGetIndex = self:getCurCanGetIndex()
	local scrollWidth = recthelper.getWidth(self._scrollreward.transform)

	if getCurCanGetIndex == nil or getCurCanGetIndex <= 0 then
		self._scrollreward.horizontalNormalizedPosition = 1
	else
		local moveOffset = math.max(0, (getCurCanGetIndex - 0.5) * (itemWidth + itemSpaceH))

		self._scrollreward.horizontalNormalizedPosition = Mathf.Clamp01(moveOffset / (self.totalWidth + 20 - scrollWidth))
	end
end

function Season123_1_9EpisodeRewardView:getCurCanGetIndex()
	for index, rewardMO in pairs(self.itemList) do
		if rewardMO.progress >= rewardMO.config.maxProgress and rewardMO.hasFinished or rewardMO.finishCount < rewardMO.config.maxFinishCount then
			return index - 1
		end
	end

	return nil
end

function Season123_1_9EpisodeRewardView:resetView()
	gohelper.setActive(self._goRwards, false)
end

function Season123_1_9EpisodeRewardView:onClose()
	return
end

function Season123_1_9EpisodeRewardView:onDestroyView()
	for _, rewardItem in pairs(self._rewardItems) do
		for index, item in pairs(rewardItem) do
			item.btnCanGet:RemoveClickListener()
		end
	end
end

return Season123_1_9EpisodeRewardView
