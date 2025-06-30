-- chunkname: @IQIGame\\UI\\Town\\TownAreaBtnRender.lua

TownAreaBtnRender = {}

function TownAreaBtnRender.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		ui.__SUB_UI_MAP_MailMouldCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_MailMouldCell
	local areaBtnRender

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		areaBtnRender = TownAreaBtnRender:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = areaBtnRender
	else
		areaBtnRender = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return areaBtnRender
end

function TownAreaBtnRender:__New(itemCellView)
	local itemCell = Clone(self)

	itemCell.tabComponent = {}
	itemCell.goView = itemCellView

	LuaCodeInterface.BindOutlet(itemCell.goView, itemCell.tabComponent)
	UGUIUtil.SetText(itemCell.tabComponent.TextTitle, TownUIApi:GetString("TextTitle"))

	itemCell.textNameComponent = itemCell.tabComponent.TextLab:GetComponent("Text")
	itemCell.btnSelfComponent = itemCell.goView:GetComponent("Button")
	itemCell.textSpendComponent = itemCell.tabComponent.TextSpend:GetComponent("Text")
	itemCell.imgSpendComponent = itemCell.tabComponent.ImgSpend:GetComponent("Image")

	function itemCell.delegateClickBtnSelf()
		itemCell:OnClickBtnSelf()
	end

	return itemCell
end

function TownAreaBtnRender.DisposeIn(ui)
	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_MailMouldCell) do
		itemCell.tabComponent = nil

		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_MailMouldCell = nil
end

function TownAreaBtnRender:SetItem(townFunctionData)
	self.townFunctionData = townFunctionData

	if self.townFunctionData == nil then
		self:Clear()
	else
		self:Update()
	end
end

function TownAreaBtnRender:AddListener()
	self.btnSelfComponent.onClick:AddListener(self.delegateClickBtnSelf)
end

function TownAreaBtnRender:RemoveListener()
	self.btnSelfComponent.onClick:RemoveListener(self.delegateClickBtnSelf)
end

function TownAreaBtnRender:Update()
	self:AddListener()
	self.tabComponent.Mould1:SetActive(false)
	self.tabComponent.Mould2:SetActive(false)
	self.tabComponent.Mould3:SetActive(false)
	self.tabComponent.Mould4:SetActive(false)

	self.textNameComponent.text = self.townFunctionData.name

	if self.townFunctionData.icon ~= nil and self.townFunctionData.icon ~= "" then
		local imgCom

		if self.townFunctionData.threadType == 1 then
			self.tabComponent.Mould1:SetActive(true)

			imgCom = self.tabComponent.Icon1:GetComponent("Image")
		elseif self.townFunctionData.threadType == 2 then
			self.tabComponent.Mould2:SetActive(true)

			imgCom = self.tabComponent.Icon2:GetComponent("Image")
		elseif self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY then
			self.tabComponent.Mould4:SetActive(true)

			imgCom = self.tabComponent.Icon4:GetComponent("Image")
		else
			self.tabComponent.Mould3:SetActive(true)

			imgCom = self.tabComponent.Icon3:GetComponent("Image")
		end

		local iconPath = UIGlobalApi.ImagePath .. self.townFunctionData.icon

		AssetUtil.LoadImage(self, iconPath, imgCom)
	end

	self.textSpendComponent.gameObject:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING)
	self.imgSpendComponent.gameObject:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING)
	self.tabComponent.TextTitle.gameObject:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING)
	self.tabComponent.Cast:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING)

	local spendID = CfgTownAreaTable[self.townFunctionData.ownerShipAreaID].WanderCost[1]
	local needNum = CfgTownAreaTable[self.townFunctionData.ownerShipAreaID].WanderCost[2]

	self.textSpendComponent.text = tostring(needNum)

	local ItemIconPath = UIGlobalApi.GetIconPath(CfgItemTable[spendID].Icon)

	AssetUtil.LoadImage(self, ItemIconPath, self.imgSpendComponent)
end

function TownAreaBtnRender:OnClickBtnSelf()
	TownModule.ExecutionEvent(self.townFunctionData)

	if self.clickSelfCallBack ~= nil then
		self.clickSelfCallBack()
	end
end

function TownAreaBtnRender:Clear()
	self.goView:SetActive(false)
	AssetUtil.UnloadAsset(self)

	self.clickSelfCallBack = nil

	self:RemoveListener()
end

function TownAreaBtnRender:Dispose()
	self:Clear()
	LuaCodeInterface.ClearOutlet(self.goView, self.tabComponent)
	UnityEngine.GameObject.DestroyImmediate(self.goView)

	self.goView = nil
end

return TownAreaBtnRender
