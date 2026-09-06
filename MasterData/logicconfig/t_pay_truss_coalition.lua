-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_truss_coalition.lua

module("logicconfig.config.t_pay_truss_coalition", package.seeall)

local title = {
	originPrice = 6,
	showDiscount = 5,
	payGoodsId = 4,
	id = 2,
	purchasedIds = 3,
	activityId = 1
}
local dataList = {
	{
		27001,
		1,
		{},
		"rmb_98",
		7.6,
		0
	},
	{
		27001,
		2,
		{
			1
		},
		"rmb_78",
		7.8,
		0
	},
	{
		27001,
		3,
		{
			2
		},
		"rmb_78",
		7.9,
		0
	},
	{
		27001,
		4,
		{
			3
		},
		"rmb_78",
		7.9,
		0
	},
	{
		27001,
		5,
		{
			4
		},
		"rmb_68",
		7.7,
		0
	},
	{
		27001,
		6,
		{
			1,
			2
		},
		"rmb_60",
		8.6,
		0
	},
	{
		27001,
		7,
		{
			1,
			3
		},
		"rmb_60",
		8.6,
		0
	},
	{
		27001,
		8,
		{
			1,
			4
		},
		"rmb_45",
		7.5,
		0
	},
	{
		27001,
		9,
		{
			2,
			3
		},
		"rmb_60",
		8.8,
		0
	},
	{
		27001,
		10,
		{
			2,
			4
		},
		"rmb_45",
		7.7,
		0
	},
	{
		27001,
		11,
		{
			3,
			4
		},
		"rmb_45",
		7.7,
		0
	},
	{
		27003,
		1,
		{},
		"rmb_45",
		7.7,
		0
	},
	{
		27004,
		1,
		{},
		"rmb_40",
		7.7,
		0
	},
	{
		27005,
		1,
		{},
		"rmb_25",
		7.7,
		0
	},
	{
		27006,
		1,
		{},
		"rmb_45",
		7.7,
		0
	},
	{
		27007,
		1,
		{},
		"rmb_25",
		8.3,
		0
	},
	{
		27008,
		1,
		{},
		"rmb_45",
		7.5,
		0
	},
	{
		27009,
		1,
		{},
		"rmb_45",
		7.5,
		0
	},
	{
		27010,
		1,
		{},
		"rmb_18",
		9.5,
		0
	},
	{
		27010,
		2,
		{
			1
		},
		"rmb_18",
		9.5,
		0
	},
	{
		27010,
		3,
		{
			2
		},
		"rmb_18",
		9.5,
		0
	},
	{
		27010,
		4,
		{
			3
		},
		"rmb_18",
		9.5,
		0
	}
}
local t_pay_truss_coalition = {
	[27001] = {
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
		dataList[11]
	},
	[27003] = {
		dataList[12]
	},
	[27004] = {
		dataList[13]
	},
	[27005] = {
		dataList[14]
	},
	[27006] = {
		dataList[15]
	},
	[27007] = {
		dataList[16]
	},
	[27008] = {
		dataList[17]
	},
	[27009] = {
		dataList[18]
	},
	[27010] = {
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	}
}

t_pay_truss_coalition.dataList = dataList

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

return t_pay_truss_coalition
