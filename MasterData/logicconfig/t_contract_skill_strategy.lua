-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_contract_skill_strategy.lua

module("logicconfig.config.t_contract_skill_strategy", package.seeall)

local title = {
	effectPath = 2,
	contractSkillId = 1
}
local dataList = {
	{
		520006,
		"common/buff/fx_buff_zhaohuanshou"
	},
	{
		520007,
		"common/buff/fx_buff_zhaohuanshou"
	},
	{
		520008,
		"common/buff/fx_buff_zhaohuanshou"
	},
	{
		520009,
		"common/buff/fx_buff_zhaohuanshou"
	},
	{
		520010,
		"common/buff/fx_buff_zhaohuanshou"
	}
}
local t_contract_skill_strategy = {
	[520006] = dataList[1],
	[520007] = dataList[2],
	[520008] = dataList[3],
	[520009] = dataList[4],
	[520010] = dataList[5]
}

t_contract_skill_strategy.dataList = dataList

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

return t_contract_skill_strategy
