-- chunkname: @IQIGame\\UI\\SkillStrengthenUI.lua

local SkillStrengthenUI = Base:Extend("SkillStrengthenUI", "IQIGame.Onigao.UI.SkillStrengthenUI", {
	MaxExp = 0,
	UpgradeNeedMoney = 0,
	isQuickSelect = false,
	curAllExp = 0,
	curSelectAllExp = 0,
	NeedExp = 0,
	MaxLv = 0,
	CurUpgradeExp = 0,
	SkillCurLv = 0,
	AllSkillItemDatas = {},
	SkillTable = {},
	ItemTable = {},
	ItemCellList = {},
	AttrItems = {},
	CurSelectMaterialItems = {},
	SelectUpgradeItems = {},
	ConditionObjList = {},
	tempScrollItems = {}
})
local DropDownUI = require("IQIGame.UI.Common.DropDownUI")
local SelectItemCell = require("IQIGame.UI.RoleDevelopment.ItemCell.SelectItemCell")

function SkillStrengthenUI:OnInit()
	self.CurExpSliderComponent = self.CurExpSlider:GetComponent("Image")
	self.wrapContent = self.SkillItemsScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.wrapContent.onRenderEnd(cell)
		self:OnRenderEndItem()
	end

	function self.DelegateSelectMaterial(data)
		self:SelectMaterialCallback(data)
	end

	function self.DelegateStrengthBtnClick()
		self:StrengthBtnClick()
	end

	function self.DelegateBreachBtnClick()
		self:OnClickBreachBtn()
	end

	function self.DelegateClearAllBtnClick()
		self:OnClickClearAllBtn()
	end

	function self.DelegateSkillUpgradeSucess()
		self:SkillUpgradeSucess()
	end

	function self.DelegateQuickAddBtnClick()
		self:OnQuickAddBtnClick()
	end

	function self.DelegateBreachSucess()
		self:BreachSucessCallback()
	end

	self.TypeDropdownItem = DropDownUI.New(self.TypeDropdown, function(sortType)
		self:OnDropDownCallBack(sortType)
	end, function(count)
		self:OnScreenCallBack(count)
	end)
	self.previewImg = self.PreviewExpImg:GetComponent("Image")

	local data = RoleDevelopmentApi:GetSreenTextList()

	self.TypeDropdownItem:SetData(data)

	self.CurDropDownType = 1
	self.CurScreenClickCount = 1
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)
	self.breachStarCom = self.BreachStar:GetComponent("SimpleStarComponent")
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self:InigStaticText()
end

function SkillStrengthenUI:GetPreloadAssetPaths()
	return nil
end

function SkillStrengthenUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkillStrengthenUI:IsManualShowOnOpen(userData)
	return false
end

function SkillStrengthenUI:GetBGM(userData)
	return nil
end

function SkillStrengthenUI:OnOpen(skillId)
	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)
	self.commonReturnBtn:SetHomeBtnState(SceneTransferModule.GetCanBackHome())
	self:SetSkillInfo(skillId)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.RoleBreachUI)
	LuaUtility.SetGameObjectShow(self.ClearAllBtn, false)
end

function SkillStrengthenUI:OnClose(userData)
	self.CurSelectMaterialItems = {}
	self.tempScrollItems = {}
	self.CurUpgradeExp = 0
	self.UpgradeNeedMoney = 0
	self.isQuickSelect = false

	self.consumeGoldCell:SetData(self.UpgradeNeedMoney)
end

function SkillStrengthenUI:OnAddListeners()
	self.StrengthBtn:GetComponent("Button").onClick:AddListener(self.DelegateStrengthBtnClick)
	self.QuickAddBtn:GetComponent("Button").onClick:AddListener(self.DelegateQuickAddBtnClick)
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateBreachBtnClick)
	self.ClearAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateClearAllBtnClick)
	EventDispatcher.AddEventListener(EventID.SelectUpgradeMaterial, self.DelegateSelectMaterial)
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpgradeSucess)
	EventDispatcher.AddEventListener(EventID.RoleSkillBreachSucess, self.DelegateBreachSucess)
end

function SkillStrengthenUI:OnRemoveListeners()
	self.StrengthBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateStrengthBtnClick)
	self.QuickAddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateQuickAddBtnClick)
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBreachBtnClick)
	self.ClearAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClearAllBtnClick)
	EventDispatcher.RemoveEventListener(EventID.SelectUpgradeMaterial, self.DelegateSelectMaterial)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpgradeSucess)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillBreachSucess, self.DelegateBreachSucess)
