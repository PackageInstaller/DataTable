-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_ya_clg_stage.lua

module("logicconfig.config.t_divine_mi_ya_clg_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1,
	rule = 4
}
local dataList = {
	{
		399001,
		1,
		1001,
		"本关必须上阵<color=#F84242FF>4只及以上暗系精灵</color>"
	},
	{
		399001,
		2,
		1002,
		"本关必须上阵<color=#F84242FF>4只及以上暗系精灵</color>"
	},
	{
		399001,
		3,
		1003,
		"本关必须上阵<color=#F84242FF>4只及以上草系精灵</color>"
	},
	{
		399001,
		4,
		1004,
		"本关必须上阵<color=#F84242FF>4只及以上草系精灵</color>"
	},
	{
		399001,
		5,
		1005,
		"本关必须上阵<color=#F84242FF>4只及以上水系精灵</color>"
	},
	{
		399001,
		6,
		1006,
		"本关必须上阵<color=#F84242FF>4只及以上水系精灵</color>"
	},
	{
		399001,
		7,
		1007,
		"本关必须上阵<color=#F84242FF>4只及以上火系精灵</color>"
	},
	{
		399001,
		8,
		1008,
		"本关必须上阵<color=#F84242FF>4只及以上火系精灵</color>"
	},
	{
		399001,
		9,
		1009,
		"本关必须上阵<color=#F84242FF>4只及以上光系精灵</color>"
	},
	{
		399001,
		10,
		1010,
		"本关必须上阵<color=#F84242FF>4只及以上光系精灵</color>"
	},
	{
		399001,
		11,
		1011,
		"本关必须上阵<color=#F84242FF>4只及以上创系精灵</color>"
	},
	{
		399001,
		12,
		1012,
		"本关必须上阵<color=#F84242FF>4只及以上创系精灵</color>"
	}
}
local t_divine_mi_ya_clg_stage = {
	[399001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_divine_mi_ya_clg_stage.dataList = dataList

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

return t_divine_mi_ya_clg_stage
