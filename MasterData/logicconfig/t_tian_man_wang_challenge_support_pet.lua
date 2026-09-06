-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_man_wang_challenge_support_pet.lua

module("logicconfig.config.t_tian_man_wang_challenge_support_pet", package.seeall)

local title = {
	supportPetId = 1,
	isSummonMaster = 4,
	raceId = 3,
	unlockCondition = 2,
	desc = 5
}
local dataList = {
	{
		1000000001,
		1,
		10099,
		true,
		""
	},
	{
		1000000002,
		1,
		10159,
		false,
		"选用功夫熊猫，天蛮王反弹50%物理伤害，不超过最大生命值的50%"
	},
	{
		1000000003,
		2,
		10202,
		false,
		"选用真元玄武，天蛮王受伤减伤30%"
	},
	{
		1000000004,
		3,
		10129,
		false,
		"选用混元天命·真龙，天蛮王最大生命值+50%"
	},
	{
		1000000005,
		4,
		10328,
		false,
		"选用辛西娅，天蛮王伤害+50%"
	}
}
local t_tian_man_wang_challenge_support_pet = {
	[1000000001] = dataList[1],
	[1000000002] = dataList[2],
	[1000000003] = dataList[3],
	[1000000004] = dataList[4],
	[1000000005] = dataList[5]
}

t_tian_man_wang_challenge_support_pet.dataList = dataList

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

return t_tian_man_wang_challenge_support_pet
