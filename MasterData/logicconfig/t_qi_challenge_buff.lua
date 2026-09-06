-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qi_challenge_buff.lua

module("logicconfig.config.t_qi_challenge_buff", package.seeall)

local title = {
	buffId = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"该精灵全属性及生命上限减少15%"
	},
	{
		2,
		"该精灵全属性及生命上限减少30%"
	},
	{
		3,
		"该精灵全属性及生命上限减少50%"
	},
	{
		4,
		"该精灵全属性及生命上限减少80%"
	},
	{
		5,
		"该精灵全属性及生命上限减少99%"
	},
	{
		6,
		"该精灵气势恒定为0"
	}
}
local t_qi_challenge_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_qi_challenge_buff.dataList = dataList

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

return t_qi_challenge_buff
