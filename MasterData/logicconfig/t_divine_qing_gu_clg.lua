-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_qing_gu_clg.lua

module("logicconfig.config.t_divine_qing_gu_clg", package.seeall)

local title = {
	challengeId = 2,
	jumpTo2 = 4,
	coin = 6,
	jumpTo1 = 3,
	activityId = 1,
	jumpTo3 = 5
}
local dataList = {
	{
		372001,
		168,
		"func#618#13018",
		"ui#lottery",
		"mibao#shenyaolibao",
		"4:235"
	}
}
local t_divine_qing_gu_clg = {
	[372001] = dataList[1]
}

t_divine_qing_gu_clg.dataList = dataList

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

return t_divine_qing_gu_clg
