-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_simple_stage.lua

module("logicconfig.config.t_annual_fuben_simple_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	supportPetPoolId = 5,
	creepsMasterId = 3,
	prize = 4
}
local dataList = {
	{
		546001,
		1,
		201,
		"10:546001:300#10:310016:300",
		1
	},
	{
		546001,
		2,
		202,
		"10:546001:300#10:310016:300",
		1
	},
	{
		546001,
		3,
		203,
		"10:546001:300#10:310016:300",
		1
	},
	{
		546001,
		4,
		204,
		"10:546001:300#10:310016:300",
		1
	},
	{
		546001,
		5,
		205,
		"10:546001:300#10:310016:300",
		1
	},
	{
		546001,
		6,
		206,
		"10:546001:300#10:310016:300",
		1
	},
	{
		546001,
		7,
		207,
		"10:546001:300#10:310016:300",
		1
	},
	{
		546001,
		8,
		208,
		"10:546001:300#10:310016:300",
		1
	}
}
local t_annual_fuben_simple_stage = {
	[546001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_annual_fuben_simple_stage.dataList = dataList

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

return t_annual_fuben_simple_stage
