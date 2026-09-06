-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_normal_stage_plan.lua

module("logicconfig.config.t_divine_tian_shan_clg_normal_stage_plan", package.seeall)

local title = {
	stagePlanId = 1,
	display = 8,
	buffPlanId = 4,
	stageDesc = 6,
	creepsMasterId = 3,
	lihuiId = 7,
	stageId = 2,
	stageName = 5
}
local dataList = {
	{
		1,
		1,
		201,
		1,
		"风暴领主",
		"1、各个领主根据剩余血量的百分比，激活不同的加成。\r\n2、激活的加成在所有领主的战斗中生效。\r\n3、全部领主的累计伤害达标后可领取进度奖励。\r\n4、每日拥有5次挑战机会,所有领主共享\r\n5、演习不扣次数,伤害记录不累计",
		12020,
		{
			0,
			70,
			1
		}
	},
	{
		1,
		2,
		202,
		2,
		"闪电领主",
		"1、各个领主根据剩余血量的百分比，激活不同的加成。\r\n2、激活的加成在所有领主的战斗中生效。\r\n3、全部领主的累计伤害达标后可领取进度奖励。\r\n4、每日拥有5次挑战机会,所有领主共享\r\n5、演习不扣次数,伤害记录不累计",
		12022,
		{
			0,
			150,
			0.9
		}
	},
	{
		1,
		3,
		203,
		3,
		"骤雨领主",
		"1、各个领主根据剩余血量的百分比，激活不同的加成。\r\n2、激活的加成在所有领主的战斗中生效。\r\n3、全部领主的累计伤害达标后可领取进度奖励。\r\n4、每日拥有5次挑战机会,所有领主共享\r\n5、演习不扣次数,伤害记录不累计",
		13008,
		{
			50,
			0,
			1.2
		}
	},
	{
		1,
		4,
		204,
		4,
		"冰雹领主",
		"1、各个领主根据剩余血量的百分比，激活不同的加成。\r\n2、激活的加成在所有领主的战斗中生效。\r\n3、全部领主的累计伤害达标后可领取进度奖励。\r\n4、每日拥有5次挑战机会,所有领主共享\r\n5、演习不扣次数,伤害记录不累计",
		13009,
		{
			0,
			60,
			1
		}
	}
}
local t_divine_tian_shan_clg_normal_stage_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_tian_shan_clg_normal_stage_plan.dataList = dataList

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

return t_divine_tian_shan_clg_normal_stage_plan
