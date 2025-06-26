-- chunkname: @IQIGame\\UI\\HomeLandRoomEditUI.lua

local HomeLandRoomEditUI = Base:Extend("HomeLandRoomEditUI", "IQIGame.Onigao.UI.HomeLandRoomEditUI", {
	isShowMore = false,
	subTypeIndex = 1,
	selectIndex = 1
})
local FurnitureSlot = require("IQIGame.UI.Common.FurnitureSlot")
local HomeLandDragView = require("IQIGame.UI.HomeLand.HomeLandDragView")
local HomeLandRoomEditToggleCell = require("IQIGame.UI.HomeLand.HomeLandRoomEditToggleCell")
local HomeLandRoomEditMaskView = require("IQIGame.UI.HomeLand.HomeLandRoomEditMaskView")
local toggleTitles = HomeLandRoomUIApi:GetString("ToggleTitle")
local startPos, endPos, tweenSpeed

function HomeLandRoomEditUI:OnInit()
	self.tabs = {}

	for i, v in pairsCfg(CfgHomeLandDecorateThemeTable) do
		if v.Tpye == 1 then
			table.insert(self.tabs, {
				v.Id,
				v.Name
			})
		end
	end

	table.sort(self.tabs, function(a, b)
		return a[1] < b[1]
	end)
	table.insert(self.tabs, 1, {
		0,
		HomeLandRoomUIApi:GetString("TextLabel1")
	})

	self.TextBtnPurchase:GetComponent("Text").text = HomeLandRoomUIApi:GetString("TextBtnPurchase")
	self.TextBtnIllustrations:GetComponent("Text").text = HomeLandRoomUIApi:GetString("TextBtnIllustration")
	self.btnSaveComponent = self.BtnSave:GetComponent("Button")
	self.btnPurchaseComponent = self.BtnPurchase:GetComponent("Button")
	self.btnIllustrationsComponent = self.BtnIllustrations:GetComponent("Button")
	self.btnCleanComponent = self.BtnClean:GetComponent("Button")
	self.btnQuickLayout = self.BtnQuickLayout:GetComponent("Button")
	self.tweenPosition = self.BottomPanel:GetComponent("TweenPosition")
	self.btnUpComponent = self.BtnUp:GetComponent("Button")
	self.btnDownComponent = self.BtnDown:GetComponent("Button")
	self.toggleStyle = self.ToggleStyle:GetComponent("Toggle")

	function self.delegateOnBtnSave()
		self:OnClickBtnSave()
	end

	function self.delegateOnBtnPurchase()
		self:OnClickBtnPurchase()
	end

	function self.delegateOnBtnIllustrations()
		self:OnClickBtnIllustrations()
	end

	function self.delegateOnBtnClean()
		self:OnClickBtnClean()
	end

	function self.delegateUIContentWrapUpdateItem(cell)
		self:UIContentWrapUpdateItem(cell)
	end

	function self.delegateSelectedItem(cell)
		self:SelectedItemCell(cell)
	end

	function self.delegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.delegateOnBtnUp()
		self:OnClickBtnUp()
	end

	function self.delegateOnBtnDown()
		self:OnClickBtnDown()
	end

	function self.delegateTweenPosition()
		self:OnTweenPositionFinished()
	end

	function self.delegateOnUnlockNotify()
		self:OnUnlockNotify()
	end

	function self.delegateSaveRoomEvent()
		self:OnSaveRoomEvent()
	end

	function self.delegatePutDecorateUpdateItem(roomId)
		self:OnPutDecorateUpdateItem(roomId)
	end

	function self.delegateOnBtnQuickLayout()
		self:OnBtnQuickLayout()
	end

	function self.delegateToggleStyleChange(isOn)
		self:OnToggleStyleChange(isOn)
	end

	function self.delegateToggleManufacture(isOn)
		self:OnTogManufacture(isOn)
	end

	startPos = Vector3.New(self.tweenPosition.from.x, self.tweenPosition.from.y, self.tweenPosition.from.z)
	endPos = Vector3.New(self.tweenPosition.to.x, self.tweenPosition.to.y, self.tweenPosition.to.z)
	tweenSpeed = self.tweenPosition.duration
	self.homeLandDragView = HomeLandDragView:New(self.SimulatePrefab, self.HomeRoot)
	self.homeLandRoomEditMaskView = HomeLandRoomEditMaskView:New(self.TabMask)

	self.homeLandRoomEditMaskView:CreateButtons(self.tabs)

	function self.homeLandRoomEditMaskView.selectChangeFun(selectIndex)
		self:OnSelectIndex(selectIndex)
	end

	self.homeLandRoomEditMaskView:Close()
	self.Disable:SetActive(not self.isShowMore)
	self.BtnSave:SetActive(not self.isShowMore)
	self.BtnUp:SetActive(self.isShowMore)
	self.BtnDown:SetActive(not self.isShowMore)
	self:InitTog()
