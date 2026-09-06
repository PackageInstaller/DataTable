-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vip_define.lua

module("logicconfig.config.t_vip_define", package.seeall)

local title = {
	vipExp = 2,
	vipLv = 1,
	weeklyBonus = 3
}
local dataList = {
	{
		0,
		0,
		"4:400004:4#9:3000:14#8:8:700#4:90274:100#4:2000:30#4:901:300#4:5000:200"
	},
	{
		1,
		12,
		"4:400004:5#9:3000:28#8:8:1400#4:90274:150#4:2000:60#4:901:500#4:5000:350"
	},
	{
		2,
		36,
		"4:400004:6#9:3000:35#8:8:2100#4:90274:200#4:2000:90#4:901:600#4:5000:700"
	},
	{
		3,
		88,
		"4:400004:8#9:3000:56#8:8:2800#4:90274:250#4:2000:120#4:901:700#4:5000:1050"
	},
	{
		4,
		198,
		"4:400004:10#9:3000:70#8:8:3500#4:90274:300#4:2000:150#4:901:1400#4:5000:1400"
	},
	{
		5,
		500,
		"4:400004:15#9:3000:84#8:8:4200#4:90274:350#4:2000:180#4:901:2100#4:5000:1750"
	},
	{
		6,
		1200,
		"4:400004:20#9:3000:112#8:8:5600#4:90274:400#4:2000:210#4:901:2800#4:5000:2100"
	},
	{
		7,
		3000,
		"4:400004:25#9:3000:140#8:8:7000#4:90274:450#4:2000:240#4:901:3500#4:5000:2800"
	},
	{
		8,
		5998,
		"4:400004:30#9:3000:175#8:8:8000#4:90274:500#4:2000:270#4:901:4000#4:5000:3500"
	},
	{
		9,
		7998,
		"4:400004:35#9:3000:210#8:8:9000#4:90274:550#4:2000:300#4:901:4500#4:5000:4300"
	},
	{
		10,
		13998,
		"4:400004:40#9:3000:250#8:8:10000#4:90274:600#4:2000:330#4:901:5000#4:5000:5300"
	}
}
local t_vip_define = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11]
}

t_vip_define.dataList = dataList

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

return t_vip_define
