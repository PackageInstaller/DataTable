__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "命令不存在"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "活动已结束"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "登入天数不足,不能领取奖励"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "参加活动,条件不满足"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "不存在此活动"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "活动未开发"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "活动尚未开启"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "活动任务未完成"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "试玩活动,未完成关卡不能领取奖励"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "试玩活动中,未找到此关卡"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "本活动该守密人已为你提供过一次助战"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "本活动需要互相关注的守密人才能提供助战"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "常用助战守密人已达上限，请调整常用助战列表"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "技能升级未到达设置的条件"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "唤醒体升格等级不足"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "唤醒体还未到开放时间"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "唤醒体已被使用过"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "不可重复拉黑"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "你已被对方列入黑名单，无法操作"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "你已被对方列入黑名单，无法关注和点赞"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "你已将对方列入黑名单，无法点赞和关注"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "拉黑人数达到上限"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "战斗创建失败"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "购买通行证等级需要的货币不足"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "操作失败"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "通行证未配置购买特权价格"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "通行证特权等级已满,无法再次购买"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "特权等级不足，无法领取"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "奖励不存在"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "奖励已领取"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "银芯源液不足"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "凭证购买次数不足"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "造物不支持强化"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "此卡已达最大等级，不能强化"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "此卡不能强化"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "包含屏蔽字"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "重复发表评论"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "重复删除"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "重复点赞"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "重复取消点赞"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "长度超过限制"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "点赞评论已删除"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "评论超时"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "专属卡升级，没有次数"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "未找到副本挑战的剧情线"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "未找到副本挑战的剧情线任务"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "幻梦深潜关卡数据更新中，请稍后重试。"
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "挑战任务已完成,无法再次领取奖励"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "挑战任务尚未完成,无法领取奖励"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "章节奖励未达到积分"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "章节奖励已领取"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "选择当前节点未找到"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "角色名字重复"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "客户端传入数据错误"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "关闭当前节点未找到"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "配置表错误"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "无法领取奖励"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "奖励尚未达到领取条件"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "关卡没有课题分数据"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "没有此副本的课题分"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "课题分没找到模块"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "尚未找到任务"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "没找到课题分单元数据"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "单元已提交，无需再次提交"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "任务中的子任务未完成"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "任务已完成"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "单元下的任务尚未全部完成，无法提交"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "当前已暂停新守密人注册"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "没有角色，需要创建"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "自定义指令使用次数达到上限"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "造物已强化"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "灵啡肽已充足，无需补充"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "当前无法进行祭祀"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "饰品不存在"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "事件区域错误"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "事件选择卡牌不存在"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "事件选择卡牌数量太多"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "事件选择造物不存在"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "事件选择造物数量太多"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "副本事件配置表中类型填写错误"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "事件数据错误"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "战斗掉落刷新卡牌没有次数"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "战斗掉落刷新造物没有次数"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "副本事件已完成"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "副本事件不存在"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "密银不足无法购买"
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "事件没找到此节点"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "事件随机池没有数据"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "联络点功能被锁"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "营地已选择了功能无法再次选择"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "营地功能已没有使用次数"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "事件商店刷新没有次数"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "事件商店删除卡牌次数已用完"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "事件选择卡牌数量不足"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "事件选择造物数量不足"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "找不到指定专属卡信息"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "升级路线没有配置角色id"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "指定专属卡未解锁"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "专属卡没有变化无法切换"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "专属卡切换失败"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "专属卡没有升级无法切换"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "找不到该专属卡uuid"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "助战唤醒体已失效，请刷新助战列表重新选择助战唤醒体。"
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "合成道具未解锁"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "合成道具需要的货币不足"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "合成道具所需的其他道具不足"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "建筑已存在不能再次建设"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "位置已存在唤醒体,无法入驻"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "建筑已到达最大等级"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "建筑不存在"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "升级/建设建筑条件不足"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "升级/建设所需要的的道具不足"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "当前节点没有奖励可领取"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "没有挑战次数"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "当前体力过低，你已经处于虚弱状态。"
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "副本探索等级达到2级解锁"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "成功完成一次探索后可瞬时探索"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "副本错误"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "没有找到副本"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "节点未解锁"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "节点已完成"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "节点未完成"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "节点不相邻"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "商店刷新次数不足"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "玩家等级不足"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "简介包含非法字符,请重新输入"
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "对方正在调查或其他玩法中"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "错误的索引值"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "您已是对方的邀请人"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "已有邀请人"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "副本状态错误，请重新登录"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "背包已满"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "今日购买次数已达上限"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "道具已被装备"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "道具已锁定"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "道具未锁定"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "道具已达最大等阶"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "物品不足"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "道具未找到"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "道具不匹配"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "道具无法使用"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "道具重复"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "命轮或钥令还未到开放时间"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "物品使用数量错误"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "物品不可使用"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "上一触发节点未找到"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "当前收集的能量不足以启动传送门，启动传送门需要{s1}点能量。"
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "已到达最大等级"
  },
  ErrCode_ERR_LOCKED_Desc = {Text = "未解锁"},
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "副本区域尚未解锁"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "剧情线扫荡尚未解锁"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "选择的副本尚未解锁"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "选择的剧情线尚未解锁"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "登录服务器错误"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "附件已领取"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "邮件不存在"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "匹配失败"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "已达最大可唤醒次数！"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "指定金币本无法挑战-"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "请选择上阵的唤醒体"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "指定金币本未解锁-请完成指定的调查副本"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "再次改名时间未到，请等待"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "名字中包含非法字符，请重新输入"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "名字长度不合法，必须2-4字符"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "输入字符过长"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "输入字符过短"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "没有足够的积分"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "您没有此道具"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "不可移动"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "功能尚未开放"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "奖励未满足条件,无法领取"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "个人资料更新中，请稍后再查看。"
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "当前没有进行中的友谊赛"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "当前没有闲置密契"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "NPC数据错误"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "Npc已触发过"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC不存在"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "对方当前不在线"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "玩家等级不足"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "剧情线星级不足，无法扫荡"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "没有找到剧情对话事件"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "剧情线挑战购买次数不足"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "奖励已领取"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "没有此奖励"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "镶嵌符文失败"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "未获得PVP收藏"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "相位对弈队伍上阵钥令不足"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "相位对弈队伍上阵命轮不足"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "未达到轮选模式开启条件"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "挑战冷却中"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "没有挑战次数"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "没有挑战对手"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "请选择上阵的唤醒体"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "双方其中有一人已达两次胜场，无法再来一局"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "对手已退出"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "密码对战 不存在 或 已过时"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "暂不支持查看 2000 名以外的排行信息。"
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "充值配置表中没有此配置"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "已免费充值过无法再次充值"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "商品刷新次数达到上限"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "与对方不是互相关注状态"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "遗物已满"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "请求过于频繁，请稍候尝试"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "精英化所需材料数量不足"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "唤醒体升级消耗的货币不足"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "角色数据错误"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "唤醒体降临度已满，无法继续提升"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "唤醒体等级不足"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "唤醒体已到达最高等级无法升级"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "货币不足"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "唤醒体已升格到最高阶"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "没有到达最高等级，无法进阶"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "没有找到唤醒体数据"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "唤醒体没有技能"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "没有槽位信息"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "唤醒体潜力已到达最高等级"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "唤醒体潜力升级道具不足"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "唤醒体尚未解锁技能"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "技能已达到最大等级"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "技能升级道具不足"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "技能升级货币不足"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "已到达最大等级"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "已没有手动升级槽位次数"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "已进阶，不能再次进阶"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "唤醒体升级消耗的道具不足"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "唤醒体升级消耗的货币不足"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "界域不满足条件"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "界域塔出战的唤醒体不满足界域要求"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "进入的关卡不在当前开启的关卡中"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "界域塔不可携带相同的唤醒体出战"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "银芯不足"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "校园维护中，请静候修整完成"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "服务未启动"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "商品已购买"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "当前无法进行感应"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "商品已过期，不可兑换"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "出售的商品已没有库存"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "没有商店数据"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "没有此类型商店"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "没有此商品出售"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "商店没此商品出售"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "没有刷新次数"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "商店中没有此商品"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "当前不是商店节点无法刷新"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "该玩家不存在"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "该原初之视的所有分身均已被击杀"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "关卡类型每日挑战次数达到上限"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "点击过于频繁，请稍候尝试"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "唤醒功能未开启"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "激活条件不足"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "共鸣已激活无需再次激活"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "共鸣初始状态不能重置"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "共鸣材料不足。"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "共鸣点已到达最大等级"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "副本中未发现共鸣"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "没有发现共鸣数据"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "未发现共鸣点等级相关数据"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "没有重置次数"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "唤醒体生产效果已解锁,无需再次解锁"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "奖励已领取"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "委派任务已完成,不可召回"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "委派条件不足"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "任务已完成"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "未找到任务"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "任务尚未完成,无法领取奖励"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "队伍名中不可包含非中文或英文字符"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "队伍名长度不可大于8个字符"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "队伍中唤醒体数量需要满足四个才可进入关卡"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "找不到队伍配置"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "队伍唤醒体没有设置命轮"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "队伍中唤醒体存在界域冲突，请进行调整"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "命轮不存在"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "凭证不足"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "登录Token错误"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "当前触发节点未找到"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "饰品没转录,无法替换属性"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "先取消关注对方才可拉黑"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "唤醒体、命轮或钥令今日在本玩法中已使用过"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "解锁支线失败：支线可用"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "解锁支线失败：支线未开启"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "解锁支线失败：无需解锁物品"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "解锁支线失败：支线已解锁"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "版本号不符，请更新最新客户端；如已更新请静待校园维护完成"
  },
  ErrCode_FAILED_Desc = {Text = "失败"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "已有角色不需要再次创建"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "操作成功"
  }
})
return Text_ErrCode