end

function SkillStrengthenUI:OnPause()
	return
end

function SkillStrengthenUI:OnResume()
	return
end

function SkillStrengthenUI:OnCover()
	return
end

function SkillStrengthenUI:OnReveal()
	return
end

function SkillStrengthenUI:OnRefocus(userData)
	return
end

function SkillStrengthenUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkillStrengthenUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkillStrengthenUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkillStrengthenUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SkillStrengthenUI:OnDestroy()
	self.moneyCell:Dispose()
	self.consumeGoldCell:Dispose()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function SkillStrengthenUI:InigStaticText()
	UGUIUtil.SetText(self.CurSkillDescTitle, RoleDevelopmentApi:GetCurEffectTitle())
	UGUIUtil.SetText(self.NextSkillDescTitle, RoleDevelopmentApi:GetNextEffectTitle())
	UGUIUtil.SetText(self.StrengthBtnText, RoleDevelopmentApi:GetStrengthBtnTitle())
	UGUIUtil.SetText(self.QuickAddBtnText, RoleDevelopmentApi:GetQuickAddBtnText())
	UGUIUtil.SetText(self.AttrTitle, RoleDevelopmentApi:GetAttrTitle())
	UGUIUtil.SetTextsInChildren(self.BreachBtn, RoleDevelopmentApi:GetBreachBtnTitle())
	UGUIUtil.SetTextsInChildren(self.MaxBtn, RoleDevelopmentApi:GetMaxText())
end

function SkillStrengthenUI:SetSkillInfo(skillId)
	self.UpgradeNeedMoney = 0
	self.curSelectAllExp = 0

	self.consumeGoldCell:SetData(self.UpgradeNeedMoney)

	self.SkillData = WarehouseModule.FindItem(skillId).skillData
	self.MaxLv = self.SkillData:GetDiySkillMaxLvByBreach(self.SkillData.strengLv)
	self.curAllExp = self.SkillData:GetCurSkillExp() + self.SkillData.exp

	local isMaxStrength = self.SkillData:IsMaxBreachLv()

	UGUIUtil.SetText(self.LvText, self.SkillData.lv)
	UGUIUtil.SetText(self.SkillNameText, self.SkillData:GetCfg().Name)
	UGUIUtil.SetText(self.MAXLevelText, "/" .. self.MaxLv)
	UGUIUtil.SetText(self.CurSkillDescInfo, self.SkillData.skillCfgsByLv[self.SkillData.lv].SkillTips)
	UGUIUtil.SetText(self.TypeText, RoleDevelopmentApi:GetSkillType(self.SkillData:GetCfg().SkillType))

	local desc = ""

	for lv = 1, #self.SkillData.skillCfgsByLv do
		if lv > self.SkillData.lv and self.SkillData.skillCfgsByLv[lv].SKillTipsAdd ~= "" then
			desc = desc .. self.SkillData.skillCfgsByLv[lv].SKillTipsAdd .. "\n"
		end
	end

	UGUIUtil.SetText(self.NextSkillDescInfo, desc)
	LuaUtility.SetGameObjectShow(self.NextSkillDesc, string.len(desc) > 0)

	local cells = self.breachStarCom.cells.Count

	for i = 1, cells do
		local simpleStarCell = self.breachStarCom.cells[i - 1]

		self:LoadImg(CommonSlotUIApi:GetSkillBreachStarImg(CfgItemTable[self.SkillData.itemCid].Quality), simpleStarCell.lightPart)
	end

	self.breachStarCom:UpdateView(CfgItemTable[self.SkillData.itemCid].Quality, CfgItemTable[self.SkillData.itemCid].Quality)
	LuaUtility.SetGameObjectShow(self.LockImg, self.SkillData.lock)
	LuaUtility.SetGameObjectShow(self.UnLockImg, not self.SkillData.lock)

	local upgradExp = self.SkillData.skillCfgsByLv[self.SkillData.lv].UpgradeNeedExp[1]

	if upgradExp == nil then
		upgradExp = 1
	end

	self.CurExpSliderComponent.fillAmount = self.SkillData.exp / upgradExp
	self.isMax = self.SkillData.skillCfgsByLv[self.SkillData.lv].UpgradeNeedExp == nil
	self.NeedExp = self.SkillData.skillCfgByLv.UpgradeNeedExp[1]
	self.MaxExp = self.SkillData:GetSkillMaxExp()
	self.SkillCurLv = self.SkillData.lv
	self.ItemTable, self.SkillTable = RoleDevelopmentModule.GetAllSKillOrItems(self.SkillData.id)

	self:RefreshSkillItem()
	self:GetSkillCondition()
	self:DynamicRefreshShowInfo(0)

	self.isCanBreach = false
	self.heroLvIsAchieve = false

	if not isMaxStrength then
		self.isCanBreach = self.SkillData.lv >= self.SkillData.skillCfgsByStrengLv[self.SkillData.strengLv + 1].NeedSkillLv
		self.heroLvIsAchieve = PlayerModule.PlayerInfo.baseInfo.pLv >= self.SkillData.skillCfgsByStrengLv[self.SkillData.strengLv + 1].NeedLv
	end

	LuaUtility.SetGameObjectShow(self.BreachBtn, self.isCanBreach)
	LuaUtility.SetGameObjectShow(self.StrengthBtn, not self.isCanBreach and not self.SkillData:IsMaxLv())
	LuaUtility.SetGameObjectShow(self.MaxBtn, not self.isCanBreach and isMaxStrength and self.SkillData:IsMaxLv())
	LuaUtility.SetGameObjectShow(self.Com_ConsumeGold, not self.isCanBreach and not self.SkillData:IsMaxLv())
