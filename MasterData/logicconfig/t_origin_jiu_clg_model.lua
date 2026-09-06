-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_jiu_clg_model.lua

module("logicconfig.config.t_origin_jiu_clg_model", package.seeall)

local title = {
	bossCreepsMasterId = 3,
	bossPrize = 4,
	modelId = 2,
	activityId = 1,
	effectSignInBuff = 5
}
local dataList = {
	{
		577001,
		1,
		1007,
		"4:510760:100",
		false
	},
	{
		577001,
		2,
		1014,
		"4:440:20",
		true
	}
}
local t_origin_jiu_clg_model = {
	[577001] = {
		dataList[1],
		dataList[2]
	}
}

t_origin_jiu_clg_model.dataList = dataList

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

return t_origin_jiu_clg_model
