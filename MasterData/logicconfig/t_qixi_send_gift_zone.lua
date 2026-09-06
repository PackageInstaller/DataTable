-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qixi_send_gift_zone.lua

module("logicconfig.config.t_qixi_send_gift_zone", package.seeall)

local title = {
	areaIds = 3,
	name = 2,
	zoneId = 1
}
local dataList = {
	{
		1,
		"001大区",
		{
			0,
			10
		}
	},
	{
		2,
		"002大区",
		{
			11,
			20
		}
	},
	{
		3,
		"003大区",
		{
			21,
			30
		}
	},
	{
		4,
		"004大区",
		{
			31,
			49
		}
	},
	{
		5,
		"005大区",
		{
			50,
			60
		}
	},
	{
		6,
		"006大区",
		{
			61,
			79
		}
	},
	{
		7,
		"007大区",
		{
			80,
			89
		}
	},
	{
		8,
		"008大区",
		{
			90,
			99
		}
	},
	{
		9,
		"009大区",
		{
			100,
			109
		}
	},
	{
		10,
		"010大区",
		{
			110,
			119
		}
	},
	{
		11,
		"011大区",
		{
			120,
			129
		}
	},
	{
		12,
		"012大区",
		{
			130,
			139
		}
	}
}
local t_qixi_send_gift_zone = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12]
}

t_qixi_send_gift_zone.dataList = dataList

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

return t_qixi_send_gift_zone
