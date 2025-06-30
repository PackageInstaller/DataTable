-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleSmallMapElement.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
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

	self.stageMapPOD = stageMapPOD
	self.roomID = roomID

	local showRoomCidList = MazeModule.GetShowMazeRoomDataList()

	if table.indexOf(showRoomCidList, self.roomID) == -1 then
		LuaUtility.SetGameObjectShow(self.rightLine, false)
		LuaUtility.SetGameObjectShow(self.bottomLine, false)
	else
		for k, v in pairs(stageMapPOD.roomids) do
			if v ~= 0 then
				if k == Constant.MazeMoveDir.Right and table.indexOf(showRoomCidList, stageMapPOD.roomids[Constant.MazeMoveDir.Right]) ~= -1 then
					LuaUtility.SetGameObjectShow(self.rightLine, true)
				elseif k == Constant.MazeMoveDir.Bottom and table.indexOf(showRoomCidList, stageMapPOD.roomids[Constant.MazeMoveDir.Bottom]) ~= -1 then
					LuaUtility.SetGameObjectShow(self.bottomLine, true)
				end
			end
		end
	end
end

function LineItemCell:RefrshLineState()
	local showRoomCidList = MazeModule.GetShowMazeRoomDataList()

	if table.indexOf(showRoomCidList, self.roomID) == -1 then
		LuaUtility.SetGameObjectShow(self.rightLine, false)
		LuaUtility.SetGameObjectShow(self.bottomLine, false)
	else
		if table.indexOf(showRoomCidList, self.stageMapPOD.roomids[Constant.MazeMoveDir.Right]) ~= -1 then
			LuaUtility.SetGameObjectShow(self.rightLine, true)
		end

		if table.indexOf(showRoomCidList, self.stageMapPOD.roomids[Constant.MazeMoveDir.Bottom]) ~= -1 then
			LuaUtility.SetGameObjectShow(self.bottomLine, true)
		end
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

function ItemCell.New(view)
	local obj = Clone(ItemCell)

	obj:__Init(view)

	return obj
end

function ItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ItemCell:SetData(stageMapPOD, roomId, state)
	LuaUtility.SetGameObjectShow(self.mapInfoParent, roomId ~= 0)

	self.state = state
	self.roomID = roomId

	self:RefreshState(state)
	self:RefreshRoom(roomId)
	self:RefreshRoomShowState()
end

function ItemCell:RefreshState(state)
	LuaUtility.SetGameObjectShow(self.finishBG, state)
end

function ItemCell:RefreshRoom(roomId)
	LuaUtility.SetGameObjectShow(self.iTag, self.roomID == roomId)
end

function ItemCell:RefreshRoomShowState()
	local showRoomCidList = MazeModule.GetShowMazeRoomDataList()

	if table.indexOf(showRoomCidList, self.roomID) == -1 then
		LuaUtility.SetGameObjectShow(self.mapInfoParent, false)
	else
		LuaUtility.SetGameObjectShow(self.mapInfoParent, true)
	end
end

function ItemCell:Show()
	self.gameObject:SetActive(true)
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	mapItemCellList = {},
	mapLineItemCellList = {}
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnOpenMapBtnClick()
		self:__OnOpenMapBtnClick()
	end

	function self.__delegateOnEnterRoom(stageMapPOD)
		self:RefreshEnterRoom(stageMapPOD)
	end

	self.mapItemPool = UIViewObjectPool.New(self.mapItem, self.MapGrid.transform, function(_view)
		return ItemCell.New(_view)
	end)
	self.mapGridCom = self.MapGrid:GetComponent("GridLayoutGroup")
	self.mapLineItemPool = UIViewObjectPool.New(self.lineItem, self.LineGrid.transform, function(_view)
		return LineItemCell.New(_view)
	end)
	self.lineGridCom = self.LineGrid:GetComponent("GridLayoutGroup")
	self.mapScrollCom = self.ScrollView:GetComponent("ScrollRect")

	self:AddListeners()
end

function Element:AddListeners()
	self.openMapBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnOpenMapBtnClick)
	EventDispatcher.AddEventListener(EventID.EnterMapRoomResult, self.__delegateOnEnterRoom)
end

function Element:RemoveListeners()
	self.openMapBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnOpenMapBtnClick)
	EventDispatcher.RemoveEventListener(EventID.EnterMapRoomResult, self.__delegateOnEnterRoom)
