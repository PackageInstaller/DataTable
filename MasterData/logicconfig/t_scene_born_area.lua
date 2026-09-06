-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_born_area.lua

module("logicconfig.config.t_scene_born_area", package.seeall)

local title = {
	sceneId = 1,
	position = 3,
	fromScene = 2
}
local dataList = {
	{
		1001,
		0,
		{
			14.5,
			9.5
		}
	},
	{
		1001,
		103,
		{
			62,
			22.5
		}
	},
	{
		1001,
		119,
		{
			10.43,
			7.68
		}
	},
	{
		1001,
		120,
		{
			53.6,
			9
		}
	},
	{
		1001,
		118,
		{
			34.7,
			37.5
		}
	},
	{
		1001,
		105,
		{
			14.7,
			29.7
		}
	},
	{
		1001,
		104,
		{
			49.3,
			30.3
		}
	},
	{
		1001,
		127,
		{
			48,
			9
		}
	},
	{
		103,
		0,
		{
			16,
			4
		}
	},
	{
		103,
		1001,
		{
			26,
			4
		}
	},
	{
		104,
		0,
		{
			6,
			3.5
		}
	},
	{
		104,
		1001,
		{
			6,
			3.5
		}
	},
	{
		105,
		0,
		{
			14.3,
			8
		}
	},
	{
		105,
		1001,
		{
			16,
			3
		}
	},
	{
		106,
		0,
		{
			43,
			12
		}
	},
	{
		106,
		124,
		{
			43,
			12
		}
	},
	{
		107,
		0,
		{
			11.5,
			9.5
		}
	},
	{
		107,
		119,
		{
			11.5,
			9.5
		}
	},
	{
		108,
		0,
		{
			3,
			3
		}
	},
	{
		108,
		120,
		{
			3,
			3
		}
	},
	{
		108,
		128,
		{
			19,
			29
		}
	},
	{
		111,
		0,
		{
			15,
			8
		}
	},
	{
		111,
		118,
		{
			5,
			3.5
		}
	},
	{
		114,
		0,
		{
			25,
			19
		}
	},
	{
		114,
		117,
		{
			50,
			6.5
		}
	},
	{
		117,
		0,
		{
			33,
			29
		}
	},
	{
		117,
		121,
		{
			10,
			39
		}
	},
	{
		117,
		114,
		{
			52,
			28.7
		}
	},
	{
		117,
		119,
		{
			54,
			40
		}
	},
	{
		117,
		122,
		{
			3,
			5
		}
	},
	{
		118,
		0,
		{
			36,
			20
		}
	},
	{
		118,
		1001,
		{
			63,
			10
		}
	},
	{
		118,
		111,
		{
			3,
			4
		}
	},
	{
		118,
		123,
		{
			22,
			37
		}
	},
	{
		119,
		0,
		{
			32.5,
			26
		}
	},
	{
		119,
		1001,
		{
			19,
			39.5
		}
	},
	{
		119,
		117,
		{
			7,
			3.5
		}
	},
	{
		119,
		107,
		{
			42,
			9
		}
	},
	{
		120,
		0,
		{
			43.4,
			19.5
		}
	},
	{
		120,
		1001,
		{
			12,
			10
		}
	},
	{
		120,
		108,
		{
			33,
			28.5
		}
	},
	{
		121,
		0,
		{
			10.5,
			3
		}
	},
	{
		121,
		117,
		{
			10.5,
			3
		}
	},
	{
		122,
		0,
		{
			14,
			10
		}
	},
	{
		122,
		117,
		{
			3,
			3.5
		}
	},
	{
		122,
		124,
		{
			9,
			16.5
		}
	},
	{
		122,
		126,
		{
			22.5,
			13.5
		}
	},
	{
		123,
		0,
		{
			6,
			10
		}
	},
	{
		123,
		118,
		{
			6.5,
			9
		}
	},
	{
		124,
		0,
		{
			17,
			3
		}
	},
	{
		124,
		120,
		{
			17,
			3
		}
	},
	{
		124,
		106,
		{
			5,
			9.2
		}
	},
	{
		125,
		0,
		{
			13,
			8.5
		}
	},
	{
		126,
		0,
		{
			10.5,
			5
		}
	},
	{
		126,
		122,
		{
			5.5,
			3.5
		}
	},
	{
		127,
		0,
		{
			13,
			8.5
		}
	},
	{
		127,
		1001,
		{
			10.7,
			6.7
		}
	},
	{
		128,
		0,
		{
			37.41,
			7.3
		}
	},
	{
		128,
		108,
		{
			38,
			7.6
		}
	},
	{
		128,
		129,
		{
			45.4,
			21
		}
	},
	{
		129,
		0,
		{
			22,
			5.3
		}
	},
	{
		129,
		128,
		{
			23,
			4.5
		}
	}
}
local t_scene_born_area = {
	[1001] = {
		[0] = dataList[1],
		[103] = dataList[2],
		[119] = dataList[3],
		[120] = dataList[4],
		[118] = dataList[5],
		[105] = dataList[6],
		[104] = dataList[7],
		[127] = dataList[8]
	},
	[103] = {
		[0] = dataList[9],
		[1001] = dataList[10]
	},
	[104] = {
		[0] = dataList[11],
		[1001] = dataList[12]
	},
	[105] = {
		[0] = dataList[13],
		[1001] = dataList[14]
	},
	[106] = {
		[0] = dataList[15],
		[124] = dataList[16]
	},
	[107] = {
		[0] = dataList[17],
		[119] = dataList[18]
	},
	[108] = {
		[0] = dataList[19],
		[120] = dataList[20],
		[128] = dataList[21]
	},
	[111] = {
		[0] = dataList[22],
		[118] = dataList[23]
	},
	[114] = {
		[0] = dataList[24],
		[117] = dataList[25]
	},
	[117] = {
		[0] = dataList[26],
		[121] = dataList[27],
		[114] = dataList[28],
		[119] = dataList[29],
		[122] = dataList[30]
	},
	[118] = {
		[0] = dataList[31],
		[1001] = dataList[32],
		[111] = dataList[33],
		[123] = dataList[34]
	},
	[119] = {
		[0] = dataList[35],
		[1001] = dataList[36],
		[117] = dataList[37],
		[107] = dataList[38]
	},
	[120] = {
		[0] = dataList[39],
		[1001] = dataList[40],
		[108] = dataList[41]
	},
	[121] = {
		[0] = dataList[42],
		[117] = dataList[43]
	},
	[122] = {
		[0] = dataList[44],
		[117] = dataList[45],
		[124] = dataList[46],
		[126] = dataList[47]
	},
	[123] = {
		[0] = dataList[48],
		[118] = dataList[49]
	},
	[124] = {
		[0] = dataList[50],
		[120] = dataList[51],
		[106] = dataList[52]
	},
	[125] = {
		[0] = dataList[53]
	},
	[126] = {
		[0] = dataList[54],
		[122] = dataList[55]
	},
	[127] = {
		[0] = dataList[56],
		[1001] = dataList[57]
	},
	[128] = {
		[0] = dataList[58],
		[108] = dataList[59],
		[129] = dataList[60]
	},
	[129] = {
		[0] = dataList[61],
		[128] = dataList[62]
	}
}

t_scene_born_area.dataList = dataList

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

return t_scene_born_area
