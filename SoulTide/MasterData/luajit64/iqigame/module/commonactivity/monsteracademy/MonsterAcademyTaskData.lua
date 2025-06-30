-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyTaskData.lua

local m = {}

function m.New(cfgID, state)
	local o = Clone(m)

	o:Init(cfgID, state)

	return o
end

function m:Init(cfgID, state)
	self.cfgID = cfgID
	self.state = state
	self.cfgInfo = CfgGalgameMonsterTaskTable[cfgID]
end

return m
