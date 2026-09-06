-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collecting_race.lua

module("logicconfig.config.t_collecting_race", package.seeall)

local title = {
	bgPath = 7,
	viewName = 3,
	sortId = 2,
	skinId = 4,
	clientRedId = 11,
	prize = 6,
	desc = 5,
	redPointId = 10,
	buffDesc = 9,
	behaviour = 8,
	activityId = 1
}
local dataList = {
	{
		184336,
		1,
		"collectingraceview",
		16046,
		"万恶灵冕·尘",
		"4:36:10#8:1:100000",
		"board_jjl_346",
		0,
		"PVE场景中，上阵万恶灵冕·尘\r\n享有暴击率+35%、生命+20%的增益效果\r\n限时buff生效时间：7月24日5:00-7月31日5:00",
		321,
		0
	},
	{
		184337,
		2,
		"collectingraceview",
		15051,
		"暮色莲影·末炎",
		"4:36:10#8:1:100000",
		"board_jjl_347",
		0,
		"PVE场景中，上阵暮色莲影·末炎\r\n享有暴击率+35%、生命+20%的增益效果\r\n限时buff生效时间：7月24日5:00-7月31日5:00",
		629,
		0
	},
	{
		184338,
		3,
		"collectingraceview",
		16047,
		"零界矩阵·无限未来",
		"4:36:10#8:1:100000",
		"board_jjl_349",
		0,
		"PVE场景中，上阵零界矩阵·无限未来\r\n享有暴击率+35%、生命+20%的增益效果\r\n限时buff生效时间：7月31日5:00-8月7日5:00",
		630,
		0
	},
	{
		184339,
		4,
		"collectingraceview",
		12047,
		"忆海寻梭·弥梦离",
		"4:36:10#8:1:100000",
		"board_jjl_348",
		0,
		"PVE场景中，上阵忆海寻梭·弥梦离\r\n享有暴击率+35%、生命+20%的增益效果\r\n限时buff生效时间：7月31日5:00-8月7日5:00",
		631,
		0
	},
	{
		184340,
		5,
		"collectingraceview",
		16048,
		"万法裁夺·双生龙尊",
		"4:36:10#8:1:100000",
		"board_jjl_350",
		0,
		"PVE场景中，上阵万法裁夺·双生龙尊\r\n享有暴击率+35%、生命+20%的增益效果\r\n限时buff生效时间：8月7日5:00-8月14日5:00",
		632,
		0
	},
	{
		184341,
		6,
		"collectingracetwoview",
		1604603,
		"瑶华天卿·尘",
		"4:510850:1",
		"board_jjl_351",
		0,
		"限时获得时间：7月24日5:00-8月21日5:00",
		0,
		0
	},
	{
		184342,
		7,
		"collectingracetwoview",
		1204703,
		"掌夜司寐·弥梦离",
		"4:510853:1",
		"board_jjl_353",
		0,
		"限时获得时间：7月31日5:00-8月21日5:00",
		634,
		0
	},
	{
		184343,
		8,
		"collectingracetwoview",
		1803102,
		"倾怀化芳·创世神女",
		"4:510855:1",
		"board_jjl_352",
		0,
		"限时获得时间：7月31日5:00-8月21日5:00",
		635,
		0
	},
	{
		184344,
		9,
		"collectingracetwoview",
		1604806,
		"并蒂莲心·双生神女",
		"4:400004:50#4:510854:1",
		"board_jjl_354",
		0,
		"限时获得时间：8月7日5:00-8月21日5:00",
		636,
		0
	}
}
local t_collecting_race = {
	[184336] = dataList[1],
	[184337] = dataList[2],
	[184338] = dataList[3],
	[184339] = dataList[4],
	[184340] = dataList[5],
	[184341] = dataList[6],
	[184342] = dataList[7],
	[184343] = dataList[8],
	[184344] = dataList[9]
}

t_collecting_race.dataList = dataList

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

return t_collecting_race
