-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge_form_check.lua

module("logicconfig.config.t_king_meng_meng_challenge_form_check", package.seeall)

local title = {
	activityId = 1,
	formId = 2
}
local dataList = {
	{
		278001,
		50
	},
	{
		278001,
		51
	},
	{
		278001,
		52
	},
	{
		278001,
		53
	},
	{
		278001,
		54
	},
	{
		278001,
		100
	},
	{
		278002,
		50
	},
	{
		278002,
		51
	},
	{
		278002,
		52
	},
	{
		278002,
		53
	},
	{
		278002,
		54
	},
	{
		278002,
		100
	}
}
local t_king_meng_meng_challenge_form_check = {
	[278001] = {
		[50] = dataList[1],
		[51] = dataList[2],
		[52] = dataList[3],
		[53] = dataList[4],
		[54] = dataList[5],
		[100] = dataList[6]
	},
	[278002] = {
		[50] = dataList[7],
		[51] = dataList[8],
		[52] = dataList[9],
		[53] = dataList[10],
		[54] = dataList[11],
		[100] = dataList[12]
	}
}

t_king_meng_meng_challenge_form_check.dataList = dataList

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

return t_king_meng_meng_challenge_form_check
