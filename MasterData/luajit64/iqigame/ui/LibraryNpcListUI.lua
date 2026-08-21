-- chunkname: @IQIGame\\UI\\LibraryNpcListUI.lua

local LibraryNpcListUI = Base:Extend("LibraryNpcListUI", "IQIGame.Onigao.UI.LibraryNpcListUI", {
	currentPage = 1,
	pageCount = 8,
	townNpc = {},
	NpcListCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LibraryNpcCell = require("IQIGame.UI.Library.LibraryNpcCell")

function LibraryNpcListUI:OnInit()
	UGUIUtil.SetText(self.TextBtnTitle, LibraryNpcListUIApi:GetString("TextBtnTitle"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateBtnRight()
		self:OnClickBtnRight()
	end

	function self.delegateBtnLeft()
		self:OnClickBtnLeft()
	end

	function self.delegateToggleValueChange(isOn)
		self:OnClickToggle(isOn)
	end

	function self.delegateUpdateLibraryPage(data)
		self:OnUpdateLibraryPage(data)
	end

	self.NpcListCellPool = UIObjectPool.New(8, function()
		return LibraryNpcCell.New(UnityEngine.Object.Instantiate(self.NpcMould))
	end, function(cell)
		cell:Dispose()
	end)

	self:CreateToggle()
end

function LibraryNpcListUI:GetPreloadAssetPaths()
	return nil
end

function LibraryNpcListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryNpcListUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryNpcListUI:GetBGM(userData)
	return nil
end

function LibraryNpcListUI:OnOpen(userData)
	self:RefreshList(0)
end

function LibraryNpcListUI:OnClose(userData)
	return
end

function LibraryNpcListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	EventDispatcher.AddEventListener(EventID.UpdateLibraryPageEvent, self.delegateUpdateLibraryPage)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.delegateToggleValueChange)
	end
end

function LibraryNpcListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryPageEvent, self.delegateUpdateLibraryPage)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.delegateToggleValueChange)
	end
end

function LibraryNpcListUI:OnPause()
	return
end

function LibraryNpcListUI:OnResume()
	return
end

function LibraryNpcListUI:OnCover()
	return
end

function LibraryNpcListUI:OnReveal()
	return
end

function LibraryNpcListUI:OnRefocus(userData)
	return
end

function LibraryNpcListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryNpcListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryNpcListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryNpcListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryNpcListUI:OnDestroy()
	for i, v in pairs(self.NpcListCells) do
		self.NpcListCellPool:Release(v)
	end

	self.NpcListCells = {}

	self.NpcListCellPool:Dispose()
end

function LibraryNpcListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryNpcListUI)
end

function LibraryNpcListUI:CreateToggle()
	self.townNpc = TownLibraryModule.npcTab

	table.sort(self.townNpc, function(a, b)
		return a.cfgID < b.cfgID
	end)

	self.totalPage = math.ceil(#self.townNpc / self.pageCount)
	self.toggles = {}

	for i = 0, self.Toggles.transform.childCount - 1 do
		local obj = self.Toggles.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for i = 1, self.totalPage do
		local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

		obj.transform:SetParent(self.Toggles.transform, false)

		obj.name = tostring(i)

		obj:SetActive(true)

		local toggle = obj:GetComponent("Toggle")

		toggle.group = self.Toggles:GetComponent("ToggleGroup")

		if self.currentPage == i then
			toggle.isOn = true
		else
			toggle.isOn = false
		end

		self.toggles[i] = toggle
	end
end

function LibraryNpcListUI:OnClickToggle(isOn)
	if isOn then
		local page

		for i = 0, self.Toggles.transform.childCount - 1 do
			local obj = self.Toggles.transform:GetChild(i).gameObject
			local toggle = obj:GetComponent("Toggle")

			if toggle.isOn == true then
				page = tonumber(obj.name)

				break
			end
		end

		if page ~= nil and self.currentPage ~= page then
			self.currentPage = page

			self:RefreshList(self.currentPage - 1)
		end
	end
end

function LibraryNpcListUI:ShowCurrentPage()
	self.BtnLeft:SetActive(self.currentPage ~= 1)
	self.BtnRight:SetActive(self.currentPage ~= self.totalPage)

	self.toggles[self.currentPage].isOn = true
end

function LibraryNpcListUI:GetCurrentPageDate(showPage)
	local tab = {}

	self.townNpc = TownLibraryModule.npcTab

	table.sort(self.townNpc, function(a, b)
		return a.cfgID < b.cfgID
	end)

	for i = 1, #self.townNpc do
		local page = math.ceil(i / self.pageCount)

		if page == showPage then
			table.insert(tab, self.townNpc[i])
		end
	end

	return tab
end

function LibraryNpcListUI:OnClickBtnLeft()
	self.scrollList:TurnToBackward()
end

function LibraryNpcListUI:OnClickBtnRight()
	self.scrollList:TurnToForward()
end

function LibraryNpcListUI:OnUpdateLibraryPage(data)
	if data[1] == "LibraryNpcListUI" then
		local npcData = data[2]
		local page

		for i = 1, #self.townNpc do
			local npc = self.townNpc[i]

			if npc.cfgID == npcData.cfgID then
				page = math.ceil(i / self.pageCount)

				break
			end
		end

		if page and page ~= self.currentPage then
			self.currentPage = page

			self:RefreshList(self.currentPage - 1)
		end
	end
end

function LibraryNpcListUI:RefreshList(startIndex)
	for i, v in pairs(self.NpcListCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.NpcListCellPool:Release(v)
	end

	self.NpcListCells = {}
	self.scrollList.startIndex = startIndex

	self.scrollList:Refresh(self.totalPage)
end

function LibraryNpcListUI:OnRenderCell(pageCell)
	local goObj = pageCell.gameObject

	goObj:SetActive(true)

	local index = pageCell.index + 1
	local pageNpc = self:GetCurrentPageDate(index)

	for i = 1, #pageNpc do
		local npcData = pageNpc[i]
		local cell = self.NpcListCellPool:Obtain()

		cell.View.transform:SetParent(goObj.transform, false)
		cell.View:SetActive(true)
		cell:SetData(npcData)
		table.insert(self.NpcListCells, cell)
	end
end

function LibraryNpcListUI:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	self:ShowCurrentPage()
end

return LibraryNpcListUI
