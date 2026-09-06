-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_saint_knight_fire_god_stage.lua

module("logicconfig.config.t_divine_saint_knight_fire_god_stage", package.seeall)

local title = {
	stageId = 2,
	equationSymbol = 8,
	equation = 9,
	formula = 10,
	nextWeekScore = 6,
	prize = 3,
	baseScore = 5,
	clientFormula = 7,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		480001,
		1,
		"4:289:10",
		1001,
		{
			10,
			10,
			10
		},
		{
			30,
			30,
			30
		},
		"#*1+#*1+#*2",
		">=",
		"40",
		"(A*a)*1+(B*b)*1+(C*c)*2>=40"
	},
	{
		480001,
		2,
		"4:289:15",
		1002,
		{
			10,
			10,
			10
		},
		{
			30,
			30,
			30
		},
		"#*2+#*1+#*1",
		">=",
		"60",
		"(A*a)*2+(B*b)*1+(C*c)*1>=60"
	},
	{
		480001,
		3,
		"4:289:15",
		1003,
		{
			10,
			10,
			10
		},
		{
			30,
			30,
			30
		},
		"#*1+#*2+#*1",
		">=",
		"80",
		"(A*a)*1+(B*b)*2+(C*c)*1>=80"
	},
	{
		480001,
		4,
		"4:289:20",
		1004,
		{
			10,
			10,
			10
		},
		{
			30,
			30,
			30
		},
		"#*1+#*2+#*2",
		">=",
		"100",
		"(A*a)*1+(B*b)*2+(C*c)*2>=100"
	},
	{
		480001,
		5,
		"4:289:20",
		1005,
		{
			10,
			10,
			10
		},
		{
			30,
			30,
			30
		},
		"#*2+#*2+#*1",
		">=",
		"120",
		"(A*a)*2+(B*b)*2+(C*c)*1>=120"
	},
	{
		480001,
		6,
		"4:289:20",
		1006,
		{
			10,
			10,
			10
		},
		{
			30,
			30,
			30
		},
		"#*2+#*1+#*2",
		">=",
		"140",
		"(A*a)*2+(B*b)*1+(C*c)*2>=140"
	}
}
local t_divine_saint_knight_fire_god_stage = {
	[480001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_saint_knight_fire_god_stage.dataList = dataList

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

return t_divine_saint_knight_fire_god_stage
