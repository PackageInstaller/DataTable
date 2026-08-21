-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RoguelikeModel.lua

module("logic.extensions.roguelike.model.RoguelikeModel", package.seeall)

local json = require("cjson")
local M = class("RoguelikeModel", BaseModel)
local kShowAllMap = false
local ROLE_STATE = {
	HP = 7,
	SAN = 8
}

function M:ctor()
	M.super.ctor(self)

	self._gold = 0
	self._const = RoguelikeConst
	self._eventType = RogueEventType
	self._equipMos = {}

	self:setEvent(true)
end

function M:onInit()
	self._roleCode2States = {}
	self._roleCodeIndexs = {}
	self._allRoleStates = nil
	self._roomMos = {}
	self._mapPlateDic = {}
	self._curRoomId = 0
	self._actionIds = {}
end

function M:onReset()
	self._equipMos = {}
	self._roleCode2States = {}
	self._roleCodeIndexs = {}
	self._allRoleStates = nil
	self._roomMos = {}
	self._curEquipMos = {}
	self._mapPlateDic = {}
	self._curRoomId = 0
	self._tempEquipId = 0
	self._touchIds = nil
	self._curRoomMo = nil

	RoguelikeAgent.instance:clearPropCodes()
end

function M:getShowAllMap()
	return kShowAllMap
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.CAMERA_CONFINER_LOADED, self._onConfinerLoaded, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CAMERA_CONFINER_LOADED, self._onConfinerLoaded, self)
	end
end

function M:updateExploreInfo(info)
	RogueExploreModel.instance:updateExploreInfo(info)

	self._scriptId = info.scriptId

	if info.scriptId == 0 then
		self._scriptId = nil
	else
		self._lastScriptId = info.scriptId
	end

	self:updateTeamInfo(info.team)
	self:updateGold(info.gold)
	self:updatePropsInfo(info.props)
	self:updateExtraDiceFace(info.faces or {})
	self:updateTempExtraDiceFace(info.tempFace or {})

	self._isInMap2 = info.isInMap2
	self._curRoom = info.curRoom

	self:updateSecondRoomInfo(info.map2)
	self:updateRoomInfo(info.map)
	self:updateCurEquipInfo(info.equip)
	self:updateEffectSource(info.source)
	self:updateCardCd(info.cardCd)

	self._layer = info.layer

	if self._san and self._san ~= info.san then
		local changes = {}
		local attrType = RoguelikeExtension_pb.AttrType

		table.insert(changes, {
			heroId = 0,
			type = attrType.SAN,
			num = info.san - self._san
		})

		if #changes > 0 then
			self._san = info.san

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, changes)
		end
	end

	self._san = info.san

	if self._rectify ~= info.rectify then
		self._rectify = info.rectify

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_RECTIFY_REFRESH)
	end

	self._isCampOpen = info.isCampOpen
	self._scriptDiffLevel = info.difficulty
	self._additions = info.additions
	self._targetText = info.targetText

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_EXPLORE_INFO)
end

function M:updateEffectSource(source)
	self._effectSource = source
end

function M:getEffectSource()
	return self._effectSource
end

function M:getGambleDebuffCleanUp()
	return false
end

function M:getMoveSanAdd()
	return 0
end

function M:getMoveSan()
	return 1 + self:getMoveSanAdd()
end

function M:getGambleAdd()
	for k, v in ipairs(self._additions) do
		if v.addition == RoguelikeExtension_pb.AdditionEnum.ADD_GAMBLE then
			return 1 + v.num / 1000
		end
	end

	return 1
end

function M:getEventDiffAdd()
	for k, v in ipairs(self._additions) do
		if v.addition == RoguelikeExtension_pb.AdditionEnum.ADD_EVENT then
			return v.num
		end
	end

	return 0
end

function M:getMonsterDiffAdd()
	for k, v in ipairs(self._additions) do
		if v.addition == RoguelikeExtension_pb.AdditionEnum.ADD_MONSTER then
			return v.num
		end
	end

	return 0
end

function M:getBigSuccessAdd()
	for k, v in ipairs(self._additions) do
		if v.addition == RoguelikeExtension_pb.AdditionEnum.ADD_BIG_SUCCESS then
			return v.num
		end
	end

	return 0
end

function M:getAddMoveSan()
	for k, v in ipairs(self._additions) do
		if v.addition == RoguelikeExtension_pb.AdditionEnum.ADD_MOVE_SAN then
			return v.num
		end
	end

	return 0
end

