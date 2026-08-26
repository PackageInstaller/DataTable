-- chunkname: @modules/logic/fight/model/FightReplayModel.lua

module("modules.logic.fight.model.FightReplayModel", package.seeall)

local FightReplayModel = class("FightReplayModel", BaseModel)

function FightReplayModel:onInit()
	return
end

function FightReplayModel:reInit()
	return
end

function FightReplayModel:onReceiveGetFightOperReply(msg)
	local list = {}

	for _, operRecord in ipairs(msg.operRecords) do
		local mo = FightRoundOperRecordMO.New()

		mo:init(operRecord)
		table.insert(list, mo)
	end

	self:setList(list)
end

FightReplayModel.instance = FightReplayModel.New()

return FightReplayModel
