-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_preheat_danmu.lua

module("logicconfig.config.t_anniversary_preheat_danmu", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		1,
		"祝奥奇越来越好！"
	},
	{
		2,
		"奥奇yyds！奥奇再做十年！"
	},
	{
		3,
		"奥奇传说手游一周年快乐！"
	},
	{
		4,
		"感谢奥奇这一年带给我的快乐！"
	},
	{
		5,
		"一周年不够，再来个二周年！"
	},
	{
		6,
		"撒花！奥奇传说手游一周岁啦！"
	},
	{
		7,
		"期待周年庆的活动！搓手手~"
	},
	{
		8,
		"希望新的一年奥奇带给我们更多精彩！"
	},
	{
		9,
		"携手相伴，一起再出发！"
	},
	{
		10,
		"一周年快乐！奥奇大陆的冒险继续！"
	},
	{
		11,
		"拉开奥奇两周年的帷幕，期待！"
	},
	{
		12,
		"小奥奇都长大了，希望初心不变！"
	},
	{
		13,
		"周年庆福利加码，4月1日不见不散！"
	},
	{
		14,
		"新职业开启，期待全新玩法！"
	},
	{
		15,
		"为青春岁月喝彩，为奥奇手游一周岁举杯！"
	},
	{
		16,
		"有奥奇的陪伴，新一年愉快航行！"
	},
	{
		17,
		"很开心结识到奥奇传说的所有小伙伴们！"
	},
	{
		18,
		"十年如一日，不忘初心方得始终！"
	},
	{
		19,
		"奥奇在变好，我们也在成长！"
	},
	{
		20,
		"向着新的冒险，出发！"
	},
	{
		21,
		"挑战一波过！抽奖一发中！"
	}
}
local t_anniversary_preheat_danmu = {
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
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_anniversary_preheat_danmu.dataList = dataList

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

return t_anniversary_preheat_danmu
