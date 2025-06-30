-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\SkillTipsView.lua

local m = {
	heroIsEquip = false,
	AttrItems = {},
	ConditionObjList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateClickStrengthBtn()
		self:OnClickStrengthBtn()
	end

	function self.DelegateClickReplaceBtn()
		self:OnClickReplaceBtn()
	end

	function self.DelegateOnLockBtnClick()
		self:OnClickLockButton()
	end

	function self.DelegateOnLockSuccessEvent()
		self:OnLockSuccessEvent()
	end

	function self.DelegateOnClickBreachBtn()
		self:OnClickBreachBtn()
	end

	self.SkillItemSlot = ItemCell.New(self.CommonSlotUI, false)
	self.ApStarCom = self.ApStar:GetComponent("SimpleStarComponent")
	self.ReplaceBtnCom = self.ReplaceBtn:GetComponent("Button")
	self.ReplaceBtnGrayCom = self.ReplaceBtn:GetComponent("GrayComponent")
	self.CostImgCom = self.CostImg:GetComponent("Image")

	self:InigStaticText()
	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateClickCloseBtn)
	self.StrengthenBtn:GetComponent("Button").onClick:AddListener(self.DelegateClickStrengthBtn)
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBreachBtn)
	self.ReplaceBtn:GetComponent("Button").onClick:AddListener(self.DelegateClickReplaceBtn)
	self.LockBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnLockBtnClick)
	EventDispatcher.AddEventListener(EventID.LockSkillSucess, self.DelegateOnLockSuccessEvent)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClickCloseBtn)
	self.StrengthenBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClickStrengthBtn)
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBreachBtn)
	self.ReplaceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClickReplaceBtn)
	self.LockBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnLockBtnClick)
	EventDispatcher.RemoveEventListener(EventID.LockSkillSucess, self.DelegateOnLockSuccessEvent)
end

function m:InigStaticText()
	UGUIUtil.SetText(self.levelTitle, RoleDevelopmentApi:GetLvTitle())
	UGUIUtil.SetText(self.CDTitle, RoleDevelopmentApi:GetCDTitle())
	UGUIUtil.SetText(self.APTitle, RoleDevelopmentApi:GetAPTitle())
	UGUIUtil.SetText(self.AttrTitle, RoleDevelopmentApi:GetAttrTitle())
	UGUIUtil.SetText(self.SkillInfoDescTitle, RoleDevelopmentApi:GetSkillInfoDescTitle())
	UGUIUtil.SetText(self.ConditionTitle, RoleDevelopmentApi:GetConditionTitle())
	UGUIUtil.SetText(self.StrengthBtnText, RoleDevelopmentApi:GetStrengthBtnTitle())
	UGUIUtil.SetText(self.BreachBtnText, RoleDevelopmentApi:GetBreachBtnTitle())
	UGUIUtil.SetText(self.ElementTitle, RoleDevelopmentApi:GetElementTitle())
	UGUIUtil.SetText(self.CostTitle, RoleDevelopmentApi:GetCostTitle())
end

