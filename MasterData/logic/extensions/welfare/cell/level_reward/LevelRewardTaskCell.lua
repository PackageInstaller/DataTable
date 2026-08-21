-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/level_reward/LevelRewardTaskCell.lua

module("logic.extensions.welfare.cell.level_reward.LevelRewardTaskCell", package.seeall)

local M = class("LevelRewardTaskCell", SimpleCellComponent)
local FinishedAlpha = 0.3

function M:ctor(container)
	self.super.ctor(self, container)

	self._taskMO = nil
	self._itemList = {}
end

function M:buildUI()
	self._goStateDone = goutil.findChild(self._go, "stateDone")
	self._goNormal = goutil.findChild(self._go, "normal")
	self._canvasGroupNormal = self._goNormal:GetComponent(ComponentType.CanvasGroup)
	self._goStateNone = goutil.findChild(self._goNormal, "stateNo")
	self._btnReceive = UIComponentType.ButtonAdapter(goutil.findChild(self._goNormal, "btnReceive"))
	self._goReceive = self._btnReceive.gameObject
	self._textDesc = goutil.findChildTextComponent(self._goNormal, "Text1")
	self._goItem = goutil.findChild(self._goNormal, "rewardGroup/backpack_item")
	self._transfParent = self._goItem.transform.parent

	goutil.setActive(self._goItem, false)
end

function M:bindEvents()
	self._btnReceive:AddClickListener(self._onClickReceive, self)
end

function M:unbindEvents()
	self._btnReceive:RemoveClickListener()
end

function M:destroyUI()
	self._taskMO = nil
	self._itemList = nil
end

function M:_setData(taskMo)
	self._taskMO = taskMo
end

function M:_refreshUI()
	self._textDesc.text = self._taskMO:getDesc()

	local taskStatus = self._taskMO:getRewardStatus()
	local isFinished = taskStatus == TaskEnum.TaskState.Finish

	goutil.setActive(self._goStateNone, taskStatus == TaskEnum.TaskState.Doing)
	goutil.setActive(self._goReceive, taskStatus == TaskEnum.TaskState.CanReceive)
	goutil.setActive(self._goStateDone, isFinished)

	self._canvasGroupNormal.alpha = isFinished and FinishedAlpha or 1

	for _, item in ipairs(self._itemList) do
		goutil.setActive(item, false)
	end

	local rewardList = self._taskMO:getRewardList()

	for index, reward in ipairs(rewardList) do
		local item = self._itemList[index]

		if item == nil then
			item = goutil.cloneAndSetParent(self._goItem, self._transfParent)
			self._itemList[index] = item
		end

		goutil.setActive(item, true)

		local cell = Astral.SimpleLuaComponentContainer.Add(item, ItemCell)
		local itemData = ItemUtil.createItemData({
			itemId = reward.itemId,
			count = reward.num
		})

		cell:updateData(itemData)
		cell:setShowSelectedEffect(false)
	end
end

function M:_onClickReceive()
	local txtBtn = goutil.findChildTextComponent(self._goReceive, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	local taskId = self._taskMO:getId()

	TaskAgent.instance:sendRewardRequest({
		taskId
	})
end

return M
