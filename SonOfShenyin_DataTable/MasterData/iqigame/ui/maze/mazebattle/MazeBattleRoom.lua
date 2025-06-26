-- chunkname: @IQIGame\\UI\\Maze\\MazeBattle\\MazeBattleRoom.lua

local MazeBattleNpc = require("IQIGame/UI/Maze/MazeBattle/MazeBattleNpc")
local DirectionEnum = {
	Right = 2,
	Left = 1,
	Standby = 0
}
local EventTypeEnum = {
	Npc4 = 4,
	Npc3 = 3,
	Npc1 = 1,
	Box = 0,
	Npc2 = 2
}
local Room = {
	roomCid = 0,
	isFlip = false,
	canMoveNextRoom = false,
	npcEventShowTypeList = {},
	npcEntityList = {},
	npcIDList = {}
}

function Room.New(stageMapPOD, mainCanvas, callback)
	local obj = Clone(Room)

	obj:__OnInit(stageMapPOD, mainCanvas, callback)

	return obj
end

function Room:__OnInit(stageMapPOD, mainCanvas, callback)
	self.roomCid = stageMapPOD.roomId
	self.canMoveNextRoom = false
	self.mainCanvas = mainCanvas

	self:__LoadScene(stageMapPOD.sceneId, callback)

	function self.__delegateOnChangeSceneEvent(sceneId, changeSceneCallback)
		self:__OnChangeScene(sceneId, changeSceneCallback)
	end

	function self.__delegateOnSetNpcClickStateEvent(state)
		self:__OnSetNpcClickStateEvent(state)
	end

	function self.__delegateOnChangeNpcEvent(npcIdList, changeNpcCallback)
		self:__OnChangeNpcEvent(npcIdList, changeNpcCallback)
	end

	function self.__delegateOnStageEventLinkEnd()
		self:__OnStageEventLinkEnd()
	end

	self:AddListeners()
end

function Room:SetRoomId(curRoomId, lastRoomId)
	self.curRoomId = curRoomId
	self.lastRoomCid = lastRoomId
end

function Room:AddListeners()
	EventDispatcher.AddEventListener(EventID.MazeChangeSceneEvent, self.__delegateOnChangeSceneEvent)
	EventDispatcher.AddEventListener(EventID.MazeSetNpcClickStateEvent, self.__delegateOnSetNpcClickStateEvent)
	EventDispatcher.AddEventListener(EventID.MazeChangeNpcEvent, self.__delegateOnChangeNpcEvent)
	EventDispatcher.AddEventListener(EventID.OnStageEventLinkEnd, self.__delegateOnStageEventLinkEnd)
end

function Room:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeChangeSceneEvent, self.__delegateOnChangeSceneEvent)
	EventDispatcher.RemoveEventListener(EventID.MazeSetNpcClickStateEvent, self.__delegateOnSetNpcClickStateEvent)
	EventDispatcher.RemoveEventListener(EventID.MazeChangeNpcEvent, self.__delegateOnChangeNpcEvent)
	EventDispatcher.RemoveEventListener(EventID.OnStageEventLinkEnd, self.__delegateOnStageEventLinkEnd)
end

function Room:__LoadScene(sceneId, callback)
	local labyrinthSceneListCfg = CfgLabyrinthSceneListTable[sceneId]
	local scenePath = UIGlobalApi.GetArtPath(labyrinthSceneListCfg.SceneID)

	AssetUtil.LoadAsset(self, scenePath, function(_, _assetUrl, _asset, _duration, _userData)
		self:__OnSceneLoaded(_asset, callback)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("迷宫系统加载场景失败 {1}", scenePath)
	end)
end

function Room:__OnSceneLoaded(asset, callback)
	self.gameObject = GameObject.Instantiate(asset)

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.mountPointTable = {}

	LuaCodeInterface.BindOutlet(self.mountPoint, self.mountPointTable)

	self.pointList = {
		[DirectionEnum.Left] = {
			[EventTypeEnum.Box] = self.mountPointTable.boxPointL,
			[EventTypeEnum.Npc1] = self.mountPointTable.NpcPoint1_L,
			[EventTypeEnum.Npc2] = self.mountPointTable.NpcPoint2_L,
			[EventTypeEnum.Npc3] = self.mountPointTable.NpcPoint3_L,
			[EventTypeEnum.Npc4] = self.mountPointTable.NpcPoint4_L
		},
		[DirectionEnum.Right] = {
			[EventTypeEnum.Box] = self.mountPointTable.boxPointR,
			[EventTypeEnum.Npc1] = self.mountPointTable.NpcPoint1_R,
			[EventTypeEnum.Npc2] = self.mountPointTable.NpcPoint2_R,
			[EventTypeEnum.Npc3] = self.mountPointTable.NpcPoint3_R,
			[EventTypeEnum.Npc4] = self.mountPointTable.NpcPoint4_R
		},
		[DirectionEnum.Standby] = {
			[EventTypeEnum.Box] = self.mountPointTable.boxPointL,
			[EventTypeEnum.Npc1] = self.mountPointTable.NpcPoint1_L,
			[EventTypeEnum.Npc2] = self.mountPointTable.NpcPoint2_L,
			[EventTypeEnum.Npc3] = self.mountPointTable.NpcPoint3_L,
			[EventTypeEnum.Npc4] = self.mountPointTable.NpcPoint4_L
		}
	}

	if callback ~= nil then
		callback()
	end

	self:SetBackgroundLayer()
