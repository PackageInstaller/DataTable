-- chunkname: @IQIGame\\UI\\RoleDevelopment\\PersonalitySystemView.lua

PersonalitySystemView = {
	MaskBg2IconPath = "",
	ItemCells = {
		Consume = {},
		ItemCellList = {}
	},
	PersonalityItemTable = {},
	PersonalityItemPos = {
		{
			size = Vector3.New(1, 1, 1),
			pos = Vector3.New(207.1, -301.6, 0)
		},
		{
			size = Vector3.New(0.5, 0.5, 1),
			pos = Vector3.New(404.2, -169, 0)
		},
		{
			size = Vector3.New(1, 1, 1),
			pos = Vector3.New(445.3, -345.6, 0)
		},
		{
			size = Vector3.New(0.6, 0.6, 1),
			pos = Vector3.New(636.4, -206.4, 0)
		},
		{
			size = Vector3.New(0.75, 0.75, 1),
			pos = Vector3.New(749.3, -337.4, 0)
		}
	},
	FillAmount = {
		0,
		0.532,
		0.67,
		0.42,
		0.532
	},
	MaskBg1IconPath = UIGlobalApi.ImagePath .. "/Personality/Personality_mask0",
	MaskBgIconList = {}
}

function PersonalitySystemView.New(go, UIController)
	local o = Clone(PersonalitySystemView)

	o:Initialize(go, UIController)

	return o
end

function PersonalitySystemView:Initialize(go, UIController)
	self.View = go
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.View, self)

	self._NameText = self.NameText:GetComponent("Text")
	self._NameSecondText = self.NameSecondText:GetComponent("Text")
	self._DescribeText = self.DescribeText:GetComponent("Text")
	self._NeedActiveText = self.NeedActiveText:GetComponent("Text")
	self.IndexIconIm = self.IndexIcon:GetComponent("Image")

	for i = 1, self.MaskBgRoot.transform.childCount do
		local itemIcon = self.MaskBgRoot.transform:Find("MaskBg" .. i)

		self.MaskBgIconList[i] = itemIcon:GetComponent("Image")
	end

	function self.DelegateOnActivateClick()
		self:OnActivateClick()
	end

	function self.DelegateOnPreviewClick(_self, go)
		self:OnPreviewClick(_self, go)
	end

	function self.ActiveSucceedRefreshDelegation()
		self:ActiveSucceedRefresh()
	end

	self:AddListener()
end

function PersonalitySystemView:OnActivateClick()
	for i, v in pairs(self.ItemCells.Consume) do
		if i < v then
			NoticeModule.ShowNotice(20003)

			return
		end
	end

	WarlockModule.UnlockPersonality(WarlockModule.curWarlockData.cid, WarlockModule.CurPersonality.id)
end

function PersonalitySystemView:OnPreviewClick(_self, go)
	local Index = tonumber(go.transform.parent.name)

	if WarlockModule.CurPersonality.index == Index then
		return
	end

	WarlockModule.CurPersonality = WarlockModule.curWarlockData.PersonalityDataList[Index]

	self:RefreshData()
end

function PersonalitySystemView:RefreshData()
	self._NameText:GetComponent("Text").text = WarlockModule.CurPersonality.config.Name
	self._NameSecondText.text = WarlockModule.CurPersonality.config.Name
	self._DescribeText.text = WarlockModule.CurPersonality.config.PersonalityTips

	self:RefreshNeedItem()
	self:DetectionCurActiveState()
	self:InitAllPersonalityState()

	local imageurl = UIGlobalApi.ImagePath .. "/Personality/PersonalityIndex_" .. WarlockModule.CurPersonality.index .. ".png"

	AssetUtil.LoadImage(self, imageurl, self.IndexIconIm)
end

function PersonalitySystemView:RefreshNeedItem()
	self.ItemCells.Consume = {}

	local index = 0

	for i = 1, #WarlockModule.CurPersonality.config.NeedItem do
		index = index + 1

		if index % 2 ~= 0 then
			local _index = (i + 1) / 2
			local itemTable = self.ItemCells.ItemCellList[_index]

			if itemTable == nil then
				local bindLuaTable = {}
				local itemCellObj = UnityEngine.Object.Instantiate(self.ItemCellPrefab)

				itemCellObj.transform:SetParent(self.ActiveConditionRoot.transform, false)

				itemCellObj.transform.localPosition = Vector3.New(0, 0, 0)

				LuaCodeInterface.BindOutlet(itemCellObj, bindLuaTable)

				bindLuaTable.itemCell = ItemCell.New(bindLuaTable.CommonSlotUI)
				itemTable = bindLuaTable

				table.insert(self.ItemCells.ItemCellList, bindLuaTable)
			end

			itemTable.View:SetActive(true)

			local NeedItemCid = WarlockModule.CurPersonality.config.NeedItem[index]
			local OwnNum = WarehouseModule.GetItemNumByCfgID(NeedItemCid)
			local ItemData = ItemData.CreateByCIDAndNumber(NeedItemCid, OwnNum)
			local needNum = WarlockModule.CurPersonality.config.NeedItem[index + 1]

			itemTable.itemCell:SetItem(ItemData)

			if OwnNum > 0 then
				UGUIUtil.SetText(itemTable.NumText, string.format(ColorCfg.RoleUpdate.normalNum, 1))
			else
				UGUIUtil.SetText(itemTable.NumText, string.format(ColorCfg.RoleUpdate.zeroNum, 0))
			end

			self.ItemCells.Consume[OwnNum] = WarlockModule.CurPersonality.config.NeedItem[index + 1]
		end
	end

	local _oIndex = index / 2 + 1

	if _oIndex <= #self.ItemCells.ItemCellList then
		for i = _oIndex, #self.ItemCells.ItemCellList do
			self.ItemCells.ItemCellList[i].View:SetActive(false)
		end
	end
