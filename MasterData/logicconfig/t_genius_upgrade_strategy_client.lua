-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_genius_upgrade_strategy_client.lua

module("logicconfig.config.t_genius_upgrade_strategy_client", package.seeall)

local title = {
	wan_zhong_zhu_mu = 7,
	shi_fen_chang_jian = 4,
	qian_zai_nan_feng = 6,
	yi_wu_shi_chu = 3,
	id = 1,
	bai_li_tiao_yi = 5,
	wang_zhe_wu_di = 8,
	cultivateTimes = 2
}
local dataList = {}
local t_genius_upgrade_strategy_client = {}

t_genius_upgrade_strategy_client.dataList = dataList

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

return t_genius_upgrade_strategy_client
