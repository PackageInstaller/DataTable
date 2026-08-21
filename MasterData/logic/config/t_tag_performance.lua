-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_tag_performance.lua

module("logic.config.t_tag_performance", package.seeall)

local title = {
	stageType = 3,
	stageCount = 4,
	modelCode = 1,
	hitPointEffectCode = 6,
	hasRange = 7,
	amplitudes = 9,
	tagType = 2,
	hasDifferentShape = 8,
	resPath = 5
}
local dataList = {
	{
		100022,
		"ArcLight",
		0,
		0,
		"biaoqian_huguang_feiniao",
		20007,
		false,
		false,
		{
			1,
			0,
			0
		}
	},
	{
		100039,
		"MoonRing",
		0,
		0,
		"biaoqian_zhengdang_mirror",
		0,
		false,
		false,
		{
			1,
			0,
			0
		}
	},
	{
		100057,
		"Bomb",
		0,
		0,
		"biaoqian_edipusi",
		0,
		false,
		true,
		{
			2,
			2,
			2
		}
	},
	{
		100041,
		"MoonRing",
		0,
		0,
		"biaoqian_xinderuila",
		0,
		true,
		false,
		{
			1,
			2,
			3
		}
	},
	{
		100005,
		"Assist",
		0,
		0,
		"biaoqian_huanxing",
		0,
		true,
		false,
		{
			0
		}
	},
	{
		100056,
		"Assist",
		0,
		0,
		"biaoqian_yuanhu_curse",
		0,
		true,
		false,
		{
			0
		}
	},
	{
		100012,
		"Bomb",
		0,
		0,
		"biaoqian_fenlier",
		0,
		false,
		false,
		{
			2,
			0,
			0
		}
	},
	{
		100019,
		"Bomb",
		0,
		0,
		"biaoqian_duolian",
		0,
		true,
		false,
		{
			1,
			2,
			3
		}
	},
	{
		100055,
		"Bomb",
		0,
		0,
		"biaoqian_geligaolie",
		0,
		true,
		false,
		{
			1,
			2,
			3
		}
	},
	{
		100011,
		"Chase",
		1,
		3,
		"100011_yiyun_biaoqian",
		0,
		false,
		false,
		{
			0
		}
	},
	{
		100016,
		"Chase",
		2,
		0,
		"100016_yanhuo_attack_skip",
		0,
		false,
		false,
		{
			0
		}
	},
	{
		100002,
		"Bomb",
		0,
		0,
		"biaoqian_alisi",
		0,
		true,
		false,
		{
			1,
			2,
			3
		}
	}
}
local t_tag_performance = {}

t_tag_performance.dataList = dataList

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
	local parent1 = t_tag_performance[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_tag_performance[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_tag_performance
