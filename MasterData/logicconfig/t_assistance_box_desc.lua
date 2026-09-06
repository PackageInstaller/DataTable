-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_assistance_box_desc.lua

module("logicconfig.config.t_assistance_box_desc", package.seeall)

local title = {
	id = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"加个好友一起助力！"
	},
	{
		2,
		"助力成功！"
	},
	{
		3,
		"大家互相助力！"
	},
	{
		4,
		"助力了以后就是朋友！"
	}
}
local t_assistance_box_desc = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_assistance_box_desc.dataList = dataList

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

return t_assistance_box_desc
