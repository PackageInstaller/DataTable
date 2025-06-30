-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivitySkill\\FishingActivitySkillCell.lua

local m = {
	CanUpgradeSkillLv = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnUpgradeSkill()
		self:OnBtnUpgradeSkill()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnUpgradeSkill:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpgradeSkill)
end

function m:RemoveListener()
	self.BtnUpgradeSkill:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpgradeSkill)
end

function m:SetData(data)
	self.FishSkillData = data

	self.BtnUpgradeSkill:SetActive(not self.FishSkillData:isMaxLv())
	self.TextMax:SetActive(self.FishSkillData:isMaxLv())
	self.LevelUpNode:SetActive(not self.FishSkillData:isMaxLv())
	self.LevelMaxNode:SetActive(self.FishSkillData:isMaxLv())

	local path = UIGlobalApi.GetImagePath(self.FishSkillData:GetCfgData().Icon)

	AssetUtil.LoadImage(self, path, self.SkillIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextSkillName, self.FishSkillData:GetCfgData().SkillName)
	UGUIUtil.SetText(self.TextSkillLv, FishingActivitySkillUIApi:GetString("TextSkillLv", self.FishSkillData.lv))
	UGUIUtil.SetText(self.TextInfo, self.FishSkillData:GetCfgLvData().SkillDesc)
	UGUIUtil.SetText(self.TextDes, self.FishSkillData:GetCfgLvData().SkillUpDesc)

	local needID = self.FishSkillData:GetCfgLvData().Cost[1]
	local costNum = self.FishSkillData:GetCfgLvData().Cost[2] or 0
	local haveNum = 0

	self.CanUpgradeSkillLv = true

	if needID then
		haveNum = WarehouseModule.GetItemNumByCfgID(needID)

		local iconPath = ExploreHallUIApi:GetString("FishingActivityMoneyIcon", needID)

		AssetUtil.LoadImage(self, iconPath, self.ImgCost:GetComponent("Image"))

		self.CanUpgradeSkillLv = costNum <= haveNum
	end

	UGUIUtil.SetText(self.TextUpgradeSkillCost, FishingActivitySkillUIApi:GetString("UpgradeSkillCost", costNum, costNum <= haveNum))
end

function m:OnBtnUpgradeSkill()
	if not self.CanUpgradeSkillLv then
		NoticeModule.ShowNoticeNoCallback(21041013)

		return
	end

	FishingActivityModule.UpSkill(self.FishSkillData.cid)
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