end

function Room:MountRoom(parent)
	self.targetParent = parent

	self.gameObject.transform:SetParent(parent, false)

	self.gameObject.transform.localPosition = Vector3.zero
	self.gameObject.transform.localScale = Vector3.one
end

function Room:SetBackgroundLayer()
	self.frontLayer:GetComponent("SortedComponentOrder").UIRootCanvas = self.mainCanvas
	self.mountPointTable.cameraEffectRoot:GetComponent("SortedComponentOrder").UIRootCanvas = self.mainCanvas
end

function Room:__OnChangeScene(sceneId, callback)
	LuaCodeInterface.ClearOutlet(self.mountPoint, self.mountPointTable)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil

	self:__LoadScene(sceneId, function()
		if callback ~= nil then
			callback()
		end

		self:MountRoom(self.targetParent)
		ForPairs(self.npcEntityList, function(pos, npc)
			npc:RefreshPosition(self:GetBirthPointTrans(self.npcEventShowTypeList[pos]))
		end)
	end)
end

function Room:__OnSetNpcClickStateEvent(state)
	if table.len(self.npcEntityList) == 0 then
		return
	end

	ForPairs(self.npcEntityList, function(_, npc)
		npc:SetClickBtnState(state)
	end)
end

function Room:__OnStageEventLinkEnd()
	if self.labyrinthEventLinkCfg.HideNpc then
		ForPairs(self.npcEntityList, function(_, npc)
			npc:Dispose()
		end)

		self.npcEntityList = {}
	else
		local roomStageMapData = MazeModule.GetRoomStageMapData(self.roomCid)

		ForPairs(self.npcEntityList, function(_, npc)
			npc:SetStageEventPOD(roomStageMapData.eventLinkPod)

			if npc:GetIsCanClearEffect() then
				npc:ClearEffect()
			end
		end)
	end
end

function Room:CreateNpc(eventLinkPod, createParent)
	self.labyrinthEventLinkCfg = CfgLabyrinthEventLinkTable[eventLinkPod.eventLinkId]
	self.createParent = createParent
	self.npcEventShowTypeList = {}
	self.npcIDList = {}

	if table.len(self.labyrinthEventLinkCfg.EventEntityID) == 0 then
		return
	end

	local npcIdList = {}

	if eventLinkPod.eventLinkState == false or self.labyrinthEventLinkCfg.HideNpc == false then
		local clientData = MazeModule.GetMazeClientDataByType(eventLinkPod, Constant.MazeClientDataType.Npc)

		if table.len(clientData) > 0 then
			npcIdList = clientData
		else
			npcIdList = self.labyrinthEventLinkCfg.EventEntityID
		end
	end

	ForArray(npcIdList, function(pos, npcId)
		self:__CreateNpcEntity(pos, npcId)
		self:__RefreshNpcIDList(pos, npcId)
	end)
end

function Room:__CreateNpcEntity(pos, npcId)
	if npcId > 0 then
		local eventEntityCfg = CfgLabyrinthEventEntityTable[npcId]

		if eventEntityCfg == nil then
			logError("Npc:{0} 在LabyrinthEventEntityTable未找到", npcId)
		end

		pos = eventEntityCfg.EventShowType
		self.npcEventShowTypeList[pos] = eventEntityCfg.EventShowType

		local eventLinkPod = MazeModule.GetRoomStageMapData(self.roomCid).eventLinkPod

		self:__CreateNPC(eventLinkPod, eventEntityCfg.NpcShow, eventEntityCfg.DefaultAnimation, eventEntityCfg.DefaultEffect, self.createParent, self:GetBirthPointTrans(eventEntityCfg.EventShowType), eventEntityCfg.IsScale, function(npc)
			self:__SetNpc(pos, npc)
		end)
	end
end

function Room:__SetNpc(pos, npc)
	self:__RemoveNpcByPos(pos)

	self.npcEntityList[pos] = npc
end

function Room:__OnChangeNpcEvent(npcIdList, changeNpcCallback)
	ForArray(npcIdList, function(pos, npcID)
		if npcID == -1 then
			self:__RemoveNpcByPos(pos)
		elseif npcID == 0 then
			-- block empty
		elseif npcID > 0 then
			self:__RemoveNpcByPos(pos)
			self:__CreateNpcEntity(pos, npcID)
		end

		self:__RefreshNpcIDList(pos, npcID)
	end)

	if changeNpcCallback ~= nil then
		changeNpcCallback(self.npcIDList)
	end
