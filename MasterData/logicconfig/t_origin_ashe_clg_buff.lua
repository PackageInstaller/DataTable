-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashe_clg_buff.lua

module("logicconfig.config.t_origin_ashe_clg_buff", package.seeall)

local title = {
	name = 2,
	buffId = 1,
	des = 3
}
local dataList = {
	{
		1,
		"己阵受伤加深20%",
		"己阵受伤加深20%"
	},
	{
		2,
		"己阵受伤加深40%及敌阵全属性+50%",
		"己阵受伤加深40%及敌阵全属性+50%"
	}
}
local t_origin_ashe_clg_buff = {
	dataList[1],
	dataList[2]
}

t_origin_ashe_clg_buff.dataList = dataList

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

return t_origin_ashe_clg_buff
