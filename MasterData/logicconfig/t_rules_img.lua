-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rules_img.lua

module("logicconfig.config.t_rules_img", package.seeall)

local title = {
	id = 2,
	key = 1,
	desc = 4,
	url = 3
}
local dataList = {
	{
		"freescuffle",
		1,
		"ui/bigbg/aoqiattackforce/board_ziyouluandou_guizhe1.png",
		""
	},
	{
		"freescuffle",
		2,
		"ui/bigbg/aoqiattackforce/board_ziyouluandou_guizhe2.png",
		""
	},
	{
		"freescuffle",
		3,
		"ui/bigbg/aoqiattackforce/board_ziyouluandou_guizhe3.png",
		""
	},
	{
		"freescuffle",
		4,
		"ui/bigbg/aoqiattackforce/board_ziyouluandou_guizhe4.png",
		""
	},
	{
		"defendcarrotgameview_1",
		1,
		"ui/bigbg/views/baoweiaoqi/board_defendcarrot_rule2.png",
		"保卫奥奇关卡中，右上角三个按钮分别为：额外任务、特殊格子、暂停。中央显示为当前波次/本关总恶灵波次。另外，点击指定恶灵可将其选中，武器将优先攻击此恶灵。"
	},
	{
		"defendcarrotgameview_1",
		2,
		"ui/bigbg/views/baoweiaoqi/board_defendcarrot_rule1.png",
		"保卫奥奇关卡中，有特殊格子，将对应的武器布置在特殊格子上，将获得一定加成。特殊格子未布置指定武器时会显示半透明的武器图标，若布置了非指定武器，外围光圈将置灰。"
	},
	{
		"defendcarrotgameview_2",
		1,
		"ui/bigbg/views/baoweiaoqi/board_defendcarrot_rule3.png",
		"资源关卡有倒计时，倒计时结束或中途退出都将扣除游戏次数。关卡内会显示当前累计的波次奖励。"
	},
	{
		"defendcarrotgameview_2",
		2,
		"ui/bigbg/views/baoweiaoqi/board_defendcarrot_rule4.png",
		"资源关卡可上阵所有武器。波次奖励计算举例：若当前攻打至第12波恶灵，但尚未打完，则当前共打通了11波，累计奖励为100*4+150*5+200*2。"
	},
	{
		"originmaterialgamerule",
		1,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_06.png",
		"击杀怪物可获得资源，用于升级武器，提升武器伤害，出售武器可返还部分资源，武器等级在退出战斗后重置"
	},
	{
		"originmaterialgamerule",
		2,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_04.png",
		"击杀怪物可获得祝福值，祝福值满后可获得1个祝福，提升武器伤害，获得数量达到上限后不再刷新新的祝福，点击左侧武器图标可以查看当前每个武器激活的祝福"
	},
	{
		"originmaterialgamerule",
		3,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_05.png",
		"只会刷出开局时所选武器专属的祝福，请选择其中一个激活，<color=#C54949>祝福只对指定的武器生效</color>，选择时请注意查看下方的武器类型"
	},
	{
		"originmaterialgamerule",
		4,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_07.png",
		"怪物波次结束，或者奥奇血量为0时，战斗结束"
	},
	{
		"originmaterialgamerule",
		5,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_08.png",
		"记录本次战斗波次，若本轮战斗波次高于历史最高，则自动刷新记录，所有关卡累积最高波次达标后，可领取对应档位的赛季奖励"
	},
	{
		"pic_rule_survival_king",
		1,
		"ui/bigbg/views/survivalking/board_shengcunzhiwang_guize01.png",
		"设置每个轮次的布阵后，在右侧选择报名场次、设置每次战斗需要使用的增益Bufff。注意非报名时间段无法调整布阵和Buff噢！"
	},
	{
		"pic_rule_survival_king",
		2,
		"ui/bigbg/views/survivalking/board_shengcunzhiwang_guize02.png",
		"布阵中，1-2轮共用血量、3-4轮共用血量，若战斗时精灵存活数量不足/血量为0，则将直接淘汰无法进入后续轮次。"
	},
	{
		"pic_rule_survival_king",
		3,
		"ui/bigbg/views/survivalking/board_shengcunzhiwang_guize03.png",
		"可以购买南瓜炸弹给自己提供增益，设置后需要有库存才可生效，未进入的轮次即使设置了也不会扣除。"
	},
	{
		"pic_rule_survival_king",
		4,
		"ui/bigbg/views/survivalking/board_shengcunzhiwang_guize04.png",
		"每日可获得奖励的场次有限，报名时需要仔细斟酌！超出奖励次数的报名将无法获得奖励。"
	},
	{
		"elf_king_path_rule_1_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize01.png",
		"1、九宫格站位均有固定编号，敌我双方的编号为镜像\r\n2、战斗开始时，双方精灵总速度较高的一方现先出手，按各自的编号从1~9依次轮流出手"
	},
	{
		"elf_king_path_rule_1_1",
		2,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize04.png",
		"1、战斗中，血条下方为怒气条，怒气满后，下次出手将消耗全部怒气释放超杀\r\n2、精灵初始为0气势，普攻加50气势，受击加20气势。"
	},
	{
		"elf_king_path_rule_1_2",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize02.png",
		"奥奇大陆的精灵都有属性，可在属性克制窗口查看具体属性克制关系，利用克制关系打出更高伤害"
	},
	{
		"elf_king_path_rule_1_2",
		2,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize03.png",
		"拖动精灵上阵时，若有克制关系，敌阵精灵灰显示对应的克制与被克的提示标签"
	},
	{
		"elf_king_path_rule_1_2",
		3,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize20.png",
		"<color=#C54949>源属性</color>精灵在布阵时可自由更改为任意属性，点击头像点开转换弹窗操作"
	},
	{
		"elf_king_path_rule_2_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize05.png",
		"1、召唤师拥有职业技能“召唤技”，可在战斗中召唤一只契约兽协同作战\r\n2、上阵后，在左侧点击【召唤师】按钮可查看阵上召唤师与契约兽的情况"
	},
	{
		"elf_king_path_rule_2_1",
		2,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize06.png",
		"1、战斗中只能选择一只召唤师生效，每位召唤师拥有多只契约精灵，精灵背包查看详情\r\n2、召唤师可召唤一只契约精灵上阵，契约精灵拥有契约技，在精灵背包处修改"
	},
	{
		"elf_king_path_rule_3_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize07.png",
		"1、英雄职业拥有“英雄技”，满足指定条件即可激活，全阵精灵获得强大的增益效果\r\n2、点开英雄技的tips即可查看具体的英雄技激活条件和效果"
	},
	{
		"elf_king_path_rule_3_1",
		2,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize08.png",
		"1、激活英雄技后，左侧的上阵效果按钮将显示英雄精灵的头像\r\n2、点击【上阵效果】按钮即可查看详情"
	},
	{
		"elf_king_path_rule_3_1",
		3,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize09.png",
		"1、上阵多位英雄职业精灵可激活多个英雄技，但只能选择其中之一生效"
	},
	{
		"elf_king_path_rule_4_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize10.png",
		"1、元素师拥有“元素技”，可选定己阵一只精灵，转化为与自身相同的属性\r\n2、上阵元素师后，左侧【元素师】按钮将亮起，点击进行属性转化"
	},
	{
		"elf_king_path_rule_4_1",
		2,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize11.png",
		"1、可上阵多只元素师精灵，但只能选择一只生效\r\n2、右侧选择当前阵上需要转化属性的精灵"
	},
	{
		"elf_king_path_rule_5_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize13.png",
		"1、通灵师拥有“通灵技”，战斗中满足特定的条件可获得通灵进度，进度满后可触发通灵技，变身为更强的形态，上阵通灵师后，左侧【通灵技】按钮将亮起，点击选择生效的通灵师"
	},
	{
		"elf_king_path_rule_5_1",
		2,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize14.png",
		"1、可上阵多只通灵师，但只能选择一只生效\r\n2、根据通灵进度的获得条件，多上阵满足条件的精灵，加速通灵师通灵"
	},
	{
		"elf_king_path_rule_5_1",
		3,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize15.png",
		"1、战斗中满足指定条件可获得通灵进度，进度满后触发通灵\r\n2、通灵后变身为通灵态，获得通灵加成，强化技能"
	},
	{
		"elf_king_path_rule_6_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize16.png",
		"圣骑神曜技均可为敌方添加标记，标记有不同效果，在标记达到对应层数时均可被神曜圣骑队的精灵消除并触发额外效果"
	},
	{
		"elf_king_path_rule_7_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize17.png",
		"神曜伏妖阵，利用神曜路西法、神曜余灰和神曜伏妖神曜技快速控制敌方精灵，使得伏妖快速通灵"
	},
	{
		"elf_king_path_rule_8_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize18.png",
		"神曜无敌阵，利用神曜王者诺雅、斐希司和凡尔维斯进行群攻输出，给无敌进行快速通灵收割"
	},
	{
		"elf_king_path_rule_9_1",
		1,
		"ui/bigbg/elfkingpath/board_jinglingwangzhilu_guize19.png",
		"神曜昆仑阵，使用神曜王者极英雄技，神曜龙主契约神曜双生龙，配合路因加德出手使得神曜昆仑快速通灵"
	},
	{
		"yearcardlottery2026_1",
		1,
		"ui/bigbg/nf2026/board_nianfeiguize_01.png",
		"精灵背包专属外框"
	},
	{
		"yearcardlottery2026_2",
		1,
		"ui/bigbg/nf2026/board_nianfeiguize_02.png",
		"布阵界面专属头像框"
	},
	{
		"yearcardpreheathud2026_1",
		1,
		"ui/bigbg/nf2026/board_tc_465.png",
		"年费技能展示：被动、普攻、超杀"
	},
	{
		"yearcardpreheathud2026_1",
		2,
		"ui/bigbg/nf2026/board_tc_466.png",
		"年费技能展示：创世技"
	},
	{
		"yearcardpreheathud2026_1",
		3,
		"ui/bigbg/nf2026/board_tc_467.png",
		"年费技能展示：源起技"
	},
	{
		"emperor_subdue_pic_rule_key",
		1,
		"ui/bigbg/views/emperorsubdue/board_dihuangxiangmo_05.png",
		""
	},
	{
		"bieyoudongtian_pic_rule_1",
		1,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_06.png",
		"进入地图搜刮矿物、宝箱，获得物资后前往商店招募精灵"
	},
	{
		"bieyoudongtian_pic_rule_2",
		2,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_04.png",
		"击败守卫、清空时间即可找到通往下一层的入口"
	},
	{
		"bieyoudongtian_pic_rule_3",
		3,
		"ui/bigbg/views/orimatgame/board_xinshidaiwanfa_05.png",
		"跟人物对话可获得不同增益，使用道具可以辅助战斗胜利"
	},
	{
		"fishing_game_pic_rule_1",
		1,
		"ui/bigbg/views/fishinggame/bg_diaoyuxiaoyouxi_tc.png",
		"不同鱼类/宝箱/水草等说明"
	},
	{
		"pantaofeast_pic_rule",
		1,
		"ui/bigbg/views/pantaofeast/board_pantaoshengyan_rule_1.png",
		"1、将物品拖拽至冰箱处松手，即可将多余物品储存进去；2、将一个食材拖拽至另一相同食材处松手，即可将其升1级变为新食材，同时可以解冻被冰冻住的食材；3、左上角带“黄色闪电”角标的，即为生产工具，每次点击扣除1点体力，产出1种食材"
	}
}
local t_rules_img = {
	freescuffle = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	defendcarrotgameview_1 = {
		dataList[5],
		dataList[6]
	},
	defendcarrotgameview_2 = {
		dataList[7],
		dataList[8]
	},
	originmaterialgamerule = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13]
	},
	pic_rule_survival_king = {
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17]
	},
	elf_king_path_rule_1_1 = {
		dataList[18],
		dataList[19]
	},
	elf_king_path_rule_1_2 = {
		dataList[20],
		dataList[21],
		dataList[22]
	},
	elf_king_path_rule_2_1 = {
		dataList[23],
		dataList[24]
	},
	elf_king_path_rule_3_1 = {
		dataList[25],
		dataList[26],
		dataList[27]
	},
	elf_king_path_rule_4_1 = {
		dataList[28],
		dataList[29]
	},
	elf_king_path_rule_5_1 = {
		dataList[30],
		dataList[31],
		dataList[32]
	},
	elf_king_path_rule_6_1 = {
		dataList[33]
	},
	elf_king_path_rule_7_1 = {
		dataList[34]
	},
	elf_king_path_rule_8_1 = {
		dataList[35]
	},
	elf_king_path_rule_9_1 = {
		dataList[36]
	},
	yearcardlottery2026_1 = {
		dataList[37]
	},
	yearcardlottery2026_2 = {
		dataList[38]
	},
	yearcardpreheathud2026_1 = {
		dataList[39],
		dataList[40],
		dataList[41]
	},
	emperor_subdue_pic_rule_key = {
		dataList[42]
	},
	bieyoudongtian_pic_rule_1 = {
		dataList[43]
	},
	bieyoudongtian_pic_rule_2 = {
		[2] = dataList[44]
	},
	bieyoudongtian_pic_rule_3 = {
		[3] = dataList[45]
	},
	fishing_game_pic_rule_1 = {
		dataList[46]
	},
	pantaofeast_pic_rule = {
		dataList[47]
	}
}

t_rules_img.dataList = dataList

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

return t_rules_img
