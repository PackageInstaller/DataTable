-- chunkname: @IQIGame\\UI\\ExploreHall\\PlotChallenge\\PlotChangePosStateCell.lua

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

	function self.delegateBtnReward()
		self:OnBtnReward()
	end

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.delegateBtnReward)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReward)
end

function m:UpdateSate(state)
	self.state = state

	self.Lock:SetActive(self.state == 0)
	self.Now:SetActive(self.state == 1)
	self.Clear:SetActive(self.state == 2)
end

function m:SetCfgData(data)
	self.cfgData = data

	UGUIUtil.SetText(self.NowTitle, self.cfgData.TitleNum)
	UGUIUtil.SetText(self.ClearTitle, self.cfgData.TitleNum)
	UGUIUtil.SetText(self.LockTitle, self.cfgData.TitleNum)

	local isShow = false

	if #self.cfgData.ChallengeNeed > 1 then
		isShow = true

		local costID = self.cfgData.ChallengeNeed[1]
		local costValue = self.cfgData.ChallengeNeed[2]
		local haveValue = WarehouseModule.GetItemNumByCfgID(costID)

		UGUIUtil.SetText(self.NowCostValue, ExploreHallUIApi:GetString("PlotChallengeCostValue", costValue, haveValue))
		UGUIUtil.SetText(self.ClearCostValue, ExploreHallUIApi:GetString("PlotChallengeCostValue", costValue, haveValue))
		UGUIUtil.SetText(self.LockCostValue, ExploreHallUIApi:GetString("PlotChallengeCostValue", costValue, haveValue))
	end

	self.NowCostIcon:SetActive(isShow)
	self.ClearCostIcon:SetActive(isShow)
	self.LockCostIcon:SetActive(isShow)
	self.NowCostValue:SetActive(isShow)
	self.ClearCostValue:SetActive(isShow)
	self.LockCostValue:SetActive(isShow)
	UGUIUtil.SetText(self.ClearTextReward, ExploreHallUIApi:GetString("PlotChallengeClearTextReward"))
	UGUIUtil.SetText(self.NowTextReward, ExploreHallUIApi:GetString("PlotChallengeNowTextReward"))

	self.rewards = {}

	local tab = self.cfgData.FirstChallengeReward

	if self.cfgData.Type == 2 and self.state == 2 then
		tab = self.cfgData.ChallengeReward
	end

	for i, v in ipairs(tab) do
		if i % 2 ~= 0 then
			self.rewards[#self.rewards + 1] = {
				id = v,
				num = tab[i + 1]
			}
		end
	end

	self.BtnReward:SetActive(#self.rewards > 0)
end

function m:OnBtnReward()
	local TitleStr = ExploreHallUIApi:GetString("PlotChallengeRewardTitle", self.state)

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		ShowBtn = false,
		Rewards = self.rewards,
		TextTitle = TitleStr
	})
end

function m:OnBtnSelf()
	PlotChallengeModule.ExecutionEvent(self.cfgData.Id, self.state)
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
