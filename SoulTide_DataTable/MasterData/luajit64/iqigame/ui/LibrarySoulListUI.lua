-- chunkname: @IQIGame\\UI\\LibrarySoulListUI.lua

local LibrarySoulListUI = {
	pageCount = 8,
	currentPage = 1,
	townSoul = {},
	SoulListPageCellPool = {}
}

LibrarySoulListUI = Base:Extend("LibrarySoulListUI", "IQIGame.Onigao.UI.LibrarySoulListUI", LibrarySoulListUI)

local LibrarySoulListPageCell = require("IQIGame.UI.Library.LibrarySoulListPageCell")

function LibrarySoulListUI:OnInit()
	UGUIUtil.SetText(self.TextPanelTitle, LibrarySoulApi:GetString("TextSoulListTitle"))

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

	self:CreateToggle()
end

function LibrarySoulListUI:GetPreloadAssetPaths()
	return nil
end

function LibrarySoulListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibrarySoulListUI:IsManualShowOnOpen(userData)
	return false
end

function LibrarySoulListUI:GetBGM(userData)
	return nil
end

function LibrarySoulListUI:OnOpen(userData)
	self:RefreshList(0)
end

function LibrarySoulListUI:OnClose(userData)
	return
end

function LibrarySoulListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	EventDispatcher.AddEventListener(EventID.UpdateLibraryPageEvent, self.delegateUpdateLibraryPage)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.delegateToggleValueChange)
	end
end

function LibrarySoulListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryPageEvent, self.delegateUpdateLibraryPage)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.delegateToggleValueChange)
	end
end

function LibrarySoulListUI:OnPause()
	return
end

function LibrarySoulListUI:OnResume()
	return
end

function LibrarySoulListUI:OnCover()
	return
end

function LibrarySoulListUI:OnReveal()
	return
end

function LibrarySoulListUI:OnRefocus(userData)
	return
end

function LibrarySoulListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibrarySoulListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibrarySoulListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibrarySoulListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibrarySoulListUI:OnDestroy()
	for i, v in pairs(self.SoulListPageCellPool) do
		v:Dispose()
	end
end

function LibrarySoulListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibrarySoulListUI)
end

function LibrarySoulListUI:CreateToggle()
	self.townSoul = TownLibraryModule.SoulTab

	table.sort(self.townSoul, function(a, b)
		return a.cfgID < b.cfgID
	end)

	self.totalPage = math.ceil(#self.townSoul / self.pageCount)
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
		self.toggles[i] = toggle
	end

	self.toggles[self.currentPage].isOn = true
end

function LibrarySoulListUI:OnClickToggle(isOn)
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

function LibrarySoulListUI:ShowCurrentPage()
	self.BtnLeft:SetActive(self.currentPage ~= 1)
	self.BtnRight:SetActive(self.currentPage ~= self.totalPage)

	if not self.toggles[self.currentPage].isOn then
		self.toggles[self.currentPage].isOn = true
	end
end

function LibrarySoulListUI:GetCurrentPageDate(showPage)
	local tab = {}

	self.townSoul = TownLibraryModule.SoulTab

	table.sort(self.townSoul, function(a, b)
		return a.cfgID < b.cfgID
	end)

	for i = 1, #self.townSoul do
		local page = math.ceil(i / self.pageCount)

		if page == showPage then
			table.insert(tab, self.townSoul[i])
		end
	end

	return tab
end

function LibrarySoulListUI:OnClickBtnLeft()
	self.scrollList:TurnToBackward()
end

function LibrarySoulListUI:OnClickBtnRight()
	self.scrollList:TurnToForward()
end

function LibrarySoulListUI:OnUpdateLibraryPage(data)
	if data[1] == "LibrarySoulListUI" then
		local npcData = data[2]
		local page

		for i = 1, #self.townSoul do
			local npc = self.townSoul[i]

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

function LibrarySoulListUI:RefreshList(startIndex)
	self.scrollList.startIndex = startIndex

	self.scrollList:Refresh(self.totalPage)
end

function LibrarySoulListUI:OnRenderCell(pageCell)
	local index = pageCell.index + 1
	local pageSoul = self:GetCurrentPageDate(index)
	local instanceID = pageCell.gameObject:GetInstanceID()
	local soulListPageCell = self.SoulListPageCellPool[instanceID]

	if soulListPageCell == nil then
		soulListPageCell = LibrarySoulListPageCell.New(pageCell.gameObject)
		self.SoulListPageCellPool[instanceID] = soulListPageCell
	end

	soulListPageCell:SetData(pageSoul)
end

function LibrarySoulListUI:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	self:ShowCurrentPage()
end

return LibrarySoulListUI
