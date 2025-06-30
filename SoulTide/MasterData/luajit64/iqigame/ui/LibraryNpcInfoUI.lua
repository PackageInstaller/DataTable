-- chunkname: @IQIGame\\UI\\LibraryNpcInfoUI.lua

local LibraryNpcInfoUI = Base:Extend("LibraryNpcInfoUI", "IQIGame.Onigao.UI.LibraryNpcInfoUI", {
	npcPlateRenders = {}
})
local LibraryNpcPlateRender = require("IQIGame.UI.Library.LibraryNpcPlateRender")
local TitleStr = {
	LibraryNpcListUIApi:GetString("NpcResName"),
	LibraryNpcListUIApi:GetString("NpcResOccupation"),
	LibraryNpcListUIApi:GetString("NpcResHeight"),
	LibraryNpcListUIApi:GetString("NpcResWeight"),
	LibraryNpcListUIApi:GetString("NpcResSpeciality"),
	LibraryNpcListUIApi:GetString("NpcResWeakness"),
	LibraryNpcListUIApi:GetString("NpcResLike"),
	LibraryNpcListUIApi:GetString("NpcResHate"),
	LibraryNpcListUIApi:GetString("NpcResLabel")
}

function LibraryNpcInfoUI:OnInit()
	UGUIUtil.SetText(self.TextPanelTitle, LibraryNpcListUIApi:GetString("TextPanelTitle"))
	UGUIUtil.SetText(self.TextLock, LibraryNpcListUIApi:GetString("TextLock"))

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
		self:OnBtnRight()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	self.npcPlateRenders = {}

	for i = 1, 3 do
		local npcPlate = LibraryNpcPlateRender.New(self["Content" .. i])

		self.npcPlateRenders[i] = npcPlate
	end
end

function LibraryNpcInfoUI:GetPreloadAssetPaths()
	return nil
end

function LibraryNpcInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryNpcInfoUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryNpcInfoUI:GetBGM(userData)
	return nil
end

function LibraryNpcInfoUI:OnOpen(userData)
	self.townLibraryNpcData = userData
	self.townNpc = TownLibraryModule.npcTab

	table.sort(self.townNpc, function(a, b)
		return a.cfgID < b.cfgID
	end)

	for i = 1, #self.townNpc do
		local npcData = self.townNpc[i]

		if npcData.cfgID == self.townLibraryNpcData.cfgID then
			self.index = i

			break
		end
	end

	self:RefreshList(self.index - 1)
end

function LibraryNpcInfoUI:OnClose(userData)
	return
end

function LibraryNpcInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
end

function LibraryNpcInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
end

function LibraryNpcInfoUI:OnPause()
	return
end

function LibraryNpcInfoUI:OnResume()
	return
end

function LibraryNpcInfoUI:OnCover()
	return
end

function LibraryNpcInfoUI:OnReveal()
	return
end

function LibraryNpcInfoUI:OnRefocus(userData)
	return
end

function LibraryNpcInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryNpcInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryNpcInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryNpcInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryNpcInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.npcPlateRenders) do
		v:Dispose()
	end
end

function LibraryNpcInfoUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryNpcInfoUI)
end

