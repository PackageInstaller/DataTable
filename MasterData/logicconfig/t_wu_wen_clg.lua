-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_wen_clg.lua

module("logicconfig.config.t_wu_wen_clg", package.seeall)

local title = {
	raceId = 2,
	activityId = 1,
	jumpTo = 3
}
local dataList = {
	{
		374001,
		13017,
		{
			"func#618#13017",
			"func#5116",
			"mibao#yingsenzhuxiang4"
		}
	},
	{
		374002,
		15031,
		{
			"func#618#15031",
			"mibao#jinglingyangcheng",
			"func#1211",
			"func#545#3"
		}
	},
	{
		374003,
		14041,
		{
			"func#618#14041",
			"ui#lottery",
			"func#545#22",
			"mibao#jinglingyangcheng"
		}
	}
}
local t_wu_wen_clg = {
	[374001] = dataList[1],
	[374002] = dataList[2],
	[374003] = dataList[3]
}

t_wu_wen_clg.dataList = dataList

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

return t_wu_wen_clg
