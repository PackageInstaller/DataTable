-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\SubPanel\\BaseSkillInfoPanel.lua

local UpgradeMaterialItem = {}

function UpgradeMaterialItem.New(view)
	local obj = Clone(UpgradeMaterialItem)

	obj:__Init(view)

	return obj
end

function UpgradeMaterialItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnUpdateItem()
		self:__OnUpdateItem()
	end

	self.commonSlot = ItemCell.New(self.commonSlotCell)

	self:AddListeners()
end

function UpgradeMaterialItem:AddListeners()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
end

function UpgradeMaterialItem:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
end

function UpgradeMaterialItem:SetData(Data)
	self.Data = Data

	self.commonSlot:SetItem(self.Data)

	local hasNum = WarehouseModule.GetItemNumByCfgID(self.Data.cid)

	self.commonSlot:SetCustomNum(self.Data.num, hasNum)
end

function UpgradeMaterialItem:__OnUpdateItem()
	if self.Data == nil then
		return
	end

	self:SetData(self.Data)
end

function UpgradeMaterialItem:Show()
	self.gameObject:SetActive(true)
end

function UpgradeMaterialItem:Hide()
	self.gameObject:SetActive(false)
end

function UpgradeMaterialItem:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkillItem = {}

function SkillItem.New(view, clickHandler)
	local obj = Clone(SkillItem)

	obj:__Init(view, clickHandler)

	return obj
end

function SkillItem:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnClickSkillItem()
		self:Select()
	end

	self:AddListeners()
end

function SkillItem:AddListeners()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickSkillItem)
end

function SkillItem:RemoveListeners()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickSkillItem)
end

function SkillItem:SetData(skillType, skillData)
	self.skillType = skillType
	self.skillData = skillData

	local skillCfg = CfgUtil.GetCfgSkillDataWithID(self.skillData.skillCid)

	LuaUtility.SetText(self.SkillLvText, string.format("%s", self.skillData.lv + self.skillData.extLv))
	LuaUtility.SetText(self.skillTypeText, RoleDevelopmentApi:GetSkillType(skillCfg.SkillType))
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(skillCfg.Icon), self.SkillIcon:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.lvUpParent, false)
end

function SkillItem:ShowLvUpinfo(oldSkillPod, skillpod, isUp)
	if isUp then
		UGUIUtil.SetText(self.upLvText, "+" .. skillpod.lv - oldSkillPod.lv)
		LuaUtility.SetGameObjectShow(self.lvUpParent, true)
		self:StopTimer()

		self.lvUpTimer = Timer.New(function()
			LuaUtility.SetGameObjectShow(self.lvUpParent, false)
		end, 1.5):Start()
	else
		LuaUtility.SetGameObjectShow(self.lvUpParent, false)
	end
end

function SkillItem:StopTimer()
	if self.lvUpTimer then
		self.lvUpTimer:Stop()

		self.lvUpTimer = nil
	end
end

function SkillItem:Select()
	if self.clickHandler ~= nil then
		self.clickHandler(self.skillType)
	end

	LuaUtility.SetGameObjectShow(self.selectImg, true)
end

function SkillItem:UnSelect()
	LuaUtility.SetGameObjectShow(self.selectImg, false)
end

function SkillItem:Show()
	self.gameObject:SetActive(true)
end

function SkillItem:Hide()
	self.gameObject:SetActive(false)
end

function SkillItem:Dispose()
	self:StopTimer()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkillUpgradeItemViewClass = require("IQIGame.UI.RoleDevelopment.SkillUpgradeItemView")
local m = {
	isMaxDesc = false,
	SkillItemCellList = {},
	itemViewList = {}
}

m.PreviewEnum = {
	MaxLv = 2,
	NextLv = 1
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.buttonUpgradeDelegate()
		self:OnButtonUpgradeClick()
	end

	function self.DelegateSkillUpSucessEvent(oldSkillPod, skillpod, isUp)
		self:OnSkillUpgradeSucess(oldSkillPod, skillpod, isUp)
	end

	function self.delegateOnClickChangeContrastBtn()
		self:OnClickChangeContrastBtn()
	end

	ForTransformChild(self.skillItemRoot.transform, function(transform, index)
		self.SkillItemCellList[index + 1] = SkillItem.New(transform.gameObject, function(skillType)
			self:OnSkillItemSelect(skillType)
		end)
	end)

	self.itemScroll = self.itemScrollView:GetComponent("OptimizedScrollRect")

	self.itemScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateItemScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.consumeGoldCell = CommonConsumeGold.New(self.com_ConsumeGold, self)
	self.nextLvToggle:GetComponent("Toggle").isOn = false
	self.maxLvToggle:GetComponent("Toggle").isOn = false
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)

	self.moneyCell:RefreshItem(Constant.TopMoneyType.SkillStrengthenUI)
	self:AddListeners()
