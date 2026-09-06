-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_team_quick_chat.lua

module("logicconfig.config.t_form_team_quick_chat", package.seeall)

local title = {
	id = 1,
	quickChat = 2
}
local dataList = {
	{
		1,
		"加个好友吧"
	},
	{
		2,
		"大家快准备"
	},
	{
		3,
		"准备好就冲吧"
	},
	{
		4,
		"大佬求带飞"
	},
	{
		5,
		"大家加油"
	},
	{
		6,
		"冲冲冲"
	}
}
local t_form_team_quick_chat = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_form_team_quick_chat.dataList = dataList

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

return t_form_team_quick_chat