function M:getCampId()
	if not self._isCampOpen then
		return nil
	end

	local allCamps = {}

	for k, v in ipairs(self._allRoleStates or {}) do
		local characterCo = CharacterConfig.instance:getCharacterItemInfo(v.code)

		allCamps[characterCo.camp] = allCamps[characterCo.camp] or 0
		allCamps[characterCo.camp] = allCamps[characterCo.camp] + 1
	end

	for k, v in pairs(allCamps) do
		if v >= 3 then
			return k
		end
	end

	return nil
end

function M:setIsInMap2(isMap2)
	self._isInMap2 = isMap2
end

function M:getIsCampOpen()
	return self._isCampOpen
end

function M:getScriptDiffLevel()
	return self._scriptDiffLevel or 0
end

function M:getTargetText()
	return self._targetText or ""
end

function M:getIsInSecondRoom()
	return self._isInMap2
end

function M:getCurMapIsFixed()
	local mapId = self:getCurMapId()
	local mapCo = RoguelikeConfig.instance:getMapById(mapId)

	return mapCo and mapCo.type == 2
end

function M:setCurRoom(curRoom)
	self._curRoom = curRoom

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_EXPLORE_INFO)
end

function M:getCurLayer()
	return self._layer
end

function M:getAllInTime()
	return 0
end

function M:getRectify()
	return self._rectify or 0
end

function M:getCurScriptId()
	return self._scriptId or self._lastScriptId
end

function M:clearScriptId()
	self._scriptId = nil
	self._lastScriptId = nil
end

function M:updateTeamInfo(heroNOs)
	table.sort(heroNOs, function(a, b)
		local aIndex = a.no
		local bIndex = b.no

		return aIndex < bIndex
	end)
	self:updateRoleState(heroNOs)

	self._allRoleStates = heroNOs

	RogueMgr.instance:updateRoleInfo(heroNOs)
end

function M:getAllRoleState()
	if not self:getIsInRogue() then
		return nil
	end

	local len = 0

	for k, v in ipairs(self._allRoleStates or {}) do
		if self:getRoleHp(v.code) > 0 then
			len = len + 1
		end
	end

	local allState

	if len ~= 0 or self:getIsInRogue() then
		allState = self._allRoleStates
	end

	return allState
end

function M:getIsInRogue()
	return RogueExploreModel.instance:getIsGaming()
end

function M:updateGold(gold)
	if gold == nil then
		return
	end

	self._gold = gold

	GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_CHANGED_ANY, CommEnum.ItemUpdateState.ItemUpdate)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_GOLD, gold)
end

function M:updatePropsInfo(propNOs)
	self._allPropNOs = propNOs

	if propNOs ~= nil then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_PROP)
	end
end

function M:getAllPropNOs()
	local allProps = {}

	for idx, v in ipairs(self._allPropNOs) do
		if not v.ash or v.ing or v.heroId and v.heroId > 0 then
			table.insert(allProps, v)
		end
	end

	return allProps
end

function M:updateExtraDiceFace(faceNOs)
	for k, v in ipairs(faceNOs) do
		print("额外面", k, v)
	end

	self._extraDiceFaceNOs = faceNOs
end

function M:getExtraDiceFaceNOs()
	return self._extraDiceFaceNOs
end

function M:getExtraDicePatterns()
	local patterns = {}

	for k, v in ipairs(self._extraDiceFaceNOs or {}) do
		local num = v.num or 1

		for i = 1, num do
			table.insert(patterns, v.face)
		end
	end

	return patterns
end

function M:getExtraDiceCPatterns()
	local patterns = {}

	for k, v in ipairs(self._extraDiceFaceNOs or {}) do
		local num = v.num or 1

		for i = 1, num do
			table.insert(patterns, RoguelikeUtil.instance:convertSAttrTypeCSType(v.face))
		end
	end

	return patterns
end

function M:updateTempExtraDiceFace(faceNOs)
	self._tempExtraDiceFaceNOs = faceNOs
end

function M:getTempExtraDiceFaceNOs()
	return self._tempExtraDiceFaceNOs
end

function M:getTempExtraDicePatterns()
	local patterns = {}

	for k, v in ipairs(self._tempExtraDiceFaceNOs or {}) do
		local num = v.num or 1

		for i = 1, num do
			table.insert(patterns, v.face)
		end
	end

	return patterns
end

function M:getTempExtraDiceCPatterns()
	local patterns = {}

	for k, v in ipairs(self._tempExtraDiceFaceNOs or {}) do
		local num = v.num or 1

		for i = 1, num do
			table.insert(patterns, RoguelikeUtil.instance:convertSAttrTypeCSType(v.face))
		end
	end

	return patterns
end

