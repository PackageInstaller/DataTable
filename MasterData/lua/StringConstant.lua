local this = {};


this.data_error = "数据出错";

-------------------------------通用
this.info = "信息";
this.hint = "提示";
this.ok = "确定";
this.ok1 = "确  定";
this.cancel = "取消";
this.jx = "点击继续"
this.jx2="<点击空白继续>"
this.tips1 = "敬请期待！"
this.open = "开 启";
this.open2 = "开启";
this.openMore = "开启%s次";
this.use="使 用";
this.combine="合 成";
this.useTips="使用了%sx%s";
this.common_tab1 = {"年", "月", "日", "时", "分", "秒"};
this.day = "天"
this.seconds="秒"
this.numTips="%s/%s";
this.numErrorTips="<color=\"#FF0000\">%s</color>/%s";
this.close = "关闭"
this.back="返回"
this.exp="EXP";
this.gan="GAN";
this.lv="LV.";
this.registerTips="注册成功！";
this.buy = "购买"
this.sell = "出售"
this.np="NP";
this.sp="SP";
this.help = "帮助说明"
this.weeks = {"一","二","三","四","五","六","日"}

-------------------------------网络
--this.net_exc = "网络异常，是否重新连接？";
this.net_connect_fail = "网络连接失败！";
------------------------------后勤仓
this.bag_title = "后勤仓";
this.bag_tab_1 = "芯片";
this.bag_tab_2 = "材料";
this.bag_autoSelect="自动选择";
this.bag_cancelSelect="取消选择";
this.bag_numTips="已选择：%s件";
this.bag_ok2="确认装备"
this.bag_nonesEquips="没有符合要求的装备";

------------------------------物品
this.goods_get_way_title = "获取途径";
this.goods_info_title = "属性";
this.goods_info_count = "拥有数量：";
this.jump_tips = "还没有解锁该跳转功能哦";
this.jump_tips2="该副本今日不开放";
this.jump_tips3="暂未达到开启副本条件";
this.shell_tips = "没有选择需要出售的装备";
this.choosie_title = "选择数量：";
this.shell_tips5 = "锁定的装备不能出售！";
this.shell_tips6="一次最多可以出售%s个！";
this.combineSuccess="作成可能";
this.combineError="素材不足";
this.combineStuffTips="所持：";
this.goods_combine_add="+";
this.goods_combine_remove="-";
this.goods_combine_max="MAX";
this.goods_combine_cost="消耗:";
this.goods_combine_combine="合成";
this.goods_combine_title="素材合成";
this.goods_combine_success="合成成功";
this.goods_UnLock="[未解锁]";
this.goods_sell_Tips4="是否出售选择的装备？";
this.rareTips={"RARE 1","RARE 2","RARE 3","RARE 4","RARE 5","RARE 6"}
this.sellTips="批量出售";
this.sellTips2="BLUK SALE";
this.sellTips3="确认出售";
this.comfrim="CONFRIM";
this.comfirm2="选择完毕"
this.material_equip_sort={"排序","品质","部位"};
this.material_equip_sort2={"排序","品质","部位","佩戴"};
this.goods_sort= {"排序","类型"}
this.material_equip_tips1="突破素材"
this.material_equip_tips2="普通素材"
this.bag_quality="品质"
this.equip_screenTips={{id=1,sName="佩戴中"},{id=2,sName="未佩戴"}};

------------------------------技能
this.skill_cost_1 = "消耗：";
this.skill_cost_2 = "无";

------------------------------战斗
this.overload_btn_show = "OVERLOAD";
this.overload_btn_cancel = "CANCEL";
this.overload_warning = "确定要发动OVERLOAD吗？";
this.overload_tips = "可操作次数：<color=#eeee11>{0}</color>/3";
this.fight_combo_tips = "没有符合同调条件的目标！";
this.auto_fight_on_text = "自律战斗";
this.auto_fight_off_text = "停止自律";


this.fight_np_no_enough = "NP不足";


this.fight_pvp_time_tips_1 = "思考时间：";
this.fight_pvp_time_tips_2 = "敌方行动：";

this.fight_pvp_disconnect = "战斗已断开";


this.fight_quit = "是否撤退？";
this.fight_quit2 = "演习无法自行退出战斗"
this.fight_quit3 = "退出战斗无法获得任何奖励，但不扣除战斗次数，是否退出？"
this.fight_quit4 = "撤退后，当前队伍会撤退战斗，切换至其他队伍？";
this.fight_quit5 = "当前只有一个队伍，撤退后，将退出当前副本？";


this.fight_lost_go1 = "等级提升";
this.fight_lost_go2 = "强化装备";
this.fight_lost_go3 = "提升技能";
this.fight_lost_go4 = "强化突破";

this.fight_end_continue = "< 点击任意位置继续 >";

this.fight_title_relive = "复活对象";
this.fight_title_transform = "状态切换";

this.fight_help = "协力触发";

this.fight_call_skill = "强制技能";
this.fight_beat_again = "追击触发";
this.fight_beat_back = "反击触发";

this.fight_restore = "正在战斗中，是否重新进入战斗？";

this.fight_skill_view_enemy_action = "敌方行动中...";
--this.fight_skill_view_player_skill = "指挥官战术";
this.fight_skill_name1 = "机神传送";
this.fight_skill_name2 = "核心同调";
this.fight_skill_name3 = "形态转换";

this.fight_player_skill_title = "战术规则，随便写几个凑数，内容也不能太多，不要超过两行";
this.fight_player_skill_cd = "回合后恢复使用";

this.fight_pvp_tips_1 = "对战中无法使用";

this.fight_roleInfo_sp="SP";
this.fight_roleInfo_np="NP";
this.fight_roleInfo_rang="范围";
this.fight_roleInfo_career1="物理护甲";
this.fight_roleInfo_career2="能量护甲";
this.fight_roleInfo_career3="特殊护甲";
this.fight_roleInfo_roundStr="剩余回合：";

