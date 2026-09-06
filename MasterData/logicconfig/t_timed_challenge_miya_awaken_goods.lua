-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_miya_awaken_goods.lua

module("logicconfig.config.t_timed_challenge_miya_awaken_goods", package.seeall)

local title = {
	id = 1,
	discount = 4,
	goods = 2,
	payGoodsId = 3
}
local dataList = {
	{
		1,
		"4:80002:1",
		"rmb_98",
		88
	}
}
local t_timed_challenge_miya_awaken_goods = {
	dataList[1]
}

t_timed_challenge_miya_awaken_goods.dataList = dataList

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

return t_timed_challenge_miya_awaken_goods
