-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_lottery_pool.lua

module("logic.config.t_lottery_pool", package.seeall)

local title = {
	pickableItems = 11,
	name = 2,
	code = 1,
	titleName = 16,
	wishDesc = 13,
	bannerName = 19,
	sortOrder = 7,
	characterCode = 17,
	wishMax = 12,
	running = 8,
	pictureName = 18,
	leftPos = 20,
	showMidRoleInfo = 23,
	campType = 4,
	enterVideo = 24,
	rightPos = 22,
	cost = 6,
	subtitle = 3,
	sceneBg = 14,
	hint = 15,
	absoluteMax = 10,
	feature = 9,
	midPos = 21,
	systemOpen = 5
}
local dataList = {
	{
		7,
		"特邀招募",
		"新手招募",
		2,
		22002,
		{
			1001001,
			1,
			10
		},
		1,
		3,
		1,
		0,
		{
			2000019,
			2000008,
			2000041
		},
		0,
		"<summary><sprite name=\"yuandian1\"> 【祈愿】系统，是本池特有的祈愿机制</summary>\r\n<sprite name=\"yuandian1\"> 玩家可以选择期望的UP守秘人，作为祈愿目标\r\n<sprite name=\"yuandian1\"> 在本池中祈愿获得的S级守秘人必定是通过【祈愿】选定的守秘人\r\n<sprite name=\"yuandian1\"> 在本池中【祈愿】获得守秘人后，则本池会消失\r\n<sprite name=\"yuandian1\"> 祈愿目标可以随时更换或者取消",
		"s410_chouka_plane_a",
		"抽取后，可以开启<color=#ffffff>【守秘人特训任务】</color>",
		"jscjdd_text_tyzm_tra",
		{
			2000019,
			2000008,
			2000041
		},
		"jscjdd_img_tyzm_01",
		"jscjdd_img_tyzm_02",
		{
			-0.87,
			-0.53,
			4.33
		},
		{
			0.18,
			-0.53,
			5
		},
		{
			1.21,
			-0.53,
			4.33
		},
		0,
		""
	},
	{
		1001,
		"标准招募",
		"常规招募",
		2,
		0,
		{
			1001001,
			1,
			10
		},
		5,
		1,
		0,
		0,
		nil,
		0,
		"",
		"s410_chouka_plane_a",
		"在时间的交错中，与更多守秘人相遇",
		"jscjdd_text_bzzm_tra",
		{
			2000039
		},
		"jscjdd_img_bzzm_01",
		"jscjdd_img_bzzm_02",
		{
			-0.87,
			-0.53,
			4.33
		},
		{
			0.18,
			-0.53,
			4.5
		},
		{
			1.04,
			-0.53,
			4.33
		},
		0,
		""
	},
	{
		1002,
		"妄狂之智",
		"厄迪普斯概率UP",
		2,
		22004,
		{
			1001001,
			1,
			10
		},
		2,
		1,
		0,
		150,
		nil,
		0,
		"",
		"s410_chouka_plane_b",
		"癫狂的天才，明慧的疯子",
		"jscjdd_text_kwzz_tra",
		{
			2000057
		},
		"jscjdd_img_kwzz_01",
		"jscjdd_img_kwzz_02",
		{
			-0.87,
			-0.53,
			4.33
		},
		{
			0.18,
			-0.53,
			4.8
		},
		{
			1.04,
			-0.53,
			4.33
		},
		1,
		""
	},
	{
		1003,
		"映铁雷光",
		"卡琳娜概率UP",
		2,
		22005,
		{
			1001001,
			1,
			10
		},
		3,
		1,
		0,
		150,
		nil,
		0,
		"",
		"s410_chouka_plane_c",
		"最后的白桦，贯穿战场的雷光",
		"jscjdd_text_ytlg_tra",
		{
			2000051
		},
		"jscjdd_img_tytlg_01",
		"jscjdd_img_tytlg_02",
		{
			-0.87,
			-0.53,
			4.33
		},
		{
			0.18,
			-0.53,
			4.5
		},
		{
			1.04,
			-0.53,
			4.33
		},
		1,
		""
	},
	{
		1004,
		"虚识惑梦",
		"爱丽丝概率UP",
		2,
		22006,
		{
			1001001,
			1,
			10
		},
		4,
		1,
		0,
		150,
		nil,
		0,
		"",
		"s410_chouka_plane_d",
		"如梦幻境中，少女无声呢喃",
		"jscjdd_text_xshm_tra",
		{
			2000002
		},
		"jscjdd_img_xhhm_01",
		"jscjdd_img_xhhm_02",
		{
			-0.87,
			-0.53,
			4.33
		},
		{
			0.18,
			-0.53,
			4.15
		},
		{
			1.04,
			-0.53,
			4.33
		},
		0,
		""
	}
}
local t_lottery_pool = {}

t_lottery_pool.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_lottery_pool[v[1]] = v

	setmetatable(v, mt)
end

return t_lottery_pool
