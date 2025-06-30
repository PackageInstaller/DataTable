-- chunkname: @IQIGame\\Config\\CfgLabyrinthEventStoryTable.lua

local CfgLabyrinthEventStoryTable = {
	[41700001] = {
		StoryShow = 10815065,
		Id = 41700001,
		StoryData = "Assets/21_Media/Story/part0-1.mp4",
		DefaultAnimation = "S_on",
		StoryAction = 32,
		Name = getI18NValue(180216788),
		DefaultEffect = {
			10028,
			10001
		},
		StoryActionParams = {
			200322
		}
	},
	[41700002] = {
		StoryShow = 10815065,
		Id = 41700002,
		StoryData = "Assets/21_Media/Maze/Season_1/Video_1_1.mp4",
		DefaultAnimation = "S_on",
		StoryAction = 32,
		Name = getI18NValue(180216789),
		DefaultEffect = {
			10028,
			10001
		},
		StoryActionParams = {
			200322
		}
	},
	[41700003] = {
		StoryShow = 10815065,
		Id = 41700003,
		StoryData = "Assets/21_Media/Maze/Season_1/Video_1_2.mp4",
		DefaultAnimation = "S_on",
		StoryAction = 32,
		Name = getI18NValue(180216790),
		DefaultEffect = {
			10028,
			10001
		},
		StoryActionParams = {
			200322
		}
	},
	[41700004] = {
		StoryShow = 10815065,
		Id = 41700004,
		StoryData = "Assets/21_Media/Maze/Season_1/Video_1_3.mp4",
		DefaultAnimation = "S_on",
		StoryAction = 32,
		Name = getI18NValue(180216791),
		DefaultEffect = {
			10028,
			10001
		},
		StoryActionParams = {
			200322
		}
	},
	[41700005] = {
		StoryShow = 10815065,
		Id = 41700005,
		StoryData = "Assets/21_Media/Maze/Season_1/Video_1_4.mp4",
		DefaultAnimation = "S_on",
		StoryAction = 32,
		Name = getI18NValue(180243496),
		DefaultEffect = {
			10028,
			10001
		},
		StoryActionParams = {
			200322
		}
	},
	[41700006] = {
		StoryShow = 10815065,
		Id = 41700006,
		StoryData = "Assets/21_Media/Maze/Season_1/Video_1_5.mp4",
		DefaultAnimation = "S_on",
		StoryAction = 32,
		Name = getI18NValue(180243497),
		DefaultEffect = {
			10028,
			10001
		},
		StoryActionParams = {
			200322
		}
	},
	[42700002] = {
		StoryData = "Assets/21_Media/Story/part0-1.mp4",
		StoryAction = 32,
		Id = 42700002,
		Name = getI18NValue(180216792),
		DefaultEffect = {
			10028,
			10001
		},
		StoryActionParams = {
			200322
		}
	}
}

setmetatable(CfgLabyrinthEventStoryTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthEventStoryTable]")
	end
})

local defaultMetaTable = {
	__index = {
		StoryShow = 0,
		StoryData = "",
		StoryAction = 0,
		DefaultAnimation = "",
		Name = "",
		StoryActionParams = {},
		DefaultEffect = {}
	}
}

for i, data in pairs(CfgLabyrinthEventStoryTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthEventStoryTable
