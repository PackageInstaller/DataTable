-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_monopoly_event.lua

module("logicconfig.config.t_monopoly_event", package.seeall)

local title = {
	reward = 4,
	imgPath = 5,
	eventGroup = 2,
	id = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"偶遇帝释天，被带飞了一段，前进%s步",
		"",
		"ui/icon/hdhz/icon_06"
	},
	{
		2,
		1,
		"偶遇龙炎，送了你一份【仰望星空】，吃饱后精神抖擞，前进%s步",
		"",
		"ui/icon/hdhz/icon_06"
	},
	{
		3,
		1,
		"被红红和火火的火箭炸得灰头土脸，后退%s步",
		"",
		"ui/icon/hdhz/icon_06"
	},
	{
		4,
		1,
		"在宝箱里找到【遥控骰子】，获得遥控骰子",
		"10:1101:1",
		"ui/icon/hdhz/icon_06"
	},
	{
		5,
		1,
		"在路上被石头绊倒，门牙磕到了一个宝箱，打开发现有许多金币",
		"8:1:10000",
		"ui/icon/hdhz/icon_06"
	},
	{
		6,
		1,
		"误入一个迷宫，在迷宫里发现召唤券碎片，获得召唤券碎片*1",
		"4:30:1",
		"ui/icon/hdhz/icon_06"
	},
	{
		7,
		1,
		"误入一个迷宫，在迷宫里发现召唤券，获得召唤券*1",
		"4:31:1",
		"ui/icon/hdhz/icon_06"
	},
	{
		8,
		2,
		"偶遇诺亚，使用时间之力送你一程，前进%s步",
		"",
		"ui/icon/hdhz/icon_06"
	},
	{
		9,
		2,
		"偶遇弥娅，被惊人的美貌鼓起干劲，精神抖擞，前进%s步",
		"",
		"ui/icon/hdhz/icon_06"
	},
	{
		10,
		2,
		"被千时追上，挨了一巴掌，后退%s步",
		"",
		"ui/icon/hdhz/icon_06"
	},
	{
		11,
		2,
		"在宝箱里找到【遥控骰子】，获得遥控骰子",
		"10:1102:1",
		"ui/icon/hdhz/icon_06"
	},
	{
		12,
		2,
		"被千重时的裂隙吸入一个神秘地带，发现金币宝箱",
		"8:1:10000",
		"ui/icon/hdhz/icon_06"
	},
	{
		13,
		2,
		"误入收藏馆的小房间，获得召唤券碎片*1",
		"4:30:1",
		"ui/icon/hdhz/icon_06"
	},
	{
		14,
		2,
		"路见不平，救助了一位老人，获赠召唤券*1",
		"4:31:1",
		"ui/icon/hdhz/icon_06"
	},
	{
		15,
		3,
		"偶遇诺亚，使用时间之力送你一程，前进%s步",
		"",
		"ui/icon/character/icon_10145_nuoya"
	},
	{
		16,
		3,
		"偶遇弥娅，被惊人的美貌鼓起干劲，精神抖擞，前进%s步",
		"",
		"ui/icon/character/icon_10147_miya"
	},
	{
		17,
		3,
		"被千时追上，挨了一巴掌，后退%s步",
		"",
		"ui/icon/character/icon_10147_miya01"
	},
	{
		18,
		3,
		"在宝箱里找到【遥控骰子】，获得遥控骰子",
		"10:1103:1",
		"ui/icon/items/item_shuaizi02"
	},
	{
		19,
		3,
		"被千重时的裂隙吸入一个神秘地带，发现金币宝箱",
		"8:1:10000",
		"ui/icon/yyfb/board_yyfb_12"
	},
	{
		20,
		3,
		"误入收藏馆的小房间，获得召唤券碎片*1",
		"4:30:1",
		"ui/icon/yyfb/board_yyfb_12"
	},
	{
		21,
		3,
		"路见不平，救助了一位老人，获赠召唤券*1",
		"4:31:1",
		"ui/icon/items/icon_quan"
	}
}
local t_monopoly_event = {
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

t_monopoly_event.dataList = dataList

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

return t_monopoly_event