function M:updateJudgeArchive(archive)
	self._curJudgeArchive = archive

	if archive.allIn ~= nil and archive.allIn > 0 then
		RogueMgr.instance:setGambleTime(archive.allIn)
	end
end

function M:getJudgeArchive()
	if false then
		local temp = {}

		temp.enemyOuterHp = 10
		temp.enemyInnerHp = 3
		temp.type = RoguelikeExtension_pb.JudgeType.FIGHT
		temp.heroId = 2000012
		temp.round = 3
		temp.selectedAttr = RoguelikeUtil.instance:convertSAttrTypeCSType(RoguelikeExtension_pb.AttrType.LORE)
		temp.isJudged = false
		temp.selfFaces = {
			temp.selectedAttr,
			temp.selectedAttr,
			temp.selectedAttr,
			temp.selectedAttr
		}
		temp.enemyFace = {}
		temp.enemyFace.face = RoguelikeExtension_pb.AttrType.LORE
		temp.enemyFace.num = 4
		temp.selfFaces = {}
		temp.selfFaces[1] = {
			num = 2,
			face = RoguelikeExtension_pb.AttrType.LORE
		}
		temp.selfFaces[2] = {
			num = 1,
			face = RoguelikeExtension_pb.AttrType.BLANK
		}

		return nil
	end

	if self._curJudgeArchive and self._curJudgeArchive.type == RoguelikeExtension_pb.JudgeType.NOT_IN_JUDGE then
		return nil
	end

	return self._curJudgeArchive
end

function M:getEventJudgeArchive()
	if self._curJudgeArchive and (self._curJudgeArchive.type == RoguelikeExtension_pb.JudgeType.SINGLE_EVENT or self._curJudgeArchive.type == RoguelikeExtension_pb.JudgeType.MUTIL_EVENT or self._curJudgeArchive.type == RoguelikeExtension_pb.JudgeType.EMERGENCY_EVENT or self._curJudgeArchive.type == RoguelikeExtension_pb.JudgeType.RECTIFY) then
		return self._curJudgeArchive
	end

	return nil
end

function M:getGold()
	return self._gold
end

function M:updateTeam(codes)
	self._teamCodes = codes
end

function M:updateRoleState(states)
	self._roleCodeIndexs = {}

	for k, v in ipairs(states) do
		self._roleCode2States[v.code] = self._roleCode2States[v.code] or {}
		self._roleCode2States[v.code] = v.attr

		table.insert(self._roleCodeIndexs, v.code)

		self._actionIds[v.code] = v.card

		for k1, v1 in ipairs(v.card) do
			if v1.entry and #v1.entry > 0 then
				-- block empty
			end
		end
	end
end

function M:getRoleCard(roleCode)
	return self._actionIds[roleCode]
end

function M:getRoleHp(roleCode)
	if self._roleCode2States[roleCode] then
		return self._roleCode2States[roleCode][RoguelikeConst.ROLE_PROP.HP]
	end

	return 0
end

function M:getRoleHpMax(roleCode)
	if self._roleCode2States[roleCode] then
		return self._roleCode2States[roleCode][RoguelikeConst.ROLE_PROP.HP_MAX]
	end

	return 0
end

function M:getRoleSan()
	return self._san or 0
end

function M:getSanIsZero()
	return self:getRoleSan() == 0
end

function M:getRoleSanMax()
	return RoguelikeConfig.instance:getConstByName("InitialTeamSan").numValue
end

function M:getSanIsDanger()
	return self:getRoleSan() <= 3
end

function M:getRoleCardIds(roleCode)
	local cardIds = {}

	for k, v in ipairs(self._actionIds[roleCode] or {}) do
		table.insert(cardIds, v.cardId)
	end

	return cardIds
end

function M:getActionCardIds()
	return
end

function M:getCardAttrBase(idx, roleIndex)
	return 0
end

function M:getCardAttrRate(idx, roleIndex)
	return 0
end

function M:getCardIsBan(idx, roleIndex)
	local index = roleIndex or RogueMgr.instance:getModel():getCurRoleIndex()
	local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(index)
	local actionId = roleProp:getCardId(idx)
	local isInCd = self:getCardCd(actionId, roleProp:getRoleId()) > 0

	return isInCd
end

function M:getCardIsInCd(idx, roleIndex)
	local index = roleIndex or RogueMgr.instance:getModel():getCurRoleIndex()
	local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(index)
	local actionId = roleProp:getCardId(idx)
	local isInCd = self:getCardCd(actionId, roleProp:getRoleId()) > 0

	return isInCd
end

