-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_equipment_throne_quality_refund.lua

module("logicconfig.config.t_equipment_throne_quality_refund", package.seeall)

local title = {
	refundMp = 2,
	quality = 1
}
local dataList = {
	{
		8,
		"8:25:80"
	},
	{
		9,
		"8:25:320"
	},
	{
		10,
		"8:25:320"
	},
	{
		11,
		"8:25:320"
	}
}
local t_equipment_throne_quality_refund = {
	[8] = dataList[1],
	[9] = dataList[2],
	[10] = dataList[3],
	[11] = dataList[4]
}

t_equipment_throne_quality_refund.dataList = dataList

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

return t_equipment_throne_quality_refund
