-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_festival.lua

module("logicconfig.config.t_scene_festival", package.seeall)

local title = {
	bgmIds = 4,
	sceneId = 1,
	resName = 3,
	screenEff = 5,
	hours = 9,
	fitFullScreen = 6,
	festival = 2,
	endTime = 8,
	startTime = 7
}
local dataList = {
	{
		1001,
		"wanshengjie",
		{
			"aoqicheng_wanshengjie"
		},
		nil,
		"",
		false,
		"2021-10-29T05:00:00",
		"2021-11-12T05:00:00",
		"19-5"
	},
	{
		125,
		"wanshengjie",
		{
			"answerscene_wanshengjie"
		},
		nil,
		"",
		false,
		"2022-09-02T05:00:00",
		"2022-09-17T05:00:00",
		"0-24"
	},
	{
		118,
		"shazhiguo",
		{
			"shazhiguo"
		},
		nil,
		"fx_scene_shazhiguo/prefab/shazhiguo/fx_scene_shazhiguo_weixian_01",
		true,
		"2022-04-29T05:00:00",
		"2022-06-02T05:00:00",
		"0-24"
	}
}
local t_scene_festival = {
	[1001] = {
		wanshengjie = dataList[1]
	},
	[125] = {
		wanshengjie = dataList[2]
	},
	[118] = {
		shazhiguo = dataList[3]
	}
}

t_scene_festival.dataList = dataList

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

return t_scene_festival
