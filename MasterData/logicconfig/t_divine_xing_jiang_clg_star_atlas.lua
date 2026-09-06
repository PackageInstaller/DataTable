-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xing_jiang_clg_star_atlas.lua

module("logicconfig.config.t_divine_xing_jiang_clg_star_atlas", package.seeall)

local title = {
	id = 1,
	posIds = 2
}
local dataList = {
	{
		1,
		{
			2,
			4,
			5,
			6,
			7,
			8,
			9
		}
	},
	{
		2,
		{
			1,
			2,
			3,
			4,
			6,
			7,
			9
		}
	},
	{
		3,
		{
			1,
			2,
			3,
			4,
			6,
			7,
			8,
			9
		}
	},
	{
		4,
		{
			1,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		}
	},
	{
		5,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		}
	},
	{
		6,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		}
	}
}
local t_divine_xing_jiang_clg_star_atlas = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_divine_xing_jiang_clg_star_atlas.dataList = dataList

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

return t_divine_xing_jiang_clg_star_atlas
