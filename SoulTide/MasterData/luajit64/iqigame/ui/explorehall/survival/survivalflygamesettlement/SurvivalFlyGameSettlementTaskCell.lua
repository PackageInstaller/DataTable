-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalFlyGameSettlement\\SurvivalFlyGameSettlementTaskCell.lua

local m = {
	rewards = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnRewardBox()
		self:OnBtnRewardBox()
	end

	self:AddListener()
end

function m:AddListener()
	self.RewardBox:GetComponent("Button").onClick:AddListener(self.DelegateBtnRewardBox)
end

function m:RemoveListener()
	self.RewardBox:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRewardBox)
end

function m:SetData(taskStr, isOpen, rewards)
	self.rewards = {}

	for i = 1, #rewards, 2 do
		local id = rewards[i]
		local num = rewards[i + 1]

		table.insert(self.rewards, {
			id = id,
			num = num
		})
	end

	self.UnComplete:SetActive(not isOpen)
	self.Complete:SetActive(isOpen)
	self.ImgUnComplete:SetActive(not isOpen)
	self.ImgComplete:SetActive(isOpen)
	UGUIUtil.SetText(self.TextUnComplete, taskStr)
	UGUIUtil.SetText(self.TextComplete, taskStr)
end

function m:OnBtnRewardBox()
	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		ShowBtn = false,
		State = 1,
		Rewards = self.rewards
	})
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
