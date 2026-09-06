-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_meng_meng_clg_stage.lua

module("logicconfig.config.t_origin_king_meng_meng_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 4,
	normalClgCreepsMasterId = 6,
	skinId = 9,
	targetDesc = 11,
	extremeClgCreepsMasterId = 5,
	normalClgSupportPetPlan = 7,
	passPrize = 10,
	valueCounter = 8,
	mustOnFormPetFilter = 3,
	activityId = 1
}
local dataList = {
	{
		594001,
		1,
		"Signs$爱心梦梦",
		82037432,
		1001,
		1007,
		1,
		"heal$1000000:5",
		14032,
		"8:1:1000000",
		82056660
	},
	{
		594001,
		2,
		"Signs$热血梦梦",
		82055859,
		1002,
		1008,
		1,
		"buff$20073602:5",
		14033,
		"4:90004:1",
		82056232
	},
	{
		594001,
		3,
		"Signs$炼金梦梦",
		82055846,
		1003,
		1009,
		1,
		"buff$20073602:5",
		14034,
		"4:30006:20",
		82056233
	},
	{
		594001,
		4,
		"Signs$暗黑梦梦",
		82055858,
		1004,
		1010,
		1,
		"buff$20073602:5",
		15032,
		"4:30006:20",
		82056234
	},
	{
		594001,
		5,
		"Signs$哆啦梦梦",
		82055845,
		1005,
		1011,
		1,
		"buff$20073602:5",
		15033,
		"4:443:10",
		82056233
	}
}
local t_origin_king_meng_meng_clg_stage = {
	[594001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_origin_king_meng_meng_clg_stage.dataList = dataList

local multiLanguageCells = {
	targetDesc = true,
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_king_meng_meng_clg_stage
