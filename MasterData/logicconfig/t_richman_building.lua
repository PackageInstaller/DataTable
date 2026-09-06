-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_richman_building.lua

module("logicconfig.config.t_richman_building", package.seeall)

local title = {
	itemKey = 7,
	srcPlanId = 8,
	name = 3,
	type = 4,
	limit = 6,
	initPos = 5,
	bid = 2,
	desc = 10,
	buffPlanId = 9,
	scenePrefabPath = 11,
	bPlanId = 1,
	viewPath = 12,
	trigger = 13
}
local dataList = {
	{
		1,
		1,
		"神龙宫殿",
		1,
		72,
		0,
		"",
		0,
		0,
		"处于奥奇神龙岛的神龙宫殿，是控制这片广阔空间的主要场所。核心功能在于限制其他建筑的最高等级，并为其他资源建筑提高收益加成\r\n\r\n等级1：提高全体资源建筑的收益加成1%\r\n等级2：提高全体资源建筑的收益加成1.5%\r\n等级3：提高全体资源建筑的收益加成2%\r\n等级4：提高全体资源建筑的收益加成2.5%\r\n等级5：提高全体资源建筑的收益加成3%\r\n等级6：提高全体资源建筑的收益加成4%\r\n等级7：提高全体资源建筑的收益加成5%\r\n等级8：提高全体资源建筑的收益加成6%\r\n等级9：提高全体资源建筑的收益加成7%\r\n等级10：提高全体资源建筑的收益加成8%\r\n等级11：提高全体资源建筑的收益加成9%\r\n等级12：提高全体资源建筑的收益加成10%",
		"zhucheng",
		"zhucheng",
		""
	},
	{
		1,
		2,
		"幸运之泉",
		2,
		10,
		0,
		"",
		0,
		0,
		"幸运之泉，流淌着幸运之水，玩家踩上去后，将获得<color=#C54949>1</color>个额外的<color=#C54949>普通骰子</color>（可超过上限）",
		"penquan_01",
		"penquan_01",
		"AddRoll"
	},
	{
		1,
		3,
		"怒气之泉",
		2,
		6,
		0,
		"",
		0,
		0,
		"怒气之泉，迸发着怒气的泉水，玩家踩上去后，为下次入侵提供<color=#C54949>额外资源收益</color>",
		"penquan_02",
		"penquan_02",
		"AttackAwardAddition"
	},
	{
		1,
		4,
		"思考之泉",
		2,
		64,
		0,
		"",
		0,
		0,
		"思考之泉，流淌着智慧的泉水，玩家踩上去后，能为下一次建筑等级<color=#C54949>额外加1级</color>",
		"penquan_03",
		"penquan_03",
		"NextUpgrade"
	},
	{
		1,
		5,
		"建筑之泉",
		2,
		126,
		0,
		"",
		0,
		0,
		"建筑之泉，充满着各种奇思妙想的建筑的思想，玩家踩上去后<color=#C54949>额外增加1次地图编辑次数</color>",
		"penquan_04",
		"penquan_04",
		"AddMapEdit"
	},
	{
		1,
		6,
		"命运之泉",
		2,
		130,
		0,
		"",
		0,
		0,
		"命运之泉，流淌着决定命运的水花，玩家踩上去后，将获得<color=#C54949>1</color>个额外的<color=#C54949>固定骰子</color>（可超过上限）",
		"penquan_05",
		"penquan_05",
		"AddFixedRoll"
	},
	{
		1,
		7,
		"金币矿场",
		3,
		0,
		6,
		"8:1",
		1,
		0,
		"叮咚叮咚，里面生产的东西是在奥奇大陆流通的通用货币-<color=#C54949>金币</color>",
		"zhuzaochang_jinbi",
		"zhuzaochang_jinbi",
		""
	},
	{
		1,
		8,
		"灵纹矿场",
		3,
		0,
		1,
		"4:30004",
		2,
		0,
		"叮咚叮咚，里面生产的东西是在奥奇大陆流通的珍稀道具-<color=#C54949>灵纹经验</color>",
		"zhuzaochang_lingwen",
		"zhuzaochang_lingwen",
		""
	},
	{
		1,
		9,
		"精华矿场",
		3,
		0,
		3,
		"10:230002",
		3,
		0,
		"叮咚叮咚，里面生产的东西是在奥奇大陆流通的新货币-<color=#C54949>龙鳞精华</color>，可用于本次活动的兑换哦",
		"zhuzaochang_daibi",
		"zhuzaochang_daibi",
		""
	},
	{
		1,
		10,
		"属性水晶",
		4,
		0,
		1,
		"",
		0,
		1,
		"发动入侵时，提供入侵队伍<color=#C54949>全属性加成</color>的效果",
		"yuansuta_01",
		"yuansuta_01",
		""
	},
	{
		1,
		11,
		"无视水晶",
		4,
		0,
		1,
		"",
		0,
		2,
		"发动入侵时，提供入侵队伍<color=#C54949>全员攻击无视防御</color>的效果",
		"yuansuta_02",
		"yuansuta_02",
		""
	},
	{
		1,
		12,
		"暴击水晶",
		4,
		0,
		1,
		"",
		0,
		3,
		"发动入侵时，提供入侵队伍<color=#C54949>增加全体暴击率</color>的效果",
		"yuansuta_03",
		"yuansuta_03",
		""
	},
	{
		1,
		13,
		"攻击水晶",
		4,
		0,
		1,
		"",
		0,
		4,
		"发动入侵时，提供入侵队伍<color=#C54949>增加攻击力</color>的效果",
		"yuansuta_04",
		"yuansuta_04",
		""
	},
	{
		1,
		14,
		"生命基地",
		5,
		0,
		2,
		"",
		0,
		5,
		"被敌方入侵时，队伍精灵增加<color=#C54949>全体生命上限</color>（作用在周边两个格子的守军队伍）",
		"fangyuta_04",
		"fangyuta_04",
		""
	},
	{
		1,
		15,
		"防御基地",
		5,
		0,
		2,
		"",
		0,
		6,
		"被敌方入侵时，队伍精灵增加<color=#C54949>全体精灵防御</color>（作用在周边两个格子的守军队伍）",
		"fangyuta_01",
		"fangyuta_01",
		""
	},
	{
		1,
		16,
		"护盾基地",
		5,
		0,
		2,
		"",
		0,
		7,
		"被敌方入侵时，队伍精灵将入场<color=#C54949>获得自身血量的护盾</color>（作用在周边两个格子的守军队伍）",
		"fangyuta_02",
		"fangyuta_02",
		""
	}
}
local t_richman_building = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_richman_building.dataList = dataList

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

return t_richman_building
