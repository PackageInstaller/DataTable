-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RogueRoomMo.lua

module("logic.extensions.roguelike.model.RogueRoomMo", package.seeall)

local M = class("RogueRoomMo")
local RoomStateType = {
	UnVisible = 0,
	Visible = 2,
	Clear = 3,
	Question = 1
}
local kRestEventType = RoguelikeConst.ROGUE_EVENT_TYPE_1.RESET
local kEntranceEventType = RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_ENTRANCE
local kExitEventType = RoguelikeConst.ROGUE_EVENT_TYPE_1.SECOND_EXIT

function M:ctor()
	self._lineDirs = {}
end

function M:setRoomId(roomId)
	self._co = RoguelikeConfig.instance:getRoomById(roomId)
	self._roomId = roomId
end

function M:getId()
	return self._roomId
end

function M:updateInfoByNO(roomNo, idx)
	local temp = {
		"A5",
		"B3",
		"B4",
		"B5",
		"C3",
		"C4",
		"C5",
		"D3",
		"D4",
		"E3",
		"F3",
		"G3",
		"H2",
		"H3",
		"H4",
		"H5",
		"H6",
		"I2",
		"I6",
		"J2",
		"J6",
		"J7",
		"K2",
		"K7",
		"L2",
		"L7",
		"M7",
		"N7",
		"O7",
		"P6",
		"P7",
		"Q6",
		"Q7",
		"R7",
		"S7"
	}
	local point = roomNo.point

	self._coordinateStr = point
	self._coordinate = RoguelikeUtil.instance:parseRoomCoordinateStr(point)
	self._roomType = roomNo.type
	self._param = roomNo.content
	self._version = roomNo.vision
	self._isFinish = roomNo.finished
	self._roomId = roomNo.id
	self._touchs = roomNo.touches

	self:setRoomId(self._roomId)
end

function M:setMapId(mapId)
	self._mapId = mapId
end

function M:getMapId()
	return self._mapId
end

function M:setMapCo(mapCo)
	self._mapCo = mapCo
end

function M:getMapCo()
	return self._mapCo
end

function M:getSceneCode()
	return self._mapCo.sceneCode
end

function M:getSceneType()
	return self._mapCo.type
end

function M:getParam()
	return tonumber(self._param)
end

function M:getCoordinate()
	return self._coordinate
end

function M:getCoordinateStr()
	return self._coordinateStr
end

function M:getCellInfo()
	if not self._cellInfo then
		self._cellInfo = RoguelikeModel.instance:getCellInfo(self:getMapId(), self:getCoordinateStr())
	end

	return self._cellInfo
end

function M:getRoomName()
	return self._co.name
end

function M:getRoomType()
	return self._roomType
end

local TypeNames = {
	"初始房间",
	"事件房间",
	"战斗房间",
	"道具房间",
	"商店房间",
	"赌博房间",
	"下层房间",
	"关底房间",
	"空白房间"
}
local TypeIcons = {
	"rungroup_point3",
	"rungroup_point7",
	"rungroup_point4",
	"rungroup_point2",
	"rungroup_point5",
	"rungroup_point8",
	"rungroup_point3",
	"rungroup_point6",
	"rungroup_point2"
}

function M:getTypeName()
	if self:getIsVisibleTemp() then
		return ""
	end

	return self._version == RoomStateType.Question and "???" or TypeNames[self._roomType]
end

function M:getRoomNumberParams()
	return self._co.numberParams
end

function M:getRoomState()
	return self._roomState
end

function M:setRoomState(state)
	self._roomState = state
end

local kIconType = {
	EXIT = 3,
	BIG_EVENT_WITH_JUDGE = 5,
	BIG_EVENT = 4,
	MONSTER = 6,
	ENTRANCE = 2,
	RESET = 1
}
local kIconTypeDic = {
	[kIconType.RESET] = "rungroup_point11",
	[kIconType.ENTRANCE] = "rungroup_point12",
	[kIconType.EXIT] = "rungroup_point12_1",
	[kIconType.BIG_EVENT] = "rungroup_point8_1",
	[kIconType.BIG_EVENT_WITH_JUDGE] = "rungroup_point8",
	[kIconType.MONSTER] = "rungroup_point4"
}

function M:getRoomIcon()
	if not self._co then
		return nil
	end

	local hadJudge, iconType = self:hadJudgeOption()

	if hadJudge then
		return "rungroup_point2_1"
	end

	if kIconTypeDic[iconType] then
		return kIconTypeDic[iconType]
	end

	local isFirst = self._roomType == RoguelikeExtension_pb.RoomType.INIT

	if isFirst then
		return ""
	end

	return self._co.icon
end

function M:getIsVisible()
	return self._version ~= RoomStateType.UnVisible
end

function M:getIsClear()
	return self._version == RoomStateType.Clear
end

function M:getIsNextRoom()
	return self._roomType == RoguelikeExtension_pb.RoomType.NEXT
end

function M:getIsFreeMove()
	local isEvent = self._roomType == RoguelikeExtension_pb.RoomType.EVENT
	local isEventFree = false

	if isEvent then
		local eventId = self:getParam()
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

		isEventFree = eventCo.type == kRestEventType
	end

	return self._roomType == RoguelikeExtension_pb.RoomType.NEXT or isEventFree
end

