-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_act_introduce_common.lua

module("logicconfig.config.t_act_introduce_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"AD_DURATION",
		"3"
	},
	{
		"AD_MAX_SHOW_LEN",
		"2"
	},
	{
		"IMG_DEFAULT_DATE_INFO",
		"board_huodongzhongxin_16"
	}
}
local t_act_introduce_common = {
	AD_DURATION = dataList[1],
	AD_MAX_SHOW_LEN = dataList[2],
	IMG_DEFAULT_DATE_INFO = dataList[3]
}

t_act_introduce_common.dataList = dataList

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

return t_act_introduce_common
