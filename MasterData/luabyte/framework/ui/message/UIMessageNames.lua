--[[-- UI消息定义，手动添加
-- 定义格式：模块名_ON_事件描述 = "驼峰式消息名"
-- 注意：
-- 1、这类型的消息只在UI模块中流通，View层只关注这里的消息，由Model层发送
-- 2、如果窗口足够简单，那每次数据变化时发送OnRefresh消息就可以了，View层进行整体刷新，以避免消息臃肿
--]]
local UIMessageNames = {
    -- 抽卡
    UPDATE_LOTTERY_DATA = "UPDATE_LOTTERY_DATA",
    LOTTERY_TIMELINE_PLAY_OVER = "LOTTERY_TIMELINE_PLAY_OVER",
    LOTTERY_TIMELINE_SKIP = "LOTTERY_TIMELINE_SKIP",
    LOTTERY_TIMELINE_PLAY_START = "LOTTERY_TIMELINE_PLAY_START",
    LOTTERY_RECORD_CHANGEPAGE = "LOTTERY_RECORD_CHANGEPAGE",
    LOTTERY_LUCKDRAW_TIMELINE_PLAY_START = "LOTTERY_LUCKDRAW_TIMELINE_PLAY_START", --S礼物抽卡
    -- 背包
    BAG_TYPE_TABLE_CHANGE = "BAG_TYPE_TABLE_CHANGE",
    BAG_SELECT_ITEM = "BAG_SELECT_ITEM",
    BAG_USE_ITEM = "BAG_USE_ITEM",
    BAG_FREE_USE_ITEM = "BAG_FREE_USE_ITEM",
    BAG_USE_ITEM_SUC = "BAG_USE_ITEM_SUC",
    -- 任务
    TASK_TYPE_TABLE_CHANGE = "TASK_TYPE_TABLE_CHANGE", -- 切换任务类型列表
    TASK_TYPE_LEVEL_CHANGE = "TASK_TYPE_LEVEL_CHANGE", -- 引导等级页签列表
    TASK_TYPE_REFRESH = "TASK_TYPE_REFRESH",           -- 任务刷新
    TASK_AWARD_REFRESH = "TASK_AWARD_REFRESH",         -- 活跃度刷新
    -- 挂机奖励
    HANGING_REFRESH_AWARD = "HANGING_REFRESH_AWARD",
    HANGING_GET_AWARD = "HANGING_GET_AWARD",
    HANGING_FAST_AWARD = "HANGING_FAST_AWARD",
    HANGING_FAST_REFRESH = "HANGING_FAST_REFRESH",
    -- 后宅
    OTAKU_MAINSCENE_CHANGE_ROOM = "OTAKU_MAINSCENE_CHANGE_ROOM",                 -- 后宅切换房间
    OTAKU_MAINSCENE_CREATE_ROOM = "OTAKU_MAINSCENE_CREATE_ROOM",                 -- 后宅创建房间成功
    OTAKU_MAINSCENE_CREATE_ROOM_TIME_UP = "OTAKU_MAINSCENE_CREATE_ROOM_TIME_UP", -- 创建房间倒计时开始
    OTAKU_OVERIVIEW_EMPLOYEE_SELECT = "OTAKU_OVERIVIEW_EMPLOYEE_SELECT",         -- 雇员总览中选中某个房间
    OTAKU_DEOLY_HERO_ROOM = "OTAKU_DEOLY_HERO_ROOM",                             -- 布置英雄到房间
    OTAKU_HERO_ENTER = "OTAKU_HERO_ENTER",                                       -- 后宅入驻成功
    OTAKU_TOP_UPDATE = "OTAKU_TOP_UPDATE",                                       -- 后宅顶栏更新
    OTAKU_CHANGE_ROOM = "OTAKU_CHANGE_ROOM",                                     -- 后宅切换舱室
    OTAKU_NAV_CHANGE = "OTAKU_NAV_CHANGE",                                       -- 后宅导航栏切换
    OTAKU_VOICE_CHANGEBGM = "OTAKU_VOICE_CHANGEBGM",                             -- 后宅切换BGM
    OTAKU_SETTLE_UPDATE = "OTAKU_SETTLE_UPDATE",
    OTAKU_SETTLE_SELECT_UPDATE = "OTAKU_SETTLE_SELECT_UPDATE",
    OTAKU_SETTLE_SELECT_HERO = "OTAKU_SETTLE_SELECT_HERO",
    OTAKU_UPGRADE = "OTAKU_UPGRADE",
    -- 通讯
    COM_TYPE_TABLE_CHANGE = "COM_TYPE_TABLE_CHANGE",         -- 通讯页签切换
    COM_TYPE_TAB_CHANGE = "COM_TYPE_TAB_CHANGE",             -- 通讯少女切换
    COM_REFRESH_CHAT = "COM_REFRESH_CHAT",                   -- 主动刷新聊天内容
    COM_SHOW_PIC = "COM_SHOW_PIC",                           -- 点击显示大图片
    COM_REFRESH_GIFT = "COM_REFRESH_GIFT",                   -- 刷新礼物道具
    COM_TAB_NAME_CHANGE = "COM_TAB_NAME_CHANGE",             -- 改通讯对话Tab名字
    COM_SHOW_CAPTION_SELECT = "COM_SHOW_CAPTION_SELECT",     --显示长官选择
    CHIEFNOTE_SELECT_UPDATE = "CHIEFNOTE_SELECT_UPDATE",     --长官笔记选择更新
    -- 制造仓
    CREATE_UPDATE_ROOM = "CREATE_UPDATE_ROOM",               -- 更新制造舱
    CREATE_UPDATE_MAKING = "CREATE_UPDATE_SPEEDUP",          -- 更新生产中界面
    CREATE_SELECT_ITEM = "CREATE_SELECT_ITEM",               -- 选择制造物品
    CREATE_STRART_MAKING_SUC = "CREATE_STRART_MAKING_SUC",   -- 开始制造物品回调
    CREATE_SPEEDUP_MAKING_SUC = "CREATE_SPEEDUP_MAKING_SUC", -- 加速制造成功回调
    CREATE_CANCEL_MAKING = "CREATE_CANCEL_MAKING",           -- 取消制造
    -- 通讯仓
    EXPMISSION_REFRESH = "EXPMISSION_REFRESH",               -- 刷新远征任务
    EXPMISSION_UPDATE = "EXPMISSION_UPDATE",                 -- 更新远征
    -- 餐厅
    Restaurant_Select_Material = "Restaurant_Select_Material",
    Restaurant_DragDown_Material = "Restaurant_DragDown_Material",

    -- 从界面返回场景
    Restaurant_Select_Pos = "Restaurant_Select_Pos",
    -- 选择第几桌
    -- 宿舍
    Dorm_CHANGE_ROOM = "Dorm_CHANGE_ROOM",
    DORM_SELECT_FURNITURE = "DORM_SELECT_FURNITURE",
    DORM_CHANGE_FURNITURE = "DORM_CHANGE_FURNITURE",
    DORM_GIVE_GIFT = "DORM_GIVE_GIFT",
    DORM_ROULETTE_BACK = "DORM_ROULETTE_BACK",
    DORM_INTERACTIVE_BACK = "DORM_INTERACTIVE_BACK",
    DORM_CONCEAL_DORM = "DORM_CONCEAL_DORM",
    DORM_DIARY_SELECT = "DORM_DIARY_SELECT",
    DORM_INTERACT_CLICK = "DORM_INTERACT_CLICK",                             --宿舍交互点击
    DORM_DRESSUP_UPDATE_AREAFURNITURE = "DORM_DRESSUP_UPDATE_AREAFURNITURE", --更新区域家具数据
    DORM_UPDATE_FAVOR = "DORM_UPDATE_FAVOR",                                 --更新好感度
    DORM_UPDATE_ATMOSPHERE = "DORM_UPDATE_ATMOSPHERE",                       --更新氛围值
    DORM_STORY_SELECT_ITEM = "DORM_STORY_SELECT_ITEM",                       --宿舍剧情送礼选择道具
    DORM_STORY_SELECT_GIVING_ITEM = "DORM_STORY_SELECT_GIVING_ITEM",         --宿舍剧情送礼选择提交道具
    DORM_FURNITURE_REDPOINT = "DORM_FURNITURE_REDPOINT",                     --宿舍家具红点
    DORM_PUZZLE_ACTIVE = "DORM_PUZZLE_ACTIVE",                               --碎片激活
    DORM_PUZZLE_CLICKREWARD = "DORM_PUZZLE_CLICKREWARD",                     --点击碎片奖励
    -- 好感度
    FAVOR_SELECT_STAGE = "FAVOR_SELECT_STAGE",                               -- 好感度阶段选择事件
    FAVOR_SELECT_LEVEL = "FAVOR_SELECT_LEVEL",                               -- 好感度等级选择事件
    FAVOR_SELECT_ROOM_STORY = "FAVOR_SELECT_ROOM_STORY",                     -- 好感度剧情选择事件
    -- 舰桥
    BRIDGE_SKILL_UPGRADE = "BRIDGE_SKILL_UPGRADE",                           -- 指挥官技能更新
    -- 百科图鉴
    PLOT_BOOK_REWARD = "PLOT_BOOK_REWARD",                                   -- 百科图鉴领奖
    -- 票选
    VOTING_CLICKITEM = "VOTING_CLICKITEM",                                   -- 点击了一个按钮
    VOTING_CLICKHERO = "VOTING_CLICKHERO",                                   -- 点击了一个英雄
    VOTING_HEROVOTE = "VOTING_HEROVOTE",                                     -- 为英雄选票
    VOTING_HEROVOTEREF = "VOTING_HEROVOTEREF",                               -- 选票成功后刷新自己数据
    VOTING_SELECTHERO1 = "VOTING_SELECTHERO1",                               -- 八强选中一个英雄
    VOTING_SELECTHERO2 = "VOTING_SELECTHERO2",                               -- 八强选中一个英雄
    VOTING_TWESELECTHERO1 = "VOTING_TWESELECTHERO1",                         -- 二强中选中一个英雄
    VOTING_REFSTATE = "VOTING_REFSTATE",                                     --票选刷新状态
    -- 小游戏
    GAME_SELECE = 'GAME_SELECE',
    GAME_GAMEEFRESH = 'GAME_GAMEEFRESH',
    GAME_DATAREFRESH = 'GAME_DATAREFRESH',
    GAME_CLOSE = 'GAME_CLOSE',
    GAME_RESTART = 'GAME_RESTART',
    GAME_RETURN = 'GAME_RETURN',
    GAME_BEE_BULLET_DIE = 'GAME_BEE_BULLET_DIE',
    -- 餐厅
    COOKING_LARGECOOKING = "COOKING_LARGECOOKING",       -- 批量烹饪
    COOKING_UPDATEMATERIAL = "COOKING_UPDATEMATERIAL",   -- 更新拥有的食材
    COOKING_UPDATEFOOD = "COOKING_UPDATEFOOD",           -- 刷新制造信息
    COOKING_LEVELSELECTHERO = "COOKING_LEVELSELECTHERO", -- 离开选择英雄
    COOKING_UPDATEHEROFEED = "COOKING_UPDATEHEROFEED",   -- 吃菜成功后更新英雄饱食度
    COOKING_COOINGHERO2 = "COOKING_COOINGHERO2",         -- 餐厅入驻成功后刷新吃菜英雄数据
    COOKING_PUTDISH = "COOKING_PUTDISH",                 -- 上菜
    COOKING_UPDATEHEROITEM = "COOKING_UPDATEHEROITEM",   -- 更新选择战员状态
    COOKING_COOKING = "COOKING_COOKING",                 --做菜
    COOKING_SUCCESS = "COOKING_SUCCESS",                 -- 烹饪成功
    COOKING_CLICKPOSREF = "COOKING_CLICKPOSREF",         --选中一个位置后刷新
    COOKING_UPDATEMENU = "COOKING_UPDATEMENU",           --更新菜单
    COOKING_HIDEHERO = "COOKING_HIDEHERO",               --隐藏吃饭英雄
    COOKING_SHOWHIDEHERO = "COOKING_SHOWHIDEHERO",       --显示隐藏的吃饭英雄
    COOKING_REFCHOOSE = "COOKING_REFCHOOSE",             --吃饭完成后刷新列表
    -- COOKING_REFEATTIPS = "COOKING_REFEATTIPS",           --刷新吃饭提示状态
    COOKING_EATSUCCESS = "COOKING_EATSUCCESS",           --吃饭完成刷新其他房间英雄饱食度
    -- 签到
    SIGN_7DAYS_GETANIMEND = "SIGN_7DAYS_GETANIMEND",     -- 7日签到获得动画结束
    SIGN_7DAYS_DISPOSE = "SIGN_7DAYS_DISPOSE",           -- 关闭7日签到
    -- 商店
    SHOP_UPDATE = "SHOP_UPDATE",                         -- 商店更新
    RECHARGE_STATE_UPDATE = "RECHARGE_STATE_UPDATE",     -- 首充更新
    MONTH_CARD_DAYS_UPDATE = "MONTH_CARD_DAYS_UPDATE",   -- 月卡剩余天数更新
    SHOP_UPDATEGIFT = "SHOP_UPDATEGIFT",                 --刷新礼包
    SHOP_CLOTH_BUY_SUCC = "SHOP_CLOTH_BUY_SUCC",         --皮肤购买成功
    SHOP_UPDATECURRENCY = "SHOP_UPDATECURRENCY",         --商店货币刷新
    LIMITSHOP_UPDATE = "LIMITSHOP_UPDATE",               -- 极限战役商店更新
    -- 系统
    SYSTEM_UPDATEMAILS = "SYSTEM_UPDATEMAILS",           -- 更新邮件 多封
    -- 活动进度变化
    ACTIVITY_UPDATE = "ACTIVITY_UPDATE",
    ACTIVITY_COMMON_REWARD = "ACTIVITY_COMMON_REWARD",
    ACTIVITY_OPEN_DORM = "ACTIVITY_OPEN_DORM",
    -- 养成
    ROLE_DEVELOP_REFRESH_DATA = "ROLE_DEVELOP_REFRESH_DATA", -- 切换英雄刷新界面信息
    ROLE_DEVELOP_MAINUI_STATE = "ROLE_DEVELOP_MAINUI_STATE", -- 主界面状态
    ROLE_DEVELOP_CAMERA_MOVE = "ROLE_DEVELOP_CAMERA_MOVE",   -- 相机调整
    ROLE_DEVELOP_CLICKHERO = "ROLE_DEVELOP_CLICKHERO",       --刷新选中状态
    ROLE_DEVELOP_CLICKCORE = "ROLE_DEVELOP_CLICKCORE",       --选中一个核心
    ROLE_GENE_UPGRADE = "ROLE_GENE_UPGRADE",                 --基因升级
    ROLE_LIST_POS = "ROLE_LIST_POS",                         --养成界面位置
    ROLE_HERO_LVUP = "ROLE_HERO_LVUP",                       --升级成功
    ROLE_DEVELOP_AWAKE = "ROLE_DEVELOP_AWAKE",               --跃迁成功
    ROLE_SKILLUP = "ROLE_SKILLUP",                           --技能升级成功
    -- 剧情
    STORY_REFRESH = "STORY_REFRESH",
    STORY_END = "STORY_END",
    STORY_VISIBLE = "STORY_SET_VISIBLE",
    STORY_CALL_MAIN = "STORY_CALL_MAIN",           --调用剧情主界面方法
    -- 编队
    TEAMHEROITEMCLICK = "TEAMHEROITEMCLICK",       -- 编队界面点击了一个英雄
    TEAMHEROITEMFRICLICK = "TEAMHEROITEMFRICLICK", --
    UPDATETEAM = "UPDATETEAM",                     -- 刷新编队
    CLICKSKILL = "CLICKSKILL",                     -- 点击了技能
    TEAM_CLICKHERO = "TEAM_CLICKHERO",             --编队左侧选中一个英雄
    TEAM_CLICKFRIENDHERO = "TEAM_CLICKFRIENDHERO", --编队好友助阵选中一个英雄
    TEAMCLICKNOTICEFRI = "TEAMCLICKNOTICEFRI",     --编队点击一个陌生人
    -- 好友
    FRIEND_ADD_UPDATE = "FRIEND_ADD_UPDATE",       -- 添加好友
    FRIEND_REMOVE_UPDATE = "FRIEND_REMOVE_UPDATE", -- 删除好友
    FRIEND_DATA_UPDATE = "FRIEND_DATA_UPDATE",
    -- 照片墙
    PHOTOWALL_CLICKITEM = "PHOTOWALL_CLICKITEM",         -- 点击了一个照片墙
    PHOTOWALL_SELECTPOS = "PHOTOWALL_SELECTPOS",         -- 选择一个
    PHOTOWALL_SELECTPHOTO = "PHOTOWALL_SELECTPHOTO",     -- 选择一个照片
    PHOTOWALL_TO = "PHOTOWALL_TO",                       --查看照片墙
    PHTOT_CLICKITEM = "PHTOT_CLICKITEM",                 --照片墙操作
    -- 海报墙
    LOADFURNITURE = "LOADFURNITURE",                     --加载海报
    SHOWDROW = "SHOWDROW",
    PHOTOWALL_SELECTPOSTER = "PHOTOWALL_SELECTPOSTER",   -- 选择了一个海报
    PHOTOWALL_CLOSEPOP = "PHOTOWALL_CLOSEPOP",           -- 关闭海报墙编辑界面
    POSTERWALL_CLICKITEM = "POSTERWALL_CLICKITEM",       --点击了第几个海报
    -- 通信证
    PASS_ITEM_REWARD_UPDATE = "PASS_ITEM_REWARD_UPDATE", -- 奖励刷新
    PASS_TASK_UPDATE = "PASS_TASK_UPDATE",               -- 通行证任务更新
    PASS_INFO_CHANGED = "PASS_INFO_CHANGED",             -- 通行证活动变化
    -- 成就
    NOTIFY_UPDATE_ACHIEVEMENT = "NOTIFY_UPDATE_ACHIEVEMENT",
    -- 个人副本
    DORM_PERSONALCOPY_ENDBATTLE = "DORM_PERSONALCOPY_ENDBATTLE", --个人副本战斗结束
    --时间刷新通知
    FIVE_CLOCK_NOTIFY = "FIVE_CLOCK_NOTIFY",
    ZERO_CLOCK_NOTIFY = "ZERO_CLOCK_NOTIFY",
    --体力系统
    ENERGY_CHANGED_NOTIFY = "ENERGY_CHANGED_NOTIFY",  -- 体力变化通知
    ENERGY_BUYTIMES_NOTIFY = "ENERGY_CHANGED_NOTIFY", -- 体力购买次数变化通知
    BATTLE_MOPUOP_END = "BATTLE_MOPUOP_END",          -- 扫荡结束
    --创角
    CREATE_ACCOUNT_SUCCESS = "CREATE_ACCOUNT_SUCCESS",
    --战员图鉴
    HERO_ATLAS_REWARD_STATE_UPDATE = "HERO_ATLAS_REWARD_STATE_UPDATE",
    --主界面
    CHANGE_MAINSCENE_HERO = "CHANGE_MAINSCENE_HERO",
    CHANGE_MAINSCENE_BACKGROUND = "CHANGE_MAINSCENE_BACKGROUND",
    --遭遇战
    ENCOUNTE_CHOOSE_MISSION = "ENCOUNTE_CHOOSE_MISSION",
    ENCOUNT_GAIN_AWARD = "ENCOUNT_GAIN_AWARD",
    --假面舞会
    DANCE_CLICKGIFT = "DANCE_CLICKGIFT",         --假面舞会点击一个礼物item
    --幻灯片
    BANNER_ITEM = "BANNER_ITEM",                 --更新幻灯片
    -- 时装
    ROLE_FASHION_CHANGE = "ROLE_FASHION_CHANGE", -- 时装穿戴
    --边仓主界面scrollview设置
    SET_OTAKU_MAIN_UI_HONRIZONTAL = "SET_OTAKU_MAIN_UI_HONRIZONTAL",
    -- Boss战词条刷新
    BOSS_WORDS_REFRESH = "BOSS_WORDS_REFRESH",
    --成长基金
    LEVELFUND_RECHARGE = "LEVELFUND_RECHARGE",       --成长基金充值成功后刷新
    -- 战役
    JUMP_ITEM_DONE = "JUMP_ITEM_DONE",               -- 道具跳转标记完成
    CLOSE_MISSION_DETAILS = "CLOSE_MISSION_DETAILS", -- 关闭关卡详情
}
return UIMessageNames
