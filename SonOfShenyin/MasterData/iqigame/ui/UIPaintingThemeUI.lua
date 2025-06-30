-- chunkname: @IQIGame\\UI\\UIPaintingThemeUI.lua

local ThemeView = {}

function ThemeView.New(view)
	local obj = Clone(ThemeView)

	obj:__Init(view)

	return obj
end

function ThemeView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ThemeView:Show(paintingData)
	self.gameObject:SetActive(true)

	self.paintingData = paintingData

	local assetPath = UIGlobalApi.GetIconPath(paintingData.Icon)

	AssetUtil.LoadImage(self, assetPath, self.Icon:GetComponent("Image"))

	local isGet = true

	if paintingData.ItemID > 0 then
		local num = WarehouseModule.GetItemNumByCfgID(paintingData.ItemID)

		isGet = num > 0
	end

	self.LockRoot.gameObject:SetActive(not isGet)
	self:RefreshUsing()
end

function ThemeView:RefreshUsing()
	local selectPaintingCid = PlayerModule.GetUsingPaintingItemCid()

	self.UsingTag.gameObject:SetActive(selectPaintingCid == self.paintingData.ID)
end

function ThemeView:Hide()
	self.gameObject:SetActive(false)
end

function ThemeView:ChangeSelect(isSelect)
	self.selectedRoot.gameObject:SetActive(isSelect)
end

function ThemeView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local UIPaintingThemeUI = {
	skinAreaList = {},
	skinItemList = {}
}

UIPaintingThemeUI = Base:Extend("UIPaintingThemeUI", "IQIGame.Onigao.UI.UIPaintingThemeUI", UIPaintingThemeUI)

function UIPaintingThemeUI:OnInit()
	self:__InitSkinList()
end

function UIPaintingThemeUI:GetPreloadAssetPaths()
	return
end

function UIPaintingThemeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UIPaintingThemeUI:IsManualShowOnOpen(userData)
	return false
end

function UIPaintingThemeUI:GetBGM(userData)
	return
end

function UIPaintingThemeUI:OnOpen(userData)
	self:__InitViewData(userData)
end

function UIPaintingThemeUI:OnClose(userData)
	return
end

function UIPaintingThemeUI:OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "useButton", self.__OnUserBtnClicked)
	UIEventUtil.AddClickEventListener_Button(self, "CloseBtn", self.__OnCloseBtnClicked)
	EventUtil.AddEventListener(self, EventID.OnSaveDataSuccess, self.__OnSavePlayerDataSuccess)
end

function UIPaintingThemeUI:OnRemoveListeners()
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
end

function UIPaintingThemeUI:OnPause()
	return
end

function UIPaintingThemeUI:OnResume()
	return
end

function UIPaintingThemeUI:OnCover()
	return
end

function UIPaintingThemeUI:OnReveal()
	return
end

function UIPaintingThemeUI:OnRefocus(userData)
	return
end

function UIPaintingThemeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UIPaintingThemeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UIPaintingThemeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UIPaintingThemeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UIPaintingThemeUI:OnDestroy()
	ForPairs(self.themeData, function(k, v)
		GameObject.Destroy(v.viewGo)
	end)

	self.themeData = nil

	ForPairs(self.paintingTable, function(k, v)
		GameObject.Destroy(v)
	end)

	self.paintingTable = nil
end

function UIPaintingThemeUI:__InitViewData(userData)
	self.paintingData = {}

	ForPairs(CfgUIPaintingItemTable, function(_, _cfg)
		if not _cfg.IsShow then
			return
		end

		table.insert(self.paintingData, _cfg)
	end)

	local __selectItem = self.paintingData[1]

	self:__ChangeSelectData(__selectItem)

	local totalCount = #self.paintingData

	self.skinAreaList:Refresh(totalCount)
end

function UIPaintingThemeUI:__InitSkinList()
	self.paintingTable = {}
	self.skinAreaList = self.rightScrollView:GetComponent("ScrollAreaList")

	function self.skinAreaList.onRenderCell(cell)
		self:__OnRenderSkinListItem(cell)
	end

	function self.skinAreaList.onSelectedCell(cell)
		self:__OnItemCellSelect(cell)
	end
