-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyItemData.lua

local m = {
	num = 0
}

function m.New(cfgID, num)
	local o = Clone(m)

	o:Init(cfgID, num)

	return o
end

function m:Init(cfgID, num)
	self.cfgID = cfgID
	self.num = num
	self.cfgInfo = CfgGalgameMonsterItemTable[cfgID]
end

return m
