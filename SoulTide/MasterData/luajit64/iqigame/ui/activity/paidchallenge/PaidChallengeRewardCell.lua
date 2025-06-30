-- chunkname: @IQIGame\\UI\\Activity\\PaidChallenge\\PaidChallengeRewardCell.lua

local PaidChallengeRewardCell = {
	itemPoolLock = {},
	itemPoolReward = {},
	itemPoolGetted = {}
}

function PaidChallengeRewardCell.New(view)
	local obj = Clone(PaidChallengeRewardCell)

	obj:Init(view)

	return obj
end

function PaidChallengeRewardCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 2 do
		local goLock = self.goLock_itemRoot.transform:GetChild(i - 1).gameObject

		self.itemPoolLock[i] = ItemCell.New(goLock, true, true)

		local goReward = self.goReward_itemRoot.transform:GetChild(i - 1).gameObject

		self.itemPoolReward[i] = ItemCell.New(goReward, true, true)

		local goGetted = self.goGetted_itemRoot.transform:GetChild(i - 1).gameObject

		self.itemPoolGetted[i] = ItemCell.New(goGetted, true, true)
	end

	self.btnExt_getted = self.goGetted_BtnExt:GetComponent("Button")
	self.btnExt_reward = self.goReward_BtnExt:GetComponent("Button")
	self.btnExt_lock = self.goLock_BtnExt:GetComponent("Button")
	self.btnReward_reward = self.goReward_BtnSelf:GetComponent("Button")

	function self.onClickBtnExtDelegate_getted()
		self:OnClickBtnExt_getted()
	end

	function self.onClickBtnExtDelegate_lock()
		self:OnClickBtnExt_lock()
	end

	function self.onClickBtnExtDelegate_reward()
		self:OnClickBtnExt_reward()
	end

	function self.onClickBtnRewardDelegate_reward()
		self:OnClickBtnReward_reward()
	end
end

function PaidChallengeRewardCell:Refresh(day, taskData, taskDataExt)
	self.day = day
	self.taskData = taskData
	self.taskDataExt = taskDataExt
	self.cfgTaskData = CfgMainQuestTable[self.taskData.cid]

	if self.taskDataExt ~= nil then
		self.cfgTaskDataExt = CfgMainQuestTable[self.taskDataExt.cid]
	end

	self:RefreshState()
	self:OnAddListener()
end

function PaidChallengeRewardCell:OnHide()
	self:OnRemoveListener()
end

function PaidChallengeRewardCell:OnDestroy()
	for i, v in pairs(self.itemPoolGetted) do
		v:Dispose()
	end

	for i, v in pairs(self.itemPoolReward) do
		v:Dispose()
	end

	for i, v in pairs(self.itemPoolLock) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function PaidChallengeRewardCell:OnAddListener()
	self:OnRemoveListener()
	self.btnExt_lock.onClick:AddListener(self.onClickBtnExtDelegate_lock)
	self.btnExt_getted.onClick:AddListener(self.onClickBtnExtDelegate_getted)
	self.btnExt_reward.onClick:AddListener(self.onClickBtnExtDelegate_reward)
	self.btnReward_reward.onClick:AddListener(self.onClickBtnRewardDelegate_reward)
end

function PaidChallengeRewardCell:OnRemoveListener()
	self.btnExt_lock.onClick:RemoveListener(self.onClickBtnExtDelegate_lock)
	self.btnExt_getted.onClick:RemoveListener(self.onClickBtnExtDelegate_getted)
	self.btnExt_reward.onClick:RemoveListener(self.onClickBtnExtDelegate_reward)
	self.btnReward_reward.onClick:RemoveListener(self.onClickBtnRewardDelegate_reward)
end

function PaidChallengeRewardCell:OnClickBtnReward_reward()
	local cids = {}

	cids[#cids + 1] = self.taskData.cid

	if self.taskDataExt ~= nil then
		cids[#cids + 1] = self.taskDataExt.cid
	end

	TaskModule.SendCommitTaskMsgBatch(cids)
end

function PaidChallengeRewardCell:OnClickBtnExt_reward()
	local rewards = {}

	for i, v in ipairs(self.cfgTaskDataExt.Reward) do
		if i % 2 ~= 0 then
			rewards[#rewards + 1] = {
				id = v,
				num = self.cfgTaskDataExt.Reward[i + 1]
			}
		end
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		GetState = false,
		Rewards = rewards
	})
end

function PaidChallengeRewardCell:OnClickBtnExt_getted()
	local rewards = {}

	for i, v in ipairs(self.cfgTaskDataExt.Reward) do
		if i % 2 ~= 0 then
			rewards[#rewards + 1] = {
				id = v,
				num = self.cfgTaskDataExt.Reward[i + 1]
			}
		end
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		GetState = false,
		Rewards = rewards
	})
end

function PaidChallengeRewardCell:OnClickBtnExt_lock()
	local rewards = {}

	for i, v in ipairs(self.cfgTaskDataExt.Reward) do
		if i % 2 ~= 0 then
			rewards[#rewards + 1] = {
				id = v,
				num = self.cfgTaskDataExt.Reward[i + 1]
			}
		end
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		GetState = false,
		Rewards = rewards
	})
end

function PaidChallengeRewardCell:RefreshState()
	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum >= self.taskData.TargetNum then
		self.goRewardBlock:SetActive(true)
		self.goGettedBlock:SetActive(false)
		self.goLockBlock:SetActive(false)
		self.goReward_BtnExt:SetActive(self.taskDataExt ~= nil)

		local tfDay = self.goReward_day:GetComponent("Text")

		tfDay.text = ActivityUIApi:GetString("paidViewRewardDay", self.day)

		local count = 0

		for i, v in ipairs(self.cfgTaskData.Reward) do
			if i % 2 ~= 0 then
				count = count + 1

				self.itemPoolReward[count]:SetItemByCID(v, self.cfgTaskData.Reward[i + 1])
			end
		end
	elseif self.taskData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		self.goGettedBlock:SetActive(true)
		self.goLockBlock:SetActive(false)
		self.goRewardBlock:SetActive(false)
		self.goGetted_BtnExt:SetActive(self.taskDataExt ~= nil)

		local tfDay = self.goGetted_day:GetComponent("Text")

		tfDay.text = ActivityUIApi:GetString("paidViewRewardDay", self.day)

		local count = 0

		for i, v in ipairs(self.cfgTaskData.Reward) do
			if i % 2 ~= 0 then
				count = count + 1

				self.itemPoolGetted[count]:SetItemByCID(v, self.cfgTaskData.Reward[i + 1])
			end
		end
	else
		self.goLockBlock:SetActive(true)
		self.goRewardBlock:SetActive(false)
		self.goGettedBlock:SetActive(false)
		self.goLock_BtnExt:SetActive(self.taskDataExt ~= nil)

		local tfDay = self.goLock_day:GetComponent("Text")

		tfDay.text = ActivityUIApi:GetString("paidViewRewardDay", self.day)

		local count = 0

		for i, v in ipairs(self.cfgTaskData.Reward) do
			if i % 2 ~= 0 then
				count = count + 1

				self.itemPoolLock[count]:SetItemByCID(v, self.cfgTaskData.Reward[i + 1])
			end
		end
	end
end

return PaidChallengeRewardCell
