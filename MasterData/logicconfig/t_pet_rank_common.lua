-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_rank_common.lua

module("logicconfig.config.t_pet_rank_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"kudosTimes",
		"3"
	},
	{
		"kudosPrize",
		"8:1:1000"
	},
	{
		"prizeNeedRankDefault",
		"100"
	}
}
local t_pet_rank_common = {
	kudosTimes = dataList[1],
	kudosPrize = dataList[2],
	prizeNeedRankDefault = dataList[3]
}

t_pet_rank_common.dataList = dataList

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

return t_pet_rank_common
