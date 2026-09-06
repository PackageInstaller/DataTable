-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_red_pack_bubble.lua

module("logicconfig.config.t_group_red_pack_bubble", package.seeall)

local title = {
	id = 1,
	des = 2
}
local dataList = {
	{
		1,
		"想不到有这么多人支持我，真开心~"
	},
	{
		2,
		"你来啦，给我投票了吗~？"
	},
	{
		3,
		"今天也是成就感满满的一天呢~"
	},
	{
		4,
		"终究还是比不过别的姐姐妹妹生得俊俏o(╥﹏╥)o"
	}
}
local t_group_red_pack_bubble = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_group_red_pack_bubble.dataList = dataList

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

return t_group_red_pack_bubble
