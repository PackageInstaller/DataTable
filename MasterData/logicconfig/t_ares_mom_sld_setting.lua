-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ares_mom_sld_setting.lua

module("logicconfig.config.t_ares_mom_sld_setting", package.seeall)

local title = {
	id = 1,
	progress = 2
}
local dataList = {
	{
		1,
		400
	},
	{
		2,
		800
	},
	{
		3,
		1200
	},
	{
		4,
		1800
	},
	{
		5,
		2400
	}
}
local t_ares_mom_sld_setting = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_ares_mom_sld_setting.dataList = dataList

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

return t_ares_mom_sld_setting
