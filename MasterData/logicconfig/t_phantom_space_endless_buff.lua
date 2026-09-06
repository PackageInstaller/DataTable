-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_phantom_space_endless_buff.lua

module("logicconfig.config.t_phantom_space_endless_buff", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		516003,
		2,
		"敌阵全属性+<color=#20b376>10%</color>"
	},
	{
		516003,
		4,
		"敌阵全属性+<color=#20b376>30%</color>"
	},
	{
		516003,
		6,
		"敌阵全属性+<color=#20b376>50%</color>"
	},
	{
		516003,
		8,
		"敌阵全属性+<color=#20b376>100%</color>"
	},
	{
		516003,
		10,
		"敌阵全属性+<color=#20b376>150%</color>"
	},
	{
		516003,
		12,
		"敌阵全属性+<color=#20b376>200%</color>"
	},
	{
		516003,
		14,
		"敌阵全属性+<color=#20b376>250%</color>"
	},
	{
		516003,
		16,
		"敌阵全属性+<color=#20b376>300%</color>"
	},
	{
		516003,
		18,
		"敌阵全属性+<color=#20b376>500%</color>"
	},
	{
		516003,
		20,
		"敌阵全属性+<color=#20b376>800%</color>"
	},
	{
		516003,
		22,
		"敌阵全属性+<color=#20b376>1000%</color>"
	},
	{
		516003,
		24,
		"敌阵全属性+<color=#20b376>1200%</color>"
	},
	{
		516004,
		2,
		"敌阵全属性+<color=#20b376>10%</color>"
	},
	{
		516004,
		4,
		"敌阵全属性+<color=#20b376>30%</color>"
	},
	{
		516004,
		6,
		"敌阵全属性+<color=#20b376>50%</color>"
	},
	{
		516004,
		8,
		"敌阵全属性+<color=#20b376>100%</color>"
	},
	{
		516004,
		10,
		"敌阵全属性+<color=#20b376>150%</color>"
	},
	{
		516004,
		12,
		"敌阵全属性+<color=#20b376>200%</color>"
	},
	{
		516004,
		14,
		"敌阵全属性+<color=#20b376>250%</color>"
	},
	{
		516004,
		16,
		"敌阵全属性+<color=#20b376>300%</color>"
	},
	{
		516004,
		18,
		"敌阵全属性+<color=#20b376>500%</color>"
	},
	{
		516004,
		20,
		"敌阵全属性+<color=#20b376>800%</color>"
	},
	{
		516004,
		22,
		"敌阵全属性+<color=#20b376>1000%</color>"
	},
	{
		516004,
		24,
		"敌阵全属性+<color=#20b376>1200%</color>"
	},
	{
		516004,
		30,
		"敌阵全属性+<color=#20b376>1500%</color>"
	},
	{
		516004,
		35,
		"敌阵全属性+<color=#20b376>2000%</color>"
	},
	{
		516004,
		40,
		"敌阵全属性+<color=#20b376>2500%</color>"
	},
	{
		516004,
		45,
		"敌阵全属性+<color=#20b376>3000%</color>且首次死亡时复活并恢复30%生命值"
	},
	{
		516004,
		55,
		"敌阵全属性+<color=#20b376>4000%</color>且首次死亡时复活并恢复30%生命值"
	}
}
local t_phantom_space_endless_buff = {
	[516003] = {
		[2] = dataList[1],
		[4] = dataList[2],
		[6] = dataList[3],
		[8] = dataList[4],
		[10] = dataList[5],
		[12] = dataList[6],
		[14] = dataList[7],
		[16] = dataList[8],
		[18] = dataList[9],
		[20] = dataList[10],
		[22] = dataList[11],
		[24] = dataList[12]
	},
	[516004] = {
		[2] = dataList[13],
		[4] = dataList[14],
		[6] = dataList[15],
		[8] = dataList[16],
		[10] = dataList[17],
		[12] = dataList[18],
		[14] = dataList[19],
		[16] = dataList[20],
		[18] = dataList[21],
		[20] = dataList[22],
		[22] = dataList[23],
		[24] = dataList[24],
		[30] = dataList[25],
		[35] = dataList[26],
		[40] = dataList[27],
		[45] = dataList[28],
		[55] = dataList[29]
	}
}

t_phantom_space_endless_buff.dataList = dataList

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

return t_phantom_space_endless_buff