function LibraryNpcInfoUI:ShowCurrentPage()
	UGUIUtil.SetText(self.TextNpcName, self.townLibraryNpcData.cfgInfo.Name)
	UGUIUtil.SetText(self.TextNpcNameEng, self.townLibraryNpcData.cfgInfo.EngName)
	self.BtnLeft:SetActive(self.index ~= 1)
	self.BtnRight:SetActive(self.index ~= #self.townNpc)
	self.Normal:SetActive(self.townLibraryNpcData.isLock)
	self.Lock:SetActive(not self.townLibraryNpcData.isLock)
	self.LockImg:SetActive(not self.townLibraryNpcData.isLock)
	UGUIUtil.SetText(self.TextMsg, LibraryNpcListUIApi:GetString("TextMsg"))

	local npcResDataTab = self.townLibraryNpcData:GetResByType(Constant.NPCType.NpcResHeight)

	if npcResDataTab[1].isLock == false then
		UGUIUtil.SetText(self.TextHeight, LibraryNpcListUIApi:GetString("Unlocked", TitleStr[Constant.NPCType.NpcResHeight]))
	else
		UGUIUtil.SetText(self.TextHeight, LibraryNpcListUIApi:GetString("ResValue", TitleStr[Constant.NPCType.NpcResHeight], npcResDataTab[1].Describe))
	end

	npcResDataTab = self.townLibraryNpcData:GetResByType(Constant.NPCType.NpcResWeight)

	if npcResDataTab[1].isLock == false then
		UGUIUtil.SetText(self.TextWeight, LibraryNpcListUIApi:GetString("Unlocked", TitleStr[Constant.NPCType.NpcResWeight]))
	else
		UGUIUtil.SetText(self.TextWeight, LibraryNpcListUIApi:GetString("ResValue", TitleStr[Constant.NPCType.NpcResWeight], npcResDataTab[1].Describe))
	end

	npcResDataTab = self.townLibraryNpcData:GetResByType(Constant.NPCType.NpcResOccupation)

	if npcResDataTab[1].isLock == false then
		UGUIUtil.SetText(self.TextOccupation, LibraryNpcListUIApi:GetString("Unlocked", TitleStr[Constant.NPCType.NpcResOccupation]))
	else
		UGUIUtil.SetText(self.TextOccupation, LibraryNpcListUIApi:GetString("ResValue", TitleStr[Constant.NPCType.NpcResOccupation], npcResDataTab[1].Describe))
	end

	npcResDataTab = self.townLibraryNpcData:GetResByType(Constant.NPCType.NpcResSpeciality)

	local npcPlate1 = self.npcPlateRenders[1]

	npcPlate1:SetData(TitleStr[Constant.NPCType.NpcResSpeciality], npcResDataTab)

	npcResDataTab = self.townLibraryNpcData:GetResByType(Constant.NPCType.NpcResWeakness)

	local npcPlate2 = self.npcPlateRenders[2]

	npcPlate2:SetData(TitleStr[Constant.NPCType.NpcResWeakness], npcResDataTab)

	npcResDataTab = self.townLibraryNpcData:GetResByType(Constant.NPCType.NpcResLike)

	local npcPlate3 = self.npcPlateRenders[3]

	npcPlate3:SetData(TitleStr[Constant.NPCType.NpcResLike], npcResDataTab)

	npcResDataTab = self.townLibraryNpcData:GetResByType(Constant.NPCType.NpcResLabel)

	local maxStart = #npcResDataTab
	local currentStart = 0

	for i, v in pairs(npcResDataTab) do
		if v.isLock then
			currentStart = currentStart + 1
		end
	end

	UGUIUtil.SetText(self.TextDes, self.townLibraryNpcData.cfgInfo.NpcDescribe[currentStart + 1])
	UGUIUtil.SetText(self.TextPer, LibraryNpcListUIApi:GetString("TextPer", currentStart, maxStart))

	for i = 1, 4 do
		self["GridMould" .. i]:SetActive(false)

		local grid = self["Grid" .. i]

		for j = 1, grid.transform.childCount - 1 do
			local obj = grid.transform:GetChild(j).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end
	end

	for i = 1, maxStart - 1 do
		local obj = UnityEngine.Object.Instantiate(self.GridMould1)

		obj.transform:SetParent(self.Grid1.transform, false)
		obj:SetActive(true)
	end

	for i = 1, maxStart do
		local obj = UnityEngine.Object.Instantiate(self.GridMould2)

		obj.transform:SetParent(self.Grid2.transform, false)
		obj:SetActive(true)
	end

	for i = 1, currentStart - 1 do
		local obj = UnityEngine.Object.Instantiate(self.GridMould3)

		obj.transform:SetParent(self.Grid3.transform, false)
		obj:SetActive(true)
	end

	for i = 1, currentStart do
		local obj = UnityEngine.Object.Instantiate(self.GridMould4)

		obj.transform:SetParent(self.Grid4.transform, false)
		obj:SetActive(true)
	end
end

function LibraryNpcInfoUI:OnBtnRight()
	self.scrollList:TurnToForward()
end

function LibraryNpcInfoUI:OnBtnLeft()
	self.scrollList:TurnToBackward()
end

function LibraryNpcInfoUI:RefreshList(startIndex)
	self.scrollList.startIndex = startIndex

	self.scrollList:Refresh(#self.townNpc)
end

function LibraryNpcInfoUI:OnRenderCell(pageCell)
	local goObj = pageCell.gameObject

	goObj:SetActive(true)

	local index = pageCell.index + 1
	local townLibraryNpcData = self.townNpc[index]
	local iconPath = UIGlobalApi.GetImagePath(townLibraryNpcData.cfgInfo.ImageWay)
	local NpcImg = goObj.transform:GetChild(0).gameObject

	AssetUtil.LoadImage(self, iconPath, NpcImg:GetComponent("Image"))

	NpcImg.transform.anchoredPosition = Vector2.New(townLibraryNpcData.cfgInfo.ImgePosition[1], townLibraryNpcData.cfgInfo.ImgePosition[2])
	NpcImg.transform.sizeDelta = Vector2.New(townLibraryNpcData.cfgInfo.ImgeSize[1], townLibraryNpcData.cfgInfo.ImgeSize[2])

	NpcImg:GetComponent("ImageGroupGrayComponent"):EnableGray(not townLibraryNpcData.isLock)
end

function LibraryNpcInfoUI:OnPageReachedMain(page)
	self.index = page.index + 1
	self.townLibraryNpcData = self.townNpc[self.index]

	self:ShowCurrentPage()
	EventDispatcher.Dispatch(EventID.UpdateLibraryPageEvent, {
		"LibraryNpcListUI",
		self.townLibraryNpcData
	})
end

return LibraryNpcInfoUI
