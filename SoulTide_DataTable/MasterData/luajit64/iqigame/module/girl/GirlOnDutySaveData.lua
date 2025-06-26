-- chunkname: @IQIGame\\Module\\Girl\\GirlOnDutySaveData.lua

local m = {
	girlOnDutyShowType = 1,
	girlOnDutyType = 4,
	girlOnDutyPosTable = {}
}

function m.New()
	local o = Clone(m)

	o:Init()

	return o
end

function m:Init()
	self.girlOnDutyPosTable = {}

	local table = CfgDiscreteDataTable[6520088].Data

	for i = 1, #table, 2 do
		local index = math.ceil(i / 2)

		self.girlOnDutyPosTable[index] = 0
	end

	self.girlOnDutyShowType = 1
	self.girlOnDutyType = 4
end

return m
