-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_boss_speak.lua

module("logicconfig.config.t_season_mode_pve_boss_speak", package.seeall)

local title = {
	desc = 3,
	weight = 4,
	phaseId = 1,
	subId = 2
}
local dataList = {
	{
		0,
		1,
		"蛊命骰局，请君入瓮。",
		1
	},
	{
		0,
		2,
		"来者都是客，要么以身入局，要么留下你的一部分。",
		1
	},
	{
		0,
		3,
		"赌局上无长幼，胜者生，败者死。",
		1
	},
	{
		0,
		4,
		"加注还是收手？我无所谓，看你的胆量。",
		1
	},
	{
		1,
		1,
		"赢够筹码才有资格见我。",
		1
	},
	{
		1,
		2,
		"舍命豪赌？！哈哈哈哈哈哈哈……",
		1
	},
	{
		1,
		3,
		"能活到现在……真努力啊，可爱得想要吃掉呢。",
		1
	},
	{
		2,
		1,
		"比大小博生死，雾中之秘，一骰定局！",
		1
	},
	{
		3,
		1,
		"侥幸赢了一堆废物，可不见得能赢过我。",
		1
	},
	{
		4,
		1,
		"0-7，选个数字，你想被我拼成几号艺术品呢？",
		1
	},
	{
		4,
		2,
		"愿赌服输，这具身子抵给你怎么样？",
		1
	},
	{
		5,
		1,
		"再来一局，我可以押上一切！",
		1
	}
}
local t_season_mode_pve_boss_speak = {
	[0] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8]
	},
	{
		dataList[9]
	},
	{
		dataList[10],
		dataList[11]
	},
	{
		dataList[12]
	}
}

t_season_mode_pve_boss_speak.dataList = dataList

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

return t_season_mode_pve_boss_speak
