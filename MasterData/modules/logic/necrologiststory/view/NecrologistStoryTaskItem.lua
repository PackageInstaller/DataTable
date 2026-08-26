-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryTaskItem.lua

module("modules.logic.necrologiststory.view.NecrologistStoryTaskItem", package.seeall)

local NecrologistStoryTaskItem = class("NecrologistStoryTaskItem", ListScrollCellExtend)

NecrologistStoryTaskItem.BlockKey = "NecrologistStoryTaskItemAni"

function NecrologistStoryTaskItem:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "#goNormal")
	self._goTotal = gohelper.findChild(self.viewGO, "#goTotal")
	self._ani = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:initNormal()
	self:initTotal()
end

function NecrologistStoryTaskItem:addEventListeners()
	self._btnGoto:AddClickListener(self.onClickGoto, self)
	self._btnReceive:AddClickListener(self.onClickReceive, self)
	self._btnGetTotal:AddClickListener(self.onClickGetTotal, self)
end

function NecrologistStoryTaskItem:removeEventListeners()
	self._btnGoto:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnGetTotal:RemoveClickListener()
end

function NecrologistStoryTaskItem:initNormal()
	self._txtCurCount = gohelper.findChildTextMesh(self._goNormal, "#txt_curcount")
	self._txtMaxCount = gohelper.findChildTextMesh(self._goNormal, "#txt_curcount/#txt_maxcount")
	self._txtDesc = gohelper.findChildTextMesh(self._goNormal, "#txt_desc")
	self._scrollreward = gohelper.findChild(self._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gocontent = gohelper.findChild(self._goNormal, "#scroll_rewards/Viewport/Content")
	self._goRewardTemplate = gohelper.findChild(self._gocontent, "#go_rewarditem")

	gohelper.setActive(self._goRewardTemplate, false)

	self._goMask = gohelper.findChild(self._goNormal, "#go_blackmask")
	self._goFinish = gohelper.findChild(self._goNormal, "#go_finish")
	self._goGoto = gohelper.findChild(self._goNormal, "#btn_goto")
	self._btnGoto = gohelper.findChildButtonWithAudio(self._goNormal, "#btn_goto")
	self._goReceive = gohelper.findChild(self._goNormal, "#btn_receive")
	self._btnReceive = gohelper.findChildButtonWithAudio(self._goNormal, "#btn_receive")
	self._goUnfinish = gohelper.findChild(self._goNormal, "#go_unfinish")
	self.goTime = gohelper.findChild(self._goNormal, "#go_time")
	self.txtTime = gohelper.findChildTextMesh(self.goTime, "bg/txt")
end

function NecrologistStoryTaskItem:initInternal(...)
	NecrologistStoryTaskItem.super.initInternal(self, ...)

	self._scrollreward.parentGameObject = self._view._csListScroll.gameObject
end

function NecrologistStoryTaskItem:initTotal()
	self._btnGetTotal = gohelper.findChildButtonWithAudio(self._goTotal, "#btn_getall")
end

function NecrologistStoryTaskItem:getAnimator()
	return self._ani
end

function NecrologistStoryTaskItem:onUpdateMO(data)
	self.taskMo = data

	TaskDispatcher.cancelTask(self._frameRefreshTime, self)
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if data.isTotalGet then
		self.storyId = data.storyId

		gohelper.setActive(self._goNormal, false)
		gohelper.setActive(self._goTotal, true)
	else
		gohelper.setActive(self._goNormal, true)
		gohelper.setActive(self._goTotal, false)
		self:refreshNormal(data)
	end
end

function NecrologistStoryTaskItem:hide()
	gohelper.setActive(self._viewGO, false)
end

function NecrologistStoryTaskItem:refreshNormal(data)
	self.taskId = data.id
	self.jumpId = data.config.jumpId

	gohelper.setActive(self._viewGO, true)
	self:refreshReward(data)
	self:refreshDesc(data)
	self:refreshProgress(data)
	self:refreshState(data)
	self:refreshTime()
end

function NecrologistStoryTaskItem:refreshReward(data)
	local config = data.config
	local rewardList = DungeonConfig.instance:getRewardItems(tonumber(config.bonus))
	local dataList = {}

	for i, v in ipairs(rewardList) do
		local co = {
			isIcon = true,
			materilType = v[1],
			materilId = v[2],
			quantity = v[3]
		}

		table.insert(dataList, co)
	end

	self._rewardItems = self._rewardItems or {}

	local count = #dataList

	for i = 1, math.max(#self._rewardItems, count) do
		local co = dataList[i]

		if not self._rewardItems[i] then
			local item = self:createRewardItem(i)

			self:refreshRewardItem(self._rewardItems[i], co)
		end
	end

	if self.dataCount and self.dataCount ~= count then
		recthelper.setAnchorX(self._gocontent.transform, 0)
	end

	self.dataCount = count
end

function NecrologistStoryTaskItem:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goRewardTemplate, self._gocontent, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	self._rewardItems[index] = item

	return item
end

function NecrologistStoryTaskItem:refreshRewardItem(item, data)
	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)
	gohelper.setActive(item.cardParent, false)
	gohelper.setActive(item.itemParent, true)

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.itemParent)

	item.itemIcon:onUpdateMO(data)
	item.itemIcon:isShowCount(true)
	item.itemIcon:setCountFontSize(40)
	item.itemIcon:showStackableNum2()
	item.itemIcon:setHideLvAndBreakFlag(true)
	item.itemIcon:hideEquipLvAndBreak(true)
