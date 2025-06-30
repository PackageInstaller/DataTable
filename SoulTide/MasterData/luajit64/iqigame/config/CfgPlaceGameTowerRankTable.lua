-- chunkname: @IQIGame\\Config\\CfgPlaceGameTowerRankTable.lua

local CfgPlaceGameTowerRankTable = {
	[10001] = {
		RankUpperLimit = 1,
		Image = "/Common/ComButton/Image_Score_SS.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 1,
		Mail = 35042001,
		Id = 10001
	},
	[10002] = {
		RankUpperLimit = 2,
		Image = "/Common/ComButton/Image_Score_SS.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 2,
		Mail = 35042001,
		Id = 10002
	},
	[10003] = {
		RankUpperLimit = 3,
		Image = "/Common/ComButton/Image_Score_SS.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 3,
		Mail = 35042001,
		Id = 10003
	},
	[10004] = {
		RankUpperLimit = 10,
		Image = "/Common/ComButton/Image_Score_SS.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 4,
		Mail = 35042001,
		Id = 10004
	},
	[10005] = {
		RankUpperLimit = 50,
		Image = "/Common/ComButton/Image_Score_SS.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 11,
		Mail = 35042001,
		Id = 10005
	},
	[10006] = {
		RankUpperLimit = 100,
		Image = "/Common/ComButton/Image_Score_S.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 51,
		Mail = 35042002,
		Id = 10006
	},
	[10007] = {
		RankUpperLimit = 500,
		Image = "/Common/ComButton/Image_Score_S0.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 101,
		Mail = 35042003,
		Id = 10007
	},
	[10008] = {
		RankUpperLimit = 1000,
		Image = "/Common/ComButton/Image_Score_A.png",
		RankType = 1,
		Group = 1,
		RankLowerLimit = 501,
		Mail = 35042004,
		Id = 10008
	},
	[10009] = {
		RankUpperLimit = 10,
		Image = "/Common/ComButton/Image_Score_A0.png",
		RankType = 2,
		Group = 1,
		RankLowerLimit = 1,
		Mail = 35042005,
		Id = 10009
	},
	[10010] = {
		RankUpperLimit = 20,
		Image = "/Common/ComButton/Image_Score_B.png",
		RankType = 2,
		Group = 1,
		RankLowerLimit = 11,
		Mail = 35042006,
		Id = 10010
	},
	[10011] = {
		RankUpperLimit = 30,
		Image = "/Common/ComButton/Image_Score_B0.png",
		RankType = 2,
		Group = 1,
		RankLowerLimit = 21,
		Mail = 35042007,
		Id = 10011
	},
	[10012] = {
		RankUpperLimit = 40,
		Image = "/Common/ComButton/Image_Score_C.png",
		RankType = 2,
		Group = 1,
		RankLowerLimit = 31,
		Mail = 35042008,
		Id = 10012
	},
	[10013] = {
		RankUpperLimit = 60,
		Image = "/Common/ComButton/Image_Score_C0.png",
		RankType = 2,
		Group = 1,
		RankLowerLimit = 41,
		Mail = 35042009,
		Id = 10013
	},
	[10014] = {
		RankUpperLimit = 80,
		Image = "/Common/ComButton/Image_Score_D.png",
		RankType = 2,
		Group = 1,
		RankLowerLimit = 61,
		Mail = 35042010,
		Id = 10014
	},
	[10015] = {
		RankUpperLimit = 100,
		Image = "/Common/ComButton/Image_Score_E.png",
		RankType = 2,
		Group = 1,
		RankLowerLimit = 81,
		Mail = 35042011,
		Id = 10015
	}
}

setmetatable(CfgPlaceGameTowerRankTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlaceGameTowerRankTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RankUpperLimit = 0,
		Image = "",
		RankType = 0,
		Mail = 0,
		RankLowerLimit = 0,
		Group = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgPlaceGameTowerRankTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlaceGameTowerRankTable
