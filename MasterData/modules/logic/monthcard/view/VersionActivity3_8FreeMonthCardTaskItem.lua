-- chunkname: @modules/logic/monthcard/view/VersionActivity3_8FreeMonthCardTaskItem.lua

module("modules.logic.monthcard.view.VersionActivity3_8FreeMonthCardTaskItem", package.seeall)

local VersionActivity3_8FreeMonthCardTaskItem = class("VersionActivity3_8FreeMonthCardTaskItem", LuaCompBase)

function VersionActivity3_8FreeMonthCardTaskItem:init(go)
	self.go = go
	self._root = gohelper.findChild(self.go, "root")
	self._bg = gohelper.findChild(self.go, "root/bg")
	self._progress = gohelper.findChild(self.go, "root/progress")
	self._txttaskdes = gohelper.findChildText(self.go, "root/txt_taskdes")
	self._txtnum = gohelper.findChildText(self.go, "root/progress/txt_num")
	self._txttotal = gohelper.findChildText(self.go, "root/progress/txt_num/txt_total")
	self._gorewards = gohelper.findChild(self.go, "root/scroll_rewards/Viewport/go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.go, "root/btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.go, "root/btn_finishbg")
	self._goAllfinish = gohelper.findChild(self.go, "root/go_allfinish")

	self:_initItem()
	self:_addEvents()
end

function VersionActivity3_8FreeMonthCardTaskItem:_initItem()
	self._rewardItems = self:getUserDataTb_()
	self._anim = self.go:GetComponent(gohelper.Type_Animator)
end

function VersionActivity3_8FreeMonthCardTaskItem:_addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function VersionActivity3_8FreeMonthCardTaskItem:_removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

function VersionActivity3_8FreeMonthCardTaskItem:_btnnotfinishbgOnClick()
	GameFacade.jump(self._taskCo.jumpId)
end

function VersionActivity3_8FreeMonthCardTaskItem:_btnfinishbgOnClick()
	TaskRpc.instance:sendFinishTaskRequest(self._taskCo.id)
end

function VersionActivity3_8FreeMonthCardTaskItem:refresh(taskId)
	self._taskId = taskId
	self._taskCo = Activity240Config.instance:getActivity240TaskCo(self._taskId)
	self._taskMo = TaskModel.instance:getTaskById(self._taskId)

	gohelper.setActive(self.go, true)
	self:_refreshUI()
	self:_refreshRewards()
end

function VersionActivity3_8FreeMonthCardTaskItem:_refreshUI()
	self._txttaskdes.text = self._taskCo.desc
	self._txtnum.text = self._taskMo.progress
	self._txttotal.text = self._taskCo.maxProgress

	if self._taskMo.finishCount >= self._taskCo.maxProgress then
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._goAllfinish, true)
	elseif self._taskMo.hasFinished then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._goAllfinish, false)
	else
		gohelper.setActive(self._btnnotfinishbg, true)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._goAllfinish, false)
	end
end

function VersionActivity3_8FreeMonthCardTaskItem:_refreshRewards()
	local bonus = self._taskCo.bonus
	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	for i, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]

		if not self._rewardItems[i] then
			local rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gorewards)

			table.insert(self._rewardItems, rewardItem)
		end

		self._rewardItems[i]:setMOValue(type, id, quantity, nil, true)
		self._rewardItems[i]:setCountFontSize(46)
		self._rewardItems[i]:showStackableNum2()
		self._rewardItems[i]:isShowEffect(true)
		gohelper.setActive(self._rewardItems[i].go, true)
	end

	for i = #rewardList + 1, #self._rewardItems do
		gohelper.setActive(self._rewardItems[i].go, false)
	end
end

function VersionActivity3_8FreeMonthCardTaskItem:destroy()
	self:_removeEvents()
end

return VersionActivity3_8FreeMonthCardTaskItem
