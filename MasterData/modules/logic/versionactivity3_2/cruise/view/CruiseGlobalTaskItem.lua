-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseGlobalTaskItem.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseGlobalTaskItem", package.seeall)

local CruiseGlobalTaskItem = class("CruiseGlobalTaskItem", LuaCompBase)
local waitOpenTime = 0.3

function CruiseGlobalTaskItem:init(go, index)
	self.go = go
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._index = index
	self._golock = gohelper.findChild(go, "#go_lock")
	self._txtlocknum = gohelper.findChildText(go, "#go_lock/#txt_num1")
	self._txtlockname = gohelper.findChildText(go, "#go_lock/namebg/txt_name1")
	self._gounlock = gohelper.findChild(go, "#go_unlock")
	self._gonormalbg = gohelper.findChild(go, "#go_unlock/normalbg")
	self._txtunlocknum = gohelper.findChildText(go, "#go_unlock/#txt_num")
	self._txtunlockname = gohelper.findChildText(go, "#go_unlock/txt_name")
	self._gounlockicon = gohelper.findChild(go, "#go_unlock/go_unlock")
	self._txtpercent = gohelper.findChildText(go, "#go_unlock/go_unlock/#txt_percent")
	self._gorewarditem = gohelper.findChild(go, "scroll_Reward/Viewport/Content/go_rewarditem")
	self._imageschedulefg = gohelper.findChildImage(go, "go_schedulefg")

	gohelper.setActive(self._gorewarditem, false)

	self._actId = VersionActivity3_2Enum.ActivityId.CruiseGlobalTask
	self._rewardItems = {}

	gohelper.setActive(self.go, false)

	local delayTime = waitOpenTime + 0.06 * self._index

	TaskDispatcher.runDelay(self._onInFinished, self, delayTime)
	self:addEvents()
end

function CruiseGlobalTaskItem:_onInFinished()
	gohelper.setActive(self.go, true)
	self._anim:Play("in", 0, 0)
end

function CruiseGlobalTaskItem:addEvents()
	return
end

function CruiseGlobalTaskItem:removeEvents()
	return
end

function CruiseGlobalTaskItem:_btnclickOnClick()
	local isActUnlock = ActivityHelper.isOpen(self._config.globalTaskActivityId)

	if not isActUnlock then
		GameFacade.showToast(ToastEnum.CruiseGlobalTaskStageLocked)

		return
	end

	TaskRpc.instance:sendFinishTaskRequest(self._taskConfig.id, self._onFinishedTask, self)
end

function CruiseGlobalTaskItem:_onFinishedTask()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.CruiseGlobalStage1,
		RedDotEnum.DotNode.CruiseGlobalStage2,
		RedDotEnum.DotNode.CruiseGlobalStage3,
		RedDotEnum.DotNode.CruiseGlobalStage4,
		RedDotEnum.DotNode.CruiseMainBtn,
		RedDotEnum.DotNode.CruiseGlobalTaskBtn
	})
end

function CruiseGlobalTaskItem:_btnextraclickOnClick()
	GameFacade.showToast(ToastEnum.CruiseSelfTaskExtraTip)
end

function CruiseGlobalTaskItem:refresh(co)
	self._config = co
	self._taskConfig = Activity173Config.instance:getTaskConfig(self._config.globalTaskId)

	local isActUnlock = ActivityHelper.isOpen(self._config.globalTaskActivityId)

	self._isUnlock = self._isUnlock or isActUnlock

	if isActUnlock and not self._isUnlock then
		self._anim:Play("unlock", 0, 0)

		self._isUnlock = isActUnlock
	end

	if isActUnlock then
		self:_refreshUnlock()
	else
		self:_refreshLock()
	end

	self:_refreshTaskRewards()
end

function CruiseGlobalTaskItem:_refreshUnlock()
	gohelper.setActive(self._golock, false)
	gohelper.setActive(self._gounlock, true)

	self._txtunlocknum.text = string.format("%02d", self._config.stageId)
	self._txtunlockname.text = self._taskConfig.name
	self._taskMO = TaskModel.instance:getTaskById(self._taskConfig.id)

	if self._taskMO then
		if not (self._taskMO.progress / self._taskConfig.maxProgress) then
			local scale = 0

			self._scale = self._scale or scale

			if scale >= 1 and self._scale < 1 then
				self._anim:Play("refresh", 0, 0)

				self._scale = scale
			end

			self._imageschedulefg.fillAmount = scale

			gohelper.setActive(self._gonormalbg, scale < 1)

			self._txtpercent.text = string.format("%d%%", 100 * scale)
		end
	end
end

