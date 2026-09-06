-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_wen_tab.lua

module("logicconfig.config.t_ling_wen_tab", package.seeall)

local title = {
	bgPath = 6,
	openDesc = 4,
	openTime = 3,
	tabId = 1,
	name = 2,
	showPrize = 5
}
local dataList = {
	{
		1,
		"强攻幻境",
		"每周|1@00:00-23:59#5-7@00:00-23:59",
		"周一，五、六日开放",
		"24:100151:0:1#24:100252:0:1#24:100353:0:1",
		"board_lingwenmijing01"
	},
	{
		2,
		"御守幻境",
		"每周|2@00:00-23:59#5-7@00:00-23:59",
		"周二，五、六日开放",
		"24:100751:0:1#24:100852:0:1#24:100953:0:1",
		"board_lingwenmijing02"
	},
	{
		3,
		"制衡幻境",
		"每周|3@00:00-23:59#5-7@00:00-23:59",
		"周三，五、六日开放",
		"24:100451:0:1#24:100552:0:1#24:100653:0:1",
		"board_lingwenmijing03"
	},
	{
		4,
		"通感幻境",
		"每周|4@00:00-23:59#5-7@00:00-23:59",
		"周四，五、六日开放",
		"24:101051:0:1#24:101152:0:1#24:101253:0:1",
		"board_lingwenmijing04"
	}
}
local t_ling_wen_tab = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_ling_wen_tab.dataList = dataList

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

return t_ling_wen_tab