end

function m:AddListeners()
	self.upgradeBtn:GetComponent("Button").onClick:AddListener(self.buttonUpgradeDelegate)
	self.changeContrastBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickChangeContrastBtn)
end

function m:RemoveListeners()
	self.upgradeBtn:GetComponent("Button").onClick:AddListener(self.buttonUpgradeDelegate)
	self.changeContrastBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickChangeContrastBtn)
end

function m:SetData(roleCid)
	self.roleCid = roleCid
	self.SkillDataList = RoleDevelopmentModule.GetCurHeroSkill(roleCid)
	self.isMaxDesc = false

	self:UpdateToggleState()
	self:RefreshSkillItemInfo()
	self.SkillItemCellList[1]:Select()
end

function m:RefreshSkillItemInfo()
	for k, v in pairs(self.SkillItemCellList) do
		v:SetData(k, self.SkillDataList[k])
	end
end

function m:RefreshSkillLvUpInfo(oldSkillPod, skillpod, isUp)
	self.SkillItemCellList[oldSkillPod.heroPos]:ShowLvUpinfo(oldSkillPod, skillpod, isUp)
end

function m:RefreshSkillDetail(skillType)
	self.selectSkillType = skillType
	self.selectSkillData = self.SkillDataList[skillType]
	self.skillCfg = CfgUtil.GetCfgSkillDataWithID(self.selectSkillData.skillCid)
	self.skillMaxLevelCfg = CfgUtil.GetCfgSkillLevelDataByLevel(self.selectSkillData.skillCid, self.skillCfg.MaxStrengthenLevel)
	self.skillLevelCfg = CfgUtil.GetCfgSkillLevelDataWithID(self.selectSkillData.skillCid)
	self.skillNextLevelCfg = CfgUtil.GetCfgSkillLevelDataWithID(self.selectSkillData.skillCid, self.selectSkillData.lv + 1)

	UGUIUtil.SetText(self.lvText, self.selectSkillData.lv + self.selectSkillData.extLv)
	UGUIUtil.SetText(self.skillNameText, self.skillCfg.Name)

	local cd, energy, cost = CfgUtil.GetSkillCD_Eg_Ct(WarlockModule.WarlockDataDic[self.selectSkillData.heroCid], self.selectSkillData.skillCid, self.selectSkillData.lv + self.selectSkillData.extLv)

	UGUIUtil.SetText(self.costText, energy)
	LuaUtility.SetGameObjectShow(self.costParent, energy > 0)

	local currentNormalSkillLevelCfg = self.skillLevelCfg[self.selectSkillData.lv]
	local UpgradeNeedExp = currentNormalSkillLevelCfg.UpgradeNeedExp

	self:CreateSkillNeedData(self.skillLevelCfg[self.selectSkillData.lv])
	self.itemScroll:RefreshByItemCount(#self.skillNeedData)

	self.SkillLvIsMax = self.selectSkillData.lv >= self.skillCfg.MaxStrengthenLevel

	LuaUtility.SetGameObjectShow(self.itemScrollView, not self.SkillLvIsMax)

	if not self.SkillLvIsMax then
		self.isMoneyEnough = UpgradeNeedExp[#UpgradeNeedExp] <= WarehouseModule.GetPlayerGoldNum()

		self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)
		self.consumeGoldCell:SetData(UpgradeNeedExp[#UpgradeNeedExp])
	end

	self.isLvLimit = WarlockModule.WarlockDataDic[self.roleCid].lv < self.skillLevelCfg[self.selectSkillData.lv].NeedLv

	if self.isLvLimit then
		LuaUtility.SetText(self.limitText, RoleDevelopmentApi:GetSkillUpgradeLevelLimitText(self.skillLevelCfg[self.selectSkillData.lv].NeedLv))
	end

	local searchTargetData = self.selectSkillData:GetSearchTargetData()

	if searchTargetData ~= nil and not LuaUtility.StrIsNullOrEmpty(searchTargetData.SkillRangeImg) then
		LuaUtility.SetGameObjectShow(self.SkillRangeRoot, true)

		local path = UIGlobalApi.GetImagePath(searchTargetData.SkillRangeImg)

		AssetUtil.LoadImage(self, path, self.skillRangeImg:GetComponent("Image"))

		if searchTargetData.SelectCamp == 2 or searchTargetData.SelectCamp == 3 then
			self.SkillRangeText:GetComponent("Text").color = Color.New(0.5607843, 0.7725491, 0.3058824, 1)
		else
			self.SkillRangeText:GetComponent("Text").color = Color.New(0.9019608, 0.3254902, 0.2627451, 1)
		end
	else
		LuaUtility.SetGameObjectShow(self.SkillRangeRoot, false)
	end

	self:UpdateSkillDesc()
	self:UpdateBtnState()
end

function m:UpdateSkillDesc()
	local descText = ""

	if self.SkillLvIsMax then
		local lvCfg = self.skillLevelCfg[self.selectSkillData.lv]

		descText = UIGlobalApi.GetDescribeMatchTable(lvCfg.SkillTips, function(_index, _formatType)
			local str = UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, lvCfg.UpGradeOldValue[_index])

			return RoleDevelopmentApi:GetPromoteStrNotIncludNext(str)
		end)
	else
		local lvCfg
		local curLvCfg = self.skillLevelCfg[self.selectSkillData.lv]

		if self.isMaxDesc then
			lvCfg = self.skillLevelCfg[self.skillCfg.MaxStrengthenLevel]
		else
			lvCfg = self.skillLevelCfg[self.selectSkillData.lv + 1]
		end

		descText = UIGlobalApi.GetDescribeMatchTable(lvCfg.SkillTips, function(_index, _formatType)
			local curValue = curLvCfg.UpGradeOldValue[_index] ~= nil and curLvCfg.UpGradeOldValue[_index] or 0
			local nextValue = lvCfg.UpGradeOldValue[_index] ~= nil and lvCfg.UpGradeOldValue[_index] or 0
			local curValueStr = UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, curValue)
			local nextValueStr = UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, nextValue)

			if curValueStr == nextValueStr then
				return RoleDevelopmentApi:GetPromoteStrNotIncludNext(curValueStr)
			end

			return RoleDevelopmentApi:GetPromoteStr(curValueStr, nextValueStr)
		end)
	end

	UGUIUtil.SetText(self.skillDescText, descText)
