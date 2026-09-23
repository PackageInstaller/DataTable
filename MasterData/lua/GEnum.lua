-- 将名字与数值反向关联，就可以实用数值返回枚举值的名字
function GenEnumNameByVal(name, enums)
    local tmpTb = {}

    for k, v in pairs(enums) do
        tmpTb[v] = k
    end

    _G[name] = tmpTb
end

-- TODO: 热更赋值使用，没有就赋值一下
if not ACC_TO_UID_ADD_NUM then
    ACC_TO_UID_ADD_NUM = 100000000
end

-----------------------物品--------------------------------------------------------------------------
MAX_INT = 2000000000
MAX_UNSIGNED_INT = MAX_INT * 2

-- 货币[ 定义了这个客户端就不会把这个物品显示在背包，如果需要显示在背包定义在 ITEMS_ID = {} ]
ITEM_ID = {}
ITEM_ID.GOLD = 10001 -- 金币
ITEM_ID.DIAMOND = 10002 -- 钻石
-- ITEM_ID.ArmyCoin = g_ArmyCoinId --军演代币  --表未加载，无法赋值
-- ITEM_ID.AbilityCoin = g_AbilityCoinId --能力点数
ITEM_ID.CARD_STORE_EXP = 10003 -- 角色存储经验
ITEM_ID.PLR_EXP = 10004
ITEM_ID.Hot = 10035 -- 体能
ITEM_ID.BIND_DIAMOND = 10040 -- 微晶
ITEM_ID.POWER_CEILING = 10041 -- 爬塔报酬上限
ITEM_ID.EXPLORE_EXP = 10043 -- 勘探经验
ITEM_ID.MonthCard = 10030 -- 月卡
ITEM_ID.EX = 10044 --10044_Item##高级勘探
ITEM_ID.PLUS = 10045 --10045_Item##机密勘探
ITEM_ID.DIFF = 10046 --10046_Item##勘探差价
ITEM_ID.TAO_FA_Count = 12005 --讨伐次数
ITEM_ID.DeductionVoucher=10999 --抵扣券[ 紫龙使用的 ]
ITEM_ID.DIAMOND_PAY = 10998 -- 充值获得钻石


-- ITEMS_ID 枚举不要与 ITEM_ID 的定义重复数值
ITEMS_ID = {}
ITEMS_ID.DORM_FUR_COIN = 10013 -- 家具币
ITEMS_ID.EQUIP_EXP = 10021 -- 芯片素材经验, 改：不是货币，是普通物品

-- save type是数据库保存，不能修改，只能添加
ITEM_TYPE = {}
ITEM_TYPE.NONE = 1 -- 1：货币类
ITEM_TYPE.NORMAL = 2 -- 2：普通材料
ITEM_TYPE.TIME_LIMIT_MATERIAL = 3 -- 3：限时素材
ITEM_TYPE.CARD_MATERAIAL = 4 -- 4：卡牌素材（card_id 对应卡牌配置）
ITEM_TYPE.CARD = 5 -- 5：卡牌
ITEM_TYPE.EQUIP = 6 -- 6：装备
ITEM_TYPE.EQUIP_MATERIAL = 7 -- 7：装备素材
ITEM_TYPE.GIFT_BAG = 8 -- 8:礼包
ITEM_TYPE.SKIN = 9 -- 9:皮肤
ITEM_TYPE.PROP = 10 -- 10:道具
ITEM_TYPE.TALENT = 11 -- 11:天赋素材
ITEM_TYPE.FORNITURE = 12 -- 宿舍家具
ITEM_TYPE.CLOTHES = 13 -- 宿舍服装
ITEM_TYPE.GIFT = 14 -- 宿舍礼物
ITEM_TYPE.CARD_CORE_ELEM = 15 -- 卡牌核心碎片
ITEM_TYPE.PANEL_IMG = 16 -- 看板图片
ITEM_TYPE.SEL_BOX = 17 -- 物品选择箱子
ITEM_TYPE.THEME = 18 -- 宿舍主题
ITEM_TYPE.ICON_FRAME = 19 -- 头像框(dy_value1 头像框配置表的id)
ITEM_TYPE.LIMITED_TIME_ITEM = 20 -- 限时物品
ITEM_TYPE.ICON = 21  -- 头像(dy_value1 头像配置表的id)
ITEM_TYPE.CHANGE_SHAPE = 22 -- 形态转换券
ITEM_TYPE.CHANGE_NAME = 23 -- 改名券
ITEM_TYPE.BG_ITEM = 24 --主界面背景图道具
ITEM_TYPE.VOUCHER = 25 --抵扣券
ITEM_TYPE.ICON_TITLE = 26 --玩家称号
ITEM_TYPE.ASMR = 27 --ASMR音频
ITEM_TYPE.SECTION_MULTI = 28 --双倍掉落道具
ITEM_TYPE.LIMITED_TIME_SKIN = 29 --限时皮肤
ITEM_TYPE.ICON_EMOTE = 30 --对战表情
ITEM_TYPE.CHANGE_NAME_AND_SEX = 31 -- 名字与形态转换券
ITEM_TYPE.LIMIT_CODE = 32 -- 识别码容器
ITEM_TYPE.HALO_EQUIP = 33 -- 光环装备
ITEM_TYPE.DORM_PET = 34 -- 宿舍宠物
ITEM_TYPE.SkINPASS_EXP = 35 -- 皮肤通行证经验道具
ITEM_TYPE.MAIN_THEME_UI = 36 -- 主界面UI物品

-- 物品标签
ITEM_TAG = {}
ITEM_TAG.None = 0
ITEM_TAG.TimeLimit = 1 --限时
ITEM_TAG.FirstPass = 2 -- 首通
ITEM_TAG.ThreeStar = 3 -- 三星
ITEM_TAG.LittleChance = 4 -- 小概率
ITEM_TAG.Chance = 5 -- 概率
ITEM_TAG.Other = 6 --额外

-- 道具子类型
PROP_TYPE = {}
PROP_TYPE.CardStorgeSpace = 1 -- 卡牌存储空间
PROP_TYPE.EquipStorgeSpace = 2 -- 装备存储空间
PROP_TYPE.MemberReward = 3 -- 会员奖励 dy_value2 填写天数 dy_tb 字段填写, 奖励的东西
PROP_TYPE.ExpMaterial = 4 -- 经验素材 dy_tb 字段填写增加的经验值 dy_tb[升级经验，强化经验]
PROP_TYPE.ExpAddCard = 5 -- 经验加成卡
PROP_TYPE.GoldAddCard = 6 -- 金币加成卡
PROP_TYPE.PlrHot = 7 -- 玩家体能
PROP_TYPE.IconFrame = 8 -- 头像框(dy_arr[头像框物品id, 有效时间秒（不填 or 0表示不过期）], 可配置为自动使用，客户端不显示)
PROP_TYPE.CardOpen = 9 -- 形态转换开启 [不能填成自动使用](dy_value1：道具子类型， dy_value2：生效的卡牌，dy_arr: 添加or开启的卡牌id)
PROP_TYPE.MechaOpen = 10 -- 机神开启   [不能填成自动使用](dy_value1：道具子类型， dy_value2：生效的卡牌，dy_arr: 添加or开启的机神技能id)
PROP_TYPE.Icon = 13 -- 头像(dy_arr[头像物品id, 有效时间秒（不填 or 0表示不过期）], 可配置为自动使用，客户端不显示)
PROP_TYPE.Pet = 14 -- 宠物(动态值2填宠物id)
PROP_TYPE.PetItem = 15 -- 宠物道具(动态值2填宠物物品id)
PROP_TYPE.PetArchive = 16 -- 宠物图鉴（动态值2填宠物图鉴表id）
PROP_TYPE.Music = 17 -- 音乐（动态值2音乐表id）
PROP_TYPE.IconTitle = 18 -- 玩家称号（动态值2称号表id）
PROP_TYPE.SKIN_REBATE = 19 --皮肤返利卡 （动态值2称号表id）
PROP_TYPE.RogueMapRollCnt = 20 --小地图探索移动次数（动态值2填增加的次数）
PROP_TYPE.HaloExp = 21 -- 关环经验素材
PROP_TYPE.OLD_SKIN_REBATE = 22 -- 旧皮肤返利
PROP_TYPE.Main_Theme_UI = 23 -- 主界面UI道具 主题(dy_arr[主题物品id, 有效时间秒（不填 or 0表示不过期）], 可配置为自动使用，客户端不显示)
PROP_TYPE.PeriodicBossCnt = 25 -- 周期BOSS挑战次数

-- 物品月卡类型
ItemMemberType = {}
ItemMemberType.Day = 1
ItemMemberType.Week = 2
ItemMemberType.Month = 3

-- 卡牌类型
CARD_TYPE = {}
CARD_TYPE.FIGHT = 1
CARD_TYPE.EXP_MATERIAL = 2
CARD_TYPE.TALENT_MATERIAL = 3

-- 跨服调用类型
CallPlrType = {}
CallPlrType.AssitTeamBase = 1
CallPlrType.AssitTeamDetail = 2
CallPlrType.PracticeDfTeam = 3
CallPlrType.PracticeAttack = 4
CallPlrType.FPanelInfo = 5
CallPlrType.ArmyInvite = 6
CallPlrType.ArmyInviteRespond = 7
CallPlrType.FArmyLogout = 8
CallPlrType.RealTimeArmyResult = 9
CallPlrType.TransformMsg = 10
CallPlrType.TryPassFriend = 11
CallPlrType.GetOpenDorm = 12
CallPlrType.GetDorm = 13
CallPlrType.PlrBindInvite = 14
CallPlrType.PlrBindInviteAgree = 15
CallPlrType.DupSupportUpdate = 16 -- 副本支援更新
CallPlrType.Army3Invite = 17
CallPlrType.Army3InviteRespond = 18
CallPlrType.LookFightAddr = 19
CallPlrType.DupSupportFriendRequireSup = 20

GenEnumNameByVal('CallPlrTypeName', CallPlrType)

-------------------------------------------------------------------------------------------------
-- 掉落类型
RandRewardType = {}

RandRewardType.TEMPLATE = 1 -- ：嵌套模板
RandRewardType.ITEM = 2 -- ：物品
RandRewardType.CARD = 3 -- ：卡牌
RandRewardType.EQUIP = 4 -- ：装备
RandRewardType.ID = 5 -- ：其他模块Id类型
RandRewardType.HALOEQUIP = 6 -- 光环装备

-------------------------------------------------------------------------------------------------
-- 周期重置周期类型
PeriodType = {}

PeriodType.None = 0 -- 0：不重置
PeriodType.Day = 1 -- 1：天重置
PeriodType.Week = 2 -- 2：周重置
PeriodType.Month = 3 -- 3：月重置
PeriodType.OnFlush = 4 -- 4：刷新重置
PeriodType.Time = 5 -- 5：按时间点刷新重置
PeriodType.MonthCard = 6 -- 6：月卡重置购买

-- 周期重置周期类型
DungeonResetType = {}

DungeonResetType.Confrontation = 1 -- 1：镜像作战,竞技场
DungeonResetType.Abattoir = 2 -- 2：角斗场赛季
DungeonResetType.Shop = 3 -- 3：按对应商店的结束时间
DungeonResetType.Time = 4 -- 4：按配置的结束时间
DungeonResetType.SplitTime = 5 -- 5：按多时段上架的时间重置
DungeonResetType.SelfChoice = 6 -- 6：自选构建卡牌，特殊处理

-------------------------------------------------------------------------------------------------
-- 布尔类型
BoolType = {}
BoolType.No = 1
BoolType.Yes = 2

-------------------------------------------------------------------------------------------------
-- 购买条件类型
ShopBuyLimitType = {}

ShopBuyLimitType.None = 0 -- 0：不限
ShopBuyLimitType.NewPlrByDay = 1 -- 1：新号前几天
ShopBuyLimitType.PlrLv = 2 -- 2：玩家等级
ShopBuyLimitType.PassDup = 3 -- 3：通关id
ShopBuyLimitType.FirstRecharge = 4 -- 4：首充
ShopBuyLimitType.UnlockPlot = 6  -- 6:爱相随剧情解锁幕
ShopBuyLimitType.MultTeamStage = 7  -- 7:多队玩法周目

-- 皮肤获取方式
SkinGetType = {}
SkinGetType.None = 9999 -- 暂无获取方式
SkinGetType.Store = 1 -- 商店购买
SkinGetType.Archive = 2 -- 活动获取
SkinGetType.Other = 3 -- 周边获得

--ASMR商品绑定类型
ShopCommBindType={}
ShopCommBindType.Show=1 --仅展示
ShopCommBindType.Bindling=2 --绑定销售

-----------------------副本地图--------------------------------------------------------------------------
-- 枚举:副本角色类型
eDungeonCharType = {}
eDungeonCharType.MyCard = 1 -- 玩家控制的队伍
-- eDungeonCharType.NpcCard		= 2 -- 好友及其他npc队伍
eDungeonCharType.MonsterGroup = 3 -- 怪物组
eDungeonCharType.Prop = 4 -- 道具
eDungeonCharType.Block = 5 -- (固定)阻挡

-- 枚举:副本角色状态
eDungeonCharState = {}
eDungeonCharState.Normal = 1 -- 正常
eDungeonCharState.Death = 2 -- 死亡(消失)
eDungeonCharState.Fighting = 3 -- 战斗中
eDungeonCharState.Active = 4 -- 激活(道具)
eDungeonCharState.NotShow = 5 -- 不显示
eDungeonCharState.InHole = 6 -- 填补到坑洞

-- 枚举：副本地图的操作模式
eDungeonMapState = {}
eDungeonMapState.Normal = 1 -- 正常
eDungeonMapState.Info = 2 -- 查看地图信息

-- 枚举：副本移动回复的特殊移动类型，目前只有怪物移动会用到
eDungeonSpecialMoveType = {}
eDungeonSpecialMoveType.SandSlip  = 1 -- 流沙滑动

