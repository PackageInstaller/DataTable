-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_privilege_params.lua

module("logicconfig.config.t_privilege_params", package.seeall)

local title = {
	superTimes = 3,
	typeId = 1,
	dec = 4,
	freeTimes = 2
}
local dataList = {
	{
		3,
		1,
		3,
		"经验幻境购买次数"
	},
	{
		4,
		1,
		3,
		"金币幻境购买次数"
	},
	{
		5,
		1,
		3,
		"装备幻境购买次数"
	},
	{
		6,
		1,
		3,
		"星辉幻境购买次数"
	},
	{
		7,
		5,
		10,
		"竞技场购买次数"
	},
	{
		8,
		1,
		2,
		"体力免费购买次数"
	},
	{
		9,
		10,
		15,
		"破阵天下免费首通次数"
	},
	{
		10,
		1,
		2,
		"勇者之塔快速收益免费次数"
	}
}
local t_privilege_params = {
	[3] = dataList[1],
	[4] = dataList[2],
	[5] = dataList[3],
	[6] = dataList[4],
	[7] = dataList[5],
	[8] = dataList[6],
	[9] = dataList[7],
	[10] = dataList[8]
}

t_privilege_params.dataList = dataList

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

return t_privilege_params
