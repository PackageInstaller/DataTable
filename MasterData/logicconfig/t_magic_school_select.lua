-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_select.lua

module("logicconfig.config.t_magic_school_select", package.seeall)

local title = {
	campId = 2,
	answerKey = 5,
	questionId = 3,
	content = 6,
	answerId = 4,
	activityId = 1
}
local dataList = {
	{
		514001,
		1,
		1,
		1,
		"A",
		"月桂木-象征荣誉与野心"
	},
	{
		514001,
		1,
		1,
		2,
		"B",
		"柳木-象征治愈与直觉"
	},
	{
		514001,
		1,
		2,
		1,
		"A",
		"火焰-充满力量与激情"
	},
	{
		514001,
		1,
		2,
		2,
		"B",
		"流水-灵活且适应性强"
	},
	{
		514001,
		1,
		3,
		1,
		"A",
		"悄悄留下-或许是机会"
	},
	{
		514001,
		1,
		3,
		2,
		"B",
		"立即上交-交由权威处理"
	},
	{
		514001,
		1,
		4,
		1,
		"A",
		"黑龙或暗影豹"
	},
	{
		514001,
		1,
		4,
		2,
		"B",
		"独角兽或风鹰"
	},
	{
		514001,
		1,
		5,
		1,
		"A",
		"掌控并引导其核心能量"
	},
	{
		514001,
		1,
		5,
		2,
		"B",
		"稳定并安抚其能量流动"
	},
	{
		514001,
		2,
		1,
		1,
		"A",
		"月桂木-象征荣誉与野心"
	},
	{
		514001,
		2,
		1,
		2,
		"B",
		"柳木-象征治愈与直觉"
	},
	{
		514001,
		2,
		2,
		1,
		"A",
		"火焰-充满力量与激情"
	},
	{
		514001,
		2,
		2,
		2,
		"B",
		"流水-灵活且适应性强"
	},
	{
		514001,
		2,
		3,
		1,
		"A",
		"悄悄留下-或许是机会"
	},
	{
		514001,
		2,
		3,
		2,
		"B",
		"立即上交-交由权威处理"
	},
	{
		514001,
		2,
		4,
		1,
		"A",
		"黑龙或暗影豹"
	},
	{
		514001,
		2,
		4,
		2,
		"B",
		"独角兽或风鹰"
	},
	{
		514001,
		2,
		5,
		1,
		"A",
		"掌控并引导其核心能量"
	},
	{
		514001,
		2,
		5,
		2,
		"B",
		"稳定并安抚其能量流动"
	}
}
local t_magic_school_select = {
	[514001] = {
		{
			{
				dataList[1],
				dataList[2]
			},
			{
				dataList[3],
				dataList[4]
			},
			{
				dataList[5],
				dataList[6]
			},
			{
				dataList[7],
				dataList[8]
			},
			{
				dataList[9],
				dataList[10]
			}
		},
		{
			{
				dataList[11],
				dataList[12]
			},
			{
				dataList[13],
				dataList[14]
			},
			{
				dataList[15],
				dataList[16]
			},
			{
				dataList[17],
				dataList[18]
			},
			{
				dataList[19],
				dataList[20]
			}
		}
	}
}

t_magic_school_select.dataList = dataList

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

return t_magic_school_select
