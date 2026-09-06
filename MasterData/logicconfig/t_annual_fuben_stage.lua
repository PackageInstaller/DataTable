-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_stage.lua

module("logicconfig.config.t_annual_fuben_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	buffDesc = 6,
	buff = 5,
	creepsMasterId = 3,
	prize = 4
}
local dataList = {
	{
		546001,
		1,
		101,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高20%"
	},
	{
		546001,
		2,
		102,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99#20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高40%"
	},
	{
		546001,
		3,
		103,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99#20055806:99#20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高60%"
	},
	{
		546001,
		4,
		104,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99#20055806:99#20055806:99#20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高80%"
	},
	{
		546001,
		5,
		105,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99#20055806:99#20055806:99#20055806:99#20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高100%"
	},
	{
		546001,
		6,
		106,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99#20055806:99#20055806:99#20055806:99#20055806:99#20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高120%"
	},
	{
		546001,
		7,
		107,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99#20055806:99#20055806:99#20055806:99#20055806:99#20055806:99#20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高140%"
	},
	{
		546001,
		8,
		108,
		"10:546001:200#10:310016:200",
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20055806:99#20055806:99#20055806:99#20055806:99#20055806:99#20055806:99#20055806:99#20055806:99"
				}
			}
		},
		"敌阵受到的伤害提高160%"
	}
}
local t_annual_fuben_stage = {
	[546001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_annual_fuben_stage.dataList = dataList

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

return t_annual_fuben_stage
