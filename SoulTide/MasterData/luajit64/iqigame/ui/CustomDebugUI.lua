-- chunkname: @IQIGame\\UI\\CustomDebugUI.lua

local CustomDebugUI = {
	TabIndex = 0,
	TabNames = {
		"Live2D"
	},
	Items = {}
}

CustomDebugUI = Base:Extend("CustomDebugUI", "IQIGame.Onigao.UI.CustomDebugUI", CustomDebugUI)

function CustomDebugUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.TabScrollList = self.TabList:GetComponent("ScrollAreaList")

	function self.TabScrollList.onRenderCell(cell)
		self:OnRenderTab(cell)
	end

	function self.TabScrollList.onSelectedCell(cell)
		self:OnSelectedTab(cell)
	end

	self.InfoScrollList = self.InfoList:GetComponent("ScrollAreaList")

	function self.InfoScrollList.onRenderCell(cell)
		self:OnRenderInfoItem(cell)
	end

	function self.InfoScrollList.onSelectedCell(cell)
		self:OnSelectedInfoItem(cell)
	end
end

function CustomDebugUI:GetPreloadAssetPaths()
	return nil
end

function CustomDebugUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CustomDebugUI:IsManualShowOnOpen(userData)
	return false
end

function CustomDebugUI:GetBGM(userData)
	return nil
end

function CustomDebugUI:OnOpen(userData)
	self:UpdateView()
end

function CustomDebugUI:OnClose(userData)
	return
end

function CustomDebugUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function CustomDebugUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function CustomDebugUI:OnPause()
	return
end

function CustomDebugUI:OnResume()
	return
end

function CustomDebugUI:OnCover()
	return
end

function CustomDebugUI:OnReveal()
	return
end

function CustomDebugUI:OnRefocus(userData)
	return
end

function CustomDebugUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CustomDebugUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CustomDebugUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CustomDebugUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CustomDebugUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.TabScrollList = nil
	self.InfoScrollList = nil
end

function CustomDebugUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function CustomDebugUI:OnRenderTab(cell)
	local name = self.TabNames[cell.index + 1]
	local toggleHelper = cell.gameObject:GetComponent("ToggleHelperComponent")

	toggleHelper.text = name
end

function CustomDebugUI:OnSelectedTab(cell)
	self:ShowDetailByTabIndex(cell.index + 1)
end

function CustomDebugUI:UpdateView()
	self:UpdateDataOfTab1()

	self.TabScrollList.defaultSelectedToggle = 0

	self.TabScrollList:Refresh(#self.TabNames)
end

function CustomDebugUI:UpdateDataOfTab1()
	self.Live2DUIs = {}

	local forms = GameEntry.UI:GetAllLoadedUIForms()

	for i = 0, forms.Length - 1 do
		local uiForm = forms[i]
		local uiController = uiForm.Logic
		local uiCtrl = LuaCodeInterface.GetFieldValue("UIController", "_Script", uiController, nil)

		if uiCtrl.l2dBuilder ~= nil then
			table.insert(self.Live2DUIs, {
				name = uiController.UIName,
				ui = uiCtrl
			})
		end
	end
end

function CustomDebugUI:ShowDetailByTabIndex(tabIndex)
	self.TabIndex = tabIndex

	if tabIndex == 1 then
		self.InfoScrollList:Refresh(#self.Live2DUIs)
	end
end

function CustomDebugUI:OnRenderInfoItem(cell)
	local content

	if self.TabIndex == 1 then
		content = self:RenderViewOfTab1(cell)
	end

	self.Items[cell.gameObject:GetInstanceID()] = content
end

function CustomDebugUI:RenderViewOfTab1(cell)
	local uiData = self.Live2DUIs[cell.index + 1]
	local uiName = uiData.name
	local uiCtrl = uiData.ui

	cell.gameObject:SetActive(uiCtrl ~= nil)

	local isUICanvasEnabled = uiCtrl.UIController:GetComponent("Canvas").enabled
	local l2dInfo = ""

	if uiCtrl.l2dBuilder ~= nil then
		local l2dBuilder = uiCtrl.l2dBuilder
		local isPaused = LuaCodeInterface.GetFieldValue("IQIGame.Onigao.Game.L2DBuilderBase", "_isPaused", l2dBuilder, nil)

		l2dInfo = ", Live2D name: " .. l2dBuilder:GetComponentInChildren(typeof(UnityEngine.Animator)).name .. ", Live2D StateMachine name: " .. l2dBuilder.stateFileName .. ", Live2D isPaused: " .. tostring(isPaused)
	end

	local text = cell.gameObject:GetComponentInChildren(typeof(UnityEngine.UI.Text))

	text.text = "UI: " .. uiName .. ", UI Canvas enabled: " .. tostring(isUICanvasEnabled) .. l2dInfo

	return text.text
end

function CustomDebugUI:OnSelectedInfoItem(cell)
	local content = self.Items[cell.gameObject:GetInstanceID()]

	warning(content)
end

return CustomDebugUI
