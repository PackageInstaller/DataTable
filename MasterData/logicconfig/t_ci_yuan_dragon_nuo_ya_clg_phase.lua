-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_dragon_nuo_ya_clg_phase.lua

module("logicconfig.config.t_ci_yuan_dragon_nuo_ya_clg_phase", package.seeall)

local title = {
	openTime = 3,
	passPhaseScore = 4,
	phaseId = 2,
	prize = 5,
	title = 7,
	btlBalancePlans = 6,
	activityId = 1,
	desc = 8
}
local dataList = {
	{
		408001,
		1,
		"2024-10-11T05:00:00",
		18,
		"4:252:20",
		{
			1,
			4
		},
		"过去",
		"1.击败敌阵根据以下条件获得时间点数\r\n①每<color=#C54949>存活</color>1只<color=#C54949>光系精灵</color>+1点\r\n②1/2<color=#C54949>回合击败敌阵</color>+5点，3回合+4点，4回合及之后+3点\r\n2.次元龙皇诺亚作为助战精灵可以选择上阵\r\n3.敌阵<color=#C54949>每次出手</color>，会降低己阵5通灵点和受击精灵25气势\r\n4.敌阵<color=#C54949>首次死亡</color>，复活并恢复自身60%血量，并在下次出手前隐身"
	},
	{
		408001,
		2,
		"2024-10-12T05:00:00",
		32,
		"4:252:40",
		{
			1,
			2,
			4
		},
		"现在",
		"1.击败敌阵根据以下条件获得时间点数\r\n①每<color=#C54949>存活</color>1只<color=#C54949>光/暗系精灵</color>+1点\r\n②1/2<color=#C54949>回合击败敌阵</color>+5点，3回合+4点，4回合及之后+3点\r\n2.敌阵<color=#C54949>每次出手</color>，会降低己阵5通灵点和受击精灵25气势\r\n3.敌阵<color=#C54949>首次死亡</color>，复活并恢复自身60%血量，并在下次出手前隐身"
	},
	{
		408001,
		3,
		"2024-10-13T05:00:00",
		45,
		"4:252:60",
		{
			1,
			2,
			3,
			4
		},
		"未来",
		"1.击败敌阵根据以下条件获得时间点数\r\n①每<color=#C54949>存活</color>1只<color=#C54949>光/暗/空系精灵</color>+1点\r\n②1/2<color=#C54949>回合击败敌阵</color>+5点，3回合+4点，4回合及之后+3点\r\n2.阵亡精灵将被封印进<color=#C54949>次元时间</color>，本大关<color=#C54949>无法继续上阵</color>\r\n3.敌阵<color=#C54949>每次出手</color>，会降低己阵5通灵点和受击精灵25气势\r\n4.敌阵<color=#C54949>首次死亡</color>，复活并恢复自身60%血量，并在下次出手前隐身"
	}
}
local t_ci_yuan_dragon_nuo_ya_clg_phase = {
	[408001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ci_yuan_dragon_nuo_ya_clg_phase.dataList = dataList

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

return t_ci_yuan_dragon_nuo_ya_clg_phase
