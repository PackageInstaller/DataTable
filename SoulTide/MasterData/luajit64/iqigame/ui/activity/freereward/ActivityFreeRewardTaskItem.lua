-- chunkname: @IQIGame\\UI\\Activity\\FreeReward\\ActivityFreeRewardTaskItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickUnfinishedBtn()
		self:OnClickUnfinishedBtn()
	end

	function self.DelegateOnClickFinishedBtn()
		self:OnClickFinishedBtn()
	end

	self.RewardItemCell = ItemCell.New(self.CommonSlotUI, true, true, true)

	UGUIUtil.SetTextInChildren(self.FinishedBtn, ActivityUIApi:GetString("FreeReward_TaskItem_FinishedBtnText"))
	self:AddListeners()
end

function m:AddListeners()
	self.UnfinishedBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnfinishedBtn)
	self.FinishedBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFinishedBtn)
end

function m:RemoveListeners()
	self.UnfinishedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnfinishedBtn)
	self.FinishedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFinishedBtn)
end

function m:SetData(questRewardCid)
	self.CfgTreasureQuestRewardsData = CfgTreasureQuestRewardsTable[questRewardCid]

	self.RewardItemCell:SetItemByCID(self.CfgTreasureQuestRewardsData.Reward[1], self.CfgTreasureQuestRewardsData.Reward[2])

	local hasItemNum = WarehouseModule.GetItemNumByCfgID(self.CfgTreasureQuestRewardsData.NumRequired[1])
	local needItemNum = self.CfgTreasureQuestRewardsData.NumRequired[2]

	UGUIUtil.SetText(self.TargetText, self.CfgTreasureQuestRewardsData.Name)
	UGUIUtil.SetText(self.ProgressText, ActivityUIApi:GetString("FreeReward_TaskItem_ProgressText", hasItemNum, needItemNum))
	self.UnfinishedBtn:SetActive(hasItemNum < needItemNum)
	self.FinishedBtn:SetActive(needItemNum <= hasItemNum)
	self.ProgressBar:SetActive(hasItemNum < needItemNum)
	self.MaxProgressImage:SetActive(needItemNum <= hasItemNum)

	if hasItemNum < needItemNum then
		self.ProgressBar:GetComponent("Image").fillAmount = hasItemNum / needItemNum
	end
end

function m:OnClickUnfinishedBtn()
	UIModule.Open(Constant.UIControllerName.TreasureQuestMissionUI, Constant.UILayer.UI, {
		cfgData = self.CfgTreasureQuestRewardsData
	})
end

function m:OnClickFinishedBtn()
	JumpModule.Jump(self.CfgTreasureQuestRewardsData.FunctionId)
end

function m:Dispose()
	self:RemoveListeners()
	self.RewardItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgTreasureQuestRewardsData = nil
end

return m
