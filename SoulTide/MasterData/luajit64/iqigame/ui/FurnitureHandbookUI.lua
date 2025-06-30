-- chunkname: @IQIGame\\UI\\FurnitureHandbookUI.lua

local FurnitureHandbookUI = Base:Extend("FurnitureHandbookUI", "IQIGame.Onigao.UI.FurnitureHandbookUI", {})
local FurnitureSlot = require("IQIGame.UI.Common.FurnitureSlot")

function FurnitureHandbookUI:OnInit()
	self.btnBackComponent = self.BtnBack:GetComponent("Button")
	self.btn1Component = self.Btn1:GetComponent("Button")
	self.btn2Component = self.Btn2:GetComponent("Button")
	self.TextStar:GetComponent("Text").text = FurnitureLotteryUIApi:GetString("TextStar")
	self.TextInfo:GetComponent("Text").text = FurnitureLotteryUIApi:GetString("TextInfo")
	self.TextDes:GetComponent("Text").text = FurnitureLotteryUIApi:GetString("TextDes")
	self.TextCome:GetComponent("Text").text = FurnitureLotteryUIApi:GetString("TextCome")

	function self.delegateClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.delegateUpdateItem(cell)
		self:UpdateItemCell(cell)
	end

	function self.delegateUpdateSlot(cell)
		self:UpdateSlotCell(cell)
	end

	function self.delegateSelectSlot(cell)
		self:SelectSlot(cell)
	end

	function self.delegateUpdateActivationEvent()
		self:UpDateView()
	end

	function self.delegateSelectedItem(cell)
		self:SelectedItemCell(cell)
	end

	function self.delegateClickBtn1()
		self:OnClickBtn1()
	end

	function self.delegateClickBtn2()
		self:OnClickBtn2()
	end

	self:InitTog()
end

function FurnitureHandbookUI:GetPreloadAssetPaths()
	return nil
end

function FurnitureHandbookUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FurnitureHandbookUI:OnOpen(userData)
	self:UpDateView()
end

function FurnitureHandbookUI:OnAddListeners()
	self.btnBackComponent.onClick:AddListener(self.delegateClickBtnBack)
	self.btn1Component.onClick:AddListener(self.delegateClickBtn1)
	self.btn2Component.onClick:AddListener(self.delegateClickBtn2)
	EventDispatcher.AddEventListener(EventID.UpdateActivationDecorates, self.delegateUpdateActivationEvent)
end

function FurnitureHandbookUI:OnClose(userData)
	return
end

function FurnitureHandbookUI:OnRemoveListeners()
	self.btnBackComponent.onClick:RemoveListener(self.delegateClickBtnBack)
	self.btn1Component.onClick:RemoveListener(self.delegateClickBtn1)
	self.btn2Component.onClick:RemoveListener(self.delegateClickBtn2)
	EventDispatcher.RemoveEventListener(EventID.UpdateActivationDecorates, self.delegateUpdateActivationEvent)
end

function FurnitureHandbookUI:OnPause()
	return
end

function FurnitureHandbookUI:OnResume()
	return
end

function FurnitureHandbookUI:OnCover()
	return
end

function FurnitureHandbookUI:OnReveal()
	return
end

function FurnitureHandbookUI:OnRefocus(userData)
	return
end

function FurnitureHandbookUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FurnitureHandbookUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FurnitureHandbookUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FurnitureHandbookUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FurnitureHandbookUI:OnDestroy()
	FurnitureSlot.DisposeIn(self)
	AssetUtil.UnloadAsset(self)
end

