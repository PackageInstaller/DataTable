-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/actflip/ActFlipTaskItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.actflip.ActFlipTaskItem", package.seeall)

local ActFlipTaskItem = class("ActFlipTaskItem", LuaCompBase)

function ActFlipTaskItem:init(go)
	self.go = go
	self._gocommon = gohelper.findChild(self.go, "go_common")
	self._gonorbg = gohelper.findChild(self._gocommon, "go_norbg")
	self._gogetbg = gohelper.findChild(self._gocommon, "go_getbg")
	self._txttaskdes = gohelper.findChildText(self._gocommon, "txt_taskdes")
	self._gotag1 = gohelper.findChild(self._gocommon, "go_tag1")
	self._gotag2 = gohelper.findChild(self._gocommon, "go_tag2")
	self._txttime = gohelper.findChildText(self._gocommon, "go_tag2/txt_time")
	self._gorewards = gohelper.findChild(self._gocommon, "go_rewards")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self._gocommon, "btn_finishbg")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self._gocommon, "btn_notfinishbg")
	self._goget = gohelper.findChild(self._gocommon, "go_get")

	self:_initItem()
	self:_addEvents()
end

function ActFlipTaskItem:_initItem()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertActFlip
	self._actMo = ActivityModel.instance:getActMO(self._actId)
	self._itemAnim = self.go:GetComponent(typeof(UnityEngine.Animator))

	self._itemAnim:Play("open", 0, 0)

	self._rewardItems = {}
end

function ActFlipTaskItem:_addEvents()
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	ActFlipController.instance:registerCallback(ActFlipEvent.GetAllTaskReward, self._onGetAllTaskShow, self)
end

function ActFlipTaskItem:_removeEvents()
	self._btnfinishbg:RemoveClickListener()
	self._btnnotfinishbg:RemoveClickListener()
	ActFlipController.instance:unregisterCallback(ActFlipEvent.GetAllTaskReward, self._onGetAllTaskShow, self)
end

function ActFlipTaskItem:_onGetAllTaskShow()
	if self._mo.finishCount > 0 then
		return
	end

	if self._mo.progress >= self._mo.config.maxProgress then
		gohelper.setActive(self._goget, true)
		self._itemAnim:Play("finish", 0, 0)
	end
end

function ActFlipTaskItem:_btnnotfinishbgOnClick()
	if self._mo then
		local jumpId = self._mo.config.jumpId

		if jumpId and jumpId > 0 then
			GameFacade.jump(jumpId)
		end
	end
end

function ActFlipTaskItem:_btnfinishbgOnClick()
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_lit)
	ActFlipController.instance:dispatchEvent(ActFlipEvent.GetAllTaskReward)
	gohelper.setActive(self._goget, true)
	self._itemAnim:Play("finish", 0, 0)
	TaskDispatcher.runDelay(self._onSendTaskFinish, self, 0.67)
end

function ActFlipTaskItem:_onSendTaskFinish()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ConcerActFlip)
end

function ActFlipTaskItem:refresh(mo)
	gohelper.setActive(self.go, true)

	self._mo = mo

	gohelper.setActive(self._gocommon, true)
	gohelper.setActive(self._goget, false)
	gohelper.setActive(self._btnnotfinishbg, false)
	gohelper.setActive(self._btnfinishbg.gameObject, false)
	gohelper.setActive(self._gotag1, self._mo.config.loopType == TaskEnum.TaskLoopType.Daily)

	local leftSec = -1
	local limitActId = self._mo.config.openLimitActId
	local actMo = ActivityModel.instance:getActMO(limitActId)

	if actMo and actMo:isOpen() and actMo.endTime < self._actMo.endTime and self._mo.finishCount <= 0 then
		leftSec = actMo.endTime / 1000 - ServerTime.now()
	end

	if leftSec > 0 then
		gohelper.setActive(self._gotag2, true)

		if leftSec > 3600 then
			local formatTime = string.format("%s%s", TimeUtil.secondToRoughTime2(leftSec))

			self._txttime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a0_actflip_tasktime_tip"), {
				formatTime
			})
		else
			self._txttime.text = luaLang("not_enough_one_hour")
		end
	else
		gohelper.setActive(self._gotag2, false)
	end

	self._txttaskdes.text = string.format("%s(%s/%s)", self._mo.config.desc, self._mo.progress, self._mo.config.maxProgress)

	gohelper.setActive(self._gonorbg, true)
	gohelper.setActive(self._gogetbg, false)

	if self._mo.finishCount > 0 then
		gohelper.setActive(self._goget, true)
	elseif self._mo.progress >= self._mo.config.maxProgress then
		gohelper.setActive(self._gonorbg, false)
		gohelper.setActive(self._gogetbg, true)
		gohelper.setActive(self._btnfinishbg.gameObject, true)
	else
		gohelper.setActive(self._btnnotfinishbg.gameObject, self._mo.config.jumpId ~= 0)
	end

	local rewards = string.split(self._mo.config.bonus, "|")

	for i = 1, #rewards do
		self._rewardItems[i] = self._rewardItems[i] or IconMgr.instance:getCommonPropItemIcon(self._gorewards)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i]:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		self._rewardItems[i]:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		self._rewardItems[i]:setCountFontSize(40)
		self._rewardItems[i]:showStackableNum2()
		self._rewardItems[i]:setHideLvAndBreakFlag(true)
		self._rewardItems[i]:hideEquipLvAndBreak(true)
	end
end

function ActFlipTaskItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function ActFlipTaskItem:destroy()
	TaskDispatcher.cancelTask(self._onSendTaskFinish, self)
	self:_removeEvents()
end

return ActFlipTaskItem
