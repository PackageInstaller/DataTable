-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_skill_label.lua

module("logicconfig.config.t_btl_skill_label", package.seeall)

local title = {
	labelResName = 5,
	labelId = 1,
	outlineColor = 4,
	labelColor = 3,
	labelName = 2
}
local dataList = {
	{
		1,
		"加气",
		"#20b376",
		"#0c7b4d",
		""
	},
	{
		2,
		"降气",
		"#df5bff",
		"#7128a6",
		""
	},
	{
		3,
		"复活",
		"#20b376",
		"#0c7b4d",
		""
	},
	{
		5,
		"禁疗",
		"#df5bff",
		"#7128a6",
		""
	},
	{
		6,
		"群攻",
		"#20b376",
		"#7128a6",
		""
	},
	{
		7,
		"变身",
		"#20b376",
		"#7128a6",
		""
	}
}
local t_btl_skill_label = {
	dataList[1],
	dataList[2],
	dataList[3],
	[5] = dataList[4],
	[6] = dataList[5],
	[7] = dataList[6]
}

t_btl_skill_label.dataList = dataList

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

return t_btl_skill_label
