-- chunkname: @IQIGame\\Config\\CfgLabyrinthEventCampTable.lua

local CfgLabyrinthEventCampTable = {
	[41300001] = {
		Id = 41300001,
		EventAction = {
			33,
			0
		},
		EventActionParams = {
			{
				2,
				2,
				1,
				30
			},
			{}
		}
	},
	[41300002] = {
		Id = 41300002,
		EventAction = {
			33,
			0
		},
		EventActionParams = {
			{
				2,
				2,
				1,
				-5
			},
			{}
		}
	},
	[41300003] = {
		Id = 41300003,
		EventAction = {
			33,
			0
		},
		EventActionParams = {
			{
				2,
				1,
				1,
				-30
			},
			{}
		}
	},
	[41300004] = {
		Id = 41300004,
		EventAction = {
			33,
			0
		},
		EventActionParams = {
			{
				2,
				2,
				1,
				15
			},
			{}
		}
	},
	[5] = {
		Id = 5
	},
	[6] = {
		Id = 6
	},
	[7] = {
		Id = 7
	},
	[8] = {
		Id = 8
	},
	[9] = {
		Id = 9
	},
	[10] = {
		Id = 10
	}
}

setmetatable(CfgLabyrinthEventCampTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthEventCampTable]")
	end
})

local defaultMetaTable = {
	__index = {
		DefaultAnimation = "",
		CampShow = 0,
		EventActionParams = {
			{},
			{}
		},
		EventAction = {
			0,
			0
		},
		DefaultEffect = {}
	}
}

for i, data in pairs(CfgLabyrinthEventCampTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthEventCampTable
