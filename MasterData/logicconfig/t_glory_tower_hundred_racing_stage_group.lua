-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_tower_hundred_racing_stage_group.lua

module("logicconfig.config.t_glory_tower_hundred_racing_stage_group", package.seeall)

local title = {
	stagePlanId = 2,
	stageGroupId = 1
}
local dataList = {
	{
		1,
		201
	},
	{
		1,
		202
	},
	{
		1,
		203
	},
	{
		1,
		204
	},
	{
		1,
		205
	},
	{
		1,
		206
	},
	{
		1,
		207
	},
	{
		1,
		208
	},
	{
		1,
		209
	},
	{
		1,
		210
	},
	{
		2,
		301
	},
	{
		2,
		302
	},
	{
		2,
		303
	},
	{
		2,
		304
	},
	{
		2,
		305
	},
	{
		2,
		306
	},
	{
		2,
		307
	},
	{
		2,
		308
	},
	{
		2,
		309
	},
	{
		2,
		310
	},
	{
		3,
		103
	},
	{
		3,
		104
	},
	{
		3,
		105
	},
	{
		3,
		106
	}
}
local t_glory_tower_hundred_racing_stage_group = {
	{
		[201] = dataList[1],
		[202] = dataList[2],
		[203] = dataList[3],
		[204] = dataList[4],
		[205] = dataList[5],
		[206] = dataList[6],
		[207] = dataList[7],
		[208] = dataList[8],
		[209] = dataList[9],
		[210] = dataList[10]
	},
	{
		[301] = dataList[11],
		[302] = dataList[12],
		[303] = dataList[13],
		[304] = dataList[14],
		[305] = dataList[15],
		[306] = dataList[16],
		[307] = dataList[17],
		[308] = dataList[18],
		[309] = dataList[19],
		[310] = dataList[20]
	},
	{
		[103] = dataList[21],
		[104] = dataList[22],
		[105] = dataList[23],
		[106] = dataList[24]
	}
}

t_glory_tower_hundred_racing_stage_group.dataList = dataList

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

return t_glory_tower_hundred_racing_stage_group
