-- chunkname: @modules/logic/survival/util/SurvivalStatHelper.lua

module("modules.logic.survival.util.SurvivalStatHelper", package.seeall)

local SurvivalStatHelper = class("SurvivalStatHelper")

function SurvivalStatHelper:statBtnClick(name, viewName)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ButtonName] = name,
		[StatEnum.EventProperties.ViewName] = viewName
	})
end

function SurvivalStatHelper:statSurvivalMapUnit(operationType, eventId, optionId, treeId)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local pos = sceneMo.player.pos
	local unitMo = sceneMo.unitsById[eventId]

	StatController.instance:track(StatEnum.EventName.SurvivalMapUnit, {
		[StatEnum.EventProperties.SurvivalBaseObj] = self:getWeekData(),
		[StatEnum.EventProperties.SurvivalMapBaseObj] = self:getMapData(),
		[StatEnum.EventProperties.OperationType] = operationType,
		[StatEnum.EventProperties.EventId] = unitMo and unitMo.cfgId,
		[StatEnum.EventProperties.TreeId] = treeId or 0,
		[StatEnum.EventProperties.OptionId] = optionId,
		[StatEnum.EventProperties.Position] = {
			x = pos.q,
			y = pos.r,
			z = pos.s
		}
	})
end

function SurvivalStatHelper:statWeekClose(time, type)
	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalWeekClose, {
		[StatEnum.EventProperties.Season] = outSideMo.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = self:getWeekData(),
		[StatEnum.EventProperties.UseTime] = time,
		[StatEnum.EventProperties.From] = type
	})
end

function SurvivalStatHelper:statMapClose(time, type)
	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalMapClose, {
		[StatEnum.EventProperties.Season] = outSideMo.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = self:getWeekData(),
		[StatEnum.EventProperties.SurvivalMapBaseObj] = self:getMapData(),
		[StatEnum.EventProperties.UseTime] = time,
		[StatEnum.EventProperties.From] = type
	})
end

function SurvivalStatHelper:getWeekData()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	return {
		world_lv = weekInfo:getAttr(SurvivalEnum.AttrType.WorldLevel),
		difficulty = weekInfo.difficulty,
		day = weekInfo.day,
		role_id = weekInfo:getRoleInfo().roleId
	}
end

function SurvivalStatHelper:getMapData()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if not sceneMo then
		return
	end

	local groupId = lua_survival_map_group_mapping.configDict[sceneMo.mapId].id
	local copyCo = lua_survival_map_group.configDict[groupId]
	local countdown = sceneMo.currMaxGameTime - sceneMo.gameTime
	local eventList = {}

	for _, v in ipairs(sceneMo.units) do
		table.insert(eventList, v.cfgId)
	end

	return {
		map_type = copyCo.id,
		map_id = sceneMo.mapId,
		countdown = countdown,
		alive_events = eventList,
		rain_id = sceneMo._mapInfo.rainId,
		disaster_ids = sceneMo._mapInfo.disasterIds
	}
end

function SurvivalStatHelper:statEditMsg(operationEnum, ids)
	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalMsgOperation, {
		[StatEnum.EventProperties.Season] = outSideMo.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = self:getWeekData(),
		[StatEnum.EventProperties.SurvivalMapBaseObj] = self:getMapData(),
		[StatEnum.EventProperties.OperationType] = tostring(operationEnum),
		[StatEnum.EventProperties.SurvivalMsgList] = ids
	})
end

function SurvivalStatHelper:statMsgOperation(operationEnum, id)
	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalMsgOperation, {
		[StatEnum.EventProperties.Season] = outSideMo.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = self:getWeekData(),
		[StatEnum.EventProperties.SurvivalMapBaseObj] = self:getMapData(),
		[StatEnum.EventProperties.OperationType] = tostring(operationEnum),
		[StatEnum.EventProperties.SurvivalMsgId] = id
	})
end

function SurvivalStatHelper:statUseRoleSkill()
	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalUseRoleSkill, {
		[StatEnum.EventProperties.Season] = outSideMo.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = self:getWeekData(),
		[StatEnum.EventProperties.SurvivalMapBaseObj] = self:getMapData()
	})
end

function SurvivalStatHelper:statCollectionRoomClose(time)
	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalCollectionRoomClose, {
		[StatEnum.EventProperties.Season] = outSideMo.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = self:getWeekData(),
		[StatEnum.EventProperties.UseTime] = time
	})
end

SurvivalStatHelper.instance = SurvivalStatHelper.New()

return SurvivalStatHelper
