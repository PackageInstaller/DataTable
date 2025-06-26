-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleMapElement.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local TagItemCell = {}

function TagItemCell.New(view)
	local obj = Clone(TagItemCell)

	obj:__Init(view)

	return obj
end

function TagItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function TagItemCell:SetData(type)
	UGUIUtil.SetText(self.tagName, MazeApi:GetMazeMapTagText(type))
	AssetUtil.LoadImage(self, MazeApi:GetMazeMapTagImg(type, false), self.icon:GetComponent("Image"))
end

function TagItemCell:Show()
	self.gameObject:SetActive(true)
end

function TagItemCell:Hide()
	self.gameObject:SetActive(false)
end

function TagItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local LineItemCell = {}

function LineItemCell.New(view)
	local obj = Clone(LineItemCell)

	obj:__Init(view)

	return obj
end

function LineItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function LineItemCell:SetData(stageMapPOD, roomID)
	LuaUtility.SetGameObjectShow(self.rightLine, false)
	LuaUtility.SetGameObjectShow(self.bottomLine, false)

	if roomID == 0 or stageMapPOD == nil then
		return
	end

	local showRoomCidList = MazeModule.GetShowMazeRoomDataList()

	for k, v in pairs(stageMapPOD.roomids) do
		if v ~= 0 then
			if k == Constant.MazeMoveDir.Right and table.indexOf(showRoomCidList, stageMapPOD.roomids[Constant.MazeMoveDir.Right]) ~= -1 then
				LuaUtility.SetGameObjectShow(self.rightLine, true)
			elseif k == Constant.MazeMoveDir.Bottom and table.indexOf(showRoomCidList, stageMapPOD.roomids[Constant.MazeMoveDir.Bottom]) ~= -1 then
				LuaUtility.SetGameObjectShow(self.bottomLine, true)
			end
		end
	end

	if table.indexOf(showRoomCidList, roomID) == -1 then
		LuaUtility.SetGameObjectShow(self.rightLine, false)
		LuaUtility.SetGameObjectShow(self.bottomLine, false)
	end
end

function LineItemCell:Show()
	self.gameObject:SetActive(true)
end

function LineItemCell:Hide()
	self.gameObject:SetActive(false)
end

function LineItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local ItemCell = {}

function ItemCell.New(view, clickHandler)
	local obj = Clone(ItemCell)

	obj:__Init(view, clickHandler)

	return obj
end

function ItemCell:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnClickMapItemBtn()
		self:OnClickMapItemBtn()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.delegateOnClickMapItemBtn)
end

function ItemCell:SetData(stageMapPOD, roomId, state)
	LuaUtility.SetGameObjectShow(self.mapInfoParent, roomId ~= 0)
	LuaUtility.SetGameObjectShow(self.iTag, MazeModule.GetCurStagePOD().curRoomId == roomId)

	self.state = state
	self.roomID = roomId

	self:RefreshState(state)

	if stageMapPOD == nil then
		return
	end

	LuaUtility.SetGameObjectShow(self.icon, true)

	local showRoomCidList = MazeModule.GetShowMazeRoomDataList()

	if table.indexOf(showRoomCidList, roomId) == -1 then
		LuaUtility.SetGameObjectShow(self.mapInfoParent, false)
	else
		local eventLinkTable = CfgLabyrinthEventLinkTable[stageMapPOD.eventLinkPod.eventLinkId]

		LuaUtility.SetGameObjectShow(self.icon, eventLinkTable.Type > 0)

		if eventLinkTable.Type > 0 then
			AssetUtil.LoadImage(self, MazeApi:GetMazeMapTagImg(eventLinkTable.Type, stageMapPOD.eventLinkPod.eventLinkState == true), self.icon:GetComponent("Image"))
		end
	end
end

function ItemCell:RefreshState(state)
	LuaUtility.SetGameObjectShow(self.finishBG, state)
end

function ItemCell:OnClickMapItemBtn()
	if self.state == false then
		return
	end

	if self.clickHandler ~= nil then
		self.clickHandler(self.roomID)
	end
end

