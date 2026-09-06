-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_stick_couplet_hard.lua

module("logicconfig.config.t_stick_couplet_hard", package.seeall)

local title = {
	id = 1,
	leftCouplet = 3,
	rightCouplet = 4,
	middleCouplet = 2
}
local dataList = {
	{
		1,
		"辞#旧#迎#春",
		"五#谷#丰#登#银#蛇#载#誉#去",
		"百#花#争#艳#金#马#踏#春#来"
	},
	{
		2,
		"喜#笑#颜#开",
		"鸟#语#花#香#九#州#春#光#好",
		"人#欢#马#叫#四#季#画#图#新"
	},
	{
		3,
		"平#步#青#云",
		"举#步#昂#首#攀#登#十#八#盘",
		"跃#马#扬#鞭#飞#越#天#柱#峰"
	},
	{
		4,
		"锦#绣中#华",
		"百#花#争#艳#祖#国#春#光#好",
		"万#马#奔#腾#改#革#事#业#兴"
	},
	{
		5,
		"平#步#青#云",
		"鱼#跃#莺#飞#光#景#随#时#好",
		"人#欢#马#叫#春#潮#逐#浪#高"
	},
	{
		6,
		"欢#度#佳#节",
		"腊#尽#夏#归#山#村#添#喜#气",
		"牛#肥#马#壮#门#户#浴#春#风"
	},
	{
		7,
		"喜#迎#新#春",
		"十#亿#神#州#共#驰#千#里#马",
		"四#化#建#设#更#上#一#层#楼"
	},
	{
		8,
		"鹏#程#万#里",
		"工#农#携#手#共#跨#千#里#马",
		"干#群#并#肩#同#上#一#层#楼"
	},
	{
		9,
		"鹏#程#万#里",
		"喜#鹊#登#梅#百#族#迎#佳#节",
		"金#虎#献#瑞#万#里#笑#春#风"
	},
	{
		10,
		"福#满#人#间",
		"辞#旧#迎#新#福#气#腾#腾#起",
		"迎#春#接#福#财#源#滚#滚#来"
	},
	{
		11,
		"四#海#同#春",
		"瑞#雪#纷#飞#庆#九#州#四#海",
		"春#风#送#暖#照#万#家#千#门"
	},
	{
		12,
		"运#长#福#厚",
		"福#满#人#间#新#春#好#运#到",
		"喜#临#门#第#佳#节#吉#运#长"
	}
}
local t_stick_couplet_hard = {
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
	dataList[12]
}

t_stick_couplet_hard.dataList = dataList

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

return t_stick_couplet_hard
