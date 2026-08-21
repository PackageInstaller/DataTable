-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_achievement_skill.lua

module("logic.config.t_achievement_skill", package.seeall)

local title = {
	name = 2,
	describe = 4,
	effect = 5,
	levelRewards = 6,
	id = 1,
	icon = 3
}
local dataList = {
	{
		1,
		"营养学",
		"zgjn_01",
		"最合理的营养配比，由夸克制药为您用心定制。",
		"使用成长液时效果增强%s%%",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	},
	{
		2,
		"铸时工艺",
		"zgjn_02",
		"校时器的秘密，隐藏在每一次的扭转和缠绕中。",
		"强化校时器时经验获取提高%s%%",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	},
	{
		3,
		"调查直觉",
		"zgjn_03",
		"调查未知前路时，直觉才是最好的指南针。",
		"主线掉落的量子贝、守秘人经验增加%s%%",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	},
	{
		4,
		"量子算法",
		"zgjn_04",
		"量子叠加……分解算法……算力……加密破解？",
		"量子贝关卡掉落增加%s%%",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	},
	{
		5,
		"夜视力",
		"zgjn_05",
		"在红雾中前行，请擦亮双眼。",
		"红雾地区的关卡有%s%%几率额外产出一次奖励",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	},
	{
		6,
		"新节俭主义",
		"zgjn_06",
		"让每个量子贝都为自我提升而存在。",
		"守秘人升级消耗量子贝下降%s%%",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	},
	{
		7,
		"管理方针",
		"zgjn_07",
		"降本增效理念，已成为各组织培养人才的共识。",
		"守秘人亲和度消耗量子贝下降%s%%",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	},
	{
		8,
		"隐秘抗性",
		"zgjn_08",
		"从抵抗到适应，是抵消密室症候群的必经之路。",
		"行动时间上限提升%s",
		{
			[10] = 1609014,
			[18] = 1609016,
			[5] = 1609013,
			[21] = 1609017,
			[14] = 1609015
		}
	}
}
local t_achievement_skill = {}

t_achievement_skill.dataList = dataList

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
	t_achievement_skill[v[1]] = v

	setmetatable(v, mt)
end

return t_achievement_skill
