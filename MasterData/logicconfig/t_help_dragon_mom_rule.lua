-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_help_dragon_mom_rule.lua

module("logicconfig.config.t_help_dragon_mom_rule", package.seeall)

local title = {
	id = 1,
	resPath = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"点击两侧【敲击晶石】按钮，即可对火灵石进行精炼，\r\n获得能量点的同时，还有机会获得“能量暴击”机会哦！",
		"views/huodong/yunyinghuizong/board_zhengjiulongmu_10"
	}
}
local t_help_dragon_mom_rule = {
	dataList[1]
}

t_help_dragon_mom_rule.dataList = dataList

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

return t_help_dragon_mom_rule