-- 道具类型
ePropType = {}
ePropType.Normal            = 0 -- 无须类型的道具
ePropType.AddHp             = 1 -- 补给
ePropType.AddHpPercent      = 2 -- 补给百分比
ePropType.Damage            = 3 -- 陷阱伤害
ePropType.DamagePercent     = 4 -- 陷阱伤害百分比
ePropType.Box               = 5 -- 宝箱
ePropType.Rand              = 6 -- 随机物品
ePropType.TransferDoor      = 7 -- 传送门
ePropType.TransferDoorRand  = 8 -- 传送门（随机）
ePropType.TransferStage     = 9 -- 传送平台
ePropType.TransferStageRand = 10 -- 传送平台（随机）
ePropType.AttackObj         = 11 -- 炮台
ePropType.AttackObjRand     = 12 -- 飞来伤害
ePropType.Buffer            = 13 -- 加buff
ePropType.AttackBack        = 14 -- 击退陷阱
ePropType.Trigger           = 15 -- 触发器
ePropType.Block             = 16 -- 机关障碍
ePropType.PushBox           = 17 -- 可移动箱子
ePropType.OnceWay           = 18 -- 一次性道路
ePropType.Palsy             = 19 -- 麻痹陷阱
ePropType.Ice               = 20 -- 冰冻陷阱
ePropType.Fire              = 21 -- 燃烧陷阱
ePropType.Thunder           = 22 -- 落雷陷阱
ePropType.Smog              = 23 -- 毒雾陷阱
ePropType.Holographic       = 24 -- 全息投影
ePropType.FieldEffect       = 25 -- 场地效果
ePropType.DisposableBox     = 26 -- 首次宝箱
ePropType.AttackObjPoised   = 27 -- 蓄力炮台
ePropType.SecendBox         = 28 -- 二次宝箱(与首次宝箱互斥)
ePropType.MonsterTrigger    = 29 -- 怪物触发AI
ePropType.WarmingPoised     = 30 -- 红蓝炮台
ePropType.Toxicide          = 31 -- 解毒草
ePropType.WarmingThunderA   = 32 -- 预示落雷A
ePropType.WarmingThunderB   = 33 -- 预示落雷B
ePropType.AddNp             = 34 -- np补给
ePropType.Spread            = 35 -- 扩散陷阱
ePropType.SpreadB           = 36 -- 扩散陷阱B
ePropType.AttackBackB       = 37 -- 击退陷阱B
ePropType.Rockfall          = 38 -- 落石


-- 障碍类型
eBlockType = {}
eBlockType.Normal = 1 -- 一般障碍
eBlockType.Ground = 2 -- 陆地障碍，飞行单位无视该障碍
eBlockType.Fly = 3 -- 空中障碍，陆行单位无视该障碍

-- 副本地形类型
eMapGridType = {}
eMapGridType.None = 1 -- 不存在
eMapGridType.Sand = 2 -- 流沙
eMapGridType.Water = 3 -- 水面
eMapGridType.Ice = 4 -- 冰
eMapGridType.Hide = 5 -- 隐藏(逻辑上存在只是不显示,当成障碍,恢复显示时,能够恢复联通路径)
eMapGridType.Slide = 6 -- 指向滑动
eMapGridType.Gravity = 7 -- 重力区
-- eMapGridType.OnceWay     = 8 --一次性道路
-- eMapGridType.Projection  = 10 --全息投影
-- 格子方向
eMapGridDir = {'up', 'right', 'down', 'left'}

-- 副本格子坑洞
eMapGridHoleType = {}
eMapGridHoleType.Deep = 1 -- 无底洞
eMapGridHoleType.Shallow = 2 -- 填补坑
eMapGridHoleType.Fall = 3 -- 掉落坑

-- 副本技能
eFbSkillType = {}
eFbSkillType.PushBox = 1 -- 推箱子
eFbSkillType.DestroyProp = 2 -- 破坏

-----------------------日常--------------------------------------------------------------------------
eDailyType = {}
eDailyType.material = 1 -- 材料
eDailyType.chip = 2 -- 芯片
eDailyType.skill = 3 -- 技能
eDailyType.Spar = 4 -- 晶石
eDailyType.exp = 5 -- 经验

-----------------------邮件--------------------------------------------------------------------------
MailOperateType = {}
MailOperateType.Read = 1 -- 读
MailOperateType.Get = 2 -- 领取
MailOperateType.Delete = 3 -- 删除

MailGetType = {}
MailGetType.No = 1 -- 未领
MailGetType.Yes = 2 -- 已领

MailReadType = {}
MailReadType.No = 1 -- 未读
MailReadType.Yes = 2 -- 已读

MailExpireType = {}
MailExpireType.FixDate = 1 -- 固定日期内有效
MailExpireType.Forever = 2 -- 永久有效
MailExpireType.DayLimit = 3 -- 发送邮件起

------------------------------任务-----------------------------------------------------------------------
-- 类型(按顺序加，接取任务的时候会获取长度TASK_TYPE_COUNT)
eTaskType = {}
eTaskType.Main = 1 -- 主线
eTaskType.Sub = 2 -- 支线
eTaskType.Daily = 3 -- 日常
eTaskType.Weekly = 4 -- 每周
eTaskType.Activity = 5 -- 活动
eTaskType.DupTower = 6 -- 长期副本爬塔
eTaskType.TmpDupTower = 7 -- 短期副本爬塔
eTaskType.DupTaoFa = 8 -- 讨伐
eTaskType.Story = 9 -- 剧情
eTaskType.DupFight = 10 -- 战场
eTaskType.Seven = 11 -- 七天引导
eTaskType.SevenStage = 12 -- 七天引导阶段
eTaskType.DayExplore = 13 -- 每日勘探任务
eTaskType.WeekExplore = 14 -- 每周勘探任务
eTaskType.Explore = 15 -- 每期勘探任务
eTaskType.GuideStage = 16 -- 每期引导任务阶段
eTaskType.Guide = 17 -- 每期引导任务
eTaskType.NewYearFinish = 18 -- 新年阶段任务
eTaskType.NewYear = 19 -- 新年任务
eTaskType.Regression = 20 -- 回归基金任务
eTaskType.Rogue = 21      -- 乱序演习任务
eTaskType.RegressionTask = 22     -- 回归任务
eTaskType.RegressionBind = 23     -- 回归绑定任务
eTaskType.StarPalace = 24     -- 十二星宫任务
eTaskType.Pet = 25              -- 夏活宠物图鉴任务
eTaskType.AbattoirMoon = 26     -- 角斗场月任务
eTaskType.AbattoirSeason = 27     -- 角斗场赛季任务
eTaskType.Puzzle = 28 --拼图活动任务
eTaskType.DupLiZhan = 29 --历战任务
eTaskType.GlobalBossDay = 30     -- 世界Boss日任务
eTaskType.GlobalBossMonth = 31     -- 世界Boss月任务
eTaskType.PointsBattle = 32     -- 积分战斗
eTaskType.AnniversaryMission = 33     -- 周年活动任务
eTaskType.MultTeam = 34     -- 多队玩法
eTaskType.LimitReward = 35      -- 限量奖励任务
eTaskType.LimitRewardStage = 36      -- 限量奖励阶段任务
eTaskType.NewPlayerSeven = 37      -- 新手七日任务
eTaskType.RichMan = 38      -- 大富翁任务
eTaskType.SONICO = 39       -- 索尼子联动任务
eTaskType.EternalBattle = 40       -- 永镜战域任务
eTaskType.SkinPass = 41       -- 皮肤通行证任务
eTaskType.ChainFront = 42       -- 连锁战线任务
eTaskType.GoldenRebate = 43 --连续累充
eTaskType.RoleTrainGuild = 44 --新手培养引导
eTaskType.StoryCollection   = 45 --故事集任务
eTaskType.StoryCollectionAct   = 46 --故事集活动任务
eTaskType.CrossBoss   = 48 --虚数天灾任务

TASK_TYPE_COUNT = table.size(eTaskType)

GenEnumNameByVal('eTaskTypeName', eTaskType)

-- v 任务过期时间
-- 任务的固定周期过期时间类型（根据这个设置任务的过期时间字段，添加类型的时候需要这里也加）
eTaskFixExpiryType = {
    [eTaskType.Daily] = PeriodType.Day
    , [eTaskType.DayExplore] = PeriodType.Day
    , [eTaskType.GlobalBossDay] = PeriodType.Day

    , [eTaskType.Weekly] = PeriodType.Week
    , [eTaskType.WeekExplore] = PeriodType.Week

    , [eTaskType.GlobalBossMonth] = PeriodType.Month
}

-- v 任务过期时间
-- 任务动态过期类型，根据配置表设定的周期过期，类型加配置表字段名字
eTaskDyExpiryType = {
    [eTaskType.Story] = 'nRestType'
    , [eTaskType.RichMan] = 'nRestType'
    , [eTaskType.SkinPass] = 'nRestType'
    , [eTaskType.MultTeam] = 'nRestType'
    , [eTaskType.RegressionTask] = 'type'
}


-- 任务提示图片： 白、黄、蓝、绿
eTaskTypeTipsImg = {}
eTaskTypeTipsImg[1] = '2' -- 主线
eTaskTypeTipsImg[2] = '2' -- 支线
eTaskTypeTipsImg[3] = '1' -- 日常
eTaskTypeTipsImg[4] = '1' -- 每周
eTaskTypeTipsImg[5] = '3' -- 活动
eTaskTypeTipsImg[6] = '3' -- 长期副本爬塔
eTaskTypeTipsImg[7] = '3' -- 短期副本爬塔
eTaskTypeTipsImg[8] = '3' -- 讨伐
eTaskTypeTipsImg[9] = '3' -- 剧情
eTaskTypeTipsImg[10] = '3' -- 战场
eTaskTypeTipsImg[11] = '4' -- 七天引导
eTaskTypeTipsImg[12] = '4' -- 七天引导阶段
eTaskTypeTipsImg[13] = '4' -- 每日勘探任务
eTaskTypeTipsImg[14] = '4' -- 每周勘探任务
eTaskTypeTipsImg[15] = '4' -- 每期勘探任务
eTaskTypeTipsImg[16] = '4' -- 每期引导任务阶段
eTaskTypeTipsImg[17] = '4' -- 每期引导任务
eTaskTypeTipsImg[18] = '4'
eTaskTypeTipsImg[19] = '4'
eTaskTypeTipsImg[20] = '4'
eTaskTypeTipsImg[21] = '4'
eTaskTypeTipsImg[101] = '5' -- 成就
eTaskTypeTipsImg[201] = '6' -- 徽章


eTaskTypeChName = {}
eTaskTypeChName.Main = '主线'
eTaskTypeChName.Sub = '支线'
eTaskTypeChName.Daily = '日常'
eTaskTypeChName.Weekly = '每周'
eTaskTypeChName.Activity = '活动'
eTaskTypeChName.DupTower = '长期副本爬塔'
eTaskTypeChName.TmpDupTower = '短期副本爬塔'
eTaskTypeChName.DupTaoFa = '讨伐'
eTaskTypeChName.Story = '剧情'
eTaskTypeChName.DupFight = '战场'
eTaskTypeChName.Seven = '七天引导'
eTaskTypeChName.SevenStage = '七天引导阶段'
eTaskTypeChName.DayExplore = '每日勘探任务'
eTaskTypeChName.WeekExplore = '每周勘探任务'
eTaskTypeChName.Explore = '每期勘探任务'
eTaskTypeChName.GuideStage = '每期引导任务阶段'
eTaskTypeChName.Guide = '每期引导任务'
eTaskTypeChName.Puzzle = '拼图活动任务'


-- 按阶段完成的任务
eStageTask = {
    [eTaskType.Guide] = true,
    [eTaskType.RegressionTask] = true,
}

-- 前后关联关系的任务（后边数字为接取顺序）
eTaskConnectType = {
    [eTaskType.GuideStage] = 1,
    [eTaskType.Guide] = 2,
    [eTaskType.SevenStage] = 3,
    [eTaskType.Seven] = 4
}


-- 完成任务后获得星数的奖励,星数达到一定数量就自动领取表里的奖励
-- 星数放在taskMgr.m_taskInfo.starInfo[taskType]里
-- 奖励下标放在taskMgr.m_taskInfo.starGetLog[taskType]里
-- 
eTaskStarReward = {
    [eTaskType.SONICO] = 'CfgSonicoTaskReward',
    [eTaskType.StoryCollectionAct] = 'CfgStoryCollectionActTaskReward',
}

GenEnumNameByVal('eTaskConnectTypeName', eTaskConnectType)

cTaskCfgNames = {
    [eTaskType.Main] = 'CfgTaskMain',
    [eTaskType.Sub] = 'CfgTaskSub',
    [eTaskType.Daily] = 'CfgTaskDaily',
    [eTaskType.Weekly] = 'CfgTaskWeekly',
    [eTaskType.Activity] = 'CfgTaskActivity',
    [eTaskType.DupTower] = 'CfgDupTower',
    [eTaskType.TmpDupTower] = 'CfgTmpDupTower',
    [eTaskType.DupTaoFa] = 'CfgDupTaoFa',
    [eTaskType.Story] = 'CfgDupStory',
    [eTaskType.DupFight] = 'CfgDupFight',
    [eTaskType.Seven] = 'CfgSevenDayTask',
    [eTaskType.SevenStage] = 'CfgSevenDayFinish',
    [eTaskType.DayExplore] = 'CfgTaskDayExploration',
    [eTaskType.WeekExplore] = 'CfgTaskWeekExploration',
    [eTaskType.Explore] = 'CfgTaskExploration',
    [eTaskType.Guide] = 'CfgGuideTask',
    [eTaskType.GuideStage] = 'CfgGuideFinish',
    [eTaskType.NewYearFinish] = 'CfgNewYearFinish',
    [eTaskType.NewYear] = 'CfgNewYearTask',
    [eTaskType.Regression] = 'CfgRegressionFundTask',
    [eTaskType.Rogue] = 'CfgRogueTask',
    [eTaskType.RegressionTask] = 'CfgRegressionTask',
    [eTaskType.RegressionBind] = 'CfgRegressionBind',
    [eTaskType.StarPalace] = 'CfgTotalBattleTask',
    [eTaskType.Pet] = 'CfgPetArchive',
    [eTaskType.AbattoirMoon] = 'cfgColosseumMission',
    [eTaskType.AbattoirSeason] = 'cfgColosseumSeasonMission',
    [eTaskType.Puzzle] = 'CfgTaskPuzzle',
    [eTaskType.DupLiZhan] = 'CfgDupLiZhan',
    [eTaskType.GlobalBossDay] = 'cfgWorldBossMission',
    [eTaskType.GlobalBossMonth] = 'cfgWorldBossMonthMission',
    [eTaskType.PointsBattle] = 'CfgPointsBattle',
    [eTaskType.AnniversaryMission] = 'cfgAnniversaryMission',
    [eTaskType.MultTeam] = 'CfgMultiteamEntrance',
    [eTaskType.LimitReward] = 'CfgLimitRewardTask',
    [eTaskType.LimitRewardStage] = 'CfgLimitRewardFinish',
    [eTaskType.NewPlayerSeven] = 'CfgNewPlayerSevenDayTask',
    [eTaskType.RichMan]='cfgMonopolyMission',
    [eTaskType.SONICO]='CfgSonicoTask',
    [eTaskType.EternalBattle]='cfgWarzoneMission',
    [eTaskType.SkinPass]='CfgSkinPassMission',
    [eTaskType.ChainFront]='CfgDupLianSuo',
    [eTaskType.GoldenRebate]='CfgGoldenRebateMission',
    [eTaskType.RoleTrainGuild]='CfgRoleTrainGuideTask',
    [eTaskType.StoryCollection]='CfgStoryCollectionTask',
    [eTaskType.StoryCollectionAct]='CfgStoryCollectionActTask',
    [eTaskType.CrossBoss]='CfgVirtualCataclysmEntrance',
}