end

function m:UpdateBtnState()
	LuaUtility.SetGameObjectShow(self.upgradeBtn, not self.SkillLvIsMax and not self.isLvLimit)
	LuaUtility.SetGameObjectShow(self.max, self.SkillLvIsMax)
	LuaUtility.SetGameObjectShow(self.com_ConsumeGold, not self.SkillLvIsMax)
	LuaUtility.SetGameObjectShow(self.upgradeLimitParent, self.isLvLimit and not self.SkillLvIsMax)
	LuaUtility.SetGameObjectShow(self.changePreviewParent, not self.SkillLvIsMax)
end

function m:UpdateItemScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.skillNeedData[index + 1]

	if not self.itemViewList[instanceID] then
		self.itemViewList[instanceID] = UpgradeMaterialItem.New(viewGameObject)
	end

	self.itemViewList[instanceID]:SetData(data)
end

function m:CreateSkillNeedData(currentSkillLevelCfg)
	self.skillNeedData = {}

	local m_ActionParam = Clone(currentSkillLevelCfg.UpgradeNeedExp)

	for _ = 1, 2 do
		table.remove(m_ActionParam)
	end

	self.skillNeedData = LuaUtility.ActionParamToItemDataTable(m_ActionParam)
end

function m:OnSkillItemSelect(skillType)
	for k, v in pairs(self.SkillItemCellList) do
		v:UnSelect()
	end

	self.isMaxDesc = false

	self:UpdateToggleState()
	self:RefreshSkillDetail(skillType)
end

function m:OnSkillUpgradeSucess(oldSkillPod, skillpod, isUp)
	self.SkillDataList = RoleDevelopmentModule.GetCurHeroSkill(self.roleCid)

	self:RefreshSkillItemInfo()
	self:RefreshSkillLvUpInfo(oldSkillPod, skillpod, isUp)
	self:RefreshSkillDetail(self.selectSkillType)
end

function m:OnButtonUpgradeClick()
	if self.isMoneyEnough then
		RoleDevelopmentModule.RoleSkillUpgrade(self.selectSkillData.id, {})
	else
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)
	end
end

function m:OnClickChangeContrastBtn()
	self.isMaxDesc = not self.isMaxDesc

	self:UpdateSkillDesc()
	self:UpdateToggleState()
end

function m:UpdateToggleState()
	self.nextLvToggle:GetComponent("Toggle").isOn = self.isMaxDesc
	self.maxLvToggle:GetComponent("Toggle").isOn = not self.isMaxDesc
end

function m:Show()
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	self:RemoveListeners()

	for k, v in pairs(self.SkillItemCellList) do
		v:Dispose()
	end

	for k, v in pairs(self.itemViewList) do
		v:Dispose()
	end

	self.moneyCell:Dispose()
	self.consumeGoldCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
