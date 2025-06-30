-- chunkname: @IQIGame\\UI\\DiySkill\\DetailsView\\DiySkillDetailsTopElement.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local StartItem = {}

function StartItem.New(view)
	local obj = Clone(StartItem)

	obj:__Init(view)

	return obj
end

function StartItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.off:SetActive(true)
	self.on:SetActive(false)
end

function StartItem:Show(isOn)
	self.off:SetActive(not isOn)
	self.on:SetActive(isOn)
	self.gameObject:SetActive(true)
end

function StartItem:Hide()
	self.off:SetActive(false)
	self.on:SetActive(false)
	self.gameObject:SetActive(false)
end

function StartItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local DiySkillDetailsTopElement = {}

function DiySkillDetailsTopElement.New(view)
	local obj = Clone(DiySkillDetailsTopElement)

	obj:__Init(view)

	return obj
end

function DiySkillDetailsTopElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.stars1:SetActive(false)

	local stratsParent = self.stars1.transform.parent

	self.startObjectPool = UIViewObjectPool.New(self.stars1, stratsParent, function(_view)
		return StartItem.New(_view)
	end)
	self.limitImgItemPool = UIViewObjectPool.New(self.limitImgPrefab, nil)

	function self.__onLockBtnClickProxy()
		RoleDevelopmentModule.RoleSkillLock({
			self.skillId
		})
	end

	self:__AddListeners()
end

function DiySkillDetailsTopElement:__AddListeners()
	self.lockBtn:GetComponent("Button").onClick:AddListener(self.__onLockBtnClickProxy)
end

function DiySkillDetailsTopElement:__RemoveListeners()
	self.lockBtn:GetComponent("Button").onClick:RemoveListener(self.__onLockBtnClickProxy)
end

function DiySkillDetailsTopElement:Dispose()
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillDetailsTopElement:Show(skillData)
	self.skillId = skillData.id

	local skillCfg = skillData:GetCfg()

	LuaUtility.SetGameObjectShow(self.normalRoot, true)
	LuaUtility.SetGameObjectShow(self.compareRoot, false)
	UGUIUtil.SetText(self.skillTypeText, CommonSkillTipsUIApi:GetSkillTypeText(skillCfg.ReleaseType))
	self:__RefreshCost(skillData)
	self:__RefreshSkillElement(skillData)
	UGUIUtil.SetText(self.skillNameText, CommonSkillTipsUIApi:GetSkillName(skillCfg.Name, nil))
	self:__RefreshLevel(skillData)
	self:__RefreshStars(skillData)
	self:__RefreshSkillLockState(skillData.lock)
	self:__RefreshSkillLimit(skillData)

	local refineImg = DiySkillStrengthenUIApi:GetSkillRefineLevelImg(skillData.purifyLv)

	AssetUtil.LoadImage(self, refineImg, self.refineImg:GetComponent("Image"))
	LuaUtility.SetText(self.refineText, DiySkillStrengthenUIApi:GetTextRefineLevel(skillData.purifyLv))
	UGUIUtil.SetText(self.refineNumText, DiySkillStrengthenUIApi:GetSkillRefineNumber(skillData.purifyLv))
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DiySkillDetailsTopElement:ShowCompare(heroCid, skillPos, skillData)
	LuaUtility.SetGameObjectShow(self.normalRoot, false)
	LuaUtility.SetGameObjectShow(self.compareRoot, true)

	local currentSkillData = RoleDevelopmentModule.GetCurHeroSkill(heroCid)[skillPos]

	if currentSkillData then
		local currentSkillCfg = currentSkillData:GetCfg()

		LuaUtility.SetText(self.currentSkillName, CommonSkillTipsUIApi:GetSkillName(currentSkillCfg.Name, nil))
		LuaUtility.SetText(self.currentSkillLevel, currentSkillData.lv)
		LuaUtility.SetText(self.currentSkillLimitLevel, "/" .. currentSkillData:GetSkillMaxLevel())
	else
		LuaUtility.SetText(self.currentSkillName, CommonSkillTipsUIApi:GetTextUnEquip())
		LuaUtility.SetText(self.currentSkillLevel, "0")
		LuaUtility.SetText(self.currentSkillLimitLevel, "/0")
	end

	local cfgTargetSkill = skillData:GetCfg()

	LuaUtility.SetText(self.targetSkillName, CommonSkillTipsUIApi:GetSkillName(cfgTargetSkill.Name, nil))
	LuaUtility.SetText(self.targetSkillLevel, skillData.lv)
	LuaUtility.SetText(self.targetSkillLimitLevel, "/" .. skillData:GetSkillMaxLevel())
	UGUIUtil.SetText(self.skillTypeText, CommonSkillTipsUIApi:GetSkillTypeText(cfgTargetSkill.ReleaseType))
	self:__RefreshSkillElement(skillData)
	self:__RefreshSkillLockState(skillData.lock)
	self:__RefreshSkillLimit(skillData)
	LuaUtility.SetText(self.refineText, DiySkillStrengthenUIApi:GetTextRefineLevel(skillData.purifyLv))
	LuaUtility.SetText(self.refineNumText, DiySkillStrengthenUIApi:GetSkillRefineNumber(skillData.purifyLv))
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DiySkillDetailsTopElement:__RefreshSkillElement(skillData)
	local skillElement = skillData:GetCfg().ElementLimit and skillData:GetCfg().ElementLimit[1] or 0
	local needShowElement = skillElement > 0

	LuaUtility.SetGameObjectShow(self.elementLimit, needShowElement)

	if not needShowElement then
		return
	end

	local path = CommonSkillTipsUIApi:GetSkillElementIconPath(skillElement)

	LuaUtility.LoadImage(self, path, self.elementImg:GetComponent("Image"))
	LuaUtility.SetText(self.textType, CommonSkillTipsUIApi:GetTextElementLimit(skillElement))
