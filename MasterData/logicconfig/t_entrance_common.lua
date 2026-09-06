-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_entrance_common.lua

module("logicconfig.config.t_entrance_common", package.seeall)

local title = {
	id = 1,
	value = 2
}
local dataList = {
	{
		"MAIL_OP",
		"2#1"
	},
	{
		"ADMIT",
		"6#5"
	},
	{
		"SUCCESS",
		"8#7"
	},
	{
		"NOT_TITLE",
		"完成认证考验，\n即可获得称号“萌新训练师”"
	},
	{
		"GET_TITLE",
		"现授予你“萌新训练师”称号，\n希望你能继续梦想，获得更大的成就！"
	}
}
local t_entrance_common = {
	MAIL_OP = dataList[1],
	ADMIT = dataList[2],
	SUCCESS = dataList[3],
	NOT_TITLE = dataList[4],
	GET_TITLE = dataList[5]
}

t_entrance_common.dataList = dataList

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

return t_entrance_common
