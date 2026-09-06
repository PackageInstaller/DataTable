-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_npc.lua

module("logicconfig.config.t_unique_world_npc", package.seeall)

local title = {
	desc = 3,
	eventId = 1,
	skinId = 2
}
local dataList = {
	{
		3001,
		1702503,
		"少侠且慢！这壁画暗藏机关，可否助我破解？"
	},
	{
		3002,
		1602802,
		"我困此多日，腹中饥饿难耐，可有干粮？"
	},
	{
		3003,
		1702601,
		"前方毒瘴弥漫，我这有枚避毒丹……"
	},
	{
		3004,
		1603302,
		"这道石门需二人合力，你我联手推开如何？"
	},
	{
		3005,
		1402601,
		"公子且留步！可知这地宫埋着什么秘密？"
	},
	{
		3006,
		1602801,
		"我乃寻宝人，前方岔路凶险，愿结伴同行。"
	},
	{
		3007,
		1803101,
		"小女子与家人走散，可否护我寻到出口？"
	},
	{
		3008,
		1701001,
		"这位侠士，可愿听吾讲个江湖旧事？"
	},
	{
		3009,
		1702002,
		"你身上有股熟悉气息……可是师承华山？"
	}
}
local t_unique_world_npc = {
	[3001] = dataList[1],
	[3002] = dataList[2],
	[3003] = dataList[3],
	[3004] = dataList[4],
	[3005] = dataList[5],
	[3006] = dataList[6],
	[3007] = dataList[7],
	[3008] = dataList[8],
	[3009] = dataList[9]
}

t_unique_world_npc.dataList = dataList

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

return t_unique_world_npc
