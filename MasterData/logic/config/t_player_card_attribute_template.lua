-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_player_card_attribute_template.lua

module("logic.config.t_player_card_attribute_template", package.seeall)

local title = {
	portrait = 5,
	name = 3,
	answers = 6,
	attributes = 2,
	id = 1,
	desc = 4
}
local dataList = {
	{
		1,
		{
			1,
			1,
			2,
			1,
			2,
			2
		},
		"护卫者",
		"每一个善良的灵魂都值得被守护，坚韧且忠诚的同行者。",
		2301001,
		{
			1,
			1
		}
	},
	{
		2,
		{
			2,
			1,
			1,
			2,
			2,
			1
		},
		"契约者",
		"无论善恶，等价代换，温柔与残忍交织而成的一杯毒酒。",
		2301002,
		{
			1,
			2
		}
	},
	{
		3,
		{
			1,
			2,
			2,
			1,
			2,
			1
		},
		"颠覆者",
		"凌驾于棋盘之上，操控棋手之人。",
		2301003,
		{
			1,
			3
		}
	},
	{
		4,
		{
			1,
			1,
			2,
			2,
			2,
			1
		},
		"慈悲者",
		"平等地爱着世界的一切，直至伤痕累累。",
		2301004,
		{
			2,
			1
		}
	},
	{
		5,
		{
			1,
			2,
			1,
			2,
			1,
			2
		},
		"制衡者",
		"正义与邪恶， 都是一种手段。",
		2301005,
		{
			2,
			2
		}
	},
	{
		6,
		{
			2,
			2,
			1,
			2,
			1,
			1
		},
		"旁观者",
		"无动于衷，在画框之外看着世界的人。",
		2301006,
		{
			2,
			3
		}
	},
	{
		7,
		{
			1,
			1,
			2,
			1,
			2,
			2
		},
		"逆行者",
		"不会沉默的歌者，不会止步的舞者。",
		2301007,
		{
			3,
			1
		}
	},
	{
		8,
		{
			2,
			1,
			1,
			2,
			1,
			2
		},
		"独行者",
		"自由的灵魂，有趣但孤独。",
		2301008,
		{
			3,
			2
		}
	},
	{
		9,
		{
			1,
			2,
			1,
			1,
			2,
			2
		},
		"狂欢者",
		"在旧世界的残骸上狂欢，却不曾期待黎明的到来。",
		2301009,
		{
			3,
			3
		}
	}
}
local t_player_card_attribute_template = {}

t_player_card_attribute_template.dataList = dataList

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
	t_player_card_attribute_template[v[1]] = v

	setmetatable(v, mt)
end

return t_player_card_attribute_template
