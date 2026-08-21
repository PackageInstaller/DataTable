-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/model/BattleRecordMO.lua

module("logic.extensions.battlerecord.model.BattleRecordMO", package.seeall)

local BattleRecordMO = class("BattleRecordMO")

function BattleRecordMO:create(battleRecordNO)
	local recordMO = BattleRecordMO.New()

	recordMO.recordId = battleRecordNO.recordId
	recordMO.recordType = battleRecordNO.type
	recordMO.timestamp = battleRecordNO.time
	recordMO.passId = battleRecordNO.passId

	local usersId = battleRecordNO.usersId

	if #usersId > 0 then
		recordMO.relatedUserIds = {}

		table.insertto(recordMO.relatedUserIds, usersId)
	end

	return recordMO
end

function BattleRecordMO:ctor()
	self.recordId = false
	self.recordType = false
	self.timestamp = false
	self.passId = false
	self.relatedUserIds = false
end

return BattleRecordMO