function M:getCardCdByIndex(idx, roleIndex)
	local index = roleIndex or RogueMgr.instance:getModel():getCurRoleIndex()
	local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(index)
	local actionId = roleProp:getCardId(idx)

	return self:getCardCd(actionId, roleProp:getRoleId()) or 0
end

function M:getRoleSix(roleCode)
	local six = {}

	if self._roleCode2States[roleCode] then
		local attr = self._roleCode2States[roleCode]

		for i = 1, 6 do
			table.insert(six, attr[i])
		end
	end

	return six
end

function M:getSpecialDice(roleCode)
	return {}
end

function M:getSkillOpen(roleCode)
	return false
end

function M:getFightFaces(roleCode)
	return self._extraDiceFaceNOs or {}
end

function M:getEventFaces(roleCode)
	return self._extraDiceFaceNOs or {}
end

function M:getRoleTemps(roleCode)
	return nil
end

function M:addBuff()
	return
end

function M:updateCurEquipInfo(equipInfos)
	if self._curEquipMos and equipInfos and equipInfos.id ~= 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_EQUIP_WEAR)
	end

	self._curEquipMos = {}

	if equipInfos and equipInfos.id ~= 0 then
		local mo = RogueEquipMo.New(equipInfos)

		table.insert(self._curEquipMos, mo)
	end

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_EQUIP_REFRESH)
end

function M:getCurEquipMOS()
	return self._curEquipMos or {}
end

function M:getEquipIsWear(id)
	for k, v in pairs(self:getCurEquipMOS()) do
		if v:getId() == id then
			return true
		end
	end

	return false
end

function M:updateSecondRoomInfo(roomInfos)
	self._room2Mos = {}
	self._mapId2Room2Mos = {}

	if roomInfos == nil or roomInfos.id == 0 or roomInfos.id == nil then
		return
	end

	for idx, mapNO in ipairs(roomInfos) do
		self:setMapLines(mapNO.id)
	end

	local mapNO = roomInfos

	self._mapId2Room2Mos[mapNO.id] = {}

	local mapCo = RoguelikeConfig.instance:getMapById(mapNO.id)

	if not mapCo then
		printError("找不到地图配置", mapNO.id)

		return
	end

	local plates = json.decode(mapCo.plate)
	local minX, minY, maxX, maxY = 100, 100, 0, 0

	for k, v in ipairs(mapNO.rooms) do
		local mo = RogueRoomMo.New()

		mo:updateInfoByNO(v, k)
		mo:setMapId(mapNO.id)
		mo:setMapCo(mapCo)

		if mapCo.sceneCode == -1 then
			mo:setShapeId(10)
		elseif plates[v.point] ~= nil then
			mo:setShapeId(plates[v.point])
		end

		mo:setIsInNearArea(true)
		table.insert(self._room2Mos, mo)
		table.insert(self._mapId2Room2Mos[mapNO.id], mo)
	end

	self:setCurSecondMapId(mapNO.id)

	if #self._room2Mos > 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROOM_INFO_REFRESH)
	end
end

function M:updateMapConfig(mapConfig)
	self._mapConfigs = self._mapConfigs or {}
	self._mapConfigs[mapConfig.mapId] = {}
	self._mapConfigs[mapConfig.mapId].shapes = {}
	self._mapConfigs[mapConfig.mapId].cells = {}

	for k, v in ipairs(mapConfig.shapes) do
		self._mapConfigs[mapConfig.mapId].shapes[v.point] = v.shapeId
	end

	for k, v in ipairs(mapConfig.cells) do
		self._mapConfigs[mapConfig.mapId].cells[v.point] = v
	end
end

function M:getCellInfo(mapId, point)
	return self._mapConfigs and self._mapConfigs[mapId] and self._mapConfigs[mapId].cells[point] or nil
end

