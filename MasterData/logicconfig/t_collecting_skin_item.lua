-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collecting_skin_item.lua

module("logicconfig.config.t_collecting_skin_item", package.seeall)

local title = {
	materialKey = 4,
	name = 5,
	type = 3,
	id = 2,
	activityId = 1
}
local dataList = {
	{
		362005,
		1,
		"MOUNT",
		"39",
		"光之帝皇战龙(双)坐骑"
	},
	{
		362005,
		2,
		"MOUNT",
		"40",
		"炎龙驹坐骑"
	},
	{
		362005,
		3,
		"",
		"1:11194:-1",
		"时装-帝皇侠套装"
	},
	{
		362005,
		4,
		"",
		"1:11196:-1",
		"时装-炎龙侠套装"
	},
	{
		362005,
		5,
		"",
		"1:400042:-1",
		"时装-帝皇侠·帝皇战戟"
	},
	{
		362005,
		6,
		"",
		"1:400044:-1",
		"时装-炎龙侠·烈焰弓"
	},
	{
		362005,
		7,
		"",
		"1:400046:-1",
		"时装-帝皇侠·极光剑"
	},
	{
		362005,
		8,
		"",
		"14:477",
		"帝皇侠头像框"
	},
	{
		362005,
		9,
		"",
		"14:478",
		"炎龙侠头像框"
	},
	{
		362005,
		10,
		"",
		"14:480",
		"帝皇侠皮肤头像框"
	},
	{
		362005,
		11,
		"",
		"13:510",
		"帝皇侠精灵头像"
	},
	{
		362005,
		12,
		"",
		"13:511",
		"炎龙侠精灵头像"
	},
	{
		362005,
		13,
		"",
		"13:513",
		"炎龙侠皮肤头像"
	},
	{
		362005,
		14,
		"",
		"13:514",
		"帝皇侠皮肤头像"
	},
	{
		362005,
		15,
		"",
		"22:16",
		"表情包"
	},
	{
		362005,
		16,
		"",
		"34:9",
		"战斗场景"
	},
	{
		362005,
		17,
		"",
		"33:9",
		"战斗主题"
	},
	{
		362005,
		18,
		"",
		"28:22",
		"开场特效"
	},
	{
		362005,
		19,
		"",
		"30:20",
		"名字框"
	},
	{
		362005,
		20,
		"",
		"19:36",
		"气泡框"
	},
	{
		362005,
		21,
		"",
		"29:38",
		"名片"
	},
	{
		362005,
		22,
		"",
		"32:18",
		"个人信息页"
	}
}
local t_collecting_skin_item = {
	[362005] = {
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
		dataList[21],
		dataList[22]
	}
}

t_collecting_skin_item.dataList = dataList

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

return t_collecting_skin_item
