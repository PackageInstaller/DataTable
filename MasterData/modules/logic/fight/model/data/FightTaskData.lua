-- chunkname: @modules/logic/fight/model/data/FightTaskData.lua

module("modules.logic.fight.model.data.FightTaskData", package.seeall)

local FightTaskData = FightDataClass("FightTaskData")

function FightTaskData:onConstructor(proto)
	self.taskId = proto.taskId
	self.status = proto.status
	self.values = {}

	for i, v in ipairs(proto.values) do
		table.insert(self.values, FightTaskValueData.New(v))
	end
end

return FightTaskData
