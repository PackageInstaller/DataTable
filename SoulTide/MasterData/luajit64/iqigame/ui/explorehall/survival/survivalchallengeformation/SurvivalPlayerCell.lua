-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalChallengeFormation\\SurvivalPlayerCell.lua

local m = {
	needItemNum = 0,
	survivalPlayerAttrCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local SurvivalPlayerAttrCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeFormation.SurvivalPlayerAttrCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnEnterGame()
		self:OnBtnEnterGame()
	end

	self.AttrModule:SetActive(false)

	self.survivalPlayerAttrPool = UIObjectPool.New(5, function()
		return SurvivalPlayerAttrCell.New(UnityEngine.Object.Instantiate(self.AttrModule))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnEnterGame:GetComponent("Button").onClick:AddListener(self.DelegateBtnEnterGame)
end

function m:RemoveListener()
	self.BtnEnterGame:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEnterGame)
end

function m:SetData(data, openType, levelCid)
	self.needItemCid = nil
	self.survivalPlayerData = data
	self.openType = openType
	self.levelCid = levelCid

	local path = UIGlobalApi.GetImagePath(self.survivalPlayerData:GetConfigData().MechaImage)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, self.survivalPlayerData:GetConfigData().Name)
	UGUIUtil.SetText(self.TextLv, self.survivalPlayerData.grade)
	self.SkillLock:SetActive(false)
	self.SkillUnlock:SetActive(false)

	for i, v in pairs(self.survivalPlayerAttrCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		self.survivalPlayerAttrPool:Release(v)
	end

	self.survivalPlayerAttrCells = {}

	if self.survivalPlayerData then
		local cfgData = self.survivalPlayerData:GetCfgSpecialData()

		if cfgData then
			self.SkillUnlock:SetActive(true)
			UGUIUtil.SetText(self.TextSkill, cfgData.Skill)
		else
			self.SkillLock:SetActive(true)
		end

		local cfgLevelData = self.survivalPlayerData:GetConfigLevelData(self.survivalPlayerData.grade)

		if cfgLevelData then
			for i = 1, #cfgLevelData.AttType do
				local attrID = cfgLevelData.AttType[i]
				local attrValue = cfgLevelData.AttValue[i]

				if CfgSurvivalChallengeAttributeTable[attrID].IsShow then
					local playerAttrCell = self.survivalPlayerAttrPool:Obtain()

					playerAttrCell.View:SetActive(true)
					playerAttrCell.View.transform:SetParent(self.AttrNode.transform, false)
					playerAttrCell:SetData(attrID, attrValue, false)
					table.insert(self.survivalPlayerAttrCells, playerAttrCell)
				end
			end
		end
	end

	local costTab = {}

	if self.openType == FlyGameConstant.ChallengeType.Challenge_Level_Mode then
		costTab = CfgSurvivalChallengeLevelTable[self.levelCid].Cost
	elseif self.openType == FlyGameConstant.ChallengeType.Challenge_Endless_Mode then
		costTab = SurvivalModule.GetFlightGameCost()
	end

	if #costTab > 0 then
		self.needItemCid = costTab[1]
		self.needItemNum = costTab[2]
	end

	if self.needItemCid then
		local iconPath = UIGlobalApi.GetIconPath(CfgItemTable[self.needItemCid].Icon)

		AssetUtil.LoadImage(self, iconPath, self.SpendIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.SpendValue, SurvivalChallengeFormationUIApi:GetString("SpendValue", self.needItemNum))
	end
end

function m:OnBtnEnterGame()
	if self.openType == FlyGameConstant.ChallengeType.Challenge_Level_Mode then
		SurvivalModule.StartChallenge(self.survivalPlayerData.cid, self.levelCid)
	else
		SurvivalModule.StartChallengeUnlimited(self.survivalPlayerData.cid)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.survivalPlayerAttrCells) do
		self.survivalPlayerAttrPool:Release(v)
	end

	self.survivalPlayerAttrCells = {}

	self.survivalPlayerAttrPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
