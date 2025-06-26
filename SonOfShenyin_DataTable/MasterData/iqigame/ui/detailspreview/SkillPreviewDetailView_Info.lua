-- chunkname: @IQIGame\\UI\\DetailsPreview\\SkillPreviewDetailView_Info.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local AttributeItem = {}

function AttributeItem.New(view)
	local obj = Clone(AttributeItem)

	obj:__Init(view)

	return obj
end

function AttributeItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function AttributeItem:Hide()
	self.gameObject:SetActive(false)
end

function AttributeItem:Show(propertyData)
	self.gameObject:SetActive(true)

	local attributeData = CfgAttributeTable[propertyData.type]

	UGUIUtil.SetText(self.attNameText, attributeData.Name)
	UGUIUtil.SetText(self.attNumText, propertyData.curLvValue == nil and 0 or propertyData.curLvValue)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attributeData.ImageUrl), self.attIcon:GetComponent("Image"))
end

function AttributeItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.breachStarsCom = self.breachStars:GetComponent("StartsHelperComponent")
	self.startsComponent = self.presentBreachStars:GetComponent("StartsHelperComponent")
	self.comonSkillImgView = CommonSkillImageView.New(self.Com_SkillImgView)

	self.attPrefab:SetActive(false)

	local attPrefabParent = self.attPrefab.transform.parent

	self.attrObjectPool = UIViewObjectPool.New(self.attPrefab, attPrefabParent, function(_view)
		return AttributeItem.New(_view)
	end)

	function self.onShowMaxValueChanged(isOn)
		if isOn then
			self:SetData(self.skillData.skillCid)
		else
			self:SetData(self.skillData.skillCid)
		end
	end

	self:AddListeners()
end

function m:AddListeners()
	self.toggleShowMax:GetComponent("Toggle").onValueChanged:AddListener(self.onShowMaxValueChanged)
end

function m:RemoveListeners()
	self.toggleShowMax:GetComponent("Toggle").onValueChanged:RemoveListener(self.onShowMaxValueChanged)
end

function m:SetData(skillCid, isMax)
	if self.toggleShowMax:GetComponent("Toggle").isOn == true then
		isMax = true
	end

	self.skillData = self:CreateTempSkillData(skillCid, isMax)

	local cfgSkill = self.skillData:GetCfg()
	local itemCfg = DiySkillModule.GetItemCfgWithDiySkill(self.skillData)

	self.comonSkillImgView:SetData(skillCid)
	LuaUtility.SetText(self.textStory, itemCfg.ItemStory)
	LuaUtility.SetGameObjectShow(self.textStory, true)
	LuaUtility.SetText(self.skillNameText, itemCfg.Name)
	LuaUtility.SetText(self.presentLevelText, self.skillData.lv)
	LuaUtility.SetText(self.limitLevelText, "/" .. self.skillData:GetSkillMaxLevel())
	LuaUtility.SetText(self.skillTypeText, CommonSkillTipsUIApi:GetSkillTypeText(cfgSkill.ReleaseType))
	LuaUtility.SetText(self.refineText, DiySkillStrengthenUIApi:GetTextRefineLevel(self.skillData.purifyLv))
	LuaUtility.SetGameObjectShow(self.presentBreachStars, true)
	self.startsComponent:Refresh(itemCfg.Quality, itemCfg.Quality)

	local path = RoleDevelopmentApi:GetSkillQualityAndTypeImgPath(itemCfg.Quality, self.skillData:GetCfg().ReleaseType)

	AssetUtil.LoadImage(self, path, self.diySkillTypeImg:GetComponent("Image"))

	local maxStrengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(self.skillData.skillCid)

	self.breachStarsCom:Refresh(self.skillData.strengLv, maxStrengthenLv)

	local isElementLimit = table.len(cfgSkill.ElementLimit) > 0
	local isProfessionLimit = table.len(cfgSkill.ProfessionLimit) > 0

	LuaUtility.SetGameObjectShow(self.elementImg1, false)
	LuaUtility.SetGameObjectShow(self.elementImg2, false)
	LuaUtility.SetGameObjectShow(self.professionImg1, false)
	LuaUtility.SetGameObjectShow(self.professionImg2, false)
	LuaUtility.SetGameObjectShow(self.limitParent, isElementLimit or isProfessionLimit)

	if isElementLimit or isProfessionLimit then
		LuaUtility.SetGameObjectShow(self.elementLimitParent, isElementLimit)
		LuaUtility.SetGameObjectShow(self.professionLimitParent, isProfessionLimit)

		for i = 1, #cfgSkill.ElementLimit do
			AssetUtil.LoadImage(self, CommonSkillTipsUIApi:GetSkillLimitImg(Constant.SkillLimitType.Element, cfgSkill.ElementLimit[i]), self["elementImg" .. i]:GetComponent("Image"))
			LuaUtility.SetGameObjectShow(self["elementImg" .. i], true)
		end

		for i = 1, #cfgSkill.ProfessionLimit do
			AssetUtil.LoadImage(self, CommonSkillTipsUIApi:GetSkillLimitImg(Constant.SkillLimitType.Profession, cfgSkill.ProfessionLimit[i]), self["professionImg" .. i]:GetComponent("Image"))
			LuaUtility.SetGameObjectShow(self["professionImg" .. i], true)
		end
	end

	local refineCfg = DiySkillModule.GetSkillRefineCfg(self.skillData.skillCid, self.skillData.purifyLv)

	if refineCfg == nil then
		self.skilEffctParent:SetActive(false)
	else
		self.skilEffctParent:SetActive(true)
		LuaUtility.SetText(self.effectContentText, refineCfg.SkillTips)
		LuaUtility.SetText(self.descContentText, refineCfg.SkillStory)
	end

	self.attrObjectPool:ForItems(function(item)
		item:Hide()
	end)

	local attrTable = DiySkillModule.GetSkillTotalAttributes(self.skillData, Constant.DIYSkillDisplayAttrTable)

	ForPairs(attrTable, function(_attrType, _attrValue)
		local propertyItem = self.attrObjectPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		propertyItem:Show({
			type = _attrType,
			curLvValue = _attrValue
		})
	end)
end

function m:CreateTempSkillData(skillCid, isMax)
	local skillCfg = CfgSkillTable[skillCid]
	local skillData = SkillData.New()
	local skillItemPod = {
		lv = 1,
		purifyLv = 1,
		skillCid = skillCid,
		strengLv = isMax and DiySkillModule.GetSkillMaxStrengthenLevel(skillCfg.Id) or 0
	}

	skillData:UpdateData(skillItemPod)

	if isMax then
		skillData.lv = skillData:GetSkillMaxLevel()
		skillData.purifyLv = skillData:GetMaxRankLv()
	end

	return skillData
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self.attrObjectPool:ForItems(function(item)
		item:Dispose()
	end)

	self.startsComponent = nil
	self.breachStarsCom = nil

	self.comonSkillImgView:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
