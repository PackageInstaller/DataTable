-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ao_jiu_clg_system_pet_pos.lua

module("logicconfig.config.t_divine_ao_jiu_clg_system_pet_pos", package.seeall)

local title = {
	systemPetPosPlan = 1,
	creepsId = 3,
	posId = 2
}
local dataList = {
	{
		1,
		9,
		10000001
	},
	{
		2,
		6,
		10000001
	},
	{
		3,
		3,
		10000001
	},
	{
		4,
		5,
		10000001
	},
	{
		5,
		8,
		10000001
	},
	{
		6,
		1,
		10000001
	},
	{
		6,
		7,
		10000002
	},
	{
		7,
		3,
		10000001
	},
	{
		7,
		4,
		10000002
	},
	{
		8,
		6,
		10000001
	},
	{
		8,
		9,
		10000002
	},
	{
		9,
		2,
		10000001
	},
	{
		9,
		8,
		10000002
	},
	{
		10,
		7,
		10000001
	},
	{
		10,
		6,
		10000002
	},
	{
		11,
		1,
		10000001
	},
	{
		11,
		7,
		10000002
	},
	{
		11,
		9,
		10000003
	},
	{
		12,
		2,
		10000001
	},
	{
		12,
		8,
		10000002
	},
	{
		12,
		5,
		10000003
	},
	{
		13,
		3,
		10000001
	},
	{
		13,
		4,
		10000002
	},
	{
		13,
		6,
		10000003
	},
	{
		14,
		7,
		10000001
	},
	{
		14,
		2,
		10000002
	},
	{
		14,
		9,
		10000003
	},
	{
		15,
		4,
		10000001
	},
	{
		15,
		1,
		10000002
	},
	{
		15,
		7,
		10000003
	},
	{
		16,
		7,
		10000001
	},
	{
		16,
		8,
		10000002
	},
	{
		16,
		9,
		10000003
	}
}
local t_divine_ao_jiu_clg_system_pet_pos = {
	{
		[9] = dataList[1]
	},
	{
		[6] = dataList[2]
	},
	{
		[3] = dataList[3]
	},
	{
		[5] = dataList[4]
	},
	{
		[8] = dataList[5]
	},
	{
		dataList[6],
		[7] = dataList[7]
	},
	{
		[3] = dataList[8],
		[4] = dataList[9]
	},
	{
		[6] = dataList[10],
		[9] = dataList[11]
	},
	{
		[2] = dataList[12],
		[8] = dataList[13]
	},
	{
		[7] = dataList[14],
		[6] = dataList[15]
	},
	{
		dataList[16],
		[7] = dataList[17],
		[9] = dataList[18]
	},
	{
		[2] = dataList[19],
		[8] = dataList[20],
		[5] = dataList[21]
	},
	{
		[3] = dataList[22],
		[4] = dataList[23],
		[6] = dataList[24]
	},
	{
		[7] = dataList[25],
		[2] = dataList[26],
		[9] = dataList[27]
	},
	{
		[4] = dataList[28],
		dataList[29],
		[7] = dataList[30]
	},
	{
		[7] = dataList[31],
		[8] = dataList[32],
		[9] = dataList[33]
	}
}

t_divine_ao_jiu_clg_system_pet_pos.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_divine_ao_jiu_clg_system_pet_pos
