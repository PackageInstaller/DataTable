-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_common_param.lua

module("logicconfig.config.t_show_down_common_param", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"broadcast_days",
		"7"
	},
	{
		"msg_template_id",
		"75"
	},
	{
		"knockout_record_limit",
		"10"
	},
	{
		"rank_broadcast_text",
		"1:冠军#2:亚军#3:季军"
	}
}
local t_show_down_common_param = {
	broadcast_days = dataList[1],
	msg_template_id = dataList[2],
	knockout_record_limit = dataList[3],
	rank_broadcast_text = dataList[4]
}

t_show_down_common_param.dataList = dataList

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

return t_show_down_common_param
