-- chunkname: @IQIGame\\UI\\Formation\\ItemCell\\FormationSkillDetailsCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.commonSlotUI = ItemCell.New(self.CommonSlotUI, false, false)

	self.View:SetActive(true)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(index, heroData)
	LuaUtility.SetGameObjectShow(self.CommonSlotUI, false)

	if heroData.isHelpHeroData or heroData.isTempHeroData then
		self.skillData = RoleDevelopmentModule.GetCurHeroSkill(heroData.cid, heroData)[index]
	else
		self.skillData = RoleDevelopmentModule.GetCurHeroSkill(heroData.cid)[index]
	end

	local isAchieve = false

	if index == 4 then
		isAchieve = heroData.lv >= CfgDiscreteDataTable[28].Data[1]

		UGUIUtil.SetText(self.NoUnLockDesc, FormationUIApi:GetLockSkillInfo(CfgDiscreteDataTable[28].Data[1]))
		UGUIUtil.SetText(self.LimitLevel, CfgDiscreteDataTable[28].Data[1])
	elseif index == 5 then
		isAchieve = heroData.lv >= CfgDiscreteDataTable[29].Data[1]

		UGUIUtil.SetText(self.NoUnLockDesc, FormationUIApi:GetLockSkillInfo(CfgDiscreteDataTable[29].Data[1]))
		UGUIUtil.SetText(self.LimitLevel, CfgDiscreteDataTable[29].Data[1])
	end

	self.DiySkillParent:SetActive(index > 3)
	self.BaseSkillParent:SetActive(index <= 3)
	self.DIYUnEquip:SetActive(index > 3 and self.skillData == nil)
	self.DiySkill:SetActive(index > 3 and self.skillData ~= nil)
	self.UnEquip:SetActive(self.skillData == nil)
	self.Equip:SetActive(self.skillData ~= nil)
	self.Lock:SetActive(self.skillData == nil and not isAchieve)
	self.SkilInfoParent:SetActive(self.skillData ~= nil)
	self.NoEquipDesc:SetActive(self.skillData == nil and isAchieve)
	self.NoUnLockDesc:SetActive(self.skillData == nil and not isAchieve)

	if self.skillData ~= nil then
		if index > 3 then
			UGUIUtil.SetText(self.DiyNameText, self.skillData:GetCfg().Name)
			UGUIUtil.SetText(self.DiySkillLvText, "Lv" .. self.skillData.lv + self.skillData.extLv)
			UGUIUtil.SetText(self.DiyTypeText, RoleDevelopmentApi:GetSkillType(self.skillData:GetCfg().SkillType))
			LuaUtility.SetGameObjectShow(self.CommonSlotUI, true)

			local tempItemData = ItemData.CreateByCIDAndNumber(self.skillData.itemCid)

			tempItemData.skillData = self.skillData

			self.commonSlotUI:SetItem(tempItemData)
			UGUIUtil.SetText(self.SkillDesc, self.skillData:GetSkillRefineInfo().SkillTips)
		else
			UGUIUtil.SetText(self.SkillNameText, self.skillData:GetCfg().Name)
			UGUIUtil.SetText(self.SkillLvText, "Lv" .. self.skillData.lv + self.skillData.extLv)
			UGUIUtil.SetText(self.SkillTypeText, RoleDevelopmentApi:GetSkillType(self.skillData:GetCfg().SkillType))
			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgSkillTable[self.skillData.skillCid].Icon), self.SkillIcon:GetComponent("Image"))
			UGUIUtil.SetText(self.SkillDesc, self.skillData.skillCfgsByLv[self.skillData.lv + self.skillData.extLv].SkillTips)
		end

		local cd = 0
		local ap = 0
		local cost = 0

		if heroData.isTempHeroData then
			cd = self.skillData.CD
			ap = self.skillData:GetCostEnergy()
		else
			cd, ap, cost = CfgUtil.GetSkillCD_Eg_Ct(heroData, self.skillData.skillCid, self.skillData.lv + self.skillData.extLv)
		end

		UGUIUtil.SetText(self.ApText, ap)
		UGUIUtil.SetText(self.CoolingText, cd)
		self.CoolingParent:SetActive(cd > 0)
		self.ApParent:SetActive(ap > 0)

		local skillRangeID = self.skillData:GetCfg().SkillRangeID

		if skillRangeID == 0 then
			self.SkillRangeImg:SetActive(false)
		else
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgSkillRangeTable[self.skillData:GetCfg().SkillRangeID].SkillRangeImg), self.SkillRangeImg:GetComponent("Image"))
			self.SkillRangeImg:SetActive(true)
		end
	end
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
