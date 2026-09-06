-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_form_common.lua

module("logicconfig.config.t_master_form_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_SUBMIT_PET_COUNT",
		"6"
	},
	{
		"SELECT_TAG_COUNT",
		"3"
	},
	{
		"NEW_FORM_CAPACITY",
		"500"
	},
	{
		"ONE_FORM_COMMEMT_CAPACITY",
		"100"
	},
	{
		"HOT_FORM_CAPACITY",
		"50"
	},
	{
		"DALIY_KUDO_TIMES",
		"10"
	},
	{
		"DALIY_COMMENT_TIMES",
		"10"
	},
	{
		"COMMONT_SIZE_LIMIT",
		"30"
	},
	{
		"FORM_TITLE_SIZE_LIMIT",
		"5"
	},
	{
		"FORM_CORE_DESC_LIMIT",
		"8"
	},
	{
		"FORM_DESC_LIMIT",
		"60"
	},
	{
		"SUBMIT_FORM_PRIZE",
		"104:2:200"
	},
	{
		"KUDO_PRIZE",
		"8:1:10000"
	},
	{
		"MAIL_TEMPLATE_ID",
		"207"
	},
	{
		"COLLECT_COUNT_LIMIT",
		"10"
	},
	{
		"MAX_SUBMIT_FMT_COUNT",
		"3"
	},
	{
		"MAX_SYSTEM_FMT_SHOW_COUNT",
		"10"
	},
	{
		"GmOffShelfLineup",
		"210"
	},
	{
		"RARE_COND_LIMIT_MIN",
		"4"
	}
}
local t_master_form_common = {
	MAX_SUBMIT_PET_COUNT = dataList[1],
	SELECT_TAG_COUNT = dataList[2],
	NEW_FORM_CAPACITY = dataList[3],
	ONE_FORM_COMMEMT_CAPACITY = dataList[4],
	HOT_FORM_CAPACITY = dataList[5],
	DALIY_KUDO_TIMES = dataList[6],
	DALIY_COMMENT_TIMES = dataList[7],
	COMMONT_SIZE_LIMIT = dataList[8],
	FORM_TITLE_SIZE_LIMIT = dataList[9],
	FORM_CORE_DESC_LIMIT = dataList[10],
	FORM_DESC_LIMIT = dataList[11],
	SUBMIT_FORM_PRIZE = dataList[12],
	KUDO_PRIZE = dataList[13],
	MAIL_TEMPLATE_ID = dataList[14],
	COLLECT_COUNT_LIMIT = dataList[15],
	MAX_SUBMIT_FMT_COUNT = dataList[16],
	MAX_SYSTEM_FMT_SHOW_COUNT = dataList[17],
	GmOffShelfLineup = dataList[18],
	RARE_COND_LIMIT_MIN = dataList[19]
}

t_master_form_common.dataList = dataList

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

return t_master_form_common
