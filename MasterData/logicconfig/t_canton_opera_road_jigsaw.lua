-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_jigsaw.lua

module("logicconfig.config.t_canton_opera_road_jigsaw", package.seeall)

local title = {
	simpleIcon = 7,
	txtTitle = 3,
	openTime = 4,
	txtDesc = 10,
	prize = 11,
	unlockCondition = 6,
	planId = 1,
	completeIcon = 8,
	jigsawId = 2,
	endTime = 5,
	preShowPrize = 12,
	chipBoard = 9
}
local dataList = {
	{
		1,
		1,
		"书化蝶·天蛮王",
		"2022-09-02T05:00:00",
		"2022-09-17T05:00:00",
		0,
		"picturepuzzle/board_yuejuzhilu_26",
		"picturepuzzle/board_yuejuzhilu_30",
		"picturepuzzle/board_yuejuzhilu_25",
		"《化蝶》梁山伯，梁山伯在书院与女扮男装的祝英台义结金兰，从此同窗共读，形影不离。",
		"10:17017:250#10:189002:25#8:1:75000",
		"10:17017:250#8:1:75000"
	},
	{
		1,
		2,
		"白蛇心·王者圣女",
		"2022-09-02T05:00:00",
		"2022-09-17T05:00:00",
		1,
		"picturepuzzle/board_yuejuzhilu_27",
		"picturepuzzle/board_yuejuzhilu_31",
		"picturepuzzle/board_yuejuzhilu_22",
		"《白蛇传》白素贞，一条修行千年的白蛇精，法力高强，有情有义，天性善良。",
		"10:17017:250#10:189002:25#8:1:75000",
		"10:17017:250#8:1:75000"
	},
	{
		1,
		3,
		"虞美人·潘多拉",
		"2022-09-02T05:00:00",
		"2022-09-17T05:00:00",
		2,
		"picturepuzzle/board_yuejuzhilu_28",
		"picturepuzzle/board_yuejuzhilu_32",
		"picturepuzzle/board_yuejuzhilu_24",
		"《霸王别姬》虞姬，后世称为虞美人，楚汉之争时期西楚霸王项羽的美人。",
		"10:17017:250#10:189002:25#8:1:75000",
		"10:17017:250#8:1:75000"
	},
	{
		1,
		4,
		"大武生·阿瑞斯",
		"2022-09-02T05:00:00",
		"2022-09-17T05:00:00",
		3,
		"picturepuzzle/board_yuejuzhilu_29",
		"picturepuzzle/board_yuejuzhilu_33",
		"picturepuzzle/board_yuejuzhilu_23",
		"《霸王别姬》楚霸王项羽，霸王项羽在和汉高祖夺封建统治权的战争中，项羽突围不出。",
		"10:17017:250#10:189002:25#8:1:75000",
		"10:17017:250#8:1:75000"
	}
}
local t_canton_opera_road_jigsaw = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_canton_opera_road_jigsaw.dataList = dataList

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

return t_canton_opera_road_jigsaw
