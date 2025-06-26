-- chunkname: @IQIGame\\Config\\CfgFishSkillListTable.lua

local CfgFishSkillListTable = {
	[1001] = {
		TriggerCondition = 50,
		SkillTime = 1500,
		Id = 1001,
		SkillType = {
			1,
			2
		},
		Skillparameter = {
			10,
			10
		}
	},
	[1002] = {
		TriggerCondition = 50,
		SkillTime = 1500,
		Id = 1002,
		SkillType = {
			1,
			2
		},
		Skillparameter = {
			20,
			20
		}
	},
	[1003] = {
		TriggerCondition = 50,
		SkillTime = 1500,
		Id = 1003,
		SkillType = {
			1,
			2
		},
		Skillparameter = {
			30,
			30
		}
	},
	[1004] = {
		TriggerCondition = 90,
		SkillTime = 1500,
		Id = 1004,
		SkillType = {
			1,
			2
		},
		Skillparameter = {
			40,
			40
		}
	}
}

setmetatable(CfgFishSkillListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFishSkillListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		TriggerCondition = 0,
		SkillTime = 0,
		Skillparameter = {
			0,
			0
		},
		SkillType = {
			0,
			0
		}
	}
}

for i, data in pairs(CfgFishSkillListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFishSkillListTable
