-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collect_summoning.lua

module("logicconfig.config.t_collect_summoning", package.seeall)

local title = {
	petPrizePlanId = 3,
	id = 1,
	petPlanId = 2,
	petPos = 6,
	petId = 4,
	bubbleText = 5
}
local dataList = {
	{
		270001,
		1,
		1,
		12009,
		"我的伙伴们，集结吧！\r\n收集精灵即可得金色星神碎片×100、钻石×1500！",
		{
			1,
			1,
			1
		}
	},
	{
		270002,
		2,
		2,
		16019,
		"六道通灵师，集结吧！\r\n收集精灵即可得专属头像框！",
		{
			1,
			-350,
			1
		}
	},
	{
		270003,
		3,
		3,
		12029,
		"收集女神精灵可得动态头像框！",
		{
			-55.5,
			57,
			1
		}
	},
	{
		270004,
		4,
		4,
		11036,
		"女神大赛开启，限时收集女神精灵可得红星碎片！",
		{
			-86,
			205,
			0.7
		}
	}
}
local t_collect_summoning = {
	[270001] = dataList[1],
	[270002] = dataList[2],
	[270003] = dataList[3],
	[270004] = dataList[4]
}

t_collect_summoning.dataList = dataList

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

return t_collect_summoning
