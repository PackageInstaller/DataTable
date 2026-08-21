-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_atk_const.lua

module("logic.config.t_air_atk_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	jsonObject = 7,
	numValues = 5,
	strValue = 4,
	numValue = 2,
	floatValues = 6
}
local dataList = {
	{
		"MaxChallengeNum",
		10,
		0,
		""
	},
	{
		"MaxRodeoLife",
		3,
		0,
		""
	},
	{
		"MaxEndLessLife",
		3,
		0,
		""
	},
	{
		"ChallengeNumRecoveryTime",
		21600,
		0,
		""
	},
	{
		"PropsExchange",
		1100018,
		0,
		""
	},
	{
		"MoneyExchange",
		60,
		0,
		""
	},
	{
		"BaseScoreCoefficient",
		0,
		0.1,
		""
	},
	{
		"LvAdd",
		0,
		0,
		"",
		[6] = {
			0.05,
			0.08,
			0.1,
			0.12,
			0.14,
			0.15,
			0.15,
			0.2,
			0.25,
			0.3,
			0.3,
			0.3,
			0.4,
			0.4,
			0.4,
			0.4,
			0.45,
			0.5,
			0.5,
			0.5
		}
	},
	{
		"ContWinAdd",
		0,
		0,
		"",
		[6] = {
			0,
			0.05,
			0.1,
			0.15,
			0.2
		}
	},
	{
		"DeadAdd",
		0,
		0,
		"",
		[6] = {
			0,
			-0.05,
			-0.1,
			-0.15,
			-0.2,
			-0.25
		}
	},
	{
		"LifeAdd",
		0,
		0,
		"",
		[6] = {
			0,
			0.1,
			0.15,
			0.2
		}
	},
	{
		"ResultCoefficient",
		0,
		0,
		"",
		[6] = {
			1,
			0.5
		}
	},
	{
		"HotRecommendNum",
		10,
		0,
		""
	},
	{
		"RodeoRecordNum",
		100,
		0,
		""
	},
	{
		"FreeRecordNum",
		100,
		0,
		""
	},
	{
		"OtherRecordNum",
		100,
		0,
		""
	},
	{
		"LikedMapPageNum",
		100,
		0,
		""
	}
}
local t_air_atk_const = {}

t_air_atk_const.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_air_atk_const[v[1]] = v

	setmetatable(v, mt)
end

return t_air_atk_const
