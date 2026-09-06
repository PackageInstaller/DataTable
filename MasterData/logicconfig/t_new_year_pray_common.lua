-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_common.lua

module("logicconfig.config.t_new_year_pray_common", package.seeall)

local title = {
	comPlanId = 1,
	spineScale = 5,
	spinePos = 4,
	ruleKeyMain = 2,
	spineUrl = 3
}
local dataList = {
	{
		1,
		"newyearwish_rule",
		"character/10295_caishennuo/10295_caishennuo-ui_p.prefab",
		{
			117,
			-212
		},
		{
			0.7,
			0.7
		}
	}
}
local t_new_year_pray_common = {
	dataList[1]
}

t_new_year_pray_common.dataList = dataList

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

return t_new_year_pray_common
