-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_ranking_score_buff_progress.lua

module("logicconfig.config.t_timed_challenge_ranking_score_buff_progress", package.seeall)

local title = {
	challengeId = 1,
	buffType = 2,
	buffLv = 3,
	buffId = 4,
	enterViewType = 7,
	challengeDesc = 9,
	scoreEffect = 6,
	buffName = 8,
	creepsMasterId = 5
}
local dataList = {
	{
		27,
		1,
		1,
		201,
		201,
		-100,
		1,
		82037245,
		82037246
	},
	{
		27,
		1,
		2,
		202,
		202,
		-300,
		1,
		82037245,
		82037246
	},
	{
		27,
		1,
		3,
		203,
		203,
		-500,
		1,
		82037245,
		82037246
	},
	{
		27,
		2,
		1,
		301,
		301,
		-100,
		1,
		82037247,
		82037248
	},
	{
		27,
		2,
		2,
		302,
		302,
		-300,
		1,
		82037247,
		82037248
	},
	{
		27,
		2,
		3,
		303,
		303,
		-500,
		1,
		82037247,
		82037248
	},
	{
		27,
		3,
		1,
		401,
		401,
		-100,
		1,
		82037249,
		82037250
	},
	{
		27,
		3,
		2,
		402,
		402,
		-300,
		1,
		82037249,
		82037250
	},
	{
		27,
		3,
		3,
		403,
		403,
		-500,
		1,
		82037249,
		82037250
	},
	{
		27,
		4,
		1,
		501,
		501,
		-100,
		1,
		82037251,
		82037252
	},
	{
		27,
		4,
		2,
		502,
		502,
		-300,
		1,
		82037251,
		82037252
	},
	{
		27,
		4,
		3,
		503,
		503,
		-500,
		1,
		82037251,
		82037252
	},
	{
		27,
		5,
		1,
		101,
		101,
		-500,
		1,
		82037253,
		82037254
	},
	{
		27,
		6,
		1,
		701,
		701,
		-100,
		2,
		82037255,
		82037256
	},
	{
		27,
		6,
		2,
		702,
		702,
		-300,
		2,
		82037255,
		82037256
	},
	{
		27,
		6,
		3,
		703,
		703,
		-500,
		2,
		82037255,
		82037256
	},
	{
		27,
		7,
		1,
		801,
		801,
		-100,
		2,
		82037257,
		82037258
	},
	{
		27,
		7,
		2,
		802,
		802,
		-300,
		2,
		82037257,
		82037258
	},
	{
		27,
		7,
		3,
		803,
		803,
		-500,
		2,
		82037257,
		82037258
	},
	{
		27,
		8,
		1,
		901,
		901,
		-100,
		2,
		82037259,
		82037260
	},
	{
		27,
		8,
		2,
		902,
		902,
		-300,
		2,
		82037259,
		82037260
	},
	{
		27,
		8,
		3,
		903,
		903,
		-500,
		2,
		82037259,
		82037260
	},
	{
		27,
		9,
		1,
		1001,
		1001,
		-100,
		2,
		82037261,
		82037262
	},
	{
		27,
		9,
		2,
		1002,
		1002,
		-300,
		2,
		82037261,
		82037262
	},
	{
		27,
		9,
		3,
		1003,
		1003,
		-500,
		2,
		82037261,
		82037262
	},
	{
		27,
		10,
		1,
		601,
		601,
		-500,
		2,
		82037263,
		82037264
	}
}
local t_timed_challenge_ranking_score_buff_progress = {
	[27] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13]
		},
		{
			dataList[14],
			dataList[15],
			dataList[16]
		},
		{
			dataList[17],
			dataList[18],
			dataList[19]
		},
		{
			dataList[20],
			dataList[21],
			dataList[22]
		},
		{
			dataList[23],
			dataList[24],
			dataList[25]
		},
		{
			dataList[26]
		}
	}
}

t_timed_challenge_ranking_score_buff_progress.dataList = dataList

local multiLanguageCells = {
	challengeDesc = true,
	buffName = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_timed_challenge_ranking_score_buff_progress