end

function UIPaintingThemeUI:__OnRenderSkinListItem(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local skinItem = self.skinItemList[insID]

	if skinItem == nil then
		skinItem = ThemeView.New(itemCell.gameObject)
		self.skinItemList[insID] = skinItem
	end

	local dataIndex = itemCell.index + 1
	local themeData = self.paintingData[dataIndex]

	skinItem:Show(themeData)
	skinItem:ChangeSelect(self.__selectPaintingCfg.ID == themeData.ID)
end

function UIPaintingThemeUI:__OnItemCellSelect(cell)
	local insID = cell.gameObject:GetInstanceID()
	local skinItem = self.skinItemList[insID]

	self:__ChangeSelectData(skinItem.paintingData)
	ForPairs(self.skinItemList, function(k, v)
		local select = v.paintingData.ID == self.__selectPaintingCfg.ID

		v:ChangeSelect(select)
	end)
end

function UIPaintingThemeUI:__ChangeSelectData(selectPaintingCfg)
	self.__selectPaintingCfg = selectPaintingCfg
	self.NameText:GetComponent("Text").text = selectPaintingCfg.Name
	self.ContentText:GetComponent("Text").text = selectPaintingCfg.ItemTips

	self:__RefreshPaintingShow(selectPaintingCfg.ID)
	self:__RefreshBtnState()
end

function UIPaintingThemeUI:__RefreshBtnState()
	local selectPaintingCid = PlayerModule.GetUsingPaintingItemCid()

	if self.__selectPaintingCfg.ID == selectPaintingCid then
		self.useButton.gameObject:SetActive(false)
		self.UsingTag.gameObject:SetActive(true)

		return
	end

	self.UsingTag.gameObject:SetActive(false)

	local isGet = true

	if self.__selectPaintingCfg.ItemID > 0 then
		local num = WarehouseModule.GetItemNumByCfgID(self.__selectPaintingCfg.ItemID)

		isGet = num > 0
	end

	self.useButton.gameObject:SetActive(isGet)
end

function UIPaintingThemeUI:__RefreshPaintingShow(itemCid)
	ForPairs(self.paintingTable, function(_itemCid, _paintingGo)
		local active = _itemCid == itemCid

		_paintingGo.gameObject:SetActive(active)
	end)

	if self.paintingTable[itemCid] == nil then
		self:__LoadPaintingGameObject(itemCid)
	end
end

function UIPaintingThemeUI:__LoadPaintingGameObject(itemCid)
	local cfgPainting = CfgUIPaintingItemTable[itemCid]

	AssetUtil.LoadAsset(self, cfgPainting.PrefabPath, function(_, _, asset, _, userData)
		self:__OnPaintingItemLoaded(asset, userData)
	end, function()
		logError("挂画加载失败PaintingItemCid: {1}", itemCid)
	end, {
		paintingItemCid = itemCid
	})
end

function UIPaintingThemeUI:__OnPaintingItemLoaded(asset, userData)
	if self.paintingTable == nil then
		return
	end

	if self.paintingTable[userData.paintingItemCid] ~= nil then
		return
	end

	local obj = UnityEngine.Object.Instantiate(asset)

	obj.gameObject.transform:SetParent(self.PaintingRoot.transform, false)

	obj.gameObject.transform.localScale = Vector3.one
	obj.gameObject.transform.localPosition = Vector3.zero

	local selectCid = self.__selectPaintingCfg.ID
	local active = selectCid == userData.paintingItemCid

	obj.gameObject:SetActive(active)

	self.paintingTable[userData.paintingItemCid] = obj
end

function UIPaintingThemeUI:__OnUserBtnClicked()
	PlayerModule.SavePlayerCatchData(Constant.SaveDataKey.PaintingItemCid, self.__selectPaintingCfg.ID)
end

function UIPaintingThemeUI:__OnCloseBtnClicked()
	UIModule.Close(Constant.UIControllerName.UIPaintingThemeUI)
end

function UIPaintingThemeUI:__OnSavePlayerDataSuccess()
	self:__RefreshBtnState()
	ForPairs(self.skinItemList, function(k, v)
		v:RefreshUsing()
	end)
end

return UIPaintingThemeUI
