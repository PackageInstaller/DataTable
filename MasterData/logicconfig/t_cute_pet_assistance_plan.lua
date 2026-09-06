-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_assistance_plan.lua

module("logicconfig.config.t_cute_pet_assistance_plan", package.seeall)

local title = {
	assistancePlanId = 1,
	quality = 2,
	zdlRate = 4,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"全队暴击伤害增加<color=#20B376>9%</color>，持续1回合",
		0.001
	},
	{
		1,
		2,
		"全队暴击伤害增加<color=#20B376>10.5%</color>，持续1回合",
		0.002
	},
	{
		1,
		3,
		"全队暴击伤害增加<color=#20B376>12%</color>，持续1回合",
		0.003
	},
	{
		1,
		4,
		"全队暴击伤害增加<color=#20B376>13.5%</color>，持续1回合",
		0.004
	},
	{
		1,
		5,
		"全队暴击伤害增加<color=#20B376>15%</color>，持续1回合",
		0.005
	},
	{
		2,
		1,
		"全队伤害增加<color=#20B376>3%</color>，持续2回合",
		0.001
	},
	{
		2,
		2,
		"全队伤害增加<color=#20B376>3.5%</color>，持续2回合",
		0.002
	},
	{
		2,
		3,
		"全队伤害增加<color=#20B376>4%</color>，持续2回合",
		0.003
	},
	{
		2,
		4,
		"全队伤害增加<color=#20B376>4.5%</color>，持续2回合",
		0.004
	},
	{
		2,
		5,
		"全队伤害增加<color=#20B376>5%</color>，持续2回合",
		0.005
	},
	{
		3,
		1,
		"全队受到的伤害减少<color=#20B376>7.5%</color>，持续1回合",
		0.001
	},
	{
		3,
		2,
		"全队受到的伤害减少<color=#20B376>8.75%</color>，持续1回合",
		0.002
	},
	{
		3,
		3,
		"全队受到的伤害减少<color=#20B376>10%</color>，持续1回合",
		0.003
	},
	{
		3,
		4,
		"全队受到的伤害减少<color=#20B376>11.25%</color>，持续1回合",
		0.004
	},
	{
		3,
		5,
		"全队受到的伤害减少<color=#20B376>12.5%</color>，持续1回合",
		0.005
	},
	{
		4,
		1,
		"全队防御属性提升<color=#20B376>4.5%</color>，持续2回合",
		0.001
	},
	{
		4,
		2,
		"全队防御属性提升<color=#20B376>5.25%</color>，持续2回合",
		0.002
	},
	{
		4,
		3,
		"全队防御属性提升<color=#20B376>6%</color>，持续2回合",
		0.003
	},
	{
		4,
		4,
		"全队防御属性提升<color=#20B376>6.75%</color>，持续2回合",
		0.004
	},
	{
		4,
		5,
		"全队防御属性提升<color=#20B376>7.5%</color>，持续2回合",
		0.005
	}
}
local t_cute_pet_assistance_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_cute_pet_assistance_plan.dataList = dataList

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

return t_cute_pet_assistance_plan