function M:updateRoomInfo(roomInfos)
	if roomInfos.id == nil or roomInfos.id == 0 then
		return
	end

	self._roomMos = {}
	self._mapId2RoomMos = {}
	self._mapIdIndexs = {}

	local mapNO = roomInfos

	self:setCurMapId(nil)

	for idx = 1, 1 do
		if idx == 1 then
			self:setCurMapId(mapNO.id)
			self:setCutRoom(mapNO.cuts)
			self:updateCameraFollowConfiner()
		end

		self._mapId2RoomMos[mapNO.id] = {}

		local mapCo = RoguelikeConfig.instance:getMapById(mapNO.id)

		if not mapCo then
			printWarn("找不到地图id", mapNO.id)

			return
		end

		local plates = {}
		local needCheckRooms = {}
		local minX, minY, maxX, maxY = 100, 100, 0, 0

		for k, v in ipairs(mapNO.rooms) do
			local mo = RogueRoomMo.New()

			mo:updateInfoByNO(v, k)
			mo:setMapId(mapNO.id)
			mo:setMapCo(mapCo)

			local shapeId = self._mapConfigs[mapNO.id] and self._mapConfigs[mapNO.id].shapes[v.point] or -1

			mo:setShapeId(shapeId)
			table.insert(needCheckRooms, mo)

			if mapCo.sceneCode == -1 then
				mo:setShapeId(10)
			elseif plates[v.point] ~= nil then
				mo:setShapeId(plates[v.point])
				table.insert(needCheckRooms, mo)
			end

			if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
				RoguelikeTempParam.ROOM_START_COORDINATE = mo:getCoordinate()
			end

			table.insert(self._roomMos, mo)
			table.insert(self._mapId2RoomMos[mapNO.id], mo)

			if mo:getShowPlate() then
				local coordinate = mo:getCoordinate()

				if minX > coordinate[1] then
					minX = coordinate[1]
				end

				if maxX < coordinate[1] then
					maxX = coordinate[1]
				end

				if minY > coordinate[2] then
					minY = coordinate[2]
				end

				if maxY < coordinate[2] then
					maxY = coordinate[2]
				end
			end
		end

		self:setPlateVisible(mapNO.id, needCheckRooms)
		self:setMapLines(mapNO.id)
		table.insert(self._mapIdIndexs, mapNO.id)
	end

	if #self._roomMos > 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROOM_INFO_REFRESH)
	end
end

function M:updateCardCd(cardCd)
	self._cardCd = cardCd
end

function M:getCardCd(cardId, roleId)
	for k, v in ipairs(self._actionIds[roleId] or {}) do
		if v.cardId == cardId then
			return v.cd
		end
	end

	return -1
end

function M:setCutRoom(cutRoom)
	self._curCutRooms = {}

	for k, v in ipairs(cutRoom) do
		for k1, v1 in ipairs(v.ab) do
			table.insert(self._curCutRooms, v1)
		end
	end
end

function M:getCurCutRooms()
	return self._curCutRooms or {}
end

function M:updateCameraFollowConfiner(minX, minY, maxX, maxY)
	local polygon = VirtualCameraMgr.instance:getPolygonColliderPolygon()
	local originCoordinate = RoguelikeTempParam.ROOM_START_COORDINATE

	if polygon == nil or originCoordinate == nil then
		return
	end

	if self._isInMap2 then
		polygon:ChangePointPos(0, -100, -100)
		polygon:ChangePointPos(1, 100, -100)
		polygon:ChangePointPos(2, 100, 100)
		polygon:ChangePointPos(3, -100, 100)

		return
	end

	local coordinate = RoguelikeUtil.instance:parseRoomCoordinateStr(self._curRoom)
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local posX = (coordinate[1] - originCoordinate[1]) * kMapItemSize
	local posY = (coordinate[2] - originCoordinate[2]) * -kMapItemSize
	local offset = 10

	polygon:ChangePointPos(0, posX - offset, posY - offset)
	polygon:ChangePointPos(1, posX + offset, posY - offset)
	polygon:ChangePointPos(2, posX + offset, posY + offset)
	polygon:ChangePointPos(3, posX - offset, posY + offset)
end

function M:_onConfinerLoaded()
	if self._minX then
		self:updateCameraFollowConfiner(self._minX, self._minY, self._maxX, self._maxY)
	end
end

function M:checkPlateVisible()
	local mos = self:getCurMapRoomMOs()

	if not mos then
		return
	end

	local mapId = self:getCurMapId()
	local mapCo = RoguelikeConfig.instance:getMapById(mapId)
	local plates = {}
	local needCheckRooms = {}
	local minX, minY, maxX, maxY = 100, 100, 0, 0

	for idx, mo in ipairs(mos) do
		if plates[mo:getCoordinateStr()] ~= nil then
			mo:setShapeId(plates[mo:getCoordinateStr()])
			table.insert(needCheckRooms, mo)
		end

		if mo:getShowPlate() then
			local coordinate = mo:getCoordinate()

			if minX > coordinate[1] then
				minX = coordinate[1]
			end

			if maxX < coordinate[1] then
				maxX = coordinate[1]
			end

			if minY > coordinate[2] then
				minY = coordinate[2]
			end

			if maxY < coordinate[2] then
				maxY = coordinate[2]
			end
		end
	end

	self:updateCameraFollowConfiner(minX, minY, maxX, maxY)
	self:setPlateVisible(mapId, needCheckRooms)
	self:setMapLines(mapId)
