-- chunkname: @modules/logic/turnback/view/TurnbackTaskItem.lua

module("modules.logic.turnback.view.TurnbackTaskItem", package.seeall)

local TurnbackTaskItem = class("TurnbackTaskItem", ListScrollCell)

function TurnbackTaskItem:init(go)
	self.go = go
	self._gocommon = gohelper.findChild(go, "#go_common")
	self._goline = gohelper.findChild(go, "#go_common/#go_line")
	self._simagebg = gohelper.findChildSingleImage(go, "#go_common/#simage_bg")
	self._txttaskdes = gohelper.findChildText(go, "#go_common/info/#txt_taskdes")
	self._txtprocess = gohelper.findChildText(go, "#go_common/info/#txt_process")
	self._scrollreward = gohelper.findChild(go, "#go_common/#scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gorewardContent = gohelper.findChild(go, "#go_common/#scroll_reward/Viewport/#go_rewardContent")
	self._gonotget = gohelper.findChild(go, "#go_common/#go_notget")
	self._btngoto = gohelper.findChildButtonWithAudio(go, "#go_common/#go_notget/#btn_goto")
	self._btncanget = gohelper.findChildButtonWithAudio(go, "#go_common/#go_notget/#btn_canget")
	self._godoing = gohelper.findChild(go, "#go_common/#go_notget/#go_doing")
	self._goget = gohelper.findChild(go, "#go_common/#go_get")
	self._goreddot = gohelper.findChild(go, "#go_common/#go_reddot")
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._rewardTab = {}
end

function TurnbackTaskItem:addEventListeners()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
end

function TurnbackTaskItem:removeEventListeners()
	self._btngoto:RemoveClickListener()
	self._btncanget:RemoveClickListener()
end

function TurnbackTaskItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo
	self._scrollreward.parentGameObject = self._view._csListScroll.gameObject

	local formatStr = self.mo.progress < self.mo.config.maxProgress and "<color=#d97373>%s/%s</color>" or "%s/%s"

	self._txttaskdes.text = self.mo.config.desc
	self._txtprocess.text = string.format(formatStr, self.mo.progress, self.mo.config.maxProgress)

	gohelper.setActive(self._goline, self._index ~= 1)

	local curPro = self.mo.progress
	local maxPro = self.mo.config.maxProgress

	gohelper.setActive(self._btngoto.gameObject, curPro < maxPro and self.mo.config.jumpId > 0)
	gohelper.setActive(self._godoing.gameObject, curPro < maxPro and self.mo.config.jumpId == 0)
	gohelper.setActive(self._btncanget.gameObject, maxPro <= curPro and self.mo.finishCount == 0)
	gohelper.setActive(self._goreddot, false)
	gohelper.setActive(self._goget, self.mo.finishCount > 0)

	local rewards = string.split(self.mo.config.bonus, "|")

	for i = 1, #rewards do
		local item = self._rewardTab[i]

		if not item then
			item = IconMgr.instance:getCommonPropItemIcon(self._gorewardContent)

			table.insert(self._rewardTab, item)
		end

		local itemCo = string.split(rewards[i], "#")

		item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		item:setPropItemScale(0.6)
		item:setHideLvAndBreakFlag(true)
		item:hideEquipLvAndBreak(true)
		item:setCountFontSize(51)
		gohelper.setActive(item.go, true)
	end

	for i = #rewards + 1, #self._rewardTab do
		gohelper.setActive(self._rewardTab[i].go, false)
	end

	self._scrollreward.horizontalNormalizedPosition = 0

	self._animator:Play(UIAnimationName.Idle, 0, 0)
end

function TurnbackTaskItem:_btngotoOnClick()
	local jumpId = self.mo.config.jumpId

	if jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function TurnbackTaskItem:_btncangetOnClick()
	if not TurnbackModel.instance:isInOpenTime() then
		return
	end

	UIBlockMgr.instance:startBlock("TurnbackTaskItemFinish")
	TaskDispatcher.runDelay(self.finishTask, self, TurnbackEnum.TaskMaskTime)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTaskRewardGetFinish, self._index)
	self._animator:Play(UIAnimationName.Finish, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function TurnbackTaskItem:finishTask()
	TaskDispatcher.cancelTask(self.finishTask, self)
	UIBlockMgr.instance:endBlock("TurnbackTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(self.mo.id)
end

function TurnbackTaskItem:onDestroy()
	TaskDispatcher.cancelTask(self.finishTask, self)
end

return TurnbackTaskItem
