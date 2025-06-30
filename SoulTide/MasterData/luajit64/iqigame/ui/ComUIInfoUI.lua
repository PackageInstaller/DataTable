-- chunkname: @IQIGame\\UI\\ComUIInfoUI.lua

local ComUIInfoUI = Base:Extend("ComUIInfoUI", "IQIGame.Onigao.UI.ComUIInfoUI", {
	currentIndex = 1,
	toggles = {},
	childPageCells = {}
})
local ComUIInfoChildPageView = require("IQIGame.UI.ComUIInfoUI.ComUIInfoChildPageView")

function ComUIInfoUI:OnInit()
	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end
end

function ComUIInfoUI:GetPreloadAssetPaths()
	return nil
end

function ComUIInfoUI:GetOpenPreloadAssetPaths(userData)
	local cfgGuideBrief = CfgGuideBriefTable[userData]

	self.navigationTab = {}

	for i = 1, #cfgGuideBrief.BelongPrefab do
		local tab = {}

		tab[1] = cfgGuideBrief.BelongPrefab[i]
		tab[2] = cfgGuideBrief["Prefab_" .. i]

		table.insert(self.navigationTab, tab)
	end

	self.preloadPath = {}

	for i = 1, #self.navigationTab do
		local tab = self.navigationTab[i]
		local path = UIGlobalApi.GetUIPrefab(tab[1])

		table.insert(self.preloadPath, path)
	end

	return self.preloadPath
end

function ComUIInfoUI:IsManualShowOnOpen(userData)
	return false
end

function ComUIInfoUI:GetBGM(userData)
	return nil
end

function ComUIInfoUI:OnOpen(userData)
	self:UpDateView()
end

function ComUIInfoUI:OnClose(userData)
	return
end

function ComUIInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function ComUIInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function ComUIInfoUI:OnPause()
	return
end

function ComUIInfoUI:OnResume()
	return
end

function ComUIInfoUI:OnCover()
	return
end

function ComUIInfoUI:OnReveal()
	return
end

function ComUIInfoUI:OnRefocus(userData)
	return
end

function ComUIInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ComUIInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ComUIInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ComUIInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ComUIInfoUI:OnDestroy()
	for goInstanceID, cell in pairs(self.childPageCells) do
		cell:Dispose()
	end
end

function ComUIInfoUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ComUIInfoUI)
end

function ComUIInfoUI:UpDateView()
	self.toggles = {}

	for i = 0, self.Toggles.transform.childCount - 1 do
		local obj = self.Toggles.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for i = 1, #self.navigationTab do
		local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

		obj.transform:SetParent(self.Toggles.transform, false)
		obj:SetActive(true)

		local toggle = obj:GetComponent("Toggle")

		toggle.interactable = false
		toggle.group = self.Toggles:GetComponent("ToggleGroup")

		if self.currentIndex == i then
			toggle.isOn = true
		else
			toggle.isOn = false
		end

		self.toggles[i] = toggle
	end

	self.scrollList:Refresh(#self.navigationTab)
	self:ShowCurrentIndexPage()
end

function ComUIInfoUI:ShowNextPate()
	if self.currentIndex > #self.navigationTab then
		self.currentIndex = 1
		self.scrollList.startIndex = 0

		self.scrollList:Refresh(#self.navigationTab)
	else
		self.scrollList:TurnToForward()
	end
end

function ComUIInfoUI:OnRenderCell(cell)
	local tabData = self.navigationTab[cell.index + 1]
	local prefabPackageCell = self.childPageCells[cell.gameObject:GetInstanceID()]

	if prefabPackageCell == nil then
		prefabPackageCell = ComUIInfoChildPageView.New(cell.gameObject, self)

		function prefabPackageCell.nextPageCallBack(index)
			self:OnClickNextPage(index)
		end

		self.childPageCells[cell.gameObject:GetInstanceID()] = prefabPackageCell
	end

	prefabPackageCell:SetData(tabData, cell.index + 1, #self.navigationTab)
end

function ComUIInfoUI:OnPageReachedMain(page)
	self.currentIndex = page.index + 1

	self:ShowCurrentIndexPage()
end

function ComUIInfoUI:OnClickNextPage(index)
	self.currentIndex = index + 1

	self:ShowNextPate()
end

function ComUIInfoUI:ShowCurrentIndexPage()
	self.toggles[self.currentIndex].isOn = true
end

return ComUIInfoUI
