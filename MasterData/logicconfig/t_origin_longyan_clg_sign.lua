-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_longyan_clg_sign.lua

module("logicconfig.config.t_origin_longyan_clg_sign", package.seeall)

local title = {
	signName = 6,
	triDesc = 7,
	showState = 8,
	signId = 2,
	positionBuff = 3,
	signBuffId = 5,
	signProgressBuffId = 4,
	needLayoutNum = 9,
	activityId = 1
}
local dataList = {
	{
		563001,
		1,
		"20070001:99",
		20070006,
		20070007,
		"坚毅",
		"坚毅条件：攻击后若自身是平衡职业则加1点进度，进度达到4点时给敌阵10%免伤及非伤免伤和10%全属性",
		1,
		4
	},
	{
		563001,
		2,
		"20070008:99",
		20070012,
		20070013,
		"热血",
		"热血条件：攻击后若自身是火属性则加1点进度，进度达到4点时给敌阵50点气势和1次立即出手",
		2,
		4
	},
	{
		563001,
		3,
		"20070014:99",
		20070019,
		20070020,
		"坚毅",
		"坚毅条件：攻击后若自身是平衡职业则加1点进度，进度达到3点时给敌阵30%免伤及非伤免伤和30%全属性",
		1,
		3
	},
	{
		563001,
		4,
		"20070021:99",
		20070025,
		20070026,
		"热血",
		"热血条件：攻击后若自身是火属性则加1点进度，进度达到3点时给敌阵100点气势和1次立即出手",
		2,
		3
	},
	{
		563001,
		5,
		"20070027:99",
		20070032,
		20070033,
		"坚毅",
		"坚毅条件：攻击后若自身是平衡职业则加1点进度，进度达到2点时给敌阵50%免伤及非伤免伤和50%全属性",
		1,
		2
	},
	{
		563001,
		6,
		"20070034:99",
		20070038,
		20070039,
		"热血",
		"热血条件：攻击后若自身是火属性则加1点进度，进度达到2点时给敌阵150点气势和1次立即出手",
		2,
		2
	}
}
local t_origin_longyan_clg_sign = {
	[563001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_longyan_clg_sign.dataList = dataList

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

return t_origin_longyan_clg_sign