end

function M:setMapLines(mapId)
	local mos = self:getCurMapRoomMOs() or self:getRoomMoByMapId(mapId)
	local offsets = {
		{
			0,
			1
		},
		{
			0,
			-1
		},
		{
			-1,
			0
		},
		{
			1,
			0
		}
	}
	local dirDic = {
		2,
		1,
		3,
		4
	}

	for k, v in pairs(mos) do
		local coordinate = v:getCoordinate()
		local cellInfo = v:getCellInfo()
		local cellDir = cellInfo and {
			cellInfo.up,
			cellInfo.down,
			cellInfo.left,
			cellInfo.right
		} or {}

		if not v:getIsUnvisible() then
			for k1, v1 in pairs(offsets) do
				local mo = self:getMoByCoordinate(coordinate[1] + v1[1], coordinate[2] + v1[2], mos)

				if mo ~= nil and not mo:getIsUnvisible() and tostring(cellDir[dirDic[k1]]) ~= "0" and tostring(cellDir[dirDic[k1]]) ~= "1" then
					v:addLineDir(k1, mo)
				end
			end
		end
	end
end

function M:getMoByCoordinate(coordinateX, coordinateY, roomMos)
	for k, v in pairs(roomMos) do
		if v:getCoordinate()[1] == coordinateX and v:getCoordinate()[2] == coordinateY then
			return v, k
		end
	end

	return nil
end

function M:setPlateVisible(mapId, checkRooms)
	local mos = self:getRoomMoByMapId(mapId)

	if not mos then
		return
	end

	function getOffset(idx)
		if idx == 1 then
			return -1, -1
		elseif idx == 2 then
			return 0, -1
		elseif idx == 3 then
			return 1, -1
		elseif idx == 4 then
			return 1, 0
		elseif idx == 5 then
			return 1, 1
		elseif idx == 6 then
			return 0, 1
		elseif idx == 7 then
			return -1, 1
		elseif idx == 8 then
			return -1, 0
		end
	end

	local roomMos = self:getRoomMoByMapId(mapId)

	for k, v in ipairs(checkRooms) do
		local shapeCo = v:getShapeCo()

		if shapeCo then
			local links = shapeCo.link or {}
			local coordinats = {}

			for i = 1, #links, 2 do
				table.insert(coordinats, {
					links[i],
					links[i + 1]
				})
			end

			for k1, v1 in pairs(coordinats) do
				local x, y = v1[1], v1[2]
				local coordinate = v:getCoordinate()
				local mo = self:getMoByCoordinate(coordinate[1] + x, coordinate[2] + y, roomMos)

				if mo ~= nil then
					mo:setPlateMo(v)

					if mo:getIsClear() or mo:getIsVisible() then
						v:setIsInNearArea(true)
						mo:setIsInNearArea(true)
					end
				end
			end

			if v:getIsClear() or v:getIsVisible() then
				v:setIsInNearArea(true)
			end
		end
	end
end

function M:getRoomMOs(getMainRoom)
	if not kShowAllMap then
		return self:getCurMapRoomMOs(getMainRoom)
	end

	return self._roomMos
end

function M:getRoom2MOs()
	if not kShowAllMap then
		return self:getCurMapRoom2MOs() or {}
	end

	return self._room2Mos or {}
end

function M:getCurMapRoomMOs(getMainRoom)
	if self._isInMap2 and not getMainRoom then
		return self:getCurMapRoom2MOs()
	end

	return self:getRoomMoByMapId(self:getCurMapId())
end

function M:getCurMapRoom2MOs()
	return self._mapId2Room2Mos[self:getCurSecondMapId()]
end

function M:getRoomMoByMapId(mapId)
	mapId = mapId or self._curMapId

	return self._mapId2RoomMos[mapId] or {}
end

function M:clearRoomMos()
	self._mapId2RoomMos = {}
	self._mapId2Room2Mos = {}
end

function M:getRoomMoByRoomCoordinate(coordinate)
	local roomMos = self:getCurMapRoomMOs()

	for k, v in pairs(roomMos) do
		if v:getCoordinateStr() == coordinate then
			return v
		end
	end

	printError("找不到房间", id)

	return nil
end

function M:getCurMapOffset()
	if not kShowAllMap then
		return 0
	end

	local mapId = self:getCurMapId()
	local count = 0

	for k, v in ipairs(self._mapIdIndexs) do
		if v == mapId then
			return count
		end

		count = count + #self:getRoomMoByMapId(v)
	end

	return 0
end

function M:getAllMapIds()
	return self._mapIdIndexs or {}
end