-- 完成类型, GetTypeById() 计算返回 eTaskFinishType 的枚举值
eTaskFinishType = {
    GetTypeById = function(id)
        return math.floor(id / 1000)
    end
}

eTaskFinishType.Player = 10 -- 玩家
eTaskFinishType.Card = 20 -- 卡牌
eTaskFinishType.CardDelete = 21 -- 卡牌删除
eTaskFinishType.CardSkill = 22 -- 卡牌技能
eTaskFinishType.Fight = 30 -- 战斗
eTaskFinishType.Shop = 35 -- 商店
eTaskFinishType.Equip = 40 -- 装备
eTaskFinishType.Build = 45 -- 建筑
eTaskFinishType.CardCreate = 50 -- 卡牌创建
eTaskFinishType.Task = 60 -- 任务
eTaskFinishType.Army = 61 -- 军演
eTaskFinishType.Item = 65 -- 物品
eTaskFinishType.Pet = 67 -- 夏活宠物
eTaskFinishType.RichMan = 68 -- 大富翁

-- 任务状态
eTaskState = {}
eTaskState.None = 0
eTaskState.Wait = 1 -- 等待加入
eTaskState.Taking = 2 -- 进行中
eTaskState.Finish = 3 -- 完成

GenEnumNameByVal('eTaskStateName', eTaskState)

eTaskEventType = {}
eTaskEventType.None = 0
eTaskEventType.Upgrade = 1 -- 升级[参数 obj]
eTaskEventType.Break = 2 -- 突破[参数 obj]
eTaskEventType.Intensify = 3 -- 强化[参数 obj]
eTaskEventType.Cool = 4 -- 冷却[参数 obj]
eTaskEventType.PassCounterpart = 5 -- 副本通关[参数 obj]
eTaskEventType.KillMonster = 6 -- 副本通关[参数 obj]
eTaskEventType.CardCreate = 7 -- 卡牌建造[参数 建造id]
eTaskEventType.TaskFinish = 8 -- 完成任务
eTaskEventType.Win = 9 -- 胜利
eTaskEventType.Decompose = 10 -- 分解
eTaskEventType.DpStart = 11 -- 通关星级
eTaskEventType.Buy = 12 -- 购买
eTaskEventType.Exchange = 13 -- 兑换
eTaskEventType.Collect = 14 -- 收集
eTaskEventType.BuyHot = 15 -- 购买体能
eTaskEventType.Hp = 16 -- 血量
eTaskEventType.PassClass = 17 -- 副本通关卡牌阵营
eTaskEventType.Damage = 18 -- 伤害
eTaskEventType.Durability = 19 -- 耐久度
eTaskEventType.ReduceHot = 20 -- 消耗体力
eTaskEventType.ReduceItem = 21 -- 消耗物品
eTaskEventType.Score = 22 -- 分数
eTaskEventType.Remould = 23 -- 重塑
eTaskEventType.First = 24 -- 首次登录
eTaskEventType.Team = 25 -- 队伍
eTaskEventType.Skill = 26 -- 技能
eTaskEventType.Board = 27 -- 看板
eTaskEventType.PassGroup = 28 -- 通关关卡组
eTaskEventType.PetAbility = 29 -- 宠物属性变动
eTaskEventType.AbattoirStar = 30 -- 角斗场星数(重置前累计星数)
eTaskEventType.AbattoirPass = 31 -- 角斗场通关
eTaskEventType.AbattoirPassStar = 32 -- 角斗场单次通关获得星数
eTaskEventType.AbattoirTotalStar = 33 -- 角斗场赛季累计获得星数
eTaskEventType.AbattoirJoin = 34 -- 角斗场参与次数
eTaskEventType.AbattoirJoinStar = 35 -- 角斗场单次获得星数(不需要通关才算)
eTaskEventType.GlobalBossFight = 36 -- 世界boss挑战或扫荡X次（每日重置）
eTaskEventType.GlobalBossDamage = 37 -- 世界boss单次伤害达到N（每月重置）
eTaskEventType.GlobalBossKill = 38 -- 世界boss击败（每月重置）
eTaskEventType.GlobalBossTotalDamage = 39 -- 世界boss累计伤害达到N（每月重置）
eTaskEventType.RichManFinishRound = 40 -- 大富翁行走X圈
eTaskEventType.ChainFrontMaxScore = 41 -- 连锁战线最高积分
eTaskEventType.JoinSection = 42 -- 参与章节
eTaskEventType.ChargeDay = 43 -- 累计充值X元X天
eTaskEventType.DupBuild = 44 -- 副本建造
eTaskEventType.EnterRogueMap = 45 -- 进入小地图副本

eLockState = {}
eLockState.No = 0
eLockState.Yes = 1

eContinueTaskType = {}
eContinueTaskType.Seven = 1 --七日
eContinueTaskType.Guide = 2 --阶段
eContinueTaskType.NewYear = 3 --新年

-- 完成任务后自动领取奖励的任务
eAutoGainTaskType = {
    [eTaskType.Pet] = 1,
    [eTaskType.LimitRewardStage] = 1,
}

-----------------------------好友------------------------------------------------------------------------
-- 常量类型
eFriendConst = {}
-- 在加载表格的时候生成

eFriendState = {}
eFriendState.None = 0
eFriendState.Pass = 1 -- 通过的好友
eFriendState.Black = 2 -- 黑名单
eFriendState.Apply = 3 -- 申请添加(发起添加方显示的状态)
eFriendState.Waiting = 4 -- 等待通过(被添加方显示的状态)
eFriendState.Delete = 5 -- 删除
eFriendState.Deny = 6 -- 拒绝
eFriendState.ApplyCancel = 7 -- 取消申请
eFriendState.BeBlack = 8 -- 被拉黑
eFriendState.DelBlack = 9 -- 解除黑名单
eFriendState.BeDelBlack = 10 -- 被解除黑名单
eFriendState.InterBlack = 11 -- 相互拉黑(只有当被拉黑，与黑名单重叠时才出现)

GenEnumNameByVal('eFriendStateName', eFriendState)

-- 队伍下标起始值,与CfgTeamTypeEnum表中的起始下标一致
eTeamType = {
    DungeonFight = 1, -- 副本队伍列表,队伍ID是1-6
    Assistance = 20, -- 助战队伍信息，自己分享的助战卡牌列表
    PracticeAttack = 21, -- 军演练习攻击队伍
    PracticeDefine = 22, -- 军演练习防御队伍
    RealPracticeAttack = 23, -- 实时军演攻击队伍
    GuildFight = 24, -- 公会战队伍
    TeamBoss = 25, -- 组队boss队伍
    Tower=26,--异构爬塔（普通）
    TowerDifficulty=27,--异构爬塔（困难）
    Rogue = 28,  --乱序演习
    TotalBattle=29,--总力战
    Preset = 30, -- 队伍预设索引起始值，从30开始到36
    RogueS = 50, --战力派遣 (50-59)
    Colosseum = 60, --角斗场(60-61) 60:自选模式 61：随机模式
    PVP = 62,       -- 实时自由匹配军演攻击队伍 62,63,64
    PVPFriend = 65, -- 好友实时军演攻击队伍 65, 66, 67
    RogueT = 70,    --限制版爬塔 70-89 
    MultBattle=90,--多队战斗
    PVP3 = 91,       -- 实时自由匹配军演攻击队伍 91,92,93
    PVPFriend3 = 94, -- 好友实时军演攻击队伍 94, 95, 96
    TowerDeep = 96, -- 新爬塔  96-100
    ChainFront = 101, -- 历战试炼-连锁战线  101-105
    EternalBattle = 106, -- 永境战域 106
    SkinPass = 107, -- 皮肤通行证 107
    PeriodBoss = 109, -- 周期BOSS 109
    CrossBoss = 110, -- 虚数天灾110-114

    ForceFight = 10000 -- 强制上阵索引起始值
}

eCardMainType = {}
eCardMainType.QN = 1 -- 全能
eCardMainType.TH = 2 -- 特化
eCardMainType.TT = 3 -- 同调
eCardMainType.TS = 4 -- 特殊
eCardMainType.ZY = 5 -- 支援

-- 队伍下标
AssistanceRowIndex = {}
AssistanceRowIndex[eCardMainType.QN] = eCardMainType.QN
AssistanceRowIndex[eCardMainType.TH] = eCardMainType.TH
AssistanceRowIndex[eCardMainType.TT] = eCardMainType.TT
AssistanceRowIndex[eCardMainType.TS] = eCardMainType.TS

eRegisterLen = {}
eRegisterLen.AccMin = 3
eRegisterLen.AccMax = 12
eRegisterLen.PwdMin = 6
eRegisterLen.PwdMax = 16

-- 奖励标随机类型
RewardRandomType = {}
RewardRandomType.FIXED = 1 -- 全部
RewardRandomType.RANDOM_PERCENT = 2 -- 概率产出[会产出多个，10000 为满概率必定掉落]
RewardRandomType.RANDOM_WEIGHT = 3 -- 多个物品按权重产出其中一个
RewardRandomType.SINGLE_SELECT = 4 -- 单选择类型
RewardRandomType.RANDOM_MULTI = 5 -- 随机多个， 根据品质决定掉落几个
RewardRandomType.RANDOM_PLR_NOT_GET = 6 -- 还未获得的随机一个
RewardRandomType.RANDOM_HALF_WEIGHT = 7 -- 半概率(自选卡池用，n个id占总概率的一半，其余平分概率)
RewardRandomType.RANDOM_MULTIPLE_WEIGHT = 8 -- 倍概率(自选卡池用，每N抽不出，特定的概率会翻倍)

-- 跳转模块状态类型
JumpModuleState = {
    Normal = 1, -- 正常
    Lock = 2, -- 未解锁
    Close = 3 -- 未开放
}

-- 卡牌品质
CardQuality = {
    N = 1,
    NH = 2,
    R = 3,
    SR = 4,
    SSR = 5,
    UR = 6
}

-- 卡牌品质
RoleQualityStr = {'★', '★★', '★★★', '★★★★', '★★★★★', '★★★★★★'}

-- 卡牌品质对应物品框
CardFrame = {}
CardFrame[CardQuality.SSR] = 'frame_5'
CardFrame[CardQuality.SR] = 'frame_4'
CardFrame[CardQuality.R] = 'frame_3'
CardFrame[CardQuality.N] = 'frame_1'

RealArmyType = {}
RealArmyType.Friend = 1
RealArmyType.Freedom = 2
RealArmyType.Limit = 3
RealArmyType.Mirror = 4     -- 演习
RealArmyType.Matrix = 5     -- 基地突袭
RealArmyType.WorldBoss = 6  -- 世界boss
RealArmyType.GuildFight = 7 -- 工会战
RealArmyType.TeamBoss = 8   -- 组队boss

GenEnumNameByVal('RealArmyTypeName', RealArmyType)

-- 装备技能类型
EquipSkillType = {}
EquipSkillType.Property = 1 -- 属性技能
EquipSkillType.Fight = 2 -- 战斗技能
EquipSkillType.LifeBuf = 3 -- 生活buff

-- 装备位置类型
EquipSlotType = {}
EquipSlotType.Top = 1
EquipSlotType.Left = 2
EquipSlotType.Center = 3
EquipSlotType.Right = 4
EquipSlotType.Bottom = 5

-- 装备盘开启设置类型
EquipCoreSetting = {}
EquipCoreSetting.Role = 1 -- 角色面板
EquipCoreSetting.Search = 2 -- 查看角色面板
EquipCoreSetting.Select = 3 -- 选择装备面板

-- 卡牌皮肤类型
CardSkinType = {}
CardSkinType.Break = 1 -- 突破皮肤
CardSkinType.Skin = 2 -- 额外
--CardSkinType.Add = 3 -- 新增
--CardSkinType.JieJin = 3 -- 解禁

-- 技能类型
SkillMainType = {}
SkillMainType.CardNormal    = 1 -- 卡牌一般技能
SkillMainType.CardTalent    = 2 -- 卡牌天赋技能
SkillMainType.CardSpecial   = 3 -- 卡牌特殊技能
SkillMainType.CardSubTalent = 4 -- 卡牌副天赋技能
SkillMainType.Equip         = 5 -- 装备技能
SkillMainType.Other         = 6 -- 其他技能
SkillMainType.Weapon        = 7 -- 专武技能

-- 特殊技能分类
SpecialSkillType = {}
SpecialSkillType.Fit = 1 -- 合体
SpecialSkillType.Summon = 2 -- 召唤
SpecialSkillType.Trans = 3 -- 形态转换

-- 角色好感度类型
CardRoleFriendExpType = {}
CardRoleFriendExpType.SetPanle = 1 -- 设置看板
CardRoleFriendExpType.Fight = 2 -- 参与战斗
CardRoleFriendExpType.InPhyRoom = 3 -- 放在心理咨询室

-- 建造分类
CreateType = {
    finish = 1,
    building = 2,
    waiting = 3
}

-- 卡牌分类
RoleCardType = {
    card = 1, -- 战斗卡
    fodder = 2, -- 素材
    store = 100 -- 存储经验
}

-- 能力分类
AbilityType = {
    SkillGroup = 1, -- 技能组
    PlrProperty = 2, -- 玩家属性
    BuildOpen = 3 -- 建筑开启(新功能建筑)
}

-- 奖励活动类型
RewardActivityType = {
    DateDay = 1, -- 月份日期类型
    DateMonth = 2, -- 天数日期类型
    Continuous = 3 -- 连续类型
}

-- 副本条件类型（副本）
DungeonStarType = {
    Pass = 1, -- 通关
    KillMonster = 2, -- 击杀怪物
    KillElite = 3, -- 击杀精英怪
    KillNum = 4, -- 击杀总数量
    MoveNum = 5, -- 移动次数
    BoxNum = 6, -- 宝箱数量
    KillMonsterNum = 7, -- 击杀怪物数量，不含精英怪
    DeathNum = 8, -- 角色死亡数量不大于X个（单局）
    TeamNum = 9 -- 通关队伍（单局）
}

-- 副本条件类型（直接战斗）
FightStarType = {
    Pass = 1, -- 通关
    DeathNum = 2, -- 角色死亡数量不大于X个
    RoundNum = 3, -- 回合数
    HPPricent = 4, -- 血量比
    Support = 5 -- 助战
}

-- 副本条件类型（战力派遣）
RogueSStarType = {
    Pass = 1,           -- 通关
    DeathNum = 2,       -- 角色死亡数量不大于X个（0就是全部存活）
    Steps = 3,          -- 总操作数
    RoundAllAlive = 4,  -- 第X轮通关时所有角色全部存活
    KillMonster = 5,    -- 击败某个角色
}

