-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoomRender.lua

local HomeLandRoomRender = {
	soulAICellPool = {}
}
local HomeLandRoomRenderAICell = require("IQIGame.UI.HomeLandRoom.HomeLandRoomRenderAICell")

function HomeLandRoomRender:New(itemCellView)
	local itemCell = Clone(HomeLandRoomRender)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandRoomRender:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.TextNew, HomeLandChangeRoomUIApi:GetString("TextNew"))

	self.soulAICellPool = {}

	for i = 1, 3 do
		local soulAICell = HomeLandRoomRenderAICell.New(self["AIPoint" .. i])

		self.soulAICellPool[i] = soulAICell
	end

	function self.DelegateOnUpdateItem()
		self:UpdateRedPoint()
	end

	function self.delegateUpdateRoomEvent(roomCid)
		self:UpdateRoom(roomCid)
	end

	self:AddListener()
end

function HomeLandRoomRender:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
end

function HomeLandRoomRender:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
end

function HomeLandRoomRender:SetData(data)
	self.homeLandDormData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function HomeLandRoomRender:Update()
	self.Panel_01:SetActive(self.homeLandDormData.isUnlock)
	self.Panel_02:SetActive(not self.homeLandDormData.isUnlock)
	self.ImgLock:SetActive(not self.homeLandDormData.foreignShow)
	self.ImgOpen:SetActive(self.homeLandDormData.foreignShow)

	local roomName = self.homeLandDormData.cfgHomeLandRoomInfo.Name
	local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.homeLandDormData.roomID)

	if roomPOD ~= nil then
		if roomPOD.name ~= nil and roomPOD.name ~= "" then
			roomName = roomPOD.name
		end

		local num = #roomPOD.decorates
		local themTab = {}
		local path
		local value = CfgDiscreteDataTable[6520059].Data[1]

		if num <= value then
			path = HomeLandChangeRoomUIApi:GetString("RoomBgPath", 0)
		else
			for i, v in ipairs(roomPOD.decorates) do
				local cfgDecorate = CfgHomeLandDecorateTable[v.cid]

				if themTab[cfgDecorate.ThemeID] == nil then
					local t = {}

					t.themeID = cfgDecorate.ThemeID
					t.num = 1
					themTab[cfgDecorate.ThemeID] = t
				else
					themTab[cfgDecorate.ThemeID].num = themTab[cfgDecorate.ThemeID].num + 1
				end
			end

			local themList = {}

			for i, v in pairs(themTab) do
				table.insert(themList, v)
			end

			if #themList > 1 then
				table.sort(themList, function(a, b)
					return a.num > b.num
				end)
			end

			local maxT = themList[1]

			path = HomeLandChangeRoomUIApi:GetString("RoomBgPath", maxT.themeID)
		end

		if path then
			AssetUtil.LoadImage(self, path, self.ImgRoomBG:GetComponent("Image"))
		end
	end

	UGUIUtil.SetText(self.TextName, roomName)

	local tab = self.homeLandDormData.homeLandRoles

	for i = 1, #self.soulAICellPool do
		local cell = self.soulAICellPool[i]
		local cfgRole

		if i <= #tab then
			local roleID = tab[i]

			cfgRole = CfgHomeLandWorkBehaviorListTable[roleID]
		end

		cell:SetData(cfgRole)
	end

	self.ImgTag:SetActive(HomeLandLuaModule.currentEnterRoomID == self.homeLandDormData.roomID)
	self:UpdateRedPoint()
end

function HomeLandRoomRender:UpdateRoom(roomCid)
	if self.homeLandDormData and self.homeLandDormData.roomID == roomCid then
		self:UpdateRedPoint()
	end
end

function HomeLandRoomRender:UpdateRedPoint()
	local isRed = HomeLandLuaModule.CheckUnlockRoom(self.homeLandDormData.roomID)

	self.RedImg:SetActive(isRed and not HomeLandLuaModule.isVisitHome)
end

function HomeLandRoomRender:Clear()
	self.goView:SetActive(false)
end

function HomeLandRoomRender:Close()
	for i, v in pairs(self.soulAICellPool) do
		v:HideEntity()
	end
end

function HomeLandRoomRender:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.soulAICellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.DestroyImmediate(self.goView)

	self.goView = nil
end

return HomeLandRoomRender
