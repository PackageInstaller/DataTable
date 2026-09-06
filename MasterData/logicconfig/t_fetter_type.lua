-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fetter_type.lua

module("logicconfig.config.t_fetter_type", package.seeall)

local title = {
	id = 1,
	dailyLimit = 4,
	oneTimeAdd = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"送友情点",
		10,
		20
	},
	{
		2,
		"进行助力宝箱",
		20,
		40
	},
	{
		3,
		"送花",
		0,
		200
	},
	{
		4,
		"灵纹幻境",
		10,
		50
	},
	{
		5,
		"星神幻境塔",
		10,
		20
	},
	{
		6,
		"好友租借",
		20,
		40
	}
}
local t_fetter_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_fetter_type.dataList = dataList

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

return t_fetter_type