end

function Element:SetData()
	if not self.gameObject.activeSelf then
		return
	end

	self.LabyrinthStagePOD = MazeModule.GetCurStagePOD()
	self.labyrinthStageCfg = MazeModule.GetMazeStageCfg(self.LabyrinthStagePOD.difficulty)
	self.mapWidth = MazeModule.GetMazeSceneSize()

	self:CreateMapItem()
end

function Element:CreateMapItem()
	self.mapItemPool:ForItems(function(_item)
		return _item:Hide()
	end)
	self.mapLineItemPool:ForItems(function(_item)
		return _item:Hide()
	end)

	self.mapItemCellList = {}
	self.mapLineItemCellList = {}
	self.mapGridCom.constraintCount = self.mapWidth
	self.lineGridCom.constraintCount = self.mapWidth

	local index = 1

	for y = 1, self.mapWidth do
		for x = 1, self.mapWidth do
			local mapItem = self.mapItemPool:GetFree(function(_item)
				return not _item.gameObject.activeSelf
			end)
			local stageMapPOD = self.LabyrinthStagePOD.stageMapPODs[index]
			local roomId = stageMapPOD ~= nil and stageMapPOD.roomId or 0
			local state = stageMapPOD ~= nil and stageMapPOD.state or false

			mapItem:Show()
			mapItem:SetData(stageMapPOD, roomId, state)
			table.insert(self.mapItemCellList, index, mapItem)

			local lineItem = self.mapLineItemPool:GetFree(function(_item)
				return not _item.gameObject.activeSelf
			end)

			lineItem:SetData(stageMapPOD, roomId)
			lineItem:Show()
			table.insert(self.mapLineItemCellList, index, lineItem)

			index = index + 1
		end
	end

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

		LuaUtility.SetSizeDeltaWithRectTransform(self.mapGridCom:GetComponent("RectTransform"), leftX + rightX + 300, topY + bottomY + 300)
		LuaUtility.SetSizeDeltaWithRectTransform(self.lineGridCom:GetComponent("RectTransform"), leftX + rightX + 300, topY + bottomY + 300)
	end, 1):Start()
end

function Element:LocationMapItem()
	local curRoomId = MazeModule.GetCurStagePOD().curRoomId
	local mapItemCell = self.mapItemCellList[curRoomId]
	local mapRect = self.mapScrollCom.content:GetComponent("RectTransform")
	local itemWorldPos = mapItemCell.gameObject.transform.position
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(itemWorldPos)
	local rectX = self.mapScrollCom:GetComponent("RectTransform").sizeDelta.x
	local rectY = self.mapScrollCom:GetComponent("RectTransform").sizeDelta.y
	local isRect, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(mapRect, screenPos, GameEntry.UICamera, nil)
	local targetPosX = math.clamp(-resultPos.x, -(mapRect.sizeDelta.x - rectX / 2), -(rectX / 2))
	local targetPosY = math.clamp(-resultPos.y, rectY / 2, mapRect.sizeDelta.y - rectY / 2)

	LuaUtility.SetAnchoredPositionWithRectTransform(mapRect, targetPosX, targetPosY)
end

function Element:RefreshEnterRoom(stageMapPOD)
	self.mapItemCellList[stageMapPOD.roomId]:RefreshState(stageMapPOD.state)

	for k, v in pairs(self.LabyrinthStagePOD.stageMapPODs) do
		self.mapItemCellList[k]:RefreshRoom(stageMapPOD.roomId)
		self.mapItemCellList[k]:RefreshRoomShowState()
		self.mapLineItemCellList[k]:RefrshLineState()
	end

	self:LocationMapItem()
end

function Element:__OnOpenMapBtnClick()
	EventDispatcher.Dispatch(EventID.OpenMazeMapUI)
end

function Element:Show()
	self.gameObject:SetActive(true)
	self:SetData()
end

function Element:Hide()
	self.mapItemPool:ForItems(function(_item)
		return _item:Hide()
	end)
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	self.mapItemPool:Dispose(function(_item)
		_item:Dispose()
	end)
	self.mapLineItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.mapItemPool = nil
	self.mapGridCom = nil
	self.lineGridCom = nil
	self.mapScrollCom = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
