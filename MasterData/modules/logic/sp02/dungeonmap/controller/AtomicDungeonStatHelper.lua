-- chunkname: @modules/logic/sp02/dungeonmap/controller/AtomicDungeonStatHelper.lua

module("modules.logic.sp02.dungeonmap.controller.AtomicDungeonStatHelper", package.seeall)

local AtomicDungeonStatHelper = class("AtomicDungeonStatHelper")

function AtomicDungeonStatHelper:ctor()
	self.dungeonStartTime = 0
	self.dataObj = {}
end

function AtomicDungeonStatHelper:initDungeonStartTime()
	self.dungeonStartTime = UnityEngine.Time.realtimeSinceStartup
end

function AtomicDungeonStatHelper:sendElementInteractInfo(elementData)
	if not elementData then
		return
	end

	StatController.instance:track(StatEnum.EventName.AtomicCompleteEvent, {
		[StatEnum.EventProperties.AtomicMapId] = tostring(elementData.mapId),
		[StatEnum.EventProperties.AtomicEventId] = elementData.elementId,
		[StatEnum.EventProperties.AtomicEventType] = elementData.elementType,
		[StatEnum.EventProperties.AtomicAlertLayer] = elementData.alamrLevel
	})
end

function AtomicDungeonStatHelper:sendOptionInteractInfo(elementData, optionIDList, optionDescList)
	StatController.instance:track(StatEnum.EventName.AtomicCompleteEvent, {
		[StatEnum.EventProperties.AtomicMapId] = tostring(elementData.mapId),
		[StatEnum.EventProperties.AtomicEventId] = elementData.elementId,
		[StatEnum.EventProperties.AtomicEventType] = elementData.elementType,
		[StatEnum.EventProperties.AtomicAlertLayer] = elementData.alamrLevel,
		[StatEnum.EventProperties.AtomicChoiceId] = optionIDList,
		[StatEnum.EventProperties.AtomicChoiceDesc] = optionDescList
	})
end

function AtomicDungeonStatHelper:sendPuzzleGameInteractInfo(elementData, isForceSucc)
	StatController.instance:track(StatEnum.EventName.AtomicCompleteEvent, {
		[StatEnum.EventProperties.AtomicMapId] = tostring(elementData.mapId),
		[StatEnum.EventProperties.AtomicEventId] = elementData.elementId,
		[StatEnum.EventProperties.AtomicEventType] = elementData.elementType,
		[StatEnum.EventProperties.AtomicAlertLayer] = elementData.alamrLevel,
		[StatEnum.EventProperties.AtomicIsViolentBreak] = isForceSucc
	})
end

function AtomicDungeonStatHelper:sendDungeonResultInfo(result)
	local mapId = AtomicDungeonModel.instance:getCurMapId()
	local alarmLevel = AtomicDungeonModel.instance:getCurAlarmLevel()
	local FinishElementIdList = AtomicDungeonModel.instance:getMapAllFinishElementIdList(mapId)
	local FinishElementCount = #FinishElementIdList

	StatController.instance:track(StatEnum.EventName.AtomicSettlement, {
		[StatEnum.EventProperties.AtomicMapId] = tostring(mapId),
		[StatEnum.EventProperties.AtomicAlertLayer] = alarmLevel,
		[StatEnum.EventProperties.AtomicUseTime] = UnityEngine.Time.realtimeSinceStartup - self.dungeonStartTime,
		[StatEnum.EventProperties.AtomicResult] = result,
		[StatEnum.EventProperties.AtomicCompletedEventNum] = FinishElementCount,
		[StatEnum.EventProperties.AtomicCompletedEventId] = FinishElementIdList
	})

	self.dungeonStartTime = UnityEngine.Time.realtimeSinceStartup
end

function AtomicDungeonStatHelper:senTalentInfo(ids, optionType, installIds)
	local names = {}

	for i, v in pairs(ids) do
		local config = AtomicConfig.instance:getTalentConfig(v)

		if config then
			table.insert(names, config.name)
		end
	end

	local installNames = {}

	for i, v in pairs(installIds) do
		local config = AtomicConfig.instance:getTalentConfig(v)

		if config then
			table.insert(installNames, config.name)
		end
	end

	StatController.instance:track(StatEnum.EventName.AtomicTalent, {
		[StatEnum.EventProperties.AtomicTalentId] = ids,
		[StatEnum.EventProperties.AtomicTalentName] = names,
		[StatEnum.EventProperties.AtomicOptionType] = optionType,
		[StatEnum.EventProperties.AtomicActiveSkill] = installNames
	})
end

AtomicDungeonStatHelper.instance = AtomicDungeonStatHelper.New()

return AtomicDungeonStatHelper