-- 副天赋格子开启类型
SubTalentOpenType = {}
SubTalentOpenType.Break = 1 -- 突破
SubTalentOpenType.UseItem = 2 -- 使用物品

-- 活动中分类
ActivityType = {
    SignIn = 1, -- 签到
    SDK = 2, -- sdk
    Integral = 3, -- 积分
    Rank = 4 -- 排名
}

-- 活动列表分类,对应活动列表id
ActivityListType = {
    SignIn = 1001,
    SignInContinue = 1002,
    MissionContinue = 1003,
    Investment = 1004,
    NewYearContinue = 1005, --新年阶段任务
    NewYearSignIn = 1006, --新年签到
    SignInCommon = 1007, --通用签到
    SignInShadowSpider = 1008, --迷城蛛影签到
    DropAdd= 1009, --多倍掉落活动
    AdvBindUsersView = 2001, --引导游客绑定账号
    Exchange = 1010, --兑换活动
    SignInGold = 1013, --2.0签到
    AccuCharge = 1011, --累计充值
    SignInZhongQiu = 1014,--中秋签到
    SignInGift = 1015,--付费签到
    SignInNational = 1016,--国庆签到
    GachaBall=1017,--扭蛋活动
    AccuCharge2 = 1022, --累计充值2
    AccuCharge3 = 1023, --累计充值3
    Collaboration=1012,--回归绑定
    SkinRebate = 3000, --皮肤返利
    SignInDuanWu = 1029, --端午签到
	AdvBindUsers =2001, --引导游客绑定账号（代码整合后必须新增）
    SignInAnniversary = 1030, --1.5周年
    MissionLimit = 1032,--限量任务
    LovePlus = 1033,--爱相随
    Halloween = 1035,--万圣节活动
    PhysicalReward = 1038,--实物抽奖活动
    NewPlayerSeven = 1039, -- 新手七日任务
    SkinDeals=1044,--皮肤折扣券
    SkinPass=1045,--皮肤通行证
    SkinRabate2 = 1047, --皮肤返利2
    StoryActive = 4000,--故事集活动
}

ALType = {}
ALType.Pay = 1 --付费
ALType.SignIn = 2 --签到

SkinRebateType = {}
SkinRebateType.Normal = 1 --常规
SkinRebateType.Lock = 2 --上锁
SkinRebateType.Red = 3 --红点
SkinRebateType.LimitTime = 4 --限时

-- 剧情站位
PlotAlign = {
    Left = 1, -- 左
    Center = 2,
    -- 中
    Right = 3
    -- 右
}

-- 剧情立绘动画类型
PlotImgTweenType = {
    -- 无
    None = 1,
    -- 淡入淡出
    Fade = 2,
    -- 移动
    Move = 3,
    -- 切割图片
    SplitImg = 4,
    -- 移动和渐变
    MoveAndFade = 5,
}

-- 剧情类型
PlotType = {
    Normal = 1,
    -- 普通类型的剧情
    Simple = 2
    -- 简洁类型的播放方式
}

-- 战斗自动寻路设置目标类型
FightNaviObjType = {
    Team1 = 1, -- 队伍1的战斗策略
    Team2 = 2, -- 队伍2的战斗策略
    Attack = 3, -- 通关战斗策略
    Get = 4 -- 拾取策略
}

CharacterImgShader = {
    -- 角色立绘混合shader
    BlendFace = 'UI/Simple Layer Blendv3', -- 表情混合shader
    HoloEffect = 'UI/HoloEffectLayerBlendv2'
    -- 全息表情混合shader
}

-- 纯色背景图
PlotColorImg = {
    Red = {
        type = 'red',
        color = {255, 0, 0, 255}
    },
    Black = {
        type = 'black',
        color = {0, 0, 0, 255}
    },
    White = {
        type = 'white',
        color = {255, 255, 255, 255}
    }
}

-- 图片切换枚举类
ImgChangeType = {
    None = 0,
    -- 无
    Fade = 1,
    -- 渐入渐出
    Line = 2
    -- 条形切换
}

--------------------------------------------------------------
-- 后台刷新类型
BackstageFlushType = {
    Board = 1, -- 公告
    ActiveSkip = 2, -- 活动跳转
    ServerState = 3 -- 服务器状态
}

--------------------------------------------------------------
-- 建筑分类
BuildsClassify = {}
BuildsClassify.Production = 1 -- 生产
BuildsClassify.Lift = 2 -- 生活
BuildsClassify.Defence = 3 -- 防御
BuildsClassify.Other = 4 -- 其它

-- 建筑类型
BuildsType = {}
BuildsType.ControlTower = 1 -- 指挥塔
BuildsType.PowerHouse = 2 -- 发电厂
BuildsType.ProductionCenter = 3 -- 生产中心(制造中心)
BuildsType.TradingCenter = 4 -- 交易中心（订单中心）
BuildsType.Expedition = 5 -- 远征
BuildsType.Compound = 6 -- 合成工厂
BuildsType.Attack = 7 -- 攻击设备
BuildsType.Defence = 8 -- 防御设备
BuildsType.Remould = 9 -- 改造工厂
BuildsType.Entry = 10 -- 入口建筑（宿舍）
BuildsType.PhyRoom = 11 -- 心理咨询室

-- 开启类型
BuildOpenType = {}
BuildOpenType.PlrLevel = 1 -- 玩家等级
BuildOpenType.ControlTowerLevel = 2 -- 控制塔等级
BuildOpenType.PlrAbility = 3 -- 能力 由玩家配置表中的CfgPlrAbility配置开启

-- 建筑护甲
BuildArmorType = {}
BuildArmorType.L1 = 1 -- 无甲
BuildArmorType.L2 = 2 -- 轻甲
BuildArmorType.L3 = 3 -- 中甲
BuildArmorType.L4 = 4 -- 重甲
BuildArmorType.L5 = 5 -- 城甲

-- 角色能力类型
RoleAbilityType = {}
RoleAbilityType.Controler = 1 -- 指挥者
RoleAbilityType.Leaderer = 2 -- 领导者
RoleAbilityType.Labor = 3 -- 专员
RoleAbilityType.Quality = 4 -- 质检员
RoleAbilityType.Cost = 5 -- 成本
RoleAbilityType.Explorer = 6 -- 探索员
RoleAbilityType.Scientist = 7 -- 科学家 --not use
RoleAbilityType.Fighter = 8 -- 战斗员
RoleAbilityType.Engineer = 9 -- 工程师
RoleAbilityType.Artisan = 10 -- 技术员
RoleAbilityType.Traders = 11 -- 交易员
RoleAbilityType.OptimizeTraders = 12 -- 优化专员
RoleAbilityType.Seller = 13 -- 销售员
RoleAbilityType.PowerOpt = 14 -- 能源优化师
RoleAbilityType.CombineWorker = 15 -- 合成工人
RoleAbilityType.DeepExplorer = 16 -- 深度探索员
RoleAbilityType.ExplorLeader = 17 -- 探索队长
RoleAbilityType.Adventurer = 18 -- 冒险家
RoleAbilityType.SpacePirate = 19 -- 宇宙海盗
RoleAbilityType.ActiveSeller = 20 -- 积极销售员，除自身外，根据入驻人员增加订单数，但是其他角色能力不生效，也不扣除疲劳
RoleAbilityType.AloneSeller = 21 -- 独行销售员， 增加入驻上限 - 入驻人员数量 的订单数，不包括自己
RoleAbilityType.BuySeller = 22 -- 采购员
RoleAbilityType.SupperItemer = 23 -- 高级物料员
RoleAbilityType.Pacifyer = 24 -- 安抚精英
RoleAbilityType.Eluder = 25 -- 避难专员
RoleAbilityType.PartDev = 26 -- 研发专注
RoleAbilityType.OptimizeDev = 27 -- 研发提升
RoleAbilityType.FightCmder = 28 -- 战斗指挥员
RoleAbilityType.ProductAdder = 29 -- 产能增长
RoleAbilityType.Storer = 30 -- 仓管员
RoleAbilityType.Troubler = 31 -- 麻烦制造者
RoleAbilityType.Unityer = 32 -- 团结员
RoleAbilityType.UpQuality = 33 -- 质检专家
RoleAbilityType.CombineGift = 34 -- 合成额外奖励能力

-- 建筑预警级别
BuildWarningLv = {}
BuildWarningLv.L1 = 1 -- 回避
BuildWarningLv.L2 = 2 -- 蓝色
BuildWarningLv.L3 = 3 -- 黄色
BuildWarningLv.L4 = 4 -- 红色

--------------------------------------------------------------------------------------------------------------------
-- 心理咨询师

-- 小游戏类型
PhyMinGameTypes = {}
PhyMinGameTypes.Hypnosis = 1 -- 催眠

-- PveDupId
PveDupId = {}
PveDupId.Build = 1 -- 建筑pve

-- 通用格子品质框图片名称
GridFrame = {'btn_1_01', 'btn_1_02', 'btn_1_03', 'btn_1_04', 'btn_1_05', 'btn_1_09'}

EquipQualityFrame = {'btn_12_01', 'btn_12_02', 'btn_12_03', 'btn_12_04', 'btn_12_05'}

EquipQualityColor = {'FFFFFF', '75FEA9', '61EBFF', 'FF8DF3', 'FFDD66'}

TeamSeletFrame = {'img_01_01', 'img_01_02', 'img_01_03', 'img_01_04', 'img_01_05', 'img_01_06'}

-- 出战队伍界面的OpenSetting枚举
TeamConfirmOpenType = {}
TeamConfirmOpenType.Dungeon = 1 -- 副本
TeamConfirmOpenType.Matrix = 2 -- 基地
TeamConfirmOpenType.FieldBoss = 3 -- 战场boss
TeamConfirmOpenType.Tower=4 --塔本
TeamConfirmOpenType.Rogue=5 --
TeamConfirmOpenType.TotalBattle =6 --十二星宫
TeamConfirmOpenType.GlobalBoss = 7 --世界boss
TeamConfirmOpenType.RogueT = 8 -- 能力测验
TeamConfirmOpenType.BuffBattle = 9 -- 积分战斗
TeamConfirmOpenType.RogueMap = 10 -- 秘境探索
TeamConfirmOpenType.MultTeamBattle= 11 --递归沙盒
TeamConfirmOpenType.RogueMapAssist = 12 -- 秘境探索支援
TeamConfirmOpenType.Trials = 13 --历战（显示支援技能）
TeamConfirmOpenType.PeriodicBoss = 14 -- 周期boss
TeamConfirmOpenType.VirCat = 16 -- 虚数天灾

-- 商店商品的展示方式
ShopShowType = {}
ShopShowType.Normal = 1
ShopShowType.Package = 2
ShopShowType.MonthCard = 3
ShopShowType.Card = 4
ShopShowType.Pay = 5
ShopShowType.Skin = 6
ShopShowType.Atlas=7   --图册
ShopShowType.Dorm=8    --家具
ShopShowType.LovePlus=9 --爱相随

-- 商品类型
CommodityType = {}
CommodityType.Normal = 1 -- 普通
CommodityType.Rand = 2 -- 随机
CommodityType.Promote = 3 -- 推荐

-- 商品道具类型
CommodityItemType = {}
CommodityItemType.Item = 1 -- 道具
CommodityItemType.Package = 2 -- 礼包
CommodityItemType.Skin = 3 -- 皮肤
CommodityItemType.Deposit = 4 -- 充值
CommodityItemType.MonthCard = 5 -- 月卡
CommodityItemType.THEME = 6 -- 宿舍主题
CommodityItemType.FORNITURE = 7 -- 宿舍家具
CommodityItemType.Exploration = 8 -- 勘探
CommodityItemType.Regression = 9 -- 回归基金
CommodityItemType.SingleSelection = 10 -- 单自选
CommodityItemType.DoubleSelection = 11 -- 双自选
CommodityItemType.SUIT = 12 -- 套装
CommodityItemType.ChoiceCard = 13 -- 自选卡牌(获得物品不读，由服务端特殊处理)
CommodityItemType.ActivityRewards = 14 -- 回归活跃返利
CommodityItemType.SkinPass = 15 -- 皮肤通行证
CommodityItemType.RoleTrainGuide = 16 -- 角色培养引导 -- v 5.6 角色培养引导


--商品子类型
CommodityItemSubType={}
CommodityItemSubType.MonthCard=1;--月卡
CommodityItemSubType.MonthCard2=2;--限时月卡

-- 商品道具品质背景图
CommodityQuality = {'white.png', 'green.png', 'blue.png', 'purple.png', 'yellow.png'}
-- 商品下方颜色码
CommodityCostColor = {'7f7f7f', '18c13b', '14c3c4', 'a259e2', 'daa71d'}

-- 商店固定刷新时间类型
ShopFixedUpdateType = {
    None = 0,
    Day = 1,
    Week = 2,
    Month = 3
}

--------------------编队
-- 占位类型
FormationType = {}
FormationType.Single = 0 -- 占用单格
FormationType.HDouble = 11 -- 横向占用两格
FormationType.VDouble = 7 -- 纵向占用两格
FormationType.Square = 10 -- 占用四格
FormationType.HThree = 9 -- 横向占用三格
FormationType.Summon = 6 -- 召唤位
FormationType.VThree = 8 -- 纵向占用三格
FormationType.Nine = 12 -- 占9格
FormationType.VDThree = 13 -- 纵向占用2*3

-----------------通用提示的所属模块类型
TipsFunType = {}
TipsFunType.Login = 1
-- 登录模块
-----------------账号类型
AccType = {}
AccType.Plr = 1 -- 玩家
AccType.Guest = 2 -- 访客

GenEnumNameByVal('AccTypeName', AccType)

-------------------背包开启时默认索引
BagOpenSetting = {}
BagOpenSetting.Material = 1 -- 普通素材页
BagOpenSetting.Equipped = 2 -- 普通装备页
BagOpenSetting.EquippedMaterial = 3 -- 素材装备页
BagOpenSetting.Props = 4 -- 消耗道具

-----------------背包基础类型
BagType = {}
BagType.Material = 1 -- 素材
BagType.Equipped = 2 -- 装备

-------------------素材背包类型
MaterialBagType = {}
MaterialBagType.Normal = 1
-- 正常
------------------装备背包类型
EquipBagType = {}
EquipBagType.Normal = 1 -- 正常开启
EquipBagType.Sell = 2 -- 出售装备
EquipBagType.Remould = 3 -- 选择合成素材
EquipBagType.Strength = 4 -- 选择强化素材
EquipBagType.Lock = 5 -- 选择加锁装备

-----------------筛选类型
ScreenType = {}
ScreenType.Role = 1 -- 角色
ScreenType.Equip = 2 -- 装备
ScreenType.EquipNoSlot = 3 -- 装备筛选，但是不包含位置选项
ScreenType.Material = 4 -- 素材

