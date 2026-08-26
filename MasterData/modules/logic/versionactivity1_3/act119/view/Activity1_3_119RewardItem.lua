-- chunkname: @modules/logic/versionactivity1_3/act119/view/Activity1_3_119RewardItem.lua

module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119RewardItem", package.seeall)

local Activity1_3_119RewardItem = class("Activity1_3_119RewardItem")

function Activity1_3_119RewardItem:init(go)
	self.go = go
	self.taskId = nil
	self.bonusCount = 0
	self.bonusItems = {}

	self:onInitView()
	self:addEvents()
end

function Activity1_3_119RewardItem:onInitView()
	self._rewards = {}

	for i = 1, 3 do
		self._rewards[i] = {}
		self._rewards[i]._goreward = gohelper.findChild(self.go, "Reward" .. i)
		self._rewards[i]._bg = gohelper.findChild(self._rewards[i]._goreward, "image_RewardBG")
		self._rewards[i]._itemposContent = gohelper.findChild(self._rewards[i]._goreward, "#go_Item")
		self._rewards[i]._state = gohelper.findChild(self._rewards[i]._goreward, "State")
		self._rewards[i]._lockbg = gohelper.findChild(self._rewards[i]._goreward, "lockbg")

		for j = 1, 3 do
			self._rewards[i]["_itempos" .. j] = gohelper.findChild(self._rewards[i]._itemposContent, "ItemPos" .. j)
		end

		self._rewards[i]._goclaimed = gohelper.findChild(self._rewards[i]._state, "#go_Claimed")
		self._rewards[i]._goclaim = gohelper.findChild(self._rewards[i]._state, "#go_Claim")
		self._rewards[i]._golocked = gohelper.findChild(self._rewards[i]._state, "#go_Locked")
		self._rewards[i]._btnclaim = gohelper.findChildButtonWithAudio(self._rewards[i]._state, "#go_Claim")
		self._rewards[i]._canvasGroup = gohelper.onceAddComponent(self._rewards[i]._itemposContent, typeof(UnityEngine.CanvasGroup))

		gohelper.setActive(self._rewards[i]._goreward, false)
	end
end

function Activity1_3_119RewardItem:addEvents()
	for i = 1, 3 do
		self._rewards[i]._btnclaim:AddClickListener(self.onTaskFinish, self)
	end
end

function Activity1_3_119RewardItem:removeEvents()
	for i = 1, 3 do
		self._rewards[i]._btnclaim:RemoveClickListener()
	end
end

function Activity1_3_119RewardItem:setBonus(bonusStr, taskId, isUnLock)
	self.taskId = taskId

	local bonus = GameUtil.splitString2(bonusStr, true)
	local bonusLen = #bonus

	if self.bonusCount ~= bonusLen then
		if self.bonusCount > 0 then
			gohelper.setActive(self._rewards[self.bonusCount]._goreward, false)
		end

		gohelper.setActive(self._rewards[bonusLen]._goreward, true)

		for i = bonusLen + 1, self.bonusCount do
			gohelper.setActive(self.bonusItems[i].go, false)
		end

		for i = 1, bonusLen do
			if not self.bonusItems[i] then
				self.bonusItems[i] = IconMgr.instance:getCommonPropItemIcon(self._rewards[bonusLen]["_itempos" .. i])
			else
				gohelper.setActive(self.bonusItems[i].go, true)
				self.bonusItems[i].go.transform:SetParent(self._rewards[bonusLen]["_itempos" .. i].transform, false)
			end
		end

		self.bonusCount = bonusLen
	end

	local reward = self._rewards[self.bonusCount]

	gohelper.setActive(reward._bg, true)
	gohelper.setActive(reward._itemposContent, true)
	gohelper.setActive(reward._state, true)
	gohelper.setActive(reward._lockbg, not true)

	if true then
		for i = 1, bonusLen do
			local info = bonus[i]

			self.bonusItems[i]:setMOValue(info[1], info[2], info[3], nil, true)
			self.bonusItems[i]:setCountFontSize(48)
			self.bonusItems[i]:SetCountBgHeight(32)
		end
	end
end

function Activity1_3_119RewardItem:updateTaskStatus(status)
	local reward = self._rewards[self.bonusCount]

	gohelper.setActive(reward._goclaimed, status == Activity119Enum.TaskStatus.GotReward)
	gohelper.setActive(reward._goclaim, status == Activity119Enum.TaskStatus.Finished)
	gohelper.setActive(reward._golocked, status == Activity119Enum.TaskStatus.Unfinished)

	reward._canvasGroup.alpha = status == Activity119Enum.TaskStatus.GotReward and 0.7 or 1

	for i = 1, #self.bonusItems do
		self.bonusItems[i]:setAlpha(status == Activity119Enum.TaskStatus.GotReward and 0.5 or 1)
	end
end

function Activity1_3_119RewardItem:onTaskFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	TaskRpc.instance:sendFinishTaskRequest(self.taskId)
end

function Activity1_3_119RewardItem:dispose()
	self:removeEvents()

	self.go = nil
	self.bonusCount = 0

	for i = 1, #self.bonusItems do
		self.bonusItems[i]:onDestroy()
	end

	self.bonusItems = nil

	for i = 1, 3 do
		for k, v in pairs(self._rewards[i]) do
			self._rewards[i][k] = nil
		end
	end

	self._rewards = nil
	self.taskId = nil
end

return Activity1_3_119RewardItem