end

function PersonalitySystemView:DetectionCurActiveState()
	if WarlockModule.CurPersonality.isOpen then
		self.isActiveState:SetActive(true)
		self.NeedActiveState:SetActive(false)
		self.ActiveStateButton:SetActive(false)
		self.ActiveCondition:SetActive(false)
	else
		local itemData

		if WarlockModule.CurPersonality.index == 1 then
			self.ActiveStateButton:SetActive(true)
			self.isActiveState:SetActive(false)
			self.NeedActiveState:SetActive(false)
			self.ActiveCondition:SetActive(true)
		else
			itemData = WarlockModule.curWarlockData.PersonalityDataList[WarlockModule.CurPersonality.index - 1]

			if itemData.isOpen then
				self.ActiveStateButton:SetActive(true)
				self.isActiveState:SetActive(false)
				self.NeedActiveState:SetActive(false)
				self.ActiveCondition:SetActive(true)
			else
				self._NeedActiveText.text = itemData.config.Name

				self.NeedActiveState:SetActive(true)
				self.ActiveStateButton:SetActive(false)
				self.isActiveState:SetActive(false)
				self.ActiveCondition:SetActive(true)
			end
		end
	end
end

function PersonalitySystemView:InitAllPersonalityState()
	for i = 1, #WarlockModule.curWarlockData.PersonalityDataList do
		local ItemList = WarlockModule.curWarlockData.PersonalityDataList[i]
		local ItemListlast = WarlockModule.curWarlockData.PersonalityDataList[i - 1]

		if self.PersonalityItemTable[i] == nil then
			local itemCellObj = UnityEngine.Object.Instantiate(self.PersonalityItem.gameObject)

			itemCellObj.name = i

			itemCellObj.transform:SetParent(self.PersonalityItemRoot.transform, false)

			itemCellObj.transform.localPosition = self.PersonalityItemPos[i].pos
			itemCellObj.transform.localScale = self.PersonalityItemPos[i].size

			local isActiveImage = itemCellObj.transform:Find("isActive"):GetComponent("Image")
			local isLockImage = itemCellObj.transform:Find("isLock"):GetComponent("Image")
			local needActiveImage = itemCellObj.transform:Find("NeedActive"):GetComponent("Image")
			local FX_xunhuan = itemCellObj.transform:Find("isActive/FX_xunhuan").gameObject
			local FX_chufa = itemCellObj.transform:Find("isActive/FX_chufa").gameObject
			local button = itemCellObj.transform:Find("button").gameObject

			self:AddClick(button, self.DelegateOnPreviewClick)
			LuaUtility.SetGameObjectShow(FX_chufa, false)
			LuaUtility.SetGameObjectShow(FX_xunhuan, false)
			itemCellObj:SetActive(true)

			self.PersonalityItemTable[i] = {
				obj = itemCellObj,
				isActive = isActiveImage,
				isLock = isLockImage,
				needActive = needActiveImage,
				FX_xunhuanObj = FX_xunhuan,
				FX_chufaObj = FX_chufa
			}
		end

		if ItemList.isOpen then
			self:SetActiveState(i, 1)
		elseif ItemListlast == nil then
			self:SetActiveState(i, 2)
		elseif ItemListlast.isOpen then
			self:SetActiveState(i, 2)
		else
			self:SetActiveState(i, 3)
		end
	end
end

