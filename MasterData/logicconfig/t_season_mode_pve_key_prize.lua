-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_key_prize.lua

module("logicconfig.config.t_season_mode_pve_key_prize", package.seeall)

local title = {
	seasonId = 1,
	keyPrize = 2
}
local dataList = {
	{
		1,
		"100:17004:1:1#4:80351:1#4:90321:2#4:510022:5#4:30006:200#104:2:3000"
	},
	{
		2,
		"17:1014603:-1:1#14:156:1#4:161:20#4:510022:5#4:30006:200"
	},
	{
		3,
		"100:17012:1:1#4:90268:1#4:510022:5#4:30006:200"
	}
}
local t_season_mode_pve_key_prize = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_season_mode_pve_key_prize.dataList = dataList

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

return t_season_mode_pve_key_prize