this.fight_result1 = "战斗胜利";

this.fight_trigger_events = {"协战","追击","反击","掩护"};

this.fight_ai_skill_setting = {"普攻","技能","必杀","自动"};

this.fight_info_pvp = "实时对战";
this.fight_info_pvpmirror = "全息模拟";
this.fight_info_main_normal = "普通";
this.fight_info_main_elite = "困难";
------------------------------战棋
this.battle_move_limit = "超出移动范围";
this.battle_move_limit_1 = "交战中不可移动";
this.battle_quit = "撤退将丢失当前进度，是否撤退？";
this.battle_layer_format="第%s层";
this.battle_step_format="行动次数:%s/%s";
this.battle_endTime_format="剩余时间:%s";
this.battle_encounter="野生的阿尔卑斯跳了出来";
this.battle_skill_state={"常规","特技","终极","自动"}
------------------------------状态
this.state_desc_1 = "进行中";
this.state_desc_2 = "完成";
this.state_desc_3 = "升级中";
------------------------------章节
this.section_type_1 = "主线副本";
this.section_type_2 = "每日副本";
this.section_fighting = "交战中";
this.section_tips="副本可用次数已达上限";
this.section_title="CHAPTER ";
this.section_multi1="%s玩家经验:%s/%s";
this.section_multi2="%s卡牌经验:%s/%s";
this.section_multi3="%s晶片:%s/%s";
this.section_multi4="%s掉落:%s/%s";
this.section_multiStr={"1倍","2倍","3倍","4倍","5倍","6倍","7倍","8倍","9倍","10倍"}
this.section_addStr="额外"

--------------------------结算
this.fightWin_fightTips="个体战力";
this.fightWin_lvUp="等级提升";
this.fightWin_expGet="经验获得";

this.fightResult1 = "统计伤害"
this.fightResult2 = "等级提升"
this.fightResult3 = "技能提升"
this.fightResult4 = "角色突破"
this.fightResult5 = "装备提升"
this.fightResult6 = "无奖励"
this.fightResult7 = "点击任意位置继续"
this.fightResult8 = "战斗胜利"
this.fightResult9 = "战斗失败"
this.fightResult10 = "<color=#65ffb1>击杀奖励</color>"
this.fightResult11 = "战斗结束"
this.fightResult12="战斗"
this.fightResult13="胜利";
this.fightResult14="失败";
this.fightResult15="结束";
this.fightResult16="<color=#ff38e1>额外奖励</color>";

------------------------------关卡
this.dungeon_title_1 = "胜利条件";
this.dungeon_title_2 = "特别条件";
this.dungeon_title_3 = "败北条件";
this.dungeon_title_cost = "行动值消耗：";
this.dungeon_starTips_1 = "通关条件：%s";
this.dungeon_starTips_2 = "击退敌方部队(%s/%s)";
this.dungeon_starTips_3 = "击退敌方精英部队(%s/%s)";
this.dungeon_starTips_4 = "击退怪物(%s/%s)";
this.dungeon_starTips_5 = "单局移动次数不超过%s";
this.dungeon_starTips_6 = "单局收集宝箱数量(%s/%s)";
this.dungeon_starTips_7 = "单局击退敌方部队数量(%s/%s)";
this.dungeon_starTips_8="队友阵亡数不大于%s个";
this.dungeon_starTips_9="使用%s支队伍通关";
this.dungeon_starTips_0="无";
this.dungeon_safe_1="区域系数：<color=\"#00f000\">安全</color>";
this.dungeon_safe_2="区域系数：<color=\"#F01100\">危险</color>"
this.dungeon_details1="关卡掉落"
this.dungeon_details2="敌方情报"
this.dungeon_details3="地图信息"
this.dungeon_reward_tips1="已领取"
this.dungeon_reward_tips2="首次通关"
this.dungeon_reward_tips3="首次三星"

--关卡胜利条件
this.dungeon_winCon_1="消灭敌方高能单位";
this.dungeon_winCon_2="我方队伍到达指定位置";
this.dungeon_winCon_3="行动次数结束时，我方队伍存活(%s)";
this.dungeon_winCon_4="消灭指定怪物数量达到%s只";
this.dungeon_winCon_5="行动次数达到%s步";
this.dungeon_winCon_0="战斗胜利";
--关卡失败条件
this.dungeon_fail_1="我方队伍全员阵亡";
this.dungeon_fail_2="敌军到达指定位置";
this.dungeon_fail_3="%s回合内未胜利";
this.dungeon_fail_4="%s任一阵亡";
this.dungeon_fail_5="%s全部阵亡";


this.dungeon_daily_left_time = "今日剩余次数：";
this.dungeon_unlock_tips1 = "等级达到Lv.%s后开启";
this.dungeon_unlock_tips2 = "通过%s后开启";
this.dungeon_unlock_tips3 = "所需等级:%s";
this.dungeon_box_tips="星级奖励";
this.dungone_use_item="使用道具";
this.dungone_use_title="特殊道具";
this.dungone_use_ok="使用";
this.dungone_use_cancel="不使用";
this.dungone_use_none="道具数量不足！";
this.dungone_no_choosie="请选择使用的道具";
this.dungeon_pass_title1="通  关";
this.dungeon_pass_title2="开  启";
this.dungeon_pass_content="[%s]%s难度";
this.dungeon_pass_hard1="普通";
this.dungeon_pass_hard2="困难";
this.dungeon_pass_hard3="（困难）"

-------------------------------剧情
this.plot_tips_1 = "是否跳过该段剧情？";
this.plot_forward="倍速";
this.auto="自动";
this.auto2="停止"
this.jumpBtn="跳过";