function FurnitureHandbookUI:InitTog()
	self.tabItems = {}

	for k, v in pairsCfg(CfgHomeLandDecorateThemeTable) do
		table.insert(self.tabItems, v)
	end

	table.sort(self.tabItems, FurnitureHandbookUI.SortEvent)

	local comp = self.GridTog:GetComponent("ScrollAreaList")

	comp.onRenderCell = self.delegateUpdateItem
	comp.onSelectedCell = self.delegateSelectedItem

	comp:Refresh(#self.tabItems)
end

function FurnitureHandbookUI.SortEvent(tb1, tb2)
	local r = false
	local id1 = tonumber(tb1.Id)
	local id2 = tonumber(tb2.Id)

	r = id1 < id2

	return r
end

function FurnitureHandbookUI:UpdateItemCell(cell)
	local cfgData = self.tabItems[cell.index + 1]

	if cfgData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local itemGo = cell.gameObject
	local toggleHelperComponent = itemGo:GetComponent("ToggleHelperComponent")
	local path = UIGlobalApi.IconPath .. cfgData.Icon

	toggleHelperComponent.iconPath = path

	local toggle = itemGo:GetComponent("Toggle")

	toggle.group = self.GridTog:GetComponent("ToggleGroup")
	toggle.isOn = false

	if self.currentTabIndex == nil then
		self.currentTabIndex = 1
		toggle.isOn = true
	end
end

function FurnitureHandbookUI:SelectedItemCell(cell)
	self.currentTabIndex = cell.index + 1

	self:ShowTab(self.currentTabIndex)
end

function FurnitureHandbookUI:UpDateView()
	self:ShowTab(self.currentTabIndex)
end

function FurnitureHandbookUI:ShowTab(index)
	local selectCfg = self.tabItems[index]

	self.tabIllustrations = FurnitureLotteryModule.GetDecorateIllustrationByTheme(selectCfg.Id)

	local count = 0

	for i, v in pairs(self.tabIllustrations) do
		if v.activation == true then
			count = count + 1
		end
	end

	self.TextNum:GetComponent("Text").text = FurnitureLotteryUIApi:GetString("TextNum", count, #self.tabIllustrations)
	self.currentSelectSlot = nil

	table.sort(self.tabIllustrations, FurnitureHandbookUI.SourEventByStart)

	local comp = self.GridSlot:GetComponent("ScrollAreaList")

	comp.onRenderCell = self.delegateUpdateSlot
	comp.onSelectedCell = self.delegateSelectSlot

	comp:Refresh(#self.tabIllustrations)
	self.currentSelectSlot:SetSelected(true)
	self:ShowDetails()
end

function FurnitureHandbookUI.SourEventByStart(tab1, tab2)
	local star1 = CfgItemTable[tab1.cfgInfo.Item].Star
	local star2 = CfgItemTable[tab2.cfgInfo.Item].Star

	return star2 < star1
end

function FurnitureHandbookUI:UpdateSlotCell(cell)
	local IllustrationsData = self.tabIllustrations[cell.index + 1]

	if IllustrationsData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local itemGo = cell.gameObject
	local furnitureCell = FurnitureSlot.PackageOrReuseView(self, itemGo)

	furnitureCell:SetItem(IllustrationsData.cfgInfo.Item, IllustrationsData.activation, IllustrationsData.cfgInfo.Id)

	if self.currentSelectSlot == nil then
		self.currentSelectSlot = furnitureCell
	end
end

function FurnitureHandbookUI:SelectSlot(cell)
	local IllustrationsData = self.tabIllustrations[cell.index + 1]
	local item = cell.gameObject
	local furnitureCell = FurnitureSlot.PackageOrReuseView(self, item)

	furnitureCell:SetItem(IllustrationsData.cfgInfo.Item, IllustrationsData.activation, IllustrationsData.cfgInfo.Id)

	if self.currentSelectSlot ~= nil then
		self.currentSelectSlot:SetSelected(false)
	end

	self.currentSelectSlot = furnitureCell

	self.currentSelectSlot:SetSelected(true)
	self:ShowDetails()
end

function FurnitureHandbookUI:ShowDetails()
	if self.currentSelectSlot ~= nil then
		local cid = self.currentSelectSlot.cfgItemID
		local cfgDecorateID = self.currentSelectSlot.cfgDecorateID

		self.TextTitle:GetComponent("Text").text = CfgHomeLandDecorateThemeTable[CfgHomeLandDecorateTable[cfgDecorateID].ThemeID].Name

		local cfgItem = CfgItemTable[cid]

		self.Btn1:SetActive(false)
		self.Btn2:SetActive(false)

		if cfgItem ~= nil then
			self.TextName:GetComponent("Text").text = cfgItem.Name
			self.TextScore:GetComponent("Text").text = CfgHomeLandDecorateTable[cfgDecorateID].Score
			self.TextDesMsg:GetComponent("Text").text = cfgItem.Describe

			local iconPath = UIGlobalApi.GetIconPath(cfgItem.Icon)

			AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))

			local parentTransform = self.StarBox.transform

			for i = 0, parentTransform.childCount - 1 do
				local obj = parentTransform:GetChild(0).gameObject

				UnityEngine.GameObject.DestroyImmediate(obj)
			end

			for i = 1, 5 do
				local starObj

				if i <= cfgItem.Star then
					starObj = UnityEngine.Object.Instantiate(self.Start1)

					starObj:SetActive(true)
				else
					starObj = UnityEngine.Object.Instantiate(self.Start2)

					starObj:SetActive(false)
				end

				starObj.transform:SetParent(parentTransform, false)
			end

			if cfgItem.Source[1] ~= nil then
				self.Btn1:SetActive(true)

				self.cfgFun1 = CfgFunctionTable[cfgItem.Source[1]]
				self.BtnText1:GetComponent("Text").text = self.cfgFun1.Name
				iconPath = UIGlobalApi.GetImagePath("/" .. self.cfgFun1.Icon)

				AssetUtil.LoadImage(self, iconPath, self.BtnIcon1:GetComponent("Image"))
			end

			if cfgItem.Source[2] ~= nil then
				self.Btn2:SetActive(true)

				self.cfgFun2 = CfgFunctionTable[cfgItem.Source[2]]
				self.BtnText2:GetComponent("Text").text = self.cfgFun2.Name
				iconPath = UIGlobalApi.GetImagePath("/" .. self.cfgFun2.Icon)

				AssetUtil.LoadImage(self, iconPath, self.BtnIcon2:GetComponent("Image"))
			end
		end
	end
end

function FurnitureHandbookUI:OnClickBtn1()
	JumpModule.Jump(self.cfgFun1.Id)
	UIModule.Close(Constant.UIControllerName.FurnitureHandbookUI)
end

function FurnitureHandbookUI:OnClickBtn2()
	JumpModule.Jump(self.cfgFun2.Id)
	UIModule.Close(Constant.UIControllerName.FurnitureHandbookUI)
end

function FurnitureHandbookUI:OnClickBtnBack()
	UIModule.Close(Constant.UIControllerName.FurnitureHandbookUI)
end

return FurnitureHandbookUI
