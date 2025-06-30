-- chunkname: @IQIGame\\UI\\CommonConditionSelectionUI.lua

local toggleItemView = {}

function toggleItemView.New(view, clickHandler)
	local obj = Clone(toggleItemView)

	obj:Init(view, clickHandler)

	return obj
end

function toggleItemView:Init(view, clickHandler)
	self.View = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickToggle(isOn)
		self:OnClickToggle(isOn)
	end

	self.toggle:GetComponent("Toggle").isOn = false

	self:AddListeners()
end

function toggleItemView:AddListeners()
	self.toggle:GetComponent("Toggle").onValueChanged:AddListener(self.delegateOnClickToggle)
end

function toggleItemView:RemoveListeners()
	self.toggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateOnClickToggle)
end

function toggleItemView:SetData(index, conditionType, condition)
	self.condition = condition
	self.toggle:GetComponent("Toggle").isOn = false

	if conditionType == Constant.CommonConditionSelectionType.Quality then
		UGUIUtil.SetText(self.toggleText, CommonConditionSelectionUIApi:GetQualityTitle(condition))
	elseif conditionType == Constant.CommonConditionSelectionType.Color then
		UGUIUtil.SetText(self.toggleText, CommonConditionSelectionUIApi:GetColorTitle(condition))
	end

	if index == 1 then
		self.toggle:GetComponent("Toggle").isOn = true
	end
end

function toggleItemView:OnClickToggle(isOn)
	if self.clickHandler ~= nil then
		self.clickHandler(isOn, self.condition)
	end
end

function toggleItemView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function toggleItemView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function toggleItemView:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)
end

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local CommonConditionSelectionUI = {
	selectCondition = {}
}

CommonConditionSelectionUI = Base:Extend("CommonConditionSelectionUI", "IQIGame.Onigao.UI.CommonConditionSelectionUI", CommonConditionSelectionUI)

function CommonConditionSelectionUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	self.toggleItemPool = UIViewObjectPool.New(self.ToggleItem, self.ToggleItemContent.transform, function(_view)
		return toggleItemView.New(_view, function(isOn, condition)
			self:ToggleItemClick(isOn, condition)
		end)
	end)
end

function CommonConditionSelectionUI:GetPreloadAssetPaths()
	return nil
end

function CommonConditionSelectionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonConditionSelectionUI:IsManualShowOnOpen(userData)
	return false
end

function CommonConditionSelectionUI:GetBGM(userData)
	return nil
end

function CommonConditionSelectionUI:OnOpen(userData)
	self.conditionType = userData.type
	self.finishCallback = userData.callback
	self.conditionList = userData.conditionList

	self:RefreshShow()
end

function CommonConditionSelectionUI:OnClose(userData)
	return
end

function CommonConditionSelectionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function CommonConditionSelectionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function CommonConditionSelectionUI:OnPause()
	return
end

function CommonConditionSelectionUI:OnResume()
	return
end

function CommonConditionSelectionUI:OnCover()
	return
end

function CommonConditionSelectionUI:OnReveal()
	return
end

function CommonConditionSelectionUI:OnRefocus(userData)
	return
end

function CommonConditionSelectionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonConditionSelectionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonConditionSelectionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonConditionSelectionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonConditionSelectionUI:OnDestroy()
	self.toggleItemPool:Dispose(function(_item)
		_item:Dispose()
	end)
	AssetUtil.UnloadAsset(self)
end

function CommonConditionSelectionUI:RefreshShow()
	self.selectCondition = {}

	self.toggleItemPool:ForItems(function(_item)
		return _item:Hide()
	end)

	for index = 1, #self.conditionList do
		local toggleItem = self.toggleItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		toggleItem:Show()
		toggleItem:SetData(index, self.conditionType, self.conditionList[index])
	end
end

function CommonConditionSelectionUI:ToggleItemClick(isOn, condition)
	local index = table.indexOf(self.selectCondition, condition)

	if isOn then
		if index == -1 then
			table.insert(self.selectCondition, condition)
		end
	elseif index ~= -1 then
		table.remove(self.selectCondition, index)
	end
end

function CommonConditionSelectionUI:OnClickCloseBtn()
	if self.finishCallback ~= nil then
		self.finishCallback(self.selectCondition, true)
	end

	UIModule.Close(Constant.UIControllerName.CommonConditionSelectionUI)
end

function CommonConditionSelectionUI:OnClickConfirmBtn()
	if table.len(self.selectCondition) == 0 then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "至少选择一个")

		return
	end

	if self.finishCallback ~= nil then
		self.finishCallback(self.selectCondition, false)
	end

	UIModule.Close(Constant.UIControllerName.CommonConditionSelectionUI)
end

return CommonConditionSelectionUI
