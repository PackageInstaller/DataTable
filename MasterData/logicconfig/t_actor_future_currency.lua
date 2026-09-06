-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_actor_future_currency.lua

module("logicconfig.config.t_actor_future_currency", package.seeall)

local title = {
	parameter = 1,
	value = 2
}
local dataList = {
	{
		"lailisi_Id",
		"165007"
	},
	{
		"xingluo_Id",
		"165016"
	},
	{
		"daianna_Id",
		"165022"
	},
	{
		"holyiceking_Id",
		"165028"
	},
	{
		"holymoonking_Id",
		"165034"
	}
}
local t_actor_future_currency = {
	lailisi_Id = dataList[1],
	xingluo_Id = dataList[2],
	daianna_Id = dataList[3],
	holyiceking_Id = dataList[4],
	holymoonking_Id = dataList[5]
}

t_actor_future_currency.dataList = dataList

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

return t_actor_future_currency
