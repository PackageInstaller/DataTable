-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ao_jiu_clg_buff_name.lua

module("logicconfig.config.t_divine_ao_jiu_clg_buff_name", package.seeall)

local title = {
	name = 3,
	buffType = 2,
	activityId = 1
}
local dataList = {
	{
		511001,
		1,
		"烽火令"
	},
	{
		511001,
		2,
		"震国令"
	},
	{
		511001,
		3,
		"钦点令"
	},
	{
		511001,
		4,
		"战国令"
	}
}
local t_divine_ao_jiu_clg_buff_name = {
	[511001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_ao_jiu_clg_buff_name.dataList = dataList

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

return t_divine_ao_jiu_clg_buff_name
