-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_collect_fmt.lua

module("logicconfig.config.t_formation_collect_fmt", package.seeall)

local title = {
	summonMasterId = 4,
	petList = 2,
	fmtId = 1,
	posList = 3,
	fmtName = 6,
	collectPrize = 7,
	summonPetRaceId = 5,
	fmtDesc = 8
}
local dataList = {
	{
		1,
		{
			13025,
			13026,
			13027,
			13028,
			13029,
			13009
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		13027,
		13029,
		"源起盖西瑞",
		"4:400004:10",
		"源起盖西瑞阵，拥有强大的续航能力，利用不同精灵源起技的搭配可以应对不同的敌阵"
	},
	{
		2,
		{
			16041,
			16042,
			16043,
			16044,
			16045,
			16033
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		16043,
		16042,
		"源起极",
		"4:400004:10",
		"源起极阵，拥有对光暗队伍的特攻，利用不同精灵源起技的搭配可以应对不同的敌阵"
	},
	{
		3,
		{
			17025,
			17026,
			17027,
			17028,
			17029,
			11037
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		17029,
		11037,
		"源起究",
		"4:400004:10",
		"源起究阵，可以利用究的源起技，快速打出克制伤害快速通灵，薄伽丘需要绑定书灵阿特拉斯"
	},
	{
		4,
		{
			15050,
			11041,
			11042,
			13031,
			12046,
			14044
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		13031,
		11041,
		"源起梦之队",
		"4:400004:10",
		"新人必备PVE阵容，可以通过至尊召唤获得王者梦梦，梦之力为梦之队提供不错的持续作战能力。"
	},
	{
		5,
		{
			16046,
			12047,
			15051,
			16047,
			16048,
			12041
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		15051,
		16047,
		"源起尘",
		"4:400004:10",
		"源起尘阵，可以上阵女性精灵让尘获得通灵进度和无限未来获得唤灵进度，双生圣龙和无烬龙可以通过皮肤来变更为女性精灵"
	}
}
local t_formation_collect_fmt = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_formation_collect_fmt.dataList = dataList

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

return t_formation_collect_fmt
