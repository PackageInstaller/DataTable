-- chunkname: @IQIGame\\UI\\EquipListUI.lua

local EquipListUI = {
	decomposeToggles = {}
}

EquipListUI = Base:Extend("EquipListUI", "IQIGame.Onigao.UI.EquipListUI", EquipListUI)

local EquipListCom = require("IQIGame.UI.Common.EquipListCom")

function EquipListUI:OnInit()
	self:Initialize()
end

function EquipListUI:GetPreloadAssetPaths()
	return nil
end

function EquipListUI:GetOpenPreloadAssetPaths(userData)
	local ret = {}
	local datum = self:GetAllItemDatum(true)
	local dic = {}

	for i, v in pairs(datum) do
		local cfgData = v:GetCfg()
		local path = UIGlobalApi.ImagePath .. cfgData.DrawingSmallSize

		if dic[path] == nil then
			dic[path] = path
			ret[#ret + 1] = path
		end

		path = EquipUIApi:GetString("qualityIconPath", cfgData.Quality)

		if dic[path] == nil then
			dic[path] = path
			ret[#ret + 1] = path
		end

		path = EquipUIApi:GetString("goCellBg", cfgData.Quality)

		if dic[path] == nil then
			dic[path] = path
			ret[#ret + 1] = path
		end
	end

	return ret
end

function EquipListUI:IsManualShowOnOpen(userData)
	return false
end

function EquipListUI:OnOpen(userData)
	self:Refresh(userData)
end

function EquipListUI:OnClose(userData)
	self:OnHide()
end

function EquipListUI:OnPause()
	return
end

function EquipListUI:OnResume()
	return
end

function EquipListUI:OnCover()
	return
end

function EquipListUI:OnReveal()
	return
end

function EquipListUI:OnRefocus(userData)
	return
end

function EquipListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipListUI:Initialize()
	self.decomposeToggleQuality = EquipListUIApi:GetString("decomposeToggleQuality")
	self.equipListCom = EquipListCom.New(self.goListView, self.UIController, function(itemData, cell)
		self:OnRenderGridCell(itemData, cell)
	end, function(itemData, cell)
		self:OnSelectedGridCell(itemData, cell)
	end)
	self.equipListCom.belongIsWoreSort = false

	for i = 1, #self.decomposeToggleQuality do
		local go = self.goDecEasySelectBlock.transform:Find("Toggle_0" .. i).gameObject

		self.decomposeToggles[i] = go:GetComponent("Toggle")
		go.transform:Find("goDown/Text_Down"):GetComponent("Text").text = EquipListUIApi:GetString("decomposeToggleTxt", self.decomposeToggleQuality[i])
		go.transform:Find("goUp/Text_Up"):GetComponent("Text").text = EquipListUIApi:GetString("decomposeToggleTxt", self.decomposeToggleQuality[i])
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnDecompose = self.goBtnDecompose:GetComponent("Button")
	self.toggleDecompose = self.goToggleDecompose:GetComponent("Toggle")
	self.toggleLock = self.goToggleLock:GetComponent("Toggle")

	function self.onClickToggleDecomposeDelegate(isOn)
		self:OnClickToggleDecompose(isOn)
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onEquipBreakSuccessDelegate(id)
		self:OnEquipBreakSuccess(id)
	end

	function self.onClickBtnDecomposeDelegate()
		self:OnClickBtnDecompose()
	end

	function self.onDecomposeSuccessDelegate(isRecast)
		self:OnDecomposeSuccess(isRecast)
	end

	function self.onComposeSuccessDelegate()
		self:OnComposeSuccess()
	end

	function self.onEquipSortRefreshDelegate()
		self:OnEquipSortRefresh()
	end

	function self.delegateBtnGuide()
		self:OnBtnGuide()
	end

	function self.onEquipTakeOffSuccessDelegate(id)
		self:OnEquipTakeOffSuccess(id)
	end

	function self.onClickToggleLockDelegate(isOn)
		self:OnClickToggleLock(isOn)
	end

	function self.onEquipLockOverDelegate(id, lock)
		self:OnEquipLockOver(id, lock)
	end

	function self.DelegateOnEquipSkinChanged(skinCid)
		self:OnEquipSkinChanged(skinCid)
	end

	for i = 1, #self.decomposeToggleQuality do
		self["onClickDecomposeToggleDelegate" .. i] = function(isOn)
			self:OnClickDecomposeToggle(isOn, i)
		end
	end

	self.goToggleDecompose.transform:Find("Off/Text"):GetComponent("Text").text = EquipListUIApi:GetString("goBtnBatchDecompose")
	self.goToggleDecompose.transform:Find("On/Text"):GetComponent("Text").text = EquipListUIApi:GetString("goBtnCancel")
	self.goToggleLock.transform:Find("Off/Text"):GetComponent("Text").text = EquipListUIApi:GetString("toggleLockTxt")
	self.goToggleLock.transform:Find("On/Text"):GetComponent("Text").text = EquipListUIApi:GetString("toggleLockCancelTxt")
	self.goBtnDecompose.transform:Find("Text"):GetComponent("Text").text = EquipListUIApi:GetString("goBtnDecompose")
	self.goViewTitle:GetComponent("Text").text = EquipListUIApi:GetString("goViewTitle")
	self.goDesc:GetComponent("Text").text = EquipListUIApi:GetString("goDesc")
	self.goDesc2:GetComponent("Text").text = EquipListUIApi:GetString("goDesc2")
	self.goDesc3:GetComponent("Text").text = EquipListUIApi:GetString("goDesc3")
end

function EquipListUI:Refresh(userData)
	self:RefreshMisc()
	self:CloseDecomposeView()
	self:OnClickToggleDecompose(false)

	self.hasOpened = true
	self.toggleLock.isOn = false
	self.isLockState = false
end

function EquipListUI:OnAddListeners()
	self.toggleDecompose.onValueChanged:AddListener(self.onClickToggleDecomposeDelegate)
	self.toggleLock.onValueChanged:AddListener(self.onClickToggleLockDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnDecompose.onClick:AddListener(self.onClickBtnDecomposeDelegate)

	for i, v in pairs(self.decomposeToggles) do
		v.onValueChanged:AddListener(self["onClickDecomposeToggleDelegate" .. i])
	end

	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.delegateBtnGuide)
	EventDispatcher.AddEventListener(EventID.EquipBreakSuccess, self.onEquipBreakSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipComposeSuccess, self.onComposeSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipSortRefresh, self.onEquipSortRefreshDelegate)
	EventDispatcher.AddEventListener(EventID.EquipTakeOffSuccess, self.onEquipTakeOffSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
	EventDispatcher.AddEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function EquipListUI:OnRemoveListeners()
	self.toggleDecompose.onValueChanged:RemoveListener(self.onClickToggleDecomposeDelegate)
	self.toggleLock.onValueChanged:RemoveListener(self.onClickToggleLockDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnDecompose.onClick:RemoveListener(self.onClickBtnDecomposeDelegate)

	for i, v in pairs(self.decomposeToggles) do
		v.onValueChanged:RemoveListener(self["onClickDecomposeToggleDelegate" .. i])
	end

	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGuide)
	EventDispatcher.RemoveEventListener(EventID.EquipBreakSuccess, self.onEquipBreakSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipDecomposeSuccess, self.onDecomposeSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipComposeSuccess, self.onComposeSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipSortRefresh, self.onEquipSortRefreshDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipTakeOffSuccess, self.onEquipTakeOffSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function EquipListUI:OnHide()
	self.hasOpened = false
	self.lastLockOpItemData = nil
	self.lastLockOpCell = nil

	self.equipListCom:OnHide()
end

function EquipListUI:OnDestroy()
	self.equipListCom:OnDestroy()
end

function EquipListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.EquipListUI, true)
end

function EquipListUI:OnClickToggleDecompose(isOn)
	self.goToggleLock:SetActive(not isOn)

	if isOn then
		self.isOpenDecomposeView = true
		self.selectedDecomposeQuality = {}
		self.selectedItemDataDic = {}
		self.equipListCom.enableClickFilter = false

		for i, v in pairs(self.decomposeToggles) do
			v.isOn = false
		end

		self:RefreshList(false, true)
	else
		self.isOpenDecomposeView = false
		self.selectedDecomposeQuality = {}
		self.selectedItemDataDic = {}
		self.equipListCom.enableClickFilter = true

		for i, cell in pairs(self.equipListCom.cells) do
			cell:SetCheckVisible(false)
		end

		self:RefreshList(true, self.hasOpened)
	end
end

function EquipListUI:OnClickToggleLock(isOn)
	self.goToggleDecompose:SetActive(not isOn)

	if isOn then
		self.isLockState = true

		self:RefreshList(false, true)
	else
		self.isLockState = false

		self:RefreshList(true, true)
	end
end

function EquipListUI:OnEquipBreakSuccess(id)
	self:RefreshList(true)

	local equips = {}

	for i, v in ipairs(self.equipListCom.curDatum) do
		if v.id ~= 0 then
			equips[#equips + 1] = v
		end
	end

	EventDispatcher.Dispatch(EventID.RefreshEquipUIEquipDatum, equips)
end

function EquipListUI:OnClickBtnDecompose()
	local datum = {}

	for i, v in pairs(self.selectedItemDataDic) do
		datum[#datum + 1] = v
	end

	if #datum == 0 then
		NoticeModule.ShowNotice(21045070)

		return
	end

	UIModule.Open(Constant.UIControllerName.EquipDecomposeUI, Constant.UILayer.UI, datum)
end

function EquipListUI:OnClickDecomposeToggle(isOn, index)
	local filterQuality = self.decomposeToggleQuality[index]

	self.selectedDecomposeQuality[filterQuality] = isOn

	for i, itemData in pairs(self.equipListCom.curDatum) do
		if self:CheckCanDecomposeForAutoSelect(itemData) then
			self.selectedItemDataDic[itemData.id] = self.selectedDecomposeQuality[itemData:GetCfg().Quality] and itemData or nil
		end
	end

	for i, cell in pairs(self.equipListCom.cells) do
		cell:SetCheckVisible(self.selectedItemDataDic[cell.itemData.id] ~= nil)
	end
end

function EquipListUI:OnDecomposeSuccess(isRecast)
	if isRecast then
		self:RefreshList(true)
	else
		self:CloseDecomposeView()
	end
end

function EquipListUI:OnComposeSuccess()
	self:RefreshList(true)
end

function EquipListUI:OnEquipSortRefresh()
	if self.isOpenDecomposeView then
		self:RefreshList(false)
	else
		self:RefreshList(true)
	end
end

function EquipListUI:OnEquipTakeOffSuccess(id)
	self:RefreshList(true)
end

function EquipListUI:OnRenderGridCell(itemData, cell)
	if itemData.equipData.isWore then
		cell:SetWearTag1Visible(true)
		cell:SetGray(false)
	end

	cell:SetCheckVisible(self.selectedItemDataDic[itemData.id] ~= nil)

	if self.isLockState then
		cell:SetLockMaskVisible(itemData.equipData.lock)
	else
		cell:SetLockMaskVisible(false)
	end
end

function EquipListUI:OnSelectedGridCell(itemData, cell)
	if self.isLockState then
		self.lastLockOpItemData = itemData
		self.lastLockOpCell = cell

		EquipModule.ReqLock(itemData.id)

		return
	end

	if itemData.id == 0 then
		UIModule.Open(Constant.UIControllerName.EquipComposeUI, Constant.UILayer.UI, itemData)
	elseif self.isOpenDecomposeView then
		if self.selectedItemDataDic[itemData.id] ~= nil then
			self.selectedItemDataDic[itemData.id] = nil

			cell:SetCheckVisible(false)
		elseif self:CheckCanDecompose(itemData) then
			self.selectedItemDataDic[itemData.id] = itemData

			cell:SetCheckVisible(true)
		else
			self:ShowCanNotDecomposeTip(itemData)
		end
	else
		local equips = {}

		for i, v in ipairs(self.equipListCom.curDatum) do
			if v.id ~= 0 then
				equips[#equips + 1] = v
			end
		end

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			data = equips,
			defaultItemData = itemData
		})
	end
end

function EquipListUI:OnEquipLockOver(id, lock)
	if self.lastLockOpCell == nil and self.lastLockOpItemData == nil then
		return
	end

	if self.lastLockOpItemData.id == id then
		self.lastLockOpCell:SetLockMaskVisible(self.lastLockOpItemData.equipData.lock)
	end

	self.lastLockOpItemData = nil
	self.lastLockOpCell = nil
end

function EquipListUI:RefreshMisc()
	self.equipListCom:Refresh()
end

function EquipListUI:RefreshList(includeClip, dynamicRefresh)
	local datum = self:GetAllItemDatum(includeClip)

	self.equipListCom:SortCells(datum, dynamicRefresh)
end

function EquipListUI:GetAllItemDatum(includeClip)
	local allItemData = WarehouseModule.GetItemsByType(Constant.ItemType.Equip, true)

	if includeClip then
		local clipItemDatum = WarehouseModule.GetItemsByTypeAndSubType(Constant.ItemType.Item, 20)

		for i, v in pairs(clipItemDatum) do
			local cfgData

			for j, k in pairsCfg(CfgExchangeTable) do
				if k.CostItems[1][1] == v.cid then
					cfgData = k

					break
				end
			end

			if cfgData ~= nil then
				local needCount = cfgData.CostItems[1][2]
				local ownCount = WarehouseModule.GetItemNumByCfgID(cfgData.CostItems[1][1])

				if needCount <= ownCount then
					local equipCid = cfgData.GetItems[1][1]

					if equipCid ~= nil then
						local itemData = ItemData.CreateByCIDAndNumber(equipCid, 1)

						allItemData[#allItemData + 1] = itemData
					end
				end
			end
		end
	end

	local ret = {}

	for i, v in ipairs(allItemData) do
		local cfgData = v:GetCfg()

		if cfgData.Type == Constant.ItemType.Equip then
			if cfgData.ExclusiveSoul ~= 0 then
				if SoulModule.GetSoulData(cfgData.ExclusiveSoul) ~= nil then
					ret[#ret + 1] = v
				end
			else
				ret[#ret + 1] = v
			end
		else
			ret[#ret + 1] = v
		end
	end

	return ret
end

function EquipListUI:CloseDecomposeView()
	self.toggleDecompose.isOn = false
end

function EquipListUI:CheckCanDecompose(itemData)
	local ret = true

	if itemData == nil or itemData.equipData.isWore or itemData.equipData.lock or itemData.id == 0 then
		ret = false
	end

	return ret
end

function EquipListUI:CheckCanDecomposeForAutoSelect(itemData)
	local ret = true

	if itemData == nil or itemData.equipData.isWore or itemData.equipData.lock or itemData.equipData.lv > 1 or itemData.equipData.star > 1 or itemData.id == 0 then
		ret = false
	end

	return ret
end

function EquipListUI:ShowCanNotDecomposeTip(itemData)
	if itemData == nil then
		return
	end

	if itemData.id == 0 then
		return
	end

	local id

	if itemData.equipData.isWore then
		id = 21053002
	elseif itemData.equipData.lock then
		id = 21053003
	end

	NoticeModule.ShowNoticeNoCallback(id)
end

function EquipListUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 2000)
end

function EquipListUI:OnEquipSkinChanged(skinCid)
	self.equipListCom:RefreshCells()
end

return EquipListUI
