-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_make_gift_make_plan.lua

module("logicconfig.config.t_make_gift_make_plan", package.seeall)

local title = {
	iconRes = 4,
	cd = 3,
	time = 2,
	makePlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		"icon_zq_mianfen"
	},
	{
		1,
		2,
		0,
		"icon_dangao_zishu"
	},
	{
		1,
		3,
		0,
		"icon_dangao_huangyou"
	},
	{
		1,
		4,
		3,
		"icon_zq_jidan"
	},
	{
		1,
		5,
		0,
		"icon_dangao_zishudangao"
	},
	{
		1,
		6,
		0,
		"icon_nssw_rou"
	},
	{
		1,
		7,
		0,
		"icon_nssw_qingcai"
	},
	{
		1,
		8,
		0,
		"icon_nssw_mogu"
	},
	{
		1,
		9,
		3,
		"icon_nssw_yan"
	},
	{
		1,
		10,
		0,
		"icon_nssw_jiaozi"
	},
	{
		1,
		11,
		0,
		"icon_nssw_mianbao"
	},
	{
		1,
		12,
		0,
		"icon_nssw_jitui"
	},
	{
		1,
		13,
		0,
		"icon_nssw_guojiu2"
	},
	{
		1,
		14,
		3,
		"icon_nssw_qingcai"
	},
	{
		1,
		15,
		0,
		"icon_nssw_jitui2"
	}
}
local t_make_gift_make_plan = {
	{
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
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_make_gift_make_plan.dataList = dataList

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

return t_make_gift_make_plan
