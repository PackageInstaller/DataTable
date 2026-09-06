-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_form_tag.lua

module("logicconfig.config.t_master_form_tag", package.seeall)

local title = {
	desc = 2,
	tagId = 1
}
local dataList = {
	{
		1,
		"新手"
	},
	{
		2,
		"高战"
	},
	{
		3,
		"免费"
	},
	{
		4,
		"土豪"
	},
	{
		5,
		"攻阵"
	},
	{
		6,
		"守阵"
	}
}
local t_master_form_tag = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_master_form_tag.dataList = dataList

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

return t_master_form_tag