function M:getMapIdIndex(mapId)
	for k, v in ipairs(self._mapIdIndexs) do
		if v == mapId then
			return k
		end
	end

	return 1
end

function M:getRoomMoByIndex(index)
	if not kShowAllMap then
		local curMapMos = self:getCurMapRoomMOs()

		if not curMapMos then
			return nil
		end

		return self:getCurMapRoomMOs()[index]
	end

	index = index + self:getCurMapOffset()

	return self._roomMos[index]
end

function M:updateScripts(infos)
	self._scriptInfos = infos

	RogueExploreModel.instance:updateScripts(infos)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SCRIPT_INFO_REFRESH, infos)
end

function M:getTouchIds()
	if self._touchIds ~= nil then
		return self._touchIds
	end

	local curScriptId = self:getCurScriptId()

	self._touchIds = {}

	for k, v in ipairs(self._scriptInfos) do
		if v.scriptId == curScriptId then
			self._touchIds = v.touchIds
		end
	end

	return self._touchIds
end

function M:setTouchIds(touchIds)
	self._touchIds = touchIds
end

function M:setMapId(mapId)
	self._mapInfoMo = RogueMapInfoMo.New(mapId)
end

function M:getMapInfoMo()
	return self._mapInfoMo
end

function M:getRoomMo(index)
	return self._mapInfoMo:getRoomMo(index)
end

function M:setCurRoomId(roomId)
	self._curRoomId = roomId
end

function M:setCurRoomMo(roomMo)
	self._curRoomMo = roomMo
end

function M:getCurRoomMo()
	if not self._curRoomMo then
		local roomMos = self._isInMap2 and self._room2Mos or self._roomMos

		for k, v in ipairs(roomMos or {}) do
			if v:getMapId() == self._curMapId and v:getCoordinateStr() == self:getCurRoomCoordinate() then
				return v
			end
		end
	end

	return self._curRoomMo
end

function M:getCurRoomIndex()
	local roomMos = self._isInMap2 and self._room2Mos or self._roomMos

	for k, v in ipairs(roomMos or {}) do
		if (v:getMapId() == self._curMapId or v:getMapId() == self._curSecondMapId) and v:getCoordinateStr() == self:getCurRoomCoordinate() then
			return k
		end
	end

	return 1
end

function M:getCurRoomId()
	return self._curRoomId
end

function M:getCurRoomCoordinate()
	return self._curRoom
end

function M:setCurMapId(mapId)
	if self._curMapId and mapId and self._curMapId ~= mapId then
		local sceneId = RoguelikeController.instance:getSceneId(mapId)

		if self._isInMap2 then
			self:setCurSecondMapId(mapId)

			return
		else
			RoguelikeController.instance:enterRunGroupScene(sceneId, true)
		end
	end

	self._curMapId = mapId
end

function M:setCurSecondMapId(mapId)
	self._curSecondMapId = mapId
end

function M:getCurMapId()
	return self._curMapId
end

function M:getPlateIndex(coordinateStr)
	local mapCo = RoguelikeConfig.instance:getMapById(self:getCurMapId())

	if not mapCo then
		printError("找不到地图配置", self:getCurMapId())

		return
	end

	do return math.random(1, 10) end

	local plates = json.decode(mapCo.plate)
	local temp = {}

	if not self._mapPlateDic[self:getCurMapId()] then
		for k, v in pairs(plates) do
			table.insert(temp, k)
		end

		table.sort(temp, function(a, b)
			local aByte = string.byte(a)
			local bByte = string.byte(b)

			if aByte ~= bByte then
				return aByte < bByte
			else
				local aNum = a:gsub("%D+", "")
				local bNum = b:gsub("%D+", "")

				return tonumber(aNum) < tonumber(bNum)
			end
		end)

		self._mapPlateDic[self:getCurMapId()] = temp
	else
		temp = self._mapPlateDic[self:getCurMapId()]
	end

	for k, v in ipairs(temp) do
		if v == coordinateStr then
			return k
		end
	end
end

function M:getCurSecondMapId()
	return self._curSecondMapId
end

function M:getCurRoom2Index()
	local coordinate = RoguelikeUtil.instance:parseRoomCoordinateStr(self._curRoom)
	local curMapIndex = 0

	for k, v in ipairs(self._room2Mos) do
		curMapIndex = curMapIndex + 1

		if v:getCoordinate()[1] == coordinate[1] and v:getCoordinate()[2] == coordinate[2] then
			return curMapIndex
		end
	end

	printWarn("找不到当前房间坐标", self._curRoom)

	return 1
end

