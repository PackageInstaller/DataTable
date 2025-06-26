-- chunkname: @IQIGame\\Config\\CfgEndlessPlusLevelTable.lua

local CfgEndlessPlusLevelTable = {
	[10001] = {
		Clearance = 20,
		MazeInstanceID = 25130001,
		Id = 10001,
		MazeName = getI18NValue(180478269),
		Desc = getI18NValue(180478329),
		ScoreReward = {
			{
				214,
				25
			},
			{
				214,
				55
			},
			{
				214,
				90
			},
			{
				214,
				130
			},
			{
				214,
				175
			},
			{
				214,
				225
			},
			{
				214,
				280
			},
			{
				214,
				340
			},
			{
				214,
				405
			},
			{
				214,
				475
			},
			{
				214,
				550
			},
			{
				214,
				630
			},
			{
				214,
				715
			},
			{
				214,
				805
			},
			{
				214,
				900
			},
			{
				214,
				1000
			},
			{
				214,
				1105
			},
			{
				214,
				1215
			},
			{
				214,
				1330
			},
			{
				214,
				1450
			}
		}
	},
	[10002] = {
		Clearance = 20,
		MazeInstanceID = 25130002,
		Id = 10002,
		MazeName = getI18NValue(180478270),
		Desc = getI18NValue(180478330),
		ScoreReward = {
			{
				214,
				50
			},
			{
				214,
				110
			},
			{
				214,
				180
			},
			{
				214,
				260
			},
			{
				214,
				350
			},
			{
				214,
				450
			},
			{
				214,
				560
			},
			{
				214,
				680
			},
			{
				214,
				810
			},
			{
				214,
				950
			},
			{
				214,
				1100
			},
			{
				214,
				1260
			},
			{
				214,
				1430
			},
			{
				214,
				1610
			},
			{
				214,
				1800
			},
			{
				214,
				2000
			},
			{
				214,
				2210
			},
			{
				214,
				2430
			},
			{
				214,
				2660
			},
			{
				214,
				2900
			}
		}
	},
	[10003] = {
		Clearance = 20,
		MazeInstanceID = 25130003,
		Id = 10003,
		MazeName = getI18NValue(180478271),
		Desc = getI18NValue(180478331),
		ScoreReward = {
			{
				214,
				75
			},
			{
				214,
				165
			},
			{
				214,
				270
			},
			{
				214,
				390
			},
			{
				214,
				525
			},
			{
				214,
				675
			},
			{
				214,
				840
			},
			{
				214,
				1020
			},
			{
				214,
				1215
			},
			{
				214,
				1425
			},
			{
				214,
				1650
			},
			{
				214,
				1890
			},
			{
				214,
				2145
			},
			{
				214,
				2415
			},
			{
				214,
				2700
			},
			{
				214,
				3000
			},
			{
				214,
				3315
			},
			{
				214,
				3645
			},
			{
				214,
				3990
			},
			{
				214,
				4350
			}
		}
	}
}

setmetatable(CfgEndlessPlusLevelTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEndlessPlusLevelTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Clearance = 0,
		MazeInstanceID = 0,
		MazeName = "",
		Desc = "",
		ScoreReward = {
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	}
}

for i, data in pairs(CfgEndlessPlusLevelTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEndlessPlusLevelTable
