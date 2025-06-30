-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGChallengeMain\\HorizontalRPGPosStateCell.lua

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

	function self.DelegateBtnReward()
		self:OnBtnReward()
	end

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnReward)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReward)
end

function m:UpdateSate(state)
	self.state = state

	self.Lock:SetActive(self.state == 0)
	self.Now:SetActive(self.state == 1)
	self.Clear:SetActive(self.state == 2)
end

function m:SetCfgData(data)
	self.cfgData = data

	UGUIUtil.SetText(self.NowTitle, self.cfgData.TitleName)
	UGUIUtil.SetText(self.ClearTitle, self.cfgData.TitleName)
	UGUIUtil.SetText(self.LockTitle, self.cfgData.TitleName)

	local isShow = false

	if #self.cfgData.ChallengeNeed > 1 then
		isShow = true

		local costID = self.cfgData.ChallengeNeed[1]
		local costValue = self.cfgData.ChallengeNeed[2]
		local haveValue = WarehouseModule.GetItemNumByCfgID(costID)

		UGUIUtil.SetText(self.NowCostValue, ExploreHallUIApi:GetString("HorizontalChallengeCostValue", costValue, haveValue))
		UGUIUtil.SetText(self.ClearCostValue, ExploreHallUIApi:GetString("HorizontalChallengeCostValue", costValue, haveValue))
		UGUIUtil.SetText(self.LockCostValue, ExploreHallUIApi:GetString("HorizontalChallengeCostValue", costValue, haveValue))
	end

	self.NowCostIcon:SetActive(isShow)
	self.ClearCostIcon:SetActive(isShow)
	self.LockCostIcon:SetActive(isShow)
	self.NowCostValue:SetActive(isShow)
	self.ClearCostValue:SetActive(isShow)
	self.LockCostValue:SetActive(isShow)
	UGUIUtil.SetText(self.ClearTextReward, ExploreHallUIApi:GetString("HorizontalChallengeClearTextReward"))
	UGUIUtil.SetText(self.NowTextReward, ExploreHallUIApi:GetString("HorizontalChallengeNowTextReward"))

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
	self:RefreshIcon()
end

function m:RefreshIcon()
	local lockPath = ExploreHallUIApi:GetString("HorizontalChallengeIcon", self.state, self.cfgData.Type)

	AssetUtil.LoadImage(self, lockPath, self.LockIcon:GetComponent("Image"))

	local clearPath = ExploreHallUIApi:GetString("HorizontalChallengeIcon", self.state, self.cfgData.Type)

	AssetUtil.LoadImage(self, clearPath, self.ClearIcon:GetComponent("Image"))

	local nowPath = ExploreHallUIApi:GetString("HorizontalChallengeIcon", self.state, self.cfgData.Type)

	AssetUtil.LoadImage(self, nowPath, self.NowIcon:GetComponent("Image"))
end

function m:OnBtnReward()
	local TitleStr = ExploreHallUIApi:GetString("HorizontalChallengeRewardTitle", self.state)

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		ShowBtn = false,
		Rewards = self.rewards,
		TextTitle = TitleStr
	})
end

function m:OnBtnSelf()
	self:ExecutionEvent()
end

function m:GetPlotIsOpen(nodeId)
	if HorizontalRPGModule.IsShow() then
		local finnishLevels = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.finnishLevels or {}

		if table.indexOf(finnishLevels, nodeId) ~= -1 then
			return true
		end
	end

	return false
end

function m:ExecutionEvent()
	if self.cfgData == nil then
		return
	end

	local isPass = m:GetPlotIsOpen(self.cfgData.Id)

	if isPass == false and #self.cfgData.ChallengeNeed > 1 then
		local have = WarehouseModule.GetItemNumByCfgID(self.cfgData.ChallengeNeed[1])
		local need = self.cfgData.ChallengeNeed[2]

		if have < need then
			NoticeModule.ShowNotice(21045026)

			return
		end
	end

	if self.cfgData.Type == HorizontalRPGConstant.PosStateType.Type_flight then
		UIModule.Open(Constant.UIControllerName.HorizontalRPGDramaBossFormationUI, Constant.UILayer.UI, {
			self.cfgData.Id,
			self.state
		})
	elseif self.cfgData.Type == HorizontalRPGConstant.PosStateType.Type_HorizontalMaze then
		local lastChooseFormationIndex = FormationModule.GetLastChooseFormationId()
		local formationPOD = FormationModule.GetFormationByIndex(lastChooseFormationIndex)

		if not formationPOD then
			return
		end

		local hasSoul = false

		for prefabId, prefabIndex in pairs(formationPOD.formation) do
			local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

			if soulPrefabData.soulCid ~= nil then
				hasSoul = true

				break
			end
		end

		if not hasSoul then
			NoticeModule.ShowNotice(21040093)

			return false
		end

		HorizontalRPGModule.Challenge(self.cfgData.Id, formationPOD.id)
	else
		HorizontalRPGModule.Challenge(self.cfgData.Id)
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