-------------------------------装备属性
this.attribute1 = "装甲";
this.title_addition = "属性加成";
this.title_skill = "触发技能";
this.text_skillPoint = "模组容量";  --技能点
this.equip_title_1 = "技能详细";
this.equip_title_2 = "芯片模组";
this.equip_title_3 = "芯片";
this.equip_title_4 = "合计";
this.equip_tips = "未激活技能";
this.equip_addGrid = "是否花费<color=\"#ffc146\">%s</color>开启<color=\"#ffc146\">%s个背包容量</color>？";
this.equip_addGrid_tips = "当前已是最大容量。";
this.sortTips = {"降序", "升序"};
this.equipSortOption = {"品质", "等级", "部位", "保护", "入手顺序", "其它"};
this.stuffOption = {"品质"};
this.equip_stuff = "素材";
this.equip_title_5 = "*请放入用于强化的素材";
this.equip_title_6 = "装备已经满级";
this.equip_replace = "替换";
this.equipSellTips = "出售该装备可以获得%s货币，是否确认出售？";
this.equipLockTips = "装备已被锁定";
this.equippedTips = "操作无效，该装备正在被其他角色使用中";
this.cardFightTips = "卡牌正在出战中，无法执行该操作";
this.cardExpeditionTips="远征中角色无法进行编队";
this.selectMaxTips = "已达到最大选择数量";
this.equip_screen = "筛选";
this.equip_skill_lv={"I","II","III","IV","V","VI"};
this.equip_max_tips="已达到最大等级，无法继续强化";
this.equip_none_stuff="请选择升级材料";
this.equip_point_tips="装备合计:";
this.equip_skill_tips="特性点数";
this.equip_strength_success="强化成功！";
this.equip_autoTips="当前没有可搭载的芯片"; --12000
this.equip_lockTips1="已锁定";
this.equip_lockTips2="已解锁";


------------------------------队伍编成
this.team_desc_left = "TEAM\nFORMATION";
this.team_desc_right = "HELPING\nTO COMPILE";
this.team_drop_desc = {
	"I       第一小队",
	"II      第二小队",
	"III     第三小队",
	"IV    第四小队",
	"V     第五小队",
	"VI    第六小队"
};
this.team_default_name="第%s战队";
this.team_text_tactics = "指挥官\n战术";
this.team_text_fightTips = "综合实力";
this.team_text_npTips = "起始NP值";
this.team_text_costTips = "COST值";
this.text_skillDesc = "技能";
this.text_equipDesc = "芯片";
this.text_Details = "详情";
this.text_btn1 = "队伍详情";
this.text_btn2 = "队伍部署";
this.team_title1 = "战术列表";
this.team_tips1 = "总体性能";
this.team_tips2 = "LEADER";
this.team_title2 = "队伍预设";
this.team_title3 = "预设队伍";
this.team_btn_stat1 = "未开启";
this.team_btn_stat2 = "更  换";
this.team_btn_stat3 = "使用中";
this.team_title4 = "队伍能力";
this.team_title5 = "布局";
this.team_title6 = "队员";
this.career1 = "物理装甲";
this.career2 = "光束装甲";
this.team_preset_warning = "当前队伍中的队员与其他队伍存在重复使用的情况，是否将该队员退出其他队伍？"
this.team_edit_warning="存在其他队伍中的卡牌，是否确认修改？";
this.fitTips1 = "核心主体";
this.fitTips2 = "同调型核心";
this.flyTips = "无法放置，Cost值超过上限!";
this.flyTips2 = "无法放置，上阵人数已满!";
this.flyTips3 = "无法放置，卡牌占位超过上限!";
this.supportOption = {"全能型", "机装型", "同调型", "特殊型"};
this.typeTips = "类型";
this.supportTips = "助战选择";
this.goal = "GOAL";
this.beginTips = "进入战场";
this.text_support = "友军";
this.text_team = "队伍";
this.beginTips2 = "ATTACK";
this.saveAssist="确认";
this.saveAssistTips="CONFIRM";
this.text_dofight = "出战";
this.supportTips1 = "角色实力：";
this.supportTips2 = "总助战：";
this.taskTips1 = "达成目标";
this.autoTips = "自律战斗";
this.hotTips = "消耗行动值";
this.teamFightTips = "队伍正在出战中，无法执行该操作";
this.teamNullTips = "当前没有上阵任何队员，无法进入战斗！";
this.teamNullTips2 = "队伍中不能只有助战队员，请上阵我方队员！";
this.team_change = "队员更换";
this.coolTips = "当前队伍中存在行动值不足的队员，是否进入冷却室进行冷却？";
this.presetUnLock = "是否花费%s进行解锁？";
this.presetTips = "请先解锁上一个预设队伍";
this.team_tips3="队伍";
this.team_assistTips="编辑作为助战的角色，每个类型可以配置一个";
this.team_none="当前不可用";
this.team_noneTips="未选择队伍";
this.team_dungeon_noneTeam="请选择出战队伍";
this.team_title7="队伍选择";
this.team_noneCard="请设置出战队员";
this.team_noneCardA="第一小队中没有配置队员，无法出击";
this.team_noneLeader="队伍中没有配置队长，无法出击";
this.team_teamNum_tips="可出击队伍数:";
this.team_force_error="缺少必要队员";
this.team_clear="清 空";
this.team_useSkill="使用战术";
this.team_black_tips="【点击黑框外即可退出弹窗】";
this.team_fromat_name="第%s小队";
this.team_leader="队长";
this.team_force="-强制出战-";
this.team_assist="-支援角色-";
this.team_npc="-NPC-";
this.team_choosieTips="最少保留一支出战队伍";
this.team_noneLeader2="请配置队长";
this.team_noneLeader3="队长不能下阵！";
this.team_noneLeader4="不能选择%s的队长";
this.team_noneLeader5="队伍%s中必须要有队长";
this.team_noneLeader6="不能选择第一队的队长";
this.teamNullTips3 = "%s中没有上阵任何队员，无法进入战斗！";
this.teamNullTips4 = "%s中不能只上阵协战队员";
this.supportHasTeam="助战队员已在其他队伍上阵！";
this.cardHasTeam="同一阵容不能存在多张相同的卡牌！";
this.team_halo_none="无阵型属性加成"
this.team_halo_none2="暂无显示";
this.team_option="队伍"
this.team_lvTips="<size=25>LV.</size>%s";

