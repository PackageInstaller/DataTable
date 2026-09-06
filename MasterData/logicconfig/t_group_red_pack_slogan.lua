-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_red_pack_slogan.lua

module("logicconfig.config.t_group_red_pack_slogan", package.seeall)

local title = {
	id = 2,
	templateId = 3,
	sloganPlanId = 1
}
local dataList = {
	{
		1,
		1,
		53
	},
	{
		1,
		2,
		54
	},
	{
		1,
		3,
		55
	},
	{
		1,
		4,
		56
	}
}
local t_group_red_pack_slogan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_group_red_pack_slogan.dataList = dataList

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

return t_group_red_pack_slogan
