-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ares_mom_settler.lua

module("logicconfig.config.t_ares_mom_settler", package.seeall)

local title = {
	id = 1,
	des = 2
}
local dataList = {
	{
		1,
		"总伤害%d"
	},
	{
		2,
		"己方存活%d个数"
	},
	{
		3,
		"己方存活火精灵%d个数"
	},
	{
		4,
		"己方存活水精灵%d个数"
	},
	{
		5,
		"己方存活草精灵%d个数"
	},
	{
		6,
		"总伤害%d"
	},
	{
		7,
		"己方存活%d个数"
	},
	{
		8,
		"己方存活火精灵%d个数"
	},
	{
		9,
		"己方存活水精灵%d个数"
	},
	{
		10,
		"己方存活草精灵%d个数"
	}
}
local t_ares_mom_settler = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_ares_mom_settler.dataList = dataList

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

return t_ares_mom_settler
