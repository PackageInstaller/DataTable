-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_stash.lua

module("logicconfig.config.t_pan_tao_feast_stash", package.seeall)

local title = {
	capacity = 3,
	stashName = 5,
	unlockRound = 4,
	activityId = 1,
	iconPath = 7,
	stashId = 2,
	dealType = 6
}
local dataList = {
	{
		622001,
		40001,
		10,
		0,
		"冰箱",
		1,
		"icon_bingxiang"
	},
	{
		622001,
		90001,
		4,
		3,
		"平底锅",
		2,
		"icon_pingdiguo"
	},
	{
		622001,
		90002,
		4,
		5,
		"备菜台",
		2,
		"icon_beicaizhuo"
	},
	{
		622001,
		90003,
		4,
		7,
		"冷饮机",
		2,
		"icon_yinshuiji"
	},
	{
		622001,
		90004,
		4,
		8,
		"烤箱",
		2,
		"icon_kaoxiang"
	}
}
local t_pan_tao_feast_stash = {
	[622001] = {
		[40001] = dataList[1],
		[90001] = dataList[2],
		[90002] = dataList[3],
		[90003] = dataList[4],
		[90004] = dataList[5]
	}
}

t_pan_tao_feast_stash.dataList = dataList

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

return t_pan_tao_feast_stash
