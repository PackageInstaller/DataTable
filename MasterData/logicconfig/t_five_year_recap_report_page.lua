-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_report_page.lua

module("logicconfig.config.t_five_year_recap_report_page", package.seeall)

local title = {
	noDataDesc = 7,
	pos = 5,
	barId = 3,
	cellName = 4,
	pageId = 2,
	activityId = 1,
	adapterFormat = 6
}
local dataList = {
	{
		586001,
		1,
		1,
		"cell_normal",
		{
			-145,
			184
		},
		{
			txtDesc = "五载江湖路，一剑踏山河。"
		},
		""
	},
	{
		586001,
		1,
		2,
		"cell_normal",
		{
			291,
			100.5
		},
		{
			txtDesc = "你已从懵懂萌新，蜕变为独当一面的江湖侠客。"
		},
		""
	},
	{
		586001,
		1,
		3,
		"cell_normal",
		{
			-160,
			-0.4
		},
		{
			txtDesc = "每一步成长，都镌刻成独属于你的江湖印记。"
		},
		""
	},
	{
		586001,
		1,
		4,
		"cell_normal",
		{
			291,
			-107
		},
		{
			txtDesc = "且看这五载修行根基，细数那些硬核数据，"
		},
		""
	},
	{
		586001,
		1,
		5,
		"cell_normal",
		{
			-175,
			-208
		},
		{
			txtDesc = "见证你初心不改的江湖岁月。"
		},
		""
	},
	{
		586001,
		2,
		1,
		"cell_normal",
		{
			291,
			100.5
		},
		{
			txtDesc = "最早踏足江湖时辰：<color=#d56d08>{DateTime$2}</color>"
		},
		"暂无最早登录时间记录"
	},
	{
		586001,
		2,
		2,
		"cell_normal",
		{
			-160,
			-0.4
		},
		{
			txtDesc = "最晚留恋江湖时辰：<color=#d56d08>{DateTime$3}</color>"
		},
		"暂无最晚登录时间记录"
	},
	{
		586001,
		2,
		3,
		"cell_normal",
		{
			291,
			-107
		},
		{
			txtDesc = "五载累计闯荡江湖<color=#d56d08>{DataId$4}</color>天\n超过了全服{RankRatio$1#4}的玩家"
		},
		"暂无登录天数记录"
	},
	{
		586001,
		2,
		4,
		"cell_normal",
		{
			-175,
			-208
		},
		{
			txtDesc = "最高连续坚守江湖<color=#d56d08>{DataId$5}</color>天\n超过了全服{RankRatio$2#5}的玩家"
		},
		"暂无连续登录记录"
	},
	{
		586001,
		3,
		1,
		"cell_normal",
		{
			-59,
			108
		},
		{
			txtDesc = "当前修行巅峰战力<color=#d56d08>{DataId$13}</color>\n超过了全服{RankRatio$3#13}的玩家"
		},
		"暂无战力数据记录"
	},
	{
		586001,
		3,
		2,
		"cell_normal",
		{
			202,
			-97
		},
		{
			txtDesc = "精灵榜单获得的最高排位是：<color=#d56d08>{DataId$15}</color>"
		},
		"暂无榜单排名记录"
	},
	{
		586001,
		4,
		1,
		"cell_item",
		{
			-183,
			176
		},
		{
			item = "8:1",
			txtDesc = "当前坐拥金币\n<color=#d56d08>{DataId$6}</color>"
		},
		"暂无金币数据记录"
	},
	{
		586001,
		4,
		2,
		"cell_item",
		{
			279,
			78
		},
		{
			item = "104:2",
			txtDesc = "累计斩获钻石\n<color=#d56d08>{DataId$7}</color>"
		},
		"暂无钻石获取记录"
	},
	{
		586001,
		4,
		3,
		"cell_item",
		{
			-183,
			-64
		},
		{
			item = "4:70003",
			txtDesc = "累计获得传说之魂\n<color=#d56d08>{DataId$8}</color>"
		},
		"暂无传说魂记录"
	},
	{
		586001,
		4,
		4,
		"cell_item",
		{
			292,
			-191
		},
		{
			item = "4:90514",
			txtDesc = "当前持有坐骑为\n<color=#d56d08>{DataId$9}</color>"
		},
		"暂无坐骑拥有记录"
	},
	{
		586001,
		5,
		1,
		"cell_item",
		{
			-183,
			176
		},
		{
			item = "4:410002",
			txtDesc = "累计获得红色星神\n<color=#d56d08>{DataId$11}</color>"
		},
		"暂无红色星神记录"
	},
	{
		586001,
		5,
		2,
		"cell_item",
		{
			35,
			-17
		},
		{
			item = "4:60005",
			txtDesc = "累计获得金色星神\n<color=#d56d08>{DataId$10}</color>"
		},
		"暂无金色星神记录"
	},
	{
		586001,
		5,
		3,
		"cell_item",
		{
			292,
			-191
		},
		{
			item = "104:2",
			txtDesc = "累计消耗钻石\n<color=#d56d08>{DataId$12}</color>"
		},
		"暂无钻石消耗记录"
	},
	{
		586001,
		6,
		1,
		"cell_pet",
		{
			-137,
			139
		},
		{
			petId = "DataId$14",
			txtDesc = "<color=#d56d08>{PetName$14}</color>是战力最高精灵"
		},
		"暂无本命精灵记录"
	},
	{
		586001,
		6,
		2,
		"cell_pet",
		{
			244,
			-85
		},
		{
			petId = "DataId$16",
			txtDesc = "<color=#d56d08>{PetName$16}</color>精灵榜排行最高"
		},
		"暂无霸榜精灵记录"
	},
	{
		586001,
		7,
		1,
		"cell_normal",
		{
			-145,
			184
		},
		{
			txtDesc = "每一笔花销都是对江湖热爱的馈赠，"
		},
		""
	},
	{
		586001,
		7,
		2,
		"cell_normal",
		{
			291,
			100.5
		},
		{
			txtDesc = "每一次投入都是为登顶巅峰蓄力，"
		},
		""
	},
	{
		586001,
		7,
		3,
		"cell_normal",
		{
			-160,
			-0.4
		},
		{
			txtDesc = "从年费尊享到月卡加持，从神钻花销到好物抢购，"
		},
		""
	},
	{
		586001,
		7,
		4,
		"cell_normal",
		{
			291,
			-107
		},
		{
			txtDesc = "尽显侠客洒脱本色，这便是你独有的江湖消费传奇。"
		},
		""
	},
	{
		586001,
		8,
		1,
		"cell_normal",
		{
			-157,
			167
		},
		{
			txtDesc = "五载江湖累计充值了<color=#d56d08>{DataId$17}</color>盘缠"
		},
		"暂无充值记录"
	},
	{
		586001,
		8,
		2,
		"cell_normal",
		{
			83,
			12
		},
		{
			txtDesc = "招募精灵消耗神钻<color=#d56d08>{DataId$21}</color>\n超过了全服{RankRatio$4#21}的玩家"
		},
		"暂无精灵招募记录"
	},
	{
		586001,
		8,
		3,
		"cell_normal",
		{
			303,
			-143
		},
		{
			txtDesc = "五载招募精灵总次数：<color=#d56d08>{DataId$22}</color>"
		},
		"暂无精灵招募记录"
	},
	{
		586001,
		9,
		1,
		"cell_normal",
		{
			-163,
			183
		},
		{
			txtDesc = "购置皮肤消耗神钻<color=#d56d08>{DataId$23}</color>\n超过了全服{RankRatio$5#23}的玩家"
		},
		"暂无皮肤购买记录"
	},
	{
		586001,
		9,
		2,
		"cell_normal",
		{
			229,
			66
		},
		{
			txtDesc = "五载购置皮肤总次数：<color=#d56d08>{DataId$24}</color>"
		},
		"暂无皮肤购买记录"
	},
	{
		586001,
		9,
		3,
		"cell_normal",
		{
			-163,
			-68
		},
		{
			txtDesc = "皮肤祈愿消耗神钻<color=#d56d08>{DataId$25}</color>\n超过了全服{RankRatio$6#25}的玩家"
		},
		"暂无皮肤祈愿记录"
	},
	{
		586001,
		9,
		4,
		"cell_normal",
		{
			229,
			-192
		},
		{
			txtDesc = "五载皮肤祈愿总次数：<color=#d56d08>{DataId$26}</color>"
		},
		"暂无皮肤祈愿记录"
	},
	{
		586001,
		10,
		1,
		"cell_normal",
		{
			-157,
			167
		},
		{
			txtDesc = "累计购置普通月卡<color=#d56d08>{DataId$33}</color>次"
		},
		"暂无普通月卡记录"
	},
	{
		586001,
		10,
		2,
		"cell_normal",
		{
			83,
			12
		},
		{
			txtDesc = "累计购置回归月卡<color=#d56d08>{DataId$34}</color>次"
		},
		"暂无回归月卡记录"
	},
	{
		586001,
		10,
		3,
		"cell_normal",
		{
			303,
			-143
		},
		{
			txtDesc = "累计购置暴击版月卡<color=#d56d08>{DataId$35}</color>次"
		},
		"暂无暴击月卡记录"
	},
	{
		586001,
		11,
		1,
		"cell_item",
		{
			-137,
			139
		},
		{
			item = "204:2",
			txtDesc = "充值获得神钻\n<color=#d56d08>{DataId$18}</color>"
		},
		"暂无神钻充值记录"
	},
	{
		586001,
		11,
		2,
		"cell_item",
		{
			244,
			-85
		},
		{
			item = "204:2",
			txtDesc = "累计消耗神钻\n<color=#d56d08>{DataId$19}</color>"
		},
		"暂无神钻消耗记录"
	},
	{
		586001,
		12,
		1,
		"cell_item",
		{
			-183,
			176
		},
		{
			item = "100:10313",
			txtDesc = "尊享21年费特权\n<color=#d56d08>获得{DataId$27}只次元圣龙</color>"
		},
		"暂未开通21年费特权"
	},
	{
		586001,
		12,
		2,
		"cell_item",
		{
			35,
			-17
		},
		{
			item = "100:16001",
			txtDesc = "尊享22年费特权\n<color=#d56d08>获得{DataId$28}只解神意志</color>"
		},
		"暂未开通22年费特权"
	},
	{
		586001,
		12,
		3,
		"cell_item",
		{
			292,
			-191
		},
		{
			item = "100:16010",
			txtDesc = "尊享23年费特权\n<color=#d56d08>获得{DataId$29}只敖九</color>"
		},
		"暂未开通23年费特权"
	},
	{
		586001,
		13,
		1,
		"cell_item",
		{
			-183,
			176
		},
		{
			item = "100:18001",
			txtDesc = "尊享24年费特权\n<color=#d56d08>获得{DataId$30}只凡尔维斯</color>"
		},
		"暂未开通24年费特权"
	},
	{
		586001,
		13,
		2,
		"cell_item",
		{
			35,
			-17
		},
		{
			item = "100:18021",
			txtDesc = "尊享25年费特权\n<color=#d56d08>获得{DataId$31}只斐希司</color>"
		},
		"暂未开通25年费特权"
	},
	{
		586001,
		13,
		3,
		"cell_item",
		{
			292,
			-191
		},
		{
			item = "100:18031",
			txtDesc = "尊享26年费特权\n<color=#d56d08>获得{DataId$32}只创世圣龙</color>"
		},
		"暂未开通26年费特权"
	},
	{
		586001,
		14,
		1,
		"cell_normal",
		{
			-145,
			184
		},
		{
			txtDesc = "江湖藏万象，珍奇纳囊中，"
		},
		"暂无皮肤直购记录"
	},
	{
		586001,
		14,
		2,
		"cell_normal",
		{
			291,
			100.5
		},
		{
			txtDesc = "你寻灵宠、集华服、收奇珍，把世间瑰宝尽数珍藏，"
		},
		""
	},
	{
		586001,
		14,
		3,
		"cell_normal",
		{
			-160,
			-0.4
		},
		{
			txtDesc = "每一只精灵、每一款皮肤，都是江湖馈赠的礼物，"
		},
		""
	},
	{
		586001,
		14,
		4,
		"cell_normal",
		{
			291,
			-107
		},
		{
			txtDesc = "以收集为乐，以圆满为志，"
		},
		""
	},
	{
		586001,
		14,
		5,
		"cell_normal",
		{
			-175,
			-208
		},
		{
			txtDesc = "这满仓珍奇，便是你闯荡五载的无上荣光。"
		},
		""
	},
	{
		586001,
		15,
		1,
		"cell_dress",
		{
			-183,
			176
		},
		{
			item = "4:510733",
			txtDesc = "累计直购精灵皮肤<color=#d56d08>{DataId$24}</color>次"
		},
		"暂无皮肤直购记录"
	},
	{
		586001,
		15,
		2,
		"cell_normal",
		{
			83,
			12
		},
		{
			txtDesc = "累计获得传说精灵<color=#d56d08>{DataId$36}</color>只\n超过了全服{RankRatio$7#36}的玩家"
		},
		"暂无传说精灵记录"
	},
	{
		586001,
		15,
		3,
		"cell_dress",
		{
			292,
			-191
		},
		{
			item = "4:510733",
			txtDesc = "累计珍藏精灵皮肤\n<color=#d56d08>{DataId$40}</color>件"
		},
		"暂无精灵皮肤记录"
	},
	{
		586001,
		16,
		1,
		"cell_dress",
		{
			-183,
			176
		},
		{
			item = "4:92242",
			txtDesc = "累计收集气泡框\n<color=#d56d08>{DataId$58}</color>个"
		},
		"暂无气泡框收集记录"
	},
	{
		586001,
		16,
		2,
		"cell_dress",
		{
			279,
			78
		},
		{
			item = "4:92243",
			txtDesc = "累计收集名字框\n<color=#d56d08>{DataId$59}</color>个"
		},
		"暂无名字框收集记录"
	},
	{
		586001,
		16,
		3,
		"cell_dress",
		{
			-183,
			-64
		},
		{
			item = "4:92241",
			txtDesc = "累计收集名片\n<color=#d56d08>{DataId$60}</color>个"
		},
		"暂无名片收集记录"
	},
	{
		586001,
		16,
		4,
		"cell_dress",
		{
			292,
			-191
		},
		{
			item = "4:92245",
			txtDesc = "累计收集开场特效\n<color=#d56d08>{DataId$61}</color>个"
		},
		"暂无开场特效记录"
	},
	{
		586001,
		17,
		1,
		"cell_dress",
		{
			-183,
			176
		},
		{
			item = "4:92244",
			txtDesc = "累计收集个人界面\n<color=#d56d08>{DataId$62}</color>个"
		},
		"暂无个人界面记录"
	},
	{
		586001,
		17,
		2,
		"cell_dress",
		{
			35,
			-17
		},
		{
			item = "4:92251",
			txtDesc = "累计收集战斗场景\n<color=#d56d08>{DataId$63}</color>个"
		},
		"暂无战斗场景记录"
	},
	{
		586001,
		17,
		3,
		"cell_dress",
		{
			292,
			-191
		},
		{
			item = "4:92250",
			txtDesc = "累计收集战斗主题\n<color=#d56d08>{DataId$64}</color>个"
		},
		"暂无战斗主题记录"
	},
	{
		586001,
		18,
		1,
		"cell_dress",
		{
			-183,
			176
		},
		{
			item = "1:300101",
			txtDesc = "累计收集动态背饰\n<color=#d56d08>{DataId$65}</color>个"
		},
		"暂无动态背饰记录"
	},
	{
		586001,
		18,
		2,
		"cell_dress",
		{
			35,
			-17
		},
		{
			item = "1:600001",
			txtDesc = "累计收集个人背景\n<color=#d56d08>{DataId$66}</color>个"
		},
		"暂无个人背景记录"
	},
	{
		586001,
		18,
		3,
		"cell_dress",
		{
			292,
			-191
		},
		{
			item = "4:510665",
			txtDesc = "累计收集主角服装\n<color=#d56d08>{DataId$67}</color>个"
		},
		"暂无主角服装记录"
	},
	{
		586001,
		19,
		1,
		"cell_normal",
		{
			-145,
			184
		},
		{
			txtDesc = "三尺青锋战群雄，五载威名震江湖。"
		},
		""
	},
	{
		586001,
		19,
		2,
		"cell_normal",
		{
			291,
			100.5
		},
		{
			txtDesc = "从秘境闯关到竞技场争锋，从排位对决到巅峰争霸，"
		},
		""
	},
	{
		586001,
		19,
		3,
		"cell_normal",
		{
			-160,
			-0.4
		},
		{
			txtDesc = "你身经百战、屡破强敌，"
		},
		""
	},
	{
		586001,
		19,
		4,
		"cell_normal",
		{
			291,
			-107
		},
		{
			txtDesc = "这一路披荆斩棘，用战绩书写传奇，"
		},
		""
	},
	{
		586001,
		19,
		5,
		"cell_normal",
		{
			-175,
			-208
		},
		{
			txtDesc = "用实力铸就江湖地位，尽显侠客铁血本色。"
		},
		""
	},
	{
		586001,
		20,
		1,
		"cell_pet",
		{
			-183,
			176
		},
		{
			petId = "DataId$37",
			txtDesc = "<color=#d56d08>{PetName$37}</color>\n是伴你征战最多的本命精灵"
		},
		"暂无精灵征战记录"
	},
	{
		586001,
		20,
		2,
		"cell_pet",
		{
			279,
			78
		},
		{
			petId = "DataId$37",
			txtDesc = "本命精灵征战沙场<color=#d56d08>{DataId$38}</color>场\n是你最信赖的战力伙伴"
		},
		"暂无精灵战斗记录"
	},
	{
		586001,
		20,
		3,
		"cell_pet",
		{
			-183,
			-64
		},
		{
			petId = "DataId$39",
			txtDesc = "<color=#d56d08>{PetName$39}</color>\n是你斩获最多次的传说精灵"
		},
		"暂无传说精灵记录"
	},
	{
		586001,
		20,
		4,
		"cell_pet",
		{
			292,
			-191
		},
		{
			petId = "DataId$41",
			txtDesc = "<color=#d56d08>{PetName$41}</color>\n是你拥有皮肤最多的专属精灵"
		},
		"暂无精灵皮肤记录"
	},
	{
		586001,
		21,
		1,
		"cell_normal",
		{
			-59,
			108
		},
		{
			txtDesc = "五年间，你在精灵挑战中共战斗了<color=#d56d08>{DataId$42}</color>场\n超过了全服{RankRatio$8#42}的玩家"
		},
		"暂无 PVE 战斗记录"
	},
	{
		586001,
		21,
		2,
		"cell_normal",
		{
			202,
			-97
		},
		{
			txtDesc = "在限时精灵挑战内参与了<color=#d56d08>{DataId$43}</color>场\n超过了全服{RankRatio$9#43}的玩家"
		},
		"暂无限时挑战记录"
	},
	{
		586001,
		22,
		1,
		"cell_pve_jingjichang",
		{
			-177,
			144
		},
		{
			maxRankDefault = "最高段位：暂无",
			name = "竞技场",
			maxRank = "最高排名：{DataId$45}",
			txtDesc = "此排名超越<color=#d56d08>{RankRatio$10#44}</color>的侠客"
		},
		"暂无竞技场战斗记录"
	},
	{
		586001,
		22,
		2,
		"cell_pve",
		{
			301,
			98
		},
		{
			maxRankDefault = "最高排名：暂无",
			txtDesc = "此排名超越<color=#d56d08>{RankRatio$11#45}</color>的侠客",
			name = "3V3高阶竞技场",
			championCount = "冠军次数：{DataId$46}",
			championCountDefault = "冠军次数：暂无",
			maxRank = "最高排名：{DataId$45}"
		},
		"暂无高阶竞技记录"
	},
	{
		586001,
		22,
		3,
		"cell_pve",
		{
			-170,
			-115
		},
		{
			maxRankDefault = "最高排名：暂无",
			txtDesc = "此排名超越<color=#d56d08>{RankRatio$12#47}</color>的侠客",
			name = "少年竞技王",
			championCount = "冠军次数：{DataId$48}",
			championCountDefault = "冠军次数：暂无",
			maxRank = "最高排名：{DataId$47}"
		},
		"暂无竞技王战斗记录"
	},
	{
		586001,
		22,
		4,
		"cell_pve",
		{
			308,
			-150
		},
		{
			maxRankDefault = "最高排名：暂无",
			txtDesc = "此排名超越<color=#d56d08>{RankRatio$13#49}</color>的侠客",
			name = "王者竞技场",
			championCount = "战皇次数：{DataId$50}",
			championCountDefault = "战皇次数：暂无",
			maxRank = "最高排名：{DataId$49}"
		},
		"暂无王者竞技记录"
	},
	{
		586001,
		23,
		1,
		"cell_pve_jingjichang",
		{
			-177,
			144
		},
		{
			maxRankDefault = "最高排名：暂无",
			name = "巅峰赛战区赛",
			maxRank = "最高排名：{DataId$51}",
			txtDesc = "此排名超越<color=#d56d08>{RankRatio$14#51}</color>的侠客"
		},
		"暂无巅峰赛-战区赛记录"
	},
	{
		586001,
		23,
		2,
		"cell_pve",
		{
			301,
			98
		},
		{
			maxRankDefault = "最高排名：暂无",
			txtDesc = "此排名超越<color=#d56d08>{RankRatio$15#52}</color>的侠客",
			name = "巅峰赛全服赛",
			championCount = "冠军次数：{DataId$53}",
			championCountDefault = "冠军次数：暂无",
			maxRank = "最高排名：{DataId$52}"
		},
		"暂无巅峰赛-全服赛记录"
	},
	{
		586001,
		23,
		3,
		"cell_pve",
		{
			-170,
			-115
		},
		{
			maxRankDefault = "最高段位：暂无",
			txtDesc = "此战绩超越<color=#d56d08>{RankRatio$16#55}</color>的侠客",
			name = "经典排位赛",
			championCount = "传说次数：{DataId$55}",
			championCountDefault = "传说次数：暂无",
			maxRank = "最高段位：{DataId$54}"
		},
		"暂无排位赛记录"
	},
	{
		586001,
		23,
		4,
		"cell_pve",
		{
			308,
			-150
		},
		{
			maxRankDefault = "最高段位：暂无",
			txtDesc = "此战绩超越<color=#d56d08>{RankRatio$17#57}</color>的侠客",
			name = "极限排位赛",
			championCount = "传说次数：{DataId$57}",
			championCountDefault = "传说次数：暂无",
			maxRank = "最高段位：{DataId$56}"
		},
		"暂无极限排位记录"
	}
}
local t_five_year_recap_report_page = {
	[586001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11]
		},
		{
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			dataList[19],
			dataList[20]
		},
		{
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24]
		},
		{
			dataList[25],
			dataList[26],
			dataList[27]
		},
		{
			dataList[28],
			dataList[29],
			dataList[30],
			dataList[31]
		},
		{
			dataList[32],
			dataList[33],
			dataList[34]
		},
		{
			dataList[35],
			dataList[36]
		},
		{
			dataList[37],
			dataList[38],
			dataList[39]
		},
		{
			dataList[40],
			dataList[41],
			dataList[42]
		},
		{
			dataList[43],
			dataList[44],
			dataList[45],
			dataList[46],
			dataList[47]
		},
		{
			dataList[48],
			dataList[49],
			dataList[50]
		},
		{
			dataList[51],
			dataList[52],
			dataList[53],
			dataList[54]
		},
		{
			dataList[55],
			dataList[56],
			dataList[57]
		},
		{
			dataList[58],
			dataList[59],
			dataList[60]
		},
		{
			dataList[61],
			dataList[62],
			dataList[63],
			dataList[64],
			dataList[65]
		},
		{
			dataList[66],
			dataList[67],
			dataList[68],
			dataList[69]
		},
		{
			dataList[70],
			dataList[71]
		},
		{
			dataList[72],
			dataList[73],
			dataList[74],
			dataList[75]
		},
		{
			dataList[76],
			dataList[77],
			dataList[78],
			dataList[79]
		}
	}
}

t_five_year_recap_report_page.dataList = dataList

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

return t_five_year_recap_report_page
