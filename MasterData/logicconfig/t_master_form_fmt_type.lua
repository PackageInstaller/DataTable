-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_form_fmt_type.lua

module("logicconfig.config.t_master_form_fmt_type", package.seeall)

local title = {
	desc = 2,
	typeId = 1
}
local dataList = {
	{
		1,
		"源起盖西瑞"
	},
	{
		2,
		"源起极"
	},
	{
		3,
		"源起究"
	},
	{
		4,
		"源起梦之队"
	},
	{
		5,
		"源起尘"
	}
}
local t_master_form_fmt_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_master_form_fmt_type.dataList = dataList

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

return t_master_form_fmt_type
