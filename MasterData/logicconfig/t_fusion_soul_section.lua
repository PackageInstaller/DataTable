-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fusion_soul_section.lua

module("logicconfig.config.t_fusion_soul_section", package.seeall)

local title = {
	sectionName = 3,
	bgRes = 5,
	clueCount = 4,
	activityId = 1,
	sectionId = 2
}
local dataList = {
	{
		498001,
		0,
		"妖王事迹",
		0,
		"ui/bigbg/fusionsoul/bg_fuyao_rhll_01.png"
	},
	{
		498001,
		1,
		"阵法谜题",
		10,
		"ui/bigbg/fusionsoul/bg_fuyao_rhll_01.png"
	},
	{
		498001,
		2,
		"御神坠落",
		15,
		"ui/bigbg/fusionsoul/bg_fuyao_rhll_01.png"
	},
	{
		498001,
		3,
		"古书探寻",
		20,
		"ui/bigbg/fusionsoul/bg_fuyao_rhll_01.png"
	},
	{
		498001,
		4,
		"自封之路",
		28,
		"ui/bigbg/fusionsoul/bg_fuyao_rhll_01.png"
	}
}
local t_fusion_soul_section = {
	[498001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_fusion_soul_section.dataList = dataList

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

return t_fusion_soul_section
