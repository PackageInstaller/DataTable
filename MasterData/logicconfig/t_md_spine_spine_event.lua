-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_md_spine_spine_event.lua

module("logicconfig.config.t_md_spine_spine_event", package.seeall)

local title = {
	spineEventId = 1,
	eventType = 3,
	paramValue = 4,
	eventName = 2
}
local dataList = {
	{
		"audio_sx_1800101_01",
		"sx_1800101_01",
		"Audio",
		{
			audioId = "1014509"
		}
	},
	{
		"audio_sx_1402301_01",
		"sx_1402301_01",
		"Audio",
		{
			audioId = "50007"
		}
	},
	{
		"audio_sx_1402301_02",
		"sx_1402301_03",
		"Audio",
		{
			audioId = "50008"
		}
	},
	{
		"audio_sx_1402301_03",
		"sx_1402301_04",
		"Audio",
		{
			audioId = "50009"
		}
	},
	{
		"audio_sx_1402301_04",
		"sx_1402301_05",
		"Audio",
		{
			audioId = "50010"
		}
	}
}
local t_md_spine_spine_event = {
	audio_sx_1800101_01 = dataList[1],
	audio_sx_1402301_01 = dataList[2],
	audio_sx_1402301_02 = dataList[3],
	audio_sx_1402301_03 = dataList[4],
	audio_sx_1402301_04 = dataList[5]
}

t_md_spine_spine_event.dataList = dataList

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

return t_md_spine_spine_event