function M:updateEquipInfo(equipInfo)
	for k, v in ipairs(equipInfo) do
		if self._equipMos[v.id] then
			self._equipMos[v.id]:updateByNo(v)
		else
			self._equipMos[v.id] = RogueEquipMo.New(v)
		end
	end
end

function M:getEquipMOS()
	local temp = {}

	for k, v in pairs(self._equipMos) do
		table.insert(temp, v)
	end

	return temp
end

function M:updateEquipLevel(id, level)
	for k, v in pairs(self._equipMos) do
		if v:getId() == id then
			v:setLevel(level)
		end
	end
end

function M:updateTaskNOs(taskNo)
	self._taskNos = taskNo
end

function M:getTaskNOs()
	return self._taskNos
end

function M:getVisibleRoomCount()
	local mos = self:getCurMapRoomMOs() or {}
	local count = 0

	for k, v in pairs(mos) do
		if v:getIsVisible() then
			count = count + 1
		end
	end

	return count
end

function M:updateLogInfo(info)
	self._logInfos = info

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_THREAD_INFO_REFRESH, info)
end

function M:getLogInfo()
	return self._logInfos
end

function M:getReplyIdSelected(replyId)
	if self._logInfos then
		for k, v in ipairs(self._logInfos.reply) do
			if v == replyId then
				return true
			end
		end
	end

	return false
end

function M:getCurDiffBuffIds()
	local diffLevel = self:getScriptDiffLevel()

	return RoguelikeConfig.instance:getCurDiffLevelEffects(diffLevel, self:getCurScriptId())
end

function M:updateCurHackToolRoomInfo(roomInfoNo)
	self._curHackToolRoomInfoNo = roomInfoNo
end

function M:getCurHackToolRoomInfo()
	return self._curHackToolRoomInfoNo
end

function M:getIsQuit()
	return self:getRoomMOs() == nil or TableUtil.getLen(self:getRoomMOs()) == 0
end

function M:setEnterRoleStates()
	self._enterRoleStates = {}

	for k, code in ipairs(self._roleCodeIndexs or {}) do
		local v = self._roleCode2States[code] or {}
		local data = {}

		data.roleId = code
		data.hp = v[RoguelikeConst.ROLE_PROP.HP]
		data.san = self._san + RoguelikeConst.SAN_OFFSET

		table.insert(self._enterRoleStates, data)
	end
end

function M:getRoleStates()
	local temp = {}

	for k, code in ipairs(self._roleCodeIndexs or {}) do
		local v = self._roleCode2States[code] or {}
		local data = {}

		data.roleId = k
		data.hp = v[RoguelikeConst.ROLE_PROP.HP]
		data.san = self._san + RoguelikeConst.SAN_OFFSET

		table.insert(temp, data)
	end

	return temp
end

function M:getRoleSanIsOne()
	return self._san <= self:getAddMoveSan() + RoguelikeConfig.instance:getConstByName("MoveReduceSan").numValue
end

function M:getRoleInDanger()
	local dangerCount = 3

	if dangerCount >= self._san then
		return true
	end

	return false
end

function M:getEnterRoleStates()
	return self._enterRoleStates or {}
end

function M:setTempEquipId(equipId)
	self._tempEquipId = equipId
end

function M:getTempEquipId()
	return self._tempEquipId or 0
end

function M:checkRedPoint()
	local taskList = {}
	local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueWeekly)

	if tabId then
		local isActive = false

		taskList = TaskModel.instance:getTaskList(tabId)

		for index, taskMo in ipairs(taskList or {}) do
			if taskMo:canGetReward() and not taskMo:getIsFinish() then
				isActive = true
			end
		end

		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			key = RedDotType.ERedDotKey.RUNGROUP_WEEK,
			isActive = isActive
		})
	end

	local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueMonthly)

	if tabId then
		local isActive = false

		taskList = TaskModel.instance:getTaskList(tabId)

		for index, taskMo in ipairs(taskList or {}) do
			if taskMo:canGetReward() and not taskMo:getIsFinish() then
				isActive = true
			end
		end

		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			key = RedDotType.ERedDotKey.RUNGROUP_MONTH,
			isActive = isActive
		})
	end

	local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueFixed)

	if tabId then
		local isActive = false

		taskList = TaskModel.instance:getTaskList(tabId)

		for index, taskMo in ipairs(taskList or {}) do
			if taskMo:canGetReward() and not taskMo:getIsFinish() then
				isActive = true
			end
		end

		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			key = RedDotType.ERedDotKey.RUNGROUP_PERIOD,
			isActive = isActive
		})
	end
end

M.instance = M.New()

return M
