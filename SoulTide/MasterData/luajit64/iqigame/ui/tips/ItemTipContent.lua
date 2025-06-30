-- chunkname: @IQIGame\\UI\\Tips\\ItemTipContent.lua

local ItemTipContent = {
	lastSortIndex = 30,
	hideSource = false,
	tfUseCostPool = {},
	sourceCellPool = {},
	sourceBtnPool = {}
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
	self.tfUseEffect = self.goUseEffect:GetComponent("Text")
	self.tfUseArea = self.goUseArea:GetComponent("Text")
	self.tfUseCondition = self.goUseCondition:GetComponent("Text")
	self.tfUseTime = self.goUseTime:GetComponent("Text")
	self.tfCD = self.goCD:GetComponent("Text")
	self.tfUseCost = self.goUseCost:GetComponent("Text")

	self.goCell:SetActive(false)

	self.goUseEffectTitle:GetComponent("Text").text = ItemTipsApi:GetString("goUseEffectTitle")
	self.goUseAreaTitle:GetComponent("Text").text = ItemTipsApi:GetString("goUseAreaTitle")
	self.goUseConditionTitle:GetComponent("Text").text = ItemTipsApi:GetString("goUseConditionTitle")
	self.goUseTimeTitle:GetComponent("Text").text = ItemTipsApi:GetString("goUseTimeTitle")
	self.goCDTitle:GetComponent("Text").text = ItemTipsApi:GetString("goCDTitle")
	self.goUseCostTitle:GetComponent("Text").text = ItemTipsApi:GetString("goUseCostTitle")
	self.goSourceTitle:GetComponent("Text").text = ItemTipsApi:GetString("goSourceTitle")
	self.tfUseCostPool[1] = self.goUseCost:GetComponent("Text")
end

function ItemTipContent:RefreshView(itemData, mainView, hideSource)
	self.itemData = itemData
	self.mainView = mainView
	self.hideSource = hideSource

	self:RefreshDatum()
	self:RefreshMisc()
	self:RefreshUseEffect()
	self:RefreshUseArea()
	self:RefreshUseCondition()
	self:RefreshUseTime()
	self:RefreshCD()
	self:RefreshUseCost()
	self:RefreshSource()
end

function ItemTipContent:OnDestroy()
	for i, v in pairs(self.sourceBtnPool) do
		if v ~= nil and v.onClick ~= nil then
			v.onClick:RemoveListener(self["onClickBtnSourceDelegate" .. i])
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

function ItemTipContent:RefreshUseEffect()
	local effectIDs = {}

	for i, v in ipairs(self.cfgItemData.EffectTypeID) do
		if v ~= 0 then
			effectIDs[#effectIDs + 1] = v
		end
	end

	local isDataOk = #effectIDs ~= 0 and self.cfgItemData.Type ~= 5 and self.cfgItemData.UseArea ~= Constant.Item.USE_AREA_NONE and self.cfgItemData.UseArea ~= Constant.Item.USE_AREA_LEAVE_MAZE

	self.goUseEffectTitle:SetActive(isDataOk)
	self.goUseEffect.transform.parent.gameObject:SetActive(isDataOk)

	if isDataOk then
		self.tfUseEffect.text = ItemTipsApi:GetString("goUseEffect", self.cfgItemData.EffectTxt)

		self:SetSiblingIndex(self.goUseEffectTitle.transform)
		self:SetSiblingIndex(self.goUseEffect.transform.parent)
	end
end

local areaText = {
	"不可使用",
	"主城",
	"迷宫使用",
	"离开迷宫自动使用"
}

function ItemTipContent:GetUseAreaText(data)
	if data.UseArea == 1 or data.UseArea == 2 then
		return areaText[data.UseArea + 1]
	end

	return ""
end

function ItemTipContent:RefreshUseArea()
	local isDataOk = false

	self.goUseAreaTitle:SetActive(isDataOk)
	self.goUseArea.transform.parent.gameObject:SetActive(isDataOk)

	if isDataOk then
		self.tfUseArea.text = ItemTipsApi:GetString("goUseArea", self:GetUseAreaText(self.cfgItemData))

		self:SetSiblingIndex(self.goUseAreaTitle.transform)
		self:SetSiblingIndex(self.goUseArea.transform.parent)
	end
end

function ItemTipContent:RefreshUseCondition()
	local isDataOk = self.cfgItemData.UseConditionID ~= 0

	self.goUseConditionTitle:SetActive(isDataOk)
	self.goUseCondition.transform.parent.gameObject:SetActive(isDataOk)

	if isDataOk then
		self.tfUseCondition.text = ItemTipsApi:GetString("goUseCondition", CfgConditionTable[self.cfgItemData.UseConditionID].Name)

		self:SetSiblingIndex(self.goUseConditionTitle.transform)
		self:SetSiblingIndex(self.goUseCondition.transform.parent)
	end
end

function ItemTipContent:RefreshUseTime()
	local expirationTime = cfgDateTimeToTimeStamp(self.cfgItemData.ExpirationTime, PlayerModule.TimeZone)
	local startTime = cfgDateTimeToTimeStamp(self.cfgItemData.StartTime, PlayerModule.TimeZone)
	local isDataOk = self.cfgItemData.EffectiveDuration ~= 0 or startTime ~= 0 and startTime > PlayerModule.GetServerTime() or expirationTime ~= 0

	self.goUseTimeTitle:SetActive(isDataOk)
	self.goUseTime.transform.parent.gameObject:SetActive(isDataOk)

	if isDataOk then
		self.tfUseTime.text = ItemTipsApi:GetString("goUseTime", self.ItemData.GetAvailableTimeText(self.cfgItemData))

		self:SetSiblingIndex(self.goUseTimeTitle.transform)
		self:SetSiblingIndex(self.goUseTime.transform.parent)
	end
end

function ItemTipContent:RefreshCD()
	local cd = self.itemData:GetCD()
	local isDataOk = cd > 0

	self.goCDTitle:SetActive(isDataOk)
	self.goCD.transform.parent.gameObject:SetActive(isDataOk)

	if isDataOk then
		self.tfCD.text = ItemTipsApi:GetString("goCD", getTimeDurationText(cd))

		self:SetSiblingIndex(self.goCDTitle.transform)
		self:SetSiblingIndex(self.goCD.transform.parent)
	end
end

function ItemTipContent:RefreshUseCost()
	local ids = {}
	local numbers = {}
	local isDataOk = #ids > 0

	self.goUseCostTitle:SetActive(isDataOk)

	for i, v in ipairs(self.tfUseCostPool) do
		v.gameObject.transform.parent.gameObject:SetActive(i <= #ids)
	end

	if isDataOk then
		for i, v in ipairs(ids) do
			local name = CfgItemTable[v].Name
			local num = numbers[i]
			local tfComp = self:GetUseCostText(i)

			tfComp.text = ItemTipsApi:GetString("goUseCost", name, num)
		end

		self:SetSiblingIndex(self.goUseCostTitle.transform)

		for i, v in ipairs(self.tfUseCostPool) do
			self:SetSiblingIndex(v.transform.parent)
		end
	end
end

function ItemTipContent:RefreshSource()
	self.goSourceTitle:SetActive(#self.cfgItemData.Source > 0 and not self.hideSource)

	for i, v in ipairs(self.sourceCellPool) do
		v:SetActive(i <= #self.cfgItemData.Source and not self.hideSource)
	end

	if self.hideSource then
		return
	end

	for i, v in ipairs(self.cfgItemData.Source) do
		local cfgFuncData = CfgFunctionTable[v]
		local go = self:GetSourceCell(i)

		go.transform:Find("Text"):GetComponent("Text").text = ItemTipsApi:GetString("goSource", cfgFuncData.Name)
	end

	self:SetSiblingIndex(self.goSourceTitle.transform)

	for i, v in ipairs(self.sourceCellPool) do
		self:SetSiblingIndex(v.transform)
	end
end

function ItemTipContent:GetSourceCell(index)
	local ret = self.sourceCellPool[index]

	if ret == nil then
		self["onClickBtnSourceDelegate" .. index] = function()
			self:OnClickBtnSource(index)
		end
		ret = UnityEngine.Object.Instantiate(self.goCell)
		self.sourceBtnPool[index] = ret:GetComponentInChildren(typeof(UnityEngine.UI.Button))

		self.sourceBtnPool[index].onClick:AddListener(self["onClickBtnSourceDelegate" .. index])

		self.sourceCellPool[index] = ret
		self.sourceBtnPool[index].transform:Find("Text"):GetComponent("Text").text = ItemTipsApi:GetString("goJumpBtnTxt")

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

function ItemTipContent:OnClickBtnSource(index)
	if PlayerModule.InMaze then
		NoticeModule.ShowNoticeNoCallback(21045001)

		return
	end

	local cfgFuncData = CfgFunctionTable[self.cfgItemData.Source[index]]

	if cfgFuncData ~= nil and PlayerModule.CurrSceneID == SceneID.Home and cfgFuncData.SceneType == SceneID.Home then
		NoticeModule.ShowNoticeNoCallback(21045008)

		return
	end

	if cfgFuncData ~= nil then
		UIModule.Close(Constant.UIControllerName.ItemTipsUI)
		UIModule.Close(Constant.UIControllerName.MazeDetailUI)
		JumpModule.Jump(cfgFuncData.Id)
	end
end

return ItemTipContent
