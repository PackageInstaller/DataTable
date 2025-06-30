-- chunkname: @IQIGame\\UI\\Tips\\ItemTipContent.lua

local ItemTipContent = {
	lastSortIndex = 30,
	hideSource = false,
	tfUseCostPool = {},
	sourceCellPool = {},
	sourceBtnPool = {},
	skillConditionPool = {}
}

function ItemTipContent.New(go)
	local o = Clone(ItemTipContent)

	o:Initialize(go)

	return o
end

function ItemTipContent:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(self.View, self)

	self.trfParent = go.transform
	self.rectTrfParent = go:GetComponent("RectTransform")
	self.tfUseTime = self.goUseTime:GetComponent("Text")

	self.goCell:SetActive(false)

	function self.onClickBtnSourceDelegate()
		self:OnClickBtnSource()
	end

	self.goItemDescTitle:GetComponent("Text").text = ItemTipsApi:GetDescTitle()
	self.goSkillTitle:GetComponent("Text").text = ItemTipsApi:GetSkillTitle()
	self.goSourceTitle:GetComponent("Text").text = ItemTipsApi:GetSourceTitle()
	self.goEquipTitle:GetComponent("Text").text = ItemTipsApi:GetEquipTitle()
end

function ItemTipContent:RefreshView(itemData, mainView, hideSource)
	self.itemData = itemData
	self.mainView = mainView
	self.hideSource = hideSource

	self:RefreshDatum()
	self:RefreshMisc()
	self:RefreshUseTime()
	self:SetItemDesc()
	self:SetSkillCondition()
	self:SetEquipSuit()
	self:RefreshSource()
end

function ItemTipContent:OnDestroy()
	for i, v in pairs(self.sourceBtnPool) do
		if v ~= nil and v.onClick ~= nil then
			v.onClick:RemoveListener(self.onClickBtnSourceDelegate)
		end
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.mainView = nil
end

function ItemTipContent:RefreshDatum()
	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, 1)
	end

	self.cfgItemData = self.itemData:GetCfg()
	self.lastSortIndex = 30
end

function ItemTipContent:RefreshMisc()
	self.rectTrfParent.anchoredPosition3D = Vector3.New(0, 0, 0)
end

function ItemTipContent:SetItemDesc()
	local isDataOk = self.cfgItemData.ItemTips ~= "" and self.cfgItemData.ItemTips ~= nil

	self.goItemDesc.transform.parent.gameObject:SetActive(isDataOk)
	self.goItemDescTitle.transform.parent.gameObject:SetActive(isDataOk)

	if isDataOk then
		self.goItemDesc:GetComponent("Text").text = ItemTipsApi:GetDesc(self.cfgItemData.ItemTips)

		self:SetSiblingIndex(self.goItemDescTitle.transform.parent)
		self:SetSiblingIndex(self.goItemDesc.transform.parent)
	end
end

function ItemTipContent:SetSkillCondition()
	local isDataOk = self.itemData.skillData ~= nil and self.itemData.skillData ~= {}

	self.goSkillTitle.transform.parent.gameObject:SetActive(isDataOk)
	self.goSkillCondition.transform.parent.gameObject:SetActive(isDataOk)

	if not isDataOk then
		return
	end

	local conditionCfg = self.itemData.skillData:GetCfg()
	local dataCount = 0
	local condtionData = {}

	condtionData[Constant.SkillConditionType.PROFRESSION] = {}
	condtionData[Constant.SkillConditionType.ELEMENT] = {}
	condtionData[Constant.SkillConditionType.POWER] = {}

	for i = 1, #conditionCfg.ProfessionLimit do
		if conditionCfg.ProfessionLimit[i] ~= 0 then
			table.insert(condtionData[Constant.SkillConditionType.PROFRESSION], conditionCfg.ProfessionLimit[i])

			dataCount = dataCount + 1
		end
	end

	for i = 1, #conditionCfg.ElementLimit do
		if conditionCfg.ElementLimit[i] ~= 0 then
			table.insert(condtionData[Constant.SkillConditionType.ELEMENT], conditionCfg.ElementLimit[i])

			dataCount = dataCount + 1
		end
	end

	for i = 1, #conditionCfg.ForceLimit do
		if conditionCfg.ForceLimit[i] ~= 0 then
			table.insert(condtionData[Constant.SkillConditionType.POWER], conditionCfg.ForceLimit[i])

			dataCount = dataCount + 1
		end
	end

	isDataOk = dataCount ~= 0

	self.goSkillTitle.transform.parent.gameObject:SetActive(isDataOk)
	self.goSkillCondition.transform.parent.gameObject:SetActive(isDataOk)

	if not isDataOk then
		return
	end

	local length = 0

	for i = 1, #condtionData do
		for j = 1, #condtionData[i] do
			length = length + 1

			local ret = self.skillConditionPool[length]

			if ret == nil then
				ret = UnityEngine.Object.Instantiate(self.goConditionCell)
				self.skillConditionPool[length] = ret

				ret.transform:SetParent(self.goSkillCondition.transform, false)
			end

			local title = self:GetDictText(i, condtionData[i][j])

			UGUIUtil.SetTextInChildren(ret, title)
			ret:SetActive(true)
		end
	end

	self:SetSiblingIndex(self.goSkillTitle.transform.parent)
	self:SetSiblingIndex(self.goSkillCondition.transform.parent)
end

