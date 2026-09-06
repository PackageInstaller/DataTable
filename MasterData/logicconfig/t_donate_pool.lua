-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_donate_pool.lua

module("logicconfig.config.t_donate_pool", package.seeall)

local title = {
	familyLevel = 1,
	poolFullValue = 2,
	maxDonateTimes = 3
}
local dataList = {
	{
		1,
		9000,
		5
	},
	{
		2,
		10500,
		10
	},
	{
		3,
		12000,
		15
	},
	{
		4,
		13500,
		20
	},
	{
		5,
		15000,
		20
	}
}
local t_donate_pool = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_donate_pool.dataList = dataList

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

return t_donate_pool
