-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_longyan_challenge_support_level.lua

module("logicconfig.config.t_divine_longyan_challenge_support_level", package.seeall)

local title = {
	cost = 6,
	buffs = 5,
	extproperties = 4,
	petLevel = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		355001,
		1,
		1,
		"生命+1058111#攻击+199173#物防+65353#魔防+65353#速度+28008",
		"20054901:99",
		0
	},
	{
		355001,
		2,
		10,
		"生命+1587167#攻击+298760#物防+98030#魔防+98030#速度+42013#命中率+0.25#暴击率+0.25#格挡率+0.25",
		"20054901:99#163:99#31330201:99",
		150
	},
	{
		355001,
		3,
		30,
		"生命+2116217#攻击+398346#物防+130707#魔防+130707#速度+56017#命中率+0.50#暴击率+0.50#格挡率+0.50",
		"20054901:99#30000062:99#163:99#31330202:99",
		250
	},
	{
		355001,
		4,
		50,
		"生命+2645273#攻击+497933#物防+163384#魔防+163384#速度+70021#命中率+0.75#暴击率+0.75#格挡率+0.75",
		"20054901:99#30000062:99#163:99#31330203:99",
		350
	},
	{
		355001,
		5,
		80,
		"生命+3703384#攻击+697107#物防+228738#魔防+228738#速度+98030#命中率+1.00#暴击率+1.00#格挡率+1.00",
		"20054901:99#30000062:99#163:99#31330204:99",
		450
	},
	{
		355001,
		6,
		100,
		"生命+5143589#攻击+968205#物防+317692#魔防+317692#速度+136153#命中率+1.00#暴击率+1.00#格挡率+1.00",
		"20054901:99#30000062:99#163:99#20054902:99#31330205:99",
		480
	}
}
local t_divine_longyan_challenge_support_level = {
	[355001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_longyan_challenge_support_level.dataList = dataList

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

return t_divine_longyan_challenge_support_level
