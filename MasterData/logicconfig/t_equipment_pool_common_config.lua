-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_equipment_pool_common_config.lua

module("logicconfig.config.t_equipment_pool_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MULT_DRAW_TYPES",
		"1,10"
	},
	{
		"MULT_DRAW_DESC",
		"单次召唤,十次召唤"
	},
	{
		"PUTONGCHOUKA",
		"6015:2:6折十连,6013:2:9折十连,6017:2:9折十连"
	},
	{
		"GAOJICHOUKA",
		"6018:2:9折神炼,6014:2:9折十连,906:2:超值神炼"
	}
}
local t_equipment_pool_common_config = {
	MULT_DRAW_TYPES = dataList[1],
	MULT_DRAW_DESC = dataList[2],
	PUTONGCHOUKA = dataList[3],
	GAOJICHOUKA = dataList[4]
}

t_equipment_pool_common_config.dataList = dataList

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

return t_equipment_pool_common_config
