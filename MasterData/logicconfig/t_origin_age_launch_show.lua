-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_age_launch_show.lua

module("logicconfig.config.t_origin_age_launch_show", package.seeall)

local title = {
	id = 2,
	desc = 5,
	showPlanId = 1,
	tag = 3,
	conUrl = 4
}
local dataList = {
	{
		1,
		1,
		2,
		"originage/board_yqsdzs_01",
		"版本全民活跃得9+红星"
	},
	{
		1,
		2,
		3,
		"originage/board_yqsdzs_02",
		"新时代诺亚、修尔全民得，送专属指定红星"
	},
	{
		1,
		3,
		2,
		"originage/board_yqsdzs_07",
		"龙宝集市回归，送通用红星自选（可选气贯星河）+随机红星+精灵+皮肤"
	},
	{
		1,
		4,
		3,
		"originage/board_yqsdzs_08",
		"时间之门神宠回归时间再调低，极限挑战由8个月调整为6个月，全民挑战由4个月调整为3个月"
	},
	{
		1,
		5,
		2,
		"originage/board_yqsdzs_09",
		"源起福利狂奔，送金钻特权，星神随心换升级，金星换红星，红星换红星，源起技养成材料加速"
	},
	{
		1,
		6,
		3,
		"originage/board_yqsdzs_12",
		"奖励调整"
	},
	{
		1,
		7,
		2,
		"originage/board_yqsdzs_03",
		"大神帮打回归"
	},
	{
		1,
		8,
		3,
		"originage/board_yqsdzs_04",
		"全民活跃得神曜诺雅阵"
	},
	{
		2,
		1,
		1,
		"originage/board_qsdcj_dhd_01",
		"精灵战力占比调整\r\n战力不变情况下，公共养成-图鉴部分占比有所下降，精灵自身养成占比增加（该调整不涉及源起前精灵）"
	},
	{
		2,
		2,
		1,
		"originage/board_qsdcj_dhd_02",
		"开放红色星神\r\n源起及之后时代精灵可装备红星，红星无条件卸下，卸下将变为专属红星只能给该精灵装备"
	},
	{
		3,
		1,
		2,
		"originage/board_yqsdzs_06",
		"新时代所有精灵均为源起精灵，无需养成潜能，潜能全部满级"
	},
	{
		3,
		2,
		3,
		"originage/board_yqsdzs_11",
		"使用泰坦残骸即可提升精灵基础属性、提升对应属性精灵的源起技"
	},
	{
		3,
		3,
		2,
		"originage/board_yqsdzs_10",
		"可自由组合源起技能，源起技能中有多个强化节点，可自由选择其中几个搭配上场"
	},
	{
		3,
		4,
		3,
		"originage/board_yqsdzs_05",
		"挑战/活动/神曜特典/至尊卡池获得源起材料；放入材料+特定精灵源起进化；放入前一态继承精灵觉醒和等级"
	},
	{
		4,
		1,
		2,
		"originage/board_yqsdzs_01",
		"版本全民活跃得9红星"
	},
	{
		4,
		2,
		3,
		"originage/board_yqsdzs_03",
		"大神帮打回归\r\n新增神曜通灵极挑战，龙脉诺亚挑战，神曜超神龙挑战，神曜无序挑战"
	},
	{
		4,
		3,
		2,
		"originage/board_qsdcj_hd_10",
		"邀好友拆福袋开启，指定红星自选（无气贯）、精灵、皮肤、养成道具福袋等你拆，自选2个奖励！"
	},
	{
		4,
		4,
		3,
		"originage/board_yqsdzs_08",
		"时间之门神宠回归\r\n神曜以撒/音织/空灵圣龙/神曜玄冥天龙/神曜龙女"
	},
	{
		5,
		1,
		1,
		"originage/board_qsdcj_dhd_03",
		"精灵王之路\r\n全新新手教程开启，解锁最全战斗教程，轻松得全民昆仑阵\r\n昆仑、阿瑞斯神曜材料、龙主、王者极、秩序龙、艾希、青骨"
	},
	{
		5,
		2,
		1,
		"originage/board_qsdcj_dhd_04",
		"活跃得通灵极阵\r\n参与运营活动即可得全民通灵极阵"
	}
}
local t_origin_age_launch_show = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20]
	}
}

t_origin_age_launch_show.dataList = dataList

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

return t_origin_age_launch_show
