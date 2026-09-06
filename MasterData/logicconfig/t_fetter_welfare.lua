-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fetter_welfare.lua

module("logicconfig.config.t_fetter_welfare", package.seeall)

local title = {
	redpoint = 5,
	jumpTo = 3,
	startTime = 6,
	funcId = 4,
	id = 1,
	bgRes = 7,
	desc = 2
}
local dataList = {
	{
		1,
		"好友上线即可收到提醒！",
		"ui#rules#friendremind_rule",
		0,
		"",
		"2022-04-01T05:00:00",
		"haoyou_hy_14"
	},
	{
		2,
		"好友组队加快跳过时间！",
		"ui#rules#friendskip_rule",
		0,
		"",
		"2022-04-01T05:00:00",
		"haoyou_hy_20"
	},
	{
		3,
		"好友组队实力提升！",
		"ui#rules#friendbattle_rule",
		0,
		"",
		"2022-04-01T05:00:00",
		"haoyou_hy_12"
	},
	{
		4,
		"好友互相租借精灵！",
		"func#673",
		673,
		"374",
		"2022-04-01T05:00:00",
		"haoyou_hy_13"
	}
}
local t_fetter_welfare = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_fetter_welfare.dataList = dataList

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

return t_fetter_welfare
