-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_emaki_fragment.lua

module("logicconfig.config.t_season_mode_pve_emaki_fragment", package.seeall)

local title = {
	item = 4,
	seasonId = 1,
	emaki = 3,
	fragmentId = 2,
	fakeItem = 5
}
local dataList = {
	{
		1,
		1,
		1,
		"",
		"1004:1218:1"
	},
	{
		1,
		2,
		1,
		"",
		"1004:1219:1"
	},
	{
		1,
		3,
		1,
		"",
		"1004:1220:1"
	},
	{
		1,
		4,
		1,
		"",
		"1004:1221:1"
	},
	{
		1,
		5,
		1,
		"",
		"1004:1222:1"
	},
	{
		1,
		6,
		1,
		"",
		"1004:1223:1"
	},
	{
		1,
		7,
		1,
		"",
		"1004:1224:1"
	},
	{
		1,
		8,
		1,
		"",
		"1004:1225:1"
	},
	{
		1,
		9,
		1,
		"",
		"1004:1226:1"
	},
	{
		2,
		1,
		2,
		"",
		"1004:1263:1"
	},
	{
		2,
		2,
		2,
		"",
		"1004:1262:1"
	},
	{
		2,
		3,
		2,
		"",
		"1004:1259:1"
	},
	{
		2,
		4,
		2,
		"",
		"1004:1260:1"
	},
	{
		2,
		5,
		2,
		"",
		"1004:1261:1"
	},
	{
		2,
		6,
		2,
		"",
		"1004:1265:1"
	},
	{
		2,
		7,
		2,
		"",
		"1004:1267:1"
	},
	{
		2,
		8,
		2,
		"",
		"1004:1264:1"
	},
	{
		2,
		9,
		2,
		"",
		"1004:1266:1"
	},
	{
		3,
		1,
		1,
		"",
		"1004:1326:1"
	},
	{
		3,
		2,
		1,
		"",
		"1004:1327:1"
	},
	{
		3,
		3,
		1,
		"",
		"1004:1328:1"
	},
	{
		3,
		4,
		1,
		"",
		"1004:1329:1"
	},
	{
		3,
		5,
		1,
		"",
		"1004:1330:1"
	},
	{
		3,
		6,
		1,
		"",
		"1004:1331:1"
	},
	{
		3,
		7,
		1,
		"",
		"1004:1332:1"
	},
	{
		3,
		8,
		1,
		"",
		"1004:1333:1"
	},
	{
		3,
		9,
		1,
		"",
		"1004:1334:1"
	}
}
local t_season_mode_pve_emaki_fragment = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27]
	}
}

t_season_mode_pve_emaki_fragment.dataList = dataList

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

return t_season_mode_pve_emaki_fragment
