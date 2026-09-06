-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fusion_soul_npc.lua

module("logicconfig.config.t_fusion_soul_npc", package.seeall)

local title = {
	name = 3,
	npcId = 2,
	isMe = 5,
	icon = 4,
	activityId = 1
}
local dataList = {
	{
		498001,
		1,
		"奥奇",
		"icon_npc_zhentanaoqi",
		1
	},
	{
		498001,
		2,
		"小妖A",
		"icon_10048_gulumaoniu",
		0
	},
	{
		498001,
		3,
		"小妖B",
		"icon_10013_jisi",
		0
	},
	{
		498001,
		4,
		"小妖C",
		"icon_10012_shuangbing",
		0
	},
	{
		498001,
		5,
		"伏妖",
		"icon_12033_shenyaofuyao",
		0
	},
	{
		498001,
		6,
		"大祭司",
		"icon_eling_03",
		0
	}
}
local t_fusion_soul_npc = {
	[498001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_fusion_soul_npc.dataList = dataList

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

return t_fusion_soul_npc
