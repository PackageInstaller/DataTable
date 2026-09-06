-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mo_yan_challenge_buff.lua

module("logicconfig.config.t_mo_yan_challenge_buff", package.seeall)

local title = {
	planId = 1,
	count = 2,
	des = 3
}
local dataList = {
	{
		1,
		1,
		"全属性提升：<color=#F5C701FF>5%</color>"
	},
	{
		1,
		2,
		"全属性提升：<color=#F5C701FF>10%</color>"
	},
	{
		1,
		3,
		"全属性提升：<color=#F5C701FF>15%</color>"
	},
	{
		1,
		4,
		"全属性提升：<color=#F5C701FF>20%</color>"
	}
}
local t_mo_yan_challenge_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_mo_yan_challenge_buff.dataList = dataList

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

return t_mo_yan_challenge_buff