function ItemCell:Show()
	self.gameObject:SetActive(true)
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickMapItemBtn)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	isFirstOpen = true,
	mapItemCellList = {},
	mapLineItemCellList = {},
	tagItemCellList = {}
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnCloseBtnClick()
		self:__OnCloseBtnClick()
	end

	function self.__delegateOnMazeStageMapPODChange(roomId)
		self:RefreshMapFinishState(roomId)
	end

	self.mapItemPool = UIViewObjectPool.New(self.mapItem, self.MapGrid.transform, function(_view)
		return ItemCell.New(_view, function(roomID)
			self:OnMapItemClick(roomID)
		end)
	end)
	self.mapGridCom = self.MapGrid:GetComponent("GridLayoutGroup")
	self.mapLineItemPool = UIViewObjectPool.New(self.lineItem, self.LineGrid.transform, function(_view)
		return LineItemCell.New(_view)
	end)
	self.lineGridCom = self.LineGrid:GetComponent("GridLayoutGroup")
	self.tagScrollCom = self.tagScroll:GetComponent("ScrollAreaList")

	function self.tagScrollCom.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.mapScrollCom = self.ScrollView:GetComponent("ScrollRect")

	self:InitMapTag()
	self:InitMapItem()
	self:AddListeners()

	self.isFirstOpen = true
end

function Element:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function Element:RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
end

function Element:InitMapTag()
	self.tagItemDataList = {}

	ForPairs(Constant.MazeShowEventImgType, function(k, v)
		table.insert(self.tagItemDataList, v)
	end)
	table.sort(self.tagItemDataList, function(a, b)
		return a < b
	end)
	self.tagScrollCom:Refresh(#self.tagItemDataList)
end

function Element:SetData()
	self.LabyrinthStagePOD = MazeModule.GetCurStagePOD()
	self.labyrinthStageCfg = MazeModule.GetMazeStageCfg(self.LabyrinthStagePOD.difficulty)
	self.mapWidth = MazeModule.GetMazeSceneSize()

	self:CreateMapItem()
end

function Element:InitMapItem()
	self.mapItemCellList = {}
	self.mapLineItemCellList = {}
	self.mapWidth = MazeModule.GetMazeSceneSize()
	self.mapGridCom.constraintCount = self.mapWidth
	self.lineGridCom.constraintCount = self.mapWidth

	local index = 1

	for y = 1, self.mapWidth * self.mapWidth do
		local mapItem = self.mapItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)
		local lineItem = self.mapLineItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		table.insert(self.mapItemCellList, index, mapItem)
		table.insert(self.mapLineItemCellList, index, lineItem)
		mapItem:Show()
		lineItem:Show()

		index = index + 1
	end
end

function Element:CreateMapItem()
	local index = 1

	for y = 1, self.mapWidth * self.mapWidth do
		local stageMapPOD = self.LabyrinthStagePOD.stageMapPODs[index]
		local roomId = stageMapPOD ~= nil and stageMapPOD.roomId or 0
		local state = stageMapPOD ~= nil and stageMapPOD.state or false
		local mapItem = self.mapItemCellList[index]
		local lineItem = self.mapLineItemCellList[index]

		if stageMapPOD ~= nil and state == true and MazeModule.GetCurStagePOD().curRoomId ~= roomId and CfgLabyrinthEventLinkTable[stageMapPOD.eventLinkPod.eventLinkId].EventReturn == true then
			mapItem:SetData(stageMapPOD, 0, false)
			lineItem:SetData(stageMapPOD, 0)
		else
			mapItem:SetData(stageMapPOD, roomId, state)
			lineItem:SetData(stageMapPOD, roomId)
		end

		index = index + 1
	end

	if self.isFirstOpen then
		self:RefreshMapSize()

		self.isFirstOpen = false
	else
		self:LocationMapItem()
	end
end

