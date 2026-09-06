-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_light_fmt.lua

module("logicconfig.config.t_xiao_nuo_summary_light_fmt", package.seeall)

local title = {
	id = 1,
	jumpTo = 2
}
local dataList = {
	{
		1,
		"event#xiaonuobirthviewchangetab#birthdaywelfaresignview&&report_behavior#200536"
	},
	{
		2,
		"func#423&&report_behavior#200537"
	},
	{
		3,
		"func#432&&report_behavior#200538"
	},
	{
		4,
		"func#419&&report_behavior#200539"
	},
	{
		5,
		"func#423&&report_behavior#200540"
	},
	{
		6,
		"func#245&&report_behavior#200541"
	}
}
local t_xiao_nuo_summary_light_fmt = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_xiao_nuo_summary_light_fmt.dataList = dataList

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

return t_xiao_nuo_summary_light_fmt
