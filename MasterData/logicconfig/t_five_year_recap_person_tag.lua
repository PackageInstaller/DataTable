-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_person_tag.lua

module("logicconfig.config.t_five_year_recap_person_tag", package.seeall)

local title = {
	sortId = 4,
	desc = 5,
	judgeCond = 6,
	pageId = 3,
	activityId = 1,
	tagId = 2
}
local dataList = {
	{
		586001,
		1,
		2,
		5,
		"江湖行者",
		"dataId$4,大于等于,30"
	},
	{
		586001,
		2,
		2,
		5,
		"初入江湖",
		"dataId$4,小于,30"
	},
	{
		586001,
		3,
		2,
		5,
		"连登高手",
		"dataId$5,大于等于,30"
	},
	{
		586001,
		4,
		2,
		5,
		"连登强人",
		"dataId$5,小于,30"
	},
	{
		586001,
		5,
		3,
		5,
		"战力天尊",
		"dataId$13,大于等于,2000000"
	},
	{
		586001,
		6,
		3,
		5,
		"战力磨炼中",
		"dataId$13,小于,2000000"
	},
	{
		586001,
		7,
		4,
		5,
		"养成匠人",
		"dataId$9,大于等于,15"
	},
	{
		586001,
		8,
		4,
		5,
		"养成新锐",
		"dataId$9,小于,15"
	},
	{
		586001,
		9,
		5,
		5,
		"星神宗师",
		"dataId$10,大于等于,10"
	},
	{
		586001,
		10,
		5,
		5,
		"星神收集中",
		"dataId$10,小于,10"
	},
	{
		586001,
		11,
		8,
		2,
		"钞能力使者",
		"dataId$17,大于等于,2000"
	},
	{
		586001,
		12,
		8,
		2,
		"仙侠金主",
		"dataId$17,小于,2000&dataId$17,大于等于,648"
	},
	{
		586001,
		13,
		8,
		2,
		"江湖巨富",
		"dataId$17,小于,648"
	},
	{
		586001,
		14,
		11,
		1,
		"殿堂名流",
		"dataId$19,大于等于,20000"
	},
	{
		586001,
		15,
		11,
		1,
		"千金雅士",
		"dataId$19,小于,20000&dataId$19,大于等于,6480"
	},
	{
		586001,
		16,
		11,
		1,
		"慷慨豪侠",
		"dataId$19,小于,6480"
	},
	{
		586001,
		17,
		15,
		3,
		"皮肤全图鉴",
		"dataId$40,大于等于,236"
	},
	{
		586001,
		18,
		15,
		3,
		"皮肤藏家",
		"dataId$40,小于,236&dataId$40,大于等于,50"
	},
	{
		586001,
		19,
		15,
		3,
		"皮肤收集者",
		"dataId$40,小于,50"
	},
	{
		586001,
		20,
		21,
		4,
		"无双斗狂",
		"dataId$42,大于等于,2000"
	},
	{
		586001,
		21,
		21,
		4,
		"鏖战宗师",
		"dataId$42,小于,2000&dataId$42,大于等于,80"
	},
	{
		586001,
		22,
		21,
		4,
		"烽火战神",
		"dataId$42,小于,80"
	},
	{
		586001,
		23,
		21,
		4,
		"挑战天尊",
		"dataId$43,大于等于100"
	},
	{
		586001,
		24,
		21,
		4,
		"挑战大佬",
		"dataId$43,小于,100&dataId$43,大于等于,20"
	},
	{
		586001,
		25,
		21,
		4,
		"挑战狂热者",
		"dataId$43,小于,20"
	}
}
local t_five_year_recap_person_tag = {
	[586001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_five_year_recap_person_tag.dataList = dataList

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

return t_five_year_recap_person_tag
