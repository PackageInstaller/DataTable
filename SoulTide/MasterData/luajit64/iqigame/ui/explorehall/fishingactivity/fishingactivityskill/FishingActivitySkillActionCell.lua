-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivitySkill\\FishingActivitySkillActionCell.lua

local m = {
	CanUpgradeSkillLv = false,
	SkillActionDirCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FishingActivitySkillActionDirCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivitySkillActionDirCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnUpGrade()
		self:OnBtnUpGrade()
	end

	self.SkillActionMould:SetActive(false)

	self.SkillActionDirCellPool = UIObjectPool.New(10, function()
		return FishingActivitySkillActionDirCell.New(UnityEngine.Object.Instantiate(self.SkillActionMould))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnUpgrade:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpGrade)
end

function m:RemoveListener()
	self.BtnUpgrade:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpGrade)
end

function m:SetData(data)
	self.SkillActionData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.SkillActionData then
		self.UnLockNode:SetActive(self.SkillActionData.isUnlock)
		self.LockNode:SetActive(not self.SkillActionData.isUnlock)
		self.NoMaxLvNode:SetActive(not self.SkillActionData:IsMaxLv())
		self.MaxLvNode:SetActive(self.SkillActionData:IsMaxLv())
		self.BtnUpgrade:SetActive(not self.SkillActionData:IsMaxLv())
		UGUIUtil.SetText(self.TextTitle, self.SkillActionData:GetCfgData().SkillName)
		UGUIUtil.SetText(self.TextLv, self.SkillActionData.lv)
		UGUIUtil.SetText(self.TextActionDes, FishingActivitySkillUIApi:GetString("ActionDes", self.SkillActionData:GetCfgLvData().Desc))

		local needID = self.SkillActionData:GetCfgLvData().Cost[1]
		local costNum = self.SkillActionData:GetCfgLvData().Cost[2] or 0
		local haveNum = 0

		self.CanUpgradeSkillLv = true

		if needID then
			haveNum = WarehouseModule.GetItemNumByCfgID(needID)

			local iconPath = ExploreHallUIApi:GetString("FishingActivityMoneyIcon", needID)

			AssetUtil.LoadImage(self, iconPath, self.ImgCost:GetComponent("Image"))

			self.CanUpgradeSkillLv = costNum <= haveNum
		end

		UGUIUtil.SetText(self.TextActionCost, FishingActivitySkillUIApi:GetString("ActionCost", costNum, costNum <= haveNum))

		local UIController = self.View:GetComponentInParent(typeof(UIController))

		for i, v in pairs(self.SkillActionDirCells) do
			v.View:SetActive(false)
			v.View.transform:SetParent(UIController.transform, false)
			self.SkillActionDirCellPool:Release(v)
		end

		self.SkillActionDirCells = {}

		for i = 1, #self.SkillActionData:GetCfgLvData().SkillAction do
			local dir = self.SkillActionData:GetCfgLvData().SkillAction[i]
			local dirCell = self.SkillActionDirCellPool:Obtain()

			dirCell.View:SetActive(true)
			dirCell.View.transform:SetParent(self.ActionListNode.transform, false)
			dirCell:SetData(dir)
			table.insert(self.SkillActionDirCells, dirCell)
		end
	end
end

function m:OnBtnUpGrade()
	if not self.CanUpgradeSkillLv then
		NoticeModule.ShowNoticeNoCallback(21041013)

		return
	end

	FishingActivityModule.UpAction(self.SkillActionData.cid)
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.SkillActionDirCells) do
		self.SkillActionDirCellPool:Release(v)
	end

	self.SkillActionDirCells = {}

	self.SkillActionDirCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
