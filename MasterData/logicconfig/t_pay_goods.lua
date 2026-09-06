-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_goods.lua

module("logicconfig.config.t_pay_goods", package.seeall)

local title = {
	goodsId = 1,
	name = 2,
	appleGoodsId = 3,
	payMoney = 4
}
local dataList = {
	{
		"rmbdiamond_6",
		"充值6元钻石",
		"com.baitian.aqcs.aqcssy_10001",
		600
	},
	{
		"rmbdiamond_30",
		"充值30元钻石",
		"com.baitian.aqcs.aqcssy_10002",
		3000
	},
	{
		"rmbdiamond_68",
		"充值68元钻石",
		"com.baitian.aqcs.aqcssy_10003",
		6800
	},
	{
		"rmbdiamond_98",
		"充值98元钻石",
		"com.baitian.aqcs.aqcssy_10028",
		9800
	},
	{
		"rmbdiamond_198",
		"充值198元钻石",
		"com.baitian.aqcs.aqcssy_10004",
		19800
	},
	{
		"rmbdiamond_328",
		"充值328元钻石",
		"com.baitian.aqcs.aqcssy_10005",
		32800
	},
	{
		"rmbdiamond_648",
		"充值648元钻石",
		"com.baitian.aqcs.aqcssy_10006",
		64800
	},
	{
		"card_30",
		"充值30天月卡",
		"com.baitian.aqcs.aqcssy_10007",
		3000
	},
	{
		"card_88",
		"充值终身卡",
		"com.baitian.aqcs.aqcssy_10008",
		8800
	},
	{
		"rmb_1",
		"充值1元",
		"com.baitian.aqcs.aqcssy_10009",
		100
	},
	{
		"rmb_3",
		"充值3元",
		"com.baitian.aqcs.aqcssy_10010",
		300
	},
	{
		"rmb_6",
		"充值6元",
		"com.baitian.aqcs.aqcssy_10011",
		600
	},
	{
		"rmb_12",
		"充值12元",
		"com.baitian.aqcs.aqcssy_10012",
		1200
	},
	{
		"rmb_18",
		"充值18元",
		"com.baitian.aqcs.aqcssy_10013",
		1800
	},
	{
		"rmb_25",
		"充值25元",
		"com.baitian.aqcs.aqcssy_10014",
		2500
	},
	{
		"rmb_28",
		"充值28元",
		"com.baitian.aqcs.aqcssy_10015",
		2800
	},
	{
		"rmb_30",
		"充值30元",
		"com.baitian.aqcs.aqcssy_10016",
		3000
	},
	{
		"rmb_40",
		"充值40元",
		"com.baitian.aqcs.aqcssy_10029",
		4000
	},
	{
		"rmb_45",
		"充值45元",
		"com.baitian.aqcs.aqcssy_10017",
		4500
	},
	{
		"rmb_60",
		"充值60元",
		"com.baitian.aqcs.aqcssy_10018",
		6000
	},
	{
		"rmb_68",
		"充值68元",
		"com.baitian.aqcs.aqcssy_10019",
		6800
	},
	{
		"rmb_78",
		"充值78元",
		"com.baitian.aqcs.aqcssy_10030",
		7800
	},
	{
		"rmb_88",
		"充值88元",
		"com.baitian.aqcs.aqcssy_10020",
		8800
	},
	{
		"rmb_98",
		"充值98元",
		"com.baitian.aqcs.aqcssy_10021",
		9800
	},
	{
		"rmb_128",
		"充值128元",
		"com.baitian.aqcs.aqcssy_10022",
		12800
	},
	{
		"rmb_148",
		"充值148元",
		"com.baitian.aqcs.aqcssy_10023",
		14800
	},
	{
		"rmb_168",
		"充值168元",
		"com.baitian.aqcs.aqcssy_10024",
		16800
	},
	{
		"rmb_198",
		"充值198元",
		"com.baitian.aqcs.aqcssy_10025",
		19800
	},
	{
		"rmb_328",
		"充值328元",
		"com.baitian.aqcs.aqcssy_10026",
		32800
	},
	{
		"rmb_648",
		"充值648元",
		"com.baitian.aqcs.aqcssy_10027",
		64800
	}
}
local t_pay_goods = {
	rmbdiamond_6 = dataList[1],
	rmbdiamond_30 = dataList[2],
	rmbdiamond_68 = dataList[3],
	rmbdiamond_98 = dataList[4],
	rmbdiamond_198 = dataList[5],
	rmbdiamond_328 = dataList[6],
	rmbdiamond_648 = dataList[7],
	card_30 = dataList[8],
	card_88 = dataList[9],
	rmb_1 = dataList[10],
	rmb_3 = dataList[11],
	rmb_6 = dataList[12],
	rmb_12 = dataList[13],
	rmb_18 = dataList[14],
	rmb_25 = dataList[15],
	rmb_28 = dataList[16],
	rmb_30 = dataList[17],
	rmb_40 = dataList[18],
	rmb_45 = dataList[19],
	rmb_60 = dataList[20],
	rmb_68 = dataList[21],
	rmb_78 = dataList[22],
	rmb_88 = dataList[23],
	rmb_98 = dataList[24],
	rmb_128 = dataList[25],
	rmb_148 = dataList[26],
	rmb_168 = dataList[27],
	rmb_198 = dataList[28],
	rmb_328 = dataList[29],
	rmb_648 = dataList[30]
}

t_pay_goods.dataList = dataList

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

return t_pay_goods
