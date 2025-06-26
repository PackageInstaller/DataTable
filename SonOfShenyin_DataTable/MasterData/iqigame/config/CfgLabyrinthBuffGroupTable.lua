-- chunkname: @IQIGame\\Config\\CfgLabyrinthBuffGroupTable.lua

local CfgLabyrinthBuffGroupTable = {
	{
		Id = 1,
		GroupIcon = "Assets/05_Images/Labyrinth/TalentIcon/Maze_Talent_02.png",
		Name = getI18NValue(180244001),
		SpecialBuff = {
			{
				2,
				1101400
			},
			{
				4,
				1101410
			},
			{
				6,
				1101420
			}
		},
		SpecialBuffDes = {
			getI18NValue(180244002),
			getI18NValue(180244000),
			getI18NValue(180243999)
		}
	},
	{
		Id = 2,
		GroupIcon = "Assets/05_Images/Labyrinth/TalentIcon/Maze_Talent_02.png",
		Name = getI18NValue(180244005),
		SpecialBuff = {
			{
				2,
				1102400
			},
			{
				4,
				1102410
			},
			{
				6,
				1102420
			}
		},
		SpecialBuffDes = {
			getI18NValue(180244006),
			getI18NValue(180244004),
			getI18NValue(180244003)
		}
	},
	{
		Id = 3,
		GroupIcon = "Assets/05_Images/Labyrinth/TalentIcon/Maze_Talent_02.png",
		Name = getI18NValue(180244009),
		SpecialBuff = {
			{
				2,
				1103400
			},
			{
				4,
				1103410
			},
			{
				6,
				1103420
			}
		},
		SpecialBuffDes = {
			getI18NValue(180244010),
			getI18NValue(180244008),
			getI18NValue(180244007)
		}
	},
	{
		Id = 4,
		GroupIcon = "Assets/05_Images/Labyrinth/TalentIcon/Maze_Talent_02.png",
		Name = getI18NValue(180244013),
		SpecialBuff = {
			{
				2,
				1202400
			},
			{
				4,
				1202410
			},
			{
				6,
				1202420
			}
		},
		SpecialBuffDes = {
			getI18NValue(180244014),
			getI18NValue(180244012),
			getI18NValue(180244011)
		}
	},
	{
		Id = 5,
		GroupIcon = "Assets/05_Images/Labyrinth/TalentIcon/Maze_Talent_02.png",
		Name = getI18NValue(180244017),
		SpecialBuff = {
			{
				2,
				1203400
			},
			{
				4,
				1203410
			},
			{
				6,
				1203420
			}
		},
		SpecialBuffDes = {
			getI18NValue(180244018),
			getI18NValue(180244016),
			getI18NValue(180244015)
		}
	},
	[101] = {
		Id = 101,
		GroupIcon = "Assets/05_Images/Labyrinth/TalentIcon/Maze_Talent_02.png",
		Name = getI18NValue(180244021),
		SpecialBuff = {
			{
				2,
				1201400
			},
			{
				4,
				1201410
			},
			{
				6,
				1201420
			}
		},
		SpecialBuffDes = {
			getI18NValue(180244022),
			getI18NValue(180244020),
			getI18NValue(180244019)
		}
	}
}

setmetatable(CfgLabyrinthBuffGroupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthBuffGroupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		GroupIcon = "",
		Name = "",
		SpecialBuffDes = {
			"",
			"",
			""
		},
		SpecialBuff = {
			{},
			{},
			{}
		}
	}
}

for i, data in pairs(CfgLabyrinthBuffGroupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthBuffGroupTable
