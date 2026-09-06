-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_collector_common.lua

module("logicconfig.config.t_goddess_collector_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BLESS_BTNTEXT",
		"女神祝福"
	},
	{
		"BLESS_DESC",
		"触发女神祝福，获得增益效果"
	},
	{
		"BLESS_SHOW_RACECID",
		"14004"
	}
}
local t_goddess_collector_common = {
	BLESS_BTNTEXT = dataList[1],
	BLESS_DESC = dataList[2],
	BLESS_SHOW_RACECID = dataList[3]
}

t_goddess_collector_common.dataList = dataList

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

return t_goddess_collector_common