end

function HomeLandRoomEditUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandRoomEditUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandRoomEditUI:OnOpen(userData)
	self.roomCid = userData
	self.toggleStyle.isOn = false
	self.toggleManufactures[self.subTypeIndex].isOn = true

	self:ShowTab(true)
end

function HomeLandRoomEditUI:OnClose(userData)
	return
end

function HomeLandRoomEditUI:OnAddListeners()
	self.btnPurchaseComponent.onClick:AddListener(self.delegateOnBtnPurchase)
	self.btnIllustrationsComponent.onClick:AddListener(self.delegateOnBtnIllustrations)
	self.btnSaveComponent.onClick:AddListener(self.delegateOnBtnSave)
	self.btnCleanComponent.onClick:AddListener(self.delegateOnBtnClean)
	self.btnUpComponent.onClick:AddListener(self.delegateOnBtnUp)
	self.btnDownComponent.onClick:AddListener(self.delegateOnBtnDown)
	self.btnQuickLayout.onClick:AddListener(self.delegateOnBtnQuickLayout)
	self.toggleStyle.onValueChanged:AddListener(self.delegateToggleStyleChange)

	for i, v in pairs(self.toggleManufactures) do
		v.onValueChanged:AddListener(self.delegateToggleManufacture)
	end

	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.AddEventListener(EventID.SaveRoomDecorateResultEvent, self.delegateSaveRoomEvent)
	EventDispatcher.AddEventListener(EventID.PutDecorateUpdateItem, self.delegatePutDecorateUpdateItem)
end

function HomeLandRoomEditUI:OnRemoveListeners()
	self.btnPurchaseComponent.onClick:RemoveListener(self.delegateOnBtnPurchase)
	self.btnIllustrationsComponent.onClick:RemoveListener(self.delegateOnBtnIllustrations)
	self.btnSaveComponent.onClick:RemoveListener(self.delegateOnBtnSave)
	self.btnCleanComponent.onClick:RemoveListener(self.delegateOnBtnClean)
	self.btnUpComponent.onClick:RemoveListener(self.delegateOnBtnUp)
	self.btnDownComponent.onClick:RemoveListener(self.delegateOnBtnDown)
	self.btnQuickLayout.onClick:RemoveListener(self.delegateOnBtnQuickLayout)

	for i, v in pairs(self.toggleManufactures) do
		v.onValueChanged:RemoveListener(self.delegateToggleManufacture)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.RemoveEventListener(EventID.SaveRoomDecorateResultEvent, self.delegateSaveRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.PutDecorateUpdateItem, self.delegatePutDecorateUpdateItem)
	self.toggleStyle.onValueChanged:RemoveListener(self.delegateToggleStyleChange)
end

function HomeLandRoomEditUI:OnPause()
	return
end

function HomeLandRoomEditUI:OnResume()
	return
end

function HomeLandRoomEditUI:OnCover()
	return
end

function HomeLandRoomEditUI:OnReveal()
	return
end

function HomeLandRoomEditUI:OnRefocus(userData)
	return
end

function HomeLandRoomEditUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandRoomEditUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandRoomEditUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandRoomEditUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandRoomEditUI:OnDestroy()
	self.homeLandDragView:Dispose()
	FurnitureSlot.DisposeIn(self)
	HomeLandRoomEditToggleCell.DisposeIn(self)
end

function HomeLandRoomEditUI:OnUnlockNotify()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.FURNITURELOTTERY)

	self.BtnPurchase:SetActive(false)
end

function HomeLandRoomEditUI:InitTog()
	self.toggleManufactures = {}

	local toggle

	self.ToggleMould:SetActive(false)

	for i = 1, #toggleTitles do
		local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

		obj.transform:SetParent(self.TogGroup.transform, false)
		obj:SetActive(true)

		obj:GetComponent("ToggleHelperComponent").text = toggleTitles[i][2]

		if i == 1 then
			obj:GetComponent("CanvasGroup").alpha = 0
		end

		toggle = obj:GetComponent("Toggle")
		toggle.isOn = false
		toggle.group = self.TogGroup:GetComponent("ToggleGroup")
		self.toggleManufactures[i] = toggle
	end
end

