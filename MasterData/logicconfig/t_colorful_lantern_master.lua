-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_colorful_lantern_master.lua

module("logicconfig.config.t_colorful_lantern_master", package.seeall)

local title = {
	resName = 2,
	title = 3,
	Id = 1
}
local dataList = {
	{
		1,
		"icon_shenqi_guanglun_03",
		"鱼鳞灯"
	},
	{
		2,
		"icon_shenqi_guanglun_04",
		"蛋形灯"
	},
	{
		3,
		"icon_shenqi_yanluo_04",
		"鳌鱼灯"
	},
	{
		4,
		"icon_shenqi_mizong_02",
		"彩莲灯"
	},
	{
		5,
		"icon_shenqi_tianyan_02",
		"墨鱼骨灯"
	},
	{
		6,
		"icon_chiyanlonghuang_02",
		"走马灯"
	}
}
local t_colorful_lantern_master = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_colorful_lantern_master.dataList = dataList

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

return t_colorful_lantern_master