-----------------装备类型
EquipType = {}
EquipType.Normal = 1 -- 1: 普通装备
EquipType.Material = 2 -- 2: 素材装备

-----------------道具页签类型
GoodsType = {   
    Normal = 1, -- 普通素材
    Prop = 2 -- 消耗品
}

-----------------队员选择界面状态
TeamSelectType = {}
TeamSelectType.Normal = 1 -- 普通队员
TeamSelectType.Support = 2 -- 助战卡牌
TeamSelectType.Force = 3 -- 强制队员

----------------队伍界面打开方式
TeamOpenSetting = {}
TeamOpenSetting.Normal = 1 -- 正常打开
TeamOpenSetting.PVE = 2 -- pve编队
TeamOpenSetting.PVP = 3 -- pvp编队 (自由匹配，好友匹配)
TeamOpenSetting.Tower = 4 --爬塔编成
TeamOpenSetting.Rogue = 5 --肉鸽
TeamOpenSetting.TotalBattle=6--总力战
TeamOpenSetting.RogueS = 7 --战力派遣
TeamOpenSetting.Colosseum = 8 --角斗场
TeamOpenSetting.GlobalBoss= 9 --世界boss
TeamOpenSetting.RogueT= 10 --限制版爬塔
TeamOpenSetting.MultBattle= 11 --多队战斗
TeamOpenSetting.PVPMirror= 12 --演习
TeamOpenSetting.TowerDeep = 13 --深塔计划
TeamOpenSetting.PVP3 = 14 -- pvp编队 (自由匹配，好友匹配)
TeamOpenSetting.Trials2 = 15 --连锁阵线
TeamOpenSetting.SkinPass = 16 --皮肤通行证
TeamOpenSetting.PeriodicBoss = 17 --周期boss
TeamOpenSetting.VirCat = 18 --虚数天灾
-----------------聊天类型
ChatType = {}
ChatType.World = 1 -- 世界
ChatType.Notice = 2 -- 系统
ChatType.Guild = 3 -- 工会
ChatType.Team = 4 -- 组队
ChatType.Friend = 5 -- 好友 ( 单独在好友系统处理  )
ChatType.PVP = 6 -- 实时战斗 (同一个服务器，实时发送给对方不用保存)

GenEnumNameByVal('ChatTypeName', ChatType)

-- 工会批准类型
GuildRatifyType = {}
GuildRatifyType.Auto = 1 -- 自动
GuildRatifyType.Apply = 2 -- 申请

-- 工会活动类型
GuildActivityType = {}
GuildActivityType.Active = 1 -- 活跃
GuildActivityType.Lazy = 2 -- 休闲

-- 工会职位
GuildMemberType = {}
GuildMemberType.Boss = 1 -- 会长
GuildMemberType.SubBoss = 2 -- 副会长
GuildMemberType.Normal = 3 -- 一般

-- 卡牌冷却材料类型
CardCoolMaterialType = {}
CardCoolMaterialType.Num = 1 -- 数值型材料
CardCoolMaterialType.Per = 2 -- 百分比材料

-- 角色界面音效类型
RoleAudioType = {}
RoleAudioType.CrossCore = 1 -- 游戏开始（标题时语音）
RoleAudioType.get = 2 -- 获得（获得该角色时的语音）
RoleAudioType.enterLevel = 3 -- 出击（进入关卡时，队长播放的语音）
RoleAudioType.upgrade = 4 -- 强化（强化角色时的语音）
RoleAudioType.perBreak = 5 -- 突破（角色突破时的语音）
RoleAudioType.maxBreak = 6 -- 最终突破（角色最终突破的语音）
RoleAudioType.login = 7 -- 看板（登录游戏时，看板的语音）
RoleAudioType.mvp = 8 -- 战斗胜利时，MVP角色的语音
RoleAudioType.fail = 9 -- 战斗失败时，角色的语音
RoleAudioType.touch = 10 -- 接触时的语音
RoleAudioType.sprecialTouch = 11 -- 特殊部位的接触语音
RoleAudioType.levelBack = 12 -- 归来
RoleAudioType.expeditionBack = 13 -- 远征归来
RoleAudioType.allocation = 14 -- 配置设施
RoleAudioType.allocationTouch = 15 -- 设施接触
RoleAudioType.birthday = 16 -- 角色生日时
RoleAudioType.shop = 17 -- 商店语音（在商店界面，点击看板时的语音）
RoleAudioType.shopGet = 18

-- 全局邀请类型
InviteTypes = {}
InviteTypes.pvp = 'Tips/InviteTips'
InviteTypes.teamBoss = 'Tips/TeamBossInviteTips'

-- 工会战，房间类型
GFRoomType = {}
GFRoomType.SinglePlr = 1 -- 单人类型
GFRoomType.MultiPlr = 2 -- 多人类型

-- 装备的数据缓存key
EquipViewKey = {
    Strength = 1, -- 强化
    Replace = 2, -- 替换
    Bag = 3, -- 背包中
    Sell = 4, -- 出售
    Remould = 5,
    SuitSelect = 6 -- 套装选择
}

-- TeamConfirmItem的状态
TeamConfirmItemState = {
    Normal = 1, -- 普通
    Disable = 2, -- 无法使用
    UnUse = 3, -- 未使用
    UnAssist = 4 -- 无支援
}

-- 关卡详细信息界面类型
DungeonDetailsType = {
    MainLineOutPut = 1, -- 主线掉落
    Enemy = 2, -- 敌人
    Map = 3, -- 地图
    OtherOutPut = 4 -- 其他掉落
}

-- 工会战，房间困难类型
GuildFightRoomDifficultyType = {}
GuildFightRoomDifficultyType.NORMAL = 1
GuildFightRoomDifficultyType.HARD = 2
GuildFightRoomDifficultyType.VERY_HARD = 3
GuildFightRoomDifficultyType.EXTREME = 4
GuildFightRoomDifficultyType.EXTREME_ADD = 5
GuildFightRoomDifficultyType.HELL90 = 6
GuildFightRoomDifficultyType.HELL100 = 7

-- 公会战斗记录类型
GuildLogType = {}
GuildLogType.SelfFightLog = 1 -- 个人战斗记录
GuildLogType.GuildFightLog = 2 -- 公会战斗记录

-- 公会战排名类型
GuildRankType = {
    GuildGobalRank = 1, -- 公会全局排名
    GuildGroupRank = 2, -- 公会分组排名
    MemberGuildRank = 3, -- 公会内玩家排名
    MemberGobalRank = 4 -- 玩家全局排名
}

GuildFightLogTbName = {}
GuildFightLogTbName.room = 'guild_fight_room_log'
GuildFightLogTbName.guild = 'guild_fight_guild_log'

-- 公会战主界面开启类型
GuildFightMainOpenType = {
    None = 1,
    RoomListOpen = 2, -- 房间列表（创建）
    RoomListBattle = 3, -- 房间列表（战场）
    RankList = 4,
    RankScore = 5
}

-- 远征类型
ExpeditionType = {}
ExpeditionType.Normal = 1 -- 普通
ExpeditionType.Deep = 2 -- 深度
ExpeditionType.Danger = 3 -- 危险
ExpeditionType.Night = 3 -- 夜间

-- 远征队伍限制
ExpeditionTeamLimit = {}
ExpeditionTeamLimit.Lv = 1 -- 队伍成员等级限制
ExpeditionTeamLimit.Num = 2 -- 队伍成员数量限制
ExpeditionTeamLimit.Class = 3 -- 队伍成员类型限制

-- 组队boss
TeamBossRoomState = {}
TeamBossRoomState.Wait = 1
TeamBossRoomState.Fighting = 2
TeamBossRoomState.Win = 3
TeamBossRoomState.Lost = 4

TeamBossTeamState = {}
TeamBossTeamState.Join = 1 -- 加入等待状态
TeamBossTeamState.Prepare = 2 -- 准备状态
TeamBossTeamState.Start = 3 -- 战斗状态
TeamBossTeamState.Finish = 4 -- 结束状态

CardSkillUpType = {}
CardSkillUpType.A = 1
CardSkillUpType.B = 2
CardSkillUpType.C = 3
CardSkillUpType.OverLoad = 4 -- overload
CardSkillUpType.CallSkill = 8 

-- 统计日志保存间隔
MongoDbLogSaveDiff = {}
MongoDbLogSaveDiff.Min = 60 * 5
MongoDbLogSaveDiff.Max = 60 * 15

-- 服务器列表，服务器状态
ServerListState = {}
ServerListState.Normal = 1 -- 良好
ServerListState.Maintentance = 2 -- 维护
ServerListState.Busy = 3 -- 繁忙
ServerListState.HotFull = 4 -- 火爆

-- 渠道ID
ChannelType = {}
ChannelType.Normal = 0 -- 官服
ChannelType.BliBli = 1 -- B站
ChannelType.TapTap = 2 -- taptap
ChannelType.QOO = 3 -- QOO
ChannelType.Test = 4 -- 测试人员，内部使用
ChannelType.All = 5 -- 兑换码使用不限制平台
ChannelType.ZiLong = 6 -- 紫龙-台湾
ChannelType.ZiLongKR = 7 -- 紫龙-韩国
ChannelType.ZiLongJP = 8 -- 紫龙-日本
ChannelType.Harmony = 9  -- 华为鸿蒙
ChannelType.QQ = 10      -- QQ
ChannelType.WeChat = 11  -- WeChat
ChannelType.English = 12  -- 英文
ChannelType.Russia = 13  -- 俄文

GenEnumNameByVal('ChannelTypeName', ChannelType)

-- 服务器登陆状态
SvrLoginState = {}
SvrLoginState.Normal = 0       -- 正常
SvrLoginState.JustRegister = 1 -- 仅注册
SvrLoginState.Close = 2        -- 关闭状态
SvrLoginState.InWihte = 3      -- 内部白名状态

-- 宿舍主题类型
ThemeType = {}
ThemeType.Sys = 1 -- 系统
ThemeType.Save = 2 -- 保存
ThemeType.Store = 3 -- 收藏
ThemeType.Share = 4 -- 分享

-- 玩家混合存储下标
PlrMixIx = {}
PlrMixIx.dupEntryCnt = 1
PlrMixIx.dupWinCnt = 2
PlrMixIx.armyRank = 3
PlrMixIx.armyRankLv = 4
PlrMixIx.armyFightCnt = 5
PlrMixIx.armyWinCnt = 6
PlrMixIx.armyPreWinCnt = 7
PlrMixIx.armyContinueWinCnt = 8
PlrMixIx.armyMaxContinueWinCnt = 9
PlrMixIx.guildId = 10
PlrMixIx.realTimeArmyInfo = 11
PlrMixIx.card_max_perf = 12
PlrMixIx.lifeBuff = 13
PlrMixIx.taoFaCount = 14 -- taoFaCount
PlrMixIx.taoFaCountResetTime = 15 -- taoFaCountResetTime
PlrMixIx.icon_id = 16
PlrMixIx.pan_bg_img = 17
PlrMixIx.had_init = 18
PlrMixIx.devecie = 19
PlrMixIx.actZeroDay = 20
PlrMixIx.isCanRename = 21
PlrMixIx.mem_rewards = 22
PlrMixIx.orignSvrId = 23
PlrMixIx.dupWin = 24
PlrMixIx.equipLogs = 25
PlrMixIx.isUseCommon = 26
PlrMixIx.birth = 27
PlrMixIx.selCardIx = 28
PlrMixIx.selCardVId = 29
PlrMixIx.icon_id_grid = 30
PlrMixIx.rewardMustUseCnt = 31
PlrMixIx.cardInfo = 32 -- 如果重新启用重命名，或者增加，需要移出去
PlrMixIx.hadGetSectionReward = 33      -- 章节任务奖励领取 -- v 6.0 章节奖励
PlrMixIx.notUse34 = 34      -- 弃用，可以重新改名使用
PlrMixIx.createTime = 35 -- 用户创建时间
PlrMixIx.remouldCount = 36 -- 存储改造芯片次数
PlrMixIx.equipInfo = 37
PlrMixIx.friendDelCnt = 38
PlrMixIx.friendApplyCnt = 39
PlrMixIx.friendAssitCnt = 40 -- 弃用
PlrMixIx.teamCount = 41
PlrMixIx.rewardNotUseCnt = 42 -- 掉落不使用
PlrMixIx.tHot = 43 -- 玩家体能恢复累计
PlrMixIx.hotBuyCnt = 44
PlrMixIx.exchangeCodeCnt = 45 -- 兑换次数统计
PlrMixIx.panel_id = 46
PlrMixIx.armyEndTime = 47
PlrMixIx.taoFaCountBuyCnt = 48 -- taoFaCountBuyCnt
PlrMixIx.modHotLastTime = 49 -- 特殊掉落的最后活动时间
PlrMixIx.modHot = 50 -- 特殊掉落的活动时间内累计消耗的体力值
PlrMixIx.fixTmpDupTowerBug = 51 -- 爬塔新任务记录异常
PlrMixIx.icon_frame = 52 -- 头像框
PlrMixIx.arachnid_count = 53 -- 购买蛛影迷城入场券
PlrMixIx.tSetName = 54 -- 设置名字时间，首次
PlrMixIx.newTowerInfo = 55 -- 重置新爬塔的时间
PlrMixIx.returningPlr = 56 -- 回归玩家配置信息
PlrMixIx.role_panel_id = 57 -- 最后设置的角色看板ID
PlrMixIx.badged = 58 -- 徽章
PlrMixIx.specialDrops = 59 -- 特殊掉落
PlrMixIx.background_id = 60 -- 背景ID
PlrMixIx.starPalace = 61 -- 十二星宫进度
PlrMixIx.newPanelInfo = 62 -- 新看板信息
PlrMixIx.openConditionTime = 63 -- 新手教程的完成时间
PlrMixIx.BugFixIndex = 64 -- 已修复Bug下标，对应下标的方法只会运行一次
PlrMixIx.icon_title = 65 -- 玩家称号
PlrMixIx.globalBossUUID = 66 -- 当前挑战的世界bossUUID
PlrMixIx.resetDoubleRechargeTime = 67 -- 重置双倍首充的时间
PlrMixIx.bindPlrType = 68 -- 回归绑定活动，绑定时玩家的回归类型
PlrMixIx.actZeroMonth = 69 -- 下个月1号凌晨3点，重置时间
PlrMixIx.limitedTimeSkins = 70 -- 限时皮肤
PlrMixIx.sectionMultiInfo = 71 -- 有时效双倍掉落
PlrMixIx.icon_emotes = 72 -- 竞技场对战表情
PlrMixIx.changeId = 73 -- 物品变动的日志Id
PlrMixIx.equipRefresh = 74 -- 装备洗练结果数据
PlrMixIx.multTeam = 75 -- 多队玩法活动数据
PlrMixIx.maidCoffee = 76 -- 女仆咖啡活动数据
PlrMixIx.levelBreakTicket = 77 -- 每日门票发放
PlrMixIx.armyLive2d = 78 -- 军演看板是否动态
PlrMixIx.ChristmasGift = 79 -- 圣诞签到活动
PlrMixIx.smallPay = 80 -- 小额付费
PlrMixIx.breakfast = 81 -- 早餐卡
PlrMixIx.skinInfos = 82 -- 已有的皮肤信息
PlrMixIx.GoldenRebate = 83 -- v5.4 连续累充
PlrMixIx.MainUIThemeId = 84 -- v5.6 主界面UI当前主题id
PlrMixIx.EternalBattleInfo = 85 -- 永境战域周重置时间
PlrMixIx.fixTaskInitPackV1 = 86 -- 日服任务初始化修复包执行标记
PlrMixIx.fixTaskInitPackV2 = 87 -- 日服任务初始化修复包V2执行标记
PlrMixIx.BugFixIndex2 = 88 -- 已修复Bug下标，对应下标的方法只会运行一次(登录后执行)