end

function Room:__RemoveNpcByPos(pos)
	if self.npcEntityList[pos] ~= nil then
		self.npcEntityList[pos]:Dispose()

		self.npcEntityList[pos] = nil
	end
end

function Room:__RefreshNpcIDList(pos, npcId)
	self.npcIDList[pos] = npcId > 0 and npcId or 0
end

function Room:__CreateNPC(eventLinkPOD, entityID, defaultAnimation, defaultEffect, parentTrans, targetTransform, isScale, callback, triggerType)
	MazeModule.log("创建NPC--->{0}", entityID)

	local npc = MazeBattleNpc.New(entityID, eventLinkPOD, defaultAnimation, defaultEffect, parentTrans, targetTransform, function(npc)
		local needFilp = self:NeedToFlip(self.lastRoomCid, self.curRoomId)

		npc:SetFlip(needFilp)
		npc:SetSacle(isScale)
		npc:SetStageEventPOD(eventLinkPOD)

		if callback ~= nil then
			callback(npc)
		end
	end)
end

function Room:__ReleaseNPC()
	if table.len(self.npcEntityList) == 0 then
		return
	end

	ForPairs(self.npcEntityList, function(_, npc)
		npc:Dispose()
	end)

	self.npcEntityList = {}
end

function Room:GetStandbyTrans()
	return self.mountPointTable.bornRight.transform
end

function Room:GetLeftOrRightDefaultTrans(isUnitFlip)
	if isUnitFlip then
		return self.mountPointTable.standbyPointR.transform
	else
		return self.mountPointTable.standbyPointL.transform
	end
end

function Room:GetBirthPointTrans(eventType)
	return self.pointList[self.curBirthPoint][eventType].transform
end

function Room:GetBornTransByRoomCid(lastRoomCid)
	local width, height = MazeModule.GetMazeSceneSize()
	local roomPod = MazeModule.GetRoomStageMapData(lastRoomCid)
	local isFirstEntry = roomPod ~= nil and roomPod.entrance == 1 and roomPod.eventLinkPod.eventLinkState == false

	return self:GetDirection(lastRoomCid, self.roomCid, width, width, isFirstEntry)
end

function Room:GetDirection(fromRoom, toRoom, columns, rows, isFirstEntry)
	local fromRow = math.floor((fromRoom - 1) / columns)
	local toRow = math.floor((toRoom - 1) / columns)
	local fromColumns = (fromRoom - 1) % columns + 1
	local toColumns = (toRoom - 1) % columns + 1

	if isFirstEntry then
		if fromColumns == 1 then
			self.curBirthPoint = DirectionEnum.Right

			return self.mountPointTable.bornLeft.transform
		elseif fromColumns == columns then
			self.curBirthPoint = DirectionEnum.Left

			return self.mountPointTable.bornRight.transform
		end
	end

	if toRoom == fromRoom + 1 and fromRow == toRow then
		self.curBirthPoint = DirectionEnum.Right

		return self.mountPointTable.bornLeft.transform
	elseif toRoom == fromRoom - 1 and fromRow == toRow then
		self.curBirthPoint = DirectionEnum.Left

		return self.mountPointTable.bornRight.transform
	elseif toRoom == fromRoom + columns then
		self.curBirthPoint = DirectionEnum.Right

		return self.mountPointTable.bornTop.transform
	elseif toRoom == fromRoom - columns then
		self.curBirthPoint = DirectionEnum.Right

		return self.mountPointTable.bornBottom.transform
	elseif toColumns < fromColumns then
		self.curBirthPoint = DirectionEnum.Left

		return self.mountPointTable.bornRight.transform
	else
		self.curBirthPoint = DirectionEnum.Right

		return self.mountPointTable.bornLeft.transform
	end
end

function Room:NeedToFlip(fromRoom, toRoom)
	local columns = MazeModule.GetMazeSceneSize()
	local fromRow = math.floor((fromRoom - 1) / columns)
	local toRow = math.floor((toRoom - 1) / columns)
	local roomPod = MazeModule.GetRoomStageMapData(toRoom)
	local isFirstEntry = roomPod.entrance == 1 and roomPod.eventLinkPod.eventLinkState == false and fromRoom == toRoom
	local fromColumns = (fromRoom - 1) % columns + 1
	local toColumns = (toRoom - 1) % columns + 1

	if isFirstEntry then
		if fromColumns == 1 then
			return false
		elseif fromColumns == columns then
			return true
		end
	end

	if toRoom == fromRoom - 1 and fromRow == toRow then
		return true
	end

	if toColumns < fromColumns then
		return true
	end

	return false
end

function Room:Dispose()
	self:RemoveListeners()
	self:__ReleaseNPC()

	self.mainCanvas = nil

	LuaCodeInterface.ClearOutlet(self.mountPoint, self.mountPointTable)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

return Room
