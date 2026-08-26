-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2SnapshotInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SnapshotInfoMO", package.seeall)

local WeekwalkVer2SnapshotInfoMO = pureTable("WeekwalkVer2SnapshotInfoMO")

function WeekwalkVer2SnapshotInfoMO:init(info)
	self.no = info.no
	self.skillIds = {}

	for i, v in ipairs(info.skillIds) do
		table.insert(self.skillIds, v)
	end
end

function WeekwalkVer2SnapshotInfoMO:getChooseSkillId()
	return self.skillIds[1]
end

function WeekwalkVer2SnapshotInfoMO:setChooseSkillId(skillIds)
	self.skillIds = {}

	if skillIds then
		for i, v in ipairs(skillIds) do
			table.insert(self.skillIds, v)
		end
	end
end

return WeekwalkVer2SnapshotInfoMO
