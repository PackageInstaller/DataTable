-- chunkname: @IQIGame\\Config\\CfgSpaceTreasureListTable.lua

local CfgSpaceTreasureListTable = {
	[1001] = {
		Team = 1,
		Id = 1001,
		SpaceName = getI18NValue(180150211),
		Cost = {
			1201086,
			20
		},
		RewardWeight = {
			35,
			35,
			18,
			10,
			2
		},
		Reward = {
			{
				10302,
				5
			},
			{
				10302,
				10
			},
			{
				10302,
				15
			},
			{
				10302,
				20
			},
			{
				11231,
				1
			}
		}
	},
	[1002] = {
		Team = 1,
		Id = 1002,
		SpaceName = getI18NValue(180150212),
		Cost = {
			1201087,
			20
		},
		RewardWeight = {
			35,
			35,
			18,
			10,
			2
		},
		Reward = {
			{
				11402,
				5
			},
			{
				11402,
				10
			},
			{
				11402,
				15
			},
			{
				11402,
				20
			},
			{
				11231,
				1
			}
		}
	},
	[1003] = {
		Team = 1,
		Id = 1003,
		SpaceName = getI18NValue(180150213),
		Cost = {
			1201088,
			20
		},
		RewardWeight = {
			35,
			35,
			18,
			10,
			2
		},
		Reward = {
			{
				1,
				10000
			},
			{
				1,
				20000
			},
			{
				1,
				30000
			},
			{
				1,
				40000
			},
			{
				11231,
				1
			}
		}
	},
	[1004] = {
		Team = 1,
		Id = 1004,
		SpaceName = getI18NValue(180150214),
		Cost = {
			1201089,
			20
		},
		RewardWeight = {
			35,
			35,
			18,
			10,
			2
		},
		Reward = {
			{
				10501,
				2
			},
			{
				10501,
				4
			},
			{
				10501,
				6
			},
			{
				10501,
				8
			},
			{
				11231,
				1
			}
		}
	}
}

setmetatable(CfgSpaceTreasureListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSpaceTreasureListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		SpaceName = "",
		Team = 0,
		RewardWeight = {
			0,
			0,
			0,
			0,
			0
		},
		Reward = {
			{},
			{},
			{},
			{},
			{}
		},
		Cost = {}
	}
}

for i, data in pairs(CfgSpaceTreasureListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSpaceTreasureListTable
