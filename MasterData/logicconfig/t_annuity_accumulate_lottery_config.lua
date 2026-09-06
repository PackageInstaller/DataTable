-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_accumulate_lottery_config.lua

module("logicconfig.config.t_annuity_accumulate_lottery_config", package.seeall)

local title = {
	itemId = 2,
	consumePlanId = 3,
	activityId = 1,
	getProps = 4
}
local dataList = {
	{
		42001,
		"10:42001",
		1,
		1
	}
}
local t_annuity_accumulate_lottery_config = {
	[42001] = dataList[1]
}

t_annuity_accumulate_lottery_config.dataList = dataList

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

return t_annuity_accumulate_lottery_config