end

function SkillStrengthenUI:RefreshSkillAttr(previewLv)
	local baseSubAttrs = self.SkillData:GetSkillAttr(self.SkillCurLv)
	local newAddSubAttrs = self.SkillData:GetSkillAttr(previewLv)

	for i = 1, #newAddSubAttrs do
		local attrItemObj = self:CreateAttrItem(i)

		UGUIUtil.SetText(attrItemObj.AttrTypeText, CfgAttributeTable[newAddSubAttrs[i].attrType].Name)
		UGUIUtil.SetText(attrItemObj.AttrValue, baseSubAttrs[i].attrValue == nil and 0 or baseSubAttrs[i].attrValue)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgAttributeTable[newAddSubAttrs[i].attrType].ImageUrl), attrItemObj.AttrImg:GetComponent("Image"))

		if previewLv > self.SkillData.lv then
			if newAddSubAttrs[i].attrValue ~= baseSubAttrs[i].attrValue then
				UGUIUtil.SetText(attrItemObj.AttrValue, RoleDevelopmentApi:GetSkillTextColorStr(1, newAddSubAttrs[i].attrValue))
			else
				UGUIUtil.SetText(attrItemObj.AttrValue, RoleDevelopmentApi:GetSkillTextColorStr(3, newAddSubAttrs[i].attrValue))
			end
		else
			UGUIUtil.SetText(attrItemObj.AttrValue, RoleDevelopmentApi:GetSkillTextColorStr(3, baseSubAttrs[i].attrValue))
		end
	end

	for i = 1, #self.AttrItems do
		self.AttrItems[i].View:SetActive(i <= #newAddSubAttrs)
	end
end

function SkillStrengthenUI:CreateAttrItem(index)
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

function SkillStrengthenUI:RefreshSkillItem()
	self.CurSelectMaterialItems = {}
	self.SelectUpgradeItems = {}
	self.tempScrollItems = {}

	self:SortSkillItem()
	self.wrapContent:Refresh(#self.AllSkillItemDatas)
	self.NoneSkillItem:SetActive(#self.AllSkillItemDatas <= 0)
end

function SkillStrengthenUI:OnRenderItem(cell)
	local ItemData = self.AllSkillItemDatas[cell.index + 1]
	local instanID = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemCellList[instanID]

	if itemCell == nil then
		itemCell = SelectItemCell.New(cell.gameObject)
		self.ItemCellList[instanID] = itemCell
	end

	itemCell:SetItem(ItemData, self:IsSelectedSkill(ItemData.id))

	self.tempScrollItems[cell.index + 1] = itemCell
end

function SkillStrengthenUI:IsSelectedSkill(skillId)
	for k, v in pairs(self.SelectUpgradeItems) do
		if k == skillId then
			return true
		end
	end

	return false
end

function SkillStrengthenUI:OnRenderEndItem()
	if self.isQuickSelect then
		self:OnQucikSelectItem()

		self.isQuickSelect = false
	end
end

function SkillStrengthenUI:SortSkillItem()
	if self.CurDropDownType == 1 then
		table.sort(self.SkillTable, function(a, b)
			if a:GetCfg().Quality == b:GetCfg().Quality then
				if a.skillData.lv == b.skillData.lv then
					if a.skillData.strengLv == b.skillData.strengLv then
						return a.skillData.heroCid > b.skillData.heroCid
					end

					return a.skillData.strengLv > b.skillData.strengLv
				end

				return a.skillData.lv > b.skillData.lv
			end

			return a:GetCfg().Quality > b:GetCfg().Quality
		end)
	elseif self.CurDropDownType == 2 then
		table.sort(self.SkillTable, function(a, b)
			if a.skillData.lv == b.skillData.lv then
				return a:GetCfg().Quality > b:GetCfg().Quality
			end

			return a.skillData.lv > b.skillData.lv
		end)
	end

	if self.CurScreenClickCount == 2 then
		table.reverse(self.SkillTable)
	end

	self.AllSkillItemDatas = {}

	table.addAll(self.AllSkillItemDatas, self.ItemTable)
	table.addAll(self.AllSkillItemDatas, self.SkillTable)
end

function SkillStrengthenUI:OnDropDownCallBack(index)
	self.CurDropDownType = index

	self:RefreshSkillItem()
	self:DynamicRefreshShowInfo(0)
end

function SkillStrengthenUI:OnScreenCallBack(count)
	self.CurScreenClickCount = count

	self:RefreshSkillItem()
	self:DynamicRefreshShowInfo(0)
end

function SkillStrengthenUI:GetCurSkillExp(lv)
	local exp = 0

	for i = 1, #self.SkillData.skillCfgsByLv do
		if i < lv then
			exp = exp + self.SkillData.skillCfgsByLv[i].UpgradeNeedExp[1]
		else
			break
		end
	end

	return exp
end

function SkillStrengthenUI:SelectMaterialCallback(data)
	for k, v in pairs(data) do
		if v[1] <= 0 then
			self.CurSelectMaterialItems[k] = nil
			self.SelectUpgradeItems[k] = nil
		else
			self.CurSelectMaterialItems[k] = v
			self.SelectUpgradeItems[k] = v[1]
		end
	end

	self:RefreshSelectAllExp()
end

function SkillStrengthenUI:RefreshSelectAllExp()
	local allExp = 0

	for k, v in pairs(self.CurSelectMaterialItems) do
		allExp = allExp + v[2]
	end

	self.UpgradeNeedMoney = allExp * CfgDiscreteDataTable[2].Data[1] / 100

	self.consumeGoldCell:SetData(self.UpgradeNeedMoney)
	self:DynamicRefreshShowInfo(allExp)
	LuaUtility.SetGameObjectShow(self.ClearAllBtn, allExp > 0)
end

function SkillStrengthenUI:DynamicRefreshShowInfo(exp)
	self.consumeGoldCell:SetData(self.UpgradeNeedMoney)

	local previewLv = self.SkillData:GetPreviewLv(self.curAllExp + exp)
	local previewExp = self.curAllExp + exp - self:GetCurSkillExp(previewLv)
	local upgradExp = self.SkillData.skillCfgsByLv[previewLv].UpgradeNeedExp[1]

	if upgradExp == nil then
		upgradExp = 1
	end

	self.curSelectAllExp = exp

	local fillAmount = previewExp / upgradExp

	self.previewImg.fillAmount = fillAmount

	if previewLv > self.SkillData.lv then
		UGUIUtil.SetText(self.PresentLevelText, RoleDevelopmentApi:GetSkillTextColorStr(2, previewLv))
	else
		UGUIUtil.SetText(self.PresentLevelText, RoleDevelopmentApi:GetSkillTextColorStr(3, previewLv))
	end

	UGUIUtil.SetText(self.CurExpText, previewExp)
	UGUIUtil.SetText(self.NextExpText, self.SkillData.skillCfgsByLv[previewLv].UpgradeNeedExp[1])
	UGUIUtil.SetText(self.CurSkillDescInfo, self.SkillData.skillCfgsByLv[previewLv].SkillTips)

	RoleDevelopmentModule.IsCanUpgradeSkill = self.SkillData.exp + exp + self.SkillData:GetCurSkillExp() >= self.MaxExp

	self:RefreshSkillAttr(previewLv)
end

function SkillStrengthenUI:GetSkillCondition()
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

function SkillStrengthenUI:SetConditionItem()
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

function SkillStrengthenUI:CreateElementConditionItem(index)
	local obj = self.ConditionObjList[index]

	if obj == nil then
		obj = UnityEngine.Object.Instantiate(self.LimitItem)

		obj.transform:SetParent(self.LimitContent.transform, false)

		self.ConditionObjList[index] = obj
	end

	return obj
end

function SkillStrengthenUI:GetDictText(groupID, id)
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

function SkillStrengthenUI:SkillUpgradeSucess()
	self:SetSkillInfo(self.SkillData.id)
	NoticeModule._ShowStrengthEffectNotcie(Constant.StrengthType.SkillUpgrade)
end

function SkillStrengthenUI:OnQuickAddBtnClick()
	if RoleDevelopmentModule.IsCanUpgradeSkill then
		NoticeModule.ShowNotice(20005)

		return
	end

	if table.len(self.AllSkillItemDatas) <= 0 then
		NoticeModule.ShowNotice(20003)

		return
	end

	self.CurSelectMaterialItems = {}
	self.SelectUpgradeItems = {}
	self.tempScrollItems = {}
	self.isQuickSelect = true

	self.wrapContent:Refresh(#self.AllSkillItemDatas)
end

function SkillStrengthenUI:OnQucikSelectItem()
	for i = 1, #self.tempScrollItems do
		if self.tempScrollItems[i].Quality == 3 or self.tempScrollItems[i].Quality == 2 then
			if RoleDevelopmentModule.IsCanUpgradeSkill then
				return
			elseif self.tempScrollItems[i].isSkillItem then
				self.tempScrollItems[i]:SelectItemClick()
			else
				while RoleDevelopmentModule.IsCanUpgradeSkill == false and self.tempScrollItems[i]:IsMaxSelect() == false do
					self.tempScrollItems[i]:SelectItemClick()
				end
			end
		end
	end

	local selectCount = 0

	for i = 1, #self.tempScrollItems do
		selectCount = selectCount + self.tempScrollItems[i].SelectCount
	end

	if selectCount == 0 then
		NoticeModule.ShowNotice(51021)
	end
end

function SkillStrengthenUI:StrengthBtnClick()
	if table.len(self.SelectUpgradeItems) <= 0 then
		NoticeModule.ShowNotice(45012)

		return
	end

	if self.UpgradeNeedMoney > WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD) then
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)

		return
	end

	local isHasBreachSkill = false
	local isHighLvSkill = false

	for k, v in pairs(self.SelectUpgradeItems) do
		local itemData = WarehouseModule.FindItem(k)

		if itemData:GetCfg().ItemTypes == Constant.ItemType.Skill and itemData.skillData.strengLv >= 1 then
			isHasBreachSkill = true

			break
		end
	end

	for k, v in pairs(self.SelectUpgradeItems) do
		local itemData = WarehouseModule.FindItem(k)

		if itemData:GetCfg().ItemTypes == Constant.ItemType.Skill and itemData:GetCfg().Quality >= 5 then
			isHighLvSkill = true

			break
		end
	end

	if isHighLvSkill or isHasBreachSkill then
		NoticeModule.ShowNotice(45008, function()
			self:JudgeIsExceedMaxExp()
		end)
	else
		self:JudgeIsExceedMaxExp()
	end
end

function SkillStrengthenUI:JudgeIsExceedMaxExp()
	local needExp = self.SkillData:GetSkillMaxExp()
	local TempSelectAllExp = self.curSelectAllExp + self.curAllExp

	if needExp < TempSelectAllExp then
		local tips = EquipApi:IntensifyOverFlow(TempSelectAllExp - needExp)

		NoticeModule.ShowNoticeByType(5, tips, function()
			RoleDevelopmentModule.RoleSkillUpgrade(self.SkillData.id, self.SelectUpgradeItems)
		end)
	else
		RoleDevelopmentModule.RoleSkillUpgrade(self.SkillData.id, self.SelectUpgradeItems)
	end
end

function SkillStrengthenUI:OnClickClearAllBtn()
	for i = 1, #self.tempScrollItems do
		self.tempScrollItems[i]:ClearSelect()
	end

	self.SelectUpgradeItems = {}
	self.CurSelectMaterialItems = {}

	self:RefreshSelectAllExp()
end

function SkillStrengthenUI:OnClickBreachBtn()
	if not self.heroLvIsAchieve then
		NoticeModule.ShowNotice(44002)

		return
	end

	UIModule.Open(Constant.UIControllerName.SkillBreachUI, Constant.UILayer.UI, self.SkillData.id)
end

function SkillStrengthenUI:BreachSucessCallback()
	self:SetSkillInfo(self.SkillData.id)
end

function SkillStrengthenUI:LoadImg(path, imgObj)
	AssetUtil.LoadImage(self, path, imgObj:GetComponent("Image"))
end

return SkillStrengthenUI
