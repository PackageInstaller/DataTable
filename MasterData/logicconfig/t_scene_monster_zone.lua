-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_monster_zone.lua

module("logicconfig.config.t_scene_monster_zone", package.seeall)

local title = {
	sceneId = 2,
	creepMasterIds = 4,
	sceneZoneId = 1,
	sceneZoneMonsterNum = 3
}
local dataList = {
	{
		11801,
		118,
		3,
		{
			6,
			24
		}
	},
	{
		11802,
		118,
		3,
		{
			6,
			24
		}
	},
	{
		11101,
		111,
		3,
		{
			6,
			24
		}
	},
	{
		11701,
		117,
		3,
		{
			2
		}
	},
	{
		11702,
		117,
		3,
		{
			2
		}
	},
	{
		11703,
		117,
		3,
		{
			2
		}
	},
	{
		11301,
		113,
		3,
		{
			2
		}
	},
	{
		11302,
		113,
		3,
		{
			2
		}
	},
	{
		10901,
		109,
		3,
		{
			5,
			21
		}
	},
	{
		10902,
		109,
		3,
		{
			5,
			21
		}
	},
	{
		11001,
		110,
		3,
		{
			23
		}
	},
	{
		11002,
		110,
		3,
		{
			23
		}
	},
	{
		11003,
		110,
		3,
		{
			23
		}
	},
	{
		11401,
		114,
		3,
		{
			3,
			23
		}
	},
	{
		12001,
		120,
		2,
		{
			25
		}
	},
	{
		12002,
		120,
		3,
		{
			25
		}
	},
	{
		12003,
		120,
		3,
		{
			25
		}
	},
	{
		10601,
		106,
		3,
		{
			26
		}
	},
	{
		10602,
		106,
		3,
		{
			26
		}
	},
	{
		10603,
		106,
		3,
		{
			26
		}
	},
	{
		10604,
		106,
		3,
		{
			26
		}
	}
}
local t_scene_monster_zone = {
	[11801] = dataList[1],
	[11802] = dataList[2],
	[11101] = dataList[3],
	[11701] = dataList[4],
	[11702] = dataList[5],
	[11703] = dataList[6],
	[11301] = dataList[7],
	[11302] = dataList[8],
	[10901] = dataList[9],
	[10902] = dataList[10],
	[11001] = dataList[11],
	[11002] = dataList[12],
	[11003] = dataList[13],
	[11401] = dataList[14],
	[12001] = dataList[15],
	[12002] = dataList[16],
	[12003] = dataList[17],
	[10601] = dataList[18],
	[10602] = dataList[19],
	[10603] = dataList[20],
	[10604] = dataList[21]
}

t_scene_monster_zone.dataList = dataList

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

return t_scene_monster_zone
