-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rose_clg_sign_in_buff.lua

module("logicconfig.config.t_rose_clg_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		414001,
		1,
		"全属性\n+10%"
	},
	{
		414001,
		2,
		"全属性\n+30%"
	},
	{
		414001,
		3,
		"全属性\n+50%"
	},
	{
		414001,
		4,
		"全属性\n+150%"
	},
	{
		414001,
		5,
		"全属性\n+300%"
	},
	{
		414001,
		6,
		"全属性\n+500%"
	},
	{
		414001,
		7,
		"全属性\n+800%"
	},
	{
		414001,
		8,
		"全属性\n+1200%"
	},
	{
		414001,
		9,
		"全属性\n+1500%"
	}
}
local t_rose_clg_sign_in_buff = {
	[414001] = {
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

t_rose_clg_sign_in_buff.dataList = dataList

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

return t_rose_clg_sign_in_buff
