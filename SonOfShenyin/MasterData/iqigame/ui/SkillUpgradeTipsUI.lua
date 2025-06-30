-- chunkname: @IQIGame\\UI\\SkillUpgradeTipsUI.lua

local SkillUpgradeTipsUI = {}

SkillUpgradeTipsUI = Base:Extend("SkillUpgradeTipsUI", "IQIGame.Onigao.UI.SkillUpgradeTipsUI", SkillUpgradeTipsUI)

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local SkillUpgradePropertyItemClass = require("IQIGame.UI.RoleDevelopment.SkillUpgradePropertyItem")

function SkillUpgradeTipsUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function SkillUpgradeTipsUI:InitComponent()
	self.buttonMask = self.buttonMask:GetComponent("Button")
	self.propertyItemPool = UIViewObjectPool.New(self.propertyPrefab, self.propertyParent.transform, function(_view)
		return SkillUpgradePropertyItemClass.New(_view, self)
	end)
end

function SkillUpgradeTipsUI:InitDelegate()
	function self.buttonMaskDelegate()
		self:OnButtonMaskClick()
	end
end

function SkillUpgradeTipsUI:OnAddListeners()
	self.buttonMask.onClick:AddListener(self.buttonMaskDelegate)
end

function SkillUpgradeTipsUI:OnRemoveListeners()
	self.buttonMask.onClick:RemoveListener(self.buttonMaskDelegate)
end

function SkillUpgradeTipsUI:OnButtonMaskClick()
	UIModule.Close(Constant.UIControllerName.SkillUpgradeTipsUI)
end

function SkillUpgradeTipsUI:RefreshPropertyScroll(data)
	self.skillPropertyData = data

	self.propertyItemPool:ForItems(function(_item)
		return _item:Hide()
	end)
	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(1.2))

		for i = 1, #data do
			CoroutineUtility.Yield(CustomWaitForSeconds(0.2))

			self.propertyItem = self.propertyItemPool:GetFree(function(_item)
				return not _item.gameObject.activeSelf
			end)

			self.propertyItem:Refresh(data[i])
			self.propertyItem:Show()
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.5))

		self.buttonMask.interactable = true
	end)
end

function SkillUpgradeTipsUI:Refresh(userData)
	local skillPOD = userData.SkillPOD

	skillPOD.lv = skillPOD.lv + skillPOD.extLv

	local skillCfg = CfgUtil.GetCfgSkillDataWithID(skillPOD.skillCid)
	local skillLevelCfg = CfgUtil.GetCfgSkillLevelDataWithID(skillPOD.skillCid)
	local currentSkillLevelCfg = skillLevelCfg[skillPOD.lv - 1]
	local lastSkillLv, lastPurifyLv

	if skillCfg.SkillType == Constant.SkillType.TYPE_LORE then
		local lastSkillPod = userData.oldSkillPod

		LuaUtility.SetText(self.textLastLevel, lastSkillPod.lv)
		LuaUtility.SetText(self.textCurrentLevel, skillPOD.lv)

		lastSkillLv = lastSkillPod.lv
		lastPurifyLv = lastSkillPod.purifyLv
	else
		LuaUtility.SetGameObjectShow(self.CurLvDetails, false)
		LuaUtility.SetGameObjectShow(self.ArrowImg, false)
		UGUIUtil.SetText(self.CurLvDetails, currentSkillLevelCfg.SkillTips)
		UGUIUtil.SetText(self.NextLvDetails, skillLevelCfg[skillPOD.lv].SkillTips)
		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[skillPOD.itemCid].Icon), self.imageIcon:GetComponent("Image"))
		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[skillPOD.itemCid].Icon), self.CurImageIcon:GetComponent("Image"))
		LuaUtility.SetText(self.textLevel, string.format("Lv.%s", skillPOD.lv))
		LuaUtility.SetText(self.CurTextLevel, string.format("Lv.%s", skillPOD.lv - 1))

		lastSkillLv = skillPOD.lv - 1
	end

	LuaUtility.SetGameObjectShow(self.normalSkillRoot, skillCfg.SkillType ~= Constant.SkillType.TYPE_LORE)
	LuaUtility.SetGameObjectShow(self.diySkillRoot, skillCfg.SkillType == Constant.SkillType.TYPE_LORE)
	LuaUtility.SetGameObjectShow(self.LvDetailsParent, skillCfg.SkillType ~= Constant.SkillType.TYPE_LORE)

	self.SkillAttributes = {}

	local baseSubAttrs = DiySkillModule.GetSkillLevelAttributes(skillCfg.Quality, skillPOD.skillCid, lastSkillLv, lastPurifyLv, Constant.DIYSkillDisplayAttrTable)
	local nextSubAttrs = DiySkillModule.GetSkillLevelAttributes(skillCfg.Quality, skillPOD.skillCid, skillPOD.lv, skillPOD.purifyLv, Constant.DIYSkillDisplayAttrTable)
	local rankAttrs = DiySkillModule.GetSkillRankAttributes(skillPOD, skillPOD.strengLv, Constant.DIYSkillDisplayAttrTable)

	for _attrType, __attrValue in pairs(nextSubAttrs) do
		local attrData = {}

		attrData.type = _attrType
		attrData.curLvValue = baseSubAttrs[_attrType] + rankAttrs[_attrType]
		attrData.nextLvValue = __attrValue + rankAttrs[_attrType]

		table.insert(self.SkillAttributes, attrData)
	end

	local skillPropertyData = self:CreateSkillPropertyData(currentSkillLevelCfg)

	self:RefreshPropertyScroll(skillPropertyData)