function HomeLandRoomEditUI:OnTogManufacture(isOn)
	if isOn then
		for i = 1, #self.toggleManufactures do
			local toggle = self.toggleManufactures[i]

			if toggle.isOn == true and self.subTypeIndex ~= i then
				self.subTypeIndex = i

				self:ShowTab(true)

				break
			end
		end
	end
end

function HomeLandRoomEditUI:OnToggleStyleChange(isOn)
	if isOn then
		self.homeLandRoomEditMaskView:Open()
	else
		self.homeLandRoomEditMaskView:Close()
	end
end

function HomeLandRoomEditUI:OnSelectIndex(selectIndex)
	self.toggleStyle.isOn = false

	if self.selectIndex ~= selectIndex then
		self.selectIndex = selectIndex
		self.toggleManufactures[1].isOn = true

		self:ShowTab(true)
	end
end

function HomeLandRoomEditUI:OnPutDecorateUpdateItem(roomId)
	if self.selectIndex ~= nil then
		self:ShowTab()
	end
end

function HomeLandRoomEditUI:OnUpdateItem()
	self.homeLandDragView:Update()

	if self.selectIndex ~= nil then
		self:ShowTab()
	end
end

function HomeLandRoomEditUI:ShowTab(freshFirst)
	self.ToggleStyle:GetComponent("ToggleHelperComponent").text = self.tabs[self.selectIndex][2]

	UGUIUtil.SetText(self.TextTitle, HomeLandRoomUIApi:GetString("TextTitle"))

	local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.roomCid)

	UGUIUtil.SetText(self.TextValue, roomPOD.comfort)
	self:OnUnlockNotify()

	local type = self.tabs[self.selectIndex][1]
	local subType = toggleTitles[self.subTypeIndex][1]

	self.items = self:GetItemsByType(type, subType)

	self.BtnQuickLayout:SetActive(type > 0 and type ~= 10001)

	local wrapContent = self.BagGroup:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.delegateUIContentWrapUpdateItem
	wrapContent.onSelectedCell = self.delegateSelectedItem

	if freshFirst then
		wrapContent:Refresh(#self.items)
	else
		wrapContent:RenderCellsDynamic(#self.items)
	end
end

function HomeLandRoomEditUI:SelectedItemCell(cell)
	local selectItemData = self.items[cell.index + 1]
	local putNum = HomeLandLuaModule.GetPutDecorateIdNum(selectItemData.cfgDecorateID)
	local showNum = WarehouseModule.GetItemNumByCfgID(selectItemData.cid) + putNum

	if showNum <= 0 then
		NoticeModule.ShowNoticeByType(1, HomeLandRoomUIApi:GetString("TextError", CfgItemTable[selectItemData.cid].Name))

		return
	end

	local pos = HomelandModule.Instance:GetItemPuDownPos({
		HomeLandLuaModule.currentEnterRoomID,
		selectItemData.cfgDecorateID
	})

	if pos ~= nil then
		local decorate = {}

		decorate.cid = selectItemData.cfgDecorateID
		decorate.x = pos.x - CfgHomeLandDecorateTable[selectItemData.cfgDecorateID].Area[1] / 2
		decorate.y = pos.y

		HomeLandLuaModule.AddDecorate(HomeLandLuaModule.currentEnterRoomID, decorate)

		local type = CfgHomeLandDecorateTable[selectItemData.cfgDecorateID].LevelType

		if type == 1 or type == 3 then
			NoticeModule.ShowNotice(21042030)
		end
	end
end

function HomeLandRoomEditUI:UIContentWrapUpdateItem(cell)
	local itemData = self.items[cell.index + 1]
	local itemGo = cell.gameObject

	if itemData == nil then
		itemGo:SetActive(false)

		return
	end

	local tabComponent = {}

	LuaCodeInterface.BindOutlet(itemGo, tabComponent)

	tabComponent.TextName:GetComponent("Text").text = FurnitureSlotApi:GetString("TextColorName", CfgItemTable[itemData.cid].Name, CfgItemTable[itemData.cid].Quality)

	local cfgDecorate = CfgHomeLandDecorateTable[itemData.cfgDecorateID]

	tabComponent.TextTag1:GetComponent("Text").text = cfgDecorate.Score

	local btnCom = tabComponent.FurnitureSlot:GetComponent("Button")

	if btnCom ~= nil then
		btnCom.enabled = false
	end

	local furnitureCell = FurnitureSlot.PackageOrReuseView(self, tabComponent.FurnitureSlot)

	furnitureCell:SetItem(itemData.cid, true)

	local putNum = HomeLandLuaModule.GetPutDecorateIdNum(itemData.cfgDecorateID)
	local showNum = WarehouseModule.GetItemNumByCfgID(itemData.cid) + putNum

	furnitureCell:SetNum(showNum, true)
	LuaCodeInterface.ClearOutlet(itemGo, tabComponent)
end

function HomeLandRoomEditUI:GetItemsByType(themeID, type)
	local allItems = {}

	for k, v in pairs(HomeLandLuaModule.putDecorateIds) do
		local cid = CfgHomeLandDecorateTable[k].Item

		table.insert(allItems, cid)
	end

	local itemData, cfgItemData

	for i = 1, #WarehouseModule.AllItems do
		itemData = WarehouseModule.AllItems[i]
		cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.Type == Constant.ItemType.HomeDecoration and table.indexOf(allItems, itemData.cid) == -1 then
			table.insert(allItems, itemData.cid)
		end
	end

	local tab = {}

	for i, v in pairs(allItems) do
		for k, v1 in pairsCfg(CfgHomeLandDecorateTable) do
			if v1.IsShowInRoom and v == v1.Item and table.indexOf(v1.DisableRooms, self.roomCid) == -1 then
				local decorateData = {}

				decorateData.cid = v

				if themeID == 0 then
					decorateData.cfgDecorateID = v1.Id
					decorateData.themeID = v1.ThemeID
					decorateData.Sort = v1.Sort

					if type == 0 then
						tab[#tab + 1] = decorateData

						break
					end

					if v1.LevelType == type then
						tab[#tab + 1] = decorateData
					end

					break
				end

				if v1.ThemeID == themeID then
					decorateData.cfgDecorateID = v1.Id
					decorateData.themeID = v1.ThemeID
					decorateData.Sort = v1.Sort

					if type == 0 then
						tab[#tab + 1] = decorateData

						break
					end

					if v1.LevelType == type then
						tab[#tab + 1] = decorateData
					end
				end

				break
			end
		end
	end

	table.sort(tab, function(a, b)
		return a.Sort < b.Sort
	end)

	return tab
end

function HomeLandRoomEditUI:OnClickBtnUp()
	self.tweenPosition = TweenPosition.Begin(self.BottomPanel, tweenSpeed, startPos)

	self.tweenPosition:SetOnFinished(self.delegateTweenPosition)
end

function HomeLandRoomEditUI:OnClickBtnDown()
	self.tweenPosition = TweenPosition.Begin(self.BottomPanel, tweenSpeed, endPos)

	self.tweenPosition:SetOnFinished(self.delegateTweenPosition)
end

function HomeLandRoomEditUI:OnTweenPositionFinished()
	self.tweenPosition:RemoveOnFinished(self.delegateTweenPosition)

	self.isShowMore = not self.isShowMore

	self.Disable:SetActive(not self.isShowMore)
	self.BtnSave:SetActive(not self.isShowMore)
	self.BtnUp:SetActive(self.isShowMore)
	self.BtnDown:SetActive(not self.isShowMore)
end

function HomeLandRoomEditUI:OnClickBtnSave()
	HomeLandLuaModule.SaveRoomDecorate(self.roomCid)
end

function HomeLandRoomEditUI:OnSaveRoomEvent()
	if HomeLandLuaModule.isEditing == true then
		HomeLandLuaModule.isEditing = false

		GameEntry.LuaEvent:Fire(nil, HomelandQuitEditRoomEventArgs())
		GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, true))
	end

	UIModule.Close(Constant.UIControllerName.HomeLandRoomEditUI)
end

function HomeLandRoomEditUI:OnClickBtnPurchase()
	UIModule.Open(Constant.UIControllerName.FurnitureLotteryUI, Constant.UILayer.UI)
end

function HomeLandRoomEditUI:OnClickBtnIllustrations()
	UIModule.Open(Constant.UIControllerName.FurnitureHandbookUI, Constant.UILayer.UI)
end

function HomeLandRoomEditUI:OnClickBtnClean()
	NoticeModule.ShowNotice(21042016, function()
		HomeLandLuaModule.ClearDecorate(HomeLandLuaModule.currentEnterRoomID)
	end)
end

function HomeLandRoomEditUI:OnBtnQuickLayout()
	local styleType = self.tabs[self.selectIndex][1]
	local canLayout, decorateTab = HomeLandLuaModule.GetQuickLayoutByThemeID(styleType)

	if not canLayout then
		NoticeModule.ShowNoticeNoCallback(21042020)
	else
		NoticeModule.ShowNotice(21042021, function()
			UIModule.Open(Constant.UIControllerName.HomeLandSpineEffectFastUI, Constant.UILayer.Mid, {
				self.roomCid,
				decorateTab
			})
		end)
	end
end

return HomeLandRoomEditUI
