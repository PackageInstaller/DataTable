-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivitySkill\\FishingActivityAttrView.lua

local m = {
	CanUpgradePlayerLv = false,
	SkillDataList = {},
	SkillCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FishingActivitySkillCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivitySkill.FishingActivitySkillCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnLevelUp()
		self:OnBtnLevelUp()
	end

	function self.DelegateOnToggleChanged(isOn)
		self:OnToggleChanged(isOn)
	end

	self.SkillMould:SetActive(false)

	self.SkillCellPool = UIObjectPool.New(10, function()
		local skillCell = FishingActivitySkillCell.New(UnityEngine.Object.Instantiate(self.SkillMould))

		return skillCell
	end, function(cell)
		cell:Dispose()
	end)
end

function m:AddListener()
	self.BtnLevelUp:GetComponent("Button").onClick:AddListener(self.DelegateBtnLevelUp)
	self.ToggleAutoFishing:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleChanged)
end

function m:RemoveListener()
	self.BtnLevelUp:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnLevelUp)
	self.ToggleAutoFishing:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleChanged)
end

function m:UpdateView()
	local isUnlock = FishingActivityModule.IsUnlockAutoAttack()

	self.Lock:SetActive(not isUnlock)
	self.Unlock:SetActive(isUnlock)

	self.ToggleAutoFishing:GetComponent("Toggle").interactable = false
	self.ToggleAutoFishing:GetComponent("Toggle").isOn = true

	if not isUnlock then
		-- block empty
	end

	local cfgFishActiveControlData = CfgFishActiveControlTable[FishingActivityModule.globalCid]
	local isMaxLv = FishingActivityModule.GetPlayerCfgLevelData().Level >= cfgFishActiveControlData.MaxLevel

	self.BtnLevelUp:SetActive(not isMaxLv)

	self.CanUpgradePlayerLv = not isMaxLv

	self.LevelUpNode:SetActive(not isMaxLv)
	self.LevelMaxNode:SetActive(isMaxLv)

	if not isMaxLv then
		local costID = FishingActivityModule.GetPlayerCfgLevelData().Cost[1]

		if costID > 0 then
			local iconPath = ExploreHallUIApi:GetString("FishingActivityMoneyIcon", costID)

			AssetUtil.LoadImage(self, iconPath, self.ImgCost:GetComponent("Image"))

			local haveNum = WarehouseModule.GetItemNumByCfgID(costID)
			local costNum = FishingActivityModule.GetPlayerCfgLevelData().Cost[2]

			if self.CanUpgradePlayerLv then
				self.CanUpgradePlayerLv = costNum <= haveNum
			end

			UGUIUtil.SetText(self.TextSpend, FishingActivitySkillUIApi:GetString("TextSpend", costNum, costNum <= haveNum))
		end
	end

	UGUIUtil.SetText(self.TextLv, FishingActivityModule.dailyDupPOD.fishingActivityPOD.roleLevel)
	UGUIUtil.SetText(self.TextArmStrength, FishingActivitySkillUIApi:GetString("ArmStrength", FishingActivityModule.GetPlayerCfgLevelData().Power))
	UGUIUtil.SetText(self.TextAttackSpeed, FishingActivityModule.GetPlayerCfgLevelData().AttackInterval / 1000)

	local num, totalNum = FishingActivityModule.GetFishIllustratedNum()

	UGUIUtil.SetText(self.TextFishTypes, num)

	self.SkillDataList = FishingActivityModule.fishSkillDataList

	table.sort(self.SkillDataList, function(a, b)
		return a.cid < b.cid
	end)

	for i, v in pairs(self.SkillCells) do
		self.SkillCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.SkillCells = {}

	for i = 1, #self.SkillDataList do
		local skillData = self.SkillDataList[i]
		local skillCell = self.SkillCellPool:Obtain()

		skillCell.View:SetActive(true)
		skillCell.View.transform:SetParent(self.SkillNode.transform, false)
		skillCell:SetData(skillData)
		table.insert(self.SkillCells, skillCell)
	end
end

function m:OnToggleChanged(isOn)
	FishingActivityModule.isOpenAutoAttack = isOn
end

function m:OnBtnLevelUp()
	if not self.CanUpgradePlayerLv then
		NoticeModule.ShowNoticeNoCallback(21041013)

		return
	end

	FishingActivityModule.UpRole()
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()

	for i, v in pairs(self.SkillCells) do
		self.SkillCellPool:Release(v)
	end

	self.SkillCells = {}

	self.SkillCellPool:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
