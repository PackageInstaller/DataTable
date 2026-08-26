-- chunkname: @modules/logic/seasonver/act123/view/Season123TaskItem.lua

module("modules.logic.seasonver.act123.view.Season123TaskItem", package.seeall)

local Season123TaskItem = class("Season123TaskItem", ListScrollCell)

Season123TaskItem.BlockKey = "Season123TaskItemAni"

function Season123TaskItem:init(go)
	self._viewGO = go
	self._simageBg = gohelper.findChildSingleImage(go, "#simage_bg")
	self._goNormal = gohelper.findChild(go, "#goNormal")
	self._goTotal = gohelper.findChild(go, "#goTotal")
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))

	self:initNormal()
	self:initTotal()

	self.firstEnter = true
end

function Season123TaskItem:addEventListeners()
	self._btnGoto:AddClickListener(self.onClickGoto, self)
	self._btnReceive:AddClickListener(self.onClickReceive, self)
	self._btnGetTotal:AddClickListener(self.onClickGetTotal, self)
end

function Season123TaskItem:removeEventListeners()
	self._btnGoto:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnGetTotal:RemoveClickListener()
end

function Season123TaskItem:initNormal()
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
	self._goType1 = gohelper.findChild(self._goGoto, "#go_gotype1")
	self._goEffect1 = gohelper.findChild(self._goGoto, "#go_gotype1/#go_effect1")
	self._goType3 = gohelper.findChild(self._goGoto, "#go_gotype3")
	self._goEffect3 = gohelper.findChild(self._goGoto, "#go_gotype3/#go_effect3")
	self._goreward = gohelper.findChild(self._goNormal, "rewardstar/#go_reward")
	self._gorewardCanvasGroup = self._goreward:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gorewardredicon = gohelper.findChild(self._goNormal, "rewardstar/#go_reward/red")
	self._gorewardlighticon = gohelper.findChild(self._goNormal, "rewardstar/#go_reward/light")
	self._gorewarddardicon = gohelper.findChild(self._goNormal, "rewardstar/#go_reward/dark")
end

function Season123TaskItem:initTotal()
	self._btnGetTotal = gohelper.findChildButtonWithAudio(self._goTotal, "#btn_getall")
end

Season123TaskItem.TaskMaskTime = 0.65
Season123TaskItem.ColumnCount = 1
Season123TaskItem.AnimRowCount = 7
Season123TaskItem.OpenAnimTime = 0.06
Season123TaskItem.OpenAnimStartTime = 0

function Season123TaskItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo
	self._scrollreward.parentGameObject = self._view._csListScroll.gameObject

	if self.mo.canGetAll then
		gohelper.setActive(self._goNormal, false)
		gohelper.setActive(self._goTotal, true)
		self._simageBg:LoadImage(ResUrl.getSeasonIcon("tap2.png"))
	else
		gohelper.setActive(self._goNormal, true)
		gohelper.setActive(self._goTotal, false)
		self:refreshNormal()
	end

	self:checkPlayAnim()
end

function Season123TaskItem:endPlayOpenAnim()
	gohelper.setActive(self._goEffect1, false)
	gohelper.setActive(self._goEffect3, false)

	self._ani.enabled = true
	self.firstEnter = false
end

