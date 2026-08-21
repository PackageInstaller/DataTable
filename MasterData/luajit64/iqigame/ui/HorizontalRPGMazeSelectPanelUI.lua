-- chunkname: @IQIGame\\UI\\HorizontalRPGMazeSelectPanelUI.lua

local HorizontalRPGMazeSelectPanelUI = {
	ActualSelectedIndex = 0,
	OptionBtns = {}
}

HorizontalRPGMazeSelectPanelUI = Base:Extend("HorizontalRPGMazeSelectPanelUI", "IQIGame.Onigao.UI.HorizontalRPGMazeSelectPanelUI", HorizontalRPGMazeSelectPanelUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeSelectOptionItem = require("IQIGame.UI.MazeSelectPanel.MazeSelectOptionItem")

function HorizontalRPGMazeSelectPanelUI:OnInit()
	function self.DelegateOnClickNormalOption(index)
		self:OnClickNormalOption(index)
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

function HorizontalRPGMazeSelectPanelUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGMazeSelectPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGMazeSelectPanelUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGMazeSelectPanelUI:GetBGM(userData)
	return nil
end

function HorizontalRPGMazeSelectPanelUI:OnOpen(userData)
	self.BtnGrid:SetActive(true)
	self:UpdateView(userData.selectionCid)
	EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
end

function HorizontalRPGMazeSelectPanelUI:OnClose(userData)
	self:ClearOptions()
	self.BtnGrid:SetActive(false)
	EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, false)
	UIModule.Close(Constant.UIControllerName.HorizontalRPGMazeBagUI)
end

function HorizontalRPGMazeSelectPanelUI:OnAddListeners()
	return
end

function HorizontalRPGMazeSelectPanelUI:OnRemoveListeners()
	return
end

function HorizontalRPGMazeSelectPanelUI:OnPause()
	return
end

function HorizontalRPGMazeSelectPanelUI:OnResume()
	return
end

function HorizontalRPGMazeSelectPanelUI:OnCover()
	return
end

function HorizontalRPGMazeSelectPanelUI:OnReveal()
	return
end

function HorizontalRPGMazeSelectPanelUI:OnRefocus(userData)
	return
end

function HorizontalRPGMazeSelectPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGMazeSelectPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGMazeSelectPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	userData.sprite = LuaCodeInterface.ToSprite(asset)
end

function HorizontalRPGMazeSelectPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGMazeSelectPanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:ClearOptions(true)
	self.OptionBtnPool:Dispose()
end

function HorizontalRPGMazeSelectPanelUI:UpdateView(choiceID)
	self.CfgChoicesData = CfgHorizontalRPGChoicesTable[choiceID]

	local contentText = ""

	for i = 1, #self.CfgChoicesData.Dialog do
		contentText = self.CfgChoicesData.Dialog[i]

		break
	end

	self:ShowOptions(self.CfgChoicesData)
	self.ContentView:SetActive(contentText ~= "")
	UGUIUtil.SetText(self.ContentText, contentText)
end

function HorizontalRPGMazeSelectPanelUI:ShowOptions(cfgHorizontalRPGChoiceData)
	self:ClearOptions()

	self.VisibleOptionIndexes = {}

	local visibleOptionNames = {}
	local chooseConditions = {}

	for i = 1, #cfgHorizontalRPGChoiceData.ShowCondition do
		if ConditionModule.Check(cfgHorizontalRPGChoiceData.ShowCondition[i]) then
			table.insert(visibleOptionNames, cfgHorizontalRPGChoiceData.SelectionName[i])
			table.insert(self.VisibleOptionIndexes, i)
			table.insert(chooseConditions, cfgHorizontalRPGChoiceData.ChooseCondition[i])
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

function HorizontalRPGMazeSelectPanelUI:ClearOptions(destroy)
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

function HorizontalRPGMazeSelectPanelUI:OnClickNormalOption(index)
	local actualIndex = self.VisibleOptionIndexes[index]

	self.ActualSelectedIndex = actualIndex

	self:EndSelect(actualIndex)
end

function HorizontalRPGMazeSelectPanelUI:EndSelect(index)
	UIModule.CloseSelf(self)

	local servers = self.CfgChoicesData.SelectionService[index]

	log("执行选项服务 index = " .. index .. " " .. self.CfgChoicesData.SelectionName[index])

	if #servers > 0 then
		HorizontalRPGModule.ElementExecutionElse(servers)
	end
end

return HorizontalRPGMazeSelectPanelUI
