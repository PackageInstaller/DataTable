-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_direct_put_pet.lua

module("logicconfig.config.t_direct_put_pet", package.seeall)

local title = {
	activityId = 1,
	raceIds = 2
}
local dataList = {
	{
		60001,
		{
			10345
		}
	},
	{
		60002,
		{
			10202,
			10352,
			10318,
			10167,
			10144,
			10099,
			10129,
			10328,
			10341
		}
	},
	{
		60003,
		{
			10204,
			10332,
			10309,
			10342,
			10360,
			10143,
			10326,
			10334,
			10097
		}
	},
	{
		60004,
		{
			14000,
			14001,
			14002,
			10145,
			10313,
			10327,
			10027,
			10325,
			10343,
			10100,
			10147,
			10323,
			10324,
			10130,
			10165,
			10206,
			10085,
			10172,
			10048,
			10346,
			10349,
			10354
		}
	}
}
local t_direct_put_pet = {
	[60001] = dataList[1],
	[60002] = dataList[2],
	[60003] = dataList[3],
	[60004] = dataList[4]
}

t_direct_put_pet.dataList = dataList

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

return t_direct_put_pet