-- 图鉴
ArchiveType = {}
ArchiveType.Role = 1 -- 角色
ArchiveType.Course = 2 -- 教程
ArchiveType.Goods = 3 -- 物品
ArchiveType.Story = 4 -- 剧情
ArchiveType.Equip = 5 -- 装备
ArchiveType.Enemy = 6 -- 敌兵
ArchiveType.Board = 7 -- 看板
ArchiveType.Music = 8 --播放器
ArchiveType.Asmr = 9 --ASMR音频
ArchiveType.Skin = 10 --皮肤
ArchiveType.Bite = 11 --吧唧
ArchiveType.StoryCollection = 12 -- 故事集

--图鉴入口名
ArchiveNameType = {
    [ArchiveType.Role] = "Role",
    [ArchiveType.Course] = "Course",
    [ArchiveType.Goods] = "Goods",
    [ArchiveType.Story] = "Memory",
    [ArchiveType.Equip] = "Equip",
    [ArchiveType.Enemy] = "Enemy",
    [ArchiveType.Board] = "Board",
    [ArchiveType.Music] = "Music",
    [ArchiveType.Asmr] = "Asmr",
}


-- 格子副本进入方式
BattleEnterType = {}
-- 进入副本状态
BattleEnterType.Start = 1 -- 首次
BattleEnterType.Next = 2 -- 下一波

-- 设置界面进入方式
SettingEnterType = {}
SettingEnterType.Login = 1 -- 登录
SettingEnterType.Main = 2 -- 主界面
SettingEnterType.FightMenu = 3 -- 战斗暂停界面

-- AI自动战斗条件界面的开启类型
AIConditionOpenType = {}
AIConditionOpenType.Sort = 1 -- 优先级
AIConditionOpenType.Condition = 2 -- 释放条件
AIConditionOpenType.Target = 3 -- 优先目标

ExchangeItemType = {}
ExchangeItemType.Normal = 1 -- 通用
ExchangeItemType.CardCoreItem = 2 -- 卡牌核心碎片兑换

BuildOpLogType = {}
BuildOpLogType.Agree = 1 -- 点赞
BuildOpLogType.Trade = 2 -- 交易

eRecordType = {}
eRecordType.ArmyPracticeIndex = 1 --  [军演服使用] 军演季度值
eRecordType.ArmyPracticeEndTime = 2 --  [军演服使用] 当前季度军演结束时间
eRecordType.ArmyRealFightIndex = 3 --  [军演服使用] 实时对战，自增index
eRecordType.SystemDiffTime = 4 -- 系统时间偏差设置
eRecordType.OpenAntiAdddiction = 5 -- 是否开启防沉迷
eRecordType.IncreaseId = 6 -- 自增id从1开始
eRecordType.BackstageId = 7
eRecordType.SvrLoginState = 8 -- 服务器登陆状态
eRecordType.GameMaxNum = 9
eRecordType.GameLineNum = 10
eRecordType.FullCacheTime = 11
eRecordType.NextActiveZeroTime = 12
eRecordType.ArmyPracticeStartTime = 13    -- [军演服使用] 当前季度军演开始时间
eRecordType.ArmyIncreaseId = 14           -- [军演服使用] 自增id从1开始
eRecordType.ArmyNextActiveZeroTime = 15   -- [军演服使用] 零点重置时间
eRecordType.ArmyCalFinish = 16            -- [军演服使用] 是否在结算中 0 否 1 是
eRecordType.ArmyCalFinishCnt = 17         -- [军演服使用] 已经结算的人数
eRecordType.ArmyCalFinishIx = 18          -- [军演服使用] 结算进度值
eRecordType.ArmyCalFinishOnceCnt = 19     -- [军演服使用] 结算进度值，每次结算的人数
eRecordType.ArmyCalFinishUseTime = 20     -- [军演服使用] 结算使用的时间戳
eRecordType.OffLineMailMysqlTbChange = 21 -- [中心服] 玩家离线邮件转移表数据
eRecordType.BindPlrActiveId = 22          -- [游戏服] 绑定活动id
eRecordType.ZiLongPayDelIx = 23           -- [Code服使用]紫龙支付处理空订单的最大值
eRecordType.CenterWebPayDelIx = 24        -- [Code服使用]中台支付处理空订单的最大值
eRecordType.GlobalBossFindIx = 25         -- [中心服]新世界boss处理结算的批数
eRecordType.ResetDoubleRecharge = 26      -- [中心服]重置双倍充值次数设置
eRecordType.ResetDoubleRechargeToken = 27 -- [中心服]重置双倍充值次数设置
eRecordType.OneTypeCodeMultiUse = 28      -- [Code服使用]一个码多人使用
eRecordType.FreeMatchPvpCfgId = 29        -- [军演服使用]自由pvp当前配置id
eRecordType.LimitCodeActiveId = 30        -- [游戏服] 限量奖励任务活动ID
eRecordType.FreeMatchJoinPlrCnt = 31      -- [军演服使用] pvp参与人数
eRecordType.DyExchangeCodeId = 32         -- [Code服使用] 动态兑换码生成id
eRecordType.FreeMatchPvp3CfgId = 33       -- [军演服使用]自由pvp3当前配置id
eRecordType.FreeMatch3JoinPlrCnt = 34     -- [军演服使用] pvp3参与人数


GmInitPlrType = {}
GmInitPlrType.Item = 1 -- 物品
GmInitPlrType.Card = 2 -- 卡牌
GmInitPlrType.Equip = 3 -- 装备
GmInitPlrType.Player = 4 -- 玩家

ExplorationState = {}
-- 勘探解锁类型
ExplorationState.Normal = 1 -- 普通勘探
ExplorationState.Ex = 2 -- 高级勘探
ExplorationState.Plus = 3 -- 机密勘探
ExplorationState.Post = 4 -- 机密勘探

ExplorationRewardState = {}
-- 勘探奖励物品状态
ExplorationRewardState.Lock = 1 -- 未解锁
ExplorationRewardState.UnLock = 2 -- 已解锁且不可领取
ExplorationRewardState.Available = 3 -- 已解锁且可领取
ExplorationRewardState.Received = 4 -- 已领取

--付费弹窗
-- MenuBuyState = {}
-- MenuBuyState.First = 1 --首充礼包
-- MenuBuyState.CrateLittle = 2 --新手构建包
-- MenuBuyState.Commodity = 3 --星贸凭证（月卡）
-- MenuBuyState.CrateMove = 4 --首轮特价构建包

---------------------------------------------设置
SettingFightActionType = {} -- 战斗动画开关
SettingFightActionType.Once = 1 -- 一日一次
SettingFightActionType.Open = 2 -- 开启
SettingFightActionType.Close = 3 -- 关闭

SettingFightSimpleType = {} -- 战斗技能简述
SettingFightSimpleType.Open = 1 -- 开启
SettingFightSimpleType.Close = 2 -- 关闭

SettingWindowType = {}
SettingWindowType.Main = 1 --主界面
SettingWindowType.Reset = 2 --重置密码
SettingWindowType.Account = 3 --账号管理
SettingWindowType.LogoutCode = 4 --注销账号验证码
SettingWindowType.Success = 5 --注销成功
SettingWindowType.Log = 6 --日志输出
SettingWindowType.LoginReset = 7 --可输入手机号的重置密码

-- 奖励格子类型
RewardGridType = {
    Goods = 1,
    Equip = 2
}
-- 商店类型
ShopType = {
    CommodityShop = 1, -- 固定商店
    ExchangeShop = 2 -- 随机商店
}
-- 商品购买条件类型
CommodityLimitType = {
    Null = 0, -- 无
    Day = 1, -- 建号后天数
    PlayLv = 2, -- 玩家等级
    Dungeon = 3, -- 通关关卡
    LovePlus = 6, -- 爱相随
    MultTeamStage=7,
}
-- 商品类型显示条件类型
CommodityShowLimitType = {
    Null = 0, -- 无
    Day = 1, -- 建号后天数
    PlayLv = 2, -- 玩家等级
    Dungeon = 3, -- 通关关卡
}

-- 自接的第三方支付类型
SDKPayType = {
    AliPay = 1, -- 支付宝
    Wechat = 2 -- 微信
}

------------------SDK使用------------------
-- HTTP服务器返回状态码
ResultCode = {}
ResultCode.Normal = 0
-- QOOSDK访问返回的Http代码
SDKResultCode = {}
SDKResultCode.Success = 200
-- 米茄SDK通讯命令
SendCMD = {}
SendCMD.Login = 'login'
SendCMD.Reg = 'register'
SendCMD.Code = 'register'
SendCMD.Sign = 'getAccount'
SendCMD.White = 'white'
SendCMD.Change = 'change_password'
-- 米茄SDK通讯子命令
SendSubCMD = {}
SendSubCMD.Reg = 'register'
SendSubCMD.Code = 'code'
SendSubCMD.query = 'query'
SendSubCMD.Change = 'change'

-- 商店类型(对应CfgShopPage的id)
ShopGroup = {
    ArmyShop = 904, -- 演习兑换
    GiftShop = 3, -- 礼包商店
    RechargeShop = 2, -- 充值商店
    RegressionShop = 3001, -- 复归商店
    AbattoirShop = 4001, -- 角斗场商店
    LovePlusShop = 3018001, -- 爱相随商店
    PopupShop = 7001, -- 触发礼包
    RegressionActive = 11001, -- 回归返利
}

ShopPriceKey={
    jCosts="jCosts",
    jCosts1="jCosts1",
}

PayType = {}
PayType.Alipay = 1 -- 支付宝
PayType.WeChat = 2 -- 微信
PayType.BiliBili = 3 -- BiliBili
PayType.Qoo = 4 -- Qoo
PayType.IOS = 5 -- ios
PayType.AlipayQR = 6 --支付宝扫码
PayType.WeChatQR = 7 --微信扫码
PayType.BsAli = 8 --聚合支付-支付宝
PayType.ZiLong = 9 --紫龙
PayType.ZiLongDeductionvoucher=10--紫龙抵扣券
PayType.ZiLongGitPay =11 --紫龙预约和礼品发放
PayType.CenterWeb = 12 --中台


GenEnumNameByVal('PayTypeName', PayType)

PaySelectConf = {}
PaySelectConf.Default = 1 --默认支付方式
PaySelectConf.BsAli = 2 --启用聚合支付替换支付宝支付
PaySelectConf.AdvPay=3--海外支付类型

OpenRuleType = {}
OpenRuleType.Lv = 1 -- 1：等级
OpenRuleType.DupId = 2 -- 2：关卡
OpenRuleType.NewPlrSetp = 3 -- 3：新手步骤( 基地开启不支持这个类型)
OpenRuleType.Add = 4 -- 4：购买等其他外部添加


CardPoolType = {}
CardPoolType.JustFinish = 1 -- 1：直接获取
CardPoolType.WaitFinish = 2 -- 2：需要建造时间
CardPoolType.GobalCreateCnt = 3 -- 3：全服抽卡次数开启
CardPoolType.FixTimeFirstLogin = 4 -- 4：固定时间后首次登录开启
CardPoolType.Regression = 5 -- 5：回归卡池
CardPoolType.SelfChoice = 6 -- 6：自选构建卡池

--编队爬塔限制条件运算符类型
TeamConditionOperator={
    And="&",
    Or="|",
}
--编队爬塔限制编入类型
TeamConditionLimitEditType={
    Only=1,--只能编入对应内容，只能编入是指只有符合限制条件的卡牌可以被编入
    Dis=2,--禁止编入对应内容，禁止编入是指除限制条件外的卡牌都可以被编入
    Max=3,--最多编入对应内容，例如最多编入4星卡牌数量，是指最多可以在队伍中上阵几张4星卡
    Must=4,--必须编入对应内容，必须编入是指队伍中必须编入指定符合条件的卡牌 
}
--编队爬塔限制类型
TeamConditionLimitType={
    Quality=1,--稀有度
    TeamType=2,--所属小队
    RoleType=3,--角色定位
    CoreType=4,--核心类型
    Territory=5,--地域
    Faction=6,--所属
    LevelGreater=7,--大于等于等级
    LevelLess=8,--小于等于等级
    SuitType=9,--套装类型,需要五件装备都是该芯片
    SuitQualityGreater=10,--大于等于套装稀有度
    SuitQualityLess=11,--小于等于套装稀有度
    SuitLevelGreater=12,--大于等于套装总等级
    SuitLevelLess=13,--小于等于套装总等级
    CardID=98,--卡牌ID
    TeamItemNum=99,--队伍人数
}
------------------副本信息------------------
DungeonInfoType = {}
DungeonInfoType.Normal = "Normal"
DungeonInfoType.Tower = "Tower"
DungeonInfoType.Course = "Course"
DungeonInfoType.Trials = "Trials"
DungeonInfoType.TrialsSpecial = "TrialsSpecial"
DungeonInfoType.Danger = "Danger"
DungeonInfoType.Plot = "Plot"
DungeonInfoType.Feast = "Feast"
DungeonInfoType.FeastSpecial = "FeastSpecial"
DungeonInfoType.TotalBattle = "TotalBattle"
DungeonInfoType.Summer = "Summer"
DungeonInfoType.SummerPlot = "SummerPlot"
DungeonInfoType.SummerDanger = "SummerDanger"
DungeonInfoType.SummerSpecial = "SummerSpecial"
DungeonInfoType.Night = "Night"
DungeonInfoType.NightPlot = "NightPlot"
DungeonInfoType.NightDanger = "NightDanger"
DungeonInfoType.NightSpecial = "NightSpecial"
DungeonInfoType.Colosseum = "Colosseum" 
DungeonInfoType.GlobalBoss = "GlobalBoss"
DungeonInfoType.GlobalBossBuff = "GlobalBossBuff"
DungeonInfoType.RogueT = "RogueT"
DungeonInfoType.Cloud = "Cloud"
DungeonInfoType.CloudPlot = "CloudPlot"
DungeonInfoType.CloudDanger = "CloudDanger"
DungeonInfoType.CloudSpecial = "CloudSpecial"
DungeonInfoType.RogueMap = "RogueMap"
DungeonInfoType.Summer2 = "Summer2"
DungeonInfoType.Summer2Plot = "Summer2Plot"
DungeonInfoType.Summer2Danger = "Summer2Danger"
DungeonInfoType.Summer2Special = "Summer2Special"
DungeonInfoType.MultTeamBattle = "MultTeamBattle"
DungeonInfoType.TowerDeep = "TowerDeep"
DungeonInfoType.Christmas = "Christmas"
DungeonInfoType.ChristmasPlot = "ChristmasPlot"
DungeonInfoType.ChristmasDanger = "ChristmasDanger"
DungeonInfoType.ChristmasSpecial = "ChristmasSpecial"
DungeonInfoType.Trials2 = "Trials2"
DungeonInfoType.Desert = "Desert"
DungeonInfoType.DesertPlot = "DesertPlot"
DungeonInfoType.DesertDanger = "DesertDanger"
DungeonInfoType.DesertSpecial = "DesertSpecial"
DungeonInfoType.Desire = "Desire"
DungeonInfoType.DesirePlot = "DesirePlot"
DungeonInfoType.DesireDanger = "DesireDanger"
DungeonInfoType.DesireSpecial = "DesireSpecial"
DungeonInfoType.Build = "Build"
DungeonInfoType.BuildPlot = "BuildPlot"
DungeonInfoType.BuildDanger = "BuildDanger"
DungeonInfoType.BuildSpecial = "BuildSpecial"
DungeonInfoType.Holiday = "Holiday"
DungeonInfoType.HolidayPlot = "HolidayPlot"
DungeonInfoType.HolidayDanger = "HolidayDanger"
DungeonInfoType.HolidaySpecial = "HolidaySpecial"
DungeonInfoType.Erosion = "Erosion"
DungeonInfoType.ErosionPlot = "ErosionPlot"
DungeonInfoType.ErosionDanger = "ErosionDanger"
DungeonInfoType.ErosionSpecial = "ErosionSpecial"
DungeonInfoType.VirtualCataclysm = "VirtualCataclysm"
DungeonInfoType.PeriodicBoss = "PeriodicBoss"

