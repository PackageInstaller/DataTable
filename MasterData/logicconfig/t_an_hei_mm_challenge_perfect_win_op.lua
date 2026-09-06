-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_an_hei_mm_challenge_perfect_win_op.lua

module("logicconfig.config.t_an_hei_mm_challenge_perfect_win_op", package.seeall)

local title = {
	perfectWinId = 1,
	label = 4,
	params = 3,
	type = 2
}
local dataList = {
	{
		1,
		"ActiveCount",
		"2",
		""
	},
	{
		2,
		"ActiveCount",
		"3",
		""
	},
	{
		3,
		"MyPosIdMustActive",
		"0,2",
		""
	},
	{
		4,
		"MyPosIdMustActive",
		"1,4",
		""
	},
	{
		5,
		"MyPosIdMustActive",
		"2,4,6",
		""
	},
	{
		6,
		"MyActivePetContainsAttrs",
		"2,火,草",
		"火,草"
	},
	{
		7,
		"MyActivePetContainsAttrs",
		"2,光,草",
		"光,草"
	},
	{
		8,
		"MyActivePetContainsAttrs",
		"2,火,水",
		"火,水"
	},
	{
		9,
		"CircleCount",
		"2",
		""
	},
	{
		10,
		"CircleCount",
		"3",
		""
	},
	{
		11,
		"MyCriticalNum",
		"10",
		""
	},
	{
		12,
		"MyDodgeNum",
		"10",
		""
	},
	{
		13,
		"CircleCount",
		"4",
		""
	},
	{
		14,
		"MyActivePetContainsAttrs",
		"2,光,草",
		"光,草"
	},
	{
		15,
		"MyDodgeNum",
		"4",
		""
	},
	{
		16,
		"MyActivePetContainsAttrs",
		"4,水,火,草",
		"水,火,草"
	},
	{
		17,
		"CircleCount",
		"3",
		""
	},
	{
		18,
		"MyActivePetContainsAttrs",
		"2,火",
		"火"
	},
	{
		19,
		"MyPosIdMustActive",
		"3,5",
		""
	},
	{
		20,
		"ActiveCount",
		"4",
		""
	},
	{
		21,
		"MyCriticalNum",
		"6",
		""
	},
	{
		22,
		"CircleCount",
		"10",
		""
	}
}
local t_an_hei_mm_challenge_perfect_win_op = {
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

t_an_hei_mm_challenge_perfect_win_op.dataList = dataList

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

return t_an_hei_mm_challenge_perfect_win_op