end

function SkillUpgradeTipsUI:CreateSkillPropertyData(currentSkillLevelCfg, rankAttrs)
	local skillPropertyData = {}

	for k, v in pairs(self.SkillAttributes) do
		local property = {}
		local cfgAttribute = CfgUtil.GetCfgAttributeDataWithID(v.type)

		property.name = cfgAttribute.Name
		property.OldValue = v.curLvValue
		property.newValue = v.nextLvValue
		property.ImageUrl = cfgAttribute.ImageUrl

		table.insert(skillPropertyData, property)
	end

	return skillPropertyData
end

function SkillUpgradeTipsUI:GetSkillRankAttr(skillData)
	local SkillAttributes = {}
	local skillRankData = DiySkillModule.GetSkillRankData(skillData.skillCid, skillData.strengLv)
	local strengthCfg, skillSlotEffectParam

	if skillRankData ~= nil and skillRankData.StrengthenId ~= {} then
		for i = 1, #skillRankData.StrengthenId do
			strengthCfg = CfgSkillStrengthenTable[skillRankData.StrengthenId[i]]

			for k = 1, #strengthCfg.SkillSlotEffect do
				if strengthCfg.SkillSlotEffect[k] == 100 then
					skillSlotEffectParam = strengthCfg.SkillSlotEffectParam[k]
					SkillAttributes[tonumber(skillSlotEffectParam[1])] = tonumber(skillSlotEffectParam[2])
				end
			end
		end
	end

	return SkillAttributes
end

function SkillUpgradeTipsUI:OnOpen(userData)
	self.buttonMask.interactable = false

	self:Refresh(userData)
end

function SkillUpgradeTipsUI:OnClose(userData)
	self.buttonMask.interactable = false
end

function SkillUpgradeTipsUI:GetPreloadAssetPaths()
	return nil
end

function SkillUpgradeTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkillUpgradeTipsUI:IsManualShowOnOpen(userData)
	return false
end

function SkillUpgradeTipsUI:GetBGM(userData)
	return nil
end

function SkillUpgradeTipsUI:OnPause()
	return
end

function SkillUpgradeTipsUI:OnResume()
	return
end

function SkillUpgradeTipsUI:OnCover()
	return
end

function SkillUpgradeTipsUI:OnReveal()
	return
end

function SkillUpgradeTipsUI:OnRefocus(userData)
	return
end

function SkillUpgradeTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkillUpgradeTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkillUpgradeTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkillUpgradeTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SkillUpgradeTipsUI:OnDestroy()
	return
end

return SkillUpgradeTipsUI
