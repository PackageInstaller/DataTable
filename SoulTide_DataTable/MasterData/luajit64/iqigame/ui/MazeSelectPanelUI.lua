-- chunkname: @IQIGame\\UI\\MazeSelectPanelUI.lua

local MazeSelectPanelUI = Base:Extend("MazeSelectPanelUI", "IQIGame.Onigao.UI.MazeSelectPanelUI", {
	ActualSelectedIndex = 0,
	ShopOptionBtns = {},
	OptionBtns = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeSelectOptionItem = require("IQIGame.UI.MazeSelectPanel.MazeSelectOptionItem")

function MazeSelectPanelUI:OnInit()
	function self.DelegateOnClickNormalOption(index)
		self:OnClickNormalOption(index)
	end

	function self.DelegateOnClickShopOption(index)
		self:OnClickShopOption(index)
	end

	self.OptionBtnPool = UIObjectPool.New(6, function()
		local item = MazeSelectOptionItem.New(UnityEngine.Object.Instantiate(self.OptionBtnPrefab), self.DelegateOnClickOption)

		return item
	end, function(obj)
		local view = obj.View

		obj:Dispose()
		UnityEngine.Object.Destroy(view)
	end)

	self.BtnGrid:SetActive(false)
end

function MazeSelectPanelUI:GetPreloadAssetPaths()
	return nil
end

function MazeSelectPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeSelectPanelUI:OnOpen(userData)
	self.BtnGrid:SetActive(true)
	self:UpdateView(userData.selectionCid)
	MazeModule.CloseMazeManualUI()
end

function MazeSelectPanelUI:OnClose(userData)
	self:ClearShopOptions()
	self:ClearOptions()
	self.BtnGrid:SetActive(false)
end

function MazeSelectPanelUI:OnAddListeners()
	return
end

function MazeSelectPanelUI:OnRemoveListeners()
	return
end

function MazeSelectPanelUI:OnPause()
	return
end

function MazeSelectPanelUI:OnResume()
	return
end

function MazeSelectPanelUI:OnCover()
	return
end

function MazeSelectPanelUI:OnReveal()
	return
end

function MazeSelectPanelUI:OnRefocus(userData)
	return
end

function MazeSelectPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSelectPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSelectPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	userData.sprite = LuaCodeInterface.ToSprite(asset)
end

function MazeSelectPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSelectPanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:ClearShopOptions(true)
	self:ClearOptions(true)
	self.OptionBtnPool:Dispose()
end

function MazeSelectPanelUI:UpdateView(mazeSelectionCid)
	self.CfgMazeSelectionData = CfgMazeSelectionTable[mazeSelectionCid]

	local checkSucceeded
	local contentText = ""

	for i = 1, #self.CfgMazeSelectionData.DialogCondition do
		checkSucceeded = ConditionModule.Check(self.CfgMazeSelectionData.DialogCondition[i])

		if checkSucceeded then
			contentText = self.CfgMazeSelectionData.Dialog[i]

			break
		end
	end

	self:ShowShopOptions()
	self:ShowOptions(self.CfgMazeSelectionData)
	self.ContentView:SetActive(contentText ~= "")
	UGUIUtil.SetText(self.ContentText, contentText)
end

function MazeSelectPanelUI:ShowShopOptions()
	self:ClearShopOptions()

	local currentInteractingElement = MazeDataModule.GetCurrentElement()

	if currentInteractingElement ~= nil then
		local cfgElementData = CfgElementAllTable[currentInteractingElement.CID]

		for i = 1, #cfgElementData.ShopList do
			local cfgShopData = CfgShopTable[cfgElementData.ShopList[i]]
			local item = self.OptionBtnPool:Obtain()

			item.View:SetActive(true)
			item.View.transform:SetParent(self.BtnGrid.transform, false)
			item:SetData(i, cfgShopData.Name, true, nil, self.DelegateOnClickShopOption)

			self.ShopOptionBtns[i] = item
		end
	end
end

function MazeSelectPanelUI:ShowOptions(cfgMazeSelectionData)
	self:ClearOptions()

	self.VisibleOptionIndexes = {}

	local visibleOptionNames = {}
	local chooseConditions = {}

	for i = 1, #cfgMazeSelectionData.ShowCondition do
		if ConditionModule.Check(cfgMazeSelectionData.ShowCondition[i]) then
			table.insert(visibleOptionNames, cfgMazeSelectionData.SelectionName[i])
			table.insert(self.VisibleOptionIndexes, i)
			table.insert(chooseConditions, cfgMazeSelectionData.ChooseCondition[i])
		end
	end

	for i = 1, #visibleOptionNames do
		local text = visibleOptionNames[i]
		local conditionCID = chooseConditions[i]
		local conditionText
		local isOK = ConditionModule.Check(conditionCID)

		if conditionCID ~= 0 then
			local cfgConditionData = CfgConditionTable[conditionCID]

			conditionText = ConditionModule.GetDesc(cfgConditionData, isOK)
		end

		local item = self.OptionBtnPool:Obtain()

		item.View:SetActive(true)
		item.View.transform:SetParent(self.BtnGrid.transform, false)
		item:SetData(i, text, isOK, conditionText, self.DelegateOnClickNormalOption)

		self.OptionBtns[i] = item
	end
end

function MazeSelectPanelUI:ClearShopOptions(destroy)
	for i = 1, #self.ShopOptionBtns do
		local item = self.ShopOptionBtns[i]

		if not destroy then
			item.View.transform:SetParent(self.UIController.transform, false)
		end

		item.View:SetActive(false)
		self.OptionBtnPool:Release(item)
	end

	self.ShopOptionBtns = {}
end

function MazeSelectPanelUI:ClearOptions(destroy)
	for i = 1, #self.OptionBtns do
		local item = self.OptionBtns[i]

		if not destroy then
			item.View.transform:SetParent(self.UIController.transform, false)
		end

		item.View:SetActive(false)
		self.OptionBtnPool:Release(item)
	end

	self.OptionBtns = {}
end

function MazeSelectPanelUI:OnClickShopOption(index)
	local currentInteractingElement = MazeDataModule.GetCurrentElement()

	if currentInteractingElement ~= nil then
		local cfgElementData = CfgElementAllTable[currentInteractingElement.CID]
		local shopCID = cfgElementData.ShopList[index]

		UIModule.Close(Constant.UIControllerName.MazeSelectPanelUI)
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_OPEN_SHOP, {
			NpcID = currentInteractingElement.CID,
			ShopCid = shopCID
		})
	end
end

function MazeSelectPanelUI:OnClickNormalOption(index)
	local actualIndex = self.VisibleOptionIndexes[index]

	self.ActualSelectedIndex = actualIndex

	local chooseCost = self.CfgMazeSelectionData.ChooseCost

	if #chooseCost > 1 then
		local costLengthOfEveryChoice = #chooseCost / #self.CfgMazeSelectionData.SelectionName
		local costStartIndex = costLengthOfEveryChoice * (actualIndex - 1) + 1
		local costLength = costStartIndex + costLengthOfEveryChoice
		local consumeText = ""
		local itemID, itemNum
		local costNum = 0

		for i = costStartIndex, costLength, 2 do
			itemID = tonumber(chooseCost[i])
			itemNum = tonumber(chooseCost[i + 1])

			if itemID == 0 then
				break
			end

			consumeText = consumeText .. CfgItemTable[itemID].Name .. " " .. itemNum

			if i < costLength then
				consumeText = consumeText .. ", "
			end

			costNum = costNum + 1
		end

		if costNum > 0 then
			NoticeModule.ShowNotice(50000001, self.ConsumeConfirm, self.ConsumeCancel, self, consumeText)
		else
			self:EndSelect(actualIndex)
		end
	else
		self:EndSelect(actualIndex)
	end
end

function MazeSelectPanelUI:EndSelect(index)
	UIModule.Close(Constant.UIControllerName.MazeSelectPanelUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SELECTION_PANEL_END, {
		SelectIndex = index
	})
end

function MazeSelectPanelUI:ConsumeConfirm()
	self:EndSelect(self.ActualSelectedIndex)
end

function MazeSelectPanelUI:ConsumeCancel()
	return
end

return MazeSelectPanelUI
