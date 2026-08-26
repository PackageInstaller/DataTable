-- chunkname: @modules/logic/versionactivity3_1/bpoper/view/V3a1_BpOperActShowTaskItem.lua

module("modules.logic.versionactivity3_1.bpoper.view.V3a1_BpOperActShowTaskItem", package.seeall)

local V3a1_BpOperActShowTaskItem = class("V3a1_BpOperActShowTaskItem", LuaCompBase)

function V3a1_BpOperActShowTaskItem:init(go, taskCo, index)
	self.go = go
	self._config = taskCo
	self._index = index
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._txttaskdes = gohelper.findChildText(go, "#txt_taskdes")
	self._txttotal = gohelper.findChildText(go, "#txt_taskdes/#txt_total")
	self._gobonus = gohelper.findChild(go, "#go_bonus")
	self._goitem = gohelper.findChild(go, "#go_bonus/go_item")
	self._gonotget = gohelper.findChild(go, "#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(go, "#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(go, "#go_notget/#btn_finishbg")
	self._goallfinish = gohelper.findChild(go, "#go_notget/#go_allfinish")
	self._goicon = gohelper.findChild(go, "#go_notget/#go_allfinish/icon")
	self._goicon2 = gohelper.findChild(go, "#go_notget/#go_allfinish/icon2")
	self._goprogress = gohelper.findChild(go, "#go_notget/#btn_progress")

	gohelper.setActive(self.go, false)
	self:addEvents()
end

function V3a1_BpOperActShowTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	V3a1_BpOperActController.instance:registerCallback(BpOperActEvent.onStartGetAll, self._onStartGetAll, self)
end

function V3a1_BpOperActShowTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	V3a1_BpOperActController.instance:unregisterCallback(BpOperActEvent.onStartGetAll, self._onStartGetAll, self)
end

function V3a1_BpOperActShowTaskItem:_onStartGetAll()
	local isLvMax = BpModel.instance:isMaxLevel()

	if not isLvMax then
		if self._taskMO.hasFinished then
			local showFinish = self._taskMO.finishCount == 0

			if not showFinish then
				return
			end

			self._anim:Play("get", 0, 0)
		end
	end
end

function V3a1_BpOperActShowTaskItem:show(show, withAnim)
	if show and withAnim then
		gohelper.setActive(self.go, false)
		TaskDispatcher.runDelay(self._playOpen, self, 0.03 * self._index)

		return
	end

	gohelper.setActive(self.go, show)
end

function V3a1_BpOperActShowTaskItem:_playOpen()
	gohelper.setActive(self.go, true)
	self._anim:Play("open", 0, 0)
end

function V3a1_BpOperActShowTaskItem:_btnnotfinishbgOnClick()
	if self._config.jumpId > 0 then
		GameFacade.jump(self._config.jumpId)
	end
end

function V3a1_BpOperActShowTaskItem:_btnfinishbgOnClick()
	V3a1_BpOperActController.instance:dispatchEvent(BpOperActEvent.onStartGetAll)
	self._anim:Play("get", 0, 0)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function V3a1_BpOperActShowTaskItem:_delayFinish()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.BpOperAct)
end

function V3a1_BpOperActShowTaskItem:refresh()
	self._taskMO = TaskModel.instance:getTaskById(self._config.id)
	self._txttaskdes.text = self._config.desc
	self._txttotal.text = string.format("%s/%s", self._taskMO.progress, self._config.maxProgress)

	gohelper.setActive(self._gonotget, true)

	local isLvMax = BpModel.instance:isMaxLevel()
	local showProgress = not isLvMax and not self._taskMO.hasFinished and self._taskMO.progress < self._config.maxProgress and self._config.jumpId == 0
	local showNotFinish = not isLvMax and not self._taskMO.hasFinished and self._taskMO.progress < self._config.maxProgress and self._config.jumpId > 0

	if not isLvMax then
		if self._taskMO.hasFinished then
			local showFinish = self._taskMO.finishCount == 0
			local showAllFinish = self._taskMO.finishCount > 0 or isLvMax

			gohelper.setActive(self._goprogress, showProgress)
			gohelper.setActive(self._btnnotfinishbg.gameObject, showNotFinish)
			gohelper.setActive(self._btnfinishbg.gameObject, showFinish)
			gohelper.setActive(self._goallfinish, showAllFinish)

			local showIcon = self._taskMO.finishCount > 0
			local showIcon2 = isLvMax and self._taskMO.finishCount == 0

			gohelper.setActive(self._goicon, showIcon)
			gohelper.setActive(self._goicon2, showIcon2)

			self._rewardItem = self._rewardItem or IconMgr.instance:getCommonPropItemIcon(self._goitem)

			self._rewardItem:setMOValue(1, BpEnum.ScoreItemId, self._config.bonusScore, nil, true)
			self._rewardItem:setCountFontSize(36)
			self._rewardItem:setScale(0.54)
			self._rewardItem:SetCountLocalY(42)
			self._rewardItem:SetCountBgHeight(22)
			self._rewardItem:showStackableNum2()
			self._rewardItem:setHideLvAndBreakFlag(true)
			self._rewardItem:hideEquipLvAndBreak(true)
		end
	end
end

function V3a1_BpOperActShowTaskItem:destroy()
	TaskDispatcher.cancelTask(self._playOpen, self)
	TaskDispatcher.cancelTask(self._delayFinish, self)
	self:removeEvents()
end

return V3a1_BpOperActShowTaskItem
