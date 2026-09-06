-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lottery_self_select_pet_group.lua

module("logicconfig.config.t_lottery_self_select_pet_group", package.seeall)

local title = {
	gridId = 2,
	raceIds = 3,
	poolId = 1
}
local dataList = {
	{
		201,
		1,
		{
			17027,
			17026,
			15032,
			12030,
			15041,
			18011,
			17024,
			12037,
			16039,
			11028,
			12027
		}
	},
	{
		201,
		2,
		{
			14048,
			12023,
			16028,
			17016,
			16024,
			14023,
			14020,
			13008,
			14024,
			17010,
			16038,
			15030,
			16020,
			15020
		}
	},
	{
		201,
		3,
		{
			13030,
			15033,
			14036,
			11026,
			11025,
			12026,
			15029,
			17022,
			14029,
			14030,
			15019,
			16023,
			17011,
			11023,
			11002,
			12004,
			10314,
			16009
		}
	},
	{
		201,
		4,
		{
			12012,
			11012,
			13017,
			11017,
			13011,
			10330,
			17006,
			16006,
			17007,
			13006,
			12005,
			16004,
			16005,
			16003,
			15006,
			15013,
			15014,
			14010,
			16014,
			12010,
			16013,
			17008
		}
	}
}
local t_lottery_self_select_pet_group = {
	[201] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_lottery_self_select_pet_group.dataList = dataList

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

return t_lottery_self_select_pet_group
