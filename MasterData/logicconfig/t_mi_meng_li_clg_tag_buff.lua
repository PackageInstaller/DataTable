-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_meng_li_clg_tag_buff.lua

module("logicconfig.config.t_mi_meng_li_clg_tag_buff", package.seeall)

local title = {
	tagType = 2,
	tagNum = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		417001,
		1,
		1,
		"-20%最大生命值"
	},
	{
		417001,
		1,
		2,
		"-40%最大生命值"
	},
	{
		417001,
		1,
		4,
		"-60%最大生命值"
	},
	{
		417001,
		1,
		6,
		"-80%最大生命值"
	},
	{
		417001,
		2,
		1,
		"-20%治疗效果"
	},
	{
		417001,
		2,
		2,
		"-40%治疗效果"
	},
	{
		417001,
		2,
		4,
		"-60%治疗效果"
	},
	{
		417001,
		2,
		6,
		"-80%治疗效果"
	},
	{
		417001,
		3,
		1,
		"-20%攻击力"
	},
	{
		417001,
		3,
		2,
		"-40%攻击力"
	},
	{
		417001,
		3,
		4,
		"-60%攻击力"
	},
	{
		417001,
		3,
		6,
		"-80%攻击力"
	},
	{
		417001,
		4,
		1,
		"初始气势-20"
	},
	{
		417001,
		4,
		2,
		"初始气势-40"
	},
	{
		417001,
		4,
		4,
		"初始气势-60"
	},
	{
		417001,
		4,
		6,
		"初始气势-80"
	}
}
local t_mi_meng_li_clg_tag_buff = {
	[417001] = {
		{
			dataList[1],
			dataList[2],
			[4] = dataList[3],
			[6] = dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			[4] = dataList[7],
			[6] = dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			[4] = dataList[11],
			[6] = dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			[4] = dataList[15],
			[6] = dataList[16]
		}
	}
}

t_mi_meng_li_clg_tag_buff.dataList = dataList

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

return t_mi_meng_li_clg_tag_buff
