-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_loop_clg.lua

module("logicconfig.config.t_chop_king_loop_clg", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		470001,
		1,
		2001
	},
	{
		470001,
		2,
		2002
	},
	{
		470001,
		3,
		2003
	},
	{
		470001,
		4,
		2004
	},
	{
		470001,
		5,
		2005
	},
	{
		470001,
		6,
		2006
	},
	{
		470001,
		7,
		2007
	},
	{
		470001,
		8,
		2008
	},
	{
		470001,
		9,
		2009
	},
	{
		470001,
		10,
		2010
	}
}
local t_chop_king_loop_clg = {
	[470001] = {
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
}

t_chop_king_loop_clg.dataList = dataList

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

return t_chop_king_loop_clg