function m:SetData(itemData)
	self.SkillData = itemData.skillData
	self.itemData = itemData
	self.curSelectSkillData = WarlockModule.WarlockDataDic[RoleDevelopmentModule.CurSelectHeroCid].SkillGroups[RoleDevelopmentModule.CurSelectSkillPos]

	self.SkillItemSlot:SetItem(itemData)
	UGUIUtil.SetText(self.SkillName, self.SkillData:GetCfg().Name)
	UGUIUtil.SetText(self.CurLevelText, self.SkillData.lv)
	UGUIUtil.SetText(self.CDText, RoleDevelopmentApi:GetCDAddContentText(self.SkillData.CD))
	UGUIUtil.SetText(self.SkillInfoDesc, self.SkillData.skillCfgsByLv[self.SkillData.lv].SkillTips)
	UGUIUtil.SetText(self.TypeText, RoleDevelopmentApi:GetSkillType(self.SkillData:GetCfg().SkillType))
	self.ApStarCom:UpdateView(self.SkillData:GetCostEnergy(), 0)
	self.SkillCD:SetActive(self.SkillData.CD > 0)
	self.SkillAp:SetActive(self.SkillData:HeroEnergyCost() > 0)

	local isEquip = self.SkillData.heroCid ~= 0

	self.LockImg:SetActive(self.SkillData.lock)
	self.UnLockImg:SetActive(not self.SkillData.lock)
	self.EquipedHeroParent:SetActive(isEquip)

	local skillRangeID = self.SkillData:GetCfg().SkillRangeID

	LuaUtility.SetGameObjectShow(self.SkillRange, skillRangeID ~= 0)

	if skillRangeID ~= 0 then
		local path = UIGlobalApi.GetImagePath(CfgSkillRangeTable[skillRangeID].SkillRangeImg)

		AssetUtil.LoadImage(self, path, self.SkillRangeImg:GetComponent("Image"))
	end

	local skillElement = CfgSkillDetailTable[self.SkillData.skillCid].Element

	LuaUtility.SetGameObjectShow(self.Skill_Element, skillElement > 0)

	if skillElement > 0 then
		self:LoadImg(CommonSlotUIApi:GetSkillElement(skillElement), self.ElementImg)
	end

	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetSkillQualityBg(CfgItemTable[self.SkillData.itemCid].Quality), self.QualityBg:GetComponent("Image"))

	if isEquip then
		UGUIUtil.SetText(self.TagHeroName, RoleDevelopmentApi:GetEquipHeroDesc(CfgHeroTable[self.itemData.skillData.heroCid].Name))
		AssetUtil.LoadImage(self, SkinModule.GetHeroCurrentSkinImgPath(self.itemData.skillData.heroCid, Constant.SkinImageType.HeadIcon), self.TagHero:GetComponent("Image"))
	end

	self.heroIsEquip = self.curSelectSkillData ~= nil

	if self.heroIsEquip then
		UGUIUtil.SetText(self.ReplaceBtnText, RoleDevelopmentApi:GetReplaceBtnText())
	else
		UGUIUtil.SetText(self.ReplaceBtnText, RoleDevelopmentApi:GetEquipedText())
	end

	if not self.SkillData:IsMaxBreachLv() then
		self.isCanBreach = self.SkillData.lv >= self.SkillData.skillCfgsByStrengLv[self.SkillData.strengLv + 1].NeedSkillLv
		self.heroLvIsAchieve = PlayerModule.PlayerInfo.baseInfo.pLv >= self.SkillData.skillCfgsByStrengLv[self.SkillData.strengLv + 1].NeedLv
	end

	self.BreachBtn:SetActive(self.isCanBreach)
	self.StrengthenBtn:SetActive(not self.isCanBreach)
	self:GetSkillCondition()
	self:RefreshSkillAttr()
	self:RefreshCostAboutState()
end

function m:RefreshSkillAttr()
	local baseSubAttrs = self.SkillData:GetSkillAttr(self.SkillCurLv)

	for i = 1, #baseSubAttrs do
		local attrItemObj = self:CreateAttrItem(i)

		UGUIUtil.SetText(attrItemObj.AttrTypeText, CfgAttributeTable[baseSubAttrs[i].attrType].Name)
		UGUIUtil.SetText(attrItemObj.AttrValue, baseSubAttrs[i].attrValue == nil and 0 or baseSubAttrs[i].attrValue)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgAttributeTable[baseSubAttrs[i].attrType].ImageUrl), attrItemObj.AttrImg:GetComponent("Image"))
	end

	for i = 1, #self.AttrItems do
		self.AttrItems[i].View:SetActive(i <= #baseSubAttrs)
	end
end

function m:RefreshCostAboutState()
	if RoleDevelopmentModule.CurSelectHeroCid ~= nil then
		local allCost, curCost = RoleDevelopmentModule.GetHeroAndSkillCost(RoleDevelopmentModule.CurSelectHeroCid)
		local isGoBeyondMaxCost = false

		if self.heroIsEquip then
			isGoBeyondMaxCost = self.SkillData.Cost <= allCost - curCost + WarehouseModule.FindItem(self.curSelectSkillData.id).skillData.Cost
		else
			isGoBeyondMaxCost = allCost >= curCost + self.SkillData.Cost
		end

		if not isGoBeyondMaxCost then
			UGUIUtil.SetText(self.CostText, string.format(ColorCfg.Skill.red, self.SkillData.Cost))

			self.CostImgCom.color = ColorCfg.ImageColor.red

			self.ReplaceBtnGrayCom:SetGray(true)

			self.ReplaceBtnCom.interactable = false
		else
			UGUIUtil.SetText(self.CostText, string.format(ColorCfg.Skill.white, self.SkillData.Cost))

			self.CostImgCom.color = ColorCfg.ImageColor.white

			self.ReplaceBtnGrayCom:SetGray(false)

			self.ReplaceBtnCom.interactable = true
		end
	end
end

function m:CreateAttrItem(index)
	local attrItem = self.AttrItems[index]

	if attrItem == nil then
		local luaOutlet = {}
		local attrItemObj = UnityEngine.GameObject.Instantiate(self.AttrItemPrefab)

		attrItemObj.transform:SetParent(self.AttrItemsGrid.transform, false)
		LuaCodeInterface.BindOutlet(attrItemObj, luaOutlet)

		self.AttrItems[index] = luaOutlet
		attrItem = self.AttrItems[index]
	end

	return attrItem
end

function m:GetSkillCondition()
	self.ConditionDataList = {}
	self.ConditionDataList[Constant.SkillConditionType.PROFRESSION] = {}
	self.ConditionDataList[Constant.SkillConditionType.ELEMENT] = {}
	self.ConditionDataList[Constant.SkillConditionType.POWER] = {}

	local conditionCfg = self.SkillData:GetCfg()

	for i = 1, #conditionCfg.ProfessionLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.PROFRESSION], {
			conditionCfg.ProfessionLimit[i]
		})
	end

	for i = 1, #conditionCfg.ElementLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.ELEMENT], {
			conditionCfg.ElementLimit[i]
		})
	end

	for i = 1, #conditionCfg.ForceLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.POWER], {
			conditionCfg.ForceLimit[i]
		})
	end

	self:SetConditionItem()
