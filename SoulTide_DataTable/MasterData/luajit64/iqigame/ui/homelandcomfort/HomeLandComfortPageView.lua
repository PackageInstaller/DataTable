-- chunkname: @IQIGame\\UI\\HomeLandComfort\\HomeLandComfortPageView.lua

local HomeLandComfortPageView = {
	rewardState = 1
}

function HomeLandComfortPageView.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_HomeLandComfortPageView == nil then
		ui.__SUB_UI_MAP_HomeLandComfortPageView = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_HomeLandComfortPageView
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = HomeLandComfortPageView.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function HomeLandComfortPageView.__New(itemCellView)
	local itemCell = Clone(HomeLandComfortPageView)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandComfortPageView:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnGetRewardComponent = self.BtnRewardBox:GetComponent("Button")

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end

	self:AddListener()
end

function HomeLandComfortPageView:AddListener()
	self.btnGetRewardComponent.onClick:AddListener(self.delegateBtnGetReward)
end

function HomeLandComfortPageView:RemoveListener()
	self.btnGetRewardComponent.onClick:RemoveListener(self.delegateBtnGetReward)
end

function HomeLandComfortPageView.DisposeIn(ui)
	if ui.__SUB_UI_MAP_HomeLandComfortPageView == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_HomeLandComfortPageView) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_HomeLandComfortPageView = nil
end

function HomeLandComfortPageView:SetData(data)
	self.stateInfo = data

	if data ~= nil then
		self:Update()
	end
end

function HomeLandComfortPageView:Update()
	UGUIUtil.SetText(self.TextCurrentName, self.stateInfo.Name)
	UGUIUtil.SetText(self.TextCurrentDes1, HomeLandComfortUIApi:GetString("TextCurrentDes1", self.stateInfo.ComfortInterval))
	UGUIUtil.SetText(self.TextCurrentDes2, self.stateInfo.Describe)

	self.rewardState = HomeLandLuaModule.GetRewardState(self.stateInfo.Id)

	self.goImgOpen:SetActive(false)
	self.goImgClose:SetActive(false)
	self.goEffectParent:SetActive(false)

	if self.rewardState == 1 then
		self.goImgClose:SetActive(true)
	elseif self.rewardState == 2 then
		self.goImgClose:SetActive(true)
		self.goEffectParent:SetActive(true)
	elseif self.rewardState == 3 then
		self.goImgOpen:SetActive(true)
	end
end

function HomeLandComfortPageView:OnBtnGetReward()
	if self.rewardState ~= 2 then
		local rewards = {}
		local collectReward = self.stateInfo.Reward

		for i = 1, #collectReward, 2 do
			rewards[#rewards + 1] = {
				id = collectReward[i],
				num = collectReward[i + 1]
			}
		end

		local state = 1

		if self.rewardState == 1 then
			state = 3
		end

		UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
			Rewards = rewards,
			State = state
		})
	elseif self.rewardState == 2 then
		HomeLandLuaModule.ReceiveComfortLvAwards(self.stateInfo.Id)
	end
end

function HomeLandComfortPageView:Dispose()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	self:RemoveListener()

	self.goView = nil
end

return HomeLandComfortPageView
