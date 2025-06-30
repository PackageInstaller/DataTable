-- chunkname: @IQIGame\\UI\\EvilErosionSoulInfoUI.lua

require("IQIGame.UIExternalApi.EvilErosionSoulInfoUIApi")
require("IQIGame.UIExternalApi.EvilErosionLevelDetailUIApi")

local FormationSoulCellAttrItem = require("IQIGame.UI.FormationUI.FormationSoulCellAttrItem")
local EvilErosionSkillCell = require("IQIGame.UI.EvilErosion.EvilErosionSkillCell")
local SoulFeatureTipController = require("IQIGame.UI.Soul.SoulFeatureTipController")
local EvilErosionSoulInfoUI = {
	AttrItems = {},
	SkillCells = {}
}

EvilErosionSoulInfoUI = Base:Extend("EvilErosionSoulInfoUI", "IQIGame.Onigao.UI.EvilErosionSoulInfoUI", EvilErosionSoulInfoUI)

function EvilErosionSoulInfoUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.AttrItemPrefab:SetActive(true)

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = FormationSoulCellAttrItem.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.AttrItems[i] = item
	end

	self.AttrItemPrefab:SetActive(false)
	self.SkillCellPrefab:SetActive(true)

	for i = 1, 8 do
		local cell = EvilErosionSkillCell.New(UnityEngine.Object.Instantiate(self.SkillCellPrefab), i, function(index)
			self:OnChangeSkill(index)
		end, true)

		cell.View.transform:SetParent(self.SkillGrid.transform, false)

		self.SkillCells[i] = cell
	end

	self.SkillCellPrefab:SetActive(false)

	self.SoulFeatureTipController = SoulFeatureTipController.New(self.FeatureView, function(text, descGO)
		self:OnClickFeatureDesc(text, descGO)
	end)

	UGUIUtil.SetText(self.AttrLabel, EvilErosionSoulInfoUIApi:GetString("AttrLabel"))
	UGUIUtil.SetText(self.SkillLabel, EvilErosionSoulInfoUIApi:GetString("SkillLabel"))
end

function EvilErosionSoulInfoUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionSoulInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionSoulInfoUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionSoulInfoUI:GetBGM(userData)
	return nil
end

function EvilErosionSoulInfoUI:OnOpen(userData)
	self:UpdateView(userData.soulData, userData.customFeatureSkills)
end

function EvilErosionSoulInfoUI:OnClose(userData)
	return
end

function EvilErosionSoulInfoUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionSoulInfoUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionSoulInfoUI:OnPause()
	return
end

function EvilErosionSoulInfoUI:OnResume()
	return
end

function EvilErosionSoulInfoUI:OnCover()
	return
end

function EvilErosionSoulInfoUI:OnReveal()
	return
end

function EvilErosionSoulInfoUI:OnRefocus(userData)
	return
end

function EvilErosionSoulInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionSoulInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionSoulInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionSoulInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionSoulInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item:Dispose()
	end

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		cell:Dispose()
	end

	self.SoulFeatureTipController:Dispose()
end

function EvilErosionSoulInfoUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EvilErosionSoulInfoUI:UpdateView(soulData, customFeatureSkills)
	local cfgSoulData = soulData:GetCfgSoul()
	local cfgSoulResData = soulData:GetCfgSoulRes2D()

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.SoulFormationImage), self.SoulHeadImage:GetComponent("Image"))
	self.Star:GetComponent("SimpleStarComponent"):UpdateView(5, soulData:GetCfgSoulQuality().Quality)
	UGUIUtil.SetText(self.SoulNameText, cfgSoulData.Name)
	UGUIUtil.SetText(self.SoulNameText2, cfgSoulData.EnglishName)
	UGUIUtil.SetText(self.LevelText, EvilErosionSoulInfoUIApi:GetString("LevelText", soulData.lv))

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]
		local attrId = showAttrIds[i]
		local prefabAttrValue = soulData.atts[attrId]

		item:SetData(attrId, prefabAttrValue)
	end

	local skillCids = self:GetSkills(soulData)

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]
		local skillCid = skillCids[i]

		cell:SetData(skillCid, soulData.activationSkillStrengthen)
	end

	self.SoulFeatureTipController:SetData(soulData, customFeatureSkills)
end

function EvilErosionSoulInfoUI:GetSkills(soulData)
	local skillCids = {}
	local cfgSoulData = soulData:GetCfgSoul()

	for i = 1, 2 do
		local cfgSkillGroupData = CfgSkillGroupTable[cfgSoulData.DefaultSkill[i]]

		for j = 1, #cfgSkillGroupData.GroupSkills do
			table.insert(skillCids, cfgSkillGroupData.GroupSkills[j])
		end
	end

	return skillCids
end

function EvilErosionSoulInfoUI:OnClickFeatureDesc(text, descGO)
	if UIGlobalApi.CheckExistKeywordTag(text) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			text,
			descGO
		})
	end
end

return EvilErosionSoulInfoUI
