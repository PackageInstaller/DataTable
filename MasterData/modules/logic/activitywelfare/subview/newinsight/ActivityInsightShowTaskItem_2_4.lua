-- chunkname: @modules/logic/activitywelfare/subview/newinsight/ActivityInsightShowTaskItem_2_4.lua

module("modules.logic.activitywelfare.subview.newinsight.ActivityInsightShowTaskItem_2_4", package.seeall)

local ActivityInsightShowTaskItem_2_4 = class("ActivityInsightShowTaskItem_2_4", LuaCompBase)

function ActivityInsightShowTaskItem_2_4:init(go, index)
	self.go = go
	self._index = index
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._goinfo = gohelper.findChild(go, "root/info")
	self._txttaskdes = gohelper.findChildText(go, "root/info/txt_taskdes")
	self._txtprocess = gohelper.findChildText(go, "root/info/txt_process")
	self._gorewards = gohelper.findChild(go, "root/scroll_reward/Viewport/go_rewardContent")
	self._gonotget = gohelper.findChild(go, "root/go_notget")
	self._btngoto = gohelper.findChildButtonWithAudio(go, "root/go_notget/btn_goto")
	self._btncanget = gohelper.findChildButtonWithAudio(go, "root/go_notget/btn_canget")
	self._btnuse = gohelper.findChildButtonWithAudio(go, "root/go_notget/btn_use")
	self._goget = gohelper.findChild(go, "root/go_get")

	gohelper.setActive(self.go, false)

	self._rewardItems = {}

	self:addEvents()
end

function ActivityInsightShowTaskItem_2_4:addEvents()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
end

function ActivityInsightShowTaskItem_2_4:removeEvents()
	self._btngoto:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btnuse:RemoveClickListener()
end

function ActivityInsightShowTaskItem_2_4:_btngotoOnClick()
	if self._config.jumpId > 0 then
		GameFacade.jump(self._config.jumpId)
	end
end

function ActivityInsightShowTaskItem_2_4:_btncangetOnClick()
	TaskRpc.instance:sendFinishTaskRequest(self._config.id)
end

function ActivityInsightShowTaskItem_2_4:_btnuseOnClick()
	local data = {}

	data.id = self._config.itemId
	data.uid = ItemInsightModel.instance:getEarliestExpireInsight(data.id).uid

	GiftController.instance:openGiftInsightHeroChoiceView(data)
end

function ActivityInsightShowTaskItem_2_4:setTask(taskId)
	self._taskId = taskId

	self:refresh()
end

function ActivityInsightShowTaskItem_2_4:refresh()
	self._taskMO = TaskModel.instance:getTaskById(self._taskId)

	gohelper.setActive(self._goclick, false)
	gohelper.setActive(self.go, true)

	self._config = Activity172Config.instance:getAct172TaskById(self._taskId)
	self._txttaskdes.text = self._config.desc
	self._txtprocess.text = string.format("%s/%s", self._taskMO.progress, self._config.maxProgress)

	self:_refreshTaskRewards()
	self:_refreshBtns()
end

function ActivityInsightShowTaskItem_2_4:_refreshBtns()
	gohelper.setActive(self._goget, false)
	gohelper.setActive(self._gonotget, false)
	gohelper.setActive(self._btnuse.gameObject, false)
	gohelper.setActive(self._btncanget.gameObject, false)
	gohelper.setActive(self._btngoto.gameObject, false)

	if self._taskMO.finishCount >= 1 then
		local activityId = ActivityEnum.Activity.V2a4_NewInsight
		local hasUse = ActivityType172Model.instance:isTaskHasUsed(activityId, self._taskId)

		if not hasUse and self._config.itemId ~= 0 then
			gohelper.setActive(self._gonotget, true)
			gohelper.setActive(self._btnuse.gameObject, true)
		else
			gohelper.setActive(self._goget, true)
		end
	elseif self._taskMO.hasFinished then
		gohelper.setActive(self._gonotget, true)
		gohelper.setActive(self._btncanget.gameObject, true)
	else
		gohelper.setActive(self._gonotget, true)
		gohelper.setActive(self._btngoto.gameObject, true)
	end
end

function ActivityInsightShowTaskItem_2_4:_refreshTaskRewards()
	for _, v in pairs(self._rewardItems) do
		gohelper.setActive(v.go, false)
	end

	local rewards = string.split(self._config.bonus, "|")

	for i = 1, #rewards do
		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i] = self._rewardItems[i] or IconMgr.instance:getCommonPropItemIcon(self._gorewards)

		gohelper.setActive(self._rewardItems[i].go, true)
		self._rewardItems[i]:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItems[i]:setScale(0.7)
		self._rewardItems[i]:setCountFontSize(46)
		self._rewardItems[i]:setHideLvAndBreakFlag(true)
	end
end

function ActivityInsightShowTaskItem_2_4:destroy()
	self:removeEvents()
end

return ActivityInsightShowTaskItem_2_4