end

function NecrologistStoryTaskItem:refreshDesc(data)
	local config = data.config

	self._txtDesc.text = config.desc
end

function NecrologistStoryTaskItem:refreshProgress(data)
	self._txtCurCount.text = data.progress
	self._txtMaxCount.text = data.config.maxProgress
end

function NecrologistStoryTaskItem:refreshState(data)
	if data:isClaimed() then
		gohelper.setActive(self._goMask, true)
		gohelper.setActive(self._goFinish, true)
		gohelper.setActive(self._goGoto, false)
		gohelper.setActive(self._goReceive, false)
		gohelper.setActive(self._goUnfinish, false)
	elseif data.hasFinished then
		gohelper.setActive(self._goMask, false)
		gohelper.setActive(self._goFinish, false)
		gohelper.setActive(self._goGoto, false)
		gohelper.setActive(self._goReceive, true)
		gohelper.setActive(self._goUnfinish, false)
	else
		gohelper.setActive(self._goMask, false)
		gohelper.setActive(self._goFinish, false)
		gohelper.setActive(self._goReceive, false)

		if self.jumpId and self.jumpId > 0 then
			gohelper.setActive(self._goGoto, true)
			gohelper.setActive(self._goUnfinish, false)
		else
			gohelper.setActive(self._goGoto, false)
			gohelper.setActive(self._goUnfinish, true)
		end
	end
end

function NecrologistStoryTaskItem:onClickGoto()
	if not self.jumpId then
		return
	end

	if GameFacade.jump(self.jumpId) then
		ViewMgr.instance:closeView(ViewName.NecrologistStoryTaskView)
	end
end

function NecrologistStoryTaskItem:onClickReceive()
	if not self.taskId then
		return
	end

	gohelper.setActive(self._goMask, true)
	self._ani:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(NecrologistStoryTaskItem.BlockKey)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, 0.76)
end

function NecrologistStoryTaskItem:onClickGetTotal()
	NecrologistStoryTaskListModel.instance:sendFinishAllTaskRequest(self.storyId)
end

function NecrologistStoryTaskItem:_onPlayActAniFinished()
	UIBlockMgr.instance:endBlock(NecrologistStoryTaskItem.BlockKey)
	TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	self:hide()
end

function NecrologistStoryTaskItem:refreshTime()
	TaskDispatcher.cancelTask(self._frameRefreshTime, self)

	local notFinish = not self.taskMo:isClaimed() and self.taskMo.config.activityId ~= 0

	gohelper.setActive(self.goTime, notFinish)

	if not notFinish then
		return
	end

	TaskDispatcher.runDelay(self._frameRefreshTime, self, 1)
	self:_frameRefreshTime()
end

function NecrologistStoryTaskItem:_frameRefreshTime()
	if not self.taskMo then
		return
	end

	local activityId = self.taskMo.config.activityId
	local actInfoMo = ActivityModel.instance:getActMO(activityId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local time, timeFormat = TimeUtil.getFormatTime1(offsetSecond, true)

		self.txtTime.text = time
	else
		TaskDispatcher.cancelTask(self._frameRefreshTime, self)
		gohelper.setActive(self.goTime, false)
	end
end

function NecrologistStoryTaskItem:onDestroy()
	TaskDispatcher.cancelTask(self._frameRefreshTime, self)
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
end

return NecrologistStoryTaskItem