-----------------------------------------------------------------------------------------------------------------
-- 回归玩家类型
RegressionPlrType = {}
RegressionPlrType.Short = 1 -- 短期回归玩家
RegressionPlrType.Long = 2 -- 长期回归玩家
RegressionPlrType.Active = 3 -- 活跃玩家

-----------------------------------------------------------------------------------------------------------------
-- 回归活动类型
RegressionActiveType = {}
RegressionActiveType.Sign = 1 -- 1、签到
RegressionActiveType.DropAdd = 2 -- 2、掉落加成
RegressionActiveType.ResourcesRecovery = 3 -- 3、找回资源
RegressionActiveType.Fund = 4 -- 4、回归基金
RegressionActiveType.Cloth = 5 -- 5、限时时装
RegressionActiveType.ItemPool = 6 -- 6、回归道具池
RegressionActiveType.Shop = 7 -- 7、回归商店
RegressionActiveType.Tasks = 8 -- 8、回归任务
RegressionActiveType.Banner = 9 -- 9、回归卡池
RegressionActiveType.Show = 10 -- 10、玩法一览
RegressionActiveType.ConsumeReduce = 11 -- 11、体力消耗减少
RegressionActiveType.Resupply = 12 -- 12、燃料补给
RegressionActiveType.AcitveRewards = 13 -- 13、回归活跃返利

-----------------------------------------------------------------------------------------------------------------
-- 完成类型, GetTypeById() 计算返回 eTaskFinishType 的枚举值
eAchieveFinishType = {
    GetTypeById = function(id)
        return math.floor(id / 1000)
    end
}

eAchieveFinishType.Player = 10 -- 玩家
eAchieveFinishType.Card = 20 -- 卡牌
eAchieveFinishType.CardDelete = 21 -- 卡牌删除
eAchieveFinishType.CardSkill = 22 -- 卡牌技能
eAchieveFinishType.Fight = 30 -- 战斗
eAchieveFinishType.Shop = 35 -- 商店
eAchieveFinishType.Equip = 40 -- 装备
eAchieveFinishType.Build = 45 -- 建筑
eAchieveFinishType.CardCreate = 50 -- 卡牌创建
eAchieveFinishType.Task = 60 -- 任务
eAchieveFinishType.Army = 61 -- 军演
eAchieveFinishType.Item = 65 -- 物品
eAchieveFinishType.Pet = 70 -- 宠物

eAchieveEventType = {}
eAchieveEventType.None = 0
eAchieveEventType.Upgrade = 1 -- 升级[参数 obj]
eAchieveEventType.Break = 2 -- 突破[参数 obj]
eAchieveEventType.PassCounterpart = 5 -- 副本通关[参数 obj]
eAchieveEventType.TaskFinish = 8 -- 任务完成[参数 obj]
eAchieveEventType.GlobalBoss = 11 -- 世界boss
eAchieveEventType.Collect = 14 -- 收集
eAchieveEventType.PassClass = 17 -- 副本通关卡牌阵营
eAchieveEventType.PassCard = 18 -- 副本通关指定卡牌
eAchieveEventType.PassRolePos = 19 -- 副本通关指定卡牌角色定位
eAchieveEventType.Order = 20 -- 订单
eAchieveEventType.ReduceItem = 21 -- 消耗物品
eAchieveEventType.Dormitory = 22 -- 宿舍
eAchieveEventType.Skill = 26 -- 技能
eAchieveEventType.CollectConditions = 27 -- 完成章章节指定关卡3星条件
eAchieveEventType.CollectStar = 28 -- 副本通关星数[参数 obj]
eAchieveEventType.PassByType = 29 -- 根据副本类型通关次数[参数 obj]
eAchieveEventType.Rank = 30 -- 排名
eAchieveEventType.Death = 31 -- 死亡
eAchieveEventType.Unite = 32 -- Unite
eAchieveEventType.OnBorn = 33 -- 机神召唤
eAchieveEventType.OverLoad = 34 -- OverLoad
eAchieveEventType.Friend = 35 -- Friend
eAchieveEventType.PowerAdd = 37 -- 电力总数
eAchieveEventType.PowerFull = 38 -- 电力充裕
eAchieveEventType.PassDup = 39 -- 角斗场通关
eAchieveEventType.PassDupStar = 40 -- 角斗场通关获得星数
eAchieveEventType.DupBuild = 41 -- 副本建造
eAchieveEventType.JoinDupGroup = 42 -- 参与x关卡组x次

-- 肉鸽玩法词条对象类型
RogueBuffTarget = {}
RogueBuffTarget.TeamAll = 1         -- 我方全体
RogueBuffTarget.MonsterAll = 2      -- 敌方全体
RogueBuffTarget.TeamRandom = 3      -- 我方随机
RogueBuffTarget.MonsterRandom = 4   -- 敌方随机
RogueBuffTarget.BothAll = 5         -- 敌我全体

--切换皮肤资源类型
SkinChangeResourceType={
    Spine=1, --Spine资源
    Image=2,--立绘
}


-----------------------------------------------------------------------------------------------------------------
-- 完成类型, GetTypeById() 计算返回 eTaskFinishType 的枚举值
eBadgedFinishType = {
    GetTypeById = function(id)
        return math.floor(id / 1000)
    end
}

eBadgedFinishType.Player = 10 -- 玩家
eBadgedFinishType.Card = 20 -- 卡牌
eBadgedFinishType.CardDelete = 21 -- 卡牌删除
eBadgedFinishType.CardSkill = 22 -- 卡牌技能
eBadgedFinishType.Fight = 30 -- 战斗
eBadgedFinishType.Shop = 35 -- 商店
eBadgedFinishType.Equip = 40 -- 装备
eBadgedFinishType.Build = 45 -- 建筑
eBadgedFinishType.CardCreate = 50 -- 卡牌创建
eBadgedFinishType.Task = 60 -- 任务
eBadgedFinishType.Army = 61 -- 军演
eBadgedFinishType.Item = 65 -- 物品
eBadgedFinishType.Pet = 70 -- 物品

eBadgedEventType = {}
eBadgedEventType.None = 0
eBadgedEventType.Upgrade = 1 -- 升级[参数 obj]
eBadgedEventType.Break = 2 -- 突破[参数 obj]
eBadgedEventType.PassCounterpart = 5 -- 副本通关[参数 obj]
eBadgedEventType.TaskFinish = 8 -- 任务完成[参数 obj]
eBadgedEventType.GlobalBoss = 11 -- 世界boss
eBadgedEventType.Collect = 14 -- 收集
eBadgedEventType.PassClass = 17 -- 副本通关卡牌阵营
eBadgedEventType.PassCard = 18 -- 副本通关指定卡牌
eBadgedEventType.PassRolePos = 19 -- 副本通关指定卡牌角色定位
eBadgedEventType.Order = 20 -- 订单
eBadgedEventType.ReduceItem = 21 -- 消耗物品
eBadgedEventType.Dormitory = 22 -- 宿舍
eBadgedEventType.Skill = 26 -- 技能
eBadgedEventType.CollectConditions = 27 -- 完成章章节指定关卡3星条件
eBadgedEventType.CollectStar = 28 -- 副本通关星数[参数 obj]
eBadgedEventType.PassByType = 29 -- 根据副本类型通关次数[参数 obj]
eBadgedEventType.Rank = 30 -- 排名
eBadgedEventType.Death = 31 -- 死亡
eBadgedEventType.Unite = 32 -- Unite
eBadgedEventType.OnBorn = 33 -- 机神召唤
eBadgedEventType.OverLoad = 34 -- OverLoad
eBadgedEventType.Friend = 35 -- Friend
eBadgedEventType.PowerAdd = 37 -- 电力总数
eBadgedEventType.PowerFull = 38 -- 电力充裕
eBadgedEventType.PassDup = 39 -- 角斗场通关
eBadgedEventType.PassDupStar = 40 -- 角斗场通关获得星数
eBadgedEventType.JoinDupGroup = 42 -- 参加x关卡组战斗x次

--道具池相关
--抽取类型
ItemPoolExtractType={
    RoundLoop=1,    --轮数无限
    RoundLimit=2,   --轮数上限设置
    Once=3,         --只能抽一次
    DropLoop=4,     --按同一轮的配置无限抽取
    Control = 5,     --控制前N抽产出，有无限奖励
    ControlNotInfinite = 6     --控制前N抽产出，没有无限奖励
}
--开放条件
ItemPoolPropType={
    TimeLimit=1,--根据时间开放
    Const=2,--常驻
    Cost=3,--根据抽取道具
    Regression=4,--回归活动
}

ItemPoolType={
    Pool=1,--道具池
    LuckyGacha=2,--幸运扭蛋
    SkinGacha=3,--皮肤扭蛋
}

-- 绑定玩家类型
eBindActivePlrType = {}
eBindActivePlrType.Any = 1 -- 1：任何玩家
eBindActivePlrType.Return = 2 -- 2：回归玩家
eBindActivePlrType.Acitve = 3 -- 3：活跃玩家

---绑定限制类型枚举
eBindLimitType={
    UnLimit=0,--不限制
    Day=1,--每日上限
    Week=2,--每周上限
}

--绑定邀请界面打开方式
eBindInviteOpenType={
    Invite=1, --推荐的
    Request=2, --请求的
}

--排行榜类型
eRankType = {}
eRankType.Abattoir = 1 -- 角斗场
eRankType.RogueTRank = 2 -- 限制肉鸽爬塔排行榜
eRankType.STAR = 3 -- 十二宫
eRankType.BuffBattleRank = 4 -- 积分战斗
eRankType.MultTeamRank = 5 -- 多队玩法
eRankType.MaidCoffeeRank = 7 -- 女仆咖啡玩法
eRankType.ChristmasGiftRank = 8 -- 圣诞节签到活动
eRankType.TowerDeepRank = 9 -- 深塔计划
eRankType.HalloweenGameRank = 10 -- 万圣节游戏
eRankType.ChainFrontRank = 11 -- 连锁战线
eRankType.EternalBattleRank = 12 -- 永镜战域
eRankType.TrialChainRank = 13 -- 历战试炼挑战榜
eRankType.PeriodBossRank = 17 -- 周期BOSS
eRankType.CrossBossRank = 18 -- 虚数天灾挑战榜

-- 排行榜id
eRankId = {}
eRankId.SummerActiveRank = 10001 --夏活无限血排行榜，钓鱼老
eRankId.Abattoir = 10002 -- 角斗场
eRankId.CentaurRank = 10003 --人马无限血排行榜
eRankId.RogueTRank = 10006 --限制肉鸽爬塔排行榜
eRankId.CloudRank = 10007 --云端行迹排行榜
eRankId.BuffBattleRank = 10013 --积分战斗
eRankId.MultTeamRank = 10015 --多队玩法
eRankId.MaidCoffeeRank = 10017 --女仆咖啡玩法
eRankId.ChristmasGiftRank = 10019 --圣诞节签到活动
eRankId.TowerDeepRank = 10020 --深塔计划
eRankId.HalloweenGameRank = 10021 --万圣节游戏
eRankId.ChainFrontRank = 10026 --连锁战线
eRankId.EternalBattleRank = 10027 --永镜战域
eRankId.CrossBossRank = 10046 --虚数天灾
eRankId.RogueMapRank = 20001 --小地图总分排行
eRankId.RogueMapSupRank = 20002 --小地图援助排行
eRankId.Exercise = 10047 --军演（前端使用）
eRankId.GlobalBoss = 10004 --世界boss（前端使用）
eRankId.PeriodicBoss1 = 20101 -- 周期BOSS排行榜1
eRankId.PeriodicBoss2 = 20102 -- 周期BOSS排行榜2
eRankId.PeriodicBoss3 = 20103 -- 周期BOSS排行榜3
eRankId.PeriodicBoss4 = 20104 -- 周期BOSS排行榜4

-- 排行榜默认使用数据表名
G_RANK_DEF_DB_TABLE = 'plr_star_rank'

--需要定义数据表名
eRankDbTable = {}
eRankDbTable[eRankType.RogueTRank] = 'plr_rogueT_rank'
eRankDbTable[eRankType.Abattoir] = 'plr_abattoir_rank'
eRankDbTable[eRankType.BuffBattleRank] = 'plr_buff_battle_rank'
eRankDbTable[eRankType.MultTeamRank] = 'plr_mult_team_rank'
eRankDbTable[eRankType.MaidCoffeeRank] = 'plr_maid_coffee_rank'
eRankDbTable[eRankType.ChristmasGiftRank] = 'plr_christmas_gift_rank'
eRankDbTable[eRankType.HalloweenGameRank] = 'plr_halloween_game_rank'
eRankDbTable[eRankType.TowerDeepRank] = 'plr_tower_deep_rank'
eRankDbTable[eRankType.ChainFrontRank] = 'plr_chain_front_rank'
eRankDbTable[eRankType.EternalBattleRank] = 'plr_eternal_battle_rank'
eRankDbTable[eRankType.TrialChainRank] = 'plr_trial_chain_rank'
eRankDbTable[eRankType.PeriodBossRank] = 'plr_period_boss_rank'
eRankDbTable[eRankType.CrossBossRank] = 'plr_cross_boss_rank'