function Season123TaskItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = Season123TaskModel.instance:getDelayPlayTime(self.mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1

		gohelper.setActive(self._goEffect1, false)
		gohelper.setActive(self._goEffect3, false)
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		gohelper.setActive(self._goEffect1, true)
		gohelper.setActive(self._goEffect3, true)
		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season123TaskItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season123TaskItem:refreshNormal()
	self.taskId = self.mo.id
	self.jumpId = self.mo.config.jumpId

	self:refreshReward()
	self:refreshDesc()
	self:refreshProgress()
	self:refreshState()
end

function Season123TaskItem:refreshReward()
	local config = self.mo.config
	local rewardStrList = string.split(config.bonus, "|")
	local dataList = {}

	for i, v in ipairs(rewardStrList) do
		if not string.nilorempty(v) then
			local itemCo = string.splitToNumber(v, "#")
			local co = {
				isIcon = true,
				materilType = itemCo[1],
				materilId = itemCo[2],
				quantity = itemCo[3]
			}

			table.insert(dataList, co)
		end
	end

	if config.equipBonus > 0 then
		table.insert(dataList, {
			equipId = config.equipBonus
		})
	end

	self._rewardItems = self._rewardItems or {}

	for i = 1, math.max(#self._rewardItems, #dataList) do
		local co = dataList[i]

		if not self._rewardItems[i] then
			local item = self:createRewardItem(i)

			self:refreshRewardItem(item, co)
		end
	end
end

function Season123TaskItem:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goRewardTemplate, self._gocontent, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	self._rewardItems[index] = item

	return item
end

function Season123TaskItem:refreshRewardItem(item, data)
	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	if data.equipId then
		gohelper.setActive(item.cardParent, true)
		gohelper.setActive(item.itemParent, false)

		if not item.equipIcon then
			item.equipIcon = Season123CelebrityCardItem.New()

			item.equipIcon:init(item.cardParent, data.equipId)
		end

		item.equipIcon:reset(data.equipId)

		return
	end

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

function Season123TaskItem:getAnimator()
	return self._ani
end

function Season123TaskItem:destroyRewardItem(item)
	if item.itemIcon then
		item.itemIcon:onDestroy()

		item.itemIcon = nil
	end

	if item.equipIcon then
		item.equipIcon:destroy()

		item.equipIcon = nil
	end
end

function Season123TaskItem:refreshDesc()
	local config = self.mo.config
	local bgStr = string.format("tap%s.png", config.bgType == 1 and 3 or 4)

	self._simageBg:LoadImage(ResUrl.getSeasonIcon(bgStr))

	self._txtDesc.text = config.desc
end

function Season123TaskItem:refreshProgress()
	self._txtCurCount.text = self.mo.progress
	self._txtMaxCount.text = self.mo.config.maxProgress

	local curTaskType = Season123TaskModel.instance.curTaskType

	gohelper.setActive(self._goreward, curTaskType == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(self._txtCurCount.gameObject, curTaskType == Activity123Enum.TaskNormalType)
end

function Season123TaskItem:refreshState()
	if self.mo.finishCount >= self.mo.config.maxFinishCount then
		gohelper.setActive(self._goMask, true)
		gohelper.setActive(self._goFinish, true)
		gohelper.setActive(self._goGoto, false)
		gohelper.setActive(self._goReceive, false)
		gohelper.setActive(self._goUnfinish, false)
		gohelper.setActive(self._gorewardredicon, self.mo.config.bgType == Activity123Enum.TaskHardType.Hard)
		gohelper.setActive(self._gorewardlighticon, self.mo.config.bgType == Activity123Enum.TaskHardType.Normal)
		gohelper.setActive(self._gorewarddardicon, false)

		self._gorewardCanvasGroup.alpha = 0.3
	elseif self.mo.hasFinished then
		gohelper.setActive(self._goMask, false)
		gohelper.setActive(self._goFinish, false)
		gohelper.setActive(self._goGoto, false)
		gohelper.setActive(self._goReceive, true)
		gohelper.setActive(self._goUnfinish, false)
		gohelper.setActive(self._gorewardredicon, self.mo.config.bgType == Activity123Enum.TaskHardType.Hard)
		gohelper.setActive(self._gorewardlighticon, self.mo.config.bgType == Activity123Enum.TaskHardType.Normal)
		gohelper.setActive(self._gorewarddardicon, false)

		self._gorewardCanvasGroup.alpha = 1
	else
		gohelper.setActive(self._goMask, false)
		gohelper.setActive(self._goFinish, false)
		gohelper.setActive(self._goReceive, false)

		if self.jumpId and self.jumpId > 0 then
			gohelper.setActive(self._goGoto, true)
			gohelper.setActive(self._goUnfinish, false)
			gohelper.setActive(self._goType1, self.mo.config.bgType ~= 1)
			gohelper.setActive(self._goType3, self.mo.config.bgType == 1)
		else
			gohelper.setActive(self._goGoto, false)
			gohelper.setActive(self._goUnfinish, true)
		end

		gohelper.setActive(self._gorewardredicon, false)
		gohelper.setActive(self._gorewardlighticon, false)
		gohelper.setActive(self._gorewarddardicon, true)

		self._gorewardCanvasGroup.alpha = 1
	end
end

function Season123TaskItem:onClickGoto()
	if not self.jumpId then
		return
	end

	GameFacade.jump(self.jumpId)
end

function Season123TaskItem:onClickReceive()
	if not self.taskId and not self.mo.canGetAll then
		return
	end

	gohelper.setActive(self._goMask, true)
	self._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(Season123TaskItem.BlockKey)
	Season123Controller.instance:dispatchEvent(Season123Event.OnTaskRewardGetFinish, self._index)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, Season123TaskItem.TaskMaskTime)
end

function Season123TaskItem:_onPlayActAniFinished()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.mo.canGetAll then
		local canGetIdList = Season123TaskModel.instance:getAllCanGetList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season123, 0, canGetIdList, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	end

	UIBlockMgr.instance:endBlock(Season123TaskItem.BlockKey)
end

function Season123TaskItem:onClickGetTotal()
	self:onClickReceive()
end

function Season123TaskItem:onDestroy()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			self:destroyRewardItem(item)
		end

		self._rewardItems = nil
	end

	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
end

return Season123TaskItem
