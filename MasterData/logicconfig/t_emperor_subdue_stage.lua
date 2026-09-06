-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_emperor_subdue_stage.lua

module("logicconfig.config.t_emperor_subdue_stage", package.seeall)

local title = {
	debuffId = 6,
	stageId = 2,
	buffId = 7,
	supportPetPlan = 8,
	title = 9,
	counterStage = 3,
	prize = 5,
	headRaceId = 10,
	baseRule = 11,
	passBuffDesc = 12,
	passDebuffDesc = 13,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		547001,
		1,
		{
			2
		},
		1001,
		"10:553001:10",
		6,
		1,
		1,
		"恶金",
		14032,
		"挑战规则：使用系统精灵破阵,五行相生相克",
		"恶金关能力：击败后获得50%命中率（仅在念关使用",
		"受到恶金影响，闪避率降低50%"
	},
	{
		547001,
		2,
		{
			5
		},
		1002,
		"10:553001:10",
		7,
		2,
		2,
		"恶木",
		13014,
		"挑战规则：使用系统精灵破阵,五行相生相克",
		"恶木关能力：击败后获得50%破击率（仅在念关使用",
		"受到恶木影响，格挡率降低50%"
	},
	{
		547001,
		3,
		{
			4
		},
		1003,
		"10:553001:10",
		8,
		3,
		3,
		"恶水",
		11030,
		"挑战规则：使用系统精灵破阵,五行相生相克",
		"恶水关能力：击败后获得20%攻击力（仅在念关使用",
		"受到恶水影响，攻击力降低20%"
	},
	{
		547001,
		4,
		{
			1
		},
		1004,
		"10:553001:10",
		9,
		4,
		4,
		"恶火",
		12033,
		"挑战规则：使用系统精灵破阵,五行相生相克",
		"恶火关能力：击败后获得30%暴击率（仅在念关使用",
		"受到恶火影响，暴击率降低30%"
	},
	{
		547001,
		5,
		{
			3
		},
		1004,
		"10:553001:10",
		10,
		5,
		5,
		"恶土",
		15037,
		"挑战规则：使用系统精灵破阵,五行相生相克",
		"恶土关能力：击败后获得20%闪避率（仅在念关使用",
		"受到恶土影响，命中率降低20%"
	}
}
local t_emperor_subdue_stage = {
	[547001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_emperor_subdue_stage.dataList = dataList

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

return t_emperor_subdue_stage