------------------------------卡牌系统
--主界面
this.buff_timeTips="剩余";
this.buff_none_tips="当前没有任何BUFF";
this.buff_time_forever="永久";
this.menu_text1 = "<点击任意键继续>"
this.menu_text2 = "作战中"
this.menu_text3 = "好友"
this.menu_text4 = "图鉴"
this.menu_text5 = "任务"
this.menu_text6 = "公会"
this.menu_text7 = "基建"
this.menu_text8 = "仓库"
this.menu_text9 = "Boss活动"

--补给站
this.shop_text1 = "购买数量";
this.shop_text2 = "购买";
this.shop_text3 = "购买物品";
this.shop_text4 = "购买礼品";
this.shop_text5 = "售罄";
this.shop_text7 = "%s折";
this.shop_text6 = "剩余数量：%s";
this.shop_text8="原价:%s";
this.shop_text9 = "剩余数量：";
-- this.moneyType = "能源";
-- this.moneyType2 = "NOVA结晶";
this.moneyType3 = "￥";
this.shop_text11 = "是否使用%s来购买%s？";
this.shop_text13 = "是否使用%s来兑换%s？";
this.shop_text14="刷新需要%s，是否继续？";
this.shop_text15="%s数量不足";
this.shop_text16="已购买";
this.shop_refreshTime="刷新剩余时间";
this.shop_tips = "购买成功";
this.shop_noneCard="当前还未获得该卡牌";
this.shop_text12 = "即将前往充值，您将使用￥%s来购买%s,是否继续？";
-- this.shop_buff12001="指挥官经验和副本战斗经验各+25%，持续%s小时"
-- this.shop_buff12002="战斗金币成50%，持续%s小时"
-- this.shop_buff12003="增加关卡获得金币的数量"
-- this.shop_buff12004="增加关卡获得金币的百分比"
this.taskInfo = {
	"战斗胜利",
	"我方没有角色阵亡",
	"战斗回合数小于20",
};
this.equipMax = "装备空间不足，请清理装备后再次尝试";
this.cardMax = "卡牌空间不足，请清理卡牌后再次尝试";
this.shopBtn1="兑换";
this.shopBtn2="补给";
this.cardState1="战斗中";
this.cardState2="冷却中";
this.cardState3="派遣中";
this.cardState4="训练中";
this.cardState5="模拟中";
this.cardState6="模拟中";
this.cardState7="助战中";
this.skinTime="<color=\"#000000\">剩余</color>   <color=\"#FF0000\">%s</color>";
this.skinDiscount="- %s";
this.lvStr="LV.%s";
this.skinShowTitle="选择需要换装的角色";
this.depositOnce="首次获得";
this.depositDay="每日获得";
this.shop_text13 = "剩余";
this.shop_tips="是否花费%s%s购买%s？";

------------------------------------------登录
this.loginTips = "不超过7个字";
this.loginTitle = "创建指挥官名称";
this.loginTips2 = "输入的名称长度超过上限（不得超过7个中文字符）";
this.accTips1 = "请输入账号";
this.accTips2 = "账号长度不能少于3位";
this.accTips3 = "您输入的账号不得含有屏蔽词";
this.pwdTips1 = "请输入密码";
this.pwdTips2 = "密码长度不能少于6位";
this.pwdTips3 = "您输入的密码不得含有屏蔽词";
this.regInpTips = "%s-%s个字符组成，区分大小写";
this.loginServerTips={"最近登陆","推荐服务器"};
this.serverStr={"服务器"};
this.loginStateTips1="<color=\"#8ae13c\">线路良好</color>";
this.loginStateTips2="<color=\"#ecc82e\">线路爆满</color>";
this.loginStateTips3="<color=\"#df1511\">线路繁忙</color>";
this.loginStateTips4="<color=\"#898989\">停服维护</color>";
this.loginTips3="请输入指挥官名称";
this.loginTips4="请设置指挥官生日";
this.loginTips5="请选择指挥官造型";
this.logining = "LOADING";
------------------------------------跳转
this.Jump_Bag_Item="物品背包已满，是否前往清理？";
this.Jump_Bag_Equip="装备背包已满，是否前往清理？";
this.Jump_Role_List="卡牌数量已达上限，是否前往清理？";


------------------------------------------headPanel
this.Head_text1 = "首页"
this.Head_text2 = "基建中心"
this.Head_text3 = "编成"
this.Head_text4 = "出击"

----------------------------------------
this.role_1 = "自动选择"
this.role_2 = "确认分解"
this.role_3 = "批量分解"
this.role_4 = "仓库容量"
this.role_5 = "取消选择"
this.role_22 = "角色战斗中"
this.role_29 = "升级所需经验"
this.role_42 = "取消升级将不返还材料，是否确定？"
this.role_43 = "是否花费%s %s解锁格子"
this.role_44 = "需要改名字？请在下方输入名字"
this.role_45 = "编队"
this.role_46 = "选择升级素材"
this.role_47 = "技能升级"
this.role_48 = "返回"
this.role_49 = "清空"
this.role_53 = "角色战斗中、不可更改"
this.role_54 = {"全能", "特化", "同调", "特殊"}
this.role_56 = "排序"
this.role_57 = "筛选"
--this.role_58 = {"排序","小队","类型","稀有度"}
this.role_59 = {"稀有度", "等级", "好感度", "入手顺序", "性能", "保护"}
this.role_60 = "已达到最大容量"
this.role_66 = "核心过热警告"
this.role_67 = "行动值"
this.role_68 = "限界突破"
this.role_69 = "战力"
this.role_70 = "角色已达到满级"
this.role_71 = {"等级提升","属性提升","战力提升"}
this.role_72 = "突破"
this.role_73 = {"等级上限提升","行动值上限提升","属性提升","战力提升","获得新天赋x1","天赋位置解锁"}
this.role_74 = "消耗"
this.role_76 = "请在下面<color=#EAFF00>选择</color>你要看的技能"
this.role_77 = "升级列表"
this.role_78 = "技能升级"
this.role_79 = "···技能正在升级中···"
this.role_80 = "取消升级"
this.role_81 = "完成"
this.role_82 = "升级技能经验"
this.role_83 = "升级"
this.role_84 = "当前角色其他技能正在升级,无法提升目前的技能"
this.role_86 = "消耗素材"
this.role_87 = "点数"
this.role_88 = "成功率100%"
this.role_89 = "100%成功率需要消耗多个素材"
this.role_90 = "若不使用“成功率100%”，则升级时有概率失败，失败时，资源不作返还。"
this.role_91 = "天赋升级"
this.role_92 = "同调对象"
this.role_93 = "查看详情"
this.role_94 = "返回上级"
this.role_95 = "解锁条件"
this.role_96 = "取消"
this.role_97 = "是否花费%s %s解锁格子"
this.role_98 = "已获得天赋"
this.role_99 = "取消搭载"
this.role_100 = "选择搭载"
this.role_101 = "取消操作"
this.role_102 = "激活属性"
this.role_103 = "需要消耗素材"
this.role_104 = "锁定中"
this.role_105 = "冷却中"
this.role_106 = "技能提升中"
this.role_107 = "编队中"
this.role_108 = "确认选择"
this.role_109 = "升级耗时"
this.role_110 = "继续升级"
this.role_111 = "升级成功"
this.role_112 = "攻击范围"
this.role_113 = "角色已达到满级"
this.role_114 = {"物理","能量","特殊"}
this.role_115 = "突破%s阶解锁"
this.role_116 = "阶段"
this.role_117 = "天赋已满级"
this.role_118 = "无法进行搭载"
this.role_119 = "已选            件"
this.role_120 = "天赋未解锁"
this.role_121 = "好友角色不可更改"
this.role_122 = "是否花费%s%s买%s格子？"
this.role_123 = "个"
this.role_124 = "格子"
this.role_125 = "点选卡牌上锁，取消请多按一次"
this.role_126 = "可把多余的卡牌选择分解"
this.role_127 = "第%s编队"
this.role_128 = "行动值"
this.role_129 = "无标签"
this.role_130 = "无被动技能"
this.role_131 = "选择标签【点选弹窗外取消选择】"
this.role_132 = "特殊能力"
this.role_133 = {"核心同调","机神传送","形态转换"}
this.role_134 = "经验库"
this.role_135 = "提升1级"
this.role_136 = "已满级"
this.role_137 = "升级时间"
this.role_138 = "跃升%s后开启"
this.role_139 = "搭载"
this.role_140 = "*素材不足无法升级"
this.role_141 = "点击继续"
this.role_142 = "被动技能"
this.role_143 = "装备"
this.role_144 = {"I","II","III","IV","V"}
this.role_145 = "属性说明"
this.role_146 = "初始同步率"
this.role_147 = "第一编队队长不可选"
this.role_148 = {"技能一","技能二","终极技能","被动技能","特殊技能"}
this.role_149 = {"核心升级","核心跃升","芯片搭载","技能强化","天赋"}
this.role_150 = "提升5级"
this.role_151 = "已搭载"
this.role_152 = "未搭载"
this.role_153= "同调对象请看上方人物"
this.role_154 = "天赋"
this.role_155 = "召唤的机神会出现在召唤位置上"
this.role_156 = "使用形态切换后，属性技能会发生变化"
this.role_157 = "装备显示请看上方圆环"
this.role_158 = "同角色编成中"
this.role_159 = "取消分解"
this.role_160 = "确认更改"
this.role_161  = "确认购买"
this.role_162  = "当前"
this.role_dirll = "是否进入角色战斗试玩？"


--角色系统
this.player_3 = "出击次数"
this.player_4 = "出击胜率"
this.player_5 = "派遣次数"
this.player_12 = "签名留言"
this.player_13 = "这家伙很懒，什么也没留下......(限制%s个字符)"
this.player_14 = "还没有技能啦指挥官"
this.player_15 = "可分配点数" 
this.player_16 = "能力提升"
this.player_17 = "已获得能力"
this.player_18 = "技能点数"
this.player_19 = "技能升级"
this.player_20 = "开启"
this.player_21 = "消耗点数"
this.player_22 = "CD冷却：%s回合"
this.player_23 = "角色图鉴"
this.player_24 = "能力升级"
this.player_25 = "支援"
this.player_26 = "展示更换"
this.player_27 = "升级"
this.player_28 = "角色"
this.player_29 = "背景"
this.player_30 = "CURRENTLY"
this.player_31 = "目前"
this.player_32 = "演习次数"
this.player_33 = "最高排名"
this.player_34 = "演习胜率"

--冷却
-- this.cool_9 = "材料不足"
-- this.cool_11 = "消耗"
-- this.cool_14 = "冷却系统"
-- this.cool_15 = "···冷却中···"
-- this.cool_16 = "核心冷却中···"
-- this.cool_17 = "冷却进度"
-- this.cool_18 = "持有："
-- this.cool_19 = "剩余时间"
-- this.cool_20 = "冷却加速"
-- this.cool_21 = "目标冷却完成"
-- this.cool_22 = "%s个%s"
-- this.cool_23 = "是否消耗%s个冷却剂加速冷却"
-- this.cool_24 = "开始冷却"
-- this.cool_25 = "消耗1个冷却剂"
-- this.cool_26 = "*素材不足无法加速"
-- this.cool_27 = "可选择冷却数量已满，点击已选择角色可取消"
-- this.cool_28 = "当前冷却容量：%s"
-- this.cool_29 = "冷却时间%s"
--基地
-- this.matrix_3 = "驻员效果"
-- this.matrix_4 = "耐久"
-- this.matrix_5 = "装甲"
-- this.matrix_6 = {"无甲","轻甲","中甲","重甲","城甲"}
-- this.matrix_7 = "电力"
-- this.matrix_8 = "面积"
-- this.matrix_9 = "效果"
-- this.matrix_10 = "消耗"
-- this.matrix_11 = "常驻队员不额外参生疲劳"         --发电厂，
-- this.matrix_12 = "常驻队员疲劳消耗 %sp/min"      --交易中心、生产中心、指挥中心
-- this.matrix_13 = "常驻队员每次合成疲劳消耗 %sp"   --合成
-- this.matrix_14 = "常驻队员在防御后，疲劳 +%sp"    --防御
-- this.matrix_15 = "改造过程中，驻员增加 %sp/min"  --改造
-- this.matirx_16 = "疲劳"
-- this.matirx_17 = "工作中"
-- this.matirx_18 = "耗时"
-- this.matirx_19 = "改造列表"
-- this.matirx_20 = "合成列表"
-- this.matirx_21 = "改造芯片"
-- this.matirx_22 = "开始改造"
-- this.matirx_23 = "正在改造"
-- this.matirx_24 = "改造完成"
-- this.matirx_25 = "追加"
-- this.matirx_26 = "点击物品全部获取"
-- this.matirx_27 = "全部上限"
-- this.matirx_28 = "剩余更新"
-- this.matirx_29 = {"普通","道具","稀有"}
-- this.matirx_30 = "时限"
-- this.matirx_31 = "交付"
-- this.matirx_32 = "报酬"
-- this.matirx_33 = "交易"
-- this.matirx_34 = "无订单"
-- this.matirx_35 = "全部"
-- this.matirx_36 = "制作难度"
-- this.matirx_37 = "所持"
-- this.matirx_38 = "合成"
-- this.matirx_39 = "剩余"
-- this.matirx_40 = "素材合成"
-- this.matirx_41 = "制作能力"
-- this.matirx_42 = "点击建筑图标查看详细情况"
-- this.matirx_43 = "建造时间"
-- this.matirx_44 = "持有"
-- this.matirx_45 = "无法继续建造"
-- this.matirx_46 = "建筑驻员"
-- this.matirx_47 = "名称"
-- this.matirx_48 = "能力"
-- this.matirx_49 = "疲劳状况"
-- this.matirx_50 = "总电力"
-- this.matirx_51 = "建筑"
-- this.matirx_52 = "人口"
-- this.matirx_53 = "来袭预警"
-- --this.matirx_54 = "驻员总览"
-- this.matirx_55 = "确定位置"
-- this.matirx_56 = "部署方式"
-- this.matirx_57 = "解锁"
-- this.matirx_58 = "调整"
-- this.matirx_59 = "建造"
-- this.matirx_60 = "确定位置"
-- this.matirx_61 = "维修"
-- this.matirx_62 = "建筑说明"
-- this.matirx_63 = "拆除"
-- this.matirx_64 = "停止运行" 
-- this.matirx_65 = "快速完成"
-- this.matirx_66 = "是否消耗%s快速完成"
-- this.matirx_67 = "距离袭击结束"
-- this.matirx_68 = "是否消耗%s进行维修？"
-- this.matirx_69 = "数量"
-- this.matirx_70 = "正常运行" 
-- this.matirx_71 = "无合成建筑" 
-- this.matirx_72 = "订单获取中..." 
--邮件
this.mail_1 = "亲爱的指挥官你暂时还没有邮件哦"
this.mail_3 = "删除已读"
this.mail_4 = "一键领取"
this.mail_6 = "已领取"
this.mail_7 = "上限"
this.mail_8 = "未读邮件"
this.mail_9 = "待领取邮件"
this.mail_11 = "剩余：%s天%s小时"
this.mail_12 = "发件人"
this.mail_13 = "[已读]"
this.mail_14 = "[未读]"

-- --任务
-- this.mission3 = "立即前往"
-- this.mission4 = "领取奖励"
-- this.mission5 = "进度"
-- this.mission6 = "当前没有任务"

-- this.mission7 = "任务界面"
-- this.mission8 = "剧情任务"
-- this.mission9 = "周日常任务"
-- this.mission10 = {"日常任务","周常任务"}
-- this.mission11 = {"每日任务","每周任务"}
-- this.mission12 = "奖励列表"

--签到
this.Activity1 = "每日签到"
this.Activity2 = "新手签到"
this.Activity3 = "SDK兑换"
this.Activity4 = "未签"
this.Activity5 = {"第","天"}
this.Activity6 = "确定签到"
this.Activity7 = "已签到"
this.Activity8 = "可签到"
this.Activity10 = "已过期"
this.Activity11 = "今天的奖励已经领取了啊"
--模拟
-- this.Exercise1 = "赛季时间"
-- this.Exercise2 = "排名"
-- this.Exercise3 = "兑换"
-- this.Exercise4 = "刷新对手"
-- this.Exercise5 = "攻击队伍"
-- this.Exercise6 = "防御队伍"
-- this.Exercise9 = "赛季积分"
-- this.Exercise12 = "模拟次数"
-- this.Exercise21 = "战力"
-- this.Exercise35 = "拒绝"
-- this.Exercise40 = "排名"
-- this.Exercise47 = "次"
-- this.Exercise48 = "模拟次数"
-- this.Exercise49 = "后恢复%s次"
-- this.Exercise50 = "防御部署"
-- this.Exercise51 = "段位"
-- this.Exercise52 = "模拟积分"
-- this.Exercise53 = "模拟战对手"
-- this.Exercise54 = "我方阵容"
-- this.Exercise55 = "队伍编辑"
-- this.Exercise56 = "已确认"
-- this.Exercise57 = "···正在匹配对手···"
-- this.Exercise58 = "开始匹配"
-- this.Exercise59 = "离线"
-- this.Exercise60 = "好友正在邀请和你对战"
-- this.Exercise61 = {"模拟排行"}
-- this.Exercise62 = "对战对手"
-- this.Exercise63 = "阵容"
-- this.Exercise64 = "我方出战阵容"
-- this.Exercise65 = "队伍编辑"
-- this.Exercise66 = "好友匹配"
-- this.Exercise67 = "随机匹配"
-- this.Exercise68 = "配对成功"
-- this.Exercise69 = "等待对方确认，双方确认后进入战斗"
-- this.Exercise70 = "对战中"
-- this.Exercise71 = "邀请对战"
-- this.Exercise72 = "下一个段位所需"
-- this.Exercise73 = "玩家积分"
-- this.Exercise74 = "寂寞的你当前没有好友"
-- this.Exercise75 = "积分"
-- this.Exercise76 = "行动失败"
-- this.Exercise77 = "我的当前排名"
-- this.Exercise78 = "邀请已发送"
-- this.Exercise79 = "进入战斗"
-- this.Exercise80 = "对方已确认，双方确认后进入战斗"
-- this.Exercise81 = "综合战力"

-- --核心构建
-- this.Create1 = "结束时间"
-- this.Create2 = "大概率出现"
-- this.Create3 = "以下角色核心组件"
-- this.Create4 = "概率同步提升"
-- this.Create5 = "构建%s次"
-- this.Create6 = "构建完成倒计"
-- this.Create7 = "点击查看"
-- this.Create8 = "···排队等待中···"
-- this.Create9 = "闲置中"
-- this.Create10 = "构建中"
-- this.Create11 = "完成构建"
-- this.Create12 = "剩余时间"
-- this.Create13 = "加速构建"
-- this.Create14 = "一键加速"
-- this.Create15 = "一键加速可同时完成所有构建"
-- this.Create16 = "可同时进行数"
-- this.Create18 = "构建"
-- this.Create19 = "今天不再提示"
-- this.Create20 = {"类型", "名称", "注意", "概率[%]"}
-- this.Create21 = "共%s名角色"
-- this.Create22 = "构建详情"
-- this.Create23 = "注意事项"
-- this.Create24 = "核心构建"
-- this.Create25 = "各品质构建概率"
-- this.Create26 = "概率因为存在四舍五入保留两位小数点，所以存在合计无法达到100%的情况\n\n\n构建时，获得相同角色的情况是存在的\n\n\n构建时，首先按照品质提供的概率进行抽取，再根据品质中的概率抽取"
-- this.Create27 = "出现角色一览【全%s名角色】"
-- this.Create28 = "获得概率"
-- this.Create29 = "查看详情"
-- this.Create30 = "是否消耗<color=#ffae00> %s </color>进行<color=#ffae00> %s </color>次构建"
-- this.Create31 = "%s个%s"
-- this.Create32 = "构建  次"
-- this.Create33 = "构建    次"
-------------------------------------设置
this.Setting_text1 = "画面设置"
this.Setting_text2 = "音频设置"
this.Setting_text3 = "兑换中心"
this.Setting_text5 = "音乐"
this.Setting_text6 = "音效"
this.Setting_text7 = "语言"
this.Setting_text9 = "画面质量"
this.Setting_text10 = "高帧率"
this.Setting_text11 = "低级画面（流畅）"
this.Setting_text12 = "中级画面（推荐）"
this.Setting_text13 = "高级画面（高清）"
this.Setting_text14 = "粒子质量"
this.Setting_text15 = "高帧率"
this.Setting_text16 = "是否退出登录？"
this.Setting_text17 = "低级画质会让游戏变得更流畅，是否开启？"
this.Setting_text18 = "中级画质会保留大部分美术渲染，是否开启？"
this.Setting_text19 = "高级画质拥有高清画面效果，是否开启？"
this.Setting_text20 = "烘焙光效"
this.Setting_text21 = "Shader效果"
this.Setting_text23 = "是否退出游戏？"
this.Setting_text24 = "界面适应"
this.Setting_text25 = "账户注销"
this.Setting_text26 = {"开","关"}
this.Setting_text27 = {"低","中","高"}
this.Setting_text28 = "请输入兑换码"
this.Setting_text29 = "确认兑换"
this.Setting_text30 = "战斗设置"
this.Setting_text31 = "消息提醒"
this.Setting_text31 = "CONFIRM REDEMPTION"

--档案
this.cRole_2 = "更换"
this.cRole_3 = "已选中"
this.cRole_4 = "已选择"
this.cRole_5 = {"名字","所属","邂逅日期","性别","血型",
"出生地","生日年龄","三围","身高体重","兴趣",
"喜欢的","讨厌的","角色故事"}
this.cRole_6 = "为该皮肤的特有台词"
this.cRole_7 = "观看"
this.cRole_8 = {"身体素质","战斗技巧","战斗意志","队伍协调","总评"}
this.cRole_9 = {"个人访谈一：","个人访谈二：","个人访谈三："}
this.cRole_10 = "(好感度达到%s开启)"
this.archive8 = "已领取"
this.archive9 = "未获得"  
this.archive10 = "通过商店购买[未获得]"  
this.archive11 = "解锁条件"
this.archive12 = "好感度"
this.archive13 = "未拥有"
this.CRole_textTab1 = {"好感度","性别","阵营","地域"}
this.CRole_textTab3 = {"讨厌","陌生","友好","在意","喜欢","憧憬","深爱","挚爱"}
this.CRole_textTab4 = {"排列方式","性别","阵营","地域"}
this.archive14 = "声优"
this.archive15 = "画师"
this.archive16 = {"主线","支线","活动"}

--好友
this.Friend3 = "你好，我是%s"
this.Friend5 = "屏蔽该玩家的所有频道聊天信息以及好友对话消息\n双方的好友列表中除名\n无法查看ta的详细信息"
this.Friend13 = "在线"
this.Friend14 = "%s天前"
this.Friend15 = "%s小时前"
this.Friend16 = "%s分钟前"
this.Friend17 = {"我的好友","黑名单","申请中的人","待添加列表"}
this.Friend18 = "你已经拉黑了"
this.Friend19 = "在线"
this.Friend20 = "离线"
this.Friend21 = {"详情","删除","拉黑"}
this.Friend22 = "请在此处输入聊天文字"
this.Friend23 = "解除封印"
this.Friend24 = "全部拒绝"
this.Friend25 = "全部同意"
this.Friend26 = "亲爱的指挥官你搜不到啥哦"
this.Friend27 = "请在此处输入ID"
this.Friend28 = "搜索"
this.Friend29 = "你还没有朋友哦"
this.Friend30 = "已添加"
this.Friend31 = "已申请"
this.Friend32 = "待添加"
this.Friend33 = "已拉黑"
this.Friend34 = "是否向%s发出好友申请？"
this.Friend35 = "发送"
this.Friend_tips1 = "删除后，双方好友值将清空，是否确认删除？"
this.Friend_tips2 = "今日删除好友已达上限"
this.Friend_tips3 = "加入黑名单后，双方将解除好友关系，好友值清空，且无法接收对方消息，是否确定？"
this.Friend_tips4 = "是否将%s从黑名单解除？"
this.Friend_tips6 = "您所输入的查找内容有误，请确认后再输入"


--实名验证
this.Anthen_Name_Error="真实姓名不能为空";
this.Anthen_Name_Error2="名字长度不能超过15个中文字符";
this.Anthen_Name_Error3="名字不得含有数字或者特殊符号";
this.Anthen_Number_Error="身份证号码格式不正确";
this.Anthen_Number_Error2="身份证号码不能为空";
this.Anthen_Tips="您当前账号为未成年账号，游戏时间和付费会受到限制";
this.Anthen_Tips2="您正在使用游客登录";

--创建角色
this.User_Name_Tips1="指挥官名字：%s";
this.User_Name_Tips2="指挥官生日：%s月%s日";
this.User_Name_Tips3="指挥官性别：%s【确定后无法更改】";
this.User_Sex_1="男";
this.User_Sex_2="女";

--公会
this.Guild_Desc1="自我介绍：";
this.Guild_Desc2="公会名片：";
this.Guild_Desc_Default="这个人很懒，什么都没有留下...";
this.Guild_Title_Tips1="是否任命%s为副会长？";
this.Guild_Title_Tips2="是否取消%s副会长权限？";
this.Guild_Title_Tips3="是否任命%s为会长？";
this.Guild_Title_Tips4="是否将%s请离公会？";
this.Guild_Apply_Tips1="已经是好友了"
this.Guild_Title1="会长";
this.Guild_Title2="副会长";
this.Guild_Title3="普通会员";
this.Guild_TimeDesc="前";
this.Guild_Create_Tips1="请输入公会名称！"
this.Guild_Create_Tips2="请选择公会头像！"
this.Guild_Activity_Type1="活跃";
this.Guild_Activity_Type2="悠闲"
this.Guild_Search_Tips1="推荐列表";
this.Guild_Search_Tips2="申请列表";
this.Guild_Btn_State1="加  入";
this.Guild_Btn_State2="取  消";
this.Guild_Btn_State3="申  请";
this.Guild_Btn_State4="申请中";
this.Guild_Btn_State5="开  启";
this.Guild_Btn_State6="关  闭";
this.Guild_Tips1="权限不足!";
this.Guild_Tips2="20秒内无法再次刷新";
this.Guild_Join_Tips1="是否加入“%s”公会？";
this.Guild_Join_Tips2="是否申请进入“%s”公会？";
this.Guild_Join_Tips3="是否取消“%s”公会入会申请？";
this.Guild_Del_Tips="是否解散公会？解散后，48小时内无法创建新的公会。";
this.Guild_Del_Tips2="是否退出公会？退出后24小时内无法加入其它公会。";
this.Guild_Fight_ScoreTips1="贡献开启";
this.Guild_Fight_ScoreTips2="贡献关闭";
this.Guild_Rank_Default="暂无名次";
this.Guild_Rank_Tips="名";
this.Guild_Fight_Result1="胜利";
this.Guild_Fight_Result2="失败";
this.Guild_Fight_Result3="攻略成功";
this.Guild_Fight_Result4="攻略失败";
this.Guild_Season_Tips1="预赛";
this.Guild_Season_Tips2="决赛";
this.Guild_Diff_Str={"NORMAL","HARD","VERYHARD","EX","EX+","HELL90","HELL100"}

this.Guild_Result_Tips1="%s耐久";

--引导
this.guide_error = "网络异常！请确保网络连接正常，再重启游戏试试";

return this;
