-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ao_jiu_clg_normal_stage.lua

module("logicconfig.config.t_divine_ao_jiu_clg_normal_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		511001,
		1,
		2001
	},
	{
		511001,
		2,
		2002
	},
	{
		511001,
		3,
		2003
	},
	{
		511001,
		4,
		2004
	},
	{
		511001,
		5,
		2005
	},
	{
		511001,
		6,
		2006
	},
	{
		511001,
		7,
		2007
	},
	{
		511001,
		8,
		2008
	},
	{
		511001,
		9,
		2009
	}
}
local t_divine_ao_jiu_clg_normal_stage = {
	[511001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_divine_ao_jiu_clg_normal_stage.dataList = dataList

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

return t_divine_ao_jiu_clg_normal_stage
