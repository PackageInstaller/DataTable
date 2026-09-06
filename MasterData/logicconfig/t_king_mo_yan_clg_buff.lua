-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_mo_yan_clg_buff.lua

module("logicconfig.config.t_king_mo_yan_clg_buff", package.seeall)

local title = {
	activityId = 1,
	num = 3,
	buffId = 2,
	desc = 4
}
local dataList = {
	{
		429001,
		1,
		1,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到1次，我方精灵会获得虚弱Ⅰ"
	},
	{
		429001,
		2,
		2,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到2次，我方精灵会获得虚弱Ⅱ"
	},
	{
		429001,
		3,
		3,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到3次，我方精灵会获得虚弱Ⅲ"
	},
	{
		429001,
		4,
		4,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到4次，我方精灵会获得虚弱Ⅳ"
	},
	{
		429001,
		5,
		5,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到5次，我方精灵会获得虚弱Ⅴ和全属性减少Ⅰ"
	},
	{
		429001,
		6,
		6,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到6次，我方精灵会获得虚弱Ⅵ和全属性减少Ⅱ"
	},
	{
		429001,
		7,
		8,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到8次，我方精灵会获得虚弱Ⅶ和全属性减少Ⅲ"
	},
	{
		429001,
		8,
		10,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到10次，我方精灵会获得虚弱Ⅷ和全属性减少Ⅳ"
	},
	{
		429002,
		1,
		1,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到1次，我方精灵会获得虚弱Ⅰ"
	},
	{
		429002,
		2,
		2,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到2次，我方精灵会获得虚弱Ⅱ"
	},
	{
		429002,
		3,
		3,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到3次，我方精灵会获得虚弱Ⅲ"
	},
	{
		429002,
		4,
		4,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到4次，我方精灵会获得虚弱Ⅳ"
	},
	{
		429002,
		5,
		5,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到5次，我方精灵会获得虚弱Ⅴ和全属性减少Ⅰ"
	},
	{
		429002,
		6,
		6,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到6次，我方精灵会获得虚弱Ⅵ和全属性减少Ⅱ"
	},
	{
		429002,
		7,
		8,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到8次，我方精灵会获得虚弱Ⅶ和全属性减少Ⅲ"
	},
	{
		429002,
		8,
		10,
		"王者末炎在我方阵上作为战者\r\n王者末炎超杀次数达到10次，我方精灵会获得虚弱Ⅷ和全属性减少Ⅳ"
	}
}
local t_king_mo_yan_clg_buff = {
	[429001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[429002] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_king_mo_yan_clg_buff.dataList = dataList

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

return t_king_mo_yan_clg_buff