function PersonalitySystemView:SetActiveState(index, type)
	self.PersonalityItemTable[index].isActive.gameObject:SetActive(type == 1)
	self.PersonalityItemTable[index].isLock.gameObject:SetActive(type == 3)
	self.PersonalityItemTable[index].needActive.gameObject:SetActive(type == 2)
	LuaUtility.SetGameObjectShow(self.PersonalityItemTable[index].FX_xunhuanObj, type == 1)

	if index ~= WarlockModule.CurPersonality.index then
		return
	end

	if self.LastpointclickEffect ~= nil then
		self.LastpointclickEffect:SetActive(false)
	end

	if type == 1 then
		self.perssionalityItemEffect.transform:SetParent(self.PersonalityItemTable[index].isActive.gameObject.transform, false)
		self.pointclickEffect1:SetActive(true)

		self.LastpointclickEffect = self.pointclickEffect1
	elseif type == 2 then
		self.perssionalityItemEffect.transform:SetParent(self.PersonalityItemTable[index].needActive.gameObject.transform, false)
		self.pointclickEffect2:SetActive(true)

		self.LastpointclickEffect = self.pointclickEffect2
	elseif type == 3 then
		self.perssionalityItemEffect.transform:SetParent(self.PersonalityItemTable[index].isLock.gameObject.transform, false)
		self.pointclickEffect3:SetActive(true)

		self.LastpointclickEffect = self.pointclickEffect3
	end

	self.perssionalityItemEffect:SetActive(true)

	self.perssionalityItemEffect.transform.localPosition = Vector3.New(0, 0, 0)
end

function PersonalitySystemView:ActiveSucceedRefresh()
	local curPersonalityItemTable = self.PersonalityItemTable[WarlockModule.CurPersonality.index]

	curPersonalityItemTable.isActive.gameObject:SetActive(true)
	LuaUtility.SetGameObjectShow(curPersonalityItemTable.FX_chufaObj, true)

	local PersonalityDataListLength = #WarlockModule.curWarlockData.PersonalityDataList

	self:MaskLightBgMove()

	if WarlockModule.CurPersonality.index == PersonalityDataListLength then
		self:DetectionCurActiveState()
		self.PersonalityItemTable[WarlockModule.CurPersonality.index].needActive.gameObject:SetActive(false)
		self.PersonalityItemTable[WarlockModule.CurPersonality.index].isActive.gameObject:SetActive(true)
		self.PersonalityItemTable[WarlockModule.CurPersonality.index].isLock.gameObject:SetActive(false)
		LuaUtility.SetGameObjectShow(curPersonalityItemTable.FX_xunhuanObj, true)
	else
		WarlockModule.CurPersonality = WarlockModule.curWarlockData.PersonalityDataList[WarlockModule.CurPersonality.index + 1]

		self:RefreshData()
	end
end

function PersonalitySystemView:SetData()
	self:Show()
	self:ResetEffect()
	WarlockModule.GetPersonalityIndex()
	self:MaskLightBgMove(true)
	self:RefreshData()
end

function PersonalitySystemView:MaskLightBgMove(isfirst)
	if isfirst then
		local realIndex = WarlockModule.RealCurPersonality ~= nil and WarlockModule.RealCurPersonality.index or 0

		for i = 1, #self.MaskBgIconList do
			if i == realIndex then
				self.MaskBgIconList[i].fillAmount = 1
			else
				self.MaskBgIconList[i].fillAmount = 0
			end
		end
	else
		if WarlockModule.CurPersonality.index - 1 ~= 0 then
			self.MaskBgIconList[WarlockModule.CurPersonality.index - 1].fillAmount = 0
		end

		local _index = WarlockModule.CurPersonality.index
		local startFillAmount = self.FillAmount[_index]

		UGUIUtil.DoGetValue(startFillAmount, 1, 0.5, DoTweenEase.Linear, function(RunNumber)
			self.MaskBgIconList[_index].fillAmount = RunNumber
		end, function()
			return
		end)
	end
end

function PersonalitySystemView:ResetEffect()
	for k, v in pairs(self.PersonalityItemTable) do
		LuaUtility.SetGameObjectShow(v.FX_xunhuanObj, false)
		LuaUtility.SetGameObjectShow(v.FX_chufaObj, false)
	end
end

function PersonalitySystemView:AddListener()
	self:AddClick(self.ActiveStateButton, self.DelegateOnActivateClick)
	EventDispatcher.AddEventListener(EventID.UnlockPersonalityRefresh, self.ActiveSucceedRefreshDelegation)
end

function PersonalitySystemView:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UnlockPersonalityRefresh, self.ActiveSucceedRefreshDelegation)
end

function PersonalitySystemView:AddClick(Obj, action)
	local button = Obj:GetComponent("Button")

	button.onClick:RemoveAllListeners()
	button.onClick:AddListener(function()
		action(self, button.gameObject)
	end)
end

function PersonalitySystemView:RemoveClick(Obj, action)
	local button = Obj:GetComponent("Button")

	button.onClick:RemoveListener(function()
		action(self, button.gameObject)
	end)
end

function PersonalitySystemView:Show()
	self.gameObject:SetActive(true)
end

function PersonalitySystemView:Hide()
	self.gameObject:SetActive(false)
end

function PersonalitySystemView:OnDestroy()
	for key, extendItemCellOne in pairs(self.ItemCells.ItemCellList) do
		extendItemCellOne.itemCell:Dispose()

		self.ItemCells.ItemCellList[key] = nil
	end

	self.ItemCells.ItemCellList = {}

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil

	self:RemoveListener()
end

return PersonalitySystemView
