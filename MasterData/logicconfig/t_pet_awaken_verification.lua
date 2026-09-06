-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_awaken_verification.lua

module("logicconfig.config.t_pet_awaken_verification", package.seeall)

local title = {
	activityId = 1,
	goPlanId = 3,
	petPlanId = 2
}
local dataList = {
	{
		115001,
		1,
		1
	},
	{
		115002,
		2,
		1
	},
	{
		115003,
		3,
		1
	},
	{
		115004,
		4,
		1
	},
	{
		115005,
		5,
		1
	}
}
local t_pet_awaken_verification = {
	[115001] = dataList[1],
	[115002] = dataList[2],
	[115003] = dataList[3],
	[115004] = dataList[4],
	[115005] = dataList[5]
}

t_pet_awaken_verification.dataList = dataList

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

return t_pet_awaken_verification
