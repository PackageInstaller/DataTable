-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_introduction_career.lua

module("logic.config.t_introduction_career", package.seeall)

local title = {
	mobility = 3,
	range = 2,
	career = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"4",
		"穿梭于战场中的作战单位，具有较为灵活的作战能力"
	},
	{
		2,
		1,
		"2",
		"具有较高的生命力及防御能力，是队友可靠的守护者"
	},
	{
		3,
		2,
		"2",
		"擅长远距离作战，凭借较高的灵感对敌人进行针对性打击"
	},
	{
		4,
		2,
		"2",
		"具有较高的灵感，并且能跨越一般单位无法行走的区域"
	},
	{
		5,
		4,
		"1",
		"擅长造成范围性伤害，并且能根据命中敌人的数量强化下次攻击的伤害"
	},
	{
		6,
		2,
		"2",
		"擅长支援友方单位，能对友方单位施加治疗或增益"
	}
}
local t_introduction_career = {}

t_introduction_career.dataList = dataList

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
	t_introduction_career[v[1]] = v

	setmetatable(v, mt)
end

return t_introduction_career
