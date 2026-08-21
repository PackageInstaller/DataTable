-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_growth_plan.lua

module("logic.config.t_growth_plan", package.seeall)

local title = {
	heroId = 2,
	stages = 3,
	id = 1,
	icon = 5,
	desc = 4
}
local dataList = {
	{
		1,
		2000008,
		{
			101,
			102,
			103,
			104,
			105,
			106
		},
		"六分仪能够使用强力的限制技替代通常技进行追击,具有极强的爆发能力",
		"main_icon_smrtx_lfy"
	},
	{
		2,
		2000019,
		{
			201,
			202,
			203,
			204,
			205,
			206
		},
		"多里安能够将超感转为现实伤害,并施加大范围的超感,具有极强的范围伤害能力",
		"main_icon_smrtx_dla"
	},
	{
		3,
		2000041,
		{
			301,
			302,
			303,
			304,
			305,
			306
		},
		"辛德瑞拉释放的振荡重复次数越多,范围也会变得越大,是伤害和范围兼顾的全能角色",
		"main_icon_smrtx_xdrl"
	}
}
local t_growth_plan = {}

t_growth_plan.dataList = dataList

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
	t_growth_plan[v[1]] = v

	setmetatable(v, mt)
end

return t_growth_plan
