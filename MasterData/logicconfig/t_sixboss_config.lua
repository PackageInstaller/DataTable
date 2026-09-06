-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sixboss_config.lua

module("logicconfig.config.t_sixboss_config", package.seeall)

local title = {
	recommendRaceId = 5,
	raceId = 2,
	id = 1,
	recommendLevel = 6,
	power = 4,
	recommendPower = 7,
	tip = 8,
	level = 3
}
local dataList = {
	{
		1,
		10127,
		100,
		8101,
		0,
		100,
		0,
		"水属性最强输出 连续斩杀            \n 感受极致战斗体验"
	},
	{
		2,
		10082,
		100,
		7801,
		10169,
		100,
		7301,
		"火属性羁绊的起始                  \n最后收割 战场之王"
	},
	{
		3,
		10083,
		100,
		7801,
		0,
		100,
		0,
		"值得信赖的草属性大哥              \n强力输出 攻守兼备"
	},
	{
		4,
		10099,
		100,
		8101,
		10019,
		100,
		7301,
		"草属性最强输出                    \n连续出手往死里打"
	},
	{
		5,
		10172,
		100,
		7601,
		0,
		100,
		0,
		"人狠话不多 开场就控制              \n大幅度削弱敌方攻击"
	},
	{
		6,
		10179,
		100,
		7601,
		0,
		100,
		0,
		"特殊技能 变身为对手              \n让对面自己打自己"
	}
}
local t_sixboss_config = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_sixboss_config.dataList = dataList

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

return t_sixboss_config
