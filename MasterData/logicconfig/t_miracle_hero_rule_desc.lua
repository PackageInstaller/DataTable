-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_hero_rule_desc.lua

module("logicconfig.config.t_miracle_hero_rule_desc", package.seeall)

local title = {
	id = 2,
	desc = 4,
	activityId = 1,
	url = 3
}
local dataList = {
	{
		383003,
		1,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize01.png",
		"使用小五王通关挑战后可将其进化为勇士态，最终去挑战女巫与恶龙，帮助末炎完成蜕变吧！推荐通关顺序：火草光水暗。"
	},
	{
		383003,
		2,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize05.png",
		"在我的队伍界面，点击阵容槽位，即可为<color=#c54949>指定的阵容槽位</color>进行升级，<color=#c54949>卡片位置更换不影响槽位等级</color>。挑战本活动中的关卡成功后，可获得升级槽位所需消耗的红莲精华。\r\n<color=#c54949>建议平均升级各个槽位哦！</color>助战卡片不可升级。"
	},
	{
		383003,
		3,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize02.png",
		"在布阵界面可查看阵容信息。顶部为双方阵容速度，速度值高的一方先手。\r\n阵上的卡片为精灵卡片，按住拖动可调换位置。左下角卡片为助战卡片。\r\n战斗技能处的类型为此卡片的攻击对象，非己身的推荐站位。"
	},
	{
		383003,
		4,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize03.png",
		"战斗界面中下方为元素栏，<color=#c54949>按住元素拖动选中相同颜色的元素</color>，松手后消除，即可使<color=#c54949>对应系别卡片</color>出手。消除1-3个同色元素可释放普攻，4-20个可释放超杀，并根据消除的元素数量获得对应的伤害加成。如：消除3个元素可造成普攻伤害*2的最终伤害。"
	},
	{
		383003,
		5,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize04.png",
		"在战斗界面中，顶部为回合信息展示；右上角为自动按钮；点击卡片后弹出的tips中，会显示卡片当前的增益/减益效果；敌阵血条上方的数字为此卡片的<color=#c54949>出手顺序</color>；怒气达标后，点击助战卡片左侧技能按钮即可释放助战技。"
	},
	{
		383002,
		1,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize05.png",
		"在我的队伍界面，点击阵容槽位，即可为<color=#c54949>指定的阵容槽位</color>进行升级，<color=#c54949>卡片位置更换不影响槽位等级</color>。挑战本活动中的关卡成功后，可获得升级槽位所需消耗的奇迹之力。\r\n<color=#c54949>建议平均升级各个槽位哦！</color>助战卡片不可升级。"
	},
	{
		383002,
		2,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize02.png",
		"在布阵界面可查看阵容信息。顶部为双方阵容速度，速度值高的一方先手。\r\n阵上的卡片为精灵卡片，按住拖动可调换位置。左下角卡片为助战卡片。\r\n战斗技能处的类型为此卡片的攻击对象，非己身的推荐站位。"
	},
	{
		383002,
		3,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize03.png",
		"战斗界面中下方为元素栏，<color=#c54949>按住元素拖动选中相同颜色的元素</color>，松手后消除，即可使<color=#c54949>对应系别卡片</color>出手。消除1-3个同色元素可释放普攻，4-20个可释放超杀，并根据消除的元素数量获得对应的伤害加成。如：消除3个元素可造成普攻伤害*2的最终伤害。"
	},
	{
		383002,
		4,
		"ui/bigbg/views/qijiyongzhe/board_qjyzwanfa_guize04.png",
		"在战斗界面中，顶部为回合信息展示；右上角为自动按钮；点击卡片后弹出的tips中，会显示卡片当前的增益/减益效果；敌阵血条上方的数字为此卡片的<color=#c54949>出手顺序</color>；怒气达标后，点击助战卡片左侧技能按钮即可释放助战技。"
	}
}
local t_miracle_hero_rule_desc = {
	[383003] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[383002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_miracle_hero_rule_desc.dataList = dataList

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

return t_miracle_hero_rule_desc
