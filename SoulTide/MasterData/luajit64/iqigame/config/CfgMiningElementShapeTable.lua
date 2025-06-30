-- chunkname: @IQIGame\\Config\\CfgMiningElementShapeTable.lua

local CfgMiningElementShapeTable = {
	[101] = {
		Id = 101,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_03"
	},
	[102] = {
		Id = 102,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_07"
	},
	[103] = {
		Id = 103,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_11"
	},
	[104] = {
		Id = 104,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_01"
	},
	[105] = {
		Id = 105,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_06"
	},
	[106] = {
		Id = 106,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_10"
	},
	[107] = {
		Id = 107,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_22"
	},
	[108] = {
		Id = 108,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_04"
	},
	[109] = {
		Id = 109,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_20"
	},
	[110] = {
		Id = 110,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_24"
	},
	[111] = {
		Id = 111,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_16"
	},
	[112] = {
		Id = 112,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_02"
	},
	[113] = {
		Id = 113,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_14"
	},
	[114] = {
		Id = 114,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_19"
	},
	[115] = {
		Id = 115,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_23"
	},
	[116] = {
		Id = 116,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_05"
	},
	[117] = {
		Id = 117,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_09"
	},
	[118] = {
		Id = 118,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_13"
	},
	[119] = {
		Id = 119,
		LandSkin = "MiningElement/MiningElementNode/MiningElementNode_1_21"
	}
}

setmetatable(CfgMiningElementShapeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMiningElementShapeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		LandSkin = ""
	}
}

for i, data in pairs(CfgMiningElementShapeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMiningElementShapeTable
