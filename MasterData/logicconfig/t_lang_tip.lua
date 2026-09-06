-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lang_tip.lua

module("logicconfig.config.t_lang_tip", package.seeall)

local title = {
	contenttw = 3,
	key = 1,
	contenten = 5,
	contentko = 6,
	contentjp = 4,
	contentzh = 2
}
local dataList = {
	{
		"tip_try_again",
		"操作太频繁啦，请稍后再尝试",
		"",
		"",
		"",
		""
	},
	{
		"tip_dodge",
		"闪避",
		"",
		"",
		"",
		""
	},
	{
		"tip_block",
		"格挡",
		"",
		"",
		"",
		""
	},
	{
		"tip_absorb",
		"吸收",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_prepare",
		"正在全力加载中，请耐心等待一下",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_connectwebfail",
		"连接失败，请检查网络",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_relogin",
		"重新登录",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_serverfull",
		"该岛已满员，可以选择其他岛进行登录哦~",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_notice",
		"公告",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_account",
		"账号",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_selectzone",
		"点击选区",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_changeserver",
		"切 换",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_begingame",
		"开始游戏",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_readandagree",
		"我已详细阅读并同意",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_userprotocol",
		"广州天梯产品使用许可和服务协议",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_notacceptuserprotocol1",
		"请详细阅读并同意《天梯游戏许可及服务协议》和《天梯游戏隐私政策》才可进入游戏",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_notacceptuserprotocol2",
		"取消将无法进入游戏哦",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_surecancel",
		"确认取消",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_returnlook",
		"返回查看",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_copyright",
		"抵制不良游戏，拒绝盗版游戏，注意自我保护，谨防受骗上当，适度游戏益脑，沉迷游戏伤身,合理安排时间，享受健康生活。\n著作权人：广州天梯网络科技有限公司 运营单位：广州天梯网络科技有限公司 出版单位：广州百田信息科技有限公司\n批准文号：新广出审[2018]XXXX号 总局批文：ISBN XXX-X-XXXX-X 文网游备字:[2018]Ｍ-RPG XXXX号著作权登记号2018SR362584",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_updateclient",
		"客户端已更新，请重新启动游戏",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_otherdevice",
		"游戏账号被其他设备登录，请注意账号安全！",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_fail",
		"服务器登录失败，请检查网络后重试！",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_sdkloginfail",
		"登录初始化失败，请检查网络后点击游戏界面重试",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_servershutdown",
		"亲爱的奥奇，精灵大陆正在维护中，新的冒险即将开启，可点击登录界面的公告按钮，查看官方公告的结束维护时间。",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_sdkinitfail",
		"登录初始化失败，请检查网络正常后点击重试",
		"",
		"",
		"",
		""
	},
	{
		"tip_login_reqremoteverfail",
		"检查游戏内容是否更新请求失败，请检查网络正常后点击重试",
		"",
		"",
		"",
		""
	},
	{
		"tip_network_disconnect",
		"网络已断开，请重新登录……",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_getinfofail",
		"获取服务器列表失败，请检查网络",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_viewtitle",
		"选择服务器",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_lastlogin",
		"最近登录",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_recommend",
		"推荐服务器",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_zone",
		"区",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_haverole",
		"表示该服拥有角色",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_stop",
		"维护",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_normal",
		"流畅",
		"",
		"",
		"",
		""
	},
	{
		"tip_server_hot",
		"爆满",
		"",
		"",
		"",
		""
	},
	{
		"tip_revise",
		"修改",
		"",
		"",
		"",
		""
	},
	{
		"tip_submit",
		"提交",
		"",
		"",
		"",
		""
	},
	{
		"tip_gesture_invaild",
		"无效手势",
		"",
		"",
		"",
		""
	},
	{
		"ui_level_name",
		"%s级%s",
		"",
		"",
		"",
		""
	},
	{
		"tip_exp",
		"经验",
		"",
		"",
		"",
		""
	},
	{
		"tip_get",
		"获得",
		"",
		"",
		"",
		""
	},
	{
		"tip_level",
		"等级",
		"",
		"",
		"",
		""
	},
	{
		"tip_unlock",
		"取消锁定",
		"",
		"",
		"",
		""
	},
	{
		"tip_replace",
		"替换",
		"",
		"",
		"",
		""
	},
	{
		"tip_equip",
		"装备",
		"",
		"",
		"",
		""
	},
	{
		"tip_lock_txt",
		"未解锁",
		"",
		"",
		"",
		""
	},
	{
		"tip_lock",
		"锁定",
		"",
		"",
		"",
		""
	},
	{
		"tip_stargod",
		"星神",
		"",
		"",
		"",
		""
	},
	{
		"tip_potential",
		"潜能",
		"",
		"",
		"",
		""
	},
	{
		"tip_null_awake",
		"未觉醒",
		"",
		"",
		"",
		""
	},
	{
		"tip_awake",
		"觉醒",
		"",
		"",
		"",
		""
	},
	{
		"tip_need_buy",
		"需要购买%s",
		"",
		"",
		"",
		""
	},
	{
		"tip_click_write",
		"点击填写",
		"",
		"",
		"",
		""
	},
	{
		"tip",
		"提示",
		"",
		"",
		"",
		""
	},
	{
		"confirm",
		"确定",
		"",
		"",
		"",
		""
	},
	{
		"tip_loading_001",
		"全力加载中，请耐心等待……",
		"",
		"",
		"",
		""
	},
	{
		"tip_all",
		"全部",
		"",
		"",
		"",
		""
	},
	{
		"tip_surplus",
		"剩余",
		"",
		"",
		"",
		""
	},
	{
		"tip_cumulative",
		"累计",
		"",
		"",
		"",
		""
	},
	{
		"tip_clearance",
		"通关",
		"",
		"",
		"",
		""
	},
	{
		"red_chaoji",
		"超级星元",
		"",
		"",
		"",
		""
	},
	{
		"red_wudi",
		"无敌星元",
		"",
		"",
		"",
		""
	},
	{
		"red_da",
		"大星元",
		"",
		"",
		"",
		""
	},
	{
		"red_xiao",
		"小星元",
		"",
		"",
		"",
		""
	},
	{
		"red_mini",
		"迷你星元",
		"",
		"",
		"",
		""
	},
	{
		"stargod_auto_off",
		"关闭星辉自动合成",
		"",
		"",
		"",
		""
	},
	{
		"stargod_auto_on",
		"自动合成紫色以下星辉",
		"",
		"",
		"",
		""
	},
	{
		"stargod_vip",
		"VIP可开启一键猎星哦",
		"",
		"",
		"",
		""
	},
	{
		"stargod_notopen",
		"该境界还未开启呢。",
		"",
		"",
		"",
		""
	},
	{
		"stargod_godopen",
		"神之境界已开启，快去猎星吧！",
		"",
		"",
		"",
		""
	},
	{
		"stargod_lightopen",
		"光之境界已开启，快去猎星吧！",
		"",
		"",
		"",
		""
	},
	{
		"stargod_willmerge",
		"<color=#000000>将会合成:</color>",
		"",
		"",
		"",
		""
	},
	{
		"stargod_swallow",
		"%s 将吞噬 %s\n获得%s经验。",
		"",
		"",
		"",
		""
	},
	{
		"stargod_replace",
		"你确定要用 %s 替换掉 %s 吗?",
		"",
		"",
		"",
		""
	},
	{
		"stargod_blue_c",
		"<color=#0ba4ff>蓝色星辉</color>",
		"",
		"",
		"",
		""
	},
	{
		"stargod_purple_c",
		"<color=#e15aff>紫色星辉</color>",
		"",
		"",
		"",
		""
	},
	{
		"stargod_full",
		"星辉已满级！",
		"",
		"",
		"",
		""
	},
	{
		"stargod_green_c",
		"<color=#33ff00>绿色星辉</color>",
		"",
		"",
		"",
		""
	},
	{
		"sort",
		"排序",
		"",
		"",
		"",
		""
	},
	{
		"sort_level_down",
		"等级降序",
		"",
		"",
		"",
		""
	},
	{
		"sort_level_up",
		"等级升序",
		"",
		"",
		"",
		""
	},
	{
		"sort_quality_down",
		"品质降序",
		"",
		"",
		"",
		""
	},
	{
		"sort_quality_up",
		"品质升序",
		"",
		"",
		"",
		""
	},
	{
		"sort_cur_power_down",
		"当前战力降序",
		"",
		"",
		"",
		""
	},
	{
		"sort_cur_power_up",
		"当前战力升序",
		"",
		"",
		"",
		""
	},
	{
		"sort_max_power_down",
		"极限战力降序",
		"",
		"",
		"",
		""
	},
	{
		"sort_max_power_up",
		"极限战力升序",
		"",
		"",
		"",
		""
	},
	{
		"sort_get_time_down",
		"获得时间降序",
		"",
		"",
		"",
		""
	},
	{
		"sort_get_time_up",
		"获得时间升序",
		"",
		"",
		"",
		""
	},
	{
		"race_cao",
		"草",
		"",
		"",
		"",
		""
	},
	{
		"race_shui",
		"水",
		"",
		"",
		"",
		""
	},
	{
		"race_huo",
		"火",
		"",
		"",
		"",
		""
	},
	{
		"race_guang",
		"光",
		"",
		"",
		"",
		""
	},
	{
		"race_an",
		"暗",
		"",
		"",
		"",
		""
	},
	{
		"job",
		"职业",
		"",
		"",
		"",
		""
	},
	{
		"job_speed",
		"疾速",
		"",
		"",
		"",
		""
	},
	{
		"job_magic",
		"魔法",
		"",
		"",
		"",
		""
	},
	{
		"job_attack",
		"利爪",
		"",
		"",
		"",
		""
	},
	{
		"job_shield",
		"肉盾",
		"",
		"",
		"",
		""
	},
	{
		"job_balance",
		"平衡",
		"",
		"",
		"",
		""
	},
	{
		"job_treatment",
		"治疗",
		"",
		"",
		"",
		""
	},
	{
		"job_shot",
		"疾速",
		"",
		"",
		"",
		""
	},
	{
		"job_hero",
		"英雄",
		"",
		"",
		"",
		""
	},
	{
		"job_summoner",
		"召唤师",
		"",
		"",
		"",
		""
	},
	{
		"job_boss_restrain",
		"魔王克星",
		"",
		"",
		"",
		""
	},
	{
		"job_ancient",
		"远古宠",
		"",
		"",
		"",
		""
	},
	{
		"job_source",
		"源兽",
		"",
		"",
		"",
		""
	},
	{
		"job_boss",
		"魔王",
		"",
		"",
		"",
		""
	},
	{
		"job_shenqi",
		"神启",
		"",
		"",
		"",
		""
	},
	{
		"attr",
		"属性",
		"",
		"",
		"",
		""
	},
	{
		"attr_attack_physical",
		"物攻",
		"",
		"",
		"",
		""
	},
	{
		"attr_defense_physical",
		"物防",
		"",
		"",
		"",
		""
	},
	{
		"attr_attack_ult",
		"超攻",
		"",
		"",
		"",
		""
	},
	{
		"attr_defense_ult",
		"超防",
		"",
		"",
		"",
		""
	},
	{
		"attr_attack_magic",
		"魔攻",
		"",
		"",
		"",
		""
	},
	{
		"attr_defense_magic",
		"魔防",
		"",
		"",
		"",
		""
	},
	{
		"attr_hp",
		"生命",
		"",
		"",
		"",
		""
	},
	{
		"attr_speed",
		"速度",
		"",
		"",
		"",
		""
	},
	{
		"petegg_ifunload",
		"你确定取回这个精灵蛋么？\n一旦取回会重置孵化时间",
		"",
		"",
		"",
		""
	},
	{
		"petegg_ifhatch",
		"孵化 %s 需要%s，\n开始孵化么？",
		"",
		"",
		"",
		""
	},
	{
		"petegg_hatching",
		"正在孵蛋",
		"",
		"",
		"",
		""
	},
	{
		"petegg_needvip",
		"月卡用户才能使用该栏哦！",
		"",
		"",
		"",
		""
	},
	{
		"pet_fruit_use",
		"确定使用一个%s,\n将精灵%s吗？",
		"",
		"",
		"",
		""
	},
	{
		"pet_power",
		"战力",
		"",
		"",
		"",
		""
	},
	{
		"pet_level_max",
		"精灵已满级",
		"",
		"",
		"",
		""
	},
	{
		"not_empty",
		"输入的名字不能为空",
		"",
		"",
		"",
		""
	},
	{
		"input_pet_name",
		"请输入精灵名字",
		"",
		"",
		"",
		""
	},
	{
		"evlove_title",
		"进化",
		"",
		"",
		"",
		""
	},
	{
		"evlove_toptip",
		"选择背包中的%s放入，进化后所有养成全部继承",
		"",
		"",
		"",
		""
	},
	{
		"task_title",
		"任务",
		"",
		"",
		"",
		""
	},
	{
		"task_chapter",
		"篇章",
		"",
		"",
		"",
		""
	},
	{
		"task_over",
		"已完结",
		"",
		"",
		"",
		""
	},
	{
		"task_desc",
		"任务描述",
		"",
		"",
		"",
		""
	},
	{
		"task_target",
		"任务目标",
		"",
		"",
		"",
		""
	},
	{
		"task_bonus",
		"任务奖励",
		"",
		"",
		"",
		""
	},
	{
		"task_goto",
		"前往完成",
		"",
		"",
		"",
		""
	},
	{
		"task_review",
		"回顾",
		"",
		"",
		"",
		""
	},
	{
		"task_main",
		"剧情任务",
		"",
		"",
		"",
		""
	},
	{
		"task_branch",
		"挑战任务",
		"",
		"",
		"",
		""
	},
	{
		"task_daily",
		"日常任务",
		"",
		"",
		"",
		""
	},
	{
		"task_guide",
		"成长任务",
		"",
		"",
		"",
		""
	},
	{
		"task_festival",
		"活动任务",
		"",
		"",
		"",
		""
	},
	{
		"task_limittime",
		"日程",
		"",
		"",
		"",
		""
	},
	{
		"task_main_shortcut",
		"剧情",
		"",
		"",
		"",
		""
	},
	{
		"task_branch_shortcut",
		"挑战",
		"",
		"",
		"",
		""
	},
	{
		"task_daily_shortcut",
		"日常",
		"",
		"",
		"",
		""
	},
	{
		"task_guide_shortcut",
		"成长",
		"",
		"",
		"",
		""
	},
	{
		"task_festival_shortcut",
		"活动",
		"",
		"",
		"",
		""
	},
	{
		"diamondtask_daily",
		"每日任务",
		"",
		"",
		"",
		""
	},
	{
		"diamondtask_weekly",
		"每周任务",
		"",
		"",
		"",
		""
	},
	{
		"diamondtask_monthly",
		"每月任务",
		"",
		"",
		"",
		""
	},
	{
		"exp_lackfruit",
		"数量不足,去获取经验果吧",
		"",
		"",
		"",
		""
	},
	{
		"fight_unformation",
		"尚未布阵，先布置好精灵再来挑战吧",
		"",
		"",
		"",
		""
	},
	{
		"fight_goto_fmt",
		"去布阵",
		"",
		"",
		"",
		""
	},
	{
		"fight_fmt_num",
		"上阵的精灵未满%s只（上阵精灵越多，战斗力越强），是否继续挑战？",
		"",
		"",
		"",
		""
	},
	{
		"kaya_nohanbin",
		"你还没有获得寒冰骑士，去获得吧！",
		"",
		"",
		"",
		""
	},
	{
		"go_get",
		"去获得",
		"",
		"",
		"",
		""
	},
	{
		"goto",
		"前往",
		"",
		"",
		"",
		""
	},
	{
		"finish",
		"完成",
		"",
		"",
		"",
		""
	},
	{
		"petegg_goto_hatch_tips",
		"您获得了精灵蛋，快去孵蛋吧！",
		"",
		"",
		"",
		""
	},
	{
		"petegg_goto_hatch",
		"去孵蛋",
		"",
		"",
		"",
		""
	},
	{
		"tips_not_release",
		"此功能尚未开放",
		"",
		"",
		"",
		""
	},
	{
		"tag",
		"标签",
		"",
		"",
		"",
		""
	},
	{
		"tag_normal",
		"普通",
		"",
		"",
		"",
		""
	},
	{
		"tag_special",
		"精英",
		"",
		"",
		"",
		""
	},
	{
		"lv_number",
		"%d 级",
		"",
		"",
		"",
		""
	},
	{
		"lv_number_nospace",
		"%d级",
		"",
		"",
		"",
		""
	},
	{
		"skill_passive_shortcut",
		"被动",
		"",
		"",
		"",
		""
	},
	{
		"skill_normal_shortcut",
		"普攻",
		"",
		"",
		"",
		""
	},
	{
		"skill_ult_shortcut",
		"超杀",
		"",
		"",
		"",
		""
	},
	{
		"skill_hero_shortcut",
		"英雄技",
		"",
		"",
		"",
		""
	},
	{
		"skill_summon_shortcut",
		"召唤技",
		"",
		"",
		"",
		""
	},
	{
		"tips_best_position",
		"推荐站位: %s",
		"",
		"",
		"",
		""
	},
	{
		"tips_team",
		"队伍",
		"",
		"",
		"",
		""
	},
	{
		"number_1",
		"一",
		"",
		"",
		"",
		""
	},
	{
		"number_2",
		"二",
		"",
		"",
		"",
		""
	},
	{
		"number_3",
		"三",
		"",
		"",
		"",
		""
	},
	{
		"number_4",
		"四",
		"",
		"",
		"",
		""
	},
	{
		"number_5",
		"五",
		"",
		"",
		"",
		""
	},
	{
		"item_sell_get",
		"获得%s金币",
		"",
		"",
		"",
		""
	},
	{
		"item_have",
		"已拥有: %s个",
		"",
		"",
		"",
		""
	},
	{
		"item_merge",
		"%s合%s",
		"",
		"",
		"",
		""
	},
	{
		"item_sell",
		"单价 <color=#f59200>%s</color>金币",
		"",
		"",
		"",
		""
	},
	{
		"genius_yiwushichu",
		"一无是处",
		"",
		"",
		"",
		""
	},
	{
		"genius_shifenchangjian",
		"十分常见",
		"",
		"",
		"",
		""
	},
	{
		"genius_bailitiaoyi",
		"百里挑一",
		"",
		"",
		"",
		""
	},
	{
		"genius_qianzainanfeng",
		"千载难逢",
		"",
		"",
		"",
		""
	},
	{
		"genius_wanzhongzhumu",
		"万众瞩目",
		"",
		"",
		"",
		""
	},
	{
		"genius_wangzhewudi",
		"王者无敌",
		"",
		"",
		"",
		""
	},
	{
		"mail_sys",
		"系统邮件",
		"",
		"",
		"",
		""
	},
	{
		"mail_sender",
		"发送者",
		"",
		"",
		"",
		""
	},
	{
		"mail_year",
		"年",
		"",
		"",
		"",
		""
	},
	{
		"mail_mon",
		"月",
		"",
		"",
		"",
		""
	},
	{
		"mail_day",
		"日",
		"",
		"",
		"",
		""
	},
	{
		"mail_tip1",
		"您还有邮件未读，是否确定删除？",
		"",
		"",
		"",
		""
	},
	{
		"mail_tip2",
		"您还有附件未领取，是否确定删除？",
		"",
		"",
		"",
		""
	},
	{
		"mail_tip",
		"提示",
		"",
		"",
		"",
		""
	},
	{
		"mail_confirm",
		"确定",
		"",
		"",
		"",
		""
	},
	{
		"mail_cancel",
		"取消",
		"",
		"",
		"",
		""
	},
	{
		"mail_get",
		"领取",
		"",
		"",
		"",
		""
	},
	{
		"mail_got",
		"已领取",
		"",
		"",
		"",
		""
	},
	{
		"mail_before",
		"前",
		"",
		"",
		"",
		""
	},
	{
		"tips_geniustype",
		"天赋：",
		"",
		"",
		"",
		""
	},
	{
		"tips_strength",
		"增强",
		"",
		"",
		"",
		""
	},
	{
		"tips_geniustrain",
		"培养天赋",
		"",
		"",
		"",
		""
	},
	{
		"dress_ownprog",
		"收集度:%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"jiugong_unlocknow",
		"花费%s钻石立刻解锁此修炼挑战吗？",
		"",
		"",
		"",
		""
	},
	{
		"no_search_player",
		"奥奇世界查无此人！",
		"",
		"",
		"",
		""
	},
	{
		"select_uplvpet",
		"请选择要升级的精灵",
		"",
		"",
		"",
		""
	},
	{
		"pet_maxlv",
		"精灵已满级",
		"",
		"",
		"",
		""
	},
	{
		"tip_missionnum",
		"第%s关",
		"",
		"",
		"",
		""
	},
	{
		"wt_boxnoget",
		"暂时不能领哦",
		"",
		"",
		"",
		""
	},
	{
		"wt_boxgot",
		"宝箱已领取",
		"",
		"",
		"",
		""
	},
	{
		"wt_poolept",
		"经验池为空",
		"",
		"",
		"",
		""
	},
	{
		"wt_usediamond",
		"消耗%s钻石完成扫荡吗?",
		"",
		"",
		"",
		""
	},
	{
		"wt_expoverflow",
		"本次扫荡将溢出%s经验，是否继续扫荡?",
		"",
		"",
		"",
		""
	},
	{
		"wt_nosweecnt",
		"您已经没有扫荡次数了",
		"",
		"",
		"",
		""
	},
	{
		"wt_nosweeplv",
		"您还没有可以扫荡的关卡",
		"",
		"",
		"",
		""
	},
	{
		"wt_sweeping",
		"扫荡正在进行",
		"",
		"",
		"",
		""
	},
	{
		"wt_sweepfinish",
		"本次扫荡获得%s经验，已帮您存入经验池，点击经验池可以吸收经验",
		"",
		"",
		"",
		""
	},
	{
		"wt_sweepto",
		"可扫荡至第%s关",
		"",
		"",
		"",
		""
	},
	{
		"tips_someone_apply_01",
		"奥奇，有好友添加你哦！",
		"",
		"",
		"",
		""
	},
	{
		"tips_recommend_01",
		"主人加些好友吧！",
		"",
		"",
		"",
		""
	},
	{
		"tips_no_search_player",
		"当前没有相关的好友哦！",
		"",
		"",
		"",
		""
	},
	{
		"apply_success",
		"申请好友成功",
		"",
		"",
		"",
		""
	},
	{
		"delete_success",
		"删除好友成功",
		"",
		"",
		"",
		""
	},
	{
		"remove_blacklist_success",
		"%s已被移除黑名单！",
		"",
		"",
		"",
		""
	},
	{
		"add_blacklist_success",
		"该好友已经被拉黑啦！",
		"",
		"",
		"",
		""
	},
	{
		"add_friend_success",
		"添加成功，可以开始聊天啦！",
		"",
		"",
		"",
		""
	},
	{
		"agree_apply",
		"%s同意了您的好友申请，开始聊天吧~",
		"",
		"",
		"",
		""
	},
	{
		"delete_friend",
		"删除好友",
		"",
		"",
		"",
		""
	},
	{
		"add_blacklist",
		"加入黑名单",
		"",
		"",
		"",
		""
	},
	{
		"remove_blacklist",
		"移除黑名单",
		"",
		"",
		"",
		""
	},
	{
		"offline",
		"离线",
		"",
		"",
		"",
		""
	},
	{
		"godrace_mat",
		"请选择作为材料的精灵",
		"",
		"",
		"",
		""
	},
	{
		"godrace_choose",
		"请选择要神属的精灵(精灵需达到80级才能进行神属进化,已神属过的种族不能再神属)",
		"",
		"",
		"",
		""
	},
	{
		"no_hero_skill",
		"无英雄技",
		"",
		"",
		"",
		""
	},
	{
		"prize_get_levelup",
		"领取升级奖励",
		"",
		"",
		"",
		""
	},
	{
		"prize_get_gift",
		"领取天赋奖励",
		"",
		"",
		"",
		""
	},
	{
		"prize_get_stargod",
		"领取星辉奖励",
		"",
		"",
		"",
		""
	},
	{
		"prize_get_srcbeast",
		"领取源兽奖励",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_tip",
		"选择背包中的精灵放入，即可领取修炼奖励",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_eighty",
		"等级升至80级",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_levelup",
		"等级升10级",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_stargod",
		"装备3个6级金色星辉",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_gift",
		"天赋升至:王者无敌",
		"",
		"",
		"",
		""
	},
	{
		"story_pass",
		"跳过",
		"",
		"",
		"",
		""
	},
	{
		"text_friend",
		"好友",
		"",
		"",
		"",
		""
	},
	{
		"text_mail",
		"邮件",
		"",
		"",
		"",
		""
	},
	{
		"text_num_round",
		"第%d回合",
		"",
		"",
		"",
		""
	},
	{
		"text_speed_acc",
		"加速",
		"",
		"",
		"",
		""
	},
	{
		"auto_voice_true",
		"设置成功，%s语音将会自动播放。",
		"",
		"",
		"",
		""
	},
	{
		"auto_voice_false",
		"设置成功，%s语音将不会自动播放。",
		"",
		"",
		"",
		""
	},
	{
		"channel_zone",
		"本服频道",
		"",
		"",
		"",
		""
	},
	{
		"channel_world",
		"本服频道",
		"",
		"",
		"",
		""
	},
	{
		"channel_league",
		"家族频道",
		"",
		"",
		"",
		""
	},
	{
		"channel_nearby",
		"附近频道",
		"",
		"",
		"",
		""
	},
	{
		"channel_system",
		"系统频道",
		"",
		"",
		"",
		""
	},
	{
		"channel_zone_shortcut",
		"本服",
		"",
		"",
		"",
		""
	},
	{
		"channel_world_shortcut",
		"本服",
		"",
		"",
		"",
		""
	},
	{
		"channel_league_shortcut",
		"家族",
		"",
		"",
		"",
		""
	},
	{
		"channel_nearby_shortcut",
		"附近",
		"",
		"",
		"",
		""
	},
	{
		"channel_system_shortcut",
		"系统",
		"",
		"",
		"",
		""
	},
	{
		"sendmsg_use_item",
		"消耗%s, %s消息发送成功！",
		"",
		"",
		"",
		""
	},
	{
		"sendmsg_use_conume_success",
		"消耗%d%s, %s消息发送成功！",
		"",
		"",
		"",
		""
	},
	{
		"sendmsg_use_conume_failed",
		"%s不足，消息发送失败！",
		"",
		"",
		"",
		""
	},
	{
		"sendmsg_use_conume_confirm",
		"是否花费%d%s购买%s发送%s消息？",
		"",
		"",
		"",
		""
	},
	{
		"sx_dailyCounterLimit",
		"今天限兑换 %s 件",
		"",
		"",
		"",
		""
	},
	{
		"sx_weeklyCounterLimit",
		"本周限兑换 %s 件",
		"",
		"",
		"",
		""
	},
	{
		"sx_monthlyCounterLimit",
		"本月限兑换 %s 件",
		"",
		"",
		"",
		""
	},
	{
		"sx_oneOffLimit",
		"限兑换 %s 件",
		"",
		"",
		"",
		""
	},
	{
		"sx_longTimeCounterLimit",
		"限兑换 %s 件",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_percent_great",
		"精灵血量大于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_percent_less",
		"精灵血量小于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_great",
		"精灵血量大于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_less",
		"精灵血量小于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_percent_great",
		"精灵气势大于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_percent_less",
		"精灵气势小于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_great",
		"精灵气势大于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_less",
		"精灵气势小于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_percent_pos_great",
		"%s血量大于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_percent_pos_less",
		"%s血量小于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_pos_great",
		"%s血量大于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_hp_pos_less",
		"%s血量小于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_percent_pos_great",
		"%s气势大于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_percent_pos_less",
		"%s气势小于百分之%d%%才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_pos_great",
		"%s气势大于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_vigour_pos_less",
		"%s气势小于%d才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_odd_round",
		"奇数回合才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_even_round",
		"偶数回合才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_buff_self",
		"乙方阵容任意精灵触发%s状态才可以捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_no_buff_self",
		"乙方阵容任意精灵未触发%s状态才可以捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_buff_enemy",
		"敌方阵容任意精灵触发%s状态才可以捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_no_buff_enemy",
		"敌方阵容任意精灵未触发%s状态才可以捕捉",
		"",
		"",
		"",
		""
	},
	{
		"battleitem_energy_noenough",
		"能量不足，不可使用",
		"",
		"",
		"",
		""
	},
	{
		"catch_waiting_cd",
		"等待时间：任意精灵%d次攻击",
		"",
		"",
		"",
		""
	},
	{
		"catch_failed",
		"捕捉精灵%s失败",
		"",
		"",
		"",
		""
	},
	{
		"catch_success",
		"成功捕捉精灵%s",
		"",
		"",
		"",
		""
	},
	{
		"catch_targetnum_less",
		"敌方存活精灵数量小于等于%d只才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_targetnum_great",
		"敌方存活精灵数量大于等于%d只才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"catch_onlypet_exist",
		"击杀所有的%s才能捕捉",
		"",
		"",
		"",
		""
	},
	{
		"click_close",
		"点击任意位置关闭",
		"",
		"",
		"",
		""
	},
	{
		"text_youcando",
		"您还可以做：",
		"",
		"",
		"",
		""
	},
	{
		"text_gain_exp",
		"获得经验",
		"",
		"",
		"",
		""
	},
	{
		"text_next_lv_exp",
		"下次升级需经验",
		"",
		"",
		"",
		""
	},
	{
		"text_exp_double_add",
		"双倍经验加成",
		"",
		"",
		"",
		""
	},
	{
		"text_exp_vip_add",
		"VIP加成",
		"",
		"",
		"",
		""
	},
	{
		"text_exp_prop_add",
		"道具加成",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_max_sp",
		"<color=#%s>[%s]</color>血量上限提升",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_transform",
		"<color=#%s>[%s]</color>变身成<color=#%s>[%s]</color>",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_buff_remove",
		"<color=#%s>%s</color>从<color=#%s>[%s]</color>身上移除",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_buff_add",
		"<color=#%s>[%s]</color>触发了<color=#%s>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_buff_damage",
		"<color=#%s>%s</color>对<color=#%s>[%s]</color>造成了<color=#%s>%d</color>点伤害",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_buff_treat",
		"<color=#%s>[%s]</color>给<color=#%s>[%s]</color>提供了<color=#%s>%d</color>点治疗",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_vigour_add",
		"<color=#%s>[%s]</color>获得了<color=#%s>%d</color>气势",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_vigour_consume",
		"<color=#%s>[%s]</color>消耗了<color=#%s>%d</color>气势",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_damage",
		"<color=#%s>[%s]</color>使用技能<color=#%s>%s</color>对<color=#%s>[%s]</color>造成了<color=#%s>%d</color>点伤害",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_treat",
		"<color=#%s>[%s]</color>使用技能<color=#%s>%s</color>给<color=#%s>[%s]</color>提供了<color=#%s>%d</color>点治疗",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_immunity",
		"<color=#%s>[%s]</color>免疫伤害",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_critical",
		"<color=#%s>[%s]</color>被暴击",
		"",
		"",
		"",
		""
	},
	{
		"battlerecord_dodge",
		"<color=#%s>[%s]</color>闪避了攻击",
		"",
		"",
		"",
		""
	},
	{
		"spriteladder_title_desc",
		"获得以下精灵即可领取对应奖励",
		"",
		"",
		"",
		""
	},
	{
		"ui_new_journey",
		"新的旅程即将开启",
		"",
		"",
		"",
		""
	},
	{
		"function_tip",
		"请先完成主线序章！",
		"",
		"",
		"",
		""
	},
	{
		"ui_item_notenough",
		"需要消耗%d个%s,您的道具不足！",
		"",
		"",
		"",
		""
	},
	{
		"ui_pretask_tips",
		"需要完成%s后才能进行这个任务",
		"",
		"",
		"",
		""
	},
	{
		"spriteladder_guide_desc",
		"<color=#%s>点击精灵头像</color>即可前往获得对应精灵",
		"",
		"",
		"",
		""
	},
	{
		"spriteladder_non_finish",
		"未达成",
		"",
		"",
		"",
		""
	},
	{
		"spriteladder_get",
		"领  取",
		"",
		"",
		"",
		""
	},
	{
		"xiuer_desc1",
		"对修尔造成",
		"",
		"",
		"",
		""
	},
	{
		"xiuer_desc2",
		"%s 万~%s 万",
		"",
		"",
		"",
		""
	},
	{
		"xiuer_desc3",
		"伤害",
		"",
		"",
		"",
		""
	},
	{
		"xiuer_desc4",
		"即",
		"",
		"",
		"",
		""
	},
	{
		"xiuer_desc5",
		"挑战胜利",
		"",
		"",
		"",
		""
	},
	{
		"jump_to",
		"前  往",
		"",
		"",
		"",
		""
	},
	{
		"wt_exppool",
		"%s万/%s万",
		"",
		"",
		"",
		""
	},
	{
		"wt_exppool2",
		"<color=#0ac775>%s万</color>/%s万",
		"",
		"",
		"",
		""
	},
	{
		"wt_absorb",
		"<color=#%s>吸收经验</color>",
		"",
		"",
		"",
		""
	},
	{
		"clg_passbefore",
		"请通过前面的关卡",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_tip1",
		"放入 <color=#df6a46>%s</color> 即可领取修炼奖励",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_levelupto1",
		"等级升至：",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_levelup1",
		"等级升：",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_gift1",
		"天赋升至:",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_gift2",
		"王者无敌",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_ji",
		"级",
		"",
		"",
		"",
		""
	},
	{
		"prize_xiulian_pet",
		"精灵",
		"",
		"",
		"",
		""
	},
	{
		"shuisheng_tip",
		"该关卡所有星星已获得，是否要再次游戏",
		"",
		"",
		"",
		""
	},
	{
		"jiugongbazhen_pettip",
		"%s等级不足，不可领取星辉奖励。\n请先给%s升至50级及以上。",
		"",
		"",
		"",
		""
	},
	{
		"story_autoplaying",
		"自动播放中",
		"",
		"",
		"",
		""
	},
	{
		"story_nextstep",
		"下一步",
		"",
		"",
		"",
		""
	},
	{
		"story_brief",
		"剧情概要",
		"",
		"",
		"",
		""
	},
	{
		"task_empty",
		"当前没有可进行的任务",
		"",
		"",
		"",
		""
	},
	{
		"tip_second",
		"秒",
		"",
		"",
		"",
		""
	},
	{
		"tip_know",
		"知道了",
		"",
		"",
		"",
		""
	},
	{
		"ball_targetnum_single",
		"单",
		"",
		"",
		"",
		""
	},
	{
		"ball_targetnum_all",
		"全",
		"",
		"",
		"",
		""
	},
	{
		"jiugongbazhen_name",
		"九宫精灵 - %s",
		"",
		"",
		"",
		""
	},
	{
		"jiugongbazhen_desc",
		"通过挑战即可获得精灵 - %s",
		"",
		"",
		"",
		""
	},
	{
		"text_hp",
		"生命",
		"",
		"",
		"",
		""
	},
	{
		"text_vigour",
		"气势",
		"",
		"",
		"",
		""
	},
	{
		"text_no_skill",
		"没有获得这个技能！",
		"",
		"",
		"",
		""
	},
	{
		"text_tiaozhanluxiang",
		"挑战录像",
		"",
		"",
		"",
		""
	},
	{
		"text_tongguanpaihang",
		"通关排行榜",
		"",
		"",
		"",
		""
	},
	{
		"text_zuijintiaozhan",
		"最近挑战",
		"",
		"",
		"",
		""
	},
	{
		"text_zhenxing",
		"阵型",
		"",
		"",
		"",
		""
	},
	{
		"text_wurenshangbang",
		"还未有人上榜，\n赶紧抢占榜单吧！",
		"",
		"",
		"",
		""
	},
	{
		"text_paiming",
		"排名",
		"",
		"",
		"",
		""
	},
	{
		"text_aoqiming",
		"奥奇名",
		"",
		"",
		"",
		""
	},
	{
		"text_jiazu",
		"家族",
		"",
		"",
		"",
		""
	},
	{
		"text_tongguanshijian",
		"通关时间",
		"",
		"",
		"",
		""
	},
	{
		"text_wodepaiming",
		"我的排名：%d",
		"",
		"",
		"",
		""
	},
	{
		"text_wodepaiming_wu",
		"我的排名：未上榜",
		"",
		"",
		"",
		""
	},
	{
		"text_luxiang",
		"录像",
		"",
		"",
		"",
		""
	},
	{
		"text_nofamily",
		"无家族",
		"",
		"",
		"",
		""
	},
	{
		"text_timeinfo",
		"%d月%d日 %02d:%02d:%02d",
		"",
		"",
		"",
		""
	},
	{
		"text_timeinfo_2",
		"%m月%d日",
		"",
		"",
		"",
		""
	},
	{
		"text_tiaozhangqming",
		"%s-%d-%d",
		"",
		"",
		"",
		""
	},
	{
		"text_zdju_useItem",
		"战斗记录播放中无法操作",
		"",
		"",
		"",
		""
	},
	{
		"text_costdimond",
		"将消耗<color=#ff0000>%d钻石</color>\n增加1次今天剩余次数",
		"",
		"",
		"",
		""
	},
	{
		"task_trigger_scene",
		"进入场景%s后开启任务",
		"",
		"",
		"",
		""
	},
	{
		"task_trigger_scene_zone",
		"进入场景%s某个特殊区域后开启任务",
		"",
		"",
		"",
		""
	},
	{
		"task_trigger_item",
		"获得道具%s后开启任务",
		"",
		"",
		"",
		""
	},
	{
		"task_trigger_challenge",
		"需要通过挑战%s关卡%s后开启任务",
		"",
		"",
		"",
		""
	},
	{
		"task_trigger_mofang",
		"魔方达到%d阶后开启任务",
		"",
		"",
		"",
		""
	},
	{
		"battleitem_unusable",
		"当前状态不能使用道具",
		"",
		"",
		"",
		""
	},
	{
		"mofang_lock_tip",
		"魔方达到<color=#e58a29>%s阶</color>后解锁<color=#e58a29>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"summoncontract_txt1",
		"%s与%s已订立召唤契约，在战斗中",
		"",
		"",
		"",
		""
	},
	{
		"summoncontract_txt2",
		"%s可召唤%s出战，",
		"",
		"",
		"",
		""
	},
	{
		"summoncontract_txt3",
		"上阵第6人，",
		"",
		"",
		"",
		""
	},
	{
		"summoncontract_txt4",
		"大幅提高战斗力！",
		"",
		"",
		"",
		""
	},
	{
		"story_chapter",
		"第%d章",
		"",
		"",
		"",
		""
	},
	{
		"chapter_end",
		"完结…",
		"",
		"",
		"",
		""
	},
	{
		"task_opentime_day",
		"第%d天开启任务",
		"",
		"",
		"",
		""
	},
	{
		"task_opentime_hours",
		"在%d小时后开启任务",
		"",
		"",
		"",
		""
	},
	{
		"task_opentime_mins",
		"在%d分钟后开启任务",
		"",
		"",
		"",
		""
	},
	{
		"click_continue",
		"点击继续",
		"",
		"",
		"",
		""
	},
	{
		"text_leave",
		"离开",
		"",
		"",
		"",
		""
	},
	{
		"tip_mail_outdate",
		"邮箱中的部分邮件，将在<color=#e58a29>明天过期</color>，过期邮件将被<color=#e58a29>销毁</color>，请您尽快查看",
		"",
		"",
		"",
		""
	},
	{
		"tip_form_auto_full_level",
		"本玩法中,已经解锁的阵法生效后自动设置为<color=#00ff00>满级</color>",
		"",
		"",
		"",
		""
	},
	{
		"tip_passed",
		"已通关",
		"",
		"",
		"",
		""
	},
	{
		"ui_story_xuzhang",
		"序章",
		"",
		"",
		"",
		""
	},
	{
		"ui_rank_refreshtime",
		"榜单每隔1分钟刷新1次",
		"",
		"",
		"",
		""
	},
	{
		"ui_rank_wtower_level",
		"%s第%d关",
		"",
		"",
		"",
		""
	},
	{
		"ui_rank_pettrain_level",
		"精灵试炼第%d关第%d小关",
		"",
		"",
		"",
		""
	},
	{
		"ui_reward_task",
		"%s奖励",
		"",
		"",
		"",
		""
	},
	{
		"ui_retreat_early",
		"现在撤退还太早了喔",
		"",
		"",
		"",
		""
	},
	{
		"ui_story_cantpass",
		"该段任务不可跳转喔",
		"",
		"",
		"",
		""
	},
	{
		"fuben_chaptertip",
		"需要通关主线关卡【第%s章 %s】",
		"",
		"",
		"",
		""
	},
	{
		"fuben_stagetip",
		"需要通关主线关卡【%s】",
		"",
		"",
		"",
		""
	},
	{
		"fuben_tasktip1",
		"需要完成主线剧情-%s",
		"",
		"",
		"",
		""
	},
	{
		"fuben_tasktip2",
		"需要完成序章剧情-%s",
		"",
		"",
		"",
		""
	},
	{
		"fuben_tasktip3",
		"需要完成第%s章主线剧情-%s",
		"",
		"",
		"",
		""
	},
	{
		"fuben_leveltip",
		"需要训练师等级达到%d级",
		"",
		"",
		"",
		""
	},
	{
		"fuben_powertip",
		"需要战斗力达到%d",
		"",
		"",
		"",
		""
	},
	{
		"text_click_skip_video",
		"再次点击视频，关闭视频",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_0",
		"一无是处",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_1",
		"十分常见",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_2",
		"百里挑一",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_3",
		"千载难逢",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_4",
		"万众瞩目",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_5",
		"王者无敌",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_6",
		"超凡入圣",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_7",
		"天纵奇才",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_8",
		"登峰造极",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_9",
		"星耀传说",
		"",
		"",
		"",
		""
	},
	{
		"tip_talent_10",
		"最强王者",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_purpose_1",
		"休闲",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_purpose_2",
		"土豪",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_purpose_3",
		"高战",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_purpose_4",
		"老奥奇",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_purpose_5",
		"肝帝",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_purpose_6",
		"欧皇",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_position_0",
		"族长",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_position_1",
		"副族长",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_position_2",
		"长老",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_position_3",
		"精英",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_position_4",
		"成员",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_declaration",
		"请修改家族宣言",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_apply",
		"申请已达上限",
		"",
		"",
		"",
		""
	},
	{
		"attr_ex",
		"属性：",
		"",
		"",
		"",
		""
	},
	{
		"job_ex",
		"职业：",
		"",
		"",
		"",
		""
	},
	{
		"exprevive_title",
		"复活药",
		"",
		"",
		"",
		""
	},
	{
		"exprevive_tips",
		"使用复活药，恢复下列所有精灵的血量",
		"",
		"",
		"",
		""
	},
	{
		"exprevive_empty",
		"没有阵亡精灵",
		"",
		"",
		"",
		""
	},
	{
		"expreviveitem_empty",
		"复活药数量不足",
		"",
		"",
		"",
		""
	},
	{
		"exprevive_emptytips",
		"没有阵亡精灵",
		"",
		"",
		"",
		""
	},
	{
		"text_refreshtime",
		"距离下次刷新：%s",
		"",
		"",
		"",
		""
	},
	{
		"rareName1",
		"初代",
		"",
		"",
		"",
		""
	},
	{
		"rareName2",
		"幻兽",
		"",
		"",
		"",
		""
	},
	{
		"rareName3",
		"超能",
		"",
		"",
		"",
		""
	},
	{
		"rareName4",
		"传说",
		"",
		"",
		"",
		""
	},
	{
		"expedition_reset",
		"失落遗迹已重置，再次进入时重新开始",
		"",
		"",
		"",
		""
	},
	{
		"expedition_reviveevent",
		"您缓步来到曙光泉水前，这圣洁的泉水散发着淡淡的光晕，昏迷不醒的伤者，喝下泉水后逐渐复苏了过来······",
		"",
		"",
		"",
		""
	},
	{
		"expedition_reviveevent_desc",
		"效果说明：随机复活1只阵亡精灵，如果没有阵亡精灵，则将最低血量精灵的血量回满",
		"",
		"",
		"",
		""
	},
	{
		"expedition_reviveall",
		"阵亡精灵已复活",
		"",
		"",
		"",
		""
	},
	{
		"network_question",
		"当前网络不佳，如果游戏不能正常运行，请退出游戏重新打开。",
		"",
		"",
		"",
		""
	},
	{
		"finish_search",
		"结束探索",
		"",
		"",
		"",
		""
	},
	{
		"con_finish_search",
		"恭喜完成本次副本",
		"",
		"",
		"",
		""
	},
	{
		"tip_family_BOSS_begin",
		"达到<color=#e58a29>%s</color>家族活跃度后，可以由族长或副族长开启魔王战。开启后%s小时内，家族成员有%s次挑战机会。",
		"",
		"",
		"",
		""
	},
	{
		"treasure_distance_tip1",
		"目前宝藏已经特别接近了，大约还有<color=#e58a29>%s米</color>左右",
		"",
		"",
		"",
		""
	},
	{
		"treasure_distance_tip2",
		"目前宝藏已经很接近了，大约还有<color=#e58a30>%s米</color>左右",
		"",
		"",
		"",
		""
	},
	{
		"treasure_distance_tip3",
		"目前宝藏还比较远，大约还有<color=#e58a31>%s米</color>左右",
		"",
		"",
		"",
		""
	},
	{
		"treasure_distance_tip4",
		"目前宝藏离你特别远哦！大约还有<color=#e58a32>%s米</color>左右才能到达附近",
		"",
		"",
		"",
		""
	},
	{
		"treasure_digging",
		"正在挖宝中…",
		"",
		"",
		"",
		""
	},
	{
		"treasure_searching",
		"正在探索中…",
		"",
		"",
		"",
		""
	},
	{
		"treasure_distance_tip5",
		"探测仪找不到宝藏距离了！好像目前距离超级超级远啊！",
		"",
		"",
		"",
		""
	},
	{
		"tips_petpiece_compose",
		"集齐%s个碎片即可在背包中合成%s",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip1",
		"世界魔王",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip2",
		"当前没有精灵陷入疲劳状态",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip3",
		"使用疲劳药水可以<color=#e58a32>消除疲劳</color>,是否使用？",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip4",
		"疲劳药水剩余数量为<color=#e58a29>0</color>",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip5",
		"精灵疲劳中，<color=#e58a29>无法上阵</color>",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip6",
		"所有疲劳状态<color=#e58a32>已消除</color>",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip7",
		"今日剩余挑战次数为<color=#e58a29>0</color>",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip8",
		"是否花费<color=#e58a29>%s钻石</color>购买1次挑战次数？",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip9",
		"未上榜",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip10",
		"第1名",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip11",
		"第%s-%s名",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip12",
		"未到开放时间",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip13",
		"购买挑战次数成功",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip14",
		"魔王挑战时间<color=#e58a29>已结束</color>",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip15",
		"未到开放时间",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip16",
		"今日购买次数<color=#e58a29>已达上限</color>",
		"",
		"",
		"",
		""
	},
	{
		"world_Boss_tip17",
		"\n每日限购<color=#e58a29>%d</color>次",
		"",
		"",
		"",
		""
	},
	{
		"settlement_tip1",
		"尝试调整精灵的站位，<color=#60ee85>输出</color>站在后排",
		"",
		"",
		"",
		""
	},
	{
		"settlement_tip2",
		"注意属性克制，属性克制可造成<color=#60ee85>130%</color>伤害",
		"",
		"",
		"",
		""
	},
	{
		"settlement_tip3",
		"<color=#60ee85>魔法攻击</color>对魔法防御低的精灵更容易造成伤害",
		"",
		"",
		"",
		""
	},
	{
		"senior_arena_tip_1",
		"每日首次进入可获得%s张入场券，最多可同时拥有%s张入场券，请收下今日的入场券吧！",
		"",
		"",
		"",
		""
	},
	{
		"senior_arena_tip_2",
		"欢迎来到冠军擂台赛",
		"",
		"",
		"",
		""
	},
	{
		"Handbookpetattribute_tip_1",
		"暂未获得该精灵",
		"",
		"",
		"",
		""
	},
	{
		"Handbookpetattribute_tip_2",
		"请提升精灵觉醒等级",
		"",
		"",
		"",
		""
	},
	{
		"signindaily_tip",
		"待配置aaaaaaaaaaaaaa",
		"",
		"",
		"",
		""
	},
	{
		"arena_3v3_give_tickets_tip",
		"每日首次进入会将入场券补齐至<color=#CD7800FF>5张</color>，请收下今日的入场券！",
		"",
		"",
		"",
		""
	},
	{
		"arena_3v3_collect_speed_title_tip",
		"获得速率:",
		"",
		"",
		"",
		""
	},
	{
		"endless_battle_tip",
		"以满阵连续进行5场战斗，尽量击败更多的敌方精灵",
		"",
		"",
		"",
		""
	},
	{
		"arena_3v3_collect_total_title_tip",
		"可领取:",
		"",
		"",
		"",
		""
	},
	{
		"longhuang_nobuff_tip",
		"当前还没玩躲避火球\n未获得战斗鼓舞",
		"",
		"",
		"",
		""
	},
	{
		"longhuang_battle_tip",
		"每次挑战都可与龙皇战斗5轮，根据5轮累积总伤害结算奖励，并会重置进度。\r\n提示：每轮战斗前都可玩【躲避火球】小游戏，获得不同强度的己阵战斗鼓舞。",
		"",
		"",
		"",
		""
	},
	{
		"longhuang_buff_tip",
		"每次战斗前都可玩<color=#FF88B2FF>【躲避火球】</color>小游戏，获得不同强度的<color=#FF88B2FF>己阵战斗鼓舞。</color>",
		"",
		"",
		"",
		""
	},
	{
		"panduola_buff_tip",
		"每次战斗前都可玩<color=#FF88B2FF>【躲避火球】</color>小游戏，获得不同强度的<color=#FF88B2FF>己阵战斗鼓舞。</color>",
		"",
		"",
		"",
		""
	},
	{
		"questionnaire_prize_tip",
		"感谢您对我们游戏的支持，希望能够得到您宝贵的意见",
		"",
		"",
		"",
		""
	},
	{
		"miya_findfault_countdown_tip",
		"请在<color=#FF4747FF>%s秒</color>内找到<color=#FF4747FF>%s处</color>不同",
		"",
		"",
		"",
		""
	},
	{
		"miya_findfault_rule_tip",
		"请在此图上点击不同之处",
		"",
		"",
		"",
		""
	},
	{
		"miya_findfault_leftTime_title",
		"剩余\n时间",
		"",
		"",
		"",
		""
	},
	{
		"miya_findfault_leftCount_title",
		"目标\n数量",
		"",
		"",
		"",
		""
	},
	{
		"miya_quizgame_countdown_tip",
		"请在<color=#FF4747FF>%s秒</color>内答对<color=#FF4747FF>%s个</color>问题！\n（共%s题）",
		"",
		"",
		"",
		""
	},
	{
		"miya_reset_mode_tip",
		"你确定要消耗%s，重抽博弈模式吗？\n重抽不会改变难度，但必定会抽到与当前不一样的模式。\r\n你确定要消耗XXX钻石（图标），重抽博弈模式吗？\r\n重抽不会改变难度，但必定会抽到与当前不一样的模式。",
		"",
		"",
		"",
		""
	},
	{
		"miya_playchess_lose_tip",
		"对弈失败！\n勇敢的冒险者，别气馁，\n再接再厉，继续来进行对弈吧！",
		"",
		"",
		"",
		""
	},
	{
		"timed_challenge_vip_tip",
		"激活<color=#B56A0DFF>VIP%s</color>特权可享受专属特权\n——%s限时挑战每天挑战次数额外多<color=#21AF74FF>%s</color>次！",
		"",
		"",
		"",
		""
	},
	{
		"timed_challenge_choose_difficulty_tip",
		"你确定要消耗%s个%s，\n进行%s难度的对弈吗？\n确定后将进行对弈模式抽取。",
		"",
		"",
		"",
		""
	},
	{
		"flipgame_tip1",
		"还未点亮哦，点亮可查看立绘并领取点亮奖励",
		"",
		"",
		"",
		""
	},
	{
		"flipgame_tip2",
		"你确定要现在退出游戏吗？\n现在退出，只能结算目前已消除的卡牌能量哦",
		"",
		"",
		"",
		""
	},
	{
		"amier_detail_tip",
		"每次挑战都可与阿米尔战斗<color=#EB4642>5轮</color>，根据5轮累积总伤害结算奖励，并会<color=#EB4642>重置进度</color>。\n注意：挑战未进行结算的话，隔天也会自动重置进度，且不会获得奖励。",
		"",
		"",
		"",
		""
	},
	{
		"family_pretech_locked",
		"请先升级<color=#EB4642>任意前置科技</color>",
		"",
		"",
		"",
		""
	},
	{
		"family_tech_player_lv_limited",
		"请先将角色等级升至<color=#EB4642>%d级</color>",
		"",
		"",
		"",
		""
	},
	{
		"family_tech_family_lv_limited",
		"已达家族等级限制，请先提升家族等级",
		"",
		"",
		"",
		""
	},
	{
		"skill_combination_shortcut",
		"合体技",
		"",
		"",
		"",
		""
	},
	{
		"pet_rent_tips",
		"出租的精灵在帮助其他玩家后，可以为您带来<color=#EB4642>友情点</color>和<color=#EB4642>金币</color>奖励",
		"",
		"",
		"",
		""
	},
	{
		"pet_hire_tips",
		"租用精灵只能用于<color=#EB4642>勇者之塔-主塔</color>、<color=#EB4642>主线剧情副本</color>、<color=#EB4642>传说挑战</color>",
		"",
		"",
		"",
		""
	},
	{
		"pet_hire_sure",
		"确定要选择<color=#B56A0DFF>%s</color>作为您的租用精灵吗？\n确认后下次重置前它将<color=#FF4747FF>不能被替换</color>哦！",
		"",
		"",
		"",
		""
	},
	{
		"expedition_normal_tips",
		"这座传送门，看上去和之前的没什么不同",
		"",
		"",
		"",
		""
	},
	{
		"expedition_hard_tips",
		"这个不同寻常的传送门，散发着<color=#EB4642>异常危险</color>的气息，暴烈、灼热的感觉迎面而来，靠近它，好像随时会被吸进去…",
		"",
		"",
		"",
		""
	},
	{
		"expedition_sweep_lv_tips",
		"训练师等级达到<color=#EB4642>25级</color>后解锁扫荡第一层功能",
		"",
		"",
		"",
		""
	},
	{
		"lightking_shengguang_result_tips",
		"勇敢的冒险者，别气馁，强化精灵，调整阵容继续来挑战吧！",
		"",
		"",
		"",
		""
	},
	{
		"lightking_yaoshi_result_tips",
		"勇敢的冒险者，别气馁，调整阵容继续来挑战吧！",
		"",
		"",
		"",
		""
	},
	{
		"lightking_jixian_result_tips",
		"勇敢的冒险者，别气馁，强化精灵，调整阵容继续来挑战吧！",
		"",
		"",
		"",
		""
	},
	{
		"scuffleTip1",
		"战略性撤退，你退出了本场战斗！",
		"",
		"",
		"",
		""
	},
	{
		"scuffleTip2",
		"对手逃跑了，你获得了本场战斗胜利！",
		"",
		"",
		"",
		""
	},
	{
		"scuffleTip3",
		"勇敢的冒险者，别气馁，调整策略继续挑战吧！",
		"",
		"",
		"",
		""
	},
	{
		"scuffleTip4",
		"当前没有正在匹配的玩家，请稍后再尝试吧！",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_nextaddscoretip",
		"下一题加分<color=#eb4642>+%d</color>",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_scores",
		"得分：%d",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_helptip_notimes",
		"剩余可用次数为<color=#e58a29>0</color>",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_help_excep_error_notimes",
		"剩余可用次数为<color=#e58a29>0</color>",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_help_excep_error",
		"每道题目只能去掉1个错误答案",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_help_tips_used",
		"每道题目只能进行1次提示",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_next_timecount",
		"下一题：%s秒",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_scores_add",
		"+%d分",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_noopened",
		"答题活动尚未开始",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_timelimits",
		"本次活动剩余答题次数已为<color=#e58a29>0</color>",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_answernum",
		"答题进度：",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_progress",
		"答题数量：%d/%d",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_rightanswer",
		"正确答案：%s",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_answerright",
		"答对：",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_answerwrong",
		"答错：",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_answermaxcombo",
		"最高连击：",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_scores_total",
		"总分：",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_result_title",
		"成绩单",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_closed",
		"趣味答题已经结束",
		"",
		"",
		"",
		""
	},
	{
		"answerscene_help_noneed",
		"已排除所有错误答案",
		"",
		"",
		"",
		""
	},
	{
		"elizabeth_game_tip",
		"快速<color=#ffffff>点击屏幕</color>吹气球，吹的越大<color=#ffffff>鲜花越多</color>。吹太大，气球<color=#ffffff>爆炸</color>不能获得鲜花哦",
		"",
		"",
		"",
		""
	},
	{
		"elizabeth_rank_tip",
		"1.通过本挑战获得伊丽莎白最快的<color=#ebad32>5999名</color>玩家，可获得<color=#ebad32>专属头像框</color>。\r\n2.根据获得时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>伊丽莎白到<color=#ebad32>聊天频道</color>显示对应<color=#ebad32>名次</color>。",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_unlock_level",
		"需要主城%d级解锁",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_locktips",
		"该建筑未解锁",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_unlock_tips",
		"您可以消耗%d%s，解锁[%s]，是否确认？",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_info",
		"信息",
		"",
		"",
		"",
		""
	},
	{
		"text_shop",
		"商店",
		"",
		"",
		"",
		""
	},
	{
		"text_upgrade",
		"升级",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_hatcheggs",
		"孵蛋",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_deployment",
		"部署",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_lostanimal_name",
		"迷失宠物",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_tree_lvdesc",
		"每个果实产出时间%d分钟，果实产出上限%d",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_amusementpark_lvdesc",
		"工位数量%d，速率系数(万分比)%d，分数上限%d",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_maincity_lvdesc",
		"宠物显示数量%d，快乐值上限%d",
		"",
		"",
		"",
		""
	},
	{
		"text_effect",
		"效果",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_lvup_max",
		"建筑已经升到最高级",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_lvup_title",
		"建筑升级",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_main_petnum",
		"宠物显示数量",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_main_happynum",
		"快乐值上限",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_workernum",
		"工位数量",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_worker_ratefactor",
		"速率系数(万分比)",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_worker_maxscore",
		"存储上限",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_fruit_interval",
		"每个果实产出需要时间(分钟)",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_fruit_max",
		"果实产出上限",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_lvup_maincity_lv_limit",
		"需要主城%d级",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_building_lvup_items_limit",
		"需要消耗%d%s，%s不足",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_goto_fiend_home",
		"您已达%s的家园",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_has_max_pet_count",
		"宠物数量已达上限",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_moral",
		"善恶值%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_comeback_home",
		"您已回到自己的家园",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_compeleted",
		"放置完成",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_absorbing",
		"已放置：%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_stealfriuts_empty",
		"还没结出果实，请稍等",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_stealfriuts_stolenover",
		"树上的果实摘不动了",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_friuts_nummax",
		"树上的果实已经长满啦",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_bestolentimes_limit",
		"这位好友已经被偷的很惨了，手下留情吧",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_stealtimes_tomax",
		"您今天已经偷累了",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_gainfriuts_empty",
		"没有果实可摘啦",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_friuts_max_timer",
		"满收集还剩:%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_cant",
		"暂不可放置",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_traveler_noback",
		"旅人出游啦 在家等他回来吧~",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_traveler_timer",
		"剩余搜索:%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_pool_absorb_max",
		"装置运行时间已满",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_pool_absorb_timer",
		"装置已运行:%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_pool_absorb_cd",
		"装置冷却中:%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_pool_absorb_empty",
		"装置空闲中",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_feed_items_noenough",
		"%s数量不足",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_feed_times_over",
		"今日已无喂食好友宠物的次数",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_interact_times_over",
		"今日互动次数已经用完",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_feed_max_level",
		"该宠物已达最高等级了",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_place_petsnum",
		"共可以选择%d/%d只宠物放置在宠物园内",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_place_petsnum_max",
		"请提升%s等级",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_place_placed",
		"放置",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_place_placed_empty",
		"当前没有放置在宠物园的宠物",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_selectpets_numtips",
		"请选择%d只宠物%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_selecteggs_numtips",
		"请选择%d个宠物蛋%s",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_selectpets_tips",
		"输入搜索宠物",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_selecteggs_tips",
		"输入搜索宠物蛋",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_selecteggs_empty",
		"搜索不到对应宠物蛋哦~",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_selectpets_empty",
		"搜索不到对应宠物哦~",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_petdetail_mathctimes",
		"仅剩%d次配对次数",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_petdetail_eggstips",
		"孵出来的宠物将获得如下基因",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_matchtimes",
		"共鸣次数：%d次",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_matchtimes_remain",
		"剩余共鸣次数：%d次",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_matchtimes_num",
		"%d次",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_matchtimes_over",
		"该宠物目前无配对次数",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_matchtimes_cd",
		"该宠物配对CD中",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_matchtimes_cd_time",
		"剩余时间：%d秒",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animalinfo_dontfollow",
		"取消跟随",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animalinfo_follow",
		"跟随",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animalinfo_follow_replacetips",
		"你确定要用<size=20><color=#263047FF>%s</color></size>替代<size=20><color=#263047FF>%s</color></size>，作为你的跟随宠物吗？",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_gradeinfo",
		"成长等级：<size=20><color=#0A87E6FF>%d</color><color=#466687FF> 级</color></size>",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_state_placed",
		"放置",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_state_follow",
		"跟随",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_state_working",
		"打工",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_cantdelete_tips",
		"当前宠物为%s状态，暂不可进行回收",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_delete_lvlimittips",
		"宠物成长等级达到%d级才可进行回收",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_delete_title",
		"回收宠物",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_animal_delete_tips",
		"你确定要回收该只宠物吗？\n一旦回收该只宠物就会消失掉，\n获得<color=#0174DEFF>%d</color>个宠物印记",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_name_fmt",
		"名字可以由<color=#ffffff>2-7个汉字、大写字母</color>，或<color=#ffffff>4-14个小写字母、数字、下划线</color>组成。",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_cantemtpy",
		"名字不能为空哦！",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_name_exist",
		"已经有宠物叫这个名字了哦",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_name_tooshort",
		"名字不能<color=#ffffff>少于2个汉字或4个字母</color>哦！",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_name_toolong",
		"名字不能长于<color=#ffffff>14个字符长度</color>",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_name_invalid",
		"名字只能由<color=#ffffff>汉字、字母、数字和下划线</color>等组成，不能含有空格或特殊符号哦！",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_name_sensitive",
		"有些字不太合适哦，再想想看？",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_all_underline",
		"不能全部是下划线哦！",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_all_number",
		"不能全部是数字哦",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_rename_success",
		"改名成功",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatch_slot_viplimit",
		"当前VIP等级未达到开放该孵化槽条件",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatch_has_stolen_time",
		"已偷取时间",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatch_stolen_owner",
		"%s的偷取器",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatch_stolen_max",
		"装置已经汲取满了",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatch_finished",
		"孵化完成",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatch_slot_egg_empty",
		"待添加",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_selecteggs_select_none",
		"未选择宠物蛋",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatch_surplustimer",
		"宠物蛋还剩%s孵化完成",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_hatchfisnish_cantcancel",
		"宠物蛋已孵化完成不可回收",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_isabsorbing",
		"别着急，先把上次的奖励领取后再放置哦~",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_nohatching",
		"太黑心啦 没有蛋在孵化还要来偷我的",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_mintime_limit",
		"孵蛋时间剩余太短啦 去其他好友家看看吧",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_in_cd",
		"汲取器还在冷却中无法使用",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_absorbed",
		"已经有一个汲取器啦",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_nofriend",
		"他已经不是你的好友啦",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_put_tips",
		"是否放置汲取器?",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_unistall",
		"卸载汲取器成功",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_absorb_prize_timelimit",
		"汲取器还没到领取时间哦",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_log_date",
		"%d月%d日",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_log_visit",
		"<color=#A66F35FF>%s</color>来访了你的家园",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_log_stealfriuts",
		"<color=#A66F35FF>%s</color>偷了你%s个果实",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_working_unlockpet_level",
		"%d级解锁",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_working_nummaxtips",
		"请先将%s升级到%d级",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_working_currratetips",
		"当前产出速率",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_working_currworkingtips",
		"已部署",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_working_production_spd",
		"%d/小时",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_friuts_num",
		"果实:%d",
		"",
		"",
		"",
		""
	},
	{
		"text_collection_progress",
		"收集进度：%d/%d",
		"",
		"",
		"",
		""
	},
	{
		"text_onekey_getall",
		"一键领取",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_head",
		"头饰",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_back",
		"背饰",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_weapon",
		"武器",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_head_sign",
		"头部标识",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_expression",
		"表情",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_clothes",
		"服饰",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_tail",
		"尾巴",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genus_work",
		"打工",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_remaintimes",
		"剩余:%d次",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_notimes",
		"今日已无配对次数",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_friend_offline",
		"该好友不在线",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_invite_counttime",
		"倒计时:%d秒",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_invite_waiting",
		"正在等待%s接受邀请......",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_invite_norespond",
		"对方未响应你的邀请",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_invite_refused",
		"对方拒绝了你的共鸣邀请",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_invite_accepted",
		"邀请成功，准备宠物共鸣",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_invite_hasrefused",
		"已拒绝",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_cancel",
		"对方取消了共鸣",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_waitingready_time",
		"倒计时:<color=#00FF00FF>%d秒</color>",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_waitingready_warningtime",
		"倒计时:<color=#FF0000FF>%d秒</color>",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_inescort",
		"护送期间不可接受配对邀请",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_noavailable",
		"该状态不可接受配对邀请",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_norespond",
		"未响应",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_handle_timecount",
		"剩余:<color=#ED4642FF>%d</color>秒",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_handle_nopets",
		"您没有可配对的宠物",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_readying",
		"准备中…",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_match_hasready",
		"已准备",
		"",
		"",
		"",
		""
	},
	{
		"text_pages_num",
		"第%d/%d页",
		"",
		"",
		"",
		""
	},
	{
		"text_none",
		"无",
		"",
		"",
		"",
		""
	},
	{
		"text_hasgot",
		"已获得",
		"",
		"",
		"",
		""
	},
	{
		"text_hasnt_got",
		"未获得",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genes_nosel_genes",
		"您尚未选择基因",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_genes_noexist_genes_animal",
		"您没有拥有该基因的宠物",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_speedcard_title",
		"使用加速卡",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_speedcard_selecttips",
		"请选择加速卡",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_speedcard_nocard",
		"加速卡数量为0",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_speedcard_hatchfinished",
		"已经孵化完成了",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_noanimals",
		"当前没有宠物",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_noeggs",
		"当前没有宠物蛋",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_shop_title",
		"宠<size=68>物</size><size=78>商</size><size=82>店</size>",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_shop_locktips",
		"商店等级%d级后解锁",
		"",
		"",
		"",
		""
	},
	{
		"petzoo_shop_coinnoenough",
		"代币不足",
		"",
		"",
		"",
		""
	},
	{
		"longnv_ch_rule",
		"1.每轮挑战<color=#C54949>扣除1次</color>挑战次数\n2.<color=#C54949>2次</color>挑战机会，<color=#C54949>击败1000万血量</color>龙女\n3.<color=#C54949>第1次</color>只能上阵<color=#C54949>水属性精灵</color>\n4.<color=#C54949>第2次</color>只能上阵<color=#C54949>暗属性精灵</color>\n5.两次伤害相差在<color=#C54949>100万以内</color>\n6.本关挑战进度<color=#C54949>每日重置</color>",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_unlockcost",
		"*%d解锁该区域",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_unlockcost_noenough",
		"需要消耗%s*%d解锁该区域，道具不足",
		"",
		"",
		"",
		""
	},
	{
		"text_requesting_svr_data",
		"正在和服务器通信中，请稍后…",
		"",
		"",
		"",
		""
	},
	{
		"text_curr_hasnum",
		"当前拥有：",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_timely_rewards",
		"每次游戏奖励预览",
		"",
		"",
		"",
		""
	},
	{
		"text_startgame",
		"开始游戏",
		"",
		"",
		"",
		""
	},
	{
		"text_remain_times",
		"剩余次数：%d",
		"",
		"",
		"",
		""
	},
	{
		"text_buytimes_tips",
		"是否消耗%d%s购买一次游戏次数？\n每天最多可以购买%d次，今天还可以购买%d次",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_exitgame_tips",
		"现在退出，将不会获得任何奖励，\n也不会扣除游戏次数，是否确认退出？",
		"",
		"",
		"",
		""
	},
	{
		"text_buytimes_max_tips",
		"今日购买次数已经上限",
		"",
		"",
		"",
		""
	},
	{
		"text_buytimes_item_noenough",
		"%s数量不足",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_unlocktips",
		"确定消耗%d%s解锁此区域？",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_propsnum",
		"积分：<color=#ffffff>%d</color>",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_gametimes_over",
		"游戏次数不足",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_getawards",
		"获得奖励",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_getprops_numtips",
		"本局积分",
		"",
		"",
		"",
		""
	},
	{
		"text_next_level_title",
		"%d级（下一等级）",
		"",
		"",
		"",
		""
	},
	{
		"text_curr_level_title",
		"%d级（当前等级）",
		"",
		"",
		"",
		""
	},
	{
		"catch_props_countingdown_time",
		"倒计时：<color=#ffffff>%ds</color>",
		"",
		"",
		"",
		""
	},
	{
		"drawequipments_title",
		"龙魂炼装",
		"",
		"",
		"",
		""
	},
	{
		"text_cost_tips",
		"消耗：",
		"",
		"",
		"",
		""
	},
	{
		"drawequipments_draw_numtips",
		"炼制%d次",
		"",
		"",
		"",
		""
	},
	{
		"drawequipments_hasdraw_numtips",
		"已炼制%d次",
		"",
		"",
		"",
		""
	},
	{
		"text_countdown_min",
		"剩余时间: %s天%s时%s分",
		"",
		"",
		"",
		""
	},
	{
		"text_countdown_second",
		"剩余时间: %s时%s分%s秒",
		"",
		"",
		"",
		""
	},
	{
		"text_rewards_review_linefeed",
		"查看\n奖励",
		"",
		"",
		"",
		""
	},
	{
		"text_rewards_review_tips",
		"查看奖励",
		"",
		"",
		"",
		""
	},
	{
		"text_hot_sell",
		"热销",
		"",
		"",
		"",
		""
	},
	{
		"text_discount_num",
		"%d折",
		"",
		"",
		"",
		""
	},
	{
		"text_rules_title",
		"规则说明",
		"",
		"",
		"",
		""
	},
	{
		"drawequipments_draw_rate",
		"炼制概率%s%%",
		"",
		"",
		"",
		""
	},
	{
		"drawequipments_draw_uprate",
		"占%s装备%s%%",
		"",
		"",
		"",
		""
	},
	{
		"checkupdetailview__space",
		"有<color=#20b376>%s%%</color>提升空间",
		"",
		"",
		"",
		""
	},
	{
		"checkupdetailview__lvl",
		"<color=#20b376>%s</color>级",
		"",
		"",
		"",
		""
	},
	{
		"checkupdetailview__awaken",
		"觉醒%s",
		"",
		"",
		"",
		""
	},
	{
		"checkupdetailview__not_awaken",
		"未觉醒",
		"",
		"",
		"",
		""
	},
	{
		"checkupdetailview__bond",
		"羁绊数量<color=#20b376>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"checkupdetailview__gift",
		"暂时没有合适的推荐礼包哦~",
		"",
		"",
		"",
		""
	},
	{
		"extremepowerview__zdl",
		"战力：<color=#eb4642>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"extremepowerview__maxZdl",
		"极限：<color=#eb4642>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"handbookpetattributeview__add",
		"%s加成",
		"",
		"",
		"",
		""
	},
	{
		"handbookpetbasicview__tips",
		"当和组合内任意一只精灵都达到%s[%s]%s时，无需同时上阵，亦可激活上阵羁绊",
		"",
		"",
		"",
		""
	},
	{
		"handbookpetbasicview__noenough_tips",
		"等级还没达到50级不可以契约",
		"",
		"",
		"",
		""
	},
	{
		"powercheckrankview__title",
		"%s战力排行榜",
		"",
		"",
		"",
		""
	},
	{
		"powercheckrankview__rankall_tips",
		"验证过的精灵且达到全服前100名方可上榜",
		"",
		"",
		"",
		""
	},
	{
		"powercheckrankview__rank_tips",
		"验证过的精灵且达到本服前100名方可上榜",
		"",
		"",
		"",
		""
	},
	{
		"powercheckview__desc",
		"当前战力已超越全服<color=#FFF836FF>%s%%</color>的玩家",
		"",
		"",
		"",
		""
	},
	{
		"powercheckview__tips1",
		"极力提升",
		"",
		"",
		"",
		""
	},
	{
		"powercheckview__tips2",
		"微弱提升",
		"",
		"",
		"",
		""
	},
	{
		"powercheckview__skill",
		"被:%s 普:%s 超:%s",
		"",
		"",
		"",
		""
	},
	{
		"powercheckview__select_pet",
		"选一个精灵，进行战力检测",
		"",
		"",
		"",
		""
	},
	{
		"powercheckview__err_tips",
		"战力检测暂未完成扫描，请稍等~",
		"",
		"",
		"",
		""
	},
	{
		"powercheck_relation",
		"羁绊详情",
		"",
		"",
		"",
		""
	},
	{
		"extremepowerview_other_tips",
		"其他养成中包含觉醒等级、图鉴、坐骑、上阵羁绊与收集羁绊都会对极限战力产生影响。",
		"",
		"",
		"",
		""
	},
	{
		"extremepowerview_other_tips_1",
		"灵纹极限战力为统一推荐属性的战力，需要淬灵属性同时拥有：攻击、物防、魔防、生命、速度；其他属性则接近极限战力。",
		"",
		"",
		"",
		""
	},
	{
		"text_reward_instruction_title",
		"奖励说明",
		"",
		"",
		"",
		""
	},
	{
		"text_integrals",
		"积分",
		"",
		"",
		"",
		""
	},
	{
		"text_integrals_num",
		"%d分",
		"",
		"",
		"",
		""
	},
	{
		"text_reward",
		"奖励",
		"",
		"",
		"",
		""
	},
	{
		"drawequip_open_tips",
		"未到开启时间！",
		"",
		"",
		"",
		""
	},
	{
		"drawequip_item_time_desc1",
		"%s.%s.%s 开启",
		"",
		"",
		"",
		""
	},
	{
		"drawequip_item_time_desc2",
		"开启中",
		"",
		"",
		"",
		""
	},
	{
		"text_refresh_all_hours",
		"每日凌晨5:00刷新",
		"",
		"",
		"",
		""
	},
	{
		"scuffle_tip1",
		"拿淬源晶石",
		"",
		"",
		"",
		""
	},
	{
		"strongestfmtcertificationview__1",
		"历史最高战力：%s",
		"",
		"",
		"",
		""
	},
	{
		"strongestfmtcertificationview__2",
		"契约精灵",
		"",
		"",
		"",
		""
	},
	{
		"strongestfmtcertificationview__6",
		"全阵战力：%s",
		"",
		"",
		"",
		""
	},
	{
		"strongestfmtcertificationview__7",
		"当前战力：%s\n极限战力：<color=#20b376>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"strongestfmtcertificationview__8",
		"未检测",
		"",
		"",
		"",
		""
	},
	{
		"strongfmtrankview__1",
		"排行榜",
		"",
		"",
		"",
		""
	},
	{
		"strongfmtrankview__2",
		"1、认证后全队战力超过400000的玩家，有机会登上<color=#C54949>全服务器排名的巅峰战力榜</color>\r\n2、成功登榜的玩家，可以获得相应的称号奖励",
		"",
		"",
		"",
		""
	},
	{
		"text_all_power",
		"全员战斗力",
		"",
		"",
		"",
		""
	},
	{
		"text_all_speed",
		"全员速度",
		"",
		"",
		"",
		""
	},
	{
		"text_activity_end",
		"活动结束",
		"",
		"",
		"",
		""
	},
	{
		"text_today_award",
		"今日已领取奖励",
		"",
		"",
		"",
		""
	},
	{
		"text_suo_timer_1",
		"剩余时间: %s天%s时%s分",
		"",
		"",
		"",
		""
	},
	{
		"text_suo_timer_2",
		"剩余时间： %s时%s分%s秒",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_chall_count",
		"镜像挑战次数",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_desc_1",
		"该挑战关卡还未解锁，请先挑战前面关卡哦！",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_desc_2",
		"当前已有辛西娅的祝福了哦！",
		"",
		"",
		"",
		""
	},
	{
		"text_today_get",
		"今日已获得",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_desc_3",
		"今天无法再获得辛西娅的祝福了哦！",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_desc_4",
		"<color=#EB4642FF>辛西娅</color>的祝福每日可使用<color=#EB4642FF>%s次</color>，\n使用后下一关挑战的属性克制效果<color=#EB4642FF>x2</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_desc_5",
		"完成全部关卡挑战后，才可重复挑战！",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_desc_6",
		"所需%s不足！",
		"",
		"",
		"",
		""
	},
	{
		"text_mirror_desc_7",
		"今日镜像挑战次数已用完！",
		"",
		"",
		"",
		""
	},
	{
		"hongliannvhuangview__1",
		"剩余挑战次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"hongliannvhuangview__2",
		"%s万",
		"",
		"",
		"",
		""
	},
	{
		"hongliannvhuangview__3",
		"今日还有挑战次数，不需要购买！",
		"",
		"",
		"",
		""
	},
	{
		"hongliannvhuangview__4",
		"今日已经通关！",
		"",
		"",
		"",
		""
	},
	{
		"hongliannvhuangview__5",
		"今日没有免费次数了，确定花费%s%s购买挑战次数吗？\n每天最多可购买%s次，还能购买%s次",
		"",
		"",
		"",
		""
	},
	{
		"hongliannvhuangview__6",
		"今日购买次数已达上限，次日5点刷新挑战次数和购买次数！",
		"",
		"",
		"",
		""
	},
	{
		"honglianzhanfangview__1",
		"全属性提升：0",
		"",
		"",
		"",
		""
	},
	{
		"liehuohonglianiview__1",
		"请先击败前面敌阵！",
		"",
		"",
		"",
		""
	},
	{
		"moyanbattleview__1",
		"活动已经结束",
		"",
		"",
		"",
		""
	},
	{
		"moyanbattleview__2",
		"距离活动结束：%s",
		"",
		"",
		"",
		""
	},
	{
		"moyanbattleview__3",
		"今日已通关！",
		"",
		"",
		"",
		""
	},
	{
		"moyanbattleview__4",
		"今日已获得：<color=#3FED11FF>%s</color>/%s",
		"",
		"",
		"",
		""
	},
	{
		"moyanmainview__1",
		"每日可领取<color=#f6f74d>%s</color>冰晶雪花",
		"",
		"",
		"",
		""
	},
	{
		"moyanmainview__2",
		"领取成功",
		"",
		"",
		"",
		""
	},
	{
		"moyanfmtrightview__1",
		"精灵已经阵亡！",
		"",
		"",
		"",
		""
	},
	{
		"moyanmainview__3",
		"前%s名\n可获得",
		"",
		"",
		"",
		""
	},
	{
		"moyanmainview__4",
		"已收集<color=#20b376>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_1",
		"还需%s次召唤才能解锁当前卡池心愿精灵！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_shenhuan",
		"神唤积分",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_zhaohuan",
		"召唤积分",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_xiaohao",
		"消耗：        x%s",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_2",
		"今日已获得免费次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_3",
		"激活金钻特权卡即可获得免费神唤次数%s次",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_4",
		"已完成所有奖励",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_5",
		"再召唤<color=#4bf95c>%s</color>次可获得",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_6",
		"此卡池已结束",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_7",
		"本卡池今日召唤已达到上限",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_8",
		"召唤精灵所需%s不足！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_9",
		"砖石不足，未补签成功！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_10",
		"今日已领取，明日可领取！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_11",
		"占传说出现概率 <color=#%s>%s%%</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_12",
		"召唤概率 <color=#%s>%s%%</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_13",
		"成功购买%s金币，赠送%s点%s积分，并额外赠送：",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_14",
		"已召唤<color=#35FF36FF>%s</color>次",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_switch",
		"准备切换",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_16",
		"已解锁其余属性召唤，现在您可以自由切换到其余召唤，至次日5点",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_choise",
		"选择",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_18",
		"消耗300钻即可解锁其余属性召唤至次日5点",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_19",
		"x%s解锁",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_lock",
		"未解锁",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_21",
		"确定要花费%s%s，解锁其余属性召唤至次日5点吗？",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_buy_tips",
		"购买提示",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_buy",
		"购买",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_15",
		"每次进行神唤可获得%s点积分",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_17",
		"每次进行召唤与友情召唤可获得积分",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_20",
		"当前积分：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_22",
		"限购：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_23",
		"还未拥有此精灵！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_24",
		"确定要花费<color=#eb4642>%s积分</color>购买<color=#eb4642>%s</color>吗？",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_25",
		"所需的积分不够！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_26",
		"购买次数不足！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_27",
		"选择你的心愿精灵，选择后占传说出现概率的<color=#20b376>%s%%</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_28",
		"已选择该精灵作为心愿精灵",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_29",
		"是否将<color=#eb4642>%s</color>作为您的心愿精灵？",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_30",
		"解锁后即可切换至其余属性召唤",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_31",
		"%s 开启",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_32",
		"开服后第%s天开启",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_33",
		"因功能调整，属性召唤将在2021年12月30日结束。后续如有更新版本上线，将在公告中告知，敬请期待！",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_34",
		"需要设置所有超级大奖后才可以开始抽奖",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_38",
		"已获得了所有大奖",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_39",
		"重置奖励",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_40",
		"本轮大奖已全部抽完，即将开始新一轮。",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_41",
		"此槽位无超级大奖可以选择",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_42",
		"限制次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_43",
		"已超过可选择奖励的限制次数",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_44",
		"奖励调整",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_45",
		"是否将%s更换成%s？",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_46",
		"请先设置超级大奖，才可进行重置",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_47",
		"是否花费%s%s重置卡池%s？（重置后，大奖进度也将重置）",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_wish_tips",
		"心愿提示",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_name",
		"体力",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_1",
		"每日限购：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_over",
		"售罄",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_free",
		"免费",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_2",
		"食用后恢复%s点体力",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_3",
		"拥有数：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_use",
		"使用",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_4",
		"今日购买已达上限！",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_5",
		"购买所需金币不足！",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_6",
		"购买所需钻石不足！",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_7",
		"可使用次数不足！",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_8",
		"体力已满",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_9",
		"主线、资源副本等玩法需花费体力。体力每<color=#CD7800FF>%s</color>分钟恢复<color=#CD7800FF>1</color>点，上限为<color=#CD7800FF>%s</color>点。",
		"",
		"",
		"",
		""
	},
	{
		"text_tili_desc_10",
		"当前体力：<color=#20B376FF>%s</color>/<color=#CD7800FF>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_1",
		"活动已结束！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_2",
		"等级达到<color=#eb4642>%s级</color>即可解锁",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_3",
		"随机%s",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_4",
		"无法放入更多材料！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_5",
		"没有任何材料可放入！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_6",
		"未满足放入的材料，无法精炼！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_7",
		"已全部选中该装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_8",
		"放入的装备已满！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_9",
		"已全部取消该装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_10",
		"已选分解道具(%s/%s)",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_11",
		"没有材料可以分解！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_12",
		"请放入分解的材料！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_analysis_tips",
		"分解提示",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_14",
		"已全部选中该材料！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_15",
		"放入材料已达到单次分解消耗上限！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_16",
		"已全部取消该材料！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_17",
		"放入材料已达到单次分解消耗上限！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_18",
		"橙色材料不可一键放入！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_19",
		"没有对应品质材料可放入！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_13",
		"没有对应品质材料可放入！",
		"",
		"",
		"",
		""
	},
	{
		"yearcard_tips",
		"※<color=#A66F35FF>4月-8月</color>为<color=#A66F35FF>原年费累充活动</color>奖励，<color=#A66F35FF>已领过</color>的奖励，<color=#A66F35FF>无法</color>再次领取哦\n激活2021年费玩家，<color=#A66F35FF>未领取过</color>，在年费卡有效期内，<color=#A66F35FF>可领取</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_buy",
		"已购买",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_all",
		"全部",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_20",
		"请勾选任意一项才能提交！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_21",
		"补充的内容超出了%s字限制！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_22",
		"当前该精灵还没有评论，赶快做第一个评论的训练师吧！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_23",
		"今日已评论该精灵！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_24",
		"精灵等级不足%s级，无法评论",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_25",
		"发送的评论内容超出%s字限制！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_26",
		"请输入评论内容再发送",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_27",
		"您已点过赞了！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_28",
		"过于频繁，请稍后在操作！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_29",
		"职业限制：",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_30",
		"属性限制：",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_31",
		"等级限制：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_32",
		"已生效",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_lv",
		"率",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_33",
		"未生效",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_34",
		"<color=#398502FF>%s</color>穿戴后，装备属性<color=#FD1616FF>+%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_35",
		"<color=#8c8c8c>该装备无特殊加成</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_36",
		"<color=#8c8c8c>%s属性精灵成功穿戴后，装备属性提升%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_37",
		"<color=#B3484BFF>%s属性精灵成功穿戴后，装备属性提升%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_38",
		"当前没有穿戴装备",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_39",
		"当前没有穿戴饰品",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_40",
		"<color=#4C6583FF>等级限制：%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_41",
		"<color=#4C6583FF>等级限制：</color><color=#E51D1DFF>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_42",
		"<color=#4C6583FF>等级限制：无</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_43",
		"未到达该装备的限制等级，无法装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_44",
		"未到达该饰品的限制等级，无法装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_45",
		"<color=#466887FF>是否把%s的【%s】替换给%s？</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_46",
		"替换确认",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_47",
		"当前没有任何装备或强化石可提供强化",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_48",
		"当前没有任何强化石可提供强化",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_49",
		"当前没有任何饰品或强化石可提供强化",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_50",
		"<color=#F3E99DFF>消耗装备时，将<color=#20B376FF>%s%%</color>继承经验</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_name",
		"装备",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_replace",
		"替换",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_51",
		"<color=#283248FF>强化消耗饰品时，将<color=#B3484BFF>%s%%</color>继承经验</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_52",
		"装备强化",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_53",
		"最大等级MAX",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_54",
		"饰品强化",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_55",
		"已经是最高星级了！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_56",
		"已达到单次强化消耗上限，无法放入更多材料！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_57",
		"已全部取消该饰品！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_58",
		"已取消该装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_59",
		"已取消该饰品！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_60",
		"已全部选中该饰品！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_61",
		"已选中该装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_62",
		"已选中该饰品！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_63",
		"已经是最高星级了！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_64",
		"没有任何材料可强化！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_65",
		"没有可放入的材料！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_66",
		"强化物品：",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_67",
		"未放入任何材料，无法强化！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_68",
		"放入材料已达到单次强化消耗上限！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_69",
		"金币不足，无法完成强化！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_70",
		"该筛选品质下没有可消耗装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_71",
		"二次确认",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_72",
		"缺少满强化装备，无法投入强化石，请先放入满强化装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_73",
		"请先放入突破材料",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_74",
		"突破的材料不足！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_75",
		"放入可突破装备",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_76",
		"请放入主装备栏中的突破装备",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_77",
		"当前没有任何符合条件的突破装备可消耗",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_78",
		"%s%%几率%s属性加成",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_79",
		"缺少满强化装备，无法突破！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_80",
		"突破提示",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_81",
		"是否消耗当前材料进行突破，突破后将消耗全部突破材料",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_tupo",
		"突破",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_82",
		"已放入了该装备为突破材料！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_83",
		"突破材料已满，不可再放入！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_84",
		"当前没有可脱下的装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_85",
		"没有可穿戴的闲置装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_86",
		"已经是当前战力最高的装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_87",
		"强化提示",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_88",
		"已放入属性石（<color=#CD7800FF>%s</color>/%s）",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_89",
		"已放入最大上限！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_90",
		"该属性已经是100%加成，无需使用！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_not_open",
		"暂未开放，敬请期待！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_91",
		"该材料没有可取消的！",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_92",
		"当前暂未有强化专属装备的的材料",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_93",
		"确认消耗%s个金色星神兑换【%s】吗？",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_94",
		"请选择需要兑换的星神",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_95",
		"请选择需要兑换的星神",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_96",
		"1.到36级后，在获得装备/星神/灵纹时，根据设置自动分解。\n2.装备分解为强化石，星神分解为星源，灵纹分解为精粹。\n3.获得奖励时，若其中有道具溢出则全通过邮件发放。",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_97",
		"4.自动分解                                     品质装备",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_98",
		"橙装选择",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_99",
		"藏品选择",
		"",
		"",
		"",
		""
	},
	{
		"text_equip_desc_100",
		"星神选择",
		"",
		"",
		"",
		""
	},
	{
		"recommendfmtcontroller__1",
		"上阵的%s必须是%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_1",
		"第一次击败曈回合数：%s回合",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_2",
		"第一次击败曈回合数：%s回合\n第二次击败曈回合数：%s回合\n达成挑战规则！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_3",
		"第一次击败曈回合数：%s回合\n第二次击败曈回合数：%s回合\n未达成挑战规则，请重新挑战！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_4",
		"你已是成功击败曈玩家！\n本次挑战中不可再获得%s！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_5",
		"你成功击败曈，通过挑战！\n当前全服剩余量为0，未获得%s！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_6",
		"你是第%s位，成功击败曈玩家！\n恭喜你获得1只%s！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_7",
		"击败敌阵所有精灵，\n本次战斗火种数：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_8",
		"本次挑战获得瞳%s/1",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_9",
		"每日参与挑战获得%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_10",
		"今天剩余次数：<color=#F84F89FF>%s</color>/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_11",
		"今日剩余/全服每日限量\n<color=#6BC9FFFF>%s</color>/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_12",
		"活动已经结束",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_13",
		"复仇之焰满足挑战条件！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_14",
		"复仇之焰不满足挑战条件！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_15",
		"恶魔双生不满足挑战条件！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_16",
		"今日挑战没有剩余量！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_17",
		"没有挑战次数可用！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_18",
		"今日购买次数已达到上限，\n次日5点刷新免费次数和购买次数！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_19",
		"确定要花费%s%s购买挑战次数吗？\n每天最多可购买%s次，还能购买%s次",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_20",
		"前%s名\n可获得",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_23",
		"通关%s！\n恭喜你获得1只%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_24",
		"你是第%s位，成功击败曈玩家！\n本次挑战中不可再获得%s！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_25",
		"普通模式",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_26",
		"地狱模式",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_28",
		"圣骑·炎神",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_29",
		"高傲的战神，眼神透露着不羁的狂气，无人可敌的力量！",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_30",
		"可获得120炎神券",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_tips",
		"提示",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_know",
		"知道了",
		"",
		"",
		"",
		""
	},
	{
		"text_battle_end",
		"战斗结束",
		"",
		"",
		"",
		""
	},
	{
		"text_battle_success",
		"挑战成功",
		"",
		"",
		"",
		""
	},
	{
		"text_battle_fail",
		"挑战失败",
		"",
		"",
		"",
		""
	},
	{
		"text_buy_tips",
		"购买提示",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_21",
		"今天剩余次数：<color=#F84F89FF>%s</color>/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_round_name",
		"回合",
		"",
		"",
		"",
		""
	},
	{
		"text_rank_notrank",
		"未上榜",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_rank_1",
		"最快通关瞳挑战的<color=#ebad32>5999名</color>玩家，可根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>瞳到<color=#ebad32>聊天频道</color>显示对应<color=#ebad32>名次</color>。",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_rank_2",
		"最快通关恶魔双生（地狱模式）的<color=#C54949>9999名</color>玩家，根据通关时间先后排名，进入地狱模式的排行榜",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_22",
		"火种总数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_tong_desc_27",
		"普通模式在9:00:00至次日5:00:00开启！",
		"",
		"",
		"",
		""
	},
	{
		"recommendfmtcontroller__2",
		"未拥有认证精灵",
		"",
		"",
		"",
		""
	},
	{
		"recommendfmtcontroller__3",
		"不大于历史最高战力，认证失败",
		"",
		"",
		"",
		""
	},
	{
		"heart_money_cat_1",
		"本次招财可能获得<color=#0174DEFF>%d-%d</color>钻石",
		"",
		"",
		"",
		""
	},
	{
		"heart_money_cat_2",
		"招财中，请稍候~",
		"",
		"",
		"",
		""
	},
	{
		"scuffle_tip2",
		"今日获得荣耀勋章已达上限，\n继续匹配对战，无法获得荣耀勋章哦！\n积分获得不受影响！",
		"",
		"",
		"",
		""
	},
	{
		"cancel",
		"取消",
		"",
		"",
		"",
		""
	},
	{
		"noahchallenge_tip1",
		"已通过神启挑战",
		"",
		"",
		"",
		""
	},
	{
		"noahchallenge_tip2",
		"是否重置所有已挑战的关卡",
		"",
		"",
		"",
		""
	},
	{
		"noahchallenge_tip3",
		"精灵疲劳，无法再使用",
		"",
		"",
		"",
		""
	},
	{
		"text_buy_commodity_tips",
		"确定购买该%s元%s吗？",
		"",
		"",
		"",
		""
	},
	{
		"text_buy_all_commodity_tips",
		"购买该礼包后将无法以%s元一键购买全部礼包，是否继续？",
		"",
		"",
		"",
		""
	},
	{
		"text_buy_all_commodity_tips_2",
		"%d元一键购买",
		"",
		"",
		"",
		""
	},
	{
		"text_activity_time_limit_d_d",
		"活动限购：%d/%d",
		"",
		"",
		"",
		""
	},
	{
		"text_buy_you_have_purchased",
		"谢谢惠顾，但该商品您已购买啦",
		"",
		"",
		"",
		""
	},
	{
		"text_countdown_dhms",
		"%d天%d时%d分%d秒",
		"",
		"",
		"",
		""
	},
	{
		"text_activity_ended_cozy_tips",
		"活动已结束，下次吧",
		"",
		"",
		"",
		""
	},
	{
		"text_activity_not_on_cozy_tips",
		"活动未开启，再忍忍",
		"",
		"",
		"",
		""
	},
	{
		"text_domainskill",
		"领域技",
		"",
		"",
		"",
		""
	},
	{
		"text_domainskill_notactive",
		"%s<color=#c1bebe>[未激活]</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_domainskill_active",
		"%s<color=#18e711>[已激活]</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_code",
		"召回码",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_1",
		"请填写召回码",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_2",
		"任务：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_3",
		"当前系统版本暂不支持该平台分享",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_4",
		"分享召回码",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_5",
		"分享成功",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_6",
		"已售罄",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_7",
		"积分获取方式",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_8",
		"积分获取方式（任务：<color=#eb4642>%s</color>/%s）",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_9",
		"共同做任务的队友还未完成！",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_10",
		"当前任务还未完成，不可领取！",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_11",
		"召回%s位",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_12",
		"你已领取了该奖励！",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_13",
		"你已经填过回归码！",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_14",
		"待加入…",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_15",
		"待完成",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_16",
		"进度：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_17",
		"策划未配置跳转配置！",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_18",
		"你是回流玩家，不可接此任务!",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_19",
		"活动已过期!",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_20",
		"还未开启此功能!",
		"",
		"",
		"",
		""
	},
	{
		"text_share_name",
		"分享",
		"",
		"",
		"",
		""
	},
	{
		"text_currency_name",
		"货币",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_21",
		"当前不可接收任务!",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_22",
		"不可重复接取任务!",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_23",
		"今日可接任务已达上限!",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_24",
		"接受成功",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_25",
		"密语已生效",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_26",
		"密语错误",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_27",
		"这是我分享的密语，复制回到游戏去填写吧：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_28",
		"密语错误！",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_29",
		"分享密语给回归好友填写生效后会获得奖励哦！",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_30",
		"这是我的密语，复制到福利-回归好礼去填写吧：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_31",
		"奥奇传说太好玩了，分享给你快复制回到游戏福利-回归去填写吧：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_32",
		"你知道奥奇传说么，快和我一起来玩吧：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_33",
		"记住你的密语发送给好友吧~",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_34",
		"好礼%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_35",
		"分享次数已达上限",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_36",
		"密语",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_37",
		"请粘贴好友分享的密语",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_38",
		"请填写正确的密语",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_39",
		"总上限次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_recall_desc_40",
		"每日次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"aceteamagent__1",
		"购买积分成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteamagent__2",
		"保存成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteamagent__3",
		"装备强化成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteamagent__4",
		"星神替换成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteamagent__5",
		"星神强化成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteamagent__6",
		"技能升级成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__1",
		"确定花费<color=#C54949>%s</color>%s更换一支新的战队吗？\n注意：更换战队后，将<color=#C54949>重置</color>原战队精灵强化\n<color=#C54949>返还</color>强化的战队积分，新战队精灵需重新强化",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__2",
		"每天只能更唤1次，今天已经更换过啦",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__3",
		"当前队伍已经使用中",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__4",
		"战斗胜利",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__5",
		"你真棒！你与你的战队获得了胜利！\n战队积分+<color=#C54949>%s</color>\n 荣耀勋章+<color=#C54949>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__6",
		"战斗失败",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__7",
		"别气馁，再接再厉！\n强化好你的战队，布阵好阵型再战！\n战队积分+<color=#C54949>%s</color>\n 荣耀勋章+<color=#C54949>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__8",
		"你的战队太强啦，刚刚没有战队跟与你一战。\n再来一次吧，这次一定行。",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__9",
		"确定要花费<color=#C54949>%s</color>积分替换换原来星神吗?",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__10",
		"今日你还能购买<color=#C54949>%s次</color>",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__11",
		"今日战队积分已达购买上限，次日5点重置",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__12",
		"战队积分+<color=#C54949>%s</color>\n荣耀勋章+<color=#C54949>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__13",
		"BOSS剩余血量：%s\n别气馁，再接再厉！\n强化号你的战队，相信下次你一定可以击败！\n%s",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__14",
		"BOSS剩余血量：%s",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__15",
		"BOSS剩余血量：%s\n你真棒！你与你的战队成功击败BOSS!\n%s",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__1",
		"BOSS遭遇战",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__2",
		"王牌激斗",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__3",
		"更换战队",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__4",
		"选择战队",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__5",
		"奇迹队、通灵师队、神曜梦之队、终焉龙队任你选，超多好礼任你兑\n少年，你准备好了吗？\n打造你的王牌战队，争夺最高荣耀吧！",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__6",
		"战队等级：<color=#A66006FF>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__7",
		"总获得荣耀勋章：<color=#A66006FF>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__8",
		"你还未布阵哦，布阵好阵型再开始激斗吧！",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__9",
		"剩余时间：%s天%s时%s分",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__10",
		"确定要花费<color=#ebad32>%s%s</color>购买1次吗？",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__11",
		"今日剩余：%d/%d",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__12",
		"还有挑战次数,不需要购买次数",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__13",
		"今日已达最大购买次数，次日5点重置",
		"",
		"",
		"",
		""
	},
	{
		"actstargodchangeview__1",
		"消耗：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"actstargodchangeview__2",
		"切换星神成功",
		"",
		"",
		"",
		""
	},
	{
		"actstargodchangeview__3",
		"精灵身上已经有此类型星神",
		"",
		"",
		"",
		""
	},
	{
		"matchingpopupview__1",
		"取消匹配",
		"",
		"",
		"",
		""
	},
	{
		"matchingpopupview__2",
		"未匹配到玩家",
		"",
		"",
		"",
		""
	},
	{
		"matchingpopupview__3",
		"匹配失败",
		"",
		"",
		"",
		""
	},
	{
		"matchingpopupview__4",
		"匹配成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteambuzhenleftview__1",
		"阵法功能未解锁",
		"",
		"",
		"",
		""
	},
	{
		"aceteammissionview__1",
		"确定",
		"",
		"",
		"",
		""
	},
	{
		"aceteammissionview__2",
		"一键布阵",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__1",
		"请放入<color=#20b376>%s</color>只<color=#20b376>%s</color>(<color=#%s>%s</color>/%s)",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__2",
		"当前精灵觉醒等级已经最高",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__3",
		"当前精灵已经满觉醒",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__4",
		"确认消耗<color=#C54949>%s</color>战队积分将觉醒等级\n由<color=#C54949>Lv%s</color>强化到<color=#C54949>Lv%s</color>吗？",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__5",
		"\n下一次<color=#C54949>Lv%s</color>强化到<color=#C54949>Lv%s</color>需消耗<color=#C54949>%s</color>战队积分",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__6",
		"当前精灵觉醒不需要升级",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__7",
		"觉醒所需的%s不足",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__8",
		"请先选中足够的觉醒所需精灵或者材料",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__9",
		"该精灵已满觉醒",
		"",
		"",
		"",
		""
	},
	{
		"aceteamequipview__1",
		"确认消耗<color=#C54949>%s</color>战队积分将该装备部位培养等级\n由Lv<color=#C54949>%s</color>强化到Lv<color=#C54949>%s</color>吗？",
		"",
		"",
		"",
		""
	},
	{
		"aceteamequipview__2",
		"当前装备已满级",
		"",
		"",
		"",
		""
	},
	{
		"aceteampetskillview__1",
		"精灵达到%d级后解锁升级",
		"",
		"",
		"",
		""
	},
	{
		"aceteampetskillview__2",
		"%d级",
		"",
		"",
		"",
		""
	},
	{
		"aceteampetskillview__3",
		"精灵等级需要达到%s时才可以升级此技能",
		"",
		"",
		"",
		""
	},
	{
		"aceteampetskillview__4",
		"确认消耗<color=#C54949>%s</color>战队积分将该技能\n由Lv<color=#C54949>%s</color>强化到Lv<color=#C54949>%s</color>吗？",
		"",
		"",
		"",
		""
	},
	{
		"aceteampetskillview__5",
		"当前技能已满级",
		"",
		"",
		"",
		""
	},
	{
		"aceteamshowview__1",
		"我的战队积分：%s",
		"",
		"",
		"",
		""
	},
	{
		"aceteamstargodview__1",
		"确认消耗<color=#C54949>%s</color>战队积分将该星神\n由<color=#C54949>Lv%s</color>强化到<color=#C54949>Lv%s</color>吗？",
		"",
		"",
		"",
		""
	},
	{
		"aceteamstargodview__2",
		"当前星神已满级",
		"",
		"",
		"",
		""
	},
	{
		"aceteamstargodview__3",
		"增加",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__1",
		"个人实力榜",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__2",
		"战队实力榜",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__3",
		"区服",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__4",
		"奥奇名称",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__5",
		"总荣耀勋章",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__6",
		"战队总实力",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__7",
		"战队名称",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__8",
		"我的战队",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__9",
		"1.在本玩法中累计获得<color=#ebad32>总荣耀勋章</color>上榜，活动结束后，按最终结算名次邮件发奖。\n2.此为全服务器排名，榜单显示前100名，每10分钟刷新。",
		"",
		"",
		"",
		""
	},
	{
		"aceteamrankview__10",
		"战队使用的人越多、获得荣耀勋章越多，战队总实力越高哦！每10分钟刷新。",
		"",
		"",
		"",
		""
	},
	{
		"aceteamruleview__1",
		"1、本活动使用的精灵均为系统精灵，仅限在本活动使用\n每日开放时间：09:00-24:00，00:00-02:00\n\n2、玩法规则\n①先选择战队，每天只能更换<color=#C54949>一次</color>战队，更换时需<color=#C54949>消耗100</color>钻石\n②战队成员精灵初始等级为<color=#C54949>100级</color>\n③更换战队后，将<color=#C54949>重置</color>原战队精灵强化，<color=#C54949>返还</color>全部强化消耗的战队积分，新战队精灵需<color=#C54949>重新</color>强化\n④根据<color=#C54949>战队等级</color>开启星神、潜能、装备、觉醒培养强化（详细请查看战队等级）\n⑤培养战队精灵强化，需消耗<color=#C54949>战队积分</color>\n⑥使用强化的战队精灵，布阵好阵型，参与<color=#C54949>全服匹配</color>对战\n⑦每日免费匹配次数<color=#C54949>10次</color>，次数用完，可花钻石购买<color=#C54949>5次</color>\n⑧源起精灵的源起技都生效源核三个末端节点的第一个效果\n\n3、如何获得战队积分和荣耀勋章\n①参与全服匹配对战\n胜利可获得<color=#C54949>800</color>战队积分、<color=#C54949>50</color>荣耀勋章\n平局可获得<color=#C54949>600</color>战队积分、<color=#C54949>30</color>荣耀勋章\n失败可获得<color=#C54949>400</color>战队积分、<color=#C54949>20</color>荣耀勋章\n②BOSS遭遇战\n每次匹配对战完，概率触发BOSS挑战，每日触发上限<color=#C54949>3次</color>（免费匹配次数用完，必定可触发满BOSS挑战）\n胜利可获得<color=#C54949>1000</color>战队积分和<color=#C54949>400</color>荣耀勋章\n失败可获得<color=#C54949>500</color>战队积分和<color=#C54949>200</color>荣耀勋章\n③钻石购买战队积分 \n<color=#C54949>20钻石=200战队积分</color>，每日最多购买<color=#C54949>1000</color>战队积分\n\n4、战队积分用于培养战队精灵；\n\n5、排名奖励\n活动期间内，累计获得总荣耀勋章上榜，活动结束后，发放排名奖励",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__16",
		"你确定要选择<color=#C54949>%s</color>战队吗？\n选择后将与它们并肩作战，在王牌争霸赛上与其他战队竞技！\n\n1.每天只能更换<color=#C54949>一次</color>战队，需消耗<color=#C54949>钻石</color>更换\n2.更换后，<color=#C54949>重置</color>原战队精灵强化，<color=#C54949>返还</color>强化的战队积分，新战队精灵需重新强化",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__14",
		"圣骑神器自选箱",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__10",
		"消耗:%s",
		"",
		"",
		"",
		""
	},
	{
		"aceteamawakeview__11",
		"觉醒成功",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__15",
		"当前没有挑战次数了，是否花费<color=#ebad32>%s%s</color>购买1次挑战机会？",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__16",
		"开放时间：09:00-24:00，00:00-02:00！",
		"",
		"",
		"",
		""
	},
	{
		"aceteammainview__17",
		"今日次数已用完，次日5点重置次数",
		"",
		"",
		"",
		""
	},
	{
		"divineevolve_tip1",
		"暂无可神启的精灵",
		"",
		"",
		"",
		""
	},
	{
		"aceteamcontroller__17",
		"更换战队成功！\n已返还强化消耗的全部战队积分！",
		"",
		"",
		"",
		""
	},
	{
		"aceteambossview__1",
		"<color=#ebad32>%s次</color>挑战机会，使用你的战队精灵布阵进行挑战",
		"",
		"",
		"",
		""
	},
	{
		"aceteambossview__2",
		"战斗胜利：战队积分<color=#ebad32>+%s</color>，荣耀勋章<color=#ebad32>+%s</color>\n战斗失败：战队积分<color=#ebad32>+%s</color>，荣耀勋章<color=#ebad32>+%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"aceteamformationview__1",
		"本活动，召唤师不能<color=#ebad32>解除</color>契约、不能<color=#ebad32>更换</color>契约精灵；需<color=#ebad32>同时上阵</color>才能触发羁绊效果！",
		"",
		"",
		"",
		""
	},
	{
		"heart_grow_up_right_time",
		"%d月%d日 %02d:%02d:%02d开启",
		"",
		"",
		"",
		""
	},
	{
		"heart_grow_up_tip_title",
		"%s提升",
		"",
		"",
		"",
		""
	},
	{
		"heart_grow_up_tip_desc",
		"是否消耗%d印记把【%s】升至满级？",
		"",
		"",
		"",
		""
	},
	{
		"heart_grow_up_tip_strengthen",
		"需要先提升%s的%s，或印记不足",
		"",
		"",
		"",
		""
	},
	{
		"heart_grow_up_tip_strengthen_ed",
		"%s的%s已经提升",
		"",
		"",
		"",
		""
	},
	{
		"nian_chall_main_name",
		"念念挑战",
		"",
		"",
		"",
		""
	},
	{
		"nian_chall_main_rule",
		"1、活动期间内，完成念念挑战累计进度可领取奖励。\r\n2、满足<color=#C54949>成长之路-念念</color>条件即可挑战，不限次数。\r\n3、每日可升级<color=#C54949>挑战祝福</color>，助你更快通关挑战。\r\n4、领取念念宝箱等奖励后挑战入口消失。",
		"",
		"",
		"",
		""
	},
	{
		"nian_chall_fmt_tip",
		"念念将不占上阵数助战",
		"",
		"",
		"",
		""
	},
	{
		"nian_chall_stage_select_tip",
		"念念能力尚未符合，是否前往成长之路加强念念",
		"",
		"",
		"",
		""
	},
	{
		"nian_chall_enter_stage_tip",
		"尚未获得念念，是否前往成长之路获取 ",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_limit_tip",
		"今日上限：%d/%d",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_daily_prize",
		"已领取每日奖励",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_achievement_prize",
		"再升%d级可领取",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_part_tip",
		"未满足部件强化条件",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_refining",
		"还差<color=#20b376>%d</color>级，即可炼制获得【火系橙+1自选】",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_refining_ing",
		"未满足炼制条件",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_refining_ed",
		"已炼制完成",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_achievement_prize_ed",
		"当前可领取",
		"",
		"",
		"",
		""
	},
	{
		"nian_welfare_achievement_task_desc",
		"冶炼总等级达到%d级",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_1",
		"希妮安挑战未满足条件！",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_2",
		"未获得心心或念念",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_3",
		"希妮安挑战满足条件！",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_4",
		"心心念念挑战回合次数一样时才可以进入挑战",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_6",
		"本次战斗回合数:%d",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_7",
		"原回合数:%d",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_8",
		"双生合体不满足条件",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_9",
		"挑战回合：%d",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_10",
		"合体\n挑战",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_11",
		"双生\n合体",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_12",
		"心心念念需要培养满等级、星神、潜能和觉醒",
		"",
		"",
		"",
		""
	},
	{
		"twin_dragon_challenge_13",
		"精灵\n详情",
		"",
		"",
		"",
		""
	},
	{
		"redstargodsellview_1",
		"时间未到，暂时无法购买",
		"",
		"",
		"",
		""
	},
	{
		"redstargodsellview_2",
		"活动已结束，无法购买",
		"",
		"",
		"",
		""
	},
	{
		"today_remaintimes",
		"今天剩余%s次",
		"",
		"",
		"",
		""
	},
	{
		"text_noneed_buyplaytimes",
		"今日还有免费次数，无需购买！",
		"",
		"",
		"",
		""
	},
	{
		"text_summontower_sweeptips",
		"确定消耗%d次冒险次数，直接扫荡吗？\r\n按你单次最高冒险积分进行结算\r\n可获得冒险积分：<color=#ff0000>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_countdown_notips_min",
		"%s天%s时%s分",
		"",
		"",
		"",
		""
	},
	{
		"text_countdown_notips_second",
		"%s时%s分%s秒",
		"",
		"",
		"",
		""
	},
	{
		"text_summontower_itemtips",
		"拿%d%s",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_careername_guang",
		"光系召唤师",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_careername_an",
		"暗系召唤师",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_careername_shui",
		"水系召唤师",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_careername_huo",
		"火系召唤师",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_careername_cao",
		"草系召唤师",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_master_noseltips",
		"请选择一位召唤师与你一起冒险！",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_master_seltips",
		"确认选择<color=#ff0000>%s</color>与你一起并肩作战吗？",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_master_selsuccess",
		"与你的召唤师并肩作战，开始你们的冒险吧！",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_scores_rewardstips",
		"游戏结束\r\n1、召唤师阵亡，无复活石，游戏结束\r\n2、全部精灵阵亡，无复活石，游戏结束\r\n3、全部通关，游戏结束\r\n\r\n冒险积分获得\r\n1、每次游戏结束后，以该次冒险所得计算冒险积分\r\n2、积分=关卡x100+召唤师获取经验x0.1+剩余银币x0.1\r\n3、首次通关后，可<color=#EB4642FF>开启扫荡</color>，直接结算获得<color=#EB4642FF>历史最高</color>冒险积分\r\n4、使用扫荡不会增加召唤师经验哦\r\n5、冒险积分可在右下角【兑换】处，<color=#EB4642FF>兑换</color>珍稀道具",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_rank",
		"第%d名",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_rank_range",
		"第%d-%d名",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_ranksreward_tips",
		"此为全服排名，奖励于活动结束后通过邮件发放，名字按最终结算名次为准！",
		"",
		"",
		"",
		""
	},
	{
		"text_summon_firstpassreward_tips",
		"首次通关对应关卡可领取对应奖励",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_shop_tips",
		"温馨提示：商店的商品<color=#eb4642>类型</color>和<color=#eb4642>价格</color>会<color=#eb4642>变动</color>，要考虑性价哦！",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_shop_bubbletips",
		"在这摆摊可不安全，价格贵一点也不能怪我嘛",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_protagonisthalo_zhishouhuajiao",
		"指手画脚",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_protagonisthalo_yanshuodashi",
		"演说大师",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_eff_zhanshudaquan",
		"每<color=#ebad32>1本</color>战术大全提升<color=#ebad32>%s%%</color>全属性及生命上限，每5本效果转化为<color=#ebad32>%s%%</color>",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_eff_yanjiangzhishu",
		"每拥有多<color=#ebad32>1本</color>演说之书，招揽精灵事件触发概率提升<color=#ebad32>%s%%</color>",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_eff_zhanshudaquan_all",
		"进入战斗时，己阵精灵全属性提升<color=#ebad32>%s%%</color>",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_eff_yanjiangzhishu_all",
		"击败守卫时，<color=#ebad32>%s%%</color>概率触发招揽精灵事件",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_selwish",
		"请选择愿望",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_revivetips",
		"以下精灵阵亡，请选择要复活的精灵，未复活的精灵将消失哦！",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_summonmasterrevivetips",
		"你的召唤师阵亡了，需要使用1个复活石复活！",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_startgame",
		"开始冒险",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_continuegame",
		"继续冒险",
		"",
		"",
		"",
		""
	},
	{
		"txt_summontower_buyguard",
		"确定花费%d银币买通守卫吗？\n买通等同于战胜守卫，有一定几率触发精灵招揽事件哦！",
		"",
		"",
		"",
		""
	},
	{
		"timewheel_tip1",
		"该精灵穿戴红星不可进行溯源",
		"",
		"",
		"",
		""
	},
	{
		"timewheel_tip2",
		"点击图标可取消",
		"",
		"",
		"",
		""
	},
	{
		"timewheel_tip3",
		"部分精灵无法通过使用时间之轮对应的消逝、重置、倒退或溯源功能以获得材料返还。",
		"",
		"",
		"",
		""
	},
	{
		"stargodplusexchange1",
		"冷却时间未到",
		"",
		"",
		"",
		""
	},
	{
		"stargodplusexchange2",
		"未达到金色星神所需数量",
		"",
		"",
		"",
		""
	},
	{
		"stargodplusexchange3",
		"请选择兑换所需消耗的金色星神",
		"",
		"",
		"",
		""
	},
	{
		"stargodplusexchange4",
		"暂未有金色星神",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_1",
		"恭喜你对捣蛋鬼限时boss造成了<color=#ff0000>%s</color>的伤害！",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_2",
		"总伤害值达到%s",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_3",
		"每日奖励已领取，不可重复领取！",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_4",
		"今天还没有对boss造成伤害噢，挑战过后即可领取每日奖励！",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_5",
		"<color=#ff0000>%s</color>伤害可领",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_6",
		"%s在挑战捣蛋鬼首领时，可以拥有%s的效果加成！",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_7",
		"知道了（%ss)",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_8",
		"已激活",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_9",
		"完成任务后可激活",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_10",
		"击败捣蛋鬼数量：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_11",
		"未达到领取条件",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_12",
		"10.29-11.11期间，周五/六/日开启捣蛋鬼限时boss，敬请期待！",
		"",
		"",
		"",
		""
	},
	{
		"text_halloween_desc_13",
		"活动期间总成绩：<color=#CD7800FF>%s</color>\n今日最高战绩：<color=#CD7800FF>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"athena_challenge_tip_1",
		"今天已经升级过祝福了，请明天再来吧~",
		"",
		"",
		"",
		""
	},
	{
		"athena_challenge_tip_2",
		"祝福等级已经最高了",
		"",
		"",
		"",
		""
	},
	{
		"athena_challenge_tip_3",
		"武力挑战",
		"",
		"",
		"",
		""
	},
	{
		"athena_challenge_tip_4",
		"请先通过前面关卡",
		"",
		"",
		"",
		""
	},
	{
		"athena_challenge_tip_5",
		"是否花费%d钻石全通智慧挑战？",
		"",
		"",
		"",
		""
	},
	{
		"athena_challenge_tip_6",
		"是否花费%d钻石通过当前关？",
		"",
		"",
		"",
		""
	},
	{
		"text_biaoqing_desc_1",
		"需要购买礼包解锁",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_1",
		"%s年%s月%s日",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_2",
		"挑战次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_3",
		"特殊奖励剩余份数：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_4",
		"已经全部通关",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_5",
		"请先通关前面关卡",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_6",
		"挑战次数不足",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_7",
		"还有挑战次数",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_8",
		"今天所有的挑战次数已经用完，可以购买更多次数继续挑战。确定要花费<color=#ebad32>%s%s</color>购买挑战次数吗？\n每天可以购买%s次，当前剩余购买次数：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_9",
		"%s %s层-%s关",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_10",
		"%s %s层·第%s关",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_11",
		"您已到达第%s层",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_12",
		"圣骑并肩作战，专属祝福",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_13",
		"通关即可获得大奖",
		"",
		"",
		"",
		""
	},
	{
		"text_wltower_desc_14",
		"上阵对应圣骑精灵，可以激活以下精灵的伤害加成效果",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_1",
		"本周:%d/%d次",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_2",
		"每日:%d/%d次",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_3",
		"弥雅礼物材料不够啦，正在采购中\n下次见面时间：%d月%d日-%d月%d日",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_4",
		"小诺已经收到你的所有礼物了",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_5",
		"明日再来吧~",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_6",
		"%s后记得回来找我哦",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_7",
		"还没到时间哦~",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_8",
		"制作完毕",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_9",
		"上一个礼物还未制作",
		"",
		"",
		"",
		""
	},
	{
		"celebrate_birthday_10",
		"快和我一起制作礼物送给小诺吧",
		"",
		"",
		"",
		""
	},
	{
		"text_The_What_Day",
		"第%s天",
		"",
		"",
		"",
		""
	},
	{
		"text_LotteryBox_Tips_No",
		"【%s】不足，无法开启礼盒哦~",
		"",
		"",
		"",
		""
	},
	{
		"text_write_phone",
		"请绑定手机号后允许接收奥奇秘闻",
		"",
		"",
		"",
		""
	},
	{
		"materialchallenge_desc1",
		"每日翻倍：",
		"",
		"",
		"",
		""
	},
	{
		"materialchallenge_desc2",
		"今日免费翻倍次数：",
		"",
		"",
		"",
		""
	},
	{
		"petshowinfostacknew__shuangsheng",
		"双生精灵共享等级，觉醒，潜能，星神养成，不同形态下拥有各自的装备，如果两个形态都是相同职业和属性，将会自动装备上相同的装备，无需额外装备。",
		"",
		"",
		"",
		""
	},
	{
		"winner_challenge_1",
		"大咖抽奖券不足",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_Formation_Tips_1",
		"大咖挑战赛布阵页面，开始挑战后将不可再更改布局",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_Formation_Tips_2",
		"上阵精灵不足%s只，点击保存后无法再次更改布阵，是否继续？",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_Formation_Tips_3",
		"确认布阵后，本轮挑战不可更换布阵，是否确认保存？",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_Formation_Tips_4",
		"空阵不能保存",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_mission_Tips_1",
		"击败敌阵所有精灵",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_mission_Tips_2",
		"无完美通关条件",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_SuccessView_Tips_1",
		"累计失败：%s/%s场",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_FailSimpleView_Tips_1",
		"累计胜利：%s场",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_FailSimpleView_Tips_2",
		"累计失败：<color=%s>%s</color>/%s场",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_HallView_Tips_1",
		"活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_HallView_Tips_2",
		"敌阵玩家数据均来源于竞技场排行前<color=%s>%s</color>名的玩家数据",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_HallView_Tips_3",
		"失败场次数达到限制，无法进入挑战",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_HallView_Tips_4",
		"当天挑战轮数达到%s，无法进入挑战",
		"",
		"",
		"",
		""
	},
	{
		"text_a_success",
		"胜",
		"",
		"",
		"",
		""
	},
	{
		"text_a_fail",
		"败",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_RankView_Tips_1",
		"未上榜",
		"",
		"",
		"",
		""
	},
	{
		"FunArena_RankView_Tips_2",
		"%d月%d日\n%02d:%02d:%02d",
		"",
		"",
		"",
		""
	},
	{
		"FunArenaView_Tips_1",
		"今日次数已用完 明日再来",
		"",
		"",
		"",
		""
	},
	{
		"Fun_LotteryView_Tips_1",
		"抽奖中",
		"",
		"",
		"",
		""
	},
	{
		"Fun_LotteryView_Tips_2",
		"抽奖券每周重置\n剩余时间：",
		"",
		"",
		"",
		""
	},
	{
		"Fun_LotteryView_Tips_3",
		"%02d天 %02d小时",
		"",
		"",
		"",
		""
	},
	{
		"Fun_LotteryView_Tips_4",
		"%02d小时 %02d分钟",
		"",
		"",
		"",
		""
	},
	{
		"Fun_LotteryView_Tips_5",
		"%02d分钟 %02d秒",
		"",
		"",
		"",
		""
	},
	{
		"Fun_LotteryView_Tips_6",
		"%02d秒",
		"",
		"",
		"",
		""
	},
	{
		"Fun_LotteryView_Tips_7",
		"当前抽奖次数：%s次",
		"",
		"",
		"",
		""
	},
	{
		"Fun_SpecialRewardView_Tips_1",
		"连胜%s场",
		"",
		"",
		"",
		""
	},
	{
		"Fun_SpecialRewardView_Tips_2",
		"未达成领取条件噢~",
		"",
		"",
		"",
		""
	},
	{
		"race_kong",
		"空",
		"",
		"",
		"",
		""
	},
	{
		"race_chuang",
		"创",
		"",
		"",
		"",
		""
	},
	{
		"chuangkongunion_text_1",
		"创/空考验 第%d关",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_1",
		"召唤提示",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_2",
		"是否确定进行精灵召唤？",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_3",
		"当前剩余：      %s",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_4",
		"请选择抽奖次数",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_5",
		"单次抽奖次数超出",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_6",
		"超过了今日的上限次数",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_7",
		"2月4号开启超神召唤",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_8",
		"2月4号前购买\n超神龙全额返钻",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_9",
		"精灵直购\n全额返钻",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_10",
		"暂无玩家上榜",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_11",
		"<color=#ffd74a>稀有道具</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_12",
		"<color=#df4dff>珍稀道具</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_13",
		"<color=#1cc2ff>普通道具</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_desc_14",
		"2月25日前获得\n无限未来可额外获得",
		"",
		"",
		"",
		""
	},
	{
		"red_pocket_leave",
		"每次可以至多领取4个红包，目前还可以接着领取。若离开的话，本次红包无法再领取，确定要离开吗？",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_1",
		"投票活动已结束！",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_2",
		"女神觉醒将于3月18日5:00开启，请先投票选出最高人气女神，我们将为最高人气女神打造神器装备！",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_3",
		"投票结束",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_4",
		"是否确认消耗一张<color=#EB4642FF>%s</color>为<color=#EB4642FF>%s</color>投出宝贵的一票，并获得<color=#EB4642FF>%s</color>奖励？",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_5",
		"投票提示",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_6",
		"%s不足，请先购买！",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_7",
		"拥有：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_8",
		"每日限购次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_9",
		"是否花费%s%s购买%s*%s，为你心仪的女神投票？",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_10",
		"今日购买次数已使用完",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_11",
		"请添加购买次数",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_12",
		"草果了每日限制次数",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_13",
		"购买所需%s不足",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_14",
		"人气：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_15",
		"本周礼物已做完",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_16",
		"今日剩余制作礼物次数：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_17",
		"进度奖励\n%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_18",
		"奖励不可重复领取",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_19",
		"未达到领取要求",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_20",
		"请选择食材",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_21",
		"最多可选择四种礼物",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_22",
		"制作不同品质的礼物需要的材料数量：",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_23",
		"S级礼物：4个礼物",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_24",
		"A级礼物：3个礼物",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_25",
		"B级礼物：2个礼物",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_26",
		"今日礼物：",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_27",
		"材料",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_28",
		"分享配方",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_29",
		"%s %s*1",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_30",
		"当前进度",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_31",
		"该礼物还未解锁",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_32",
		"礼物制作成功",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_33",
		"礼物制作失败",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_34",
		"距离成功就差一点点！再接再厉呀！",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_35",
		"太棒了！你成功做出了[%s]\n配方：%s\n本礼物不在今日礼物单中，礼物配方已解锁，不增加收集进度",
		"",
		"",
		"",
		""
	},
	{
		"text_goddess_desc_36",
		"太棒了！你成功做出了[%s]\n配方：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_1",
		"点亮整幅拼图才可以领取大奖奖励哦！",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_2",
		"同心宝石不足，完成任务可获得！",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_3",
		"点击拼图点亮，每次点亮消耗35同心宝石，并获得1W金币奖励。点亮整幅拼图即可领取大奖。",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_4",
		"点亮所有拼图后，剩余的同心宝石可进行抽奖。点击宝箱即可抽奖，每次抽奖消耗35同心宝石。",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_5",
		"同心宝石不足，完成任务可获得！",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_6",
		"共%s宝石",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_7",
		"点亮拼图",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_8",
		"获得宝石",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_9",
		"%s.%s 5:00后开启",
		"",
		"",
		"",
		""
	},
	{
		"text_annual_desc_10",
		"抽奖",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip1",
		"当前积分:<color=#F8D200FF>%d</color>",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip2",
		"已通关关卡：<color=#5EECF5FF>%d</color>",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip3",
		"剩余次数：%d",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip4",
		"第%s关",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip5",
		"游戏次数已用尽",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip6",
		"关卡将于\n%02d.%02d 05:00\n开启",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip7",
		"关卡将于%02d.%02d 05:00开启",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip8",
		"请通关前置关卡",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip9",
		"退出游戏后不会保留本关进度，是否确认退出游戏",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip10",
		"当前已经是初始状态",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip11",
		"是否确认重置所有进度并开始游戏",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip12",
		"材料不足, 请前往活动获取",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip13",
		"是否消%s*%d，给游戏新增一盒空珠盘（珠盘只限单局使用，一局最多只能使用一次）",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip14",
		"后退次数已用尽",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip15",
		"积分 +%d",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip16",
		"后退(%d/%d)",
		"",
		"",
		"",
		""
	},
	{
		"makecake_tip17",
		"给游戏新增一盒空珠盘（珠盘只限单局使用，一局最多只能使用1次）",
		"",
		"",
		"",
		""
	},
	{
		"text_hjsl_desc",
		"紧急通知，奥奇城遭遇未知力量侵袭，力量神柱逐渐崩塌，近来年来，奥奇城从未出现如此大的变动，真相究竟如何……\n面对即将到来的灾难，五王需要我们的支援！守护奥奇城，修复力量神柱，迫在眉睫！",
		"",
		"",
		"",
		""
	},
	{
		"CrazyPartnerRankView__1",
		"今日积分",
		"",
		"",
		"",
		""
	},
	{
		"CrazyPartnerRankView__2",
		"总积分",
		"",
		"",
		"",
		""
	},
	{
		"CrazyPartnerRankView__3",
		"前100名可上榜，累计今日获得积分排名，每日5点重置",
		"",
		"",
		"",
		""
	},
	{
		"CrazyPartnerRankView__4",
		"前100名可上榜，累计活动期间内获得积分排名",
		"",
		"",
		"",
		""
	},
	{
		"text_whlz",
		"关卡内拥有未领取的宝箱奖励，是否进入下一关？",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestResultView__1",
		"神射手 达成%d次",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestResultView__2",
		"再接再厉！",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestResultView__3",
		"获得进度：",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestResultView__4",
		"神射手：",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestResultView__5",
		"总积分：",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestRecordView__1",
		"获得进度 %d",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestRecordView__2",
		"获得进度 %d",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMyGamePanel__1",
		"您的发射次数不足哦~",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMyGamePanel__2",
		"神射手 等等他吧....",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestGamePanel__1",
		"玩家好像受到其他神秘力量的封印 离线中…",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestGamePanel__2",
		"第%d/%d关",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestGamePanel__3",
		"积分：<color=\"black\">%d</color>",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestHandler__1",
		"不在游戏中",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestHandler__2",
		"未匹配成功",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestGameView__1",
		"退出游戏后不会获得积分，是否确认退出游戏",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestGameView__2",
		"关卡时间：%d秒",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMainView__1",
		"游戏次数不足，明日再来。",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMainView__2",
		"不在活动时间内",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMainView__3",
		"次数 %s/%d",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMainView__4",
		"你的操作太快了 慢一点 剩%d秒",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMainView__5",
		"%d点",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestMatchView__5",
		"没能够匹配到实力相当的对手",
		"",
		"",
		"",
		""
	},
	{
		"FirePowerContestPrepareView__1",
		"倒计时：%d秒",
		"",
		"",
		"",
		""
	},
	{
		"PetRankView__1",
		"%d.%02d.%02d\n%02d:%02d:%02d",
		"",
		"",
		"",
		""
	},
	{
		"PetTop5RankView__1",
		"%d.%02d.%02d %02d:%02d:%02d",
		"",
		"",
		"",
		""
	},
	{
		"PetTop5RankView__2",
		"前%d名\n可领奖励",
		"",
		"",
		"",
		""
	},
	{
		"PetTop5RankView__3",
		"%s排行榜",
		"",
		"",
		"",
		""
	},
	{
		"PetTop5RankView__4",
		"%d名之外",
		"",
		"",
		"",
		""
	},
	{
		"PetTop5RankView__5",
		"获得精灵后才能进行验证哦",
		"",
		"",
		"",
		""
	},
	{
		"HandBookAttrTips_1",
		"属性加成百分比上限均为<color=#E8386FFF>+%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"HandBookAttrTips_2",
		"百分比达到上限只加固定值 （）内的数字为<color=#E8386FFF>固定数值加成</color>",
		"",
		"",
		"",
		""
	},
	{
		"SummerLotteryBuyView__1",
		"召唤提示",
		"",
		"",
		"",
		""
	},
	{
		"SummerLotteryBuyView__2",
		"是否消耗 <color=#eb4642>%s x %s</color>\r\n进行 <color=#20b376>%s</color> 次召唤？",
		"",
		"",
		"",
		""
	},
	{
		"SummerLotteryMainView__1",
		"再抽 <size=24><color=#ffe89d>%d</color></size> 次必定获得以上大奖之一",
		"",
		"",
		"",
		""
	},
	{
		"SummerLotteryBuyView__3",
		"所需%s不足，可在本活动完成任务获得",
		"",
		"",
		"",
		""
	},
	{
		"FestiveFlowerMainView__1",
		"今日不再提示",
		"",
		"",
		"",
		""
	},
	{
		"FestiveFlowerMainView__2",
		"在好友列表点击鲜花按钮进行送花，赠送鲜花后，收花方增加魅力值，且双方都增加心意值进度",
		"",
		"",
		"",
		""
	},
	{
		"FestiveFlowerMainView__3",
		"赠送鲜花后，送花方和收花方都增加心意值进度，1魅力值=1心意值",
		"",
		"",
		"",
		""
	},
	{
		"FestiveFlowerRankView__1",
		"本排行榜为全服玩家排名，心意值达到1314即可上榜，每5分钟刷新一次",
		"",
		"",
		"",
		""
	},
	{
		"FestiveFlowerGainView__1",
		"在本服聊天频道发送鲜花口令，每天有1次机会获得1朵蔷薇花噢！",
		"",
		"",
		"",
		""
	},
	{
		"FestiveFlowerGainView__2",
		"鲜花任务",
		"",
		"",
		"",
		""
	},
	{
		"BuddyOnlineTip",
		"你的好友<color=#20b376>%s</color>上线啦，记得与他（她）一起冒险哦！",
		"",
		"",
		"",
		""
	},
	{
		"BuddyFetterExplain",
		"1.与每个好友的羁绊值分别计算，与奥奇成为好友后，直接增加 <color=#20b376>1</color> 羁绊值。\r\n\n2.删除好友之后，羁绊值重置为<color=#20b376>0</color>。\r\n\n3.可以增加羁绊值的功能：\r\n\n①每天互送友情点，每次赠送友情点可获得<color=#20b376>10</color> 羁绊值。\n今日与他（她）通过互送友情点获得羁绊值上限：<color=#20b376>%s /20</color> \r\n\n②每天互相助力宝箱，每次成功助力宝箱可获得<color=#20b376>20</color> 羁绊值。\n今日与他（她）通过助力宝箱获得羁绊值上限：<color=#20b376>%s /40</color> \r\n\n③每天互相送花，每次送花根据花朵的种类、数量获得对应羁绊值。\n今日与他（她）通过送花获得羁绊值上限：<color=#20b376>%s /200</color> \r\n\n④每天一起挑战灵纹幻境-组队模式并战斗胜利，每次战斗胜利可获得<color=#20b376>10</color> 羁绊值。\n今日与他（她）通过灵纹幻境-组队模式战斗胜利获得羁绊值上限：<color=#20b376>%s /50</color>\r\n\n⑤每天一起挑战星神幻境-组队模式并战斗胜利，每次战斗胜利可获得<color=#20b376>10</color> 羁绊值。\n今日与他（她）通过星神幻境-组队模式战斗胜利获得羁绊值上限：<color=#20b376>%s /20</color>\r\n\n⑥租借好友的精灵，每次租借可获得<color=#20b376>20</color> 羁绊值。\n今日与他（她）通过租借精灵胜利获得羁绊值上限：<color=#20b376>%s /40</color>",
		"",
		"",
		"",
		""
	},
	{
		"saintknighttianteambufftip",
		"获得圣骑团队成员可在挑战中提升己阵精灵属性\r\n获得0只，己阵全属性+<color=#20b376>0%</color>及生命上限+<color=#20b376>0%</color>\r\n获得1只，己阵全属性+<color=#20b376>10%</color>及生命上限+<color=#20b376>10%</color>\r\n获得2只，己阵全属性+<color=#20b376>20%</color>及生命上限+<color=#20b376>20%</color>\r\n获得3只，己阵全属性+<color=#20b376>40%</color>及生命上限+<color=#20b376>40%</color>\r\n获得4只，己阵全属性+<color=#20b376>80%</color>及生命上限+<color=#20b376>80%</color>\r\n获得5只，己阵全属性+<color=#20b376>160%</color>及生命上限+<color=#20b376>160%</color>\r\n获得6只，己阵全属性+<color=#20b376>320%</color>及生命上限+<color=#20b376>320%</color>",
		"",
		"",
		"",
		""
	},
	{
		"saintknighttianareabufftip",
		"新开服<color=#eb4642>前14天</color>享受新服加成！\r\n己阵全属性+<color=#20b376>200%</color>及生命上限+<color=#20b376>200%</color>",
		"",
		"",
		"",
		""
	},
	{
		"saintknighttianmainviewTips",
		"华丽优雅的圣骑王者\n穿梭风暴，翱翔于天际！",
		"",
		"",
		"",
		""
	},
	{
		"saintknighttianmainviewTips1",
		"得60张天闪券",
		"",
		"",
		"",
		""
	},
	{
		"saintknighttianmainviewTips2",
		"得60张天闪券",
		"",
		"",
		"",
		""
	},
	{
		"text_boonsign_desc_1",
		"每次消耗18神钻提前签到1天",
		"",
		"",
		"",
		""
	},
	{
		"saintknighttiangameTips",
		"挑战失败！\r\n1.控制角色尽量多拾取道具\r\n2.选择数字小的障碍物通过",
		"",
		"",
		"",
		""
	},
	{
		"SaintKnightTask_Blessing",
		"PVE场景中，奇迹队精灵的暴击率和生命值提高，上阵精灵越多，加成越强，最高提升暴击率20%和10%最大生命值，限时buff生效时间：6月30日5:00-7月28日5:00",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxView__1",
		"仅限活动开放期间，每日任务活跃度达到<color=#ff0000>60</color>和<color=#ff0000>120</color>各增加1次红包雨",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxView__2",
		"不在活动时间",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxView__3",
		"次数不足，获得次数再来吧",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxView__4",
		"点击一键拆开全部红包吧",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxGameView__1",
		"已抢红包：<color=#eb4642>%d</color>/%d",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxGameView__2",
		"手速真快，成功抢满10个红包，快去开出大奖吧！",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxGameView__3",
		"时间到啦！",
		"",
		"",
		"",
		""
	},
	{
		"WeeklyBigBoxGameView__4",
		"%d<color=#eb4642>秒</color>",
		"",
		"",
		"",
		""
	},
	{
		"task_title_desc",
		"日常&周常奖励升级",
		"",
		"",
		"",
		""
	},
	{
		"lucky_draw_preview_tip",
		"本次抽奖奖励大奖为<color=#20b376>极夜危险·无烬神女皮肤</color>，详细概率请查看说明规则",
		"",
		"",
		"",
		""
	},
	{
		"text_lottery_desc_48",
		"是否将%s设置为超级大奖？",
		"",
		"",
		"",
		""
	},
	{
		"text_dragon_select_buff",
		"选择该加成在本次挑战后续的战斗中将一直生效。确定选择该加成吗，确定后本次挑战不可以改变。",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__1",
		"本次战斗已经下注%s赏金，若中途退出，则入场消耗和已下注的奖金没有退还哦！",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__2",
		"100+名",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__3",
		"当前排名：100+名",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__4",
		"未匹配到实力相当的对手",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__5",
		"请上阵%s只精灵，超过时间将自动上阵精灵",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__6",
		"阵上可替换%s只精灵",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__7",
		"正在等待对方选择......",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__8",
		"我方已投赏金：%s",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__9",
		"双方总赏金：%s",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__10",
		"赏金加成 Lv.%s",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__11",
		"赏金加成",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__12",
		"冲呀！目前共有%s人参与，总共赢得%s赏金啦！！",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__13",
		"若继续跟注，则将暂时扣除<color=#CD7800FF>%s赏金</color>进入本局的总赏金池",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__14",
		"赏金：%s",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__15",
		"当前赏金：%s",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__16",
		"请选择场次",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__17",
		"当前排名：%s",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__18",
		"<color=#ff0000>%s赏金</color>",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__19",
		"确认上阵精灵后，本轮无法修改",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__20",
		"请进行跟注，未完成精灵将视作失败",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__21",
		"由于未完成匹配流程，赏金（%s）",
		"",
		"",
		"",
		""
	},
	{
		"bountypk__22",
		"由于对方未完成匹配流程，赏金（%s）",
		"",
		"",
		"",
		""
	},
	{
		"text_answer_desc_1",
		"恭喜您答对%s题！",
		"",
		"",
		"",
		""
	},
	{
		"text_answer_desc_2",
		"获得了%s积分",
		"",
		"",
		"",
		""
	},
	{
		"text_answer_desc_3",
		"没想好列",
		"",
		"",
		"",
		""
	},
	{
		"text_answer_desc_4",
		"这个还没定 你先随便写下？到时候我让小聚帮忙该呢~",
		"",
		"",
		"",
		""
	},
	{
		"text_grateful_desc_1",
		"每日任务活跃度达到%s时，各增加1次点亮次数",
		"",
		"",
		"",
		""
	},
	{
		"text_grateful_desc_2",
		"当前可使用次数：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_grateful_desc_3",
		"次数不足",
		"",
		"",
		"",
		""
	},
	{
		"summer_prize_1",
		"奖励内容：\n1个赤焰龙皇\n火系传说之魂*2\n火系传说之魂*2\n火系传说之魂*2",
		"",
		"",
		"",
		""
	},
	{
		"outtime",
		"未在活动时间",
		"",
		"",
		"",
		""
	},
	{
		"activitytime",
		"活动时间",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_1",
		"活动时间：11.10-11.12每日9点、12点、18点开启秒杀",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_2",
		"本轮秒杀已结束！",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_3",
		"本轮剩余时间：%s时%s分%s秒",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_4",
		"下轮开启剩余时间：%s时%s分%s秒",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_5",
		"全服限购：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_6",
		"个人限购：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_7",
		"已售罄，不可购买！",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_8",
		"购买已达上限，不可购买！",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_9",
		"活动时间：11月11日5:00--11月14日5:00",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_10",
		"免单概率：%s%%",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_11",
		"全服第11/111/211···/N11次的购买玩家获得尾号免单资格",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_12",
		"本轮秒杀已结束",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_13",
		"本轮秒杀还未开始",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_14",
		"%s服[%s]获得了%s神钻免单",
		"",
		"",
		"",
		""
	},
	{
		"text_doubleeleven_desc_15",
		"今日充值：%s",
		"",
		"",
		"",
		""
	},
	{
		"tip_psychic_hire_pet",
		"是否确认租借该精灵，租借后其余精灵将进入冷却时间？",
		"",
		"",
		"",
		""
	},
	{
		"TabPTEliMyScheduleView_1",
		"【我的赛程】展示上一轮赛事，敌方的上阵阵容。",
		"",
		"",
		"",
		""
	},
	{
		"tabptelivoteplatemainview_1",
		"应援选手胜利，以%s倍返还应援币；应援选手失败，返还%s应援币。",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_1",
		"家族赛季即将开始，敬请期待！",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_2",
		"家族等级：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_3",
		"本功能正在进行技术维护，具体开放时间请留意公告！",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_4",
		"当前没有家族红包",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_5",
		"需要家族贡献值达到%s才可领取红包    %s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_6",
		"当前没有任务可发红包",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_7",
		"需要家族贡献值达到%s才可发红包    可发红包：%s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_8",
		"当前贡献值不足%s，不可操作！",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_9",
		"限领：%s人",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_10",
		"发放",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_11",
		"红包任务已过期",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_12",
		"只可完成",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_13",
		"每日",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_14",
		"每周",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_15",
		"已领：%s/%s，共%s/%s份",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_16",
		"当前红包不可领取",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_17",
		"%s今日已领取完！",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_18",
		"%s的%s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_19",
		"成员：<size=22><color=#74E283FF>%s</color>/%s</size>",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_20",
		"在线：<color=#74E283FF>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_21",
		"解散家族",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_22",
		"退出家族",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_23",
		"去意已决",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_24",
		"容我三思",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_25",
		"你的家族故事",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_26",
		"%s\n<color=#eb4642><size=18>（注意：您作为家族的最后一位成员，在您退出后，家族将自动解散）</size></color>",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_27",
		"%04d年%02d月%02d日\n你加入了[%s]家族，至今已%s个日夜。\n您收获颇丰，累计获得了%s%s；您勤耕不辍，累计贡献了%s点家族活跃度；\n回想您在家族的欢声与笑语，您真的要离开吗？\n<color=#eb4642>注意：退出家族后，24小时后才能加入新家族</color>",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_28",
		"驱逐成功",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_29",
		"今日驱逐人数已达上限",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_30",
		"是否驱逐此成员？今日驱逐人数上限：<color=#%s>%s</color>/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_31",
		"每日可驱逐上限：%s(+%s)/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_32",
		"没有该离线时长的家族成员",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_33",
		"请选择要驱逐的成员",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_34",
		"<size=30>是否确认驱逐选择的%s个玩家？</size>\n<size=20>今日驱逐人数上限：%s/%s</size>",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_35",
		"驱逐提示",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_36",
		"家族宣言不能为空",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_37",
		"家族宣言修改成功",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_38",
		"自加入家族以来，累计捐献幸运值 %s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_39",
		"剩余捐献：%s/%s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_40",
		"剩余捐献次数不足",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_41",
		"捐献成功",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_42",
		"是否消耗%s%s捐献1次？您将为家族增加%s活跃度，并获得%s%s、%s%s",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_43",
		"捐献确认",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_44",
		"捐献了%s家族幸运值",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_45",
		"达到活跃度后可开启，开启后持续%s小时",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_46",
		"家族魔王战每日5:00刷新",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_47",
		"家族%s级解锁",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_48",
		"扫荡次数不足",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_49",
		"剩余次数不足",
		"",
		"",
		"",
		""
	},
	{
		"text_family_desc_50",
		"请稍等",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_1",
		"本关精灵存活数/回合数为:%s，上一次结果为:%s 是否保存本关结果？",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_2",
		"确定要花费%d神钻，直接一键通过?",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_3",
		"已完成神启挑战",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_4",
		"是否重置所有关卡，重置后所有挑战结果都将清空",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_5",
		"心情状态描述：\n常：正常状态下为，常状态 \n喜：当喜值大于悲值时，为喜状态\n悲：当悲值大于喜值时，为悲状态",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_6",
		"善恶挑战已通关",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_7",
		"心情状态：",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_8",
		"回合数：",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_9",
		"存活数：",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_10",
		"是非挑战已通关",
		"",
		"",
		"",
		""
	},
	{
		"godxiuer_11",
		"请先通关【是之阵】",
		"",
		"",
		"",
		""
	},
	{
		"collecttangyuan_1",
		"兑换所需汤圆数量不足，先去收集五王汤圆吧！",
		"",
		"",
		"",
		""
	},
	{
		"dodragon_1",
		"每通过一关即可获得至尊券一张！",
		"",
		"",
		"",
		""
	},
	{
		"text_pet_lottery_desc_1",
		"是否确认选择当前卡组？确认之后不可更改",
		"",
		"",
		"",
		""
	},
	{
		"divineEvolvePlus_notputin",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"",
		"",
		"",
		""
	},
	{
		"divineEvolvePlus_specify",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"",
		"",
		"",
		""
	},
	{
		"divineEvolvePlus_sameLine",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		"",
		"",
		"",
		""
	},
	{
		"divineEvolvePlus_notputin_ciyuan",
		"1.放入<color=#EB4642>万象·次元圣龙</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>次元之心</color>，不继承等级和觉醒",
		"",
		"",
		"",
		""
	},
	{
		"divineEvolvePlus_specify_ciyuan",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量万象·次元圣龙专属魂",
		"",
		"",
		"",
		""
	},
	{
		"divineEvolvePlus_sameLine_ciyuan",
		"1.次元之心<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>只获得</color>1级0觉醒神曜万象·次元圣龙",
		"",
		"",
		"",
		""
	},
	{
		"holydarkmm_reset_tip",
		"是否确认重置本关？",
		"",
		"",
		"",
		""
	},
	{
		"weeklyGroupTeamRankTip",
		"根据队伍内所有玩家的当期积分，从高到低进行排名，前1000名可获得奖励\r\n每期结束时结算，并通过邮件发放排名奖励",
		"",
		"",
		"",
		""
	},
	{
		"weeklyGroupPersonRankTip",
		"根据每名玩家的当期积分，从高到低进行排名，前1000名可获得奖励\r\n每期结束时结算，并通过邮件发放排名奖励",
		"",
		"",
		"",
		""
	},
	{
		"NeverLandRankTip",
		"前500上榜可获得奖励，活动结束通过邮件发放（仅展示前100名玩家）",
		"",
		"",
		"",
		""
	},
	{
		"divineciyuan_buff_tip",
		"切换增益效果后，将重置本层关卡挑战进度，\r\n是否确认切换？",
		"",
		"",
		"",
		""
	},
	{
		"divineciyuan_extreme_reset_tip",
		"是否重置所有关卡，重置后本层所有挑战结果都将清空",
		"",
		"",
		"",
		""
	},
	{
		"zhuxiao_popup_1",
		"亲爱的用户，我们对您的注销的深表遗憾，为了确保您的游戏账户和财产安全，我们先为您做出如下重要提示与说明：注销游戏账户是不可恢复的操作，一旦您注销游戏账户，您在该游戏账户下的个人信息将进行删除或匿名化处理，且此前已关联该游戏账户角色的相关产品与服务均将不再关联，您将无法再以该申请注销的游戏账户登录和使用所有适用该游戏账户的产品及服务，亦无法找回您通过该申请注销的游戏账户添加或绑定的任何内容和信息，包括但不限于头像、角色、昵称、虚拟道具或虚拟物品等所有游戏数据及游戏中的聊天记录等。即使您选择相同的个人信息资料再次注册并使用与注销账户相同的产品及服务，以上信息及数据均无法恢复。为避免给您带来不便，请您谨慎考虑与操作。在提交注销申请前，请确认游戏账户满足以下条款：\r\n\r\n1. 该游戏账户为您本人合法拥有并登录使用，且符合我们双方间的协议规定及相关说明规则中有关游戏账户的规定；\r\n\r\n2. 游戏账户无任何纠纷：包括但不限于举报/投诉、被举报/被投诉、被禁言、诉讼等情况；\r\n\r\n3. 游戏账户处于安全状态：账户处于正常使用状态中，且无被封、被盗等风险；\r\n\r\n4. 游戏资产/收益已妥善处理：包括但不限于游戏代币，虚拟道具以及游戏增值服务和周边商品。请妥善处理，若未处理，视为您自愿放弃该游戏资产/收益；\r\n\r\n5. 游戏账户无未完成状态订单：包括但不限于充值游戏代币、购买游戏其他虚拟道具以及增值服务、周边商品等。",
		"",
		"",
		"",
		""
	},
	{
		"zhuxiao_popup_2",
		"尊敬的用户，在您正式开始下一步有关本游戏账户注销流程前，请您务必详细阅读《游戏账户注销协议》（以下统称“本协议”）。您按照我们的注销流程开始注销操作，或您勾选本协议并点击下一步操作的，即视为您已经同意和遵守本协议全部内容。\r\n\r\n有关游戏账户注销的详细规则及注意事项请点击查看《游戏账户注销协议》。",
		"",
		"",
		"",
		""
	},
	{
		"zhuxiao_popup_3",
		"为防止误操作，请再次确认是否注销游戏账户并确认注销后的影响：\r\n\r\n1. 游戏账户一旦注销，您将无法登录、使用该游戏账户，且无法恢复，也无权要求我们找回。此前已关联该游戏账户角色的相关产品与服务均将不再关联，您将无法找回您通过该申请注销的游戏账户添加或绑定的任何内容和信息，包括但不限于头像、角色、昵称、虚拟道具或虚拟物品等所有游戏数据及游戏中的聊天记录等。\r\n\r\n2. 该游戏账户在本游戏使用期间已产生及未来可能产生的所有收益或权益都将被清除。据此，也特别提示您，在您注销本游戏账户前请您确保已妥善处理您的游戏收益或权益。否则，账户注销后，我们有权对该账户下的收益或权益做清除处理，因此产生的后果由您自行承担。前述游戏收益或权益包括但不限于账户内剩余的所有游戏虚拟货币、虚拟道具及其他虚拟物品和增值服务、周边商品等。\r\n\r\n3. 在您通过各项提醒并最终确认注销后，视为您已成功向我们提交了游戏账户注销申请，但是这并不意味着该游戏账户必然完全符合注销条件，也并不意味着该游戏账户已被永久注销。如符合注销条件，我们将在第16日内完成您的注销申请核查和进行游戏账户注销，此后该游戏账户将被永久注销且不得恢复。",
		"",
		"",
		"",
		""
	},
	{
		"zhuxiao_popup_4",
		"请注意，该游戏账户注销有15日的冷静期，我们将在冷静期满后完成注销，删除您的游戏账户数据。\r\n\r\n在此期间，请您不要登录和使用该游戏账户，以确保注销的顺利完成，一旦您登陆和使用该游戏账户，将视为您撤销注销申请。",
		"",
		"",
		"",
		""
	},
	{
		"zhuxiao_popup_5",
		"您在%s的角色已于%s发起注销，目前正处于注销冷冻期中，注销冷冻期后会清除角色相关信息，若您在%s前选择进入游戏，我们将视为您主动取消注销，是否确认放弃注销流程并登录游戏？",
		"",
		"",
		"",
		""
	},
	{
		"zhuxiao_popup_6",
		"您已成功注销，进入注销15天冷冻期，在冷冻期内可随时取消注销流程，我们静候您的回归！",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_1",
		"恭喜您，成为<color=#ffbd3d>【%s】</color>阵营的指挥官!",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_2",
		"恭喜您，被随机分配至<color=#ffbd3d>【%s】</color>阵营!",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_3",
		"本阵营中的主战精灵有：<color=#ffbd3d>%s</color>\n 本阵营中已任命的指挥官为：<color=#ffbd3d>%s</color>\n占领指定地块后，可解锁资源地块与酒馆\n资源地块中收集的酒馆积分可至酒馆招募精灵协助战斗\n作为指挥官，你可以：编辑阵营公告、标记地块、升级地块、发布指令\n快带领你的阵营夺得胜利吧！\n现在先去设置你的队伍吧！",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_4",
		"本阵营中的主战精灵有：<color=#ffbd3d>%s</color>\n 本阵营中的指挥官为：<color=#ffbd3d>%s</color>\n占领指定地块后，可解锁资源地块与酒馆\n资源地块中收集的酒馆积分可至酒馆招募精灵协助战斗\n现在先去设置你的队伍吧！",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_5",
		"守军阵容战力达到本地块的最低限制战力：<color=#eb4642>%d</color>\n布置守军有<color=#eb4642>%d</color>分钟的行进时间，是否确认布置守军？",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_6",
		"您是<color=#eb4642>%s</color>中的守卫\n您可以选择撤下守军，撤下守军后再次布置守军\n需要<color=#eb4642>%d</color>分钟的行进时间",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_7",
		"是否立即跳转至自己当前驻守的地块？",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_8",
		"确认花费<color=#eb4642>%s</color>，升级阵营至<color=#eb4642>%d级</color>吗？\n当前拥有阵营积分：<color=#eb4642>%d</color>",
		"",
		"",
		"",
		""
	},
	{
		"elementspark_9",
		"确认花费<color=#eb4642>%d</color>，\r\n招募精灵<color=#eb4642>%s</color>吗？",
		"",
		"",
		"",
		""
	},
	{
		"nogamenumber",
		"游戏次数不足！",
		"",
		"",
		"",
		""
	},
	{
		"nobuynumber",
		"购买次数不足！",
		"",
		"",
		"",
		""
	},
	{
		"unlock",
		"解锁",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc1",
		"还有剩余次数未使用",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc2",
		"是否花费%s购买游戏次数？",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc3",
		"心意值未满",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc4",
		"心意值礼物已领取",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc5",
		"今日剩余次数：%d/%d",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc6",
		"心意值",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc7",
		"当前礼物\n%d",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc8",
		"可获得%d礼物",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc9",
		"%d秒内成功礼物翻倍",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc10",
		"轻松",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc11",
		"普通",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc12",
		"挑战",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc13",
		"疯狂",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc14",
		"全服排行",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc15",
		"疯狂模式排行",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc16",
		"把礼物放入礼盒中，准备好给小诺的礼物吧！\n点击任意位置开始游戏",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc17",
		"给小诺的礼物准备好啦！奥奇快收下属于你的奖励吧~",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc18",
		"还差一点就能包装好啦，再试着用心包装一下吧！\n 点击重新开始",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc19",
		"游戏结束！本局通过%d关，获得积分：%d",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc20",
		"游戏结束！本局获得翻倍积分：",
		"",
		"",
		"",
		""
	},
	{
		"lsqordeal_desc21",
		"游戏结束！本局获得积分：",
		"",
		"",
		"",
		""
	},
	{
		"wtbm_not_enough",
		"数量不足，点击获得能量获取吧~",
		"",
		"",
		"",
		""
	},
	{
		"txt_script_kill_rank_rule",
		"参与完所有轮次的预测真凶，且正确率达到100%才能上榜，根据成功猜出真凶消耗的总时间进行排名\r\n消耗时间计算方式：成功提交每轮答案时间-章节开启时间，前5000名上榜玩家均可获得限定称号",
		"",
		"",
		"",
		""
	},
	{
		"txt_equip_limit_desc",
		"%s仓库的初始容量为<color=#C54949>%s</color>。\n当拥有<color=#C54949>%s只满级传说精灵</color>时,每超出<color=#C54949>%s</color>只会增加<color=#C54949>%s%%</color>的容量上限,最多达到<color=#C54949>%s</color>。\n多余的道具可以在回收工坊中进行回收\n\n当前增加比例：<color=#C54949>%s%%</color>\n当前容量：<color=#C54949>%s</color>",
		"",
		"",
		"",
		""
	},
	{
		"teshamuchallenge_reset_tip",
		"是否重置所有关卡，重置后当前已挑战结果将清空？\n\n<color=#20b376>温馨提示：每个关卡奖励只能获得一次，重置关卡并不会重置已经获得的奖励状态。</color>",
		"",
		"",
		"",
		""
	},
	{
		"holydragonfield_name_1",
		"黄金战场",
		"",
		"",
		"",
		""
	},
	{
		"holydragonfield_name_2",
		"次元战场",
		"",
		"",
		"",
		""
	},
	{
		"holydragonfield_name_3",
		"圣光战场",
		"",
		"",
		"",
		""
	}
}
local t_lang_tip = {
	tip_try_again = dataList[1],
	tip_dodge = dataList[2],
	tip_block = dataList[3],
	tip_absorb = dataList[4],
	tip_login_prepare = dataList[5],
	tip_login_connectwebfail = dataList[6],
	tip_login_relogin = dataList[7],
	tip_login_serverfull = dataList[8],
	tip_login_notice = dataList[9],
	tip_login_account = dataList[10],
	tip_login_selectzone = dataList[11],
	tip_login_changeserver = dataList[12],
	tip_login_begingame = dataList[13],
	tip_login_readandagree = dataList[14],
	tip_login_userprotocol = dataList[15],
	tip_login_notacceptuserprotocol1 = dataList[16],
	tip_login_notacceptuserprotocol2 = dataList[17],
	tip_login_surecancel = dataList[18],
	tip_login_returnlook = dataList[19],
	tip_login_copyright = dataList[20],
	tip_login_updateclient = dataList[21],
	tip_login_otherdevice = dataList[22],
	tip_login_fail = dataList[23],
	tip_login_sdkloginfail = dataList[24],
	tip_login_servershutdown = dataList[25],
	tip_login_sdkinitfail = dataList[26],
	tip_login_reqremoteverfail = dataList[27],
	tip_network_disconnect = dataList[28],
	tip_server_getinfofail = dataList[29],
	tip_server_viewtitle = dataList[30],
	tip_server_lastlogin = dataList[31],
	tip_server_recommend = dataList[32],
	tip_server_zone = dataList[33],
	tip_server_haverole = dataList[34],
	tip_server_stop = dataList[35],
	tip_server_normal = dataList[36],
	tip_server_hot = dataList[37],
	tip_revise = dataList[38],
	tip_submit = dataList[39],
	tip_gesture_invaild = dataList[40],
	ui_level_name = dataList[41],
	tip_exp = dataList[42],
	tip_get = dataList[43],
	tip_level = dataList[44],
	tip_unlock = dataList[45],
	tip_replace = dataList[46],
	tip_equip = dataList[47],
	tip_lock_txt = dataList[48],
	tip_lock = dataList[49],
	tip_stargod = dataList[50],
	tip_potential = dataList[51],
	tip_null_awake = dataList[52],
	tip_awake = dataList[53],
	tip_need_buy = dataList[54],
	tip_click_write = dataList[55],
	tip = dataList[56],
	confirm = dataList[57],
	tip_loading_001 = dataList[58],
	tip_all = dataList[59],
	tip_surplus = dataList[60],
	tip_cumulative = dataList[61],
	tip_clearance = dataList[62],
	red_chaoji = dataList[63],
	red_wudi = dataList[64],
	red_da = dataList[65],
	red_xiao = dataList[66],
	red_mini = dataList[67],
	stargod_auto_off = dataList[68],
	stargod_auto_on = dataList[69],
	stargod_vip = dataList[70],
	stargod_notopen = dataList[71],
	stargod_godopen = dataList[72],
	stargod_lightopen = dataList[73],
	stargod_willmerge = dataList[74],
	stargod_swallow = dataList[75],
	stargod_replace = dataList[76],
	stargod_blue_c = dataList[77],
	stargod_purple_c = dataList[78],
	stargod_full = dataList[79],
	stargod_green_c = dataList[80],
	sort = dataList[81],
	sort_level_down = dataList[82],
	sort_level_up = dataList[83],
	sort_quality_down = dataList[84],
	sort_quality_up = dataList[85],
	sort_cur_power_down = dataList[86],
	sort_cur_power_up = dataList[87],
	sort_max_power_down = dataList[88],
	sort_max_power_up = dataList[89],
	sort_get_time_down = dataList[90],
	sort_get_time_up = dataList[91],
	race_cao = dataList[92],
	race_shui = dataList[93],
	race_huo = dataList[94],
	race_guang = dataList[95],
	race_an = dataList[96],
	job = dataList[97],
	job_speed = dataList[98],
	job_magic = dataList[99],
	job_attack = dataList[100],
	job_shield = dataList[101],
	job_balance = dataList[102],
	job_treatment = dataList[103],
	job_shot = dataList[104],
	job_hero = dataList[105],
	job_summoner = dataList[106],
	job_boss_restrain = dataList[107],
	job_ancient = dataList[108],
	job_source = dataList[109],
	job_boss = dataList[110],
	job_shenqi = dataList[111],
	attr = dataList[112],
	attr_attack_physical = dataList[113],
	attr_defense_physical = dataList[114],
	attr_attack_ult = dataList[115],
	attr_defense_ult = dataList[116],
	attr_attack_magic = dataList[117],
	attr_defense_magic = dataList[118],
	attr_hp = dataList[119],
	attr_speed = dataList[120],
	petegg_ifunload = dataList[121],
	petegg_ifhatch = dataList[122],
	petegg_hatching = dataList[123],
	petegg_needvip = dataList[124],
	pet_fruit_use = dataList[125],
	pet_power = dataList[126],
	pet_level_max = dataList[127],
	not_empty = dataList[128],
	input_pet_name = dataList[129],
	evlove_title = dataList[130],
	evlove_toptip = dataList[131],
	task_title = dataList[132],
	task_chapter = dataList[133],
	task_over = dataList[134],
	task_desc = dataList[135],
	task_target = dataList[136],
	task_bonus = dataList[137],
	task_goto = dataList[138],
	task_review = dataList[139],
	task_main = dataList[140],
	task_branch = dataList[141],
	task_daily = dataList[142],
	task_guide = dataList[143],
	task_festival = dataList[144],
	task_limittime = dataList[145],
	task_main_shortcut = dataList[146],
	task_branch_shortcut = dataList[147],
	task_daily_shortcut = dataList[148],
	task_guide_shortcut = dataList[149],
	task_festival_shortcut = dataList[150],
	diamondtask_daily = dataList[151],
	diamondtask_weekly = dataList[152],
	diamondtask_monthly = dataList[153],
	exp_lackfruit = dataList[154],
	fight_unformation = dataList[155],
	fight_goto_fmt = dataList[156],
	fight_fmt_num = dataList[157],
	kaya_nohanbin = dataList[158],
	go_get = dataList[159],
	goto = dataList[160],
	finish = dataList[161],
	petegg_goto_hatch_tips = dataList[162],
	petegg_goto_hatch = dataList[163],
	tips_not_release = dataList[164],
	tag = dataList[165],
	tag_normal = dataList[166],
	tag_special = dataList[167],
	lv_number = dataList[168],
	lv_number_nospace = dataList[169],
	skill_passive_shortcut = dataList[170],
	skill_normal_shortcut = dataList[171],
	skill_ult_shortcut = dataList[172],
	skill_hero_shortcut = dataList[173],
	skill_summon_shortcut = dataList[174],
	tips_best_position = dataList[175],
	tips_team = dataList[176],
	number_1 = dataList[177],
	number_2 = dataList[178],
	number_3 = dataList[179],
	number_4 = dataList[180],
	number_5 = dataList[181],
	item_sell_get = dataList[182],
	item_have = dataList[183],
	item_merge = dataList[184],
	item_sell = dataList[185],
	genius_yiwushichu = dataList[186],
	genius_shifenchangjian = dataList[187],
	genius_bailitiaoyi = dataList[188],
	genius_qianzainanfeng = dataList[189],
	genius_wanzhongzhumu = dataList[190],
	genius_wangzhewudi = dataList[191],
	mail_sys = dataList[192],
	mail_sender = dataList[193],
	mail_year = dataList[194],
	mail_mon = dataList[195],
	mail_day = dataList[196],
	mail_tip1 = dataList[197],
	mail_tip2 = dataList[198],
	mail_tip = dataList[199],
	mail_confirm = dataList[200],
	mail_cancel = dataList[201],
	mail_get = dataList[202],
	mail_got = dataList[203],
	mail_before = dataList[204],
	tips_geniustype = dataList[205],
	tips_strength = dataList[206],
	tips_geniustrain = dataList[207],
	dress_ownprog = dataList[208],
	jiugong_unlocknow = dataList[209],
	no_search_player = dataList[210],
	select_uplvpet = dataList[211],
	pet_maxlv = dataList[212],
	tip_missionnum = dataList[213],
	wt_boxnoget = dataList[214],
	wt_boxgot = dataList[215],
	wt_poolept = dataList[216],
	wt_usediamond = dataList[217],
	wt_expoverflow = dataList[218],
	wt_nosweecnt = dataList[219],
	wt_nosweeplv = dataList[220],
	wt_sweeping = dataList[221],
	wt_sweepfinish = dataList[222],
	wt_sweepto = dataList[223],
	tips_someone_apply_01 = dataList[224],
	tips_recommend_01 = dataList[225],
	tips_no_search_player = dataList[226],
	apply_success = dataList[227],
	delete_success = dataList[228],
	remove_blacklist_success = dataList[229],
	add_blacklist_success = dataList[230],
	add_friend_success = dataList[231],
	agree_apply = dataList[232],
	delete_friend = dataList[233],
	add_blacklist = dataList[234],
	remove_blacklist = dataList[235],
	offline = dataList[236],
	godrace_mat = dataList[237],
	godrace_choose = dataList[238],
	no_hero_skill = dataList[239],
	prize_get_levelup = dataList[240],
	prize_get_gift = dataList[241],
	prize_get_stargod = dataList[242],
	prize_get_srcbeast = dataList[243],
	prize_xiulian_tip = dataList[244],
	prize_xiulian_eighty = dataList[245],
	prize_xiulian_levelup = dataList[246],
	prize_xiulian_stargod = dataList[247],
	prize_xiulian_gift = dataList[248],
	story_pass = dataList[249],
	text_friend = dataList[250],
	text_mail = dataList[251],
	text_num_round = dataList[252],
	text_speed_acc = dataList[253],
	auto_voice_true = dataList[254],
	auto_voice_false = dataList[255],
	channel_zone = dataList[256],
	channel_world = dataList[257],
	channel_league = dataList[258],
	channel_nearby = dataList[259],
	channel_system = dataList[260],
	channel_zone_shortcut = dataList[261],
	channel_world_shortcut = dataList[262],
	channel_league_shortcut = dataList[263],
	channel_nearby_shortcut = dataList[264],
	channel_system_shortcut = dataList[265],
	sendmsg_use_item = dataList[266],
	sendmsg_use_conume_success = dataList[267],
	sendmsg_use_conume_failed = dataList[268],
	sendmsg_use_conume_confirm = dataList[269],
	sx_dailyCounterLimit = dataList[270],
	sx_weeklyCounterLimit = dataList[271],
	sx_monthlyCounterLimit = dataList[272],
	sx_oneOffLimit = dataList[273],
	sx_longTimeCounterLimit = dataList[274],
	catch_hp_percent_great = dataList[275],
	catch_hp_percent_less = dataList[276],
	catch_hp_great = dataList[277],
	catch_hp_less = dataList[278],
	catch_vigour_percent_great = dataList[279],
	catch_vigour_percent_less = dataList[280],
	catch_vigour_great = dataList[281],
	catch_vigour_less = dataList[282],
	catch_hp_percent_pos_great = dataList[283],
	catch_hp_percent_pos_less = dataList[284],
	catch_hp_pos_great = dataList[285],
	catch_hp_pos_less = dataList[286],
	catch_vigour_percent_pos_great = dataList[287],
	catch_vigour_percent_pos_less = dataList[288],
	catch_vigour_pos_great = dataList[289],
	catch_vigour_pos_less = dataList[290],
	catch_odd_round = dataList[291],
	catch_even_round = dataList[292],
	catch_buff_self = dataList[293],
	catch_no_buff_self = dataList[294],
	catch_buff_enemy = dataList[295],
	catch_no_buff_enemy = dataList[296],
	battleitem_energy_noenough = dataList[297],
	catch_waiting_cd = dataList[298],
	catch_failed = dataList[299],
	catch_success = dataList[300],
	catch_targetnum_less = dataList[301],
	catch_targetnum_great = dataList[302],
	catch_onlypet_exist = dataList[303],
	click_close = dataList[304],
	text_youcando = dataList[305],
	text_gain_exp = dataList[306],
	text_next_lv_exp = dataList[307],
	text_exp_double_add = dataList[308],
	text_exp_vip_add = dataList[309],
	text_exp_prop_add = dataList[310],
	battlerecord_max_sp = dataList[311],
	battlerecord_transform = dataList[312],
	battlerecord_buff_remove = dataList[313],
	battlerecord_buff_add = dataList[314],
	battlerecord_buff_damage = dataList[315],
	battlerecord_buff_treat = dataList[316],
	battlerecord_vigour_add = dataList[317],
	battlerecord_vigour_consume = dataList[318],
	battlerecord_damage = dataList[319],
	battlerecord_treat = dataList[320],
	battlerecord_immunity = dataList[321],
	battlerecord_critical = dataList[322],
	battlerecord_dodge = dataList[323],
	spriteladder_title_desc = dataList[324],
	ui_new_journey = dataList[325],
	function_tip = dataList[326],
	ui_item_notenough = dataList[327],
	ui_pretask_tips = dataList[328],
	spriteladder_guide_desc = dataList[329],
	spriteladder_non_finish = dataList[330],
	spriteladder_get = dataList[331],
	xiuer_desc1 = dataList[332],
	xiuer_desc2 = dataList[333],
	xiuer_desc3 = dataList[334],
	xiuer_desc4 = dataList[335],
	xiuer_desc5 = dataList[336],
	jump_to = dataList[337],
	wt_exppool = dataList[338],
	wt_exppool2 = dataList[339],
	wt_absorb = dataList[340],
	clg_passbefore = dataList[341],
	prize_xiulian_tip1 = dataList[342],
	prize_xiulian_levelupto1 = dataList[343],
	prize_xiulian_levelup1 = dataList[344],
	prize_xiulian_gift1 = dataList[345],
	prize_xiulian_gift2 = dataList[346],
	prize_xiulian_ji = dataList[347],
	prize_xiulian_pet = dataList[348],
	shuisheng_tip = dataList[349],
	jiugongbazhen_pettip = dataList[350],
	story_autoplaying = dataList[351],
	story_nextstep = dataList[352],
	story_brief = dataList[353],
	task_empty = dataList[354],
	tip_second = dataList[355],
	tip_know = dataList[356],
	ball_targetnum_single = dataList[357],
	ball_targetnum_all = dataList[358],
	jiugongbazhen_name = dataList[359],
	jiugongbazhen_desc = dataList[360],
	text_hp = dataList[361],
	text_vigour = dataList[362],
	text_no_skill = dataList[363],
	text_tiaozhanluxiang = dataList[364],
	text_tongguanpaihang = dataList[365],
	text_zuijintiaozhan = dataList[366],
	text_zhenxing = dataList[367],
	text_wurenshangbang = dataList[368],
	text_paiming = dataList[369],
	text_aoqiming = dataList[370],
	text_jiazu = dataList[371],
	text_tongguanshijian = dataList[372],
	text_wodepaiming = dataList[373],
	text_wodepaiming_wu = dataList[374],
	text_luxiang = dataList[375],
	text_nofamily = dataList[376],
	text_timeinfo = dataList[377],
	text_timeinfo_2 = dataList[378],
	text_tiaozhangqming = dataList[379],
	text_zdju_useItem = dataList[380],
	text_costdimond = dataList[381],
	task_trigger_scene = dataList[382],
	task_trigger_scene_zone = dataList[383],
	task_trigger_item = dataList[384],
	task_trigger_challenge = dataList[385],
	task_trigger_mofang = dataList[386],
	battleitem_unusable = dataList[387],
	mofang_lock_tip = dataList[388],
	summoncontract_txt1 = dataList[389],
	summoncontract_txt2 = dataList[390],
	summoncontract_txt3 = dataList[391],
	summoncontract_txt4 = dataList[392],
	story_chapter = dataList[393],
	chapter_end = dataList[394],
	task_opentime_day = dataList[395],
	task_opentime_hours = dataList[396],
	task_opentime_mins = dataList[397],
	click_continue = dataList[398],
	text_leave = dataList[399],
	tip_mail_outdate = dataList[400],
	tip_form_auto_full_level = dataList[401],
	tip_passed = dataList[402],
	ui_story_xuzhang = dataList[403],
	ui_rank_refreshtime = dataList[404],
	ui_rank_wtower_level = dataList[405],
	ui_rank_pettrain_level = dataList[406],
	ui_reward_task = dataList[407],
	ui_retreat_early = dataList[408],
	ui_story_cantpass = dataList[409],
	fuben_chaptertip = dataList[410],
	fuben_stagetip = dataList[411],
	fuben_tasktip1 = dataList[412],
	fuben_tasktip2 = dataList[413],
	fuben_tasktip3 = dataList[414],
	fuben_leveltip = dataList[415],
	fuben_powertip = dataList[416],
	text_click_skip_video = dataList[417],
	tip_talent_0 = dataList[418],
	tip_talent_1 = dataList[419],
	tip_talent_2 = dataList[420],
	tip_talent_3 = dataList[421],
	tip_talent_4 = dataList[422],
	tip_talent_5 = dataList[423],
	tip_talent_6 = dataList[424],
	tip_talent_7 = dataList[425],
	tip_talent_8 = dataList[426],
	tip_talent_9 = dataList[427],
	tip_talent_10 = dataList[428],
	tip_family_purpose_1 = dataList[429],
	tip_family_purpose_2 = dataList[430],
	tip_family_purpose_3 = dataList[431],
	tip_family_purpose_4 = dataList[432],
	tip_family_purpose_5 = dataList[433],
	tip_family_purpose_6 = dataList[434],
	tip_family_position_0 = dataList[435],
	tip_family_position_1 = dataList[436],
	tip_family_position_2 = dataList[437],
	tip_family_position_3 = dataList[438],
	tip_family_position_4 = dataList[439],
	tip_family_declaration = dataList[440],
	tip_family_apply = dataList[441],
	attr_ex = dataList[442],
	job_ex = dataList[443],
	exprevive_title = dataList[444],
	exprevive_tips = dataList[445],
	exprevive_empty = dataList[446],
	expreviveitem_empty = dataList[447],
	exprevive_emptytips = dataList[448],
	text_refreshtime = dataList[449],
	rareName1 = dataList[450],
	rareName2 = dataList[451],
	rareName3 = dataList[452],
	rareName4 = dataList[453],
	expedition_reset = dataList[454],
	expedition_reviveevent = dataList[455],
	expedition_reviveevent_desc = dataList[456],
	expedition_reviveall = dataList[457],
	network_question = dataList[458],
	finish_search = dataList[459],
	con_finish_search = dataList[460],
	tip_family_BOSS_begin = dataList[461],
	treasure_distance_tip1 = dataList[462],
	treasure_distance_tip2 = dataList[463],
	treasure_distance_tip3 = dataList[464],
	treasure_distance_tip4 = dataList[465],
	treasure_digging = dataList[466],
	treasure_searching = dataList[467],
	treasure_distance_tip5 = dataList[468],
	tips_petpiece_compose = dataList[469],
	world_Boss_tip1 = dataList[470],
	world_Boss_tip2 = dataList[471],
	world_Boss_tip3 = dataList[472],
	world_Boss_tip4 = dataList[473],
	world_Boss_tip5 = dataList[474],
	world_Boss_tip6 = dataList[475],
	world_Boss_tip7 = dataList[476],
	world_Boss_tip8 = dataList[477],
	world_Boss_tip9 = dataList[478],
	world_Boss_tip10 = dataList[479],
	world_Boss_tip11 = dataList[480],
	world_Boss_tip12 = dataList[481],
	world_Boss_tip13 = dataList[482],
	world_Boss_tip14 = dataList[483],
	world_Boss_tip15 = dataList[484],
	world_Boss_tip16 = dataList[485],
	world_Boss_tip17 = dataList[486],
	settlement_tip1 = dataList[487],
	settlement_tip2 = dataList[488],
	settlement_tip3 = dataList[489],
	senior_arena_tip_1 = dataList[490],
	senior_arena_tip_2 = dataList[491],
	Handbookpetattribute_tip_1 = dataList[492],
	Handbookpetattribute_tip_2 = dataList[493],
	signindaily_tip = dataList[494],
	arena_3v3_give_tickets_tip = dataList[495],
	arena_3v3_collect_speed_title_tip = dataList[496],
	endless_battle_tip = dataList[497],
	arena_3v3_collect_total_title_tip = dataList[498],
	longhuang_nobuff_tip = dataList[499],
	longhuang_battle_tip = dataList[500],
	longhuang_buff_tip = dataList[501],
	panduola_buff_tip = dataList[502],
	questionnaire_prize_tip = dataList[503],
	miya_findfault_countdown_tip = dataList[504],
	miya_findfault_rule_tip = dataList[505],
	miya_findfault_leftTime_title = dataList[506],
	miya_findfault_leftCount_title = dataList[507],
	miya_quizgame_countdown_tip = dataList[508],
	miya_reset_mode_tip = dataList[509],
	miya_playchess_lose_tip = dataList[510],
	timed_challenge_vip_tip = dataList[511],
	timed_challenge_choose_difficulty_tip = dataList[512],
	flipgame_tip1 = dataList[513],
	flipgame_tip2 = dataList[514],
	amier_detail_tip = dataList[515],
	family_pretech_locked = dataList[516],
	family_tech_player_lv_limited = dataList[517],
	family_tech_family_lv_limited = dataList[518],
	skill_combination_shortcut = dataList[519],
	pet_rent_tips = dataList[520],
	pet_hire_tips = dataList[521],
	pet_hire_sure = dataList[522],
	expedition_normal_tips = dataList[523],
	expedition_hard_tips = dataList[524],
	expedition_sweep_lv_tips = dataList[525],
	lightking_shengguang_result_tips = dataList[526],
	lightking_yaoshi_result_tips = dataList[527],
	lightking_jixian_result_tips = dataList[528],
	scuffleTip1 = dataList[529],
	scuffleTip2 = dataList[530],
	scuffleTip3 = dataList[531],
	scuffleTip4 = dataList[532],
	answerscene_nextaddscoretip = dataList[533],
	answerscene_scores = dataList[534],
	answerscene_helptip_notimes = dataList[535],
	answerscene_help_excep_error_notimes = dataList[536],
	answerscene_help_excep_error = dataList[537],
	answerscene_help_tips_used = dataList[538],
	answerscene_next_timecount = dataList[539],
	answerscene_scores_add = dataList[540],
	answerscene_noopened = dataList[541],
	answerscene_timelimits = dataList[542],
	answerscene_answernum = dataList[543],
	answerscene_progress = dataList[544],
	answerscene_rightanswer = dataList[545],
	answerscene_answerright = dataList[546],
	answerscene_answerwrong = dataList[547],
	answerscene_answermaxcombo = dataList[548],
	answerscene_scores_total = dataList[549],
	answerscene_result_title = dataList[550],
	answerscene_closed = dataList[551],
	answerscene_help_noneed = dataList[552],
	elizabeth_game_tip = dataList[553],
	elizabeth_rank_tip = dataList[554],
	petzoo_building_unlock_level = dataList[555],
	petzoo_building_locktips = dataList[556],
	petzoo_building_unlock_tips = dataList[557],
	petzoo_building_info = dataList[558],
	text_shop = dataList[559],
	text_upgrade = dataList[560],
	petzoo_building_hatcheggs = dataList[561],
	petzoo_building_deployment = dataList[562],
	petzoo_building_lostanimal_name = dataList[563],
	petzoo_tree_lvdesc = dataList[564],
	petzoo_amusementpark_lvdesc = dataList[565],
	petzoo_maincity_lvdesc = dataList[566],
	text_effect = dataList[567],
	petzoo_building_lvup_max = dataList[568],
	petzoo_building_lvup_title = dataList[569],
	petzoo_building_main_petnum = dataList[570],
	petzoo_building_main_happynum = dataList[571],
	petzoo_building_workernum = dataList[572],
	petzoo_building_worker_ratefactor = dataList[573],
	petzoo_building_worker_maxscore = dataList[574],
	petzoo_building_fruit_interval = dataList[575],
	petzoo_building_fruit_max = dataList[576],
	petzoo_building_lvup_maincity_lv_limit = dataList[577],
	petzoo_building_lvup_items_limit = dataList[578],
	petzoo_goto_fiend_home = dataList[579],
	petzoo_has_max_pet_count = dataList[580],
	petzoo_moral = dataList[581],
	petzoo_comeback_home = dataList[582],
	petzoo_absorb_compeleted = dataList[583],
	petzoo_absorb_absorbing = dataList[584],
	petzoo_stealfriuts_empty = dataList[585],
	petzoo_stealfriuts_stolenover = dataList[586],
	petzoo_friuts_nummax = dataList[587],
	petzoo_bestolentimes_limit = dataList[588],
	petzoo_stealtimes_tomax = dataList[589],
	petzoo_gainfriuts_empty = dataList[590],
	petzoo_friuts_max_timer = dataList[591],
	petzoo_absorb_cant = dataList[592],
	petzoo_traveler_noback = dataList[593],
	petzoo_traveler_timer = dataList[594],
	petzoo_pool_absorb_max = dataList[595],
	petzoo_pool_absorb_timer = dataList[596],
	petzoo_pool_absorb_cd = dataList[597],
	petzoo_pool_absorb_empty = dataList[598],
	petzoo_feed_items_noenough = dataList[599],
	petzoo_feed_times_over = dataList[600],
	petzoo_interact_times_over = dataList[601],
	petzoo_feed_max_level = dataList[602],
	petzoo_place_petsnum = dataList[603],
	petzoo_place_petsnum_max = dataList[604],
	petzoo_place_placed = dataList[605],
	petzoo_place_placed_empty = dataList[606],
	petzoo_selectpets_numtips = dataList[607],
	petzoo_selecteggs_numtips = dataList[608],
	petzoo_selectpets_tips = dataList[609],
	petzoo_selecteggs_tips = dataList[610],
	petzoo_selecteggs_empty = dataList[611],
	petzoo_selectpets_empty = dataList[612],
	petzoo_petdetail_mathctimes = dataList[613],
	petzoo_petdetail_eggstips = dataList[614],
	petzoo_matchtimes = dataList[615],
	petzoo_matchtimes_remain = dataList[616],
	petzoo_matchtimes_num = dataList[617],
	petzoo_matchtimes_over = dataList[618],
	petzoo_matchtimes_cd = dataList[619],
	petzoo_matchtimes_cd_time = dataList[620],
	petzoo_animalinfo_dontfollow = dataList[621],
	petzoo_animalinfo_follow = dataList[622],
	petzoo_animalinfo_follow_replacetips = dataList[623],
	petzoo_animal_gradeinfo = dataList[624],
	petzoo_animal_state_placed = dataList[625],
	petzoo_animal_state_follow = dataList[626],
	petzoo_animal_state_working = dataList[627],
	petzoo_animal_cantdelete_tips = dataList[628],
	petzoo_animal_delete_lvlimittips = dataList[629],
	petzoo_animal_delete_title = dataList[630],
	petzoo_animal_delete_tips = dataList[631],
	petzoo_rename_name_fmt = dataList[632],
	petzoo_rename_cantemtpy = dataList[633],
	petzoo_rename_name_exist = dataList[634],
	petzoo_rename_name_tooshort = dataList[635],
	petzoo_rename_name_toolong = dataList[636],
	petzoo_rename_name_invalid = dataList[637],
	petzoo_rename_name_sensitive = dataList[638],
	petzoo_rename_all_underline = dataList[639],
	petzoo_rename_all_number = dataList[640],
	petzoo_rename_success = dataList[641],
	petzoo_hatch_slot_viplimit = dataList[642],
	petzoo_hatch_has_stolen_time = dataList[643],
	petzoo_hatch_stolen_owner = dataList[644],
	petzoo_hatch_stolen_max = dataList[645],
	petzoo_hatch_finished = dataList[646],
	petzoo_hatch_slot_egg_empty = dataList[647],
	petzoo_selecteggs_select_none = dataList[648],
	petzoo_hatch_surplustimer = dataList[649],
	petzoo_hatchfisnish_cantcancel = dataList[650],
	petzoo_absorb_isabsorbing = dataList[651],
	petzoo_absorb_nohatching = dataList[652],
	petzoo_absorb_mintime_limit = dataList[653],
	petzoo_absorb_in_cd = dataList[654],
	petzoo_absorb_absorbed = dataList[655],
	petzoo_absorb_nofriend = dataList[656],
	petzoo_absorb_put_tips = dataList[657],
	petzoo_absorb_unistall = dataList[658],
	petzoo_absorb_prize_timelimit = dataList[659],
	petzoo_log_date = dataList[660],
	petzoo_log_visit = dataList[661],
	petzoo_log_stealfriuts = dataList[662],
	petzoo_working_unlockpet_level = dataList[663],
	petzoo_working_nummaxtips = dataList[664],
	petzoo_working_currratetips = dataList[665],
	petzoo_working_currworkingtips = dataList[666],
	petzoo_working_production_spd = dataList[667],
	petzoo_friuts_num = dataList[668],
	text_collection_progress = dataList[669],
	text_onekey_getall = dataList[670],
	petzoo_genus_head = dataList[671],
	petzoo_genus_back = dataList[672],
	petzoo_genus_weapon = dataList[673],
	petzoo_genus_head_sign = dataList[674],
	petzoo_genus_expression = dataList[675],
	petzoo_genus_clothes = dataList[676],
	petzoo_genus_tail = dataList[677],
	petzoo_genus_work = dataList[678],
	petzoo_match_remaintimes = dataList[679],
	petzoo_match_notimes = dataList[680],
	petzoo_match_friend_offline = dataList[681],
	petzoo_match_invite_counttime = dataList[682],
	petzoo_match_invite_waiting = dataList[683],
	petzoo_match_invite_norespond = dataList[684],
	petzoo_match_invite_refused = dataList[685],
	petzoo_match_invite_accepted = dataList[686],
	petzoo_match_invite_hasrefused = dataList[687],
	petzoo_match_cancel = dataList[688],
	petzoo_match_waitingready_time = dataList[689],
	petzoo_match_waitingready_warningtime = dataList[690],
	petzoo_match_inescort = dataList[691],
	petzoo_match_noavailable = dataList[692],
	petzoo_match_norespond = dataList[693],
	petzoo_match_handle_timecount = dataList[694],
	petzoo_match_handle_nopets = dataList[695],
	petzoo_match_readying = dataList[696],
	petzoo_match_hasready = dataList[697],
	text_pages_num = dataList[698],
	text_none = dataList[699],
	text_hasgot = dataList[700],
	text_hasnt_got = dataList[701],
	petzoo_genes_nosel_genes = dataList[702],
	petzoo_genes_noexist_genes_animal = dataList[703],
	petzoo_speedcard_title = dataList[704],
	petzoo_speedcard_selecttips = dataList[705],
	petzoo_speedcard_nocard = dataList[706],
	petzoo_speedcard_hatchfinished = dataList[707],
	petzoo_noanimals = dataList[708],
	petzoo_noeggs = dataList[709],
	petzoo_shop_title = dataList[710],
	petzoo_shop_locktips = dataList[711],
	petzoo_shop_coinnoenough = dataList[712],
	longnv_ch_rule = dataList[713],
	catch_props_unlockcost = dataList[714],
	catch_props_unlockcost_noenough = dataList[715],
	text_requesting_svr_data = dataList[716],
	text_curr_hasnum = dataList[717],
	catch_props_timely_rewards = dataList[718],
	text_startgame = dataList[719],
	text_remain_times = dataList[720],
	text_buytimes_tips = dataList[721],
	catch_props_exitgame_tips = dataList[722],
	text_buytimes_max_tips = dataList[723],
	text_buytimes_item_noenough = dataList[724],
	catch_props_unlocktips = dataList[725],
	catch_props_propsnum = dataList[726],
	catch_props_gametimes_over = dataList[727],
	catch_props_getawards = dataList[728],
	catch_props_getprops_numtips = dataList[729],
	text_next_level_title = dataList[730],
	text_curr_level_title = dataList[731],
	catch_props_countingdown_time = dataList[732],
	drawequipments_title = dataList[733],
	text_cost_tips = dataList[734],
	drawequipments_draw_numtips = dataList[735],
	drawequipments_hasdraw_numtips = dataList[736],
	text_countdown_min = dataList[737],
	text_countdown_second = dataList[738],
	text_rewards_review_linefeed = dataList[739],
	text_rewards_review_tips = dataList[740],
	text_hot_sell = dataList[741],
	text_discount_num = dataList[742],
	text_rules_title = dataList[743],
	drawequipments_draw_rate = dataList[744],
	drawequipments_draw_uprate = dataList[745],
	checkupdetailview__space = dataList[746],
	checkupdetailview__lvl = dataList[747],
	checkupdetailview__awaken = dataList[748],
	checkupdetailview__not_awaken = dataList[749],
	checkupdetailview__bond = dataList[750],
	checkupdetailview__gift = dataList[751],
	extremepowerview__zdl = dataList[752],
	extremepowerview__maxZdl = dataList[753],
	handbookpetattributeview__add = dataList[754],
	handbookpetbasicview__tips = dataList[755],
	handbookpetbasicview__noenough_tips = dataList[756],
	powercheckrankview__title = dataList[757],
	powercheckrankview__rankall_tips = dataList[758],
	powercheckrankview__rank_tips = dataList[759],
	powercheckview__desc = dataList[760],
	powercheckview__tips1 = dataList[761],
	powercheckview__tips2 = dataList[762],
	powercheckview__skill = dataList[763],
	powercheckview__select_pet = dataList[764],
	powercheckview__err_tips = dataList[765],
	powercheck_relation = dataList[766],
	extremepowerview_other_tips = dataList[767],
	extremepowerview_other_tips_1 = dataList[768],
	text_reward_instruction_title = dataList[769],
	text_integrals = dataList[770],
	text_integrals_num = dataList[771],
	text_reward = dataList[772],
	drawequip_open_tips = dataList[773],
	drawequip_item_time_desc1 = dataList[774],
	drawequip_item_time_desc2 = dataList[775],
	text_refresh_all_hours = dataList[776],
	scuffle_tip1 = dataList[777],
	strongestfmtcertificationview__1 = dataList[778],
	strongestfmtcertificationview__2 = dataList[779],
	strongestfmtcertificationview__6 = dataList[780],
	strongestfmtcertificationview__7 = dataList[781],
	strongestfmtcertificationview__8 = dataList[782],
	strongfmtrankview__1 = dataList[783],
	strongfmtrankview__2 = dataList[784],
	text_all_power = dataList[785],
	text_all_speed = dataList[786],
	text_activity_end = dataList[787],
	text_today_award = dataList[788],
	text_suo_timer_1 = dataList[789],
	text_suo_timer_2 = dataList[790],
	text_mirror_chall_count = dataList[791],
	text_mirror_desc_1 = dataList[792],
	text_mirror_desc_2 = dataList[793],
	text_today_get = dataList[794],
	text_mirror_desc_3 = dataList[795],
	text_mirror_desc_4 = dataList[796],
	text_mirror_desc_5 = dataList[797],
	text_mirror_desc_6 = dataList[798],
	text_mirror_desc_7 = dataList[799],
	hongliannvhuangview__1 = dataList[800],
	hongliannvhuangview__2 = dataList[801],
	hongliannvhuangview__3 = dataList[802],
	hongliannvhuangview__4 = dataList[803],
	hongliannvhuangview__5 = dataList[804],
	hongliannvhuangview__6 = dataList[805],
	honglianzhanfangview__1 = dataList[806],
	liehuohonglianiview__1 = dataList[807],
	moyanbattleview__1 = dataList[808],
	moyanbattleview__2 = dataList[809],
	moyanbattleview__3 = dataList[810],
	moyanbattleview__4 = dataList[811],
	moyanmainview__1 = dataList[812],
	moyanmainview__2 = dataList[813],
	moyanfmtrightview__1 = dataList[814],
	moyanmainview__3 = dataList[815],
	moyanmainview__4 = dataList[816],
	text_lottery_desc_1 = dataList[817],
	text_lottery_shenhuan = dataList[818],
	text_lottery_zhaohuan = dataList[819],
	text_lottery_xiaohao = dataList[820],
	text_lottery_desc_2 = dataList[821],
	text_lottery_desc_3 = dataList[822],
	text_lottery_desc_4 = dataList[823],
	text_lottery_desc_5 = dataList[824],
	text_lottery_desc_6 = dataList[825],
	text_lottery_desc_7 = dataList[826],
	text_lottery_desc_8 = dataList[827],
	text_lottery_desc_9 = dataList[828],
	text_lottery_desc_10 = dataList[829],
	text_lottery_desc_11 = dataList[830],
	text_lottery_desc_12 = dataList[831],
	text_lottery_desc_13 = dataList[832],
	text_lottery_desc_14 = dataList[833],
	text_lottery_switch = dataList[834],
	text_lottery_desc_16 = dataList[835],
	text_lottery_choise = dataList[836],
	text_lottery_desc_18 = dataList[837],
	text_lottery_desc_19 = dataList[838],
	text_lottery_lock = dataList[839],
	text_lottery_desc_21 = dataList[840],
	text_lottery_buy_tips = dataList[841],
	text_lottery_buy = dataList[842],
	text_lottery_desc_15 = dataList[843],
	text_lottery_desc_17 = dataList[844],
	text_lottery_desc_20 = dataList[845],
	text_lottery_desc_22 = dataList[846],
	text_lottery_desc_23 = dataList[847],
	text_lottery_desc_24 = dataList[848],
	text_lottery_desc_25 = dataList[849],
	text_lottery_desc_26 = dataList[850],
	text_lottery_desc_27 = dataList[851],
	text_lottery_desc_28 = dataList[852],
	text_lottery_desc_29 = dataList[853],
	text_lottery_desc_30 = dataList[854],
	text_lottery_desc_31 = dataList[855],
	text_lottery_desc_32 = dataList[856],
	text_lottery_desc_33 = dataList[857],
	text_lottery_desc_34 = dataList[858],
	text_lottery_desc_38 = dataList[859],
	text_lottery_desc_39 = dataList[860],
	text_lottery_desc_40 = dataList[861],
	text_lottery_desc_41 = dataList[862],
	text_lottery_desc_42 = dataList[863],
	text_lottery_desc_43 = dataList[864],
	text_lottery_desc_44 = dataList[865],
	text_lottery_desc_45 = dataList[866],
	text_lottery_desc_46 = dataList[867],
	text_lottery_desc_47 = dataList[868],
	text_lottery_wish_tips = dataList[869],
	text_tili_name = dataList[870],
	text_tili_desc_1 = dataList[871],
	text_tili_over = dataList[872],
	text_tili_free = dataList[873],
	text_tili_desc_2 = dataList[874],
	text_tili_desc_3 = dataList[875],
	text_tili_use = dataList[876],
	text_tili_desc_4 = dataList[877],
	text_tili_desc_5 = dataList[878],
	text_tili_desc_6 = dataList[879],
	text_tili_desc_7 = dataList[880],
	text_tili_desc_8 = dataList[881],
	text_tili_desc_9 = dataList[882],
	text_tili_desc_10 = dataList[883],
	text_equip_desc_1 = dataList[884],
	text_equip_desc_2 = dataList[885],
	text_equip_desc_3 = dataList[886],
	text_equip_desc_4 = dataList[887],
	text_equip_desc_5 = dataList[888],
	text_equip_desc_6 = dataList[889],
	text_equip_desc_7 = dataList[890],
	text_equip_desc_8 = dataList[891],
	text_equip_desc_9 = dataList[892],
	text_equip_desc_10 = dataList[893],
	text_equip_desc_11 = dataList[894],
	text_equip_desc_12 = dataList[895],
	text_equip_analysis_tips = dataList[896],
	text_equip_desc_14 = dataList[897],
	text_equip_desc_15 = dataList[898],
	text_equip_desc_16 = dataList[899],
	text_equip_desc_17 = dataList[900],
	text_equip_desc_18 = dataList[901],
	text_equip_desc_19 = dataList[902],
	text_equip_desc_13 = dataList[903],
	yearcard_tips = dataList[904],
	text_equip_buy = dataList[905],
	text_equip_all = dataList[906],
	text_equip_desc_20 = dataList[907],
	text_equip_desc_21 = dataList[908],
	text_equip_desc_22 = dataList[909],
	text_equip_desc_23 = dataList[910],
	text_equip_desc_24 = dataList[911],
	text_equip_desc_25 = dataList[912],
	text_equip_desc_26 = dataList[913],
	text_equip_desc_27 = dataList[914],
	text_equip_desc_28 = dataList[915],
	text_equip_desc_29 = dataList[916],
	text_equip_desc_30 = dataList[917],
	text_equip_desc_31 = dataList[918],
	text_equip_desc_32 = dataList[919],
	text_equip_lv = dataList[920],
	text_equip_desc_33 = dataList[921],
	text_equip_desc_34 = dataList[922],
	text_equip_desc_35 = dataList[923],
	text_equip_desc_36 = dataList[924],
	text_equip_desc_37 = dataList[925],
	text_equip_desc_38 = dataList[926],
	text_equip_desc_39 = dataList[927],
	text_equip_desc_40 = dataList[928],
	text_equip_desc_41 = dataList[929],
	text_equip_desc_42 = dataList[930],
	text_equip_desc_43 = dataList[931],
	text_equip_desc_44 = dataList[932],
	text_equip_desc_45 = dataList[933],
	text_equip_desc_46 = dataList[934],
	text_equip_desc_47 = dataList[935],
	text_equip_desc_48 = dataList[936],
	text_equip_desc_49 = dataList[937],
	text_equip_desc_50 = dataList[938],
	text_equip_name = dataList[939],
	text_equip_replace = dataList[940],
	text_equip_desc_51 = dataList[941],
	text_equip_desc_52 = dataList[942],
	text_equip_desc_53 = dataList[943],
	text_equip_desc_54 = dataList[944],
	text_equip_desc_55 = dataList[945],
	text_equip_desc_56 = dataList[946],
	text_equip_desc_57 = dataList[947],
	text_equip_desc_58 = dataList[948],
	text_equip_desc_59 = dataList[949],
	text_equip_desc_60 = dataList[950],
	text_equip_desc_61 = dataList[951],
	text_equip_desc_62 = dataList[952],
	text_equip_desc_63 = dataList[953],
	text_equip_desc_64 = dataList[954],
	text_equip_desc_65 = dataList[955],
	text_equip_desc_66 = dataList[956],
	text_equip_desc_67 = dataList[957],
	text_equip_desc_68 = dataList[958],
	text_equip_desc_69 = dataList[959],
	text_equip_desc_70 = dataList[960],
	text_equip_desc_71 = dataList[961],
	text_equip_desc_72 = dataList[962],
	text_equip_desc_73 = dataList[963],
	text_equip_desc_74 = dataList[964],
	text_equip_desc_75 = dataList[965],
	text_equip_desc_76 = dataList[966],
	text_equip_desc_77 = dataList[967],
	text_equip_desc_78 = dataList[968],
	text_equip_desc_79 = dataList[969],
	text_equip_desc_80 = dataList[970],
	text_equip_desc_81 = dataList[971],
	text_equip_tupo = dataList[972],
	text_equip_desc_82 = dataList[973],
	text_equip_desc_83 = dataList[974],
	text_equip_desc_84 = dataList[975],
	text_equip_desc_85 = dataList[976],
	text_equip_desc_86 = dataList[977],
	text_equip_desc_87 = dataList[978],
	text_equip_desc_88 = dataList[979],
	text_equip_desc_89 = dataList[980],
	text_equip_desc_90 = dataList[981],
	text_equip_not_open = dataList[982],
	text_equip_desc_91 = dataList[983],
	text_equip_desc_92 = dataList[984],
	text_equip_desc_93 = dataList[985],
	text_equip_desc_94 = dataList[986],
	text_equip_desc_95 = dataList[987],
	text_equip_desc_96 = dataList[988],
	text_equip_desc_97 = dataList[989],
	text_equip_desc_98 = dataList[990],
	text_equip_desc_99 = dataList[991],
	text_equip_desc_100 = dataList[992],
	recommendfmtcontroller__1 = dataList[993],
	text_tong_desc_1 = dataList[994],
	text_tong_desc_2 = dataList[995],
	text_tong_desc_3 = dataList[996],
	text_tong_desc_4 = dataList[997],
	text_tong_desc_5 = dataList[998],
	text_tong_desc_6 = dataList[999],
	text_tong_desc_7 = dataList[1000],
	text_tong_desc_8 = dataList[1001],
	text_tong_desc_9 = dataList[1002],
	text_tong_desc_10 = dataList[1003],
	text_tong_desc_11 = dataList[1004],
	text_tong_desc_12 = dataList[1005],
	text_tong_desc_13 = dataList[1006],
	text_tong_desc_14 = dataList[1007],
	text_tong_desc_15 = dataList[1008],
	text_tong_desc_16 = dataList[1009],
	text_tong_desc_17 = dataList[1010],
	text_tong_desc_18 = dataList[1011],
	text_tong_desc_19 = dataList[1012],
	text_tong_desc_20 = dataList[1013],
	text_tong_desc_23 = dataList[1014],
	text_tong_desc_24 = dataList[1015],
	text_tong_desc_25 = dataList[1016],
	text_tong_desc_26 = dataList[1017],
	text_tong_desc_28 = dataList[1018],
	text_tong_desc_29 = dataList[1019],
	text_tong_desc_30 = dataList[1020],
	text_tong_tips = dataList[1021],
	text_tong_know = dataList[1022],
	text_battle_end = dataList[1023],
	text_battle_success = dataList[1024],
	text_battle_fail = dataList[1025],
	text_buy_tips = dataList[1026],
	text_tong_desc_21 = dataList[1027],
	text_round_name = dataList[1028],
	text_rank_notrank = dataList[1029],
	text_tong_rank_1 = dataList[1030],
	text_tong_rank_2 = dataList[1031],
	text_tong_desc_22 = dataList[1032],
	text_tong_desc_27 = dataList[1033],
	recommendfmtcontroller__2 = dataList[1034],
	recommendfmtcontroller__3 = dataList[1035],
	heart_money_cat_1 = dataList[1036],
	heart_money_cat_2 = dataList[1037],
	scuffle_tip2 = dataList[1038],
	cancel = dataList[1039],
	noahchallenge_tip1 = dataList[1040],
	noahchallenge_tip2 = dataList[1041],
	noahchallenge_tip3 = dataList[1042],
	text_buy_commodity_tips = dataList[1043],
	text_buy_all_commodity_tips = dataList[1044],
	text_buy_all_commodity_tips_2 = dataList[1045],
	text_activity_time_limit_d_d = dataList[1046],
	text_buy_you_have_purchased = dataList[1047],
	text_countdown_dhms = dataList[1048],
	text_activity_ended_cozy_tips = dataList[1049],
	text_activity_not_on_cozy_tips = dataList[1050],
	text_domainskill = dataList[1051],
	text_domainskill_notactive = dataList[1052],
	text_domainskill_active = dataList[1053],
	text_recall_code = dataList[1054],
	text_recall_desc_1 = dataList[1055],
	text_recall_desc_2 = dataList[1056],
	text_recall_desc_3 = dataList[1057],
	text_recall_desc_4 = dataList[1058],
	text_recall_desc_5 = dataList[1059],
	text_recall_desc_6 = dataList[1060],
	text_recall_desc_7 = dataList[1061],
	text_recall_desc_8 = dataList[1062],
	text_recall_desc_9 = dataList[1063],
	text_recall_desc_10 = dataList[1064],
	text_recall_desc_11 = dataList[1065],
	text_recall_desc_12 = dataList[1066],
	text_recall_desc_13 = dataList[1067],
	text_recall_desc_14 = dataList[1068],
	text_recall_desc_15 = dataList[1069],
	text_recall_desc_16 = dataList[1070],
	text_recall_desc_17 = dataList[1071],
	text_recall_desc_18 = dataList[1072],
	text_recall_desc_19 = dataList[1073],
	text_recall_desc_20 = dataList[1074],
	text_share_name = dataList[1075],
	text_currency_name = dataList[1076],
	text_recall_desc_21 = dataList[1077],
	text_recall_desc_22 = dataList[1078],
	text_recall_desc_23 = dataList[1079],
	text_recall_desc_24 = dataList[1080],
	text_recall_desc_25 = dataList[1081],
	text_recall_desc_26 = dataList[1082],
	text_recall_desc_27 = dataList[1083],
	text_recall_desc_28 = dataList[1084],
	text_recall_desc_29 = dataList[1085],
	text_recall_desc_30 = dataList[1086],
	text_recall_desc_31 = dataList[1087],
	text_recall_desc_32 = dataList[1088],
	text_recall_desc_33 = dataList[1089],
	text_recall_desc_34 = dataList[1090],
	text_recall_desc_35 = dataList[1091],
	text_recall_desc_36 = dataList[1092],
	text_recall_desc_37 = dataList[1093],
	text_recall_desc_38 = dataList[1094],
	text_recall_desc_39 = dataList[1095],
	text_recall_desc_40 = dataList[1096],
	aceteamagent__1 = dataList[1097],
	aceteamagent__2 = dataList[1098],
	aceteamagent__3 = dataList[1099],
	aceteamagent__4 = dataList[1100],
	aceteamagent__5 = dataList[1101],
	aceteamagent__6 = dataList[1102],
	aceteamcontroller__1 = dataList[1103],
	aceteamcontroller__2 = dataList[1104],
	aceteamcontroller__3 = dataList[1105],
	aceteamcontroller__4 = dataList[1106],
	aceteamcontroller__5 = dataList[1107],
	aceteamcontroller__6 = dataList[1108],
	aceteamcontroller__7 = dataList[1109],
	aceteamcontroller__8 = dataList[1110],
	aceteamcontroller__9 = dataList[1111],
	aceteamcontroller__10 = dataList[1112],
	aceteamcontroller__11 = dataList[1113],
	aceteamcontroller__12 = dataList[1114],
	aceteamcontroller__13 = dataList[1115],
	aceteamcontroller__14 = dataList[1116],
	aceteamcontroller__15 = dataList[1117],
	aceteammainview__1 = dataList[1118],
	aceteammainview__2 = dataList[1119],
	aceteammainview__3 = dataList[1120],
	aceteammainview__4 = dataList[1121],
	aceteammainview__5 = dataList[1122],
	aceteammainview__6 = dataList[1123],
	aceteammainview__7 = dataList[1124],
	aceteammainview__8 = dataList[1125],
	aceteammainview__9 = dataList[1126],
	aceteammainview__10 = dataList[1127],
	aceteammainview__11 = dataList[1128],
	aceteammainview__12 = dataList[1129],
	aceteammainview__13 = dataList[1130],
	actstargodchangeview__1 = dataList[1131],
	actstargodchangeview__2 = dataList[1132],
	actstargodchangeview__3 = dataList[1133],
	matchingpopupview__1 = dataList[1134],
	matchingpopupview__2 = dataList[1135],
	matchingpopupview__3 = dataList[1136],
	matchingpopupview__4 = dataList[1137],
	aceteambuzhenleftview__1 = dataList[1138],
	aceteammissionview__1 = dataList[1139],
	aceteammissionview__2 = dataList[1140],
	aceteamawakeview__1 = dataList[1141],
	aceteamawakeview__2 = dataList[1142],
	aceteamawakeview__3 = dataList[1143],
	aceteamawakeview__4 = dataList[1144],
	aceteamawakeview__5 = dataList[1145],
	aceteamawakeview__6 = dataList[1146],
	aceteamawakeview__7 = dataList[1147],
	aceteamawakeview__8 = dataList[1148],
	aceteamawakeview__9 = dataList[1149],
	aceteamequipview__1 = dataList[1150],
	aceteamequipview__2 = dataList[1151],
	aceteampetskillview__1 = dataList[1152],
	aceteampetskillview__2 = dataList[1153],
	aceteampetskillview__3 = dataList[1154],
	aceteampetskillview__4 = dataList[1155],
	aceteampetskillview__5 = dataList[1156],
	aceteamshowview__1 = dataList[1157],
	aceteamstargodview__1 = dataList[1158],
	aceteamstargodview__2 = dataList[1159],
	aceteamstargodview__3 = dataList[1160],
	aceteamrankview__1 = dataList[1161],
	aceteamrankview__2 = dataList[1162],
	aceteamrankview__3 = dataList[1163],
	aceteamrankview__4 = dataList[1164],
	aceteamrankview__5 = dataList[1165],
	aceteamrankview__6 = dataList[1166],
	aceteamrankview__7 = dataList[1167],
	aceteamrankview__8 = dataList[1168],
	aceteamrankview__9 = dataList[1169],
	aceteamrankview__10 = dataList[1170],
	aceteamruleview__1 = dataList[1171],
	aceteamcontroller__16 = dataList[1172],
	aceteammainview__14 = dataList[1173],
	aceteamawakeview__10 = dataList[1174],
	aceteamawakeview__11 = dataList[1175],
	aceteammainview__15 = dataList[1176],
	aceteammainview__16 = dataList[1177],
	aceteammainview__17 = dataList[1178],
	divineevolve_tip1 = dataList[1179],
	aceteamcontroller__17 = dataList[1180],
	aceteambossview__1 = dataList[1181],
	aceteambossview__2 = dataList[1182],
	aceteamformationview__1 = dataList[1183],
	heart_grow_up_right_time = dataList[1184],
	heart_grow_up_tip_title = dataList[1185],
	heart_grow_up_tip_desc = dataList[1186],
	heart_grow_up_tip_strengthen = dataList[1187],
	heart_grow_up_tip_strengthen_ed = dataList[1188],
	nian_chall_main_name = dataList[1189],
	nian_chall_main_rule = dataList[1190],
	nian_chall_fmt_tip = dataList[1191],
	nian_chall_stage_select_tip = dataList[1192],
	nian_chall_enter_stage_tip = dataList[1193],
	nian_welfare_limit_tip = dataList[1194],
	nian_welfare_daily_prize = dataList[1195],
	nian_welfare_achievement_prize = dataList[1196],
	nian_welfare_part_tip = dataList[1197],
	nian_welfare_refining = dataList[1198],
	nian_welfare_refining_ing = dataList[1199],
	nian_welfare_refining_ed = dataList[1200],
	nian_welfare_achievement_prize_ed = dataList[1201],
	nian_welfare_achievement_task_desc = dataList[1202],
	twin_dragon_challenge_1 = dataList[1203],
	twin_dragon_challenge_2 = dataList[1204],
	twin_dragon_challenge_3 = dataList[1205],
	twin_dragon_challenge_4 = dataList[1206],
	twin_dragon_challenge_6 = dataList[1207],
	twin_dragon_challenge_7 = dataList[1208],
	twin_dragon_challenge_8 = dataList[1209],
	twin_dragon_challenge_9 = dataList[1210],
	twin_dragon_challenge_10 = dataList[1211],
	twin_dragon_challenge_11 = dataList[1212],
	twin_dragon_challenge_12 = dataList[1213],
	twin_dragon_challenge_13 = dataList[1214],
	redstargodsellview_1 = dataList[1215],
	redstargodsellview_2 = dataList[1216],
	today_remaintimes = dataList[1217],
	text_noneed_buyplaytimes = dataList[1218],
	text_summontower_sweeptips = dataList[1219],
	text_countdown_notips_min = dataList[1220],
	text_countdown_notips_second = dataList[1221],
	text_summontower_itemtips = dataList[1222],
	text_summon_careername_guang = dataList[1223],
	text_summon_careername_an = dataList[1224],
	text_summon_careername_shui = dataList[1225],
	text_summon_careername_huo = dataList[1226],
	text_summon_careername_cao = dataList[1227],
	text_summon_master_noseltips = dataList[1228],
	text_summon_master_seltips = dataList[1229],
	text_summon_master_selsuccess = dataList[1230],
	text_summon_scores_rewardstips = dataList[1231],
	text_summon_rank = dataList[1232],
	text_summon_rank_range = dataList[1233],
	text_summon_ranksreward_tips = dataList[1234],
	text_summon_firstpassreward_tips = dataList[1235],
	txt_summontower_shop_tips = dataList[1236],
	txt_summontower_shop_bubbletips = dataList[1237],
	txt_summontower_protagonisthalo_zhishouhuajiao = dataList[1238],
	txt_summontower_protagonisthalo_yanshuodashi = dataList[1239],
	txt_summontower_eff_zhanshudaquan = dataList[1240],
	txt_summontower_eff_yanjiangzhishu = dataList[1241],
	txt_summontower_eff_zhanshudaquan_all = dataList[1242],
	txt_summontower_eff_yanjiangzhishu_all = dataList[1243],
	txt_summontower_selwish = dataList[1244],
	txt_summontower_revivetips = dataList[1245],
	txt_summontower_summonmasterrevivetips = dataList[1246],
	txt_summontower_startgame = dataList[1247],
	txt_summontower_continuegame = dataList[1248],
	txt_summontower_buyguard = dataList[1249],
	timewheel_tip1 = dataList[1250],
	timewheel_tip2 = dataList[1251],
	timewheel_tip3 = dataList[1252],
	stargodplusexchange1 = dataList[1253],
	stargodplusexchange2 = dataList[1254],
	stargodplusexchange3 = dataList[1255],
	stargodplusexchange4 = dataList[1256],
	text_halloween_desc_1 = dataList[1257],
	text_halloween_desc_2 = dataList[1258],
	text_halloween_desc_3 = dataList[1259],
	text_halloween_desc_4 = dataList[1260],
	text_halloween_desc_5 = dataList[1261],
	text_halloween_desc_6 = dataList[1262],
	text_halloween_desc_7 = dataList[1263],
	text_halloween_desc_8 = dataList[1264],
	text_halloween_desc_9 = dataList[1265],
	text_halloween_desc_10 = dataList[1266],
	text_halloween_desc_11 = dataList[1267],
	text_halloween_desc_12 = dataList[1268],
	text_halloween_desc_13 = dataList[1269],
	athena_challenge_tip_1 = dataList[1270],
	athena_challenge_tip_2 = dataList[1271],
	athena_challenge_tip_3 = dataList[1272],
	athena_challenge_tip_4 = dataList[1273],
	athena_challenge_tip_5 = dataList[1274],
	athena_challenge_tip_6 = dataList[1275],
	text_biaoqing_desc_1 = dataList[1276],
	text_wltower_desc_1 = dataList[1277],
	text_wltower_desc_2 = dataList[1278],
	text_wltower_desc_3 = dataList[1279],
	text_wltower_desc_4 = dataList[1280],
	text_wltower_desc_5 = dataList[1281],
	text_wltower_desc_6 = dataList[1282],
	text_wltower_desc_7 = dataList[1283],
	text_wltower_desc_8 = dataList[1284],
	text_wltower_desc_9 = dataList[1285],
	text_wltower_desc_10 = dataList[1286],
	text_wltower_desc_11 = dataList[1287],
	text_wltower_desc_12 = dataList[1288],
	text_wltower_desc_13 = dataList[1289],
	text_wltower_desc_14 = dataList[1290],
	celebrate_birthday_1 = dataList[1291],
	celebrate_birthday_2 = dataList[1292],
	celebrate_birthday_3 = dataList[1293],
	celebrate_birthday_4 = dataList[1294],
	celebrate_birthday_5 = dataList[1295],
	celebrate_birthday_6 = dataList[1296],
	celebrate_birthday_7 = dataList[1297],
	celebrate_birthday_8 = dataList[1298],
	celebrate_birthday_9 = dataList[1299],
	celebrate_birthday_10 = dataList[1300],
	text_The_What_Day = dataList[1301],
	text_LotteryBox_Tips_No = dataList[1302],
	text_write_phone = dataList[1303],
	materialchallenge_desc1 = dataList[1304],
	materialchallenge_desc2 = dataList[1305],
	petshowinfostacknew__shuangsheng = dataList[1306],
	winner_challenge_1 = dataList[1307],
	FunArena_Formation_Tips_1 = dataList[1308],
	FunArena_Formation_Tips_2 = dataList[1309],
	FunArena_Formation_Tips_3 = dataList[1310],
	FunArena_Formation_Tips_4 = dataList[1311],
	FunArena_mission_Tips_1 = dataList[1312],
	FunArena_mission_Tips_2 = dataList[1313],
	FunArena_SuccessView_Tips_1 = dataList[1314],
	FunArena_FailSimpleView_Tips_1 = dataList[1315],
	FunArena_FailSimpleView_Tips_2 = dataList[1316],
	FunArena_HallView_Tips_1 = dataList[1317],
	FunArena_HallView_Tips_2 = dataList[1318],
	FunArena_HallView_Tips_3 = dataList[1319],
	FunArena_HallView_Tips_4 = dataList[1320],
	text_a_success = dataList[1321],
	text_a_fail = dataList[1322],
	FunArena_RankView_Tips_1 = dataList[1323],
	FunArena_RankView_Tips_2 = dataList[1324],
	FunArenaView_Tips_1 = dataList[1325],
	Fun_LotteryView_Tips_1 = dataList[1326],
	Fun_LotteryView_Tips_2 = dataList[1327],
	Fun_LotteryView_Tips_3 = dataList[1328],
	Fun_LotteryView_Tips_4 = dataList[1329],
	Fun_LotteryView_Tips_5 = dataList[1330],
	Fun_LotteryView_Tips_6 = dataList[1331],
	Fun_LotteryView_Tips_7 = dataList[1332],
	Fun_SpecialRewardView_Tips_1 = dataList[1333],
	Fun_SpecialRewardView_Tips_2 = dataList[1334],
	race_kong = dataList[1335],
	race_chuang = dataList[1336],
	chuangkongunion_text_1 = dataList[1337],
	text_dragon_desc_1 = dataList[1338],
	text_dragon_desc_2 = dataList[1339],
	text_dragon_desc_3 = dataList[1340],
	text_dragon_desc_4 = dataList[1341],
	text_dragon_desc_5 = dataList[1342],
	text_dragon_desc_6 = dataList[1343],
	text_dragon_desc_7 = dataList[1344],
	text_dragon_desc_8 = dataList[1345],
	text_dragon_desc_9 = dataList[1346],
	text_dragon_desc_10 = dataList[1347],
	text_dragon_desc_11 = dataList[1348],
	text_dragon_desc_12 = dataList[1349],
	text_dragon_desc_13 = dataList[1350],
	text_dragon_desc_14 = dataList[1351],
	red_pocket_leave = dataList[1352],
	text_goddess_desc_1 = dataList[1353],
	text_goddess_desc_2 = dataList[1354],
	text_goddess_desc_3 = dataList[1355],
	text_goddess_desc_4 = dataList[1356],
	text_goddess_desc_5 = dataList[1357],
	text_goddess_desc_6 = dataList[1358],
	text_goddess_desc_7 = dataList[1359],
	text_goddess_desc_8 = dataList[1360],
	text_goddess_desc_9 = dataList[1361],
	text_goddess_desc_10 = dataList[1362],
	text_goddess_desc_11 = dataList[1363],
	text_goddess_desc_12 = dataList[1364],
	text_goddess_desc_13 = dataList[1365],
	text_goddess_desc_14 = dataList[1366],
	text_goddess_desc_15 = dataList[1367],
	text_goddess_desc_16 = dataList[1368],
	text_goddess_desc_17 = dataList[1369],
	text_goddess_desc_18 = dataList[1370],
	text_goddess_desc_19 = dataList[1371],
	text_goddess_desc_20 = dataList[1372],
	text_goddess_desc_21 = dataList[1373],
	text_goddess_desc_22 = dataList[1374],
	text_goddess_desc_23 = dataList[1375],
	text_goddess_desc_24 = dataList[1376],
	text_goddess_desc_25 = dataList[1377],
	text_goddess_desc_26 = dataList[1378],
	text_goddess_desc_27 = dataList[1379],
	text_goddess_desc_28 = dataList[1380],
	text_goddess_desc_29 = dataList[1381],
	text_goddess_desc_30 = dataList[1382],
	text_goddess_desc_31 = dataList[1383],
	text_goddess_desc_32 = dataList[1384],
	text_goddess_desc_33 = dataList[1385],
	text_goddess_desc_34 = dataList[1386],
	text_goddess_desc_35 = dataList[1387],
	text_goddess_desc_36 = dataList[1388],
	text_annual_desc_1 = dataList[1389],
	text_annual_desc_2 = dataList[1390],
	text_annual_desc_3 = dataList[1391],
	text_annual_desc_4 = dataList[1392],
	text_annual_desc_5 = dataList[1393],
	text_annual_desc_6 = dataList[1394],
	text_annual_desc_7 = dataList[1395],
	text_annual_desc_8 = dataList[1396],
	text_annual_desc_9 = dataList[1397],
	text_annual_desc_10 = dataList[1398],
	makecake_tip1 = dataList[1399],
	makecake_tip2 = dataList[1400],
	makecake_tip3 = dataList[1401],
	makecake_tip4 = dataList[1402],
	makecake_tip5 = dataList[1403],
	makecake_tip6 = dataList[1404],
	makecake_tip7 = dataList[1405],
	makecake_tip8 = dataList[1406],
	makecake_tip9 = dataList[1407],
	makecake_tip10 = dataList[1408],
	makecake_tip11 = dataList[1409],
	makecake_tip12 = dataList[1410],
	makecake_tip13 = dataList[1411],
	makecake_tip14 = dataList[1412],
	makecake_tip15 = dataList[1413],
	makecake_tip16 = dataList[1414],
	makecake_tip17 = dataList[1415],
	text_hjsl_desc = dataList[1416],
	CrazyPartnerRankView__1 = dataList[1417],
	CrazyPartnerRankView__2 = dataList[1418],
	CrazyPartnerRankView__3 = dataList[1419],
	CrazyPartnerRankView__4 = dataList[1420],
	text_whlz = dataList[1421],
	FirePowerContestResultView__1 = dataList[1422],
	FirePowerContestResultView__2 = dataList[1423],
	FirePowerContestResultView__3 = dataList[1424],
	FirePowerContestResultView__4 = dataList[1425],
	FirePowerContestResultView__5 = dataList[1426],
	FirePowerContestRecordView__1 = dataList[1427],
	FirePowerContestRecordView__2 = dataList[1428],
	FirePowerContestMyGamePanel__1 = dataList[1429],
	FirePowerContestMyGamePanel__2 = dataList[1430],
	FirePowerContestGamePanel__1 = dataList[1431],
	FirePowerContestGamePanel__2 = dataList[1432],
	FirePowerContestGamePanel__3 = dataList[1433],
	FirePowerContestHandler__1 = dataList[1434],
	FirePowerContestHandler__2 = dataList[1435],
	FirePowerContestGameView__1 = dataList[1436],
	FirePowerContestGameView__2 = dataList[1437],
	FirePowerContestMainView__1 = dataList[1438],
	FirePowerContestMainView__2 = dataList[1439],
	FirePowerContestMainView__3 = dataList[1440],
	FirePowerContestMainView__4 = dataList[1441],
	FirePowerContestMainView__5 = dataList[1442],
	FirePowerContestMatchView__5 = dataList[1443],
	FirePowerContestPrepareView__1 = dataList[1444],
	PetRankView__1 = dataList[1445],
	PetTop5RankView__1 = dataList[1446],
	PetTop5RankView__2 = dataList[1447],
	PetTop5RankView__3 = dataList[1448],
	PetTop5RankView__4 = dataList[1449],
	PetTop5RankView__5 = dataList[1450],
	HandBookAttrTips_1 = dataList[1451],
	HandBookAttrTips_2 = dataList[1452],
	SummerLotteryBuyView__1 = dataList[1453],
	SummerLotteryBuyView__2 = dataList[1454],
	SummerLotteryMainView__1 = dataList[1455],
	SummerLotteryBuyView__3 = dataList[1456],
	FestiveFlowerMainView__1 = dataList[1457],
	FestiveFlowerMainView__2 = dataList[1458],
	FestiveFlowerMainView__3 = dataList[1459],
	FestiveFlowerRankView__1 = dataList[1460],
	FestiveFlowerGainView__1 = dataList[1461],
	FestiveFlowerGainView__2 = dataList[1462],
	BuddyOnlineTip = dataList[1463],
	BuddyFetterExplain = dataList[1464],
	saintknighttianteambufftip = dataList[1465],
	saintknighttianareabufftip = dataList[1466],
	saintknighttianmainviewTips = dataList[1467],
	saintknighttianmainviewTips1 = dataList[1468],
	saintknighttianmainviewTips2 = dataList[1469],
	text_boonsign_desc_1 = dataList[1470],
	saintknighttiangameTips = dataList[1471],
	SaintKnightTask_Blessing = dataList[1472],
	WeeklyBigBoxView__1 = dataList[1473],
	WeeklyBigBoxView__2 = dataList[1474],
	WeeklyBigBoxView__3 = dataList[1475],
	WeeklyBigBoxView__4 = dataList[1476],
	WeeklyBigBoxGameView__1 = dataList[1477],
	WeeklyBigBoxGameView__2 = dataList[1478],
	WeeklyBigBoxGameView__3 = dataList[1479],
	WeeklyBigBoxGameView__4 = dataList[1480],
	task_title_desc = dataList[1481],
	lucky_draw_preview_tip = dataList[1482],
	text_lottery_desc_48 = dataList[1483],
	text_dragon_select_buff = dataList[1484],
	bountypk__1 = dataList[1485],
	bountypk__2 = dataList[1486],
	bountypk__3 = dataList[1487],
	bountypk__4 = dataList[1488],
	bountypk__5 = dataList[1489],
	bountypk__6 = dataList[1490],
	bountypk__7 = dataList[1491],
	bountypk__8 = dataList[1492],
	bountypk__9 = dataList[1493],
	bountypk__10 = dataList[1494],
	bountypk__11 = dataList[1495],
	bountypk__12 = dataList[1496],
	bountypk__13 = dataList[1497],
	bountypk__14 = dataList[1498],
	bountypk__15 = dataList[1499],
	bountypk__16 = dataList[1500],
	bountypk__17 = dataList[1501],
	bountypk__18 = dataList[1502],
	bountypk__19 = dataList[1503],
	bountypk__20 = dataList[1504],
	bountypk__21 = dataList[1505],
	bountypk__22 = dataList[1506],
	text_answer_desc_1 = dataList[1507],
	text_answer_desc_2 = dataList[1508],
	text_answer_desc_3 = dataList[1509],
	text_answer_desc_4 = dataList[1510],
	text_grateful_desc_1 = dataList[1511],
	text_grateful_desc_2 = dataList[1512],
	text_grateful_desc_3 = dataList[1513],
	summer_prize_1 = dataList[1514],
	outtime = dataList[1515],
	activitytime = dataList[1516],
	text_doubleeleven_desc_1 = dataList[1517],
	text_doubleeleven_desc_2 = dataList[1518],
	text_doubleeleven_desc_3 = dataList[1519],
	text_doubleeleven_desc_4 = dataList[1520],
	text_doubleeleven_desc_5 = dataList[1521],
	text_doubleeleven_desc_6 = dataList[1522],
	text_doubleeleven_desc_7 = dataList[1523],
	text_doubleeleven_desc_8 = dataList[1524],
	text_doubleeleven_desc_9 = dataList[1525],
	text_doubleeleven_desc_10 = dataList[1526],
	text_doubleeleven_desc_11 = dataList[1527],
	text_doubleeleven_desc_12 = dataList[1528],
	text_doubleeleven_desc_13 = dataList[1529],
	text_doubleeleven_desc_14 = dataList[1530],
	text_doubleeleven_desc_15 = dataList[1531],
	tip_psychic_hire_pet = dataList[1532],
	TabPTEliMyScheduleView_1 = dataList[1533],
	tabptelivoteplatemainview_1 = dataList[1534],
	text_family_desc_1 = dataList[1535],
	text_family_desc_2 = dataList[1536],
	text_family_desc_3 = dataList[1537],
	text_family_desc_4 = dataList[1538],
	text_family_desc_5 = dataList[1539],
	text_family_desc_6 = dataList[1540],
	text_family_desc_7 = dataList[1541],
	text_family_desc_8 = dataList[1542],
	text_family_desc_9 = dataList[1543],
	text_family_desc_10 = dataList[1544],
	text_family_desc_11 = dataList[1545],
	text_family_desc_12 = dataList[1546],
	text_family_desc_13 = dataList[1547],
	text_family_desc_14 = dataList[1548],
	text_family_desc_15 = dataList[1549],
	text_family_desc_16 = dataList[1550],
	text_family_desc_17 = dataList[1551],
	text_family_desc_18 = dataList[1552],
	text_family_desc_19 = dataList[1553],
	text_family_desc_20 = dataList[1554],
	text_family_desc_21 = dataList[1555],
	text_family_desc_22 = dataList[1556],
	text_family_desc_23 = dataList[1557],
	text_family_desc_24 = dataList[1558],
	text_family_desc_25 = dataList[1559],
	text_family_desc_26 = dataList[1560],
	text_family_desc_27 = dataList[1561],
	text_family_desc_28 = dataList[1562],
	text_family_desc_29 = dataList[1563],
	text_family_desc_30 = dataList[1564],
	text_family_desc_31 = dataList[1565],
	text_family_desc_32 = dataList[1566],
	text_family_desc_33 = dataList[1567],
	text_family_desc_34 = dataList[1568],
	text_family_desc_35 = dataList[1569],
	text_family_desc_36 = dataList[1570],
	text_family_desc_37 = dataList[1571],
	text_family_desc_38 = dataList[1572],
	text_family_desc_39 = dataList[1573],
	text_family_desc_40 = dataList[1574],
	text_family_desc_41 = dataList[1575],
	text_family_desc_42 = dataList[1576],
	text_family_desc_43 = dataList[1577],
	text_family_desc_44 = dataList[1578],
	text_family_desc_45 = dataList[1579],
	text_family_desc_46 = dataList[1580],
	text_family_desc_47 = dataList[1581],
	text_family_desc_48 = dataList[1582],
	text_family_desc_49 = dataList[1583],
	text_family_desc_50 = dataList[1584],
	godxiuer_1 = dataList[1585],
	godxiuer_2 = dataList[1586],
	godxiuer_3 = dataList[1587],
	godxiuer_4 = dataList[1588],
	godxiuer_5 = dataList[1589],
	godxiuer_6 = dataList[1590],
	godxiuer_7 = dataList[1591],
	godxiuer_8 = dataList[1592],
	godxiuer_9 = dataList[1593],
	godxiuer_10 = dataList[1594],
	godxiuer_11 = dataList[1595],
	collecttangyuan_1 = dataList[1596],
	dodragon_1 = dataList[1597],
	text_pet_lottery_desc_1 = dataList[1598],
	divineEvolvePlus_notputin = dataList[1599],
	divineEvolvePlus_specify = dataList[1600],
	divineEvolvePlus_sameLine = dataList[1601],
	divineEvolvePlus_notputin_ciyuan = dataList[1602],
	divineEvolvePlus_specify_ciyuan = dataList[1603],
	divineEvolvePlus_sameLine_ciyuan = dataList[1604],
	holydarkmm_reset_tip = dataList[1605],
	weeklyGroupTeamRankTip = dataList[1606],
	weeklyGroupPersonRankTip = dataList[1607],
	NeverLandRankTip = dataList[1608],
	divineciyuan_buff_tip = dataList[1609],
	divineciyuan_extreme_reset_tip = dataList[1610],
	zhuxiao_popup_1 = dataList[1611],
	zhuxiao_popup_2 = dataList[1612],
	zhuxiao_popup_3 = dataList[1613],
	zhuxiao_popup_4 = dataList[1614],
	zhuxiao_popup_5 = dataList[1615],
	zhuxiao_popup_6 = dataList[1616],
	elementspark_1 = dataList[1617],
	elementspark_2 = dataList[1618],
	elementspark_3 = dataList[1619],
	elementspark_4 = dataList[1620],
	elementspark_5 = dataList[1621],
	elementspark_6 = dataList[1622],
	elementspark_7 = dataList[1623],
	elementspark_8 = dataList[1624],
	elementspark_9 = dataList[1625],
	nogamenumber = dataList[1626],
	nobuynumber = dataList[1627],
	unlock = dataList[1628],
	lsqordeal_desc1 = dataList[1629],
	lsqordeal_desc2 = dataList[1630],
	lsqordeal_desc3 = dataList[1631],
	lsqordeal_desc4 = dataList[1632],
	lsqordeal_desc5 = dataList[1633],
	lsqordeal_desc6 = dataList[1634],
	lsqordeal_desc7 = dataList[1635],
	lsqordeal_desc8 = dataList[1636],
	lsqordeal_desc9 = dataList[1637],
	lsqordeal_desc10 = dataList[1638],
	lsqordeal_desc11 = dataList[1639],
	lsqordeal_desc12 = dataList[1640],
	lsqordeal_desc13 = dataList[1641],
	lsqordeal_desc14 = dataList[1642],
	lsqordeal_desc15 = dataList[1643],
	lsqordeal_desc16 = dataList[1644],
	lsqordeal_desc17 = dataList[1645],
	lsqordeal_desc18 = dataList[1646],
	lsqordeal_desc19 = dataList[1647],
	lsqordeal_desc20 = dataList[1648],
	lsqordeal_desc21 = dataList[1649],
	wtbm_not_enough = dataList[1650],
	txt_script_kill_rank_rule = dataList[1651],
	txt_equip_limit_desc = dataList[1652],
	teshamuchallenge_reset_tip = dataList[1653],
	holydragonfield_name_1 = dataList[1654],
	holydragonfield_name_2 = dataList[1655],
	holydragonfield_name_3 = dataList[1656]
}

t_lang_tip.dataList = dataList

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

return t_lang_tip
