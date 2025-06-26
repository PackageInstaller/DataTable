-- chunkname: @IQIGame\\UI\\HomeLandChangeRoomUI.lua

local HomeLandChangeRoomUI = Base:Extend("HomeLandChangeRoomUI", "IQIGame.Onigao.UI.HomeLandChangeRoomUI", {
	selectPage = 1,
	pageCount = 1,
	rooms = {},
	pageRooms = {},
	roomRenderCellPool = {},
	pageCellPool = {}
})
local HomeLandRoomRender = require("IQIGame.UI.HomeLand.HomeLandRoomRender")
local HomeLandChangePageCell = require("IQIGame.UI.HomeLand.HomeLandChangeRoom.HomeLandChangePageCell")

require("IQIGame.UIExternalApi.HomeLandChangeRoomUIApi")

function HomeLandChangeRoomUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, HomeLandChangeRoomUIApi:GetString("TextTitle", false))
	UGUIUtil.SetText(self.TextTitleEng, HomeLandChangeRoomUIApi:GetString("TextTitle", true))

	self.btnBackComponent = self.BtnBack:GetComponent("Button")
	self.roomListComponent = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.roomListComponent.onSelectedCell(cell)
		self:OnClickCell(cell)
	end

	function self.roomListComponent.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.PageScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderPageCell(cell)
	end
	self.PageScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectPageCell(cell)
	end

	function self.delegateOnBtnBack()
		self:OnClickBackBtn()
	end

	self.pageCount = CfgDiscreteDataTable[6520099].Data[1]
end

function HomeLandChangeRoomUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandChangeRoomUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandChangeRoomUI:OnOpen(userData)
	self:UpdateView()
end

function HomeLandChangeRoomUI:OnClose(userData)
	for i, v in pairs(self.roomRenderCellPool) do
		v:Close()
	end
end

function HomeLandChangeRoomUI:OnAddListeners()
	self.btnBackComponent.onClick:AddListener(self.delegateOnBtnBack)
	self.BtnBack1:GetComponent("Button").onClick:AddListener(self.delegateOnBtnBack)
end

function HomeLandChangeRoomUI:OnRemoveListeners()
	self.btnBackComponent.onClick:RemoveListener(self.delegateOnBtnBack)
	self.BtnBack1:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnBack)
end

function HomeLandChangeRoomUI:OnPause()
	return
end

function HomeLandChangeRoomUI:OnResume()
	return
end

function HomeLandChangeRoomUI:OnCover()
	return
end

function HomeLandChangeRoomUI:OnReveal()
	return
end

function HomeLandChangeRoomUI:OnRefocus(userData)
	return
end

function HomeLandChangeRoomUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandChangeRoomUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandChangeRoomUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandChangeRoomUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandChangeRoomUI:OnDestroy()
	for i, v in pairs(self.pageCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.roomRenderCellPool) do
		v:Dispose()
	end
end

function HomeLandChangeRoomUI:OnClickBackBtn()
	UIModule.Close(Constant.UIControllerName.HomeLandChangeRoomUI)
end

function HomeLandChangeRoomUI:OnSelectPageCell(cell)
	self.selectPage = cell.index + 1

	for i, v in pairs(self.pageCellPool) do
		v:SetSelect(v.Index == self.selectPage)
	end

	self:RefreshPage()
end

function HomeLandChangeRoomUI:RefreshPage()
	self.pageRooms = {}

	for i = 1, self.pageCount do
		local index = (self.selectPage - 1) * self.pageCount + i

		if index <= #self.rooms then
			local data = self.rooms[index]

			table.insert(self.pageRooms, data)
		end
	end

	self.roomListComponent:Refresh(#self.pageRooms)
end

function HomeLandChangeRoomUI:OnRenderPageCell(cell)
	local index = cell.index + 1
	local instanceID = cell.gameObject:GetInstanceID()
	local pageCell = self.pageCellPool[instanceID]

	if pageCell == nil then
		pageCell = HomeLandChangePageCell.New(cell.gameObject)
		self.pageCellPool[instanceID] = pageCell
	end

	local startNum = self.pageCount * (index - 1) + 1
	local endNum = self.pageCount * index

	pageCell:SetData(index, startNum, endNum)
	pageCell:SetSelect(self.selectPage == index)
end

function HomeLandChangeRoomUI:OnRenderCell(cell)
	local dormData = self.pageRooms[cell.index + 1]

	if dormData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goObj = cell.gameObject

	goObj:SetActive(true)

	local instanceID = goObj:GetInstanceID()
	local roomRender = self.roomRenderCellPool[instanceID]

	if roomRender == nil then
		roomRender = HomeLandRoomRender:New(goObj)
		self.roomRenderCellPool[instanceID] = roomRender
	end

	roomRender:SetData(dormData)
end

function HomeLandChangeRoomUI:OnClickCell(cell)
	local dormData = self.pageRooms[cell.index + 1]

	if HomeLandLuaModule.isVisitHome then
		if dormData.isUnlock then
			if dormData.foreignShow then
				self:EnterRoom(dormData.roomID)
			else
				NoticeModule.ShowNoticeByType(1, HomeLandChangeRoomUIApi:GetString("ErrorMsg"))
			end
		end
	elseif not dormData.isUnlock then
		UIModule.Open(Constant.UIControllerName.HomeLandUnlockRoomUI, Constant.UILayer.UI, dormData.roomID)
	else
		self:EnterRoom(dormData.roomID)
	end
end

function HomeLandChangeRoomUI:UpdateView()
	local allRooms = HomeLandLuaModule.GetHomeLandDorms()

	self.rooms = {}

	local nextLockRoom

	for i = 1, #allRooms do
		local dormData = allRooms[i]

		if dormData.isUnlock then
			table.insert(self.rooms, dormData)
		elseif nextLockRoom == nil then
			nextLockRoom = dormData
		end
	end

	if nextLockRoom ~= nil then
		table.insert(self.rooms, nextLockRoom)
	end

	local len = math.ceil(#self.rooms / self.pageCount)

	self.PageScrollArea:GetComponent("ScrollAreaList"):Refresh(len)
	self:RefreshPage()
end

function HomeLandChangeRoomUI:EnterRoom(roomID)
	GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
	GameEntry.LuaEvent:Fire(nil, HomelandEnterRoomEventArgs():Fill(roomID))
	self:OnClickBackBtn()
end

return HomeLandChangeRoomUI
