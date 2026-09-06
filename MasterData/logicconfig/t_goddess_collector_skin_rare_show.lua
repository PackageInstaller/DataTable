-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_collector_skin_rare_show.lua

module("logicconfig.config.t_goddess_collector_skin_rare_show", package.seeall)

local title = {
	rareId = 2,
	skinRareShowPlanId = 1,
	id = 3,
	skinId = 4
}
local dataList = {
	{
		1,
		8,
		1,
		16000
	},
	{
		1,
		8,
		2,
		16001
	},
	{
		1,
		8,
		3,
		16002
	},
	{
		1,
		8,
		4,
		16003
	},
	{
		1,
		8,
		5,
		16004
	},
	{
		1,
		8,
		6,
		16005
	},
	{
		1,
		7,
		1,
		16006
	},
	{
		1,
		7,
		2,
		16007
	},
	{
		1,
		7,
		3,
		16008
	},
	{
		1,
		6,
		1,
		16009
	},
	{
		1,
		6,
		2,
		16010
	},
	{
		1,
		6,
		3,
		16011
	},
	{
		1,
		6,
		4,
		16012
	},
	{
		1,
		5,
		1,
		16013
	},
	{
		1,
		5,
		2,
		16014
	},
	{
		1,
		3,
		1,
		16015
	},
	{
		1,
		3,
		2,
		16016
	},
	{
		1,
		3,
		3,
		16017
	}
}
local t_goddess_collector_skin_rare_show = {
	{
		[8] = {
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		[7] = {
			dataList[7],
			dataList[8],
			dataList[9]
		},
		[6] = {
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13]
		},
		[5] = {
			dataList[14],
			dataList[15]
		},
		[3] = {
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_goddess_collector_skin_rare_show.dataList = dataList

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

return t_goddess_collector_skin_rare_show
