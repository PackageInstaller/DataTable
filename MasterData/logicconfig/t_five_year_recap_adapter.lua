-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_adapter.lua

module("logicconfig.config.t_five_year_recap_adapter", package.seeall)

local title = {
	adapterType = 1
}
local dataList = {
	{
		"DataId"
	},
	{
		"RankRatio"
	},
	{
		"PetName"
	},
	{
		"DateTime"
	}
}
local t_five_year_recap_adapter = {
	DataId = dataList[1],
	RankRatio = dataList[2],
	PetName = dataList[3],
	DateTime = dataList[4]
}

t_five_year_recap_adapter.dataList = dataList

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

return t_five_year_recap_adapter