end

function DiySkillDetailsTopElement:__RefreshCost(skillData)
	local cost = skillData:GetCfg().NeedCost
	local attributeData = CfgAttributeTable[DiySkillModule.SkillCostAttrID]

	UGUIUtil.SetText(self.costText, attributeData.Name)
	UGUIUtil.SetText(self.costNumText, cost)
end

function DiySkillDetailsTopElement:__RefreshLevel(skillData)
	UGUIUtil.SetText(self.presentLevelText, skillData.lv)
	UGUIUtil.SetText(self.limitLevelText, "/" .. skillData:GetSkillMaxLevel())
end

function DiySkillDetailsTopElement:__RefreshStars(skillData)
	self.startObjectPool:ForItems(function(_item)
		_item:Hide()
	end)

	local maxStrengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(skillData:GetCfg().Id)

	for i = 1, maxStrengthenLv do
		local item = self.startObjectPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		item:Show(i <= skillData.strengLv)
	end
end

function DiySkillDetailsTopElement:__RefreshSkillLockState(isLock)
	LuaCodeInterface.SetGameObjectShow(self.on, isLock)
	LuaCodeInterface.SetGameObjectShow(self.off, not isLock)
end

function DiySkillDetailsTopElement:__RefreshSkillLimit(skillData)
	local skillCfg = skillData:GetCfg()
	local limitDatas = {}

	for i = 1, #skillCfg.ForceLimit do
		if skillCfg.ForceLimit[i] ~= 0 then
			table.insert(limitDatas, {
				type = Constant.SkillLimitType.Force,
				value = skillCfg.ForceLimit[i]
			})
		end
	end

	for i = 1, #skillCfg.ProfessionLimit do
		if skillCfg.ProfessionLimit[i] ~= 0 then
			table.insert(limitDatas, {
				type = Constant.SkillLimitType.Profession,
				value = skillCfg.ProfessionLimit[i]
			})
		end
	end

	for i = 1, #skillCfg.ElementLimit do
		if skillCfg.ElementLimit[i] ~= 0 then
			table.insert(limitDatas, {
				type = Constant.SkillLimitType.Element,
				value = skillCfg.ElementLimit[i]
			})
		end
	end

	self.limitImgItemPool:ForItems(function(_item)
		LuaUtility.SetGameObjectShow(_item, false)
	end)

	for i = 1, #limitDatas do
		local limitImgItem = self.limitImgItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		LuaUtility.SetGameObjectShow(limitImgItem, true)
		AssetUtil.LoadImage(self, CommonSkillTipsUIApi:GetSkillLimitImg(limitDatas[i].type, limitDatas[i].value), limitImgItem:GetComponent("Image"))
	end
end

return DiySkillDetailsTopElement