function M:getShowMapRole()
	local isEvent = self._roomType == RoguelikeExtension_pb.RoomType.EVENT

	if isEvent then
		local eventId = self:getParam()
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

		if not eventCo then
			printError("找不到事件配置", eventId)

			return false, false
		end

		local replyIds = eventCo.replys or {}

		function getNpcId(plotList)
			for k, v in pairs(plotList) do
				if v.npcId > 0 then
					return true, v.npcId
				end
			end

			return false
		end

		local plotList = RoguelikeConfig.instance:getPlotListById(tonumber(eventCo.prestory)) or {}
		local hadNpc, npcId = getNpcId(plotList)

		if hadNpc then
			return true, npcId
		end

		for i = 1, #replyIds do
			local replyCo = RoguelikeConfig.instance:getEventReplyById(replyIds[i])
			local plotList1 = replyCo and RoguelikeConfig.instance:getPlotListById(replyCo.successStory) or {}

			if #plotList1 > 0 then
				local hadNpc1, npcId1 = getNpcId(plotList1)

				if hadNpc1 then
					return true, npcId1
				end
			end

			local plotList2 = replyCo and RoguelikeConfig.instance:getPlotListById(replyCo.failStory) or {}

			if #plotList2 > 0 then
				local hadNpc2, npcId2 = getNpcId(plotList2)

				if hadNpc2 then
					return true, npcId2
				end
			end
		end
	end

	return false
end

function M:getShowMapLiPai()
	if self._co and self._co.model ~= "" then
		return self._co.model, self._co.iconOffset
	end
end

function M:getIsQuestion()
	return false
end

function M:hadJudgeOption()
	local isEvent = self._roomType == RoguelikeExtension_pb.RoomType.EVENT
	local isMonster = self._roomType == RoguelikeExtension_pb.RoomType.MONSTER
	local isBoss = self._roomType == RoguelikeExtension_pb.RoomType.BOSS
	local hadJudge = false
	local iconType = 0

	if isEvent then
		local eventId = self:getParam()
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

		if not eventCo then
			printError("找不到事件配置", eventId)

			return false, false
		end

		if eventCo.type == RoguelikeConst.ROGUE_EVENT_TYPE_1.MONSTER_EVENT then
			return false, kIconType.MONSTER
		end

		local replyIds = eventCo.replys or {}

		for i = 1, #replyIds do
			local replyCo = RoguelikeConfig.instance:getEventReplyById(replyIds[i])

			if replyCo and replyCo.type >= RoguelikeConst.ROGUE_EVENT_TYPE_1.SINGLE_EVENT and replyCo.type <= RoguelikeConst.ROGUE_EVENT_TYPE_1.ENCOUNTER_EVENT then
				hadJudge = true
			end
		end

		if eventCo.type == kRestEventType then
			iconType = kIconType.RESET
		elseif eventCo.type == kEntranceEventType then
			iconType = kIconType.ENTRANCE
			hadJudge = false
		elseif eventCo.type == kExitEventType then
			iconType = kIconType.EXIT
		elseif eventCo.type == 5 then
			if hadJudge then
				hadJudge = false
				iconType = kIconType.BIG_EVENT_WITH_JUDGE
			else
				iconType = kIconType.BIG_EVENT
			end
		end
	end

	if isBoss then
		local param = self:getParam()
		local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(param)

		hadJudge = false

		if monsterCo then
			iconType = kIconType.MONSTER
		else
			iconType = kIconType.BIG_EVENT_WITH_JUDGE
		end
	end

	return isEvent and hadJudge, iconType
end

function M:getShowPlate()
	return self._version == RoomStateType.Clear or self._isInArea or self._roomType == RoguelikeExtension_pb.RoomType.INIT
end

function M:setVersion(version)
	self._version = version
end

function M:getIsUnvisible()
	return self._version == RoomStateType.UnVisible
end

function M:getIsCutRoom()
	return self._roomType == RoguelikeExtension_pb.RoomType.ENTRANCE or self._roomType == RoguelikeExtension_pb.RoomType.EXIT
end

function M:setShapeId(shapeId)
	self._shapeId = shapeId
end

function M:getShapeId()
	return self._shapeId
end

function M:getShapeCo()
	if self._shapeId ~= nil and self._shapeId ~= -1 then
		if self._shareCo == nil then
			self._shareCo = RoguelikeConfig.instance:getMapShapeById(self._shapeId)
		end

		if not self._shareCo then
			-- block empty
		end

		return self._shareCo
	end

	return nil
end

function M:getIsVisibleTemp()
	return self._isInArea and self._version == RoomStateType.UnVisible
end

function M:setIsInNearArea(isInArea)
	self._isInArea = isInArea
end

function M:getIsInNearArea()
	return self._isInArea
end

function M:setPlateMo(mo)
	self._plateMo = mo
end

function M:getPlateMo()
	return self._plateMo
end

function M:addLineDir(dir, mo)
	self._lineDirs[dir] = mo
end

function M:getLineDir()
	return self._lineDirs
end

function M:getIsFinish()
	return self._isFinish or not self._co
end

function M:setIsFinish(isFinish)
	self._isFinish = isFinish
end

function M:setTouches(touches)
	self._touchs = touches
end

function M:getTouches()
	return self._touchs or {}
end

function M:getToucheIds()
	local toucheIds = {}

	for k, v in ipairs(self._touchs or {}) do
		table.insert(toucheIds, v.id)
	end

	return toucheIds
end

function M:getTouchesNoFinish()
	for k, v in ipairs(self._touchs or {}) do
		if v.taken == false then
			return true
		end
	end

	return false
end

return M