function CruiseGlobalTaskItem:_refreshLock()
	gohelper.setActive(self._golock, true)
	gohelper.setActive(self._gounlock, false)

	self._txtlocknum.text = string.format("%02d", self._config.stageId)
	self._txtlockname.text = self._taskConfig.name
	self._imageschedulefg.fillAmount = 0
end

function CruiseGlobalTaskItem:_refreshTaskRewards()
	for _, v in pairs(self._rewardItems) do
		gohelper.setActive(v.go, false)
	end

	local rewards = string.split(self._taskConfig.bonus, "|")

	for i = 1, #rewards do
		if not self._rewardItems[i] then
			self._rewardItems[i] = {}
			self._rewardItems[i].go = gohelper.cloneInPlace(self._gorewarditem)
			self._rewardItems[i].itemRoot = gohelper.findChild(self._rewardItems[i].go, "go_icon")
			self._rewardItems[i].item = IconMgr.instance:getCommonPropItemIcon(self._rewardItems[i].itemRoot)
			self._rewardItems[i].gocanget = gohelper.findChild(self._rewardItems[i].go, "go_canget")
			self._rewardItems[i].goreceive = gohelper.findChild(self._rewardItems[i].go, "go_receive")
			self._rewardItems[i].gorare = gohelper.findChild(self._rewardItems[i].go, "go_rare")
			self._rewardItems[i].golock = gohelper.findChild(self._rewardItems[i].go, "go_lock")
			self._rewardItems[i].gomask = gohelper.findChild(self._rewardItems[i].go, "go_mask")
			self._rewardItems[i].btnclick = gohelper.findChildButtonWithAudio(self._rewardItems[i].go, "btn_click")

			self._rewardItems[i].btnclick:AddClickListener(self._btnclickOnClick, self)
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItems[i].item:setHideLvAndBreakFlag(true)

		local canGet = true

		goto label_11_0

		::label_11_0::

		gohelper.setActive(self._rewardItems[i].btnclick.gameObject, canGet)
		gohelper.setActive(self._rewardItems[i].gocanget, canGet)
		gohelper.setActive(self._rewardItems[i].goreceive, self._taskMO and self._taskMO.finishCount >= 1)
		gohelper.setActive(self._rewardItems[i].golock, false)
		gohelper.setActive(self._rewardItems[i].gomask, not self._isUnlock)
		gohelper.setActive(self._rewardItems[i].gorare, false)
	end

	local extraRewards = string.split(self._taskConfig.showBonus, "|")

	for i = #rewards + 1, #rewards + #extraRewards do
		if not self._rewardItems[i] then
			self._rewardItems[i] = {}
			self._rewardItems[i].go = gohelper.cloneInPlace(self._gorewarditem)
			self._rewardItems[i].itemRoot = gohelper.findChild(self._rewardItems[i].go, "go_icon")
			self._rewardItems[i].item = IconMgr.instance:getCommonPropItemIcon(self._rewardItems[i].itemRoot)
			self._rewardItems[i].gocanget = gohelper.findChild(self._rewardItems[i].go, "go_canget")
			self._rewardItems[i].goreceive = gohelper.findChild(self._rewardItems[i].go, "go_receive")
			self._rewardItems[i].gorare = gohelper.findChild(self._rewardItems[i].go, "go_rare")
			self._rewardItems[i].golock = gohelper.findChild(self._rewardItems[i].go, "go_lock")
			self._rewardItems[i].gomask = gohelper.findChild(self._rewardItems[i].go, "go_mask")
			self._rewardItems[i].btnclick = gohelper.findChildButtonWithAudio(self._rewardItems[i].go, "btn_click")

			self._rewardItems[i].btnclick:AddClickListener(self._btnextraclickOnClick, self)
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local itemCo = string.splitToNumber(extraRewards[i - #rewards], "#")

		self._rewardItems[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItems[i].item:setHideLvAndBreakFlag(true)
		gohelper.setActive(self._rewardItems[i].gocanget, false)

		local ceremonyReceived = CruiseModel.instance:isCeremonyRewardReceived()

		gohelper.setActive(self._rewardItems[i].goreceive, ceremonyReceived)

		local showLock = not self._taskMO or self._taskMO.progress < self._taskConfig.maxProgress

		gohelper.setActive(self._rewardItems[i].golock, not ceremonyReceived and showLock)

		local showRare = true

		goto label_11_1

		::label_11_1::

		gohelper.setActive(self._rewardItems[i].gorare, showRare)
		gohelper.setActive(self._rewardItems[i].btnclick.gameObject, showRare)
		gohelper.setActive(self._rewardItems[i].gomask, false)
	end
end

function CruiseGlobalTaskItem:destroy()
	TaskDispatcher.cancelTask(self._onInFinished, self)

	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			v.btnclick:RemoveClickListener()
		end

		self._rewardItems = nil
	end

	self:removeEvents()
end

return CruiseGlobalTaskItem
