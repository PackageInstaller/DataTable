-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_colorful_lantern_work.lua

module("logicconfig.config.t_colorful_lantern_work", package.seeall)

local title = {
	Id = 1,
	resName = 2
}
local dataList = {
	{
		1,
		"icon_shenqi_guanglun_03"
	},
	{
		2,
		"icon_shenqi_guanglun_04"
	},
	{
		3,
		"icon_shenqi_yanluo_04"
	},
	{
		4,
		"icon_shenqi_mizong_02"
	},
	{
		5,
		"icon_shenqi_tianyan_02"
	},
	{
		6,
		"icon_chiyanlonghuang_02"
	},
	{
		7,
		"icon_chiyanlonghuang_02"
	}
}
local t_colorful_lantern_work = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_colorful_lantern_work.dataList = dataList

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

return t_colorful_lantern_work
