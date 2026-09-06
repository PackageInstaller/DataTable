-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_alchemy_meng_meng_mark.lua

module("logicconfig.config.t_origin_alchemy_meng_meng_mark", package.seeall)

local title = {
	resName = 6,
	buffId = 4,
	markId = 2,
	gainCompound = 3,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		601001,
		1,
		{
			1
		},
		20073424,
		82056669,
		"icon_shiji_02"
	},
	{
		601001,
		2,
		{
			2
		},
		20073427,
		82056670,
		"icon_shiji_03"
	},
	{
		601001,
		3,
		{
			3
		},
		20073429,
		82056173,
		"icon_shiji_01"
	}
}
local t_origin_alchemy_meng_meng_mark = {
	[601001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_alchemy_meng_meng_mark.dataList = dataList

local multiLanguageCells = {
	desc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_alchemy_meng_meng_mark