end

function m:SetConditionItem()
	for i = 1, #self.ConditionObjList do
		self.ConditionObjList[i]:SetActive(false)
	end

	local length = 0

	for i = 1, #self.ConditionDataList do
		for j = 1, #self.ConditionDataList[i] do
			if self.ConditionDataList[i][j][1] ~= 0 then
				length = length + 1

				local Obj = self:CreateElementConditionItem(length)

				Obj:SetActive(true)
				UGUIUtil.SetTextsInChildren(Obj, self:GetDictText(i, self.ConditionDataList[i][j][1]))
			end
		end
	end

	self.ConditionParent:SetActive(length ~= 0)
end

function m:CreateElementConditionItem(index)
	local obj = self.ConditionObjList[index]

	if obj == nil then
		obj = UnityEngine.Object.Instantiate(self.ConditionItemPrefab)

		obj.transform:SetParent(self.SkillConditionGrid.transform, false)

		self.ConditionObjList[index] = obj
	end

	return obj
end

function m:GetDictText(groupID, id)
	if groupID == 1 then
		groupID = 7
	elseif groupID == 2 then
		groupID = 8
	elseif groupID == 3 then
		groupID = 9
	end

	for k, v in pairsCfg(CfgDictTable) do
		if v.GroupId == groupID and v.TypeId == id then
			return RoleDevelopmentApi:GetItemIipsDesc(v.TipsId)
		end
	end
end

function m:OnClickBreachBtn()
	if not self.heroLvIsAchieve then
		NoticeModule.ShowNotice(44002)

		return
	end

	UIModule.Open(Constant.UIControllerName.SkillBreachUI, Constant.UILayer.UI, self.SkillData.id)
	self:OnClickCloseBtn()
end

function m:OnLockSuccessEvent()
	if self.SkillData ~= nil then
		self.SkillData = WarehouseModule.FindItem(self.SkillData.id).skillData

		self.LockImg:SetActive(self.SkillData.lock)
		self.UnLockImg:SetActive(not self.SkillData.lock)
	end
end

function m:OnClickLockButton()
	RoleDevelopmentModule.RoleSkillLock({
		self.SkillData.id
	})
end

function m:OnClickStrengthBtn()
	UIModule.Open(Constant.UIControllerName.SkillStrengthenUI, Constant.UILayer.UI, self.SkillData.id)
	self:OnClickCloseBtn()
end

function m:OnClickReplaceBtn()
	RoleDevelopmentModule.RoleSkillWear(RoleDevelopmentModule.CurSelectHeroCid, RoleDevelopmentModule.CurSelectSkillPos, self.SkillData.id)
end

function m:OnClickCloseBtn()
	self:Hide()
	EventDispatcher.Dispatch(EventID.CloseSkillTipsEvent)
end

function m:LoadImg(path, imgObj)
	AssetUtil.LoadImage(self, path, imgObj:GetComponent("Image"))
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
