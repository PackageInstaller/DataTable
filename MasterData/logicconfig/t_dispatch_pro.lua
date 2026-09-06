-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dispatch_pro.lua

module("logicconfig.config.t_dispatch_pro", package.seeall)

local title = {
	taskPro = 2,
	dispatchPro = 1
}
local dataList = {
	{
		1,
		101
	},
	{
		1,
		102
	},
	{
		2,
		201
	},
	{
		2,
		202
	},
	{
		3,
		301
	},
	{
		3,
		302
	},
	{
		4,
		401
	},
	{
		4,
		402
	},
	{
		5,
		501
	},
	{
		5,
		502
	},
	{
		6,
		601
	},
	{
		6,
		602
	},
	{
		7,
		701
	},
	{
		7,
		702
	},
	{
		8,
		801
	},
	{
		8,
		802
	},
	{
		9,
		901
	},
	{
		9,
		902
	}
}
local t_dispatch_pro = {
	{
		[101] = dataList[1],
		[102] = dataList[2]
	},
	{
		[201] = dataList[3],
		[202] = dataList[4]
	},
	{
		[301] = dataList[5],
		[302] = dataList[6]
	},
	{
		[401] = dataList[7],
		[402] = dataList[8]
	},
	{
		[501] = dataList[9],
		[502] = dataList[10]
	},
	{
		[601] = dataList[11],
		[602] = dataList[12]
	},
	{
		[701] = dataList[13],
		[702] = dataList[14]
	},
	{
		[801] = dataList[15],
		[802] = dataList[16]
	},
	{
		[901] = dataList[17],
		[902] = dataList[18]
	}
}

t_dispatch_pro.dataList = dataList

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

return t_dispatch_pro
