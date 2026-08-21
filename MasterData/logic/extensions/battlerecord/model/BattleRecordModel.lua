-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/model/BattleRecordModel.lua

module("logic.extensions.battlerecord.model.BattleRecordModel", package.seeall)

local BattleRecordModel = class("BattleRecordModel", BaseModel)

local function sort_on_id(recordMOA, recordMOB)
	return recordMOA.timestamp > recordMOB.timestamp
end

function BattleRecordModel:onInit()
	self._recordList = {}
end

function BattleRecordModel:onReset()
	self._recordList = {}
end

function BattleRecordModel:fillRecordMOList(recordNOList)
	BattleTableUtil.clearTable(self._recordList)

	for _, recordNO in ipairs(recordNOList) do
		local recordMO = BattleRecordMO:create(recordNO)

		table.insert(self._recordList, recordMO)
	end

	table.sort(self._recordList, sort_on_id)
	GlobalDispatcher:dispatchEvent(EventType.BATTLE_RECORD_LIST_UPDATE)
end

function BattleRecordModel:getRecordMOList()
	return self._recordList
end

BattleRecordModel.instance = BattleRecordModel.New()

return BattleRecordModel