--收集活动类型
eCollectType = {}
eCollectType.Recharge = 1 --累计充值 1011
eCollectType.Recharge1 = 2 --累计充值 1022
eCollectType.Recharge2 = 3 --累计充值 1023

--eCollectType活动对应的配置表
eCollectTable = {}
eCollectTable[eCollectType.Recharge] = 'CfgRechargeCount'
eCollectTable[eCollectType.Recharge1] = 'CfgRechargeCount2'
eCollectTable[eCollectType.Recharge2] = 'CfgRechargeCount'

--eCollectType活动对应的活动列表的id
eCollectTypeActiveId = {}
eCollectTypeActiveId[eCollectType.Recharge] = 1011 --累计充值 1011
eCollectTypeActiveId[eCollectType.Recharge1] = 1022 --累计充值 1022
eCollectTypeActiveId[eCollectType.Recharge2] = 1023 --累计充值 1023

GenEnumNameByVal('eCollectTypeActive', eCollectTypeActiveId)

-- 回归商店id
eReturnPlrShopType = {}
eReturnPlrShopType[ShopGroup.RegressionShop] = true

--抵扣券类型
VoucherType={
    Common=1,--通用折扣券
    Skin=2,--时装折扣券
    Pictrue=3,--插画折扣券
}

--运营活动活动类型
eOperateType = {}
--(有前置开启条件)
eOperateType.RechargeSign = 1015 --充值签到
--(无前置开启条件)
eOperateType.PayNotice7 = 1018 --充值弹窗7
eOperateType.PayNotice8 = 1019 --充值弹窗8
eOperateType.PayNotice1 = 1020 --充值弹窗1
--(特殊处理)对应多个活动，所以不对应活动id
eOperateType.SkinRebate = 13000 --皮肤返利
eOperateType.DragonBoatFestival = 1029 --端午签到
--
eOperateType.LimitCode = 1032 --限量奖励活动
eOperateType.RichMan = 1037--大富翁
eOperateType.PhysicalReward = 1038 --实物抽奖活动
eOperateType.HalloweenGame = 1035--万圣节小游戏
eOperateType.NewPlayerSeven = 1039 --新手七日活动
eOperateType.SkinDiscount = 1044 --悦购优惠（皮肤折扣）
eOperateType.OldSkinRebate = 1047 --复刻皮肤返利


eActiveListId = {}
eActiveListId.FreeCreateCard = 1021


--运营活动活动类型(到时间直接开启无需前置条件)
eOperateActiveType = {}
eOperateActiveType.PayNotice1 = eOperateType.PayNotice1
eOperateActiveType.PayNotice7 = eOperateType.PayNotice7
eOperateActiveType.PayNotice8 = eOperateType.PayNotice8

GenEnumNameByVal('eOperateActiveTypeById', eOperateActiveType)
-----------------------------------------------------------------------------------------------------------------
-- 夏日活动宠物属性类型
ePetAbilityType = {
    "happy",        -- 心情
    "food",         -- 饱腹度
    "wash",        -- 清洁度
    "feed",         --养成值
}

-- 夏日活动宠物状态
ePetState = {
    "Hunger",   -- 饥饿
    "Full",     -- 饱腹
    "Down" ,    -- 心情低落
    "Dirty",    -- 肮脏
    "Happy",    -- 高兴
}

-----------------------------------------------------------------------------------------------------------------
-- 新手关卡开放类型
eOpenConditionType = {}
eOpenConditionType.Lv = 1 --等级
eOpenConditionType.Dup = 2 --关卡

-----------------------------------------------------------------------------------------------------------------
--爱相随解锁类型
eLovePlusUnLockType = {}
eLovePlusUnLockType.CG = 1 
eLovePlusUnLockType.Img = 2
eLovePlusUnLockType.Chat = 3
eLovePlusUnLockType.Label = 4
eLovePlusUnLockType.Story = 5
eLovePlusUnLockType.Shop = 6
-----------------------------------------------------------------------------------------------------------------
-- 角斗场状态
eAbattoirState = {}
eAbattoirState.START = 1
eAbattoirState.OVER = 2
eAbattoirState.REFRESH = 3

-- 活动入口id
eActiveEntryId = {}
eActiveEntryId.STAR = 13 --十二星宫
eActiveEntryId.PET = 16 --宠物

-- 随机看板类型
eRandomPanelType = {}
eRandomPanelType.SINGLE = 1 --单人随机看板
eRandomPanelType.DOUBLE = 2 --双人随机看板
eRandomPanelType.ALL = 3 --全部一起勾选

-- 新世界boss最大上榜人数
GLOBAL_BOSS_MAX_RANK = 50

--活动弹窗类型 
eAEShowType = {}
eAEShowType.Anniversary = 1

--关联活动弹窗类型 活动入口表id
eAEShowIdType = {}
eAEShowIdType[1] = 31

-----------------------------------------------------------------------------------------------------------------
-- 物品数据数组下标枚举
eItemArrIx = {}
eItemArrIx.num = 1             -- 数量
eItemArrIx.fixExpiryIx = 2     -- 固定过期时间值
eItemArrIx.createTime = 3      -- 首次创建时间
eItemArrIx.fixExpiryTime = 4   -- 固定过期时间
eItemArrIx.dyExpiryArr = 5     -- 多堆叠过期动态时间 { {数量，过期时间}, {数量，过期时间} }

-----------------------------------------------------------------------------------------------------------------
--汇总枚举
eSummaryType = {}
eSummaryType.NewYear = 1
eSummaryType.Timest = 2

--双倍掉落道具类型
eItemSectionMultiType = {}
eItemSectionMultiType.cnt = 1 --指定时间内只有一个可以生效
eItemSectionMultiType.time = 2 --使用之后延长有效时间（道具id不同,需要上一个失效才会生效下一个）
eItemSectionMultiType.exTime = 3 --使用之后延长有效时间（道具id不同可以同时生效）

-----------------------------------------------------------------------------------------------------------------
--对战表情类型
eEmoteType = {}
eEmoteType.Common     = 1   -- 通用
eEmoteType.FightStart = 2   -- 开场
eEmoteType.FightWin   = 3   -- 胜利
eEmoteType.FightLost  = 4   -- 失败

-----------------------------------------------------------------------------------------------------------------
-- 拼图玩法活动类型
ePuzzleType = {}
ePuzzleType.Type1     = 1   -- 玩法1
ePuzzleType.Type2     = 2   -- 玩法2
-----------------------------------------------------------------------------------------------------------------
--特殊引导类型
SpecialGuideType = {}
SpecialGuideType.Start = 1 --开始
SpecialGuideType.Stop = 2 --暂停
SpecialGuideType.StopAll = 3 --关闭所有
SpecialGuideType.FinishOrRefresh = 4 --结束或者刷新
SpecialGuideType.Finish = 5 --结束
-----------------------------------------------------------------------------------------------------------------
-- 端午活动加油类型
eDragonBoatFestivalType = {}
eDragonBoatFestivalType.Sweet = 1   -- 甜
eDragonBoatFestivalType.Salty = 2   -- 咸

-----------------------------------------------------------------------------------------------------------------
-- 小地图探索格子类型
eRogueMapPosType = {}
eRogueMapPosType.Monster    = 1   -- 小怪
eRogueMapPosType.Boss       = 2   -- BOSS
eRogueMapPosType.SpecialBoss= 3   -- 特殊BOSS
eRogueMapPosType.Reward     = 4   -- 奖励
eRogueMapPosType.Prop       = 5   -- 地图道具
eRogueMapPosType.Action     = 6   -- 行动资源
eRogueMapPosType.Buff       = 7   -- BUFF
-----------------------------------------------------------------------------------------------------------------
-- 小地图探索动效类型
eRogueMapEffectType = {
    [eRogueMapPosType.SpecialBoss] = 1, -- 特殊BOSS
}
-----------------------------------------------------------------------------------------------------------------
-- 小地图探索BUFF类型
eRogueMapBuffType = {}
eRogueMapBuffType.PERMANENT    = 1   -- 永久BUFF
eRogueMapBuffType.TEMPORARY    = 2   -- 临时BUFF

-----------------------------------------------------------------------------------------------------------------
-- 小地图探索道具类型
eRogueMapPropType = {}
eRogueMapPropType.UnlockSingleBoss  = 1   -- 透视单个BOSS
eRogueMapPropType.UnlockAllBoss     = 2   -- 透视所有BOSS
eRogueMapPropType.Teleport          = 3   -- 传送
eRogueMapPropType.Boom              = 4   -- 炸弹击败（击败指定小怪）
eRogueMapPropType.Roll              = 5   -- 定向骰子
eRogueMapPropType.Damage            = 6   -- 对BOSS使用会削减它的生命值，无法通过该方法击败BOSS

-----------------------------------------------------------------------------------------------------------------
-- 小地图探索其余格子生成对应的类型
eRogueMapOtherPlot = {
    [eRogueMapPosType.Reward] = 1,
    [eRogueMapPosType.Buff] = 2
}

-----------------------------------------------------------------------------------------------------------------
--
eDupSupportType = {}
eDupSupportType.Friend = 1 -- 好友支援
eDupSupportType.All = 2    -- 全体

-----------------------------------------------------------------------------------------------------------------
AnniversaryType = {}
AnniversaryType.Timest = 2 --1.5周年
AnniversaryType.Second = 3 --2周年
AnniversaryType.NewYear = 4 --新春庆典
AnniversaryType.Dream = 5 --2.5周年

AnniversaryListType = {}
AnniversaryListType.Main = 1 --主界面
AnniversaryListType.Pic = 2 --图片跳转
AnniversaryListType.Shop = 3 --商店
AnniversaryListType.AccuCharge = 4 --累积充值
AnniversaryListType.SignIn = 5 --签到
-----------------------------------------------------------------------------------------------------------------
DungeonBgType = {}
DungeonBgType.Normal = 1 --正常模式
DungeonBgType.Change = 2 --背景切换模式

-----------------------------------------------------------------------------------------------------------------
-- 多队玩法
eMultTeamState = {}
eMultTeamState.NONE = 0
eMultTeamState.START = 1
eMultTeamState.SETTLE = 2
eMultTeamState.OVER = 3

-----------------------------------------------------------------------------------------------------------------
--触发礼包类型
ePopupType = {}
ePopupType.PlrLevel = 1 --玩家等级达到X
ePopupType.Skill = 2    --X个主动技能等级达到Y级
ePopupType.Role = 3 --获得X个Y星角色
ePopupType.PassDup = 4  --首次通关指定关卡
ePopupType.TalentLevel = 5  --X个跃升天赋等级达到Y级
ePopupType.Equip = 6    --获得X个Y品质芯片
ePopupType.RoleLevel = 7    --X个角色等级达到Y级

-----------------------------------------------------------------------------------------------------------------
-- 
eFreeMatchDef = {}
eFreeMatchDef.rankLen = 100 -- 自由军演，排行榜长度

-----------------------------------------------------------------------------------------------------------------
-- 
ePvpDef = {}
ePvpDef.pvp3MaxRound = 3 -- pvp3 打几轮



-----------------------------------------------------------------------------------------------------------------
-- 
eDupPassTeamDef = {}
eDupPassTeamDef.recordCnt = 10 -- 每个副本记录的数量

-----------------------------------------------------------------------------------------------------------------
HalloweenItemType = {}
HalloweenItemType.Score = 1 --得分
HalloweenItemType.Trap = 2 --陷阱
HalloweenItemType.Time = 3 --加时


-----------------------------------------------------------------------------------------------------------------
-- pvp 累计任务计数类型
ePVPTaskType = {}
ePVPTaskType.Join = 1 -- 参与次数
ePVPTaskType.Win = 2  -- 胜利次数

--检测卡牌类型
eSingleCardType = {}
eSingleCardType.Normal = 1 --自己的卡牌
eSingleCardType.Assist = 2 --包括助战卡牌

--上阵匹配类型 1v1 和 3v3
ePVPPPType = {}
ePVPPPType.One = 1   --1v1
ePVPPPType.Three = 2 --3v3

eItemExpiryNoMailType = {}
eItemExpiryNoMailType.NoExpiryMail = 1
eItemExpiryNoMailType.ExpiryMailButNo = 1
-----------------------------------------------------------------------------------------------------------------
---小额付费商品解锁条件
eSmallPayConType = {}
eSmallPayConType.Login = 1
eSmallPayConType.ReduceHot = 2
eSmallPayConType.PassDup = 3


eSmallPayDataName = {}
eSmallPayDataName[eSmallPayConType.Login] = "loginDay"
eSmallPayDataName[eSmallPayConType.ReduceHot] = "reduceHot"
eSmallPayDataName[eSmallPayConType.PassDup] = "dupPass"




-----------------------------------------------------------------------------------------------------------------
--虚数天灾活动状态
eCrossBossActState = {}
eCrossBossActState.NotStart = 0        -- 未开始
eCrossBossActState.Taking = 1         -- 进行中
eCrossBossActState.Over = 2           -- 已结束

--虚数天灾取值类型
eCrossBossGetValueType = {}
eCrossBossGetValueType.Fixed = 1   -- 固定值
eCrossBossGetValueType.Rand = 2   -- 随机

--虚数天灾变化取值类型
eCrossBossValueAddType = {}
eCrossBossValueAddType.Increase  = 1   -- 增加
eCrossBossValueAddType.Decrease = 2   -- 减少


--小地图日志上报类型
eRogueMapBILogTy = {}
eRogueMapBILogTy.enterDup = 1       --进入全新副本
eRogueMapBILogTy.dupOver = 2        --副本结束
eRogueMapBILogTy.buyRollCnt = 3     --购买骰子
eRogueMapBILogTy.roll = 4           --使用骰子
eRogueMapBILogTy.moveEnd = 5        --移动结束
eRogueMapBILogTy.enterFight = 6     --进入战斗
eRogueMapBILogTy.supFightEnd = 7    --援助战斗结束
eRogueMapBILogTy.requireSup = 8     --发起求援
eRogueMapBILogTy.enterSupFight = 9  --援助战斗开始

-- v 6.0 扩展队长[ 性别只有 1 和 2 ]
eSex = {}
eSex.Boy = 1 --男
eSex.Girl = 2 --女
GenEnumNameByVal('eSexName', eSex)