function ItemTipContent:GetDictText(groupID, id)
	if groupID == 1 then
		groupID = 7
	elseif groupID == 2 then
		groupID = 8
	elseif groupID == 3 then
		groupID = 9
	end

	local text

	for k, v in pairsCfg(CfgDictTable) do
		if v.GroupId == groupID and v.TypeId == id then
			text = ItemTipsApi:GetItemIipsDesc(v.TipsId)

			return text
		end
	end
end

function ItemTipContent:SetEquipSuit()
	local isDataOk = self.itemData.equipData ~= nil and self.itemData.equipData ~= {}

	self.goEquipTitle.transform.parent.gameObject:SetActive(isDataOk)
	self.goEuqipSuit1.transform.parent.gameObject:SetActive(isDataOk)
	self.goEuqipSuit2.transform.parent.gameObject:SetActive(isDataOk)

	if not isDataOk then
		return
	end

	local equipSuitData = EquipModule.GetSuitNeedCount(self.itemData.equipData:GetEquipCfg().SuitId, 1)

	isDataOk = #equipSuitData > 0

	self.goEquipTitle.transform.parent.gameObject:SetActive(isDataOk)
	self.goEuqipSuit1.transform.parent.gameObject:SetActive(isDataOk)
	self.goEuqipSuit2.transform.parent.gameObject:SetActive(isDataOk)

	if not isDataOk then
		return
	end

	UGUIUtil.SetText(self.goEuqipSuit1, ItemTipsApi:GetEquipDesc(equipSuitData[1].EquipTips, 2))
	UGUIUtil.SetText(self.goEuqipSuit2, ItemTipsApi:GetEquipDesc(equipSuitData[2].EquipTips, 4))
	self:SetSiblingIndex(self.goEquipTitle.transform.parent)
	self:SetSiblingIndex(self.goEuqipSuit1.transform.parent)
	self:SetSiblingIndex(self.goEuqipSuit2.transform.parent)
end

function ItemTipContent:RefreshUseTime()
	local isDataOk = self.cfgItemData.EffectiveDuration ~= 0 or self.itemData:ConversionTime(self.cfgItemData.StartTime) ~= 0 and self.itemData:ConversionTime(self.cfgItemData.StartTime) > PlayerModule.GetServerTime() or self.itemData:ConversionTime(self.cfgItemData.ExpirationTime) ~= 0

	self.goUseTime.transform.parent.parent.gameObject:SetActive(isDataOk)

	if isDataOk then
		self.tfUseTime.text = ItemTipsApi:GetUseTime(self.itemData:GetAvailableTimeText(self.cfgItemData))

		self:SetSiblingIndex(self.goUseTime.transform.parent.parent)
	end
end

function ItemTipContent:RefreshSource()
	if self.cfgItemData.Source == nil or #self.cfgItemData.Source <= 0 or self.hideSource then
		self.goSourceTitle.transform.parent.gameObject:SetActive(false)

		for i, v in ipairs(self.sourceCellPool) do
			v:SetActive(false)
		end

		return
	end

	self.goSourceTitle.transform.parent.gameObject:SetActive(#self.cfgItemData.Source > 0 and not self.hideSource)

	for i, v in ipairs(self.sourceCellPool) do
		v:SetActive(i <= #self.cfgItemData.Source and not self.hideSource)
	end

	if self.hideSource then
		return
	end

	for i, v in ipairs(self.cfgItemData.Source) do
		local cfgFuncData = CfgFunctionTable[v]
		local go = self:GetSourceCell(i)

		go.transform:Find("Text"):GetComponent("Text").text = ItemTipsApi:GetSource(cfgFuncData.Name)
	end

	self:SetSiblingIndex(self.goSourceTitle.transform.parent)

	for i, v in ipairs(self.sourceCellPool) do
		self:SetSiblingIndex(v.transform)
	end
end

function ItemTipContent:GetSourceCell(index)
	local ret = self.sourceCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goCell)
		self.sourceBtnPool[index] = ret:GetComponentInChildren(typeof(UnityEngine.UI.Button))

		self.sourceBtnPool[index].onClick:AddListener(self.onClickBtnSourceDelegate)

		self.sourceCellPool[index] = ret

		ret.transform:SetParent(self.goCell.transform.parent, false)
	end

	ret:SetActive(true)

	ret:GetComponentInChildren(typeof(UnityEngine.UI.Button)).gameObject.name = index

	return ret
end

function ItemTipContent:GetUseCostText(index)
	local ret = self.tfUseCostPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goUseCost):GetComponent("Text")
		self.tfUseCostPool[index] = ret

		ret.transform:SetParent(self.trfParent, false)
	end

	return ret
end

function ItemTipContent:SetSiblingIndex(transform)
	self.lastSortIndex = self.lastSortIndex + 1

	transform:SetSiblingIndex(self.lastSortIndex)
end

function ItemTipContent:OnClickBtnSource()
	if self.mainView.UIController:GetCurrentTarget() == nil then
		return
	end

	local index = tonumber(self.mainView.UIController:GetCurrentTarget().name)
	local cfgFuncData = CfgFunctionTable[self.cfgItemData.Source[index]]

	if cfgFuncData ~= nil and PlayerModule.CurrSceneID == SceneID.Home and cfgFuncData.SceneType == SceneID.Home then
		NoticeModule.ShowNoticeNoCallback(21045008)

		return
	end

	if cfgFuncData ~= nil then
		UIModule.Close(Constant.UIControllerName.ItemTipsUI)
		JumpModule.Jump(cfgFuncData.Id)
	end
end

return ItemTipContent