function Element:RefreshMapSize()
	local leftX, rightX, topY, bottomY = 0, 0, 0, 0

	FrameTimer.New(function()
		local itemCell = self.mapItemCellList[1]
		local rect = itemCell.gameObject:GetComponent("RectTransform")

		leftX = Mathf.Abs(rect.anchoredPosition.x)
		topY = Mathf.Abs(rect.anchoredPosition.y)
		itemCell = self.mapItemCellList[#self.mapItemCellList]
		rect = itemCell.gameObject:GetComponent("RectTransform")
		rightX = Mathf.Abs(rect.anchoredPosition.x)
		bottomY = Mathf.Abs(rect.anchoredPosition.y)

		local rectSize = leftX + rightX + 100

		LuaUtility.SetSizeDeltaWithRectTransform(self.mapGridCom:GetComponent("RectTransform"), rectSize, rectSize)
		LuaUtility.SetSizeDeltaWithRectTransform(self.lineGridCom:GetComponent("RectTransform"), rectSize, rectSize)
		self.mapScrollCom.content.gameObject:GetComponent(typeof(UISizeAdapter)):UpdateSize()
		self:LocationMapItem()
	end, 2):Start()
end

function Element:LocationMapItem()
	local curRoomId = MazeModule.GetCurStagePOD().curRoomId
	local mapItemCell = self.mapItemCellList[curRoomId]
	local mapRect = self.mapScrollCom.content:GetComponent("RectTransform")
	local itemWorldPos = mapItemCell.gameObject.transform.position
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(itemWorldPos)
	local isRect, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(mapRect, screenPos, GameEntry.UICamera, nil)
	local targetPosX = resultPos.x
	local targetPosY = -resultPos.y

	LuaUtility.SetAnchoredPositionWithRectTransform(mapRect, targetPosX, targetPosY)
end

function Element:RefreshMapFinishState(roomId)
	self.LabyrinthStagePOD = MazeModule.GetCurStagePOD()

	for k, v in pairs(self.LabyrinthStagePOD.stageMapPODs) do
		self.mapItemCellList[k]:RefreshState(v.state)
	end
end

function Element:OnMapItemClick(roomID)
	local roomStageMapData = MazeModule.GetRoomStageMapData(self.LabyrinthStagePOD.curRoomId)
	local eventLinkTable = CfgLabyrinthEventLinkTable[roomStageMapData.eventLinkPod.eventLinkId]

	if self.LabyrinthStagePOD.curRoomId == roomID or not MazeModule.GetMazeCanInteractive() or roomStageMapData.eventLinkPod.eventLinkState == false and not eventLinkTable.ControlType then
		return
	end

	local count = MazeModule.FindPath(math.min(self.LabyrinthStagePOD.curRoomId, roomID), math.max(self.LabyrinthStagePOD.curRoomId, roomID))

	NoticeModule.ShowNoticeByType(Constant.NoticeType.BoxDoubleButton, MazeApi:GetJumpTips(self:CheckConsume() * count), function()
		MazeModule.previousLastRoomCid = self.LabyrinthStagePOD.curRoomId
		MazeModule.isClickChangeRoom = true

		MazeModule.OnStartEnterRoom(roomID, true, count)
		self:Hide()
	end)
end

function Element:CheckConsume()
	local consumeCount = 1
	local jumpMapConsumeTalentData = MazeModule.GetSenroDataByEffectType(Constant.MazeSenroEffectType.JumpMapConsume)

	if jumpMapConsumeTalentData == nil then
		local labyrinthBarrierCfg = MazeModule.GetMazeStageCfg(self.LabyrinthStagePOD.difficulty)

		if labyrinthBarrierCfg ~= nil then
			consumeCount = labyrinthBarrierCfg.MoveCost[2]
		end
	else
		local talentCfg = CfgLabyrinthSenrotalentTable[jumpMapConsumeTalentData.id]

		consumeCount = talentCfg.TalentParams[jumpMapConsumeTalentData.level][2]
	end

	return consumeCount
end

function Element:OnRenderCell(cell)
	local index = cell.index + 1
	local data = self.tagItemDataList[index]
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.tagItemCellList[insID]

	if itemCell == nil then
		itemCell = TagItemCell.New(cell.gameObject)
		self.tagItemCellList[insID] = itemCell
	end

	itemCell:SetData(data)
end

function Element:__OnCloseBtnClick()
	self:Hide()
end

function Element:Show()
	self:AddEventListeners()
	self.gameObject:SetActive(true)
end

function Element:Hide()
	self:RemoveEventListeners()
	self.gameObject:SetActive(false)
end

function Element:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeStageMapPODChange, self.__delegateOnMazeStageMapPODChange)
end

function Element:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeStageMapPODChange, self.__delegateOnMazeStageMapPODChange)
end

function Element:Dispose()
	self:RemoveEventListeners()
	self.mapItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	for k, v in pairs(self.tagItemCellList) do
		v:Dispose()
	end

	self.lineGridCom = nil
	self.mapScrollCom = nil
	self.mapItemPool = nil
	self.mapGridCom = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
