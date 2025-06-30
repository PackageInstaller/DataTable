-- chunkname: @IQIGame\\Config\\CfgSerialVideoTable.lua

local CfgSerialVideoTable = {
	{
		VideoPath = "/StoryCG/MainStory1.mp4",
		IsLoop = true,
		Id = 1,
		NextVideoId = 2,
		BGM = 47,
		Subtitle = {
			getI18NValue(180107259),
			getI18NValue(180107260),
			getI18NValue(180107261),
			getI18NValue(180107262)
		}
	},
	{
		VideoPath = "/StoryCG/MainStory2.mp4",
		DisableClick = true,
		Id = 2,
		NextVideoId = 3,
		BGM = 47,
		Subtitle = {
			getI18NValue(180107263)
		}
	},
	{
		VideoPath = "/StoryCG/MainStory3.mp4",
		IsLoop = true,
		Id = 3,
		NextVideoId = -1,
		BGM = 47,
		Subtitle = {
			getI18NValue(180107264),
			getI18NValue(180107265),
			getI18NValue(180107266)
		}
	},
	{
		CanSkipWhenLock = true,
		DisableClick = true,
		VideoPath = "/21_Media/CG/ActivityPV/DreizehnPV.mp4",
		IsLocal = true,
		Id = 4,
		NextVideoId = -1,
		BGM = 100
	}
}

setmetatable(CfgSerialVideoTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSerialVideoTable]")
	end
})

local defaultMetaTable = {
	__index = {
		IsLocal = false,
		VideoPath = "",
		IsLoop = false,
		CanSkipWhenLock = false,
		NextVideoId = 0,
		DisableClick = false,
		BGM = 0,
		Subtitle = {}
	}
}

for i, data in pairs(CfgSerialVideoTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSerialVideoTable
