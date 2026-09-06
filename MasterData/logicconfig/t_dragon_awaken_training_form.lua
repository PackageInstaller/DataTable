-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_training_form.lua

module("logicconfig.config.t_dragon_awaken_training_form", package.seeall)

local title = {
	creepsMasterId = 3,
	trainingFormPlan = 1,
	formId = 2
}
local dataList = {
	{
		1,
		1,
		1001
	},
	{
		1,
		2,
		1002
	},
	{
		1,
		3,
		1003
	},
	{
		2,
		1,
		1004
	},
	{
		2,
		2,
		1005
	},
	{
		2,
		3,
		1006
	},
	{
		3,
		1,
		1007
	},
	{
		3,
		2,
		1008
	},
	{
		3,
		3,
		1009
	},
	{
		4,
		1,
		2001
	},
	{
		4,
		2,
		2002
	},
	{
		4,
		3,
		2003
	},
	{
		5,
		1,
		2004
	},
	{
		5,
		2,
		2005
	},
	{
		5,
		3,
		2006
	},
	{
		6,
		1,
		2007
	},
	{
		6,
		2,
		2008
	},
	{
		6,
		3,
		2009
	}
}
local t_dragon_awaken_training_form = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_dragon_awaken_training_form.dataList = dataList

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

return t_dragon_awaken_training_form
