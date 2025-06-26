-- this file is auto generate by proto2lua.exe, please DO NOT modify it manually!

---@class RarityEnum
RarityEnum = {
    RarityNone = 0,
    RarityR = 1,
    RaritySR = 2,
    RaritySSR = 3,
}

---@class CharacterClassEnum
CharacterClassEnum = {
    CharacterClassUnknown = 0,
    CharacterClassWarrior = 1,
    CharacterClassGuardian = 2,
    CharacterClassRogue = 3,
    CharacterClassRanger = 4,
    CharacterClassWarlock = 5,
    CharacterClassSupport = 6,
}

---@class ItemUseType
ItemUseType = {
    ItemUseTypeNone = 0, -- 
    ItemUseTypeGetPower = 1, -- 体力药, 参数[恢复量]
    ItemUseTypeAddCharacter = 2, -- 添加角色, 参数[角色id]
    ItemUseTypeAddEquipment = 3, -- 添加装备, 参数[装备id]
    ItemUseTypeCharacterLevelUp = 4, -- 角色经验, 参数[经验量]
    ItemUseTypeFightSoulLevelUp = 5, -- 战魂经验, 参数[经验量]
    ItemUseTypeCharacterFrag = 6, -- 角色碎片, 参数[角色id], 不写就是通用碎片
    ItemUseTypeExpendFightSoulBag = 7, -- 扩展战魂背包, 参数[扩展数量]
    ItemUseTypeAddHeadPortrait = 8, -- 头像, 参数[头像id]
    ItemUseTypeIntimacy = 9, -- 增加亲密度, 参数[亲密度]
    ItemUseTypeExpendEquipmentPack = 10, -- 扩展装备背包, 参数[扩展数量]
    ItemUseTypeOptionalRewardPack = 11, -- 自选包, 参数[RewardPack表id]
    ItemUseTypeDrop = 12, -- 随机掉落, 参数[drop表id]
}

---@class EquipmentSlot
EquipmentSlot = {
    EquipmentSlotNone = 0,
    EquipmentSlotMainHand = 1,
    EquipmentSlotSecondaryWeapon = 2,
    EquipmentSlotBody = 3,
    EquipmentSlotHead = 4,
    EquipmentSlotFoot = 5,
    EquipmentSlotAccessory = 6,
}

---@class RewardType
RewardType = {
    RewardTypeUnknow = 0,
    RewardTypeItem = 1, -- 道具, [道具id, 道具数量]
    RewardTypeCharacter = 2, -- 角色, [角色id, 角色数量]
    RewardTypeExp = 3, -- 玩家经验, [1, 经验值]
    RewardTypeHeadPortrait = 4, -- 头像, [头像id, 头像数量]
    RewardTypeHeadPortraitBorder = 5, -- 头像框, [头像框id, 头像框数量]
    RewardTypeCharacterSkin = 6, -- 角色皮肤, [皮肤id, 皮肤数量]
    RewardTypeMonthlyCard = 7, -- 月卡, [月卡id, 1]
    RewardTypeFightSoul = 8, -- 战魂, [战魂id, 战魂数量]
    RewardTypeEquipment = 9, -- 装备, [装备id, 装备数量]
    RewardTypePassProgress = 10, -- 通行证进度, [通行证id, 经验值]
    RewardTypePassMembership = 11, -- 通行证用户级别, [通行证id, 用户级别]
    RewardTypePassProgressWithAddition = 12, -- 通行证进度(带加成), [通行证id, 经验值]
}

---@class ConditionType
ConditionType = {
    ConditionTypeUnknown = 0,
    ConditionTypeRoleLevel = 1, -- 玩家等级, 参数: [玩家等级]
    ConditionTypeBuyGoods = 2, -- 购买商品, 参数: [商店id, 商品id, 商品数量]
    ConditionTypeBuyPaymentGoods = 3, -- 购买氪金商品: [商品id, 商品数量]
    ConditionTypePassLevel = 4, -- 通关关卡, 参数: [关卡id]
    ConditionTypeUnlockModule = 5, -- 解锁模块, 参数: [模块id]
    ConditionTypeMonthCardOver = 6, -- 月卡剩余天数超过n天, 参数: [天数]
    ConditionTypeMonthCardNotOver = 7, -- 月卡剩余天数不超过n天, 参数: [天数]
    ConditionTypeFirstCharacterSelected = 8, -- 初始角色的选择, 参数: [序号]
    ConditionTypeRegistryTime = 9, -- 注册时间, 参数: [时间戳]
    ConditionTypeAlwaysFailed = 10, -- 永远失败
    ConditionTypeHasCharacter = 11, -- 拥有角色, 参数: [角色id]
    ConditionTypeNotHasSkin = 12, -- 未拥有皮肤, 参数: [皮肤id]
    ConditionTypeItemCount = 13, -- 道具数量, 参数: [道具id, 数量]
}

---@class TaskStatus
TaskStatus = {
    TaskStatusWaiting = 0,
    TaskStatusProgressing = 1,
    TaskStatusCompleted = 2,
    TaskStatusReceived = 3,
}

---@class TaskType
TaskType = {
    TaskTypeUnknown = 0,
    TaskTypeMain = 1,
    TaskTypeDaily = 2,
    TaskTypeWeekly = 3,
    TaskTypeGameEvent = 4,
    TaskTypeAchievement = 5,
    TaskTypePass = 6,
}

---@class MailStatus
MailStatus = {
    MailStatusUnknown = 0,
    MailStatusUnread = 1, -- 未读未领取
    MailStatusReadNotReceived = 2, -- 已读未领取
    MailStatusReceived = 3, -- 已读已领取
}

---@class ChapterType
ChapterType = {
    ChapterTypeUnknown = 0,
    ChapterTypeAdventure = 1,
    ChapterTypeResource = 2,
    ChapterTypeJob = 3,
}

---@class LevelType
LevelType = {
    LevelTypeNone = 0,
    LevelTypeStory = 1,
    LevelTypeSevenStar = 2,
    LevelTypeGameEvent = 3,
    LevelTypeMonthlyTower = 4,
    LevelTypeTower = 5,
    LevelTypeChallenge = 6,
    LevelTypeGuide = 7,
    LevelTypeArena = 8,
    LevelTypeBossraid = 9,
}

---@class FormationsType
FormationsType = {
    FormationsTypeUnknown = 0,
    FormationsTypeSystem = 1,
    FormationsTypeArena = 2,
    FormationsTypeBossraid = 3,
}

---@class CharacterSkillStatus
CharacterSkillStatus = {
    CharacterSkillStatusUnknown = 0,
    CharacterSkillStatusLock = 1,
    CharacterSkillStatusUnlock = 2,
}

---@class RecruitPoolType
RecruitPoolType = {
    RecruitPoolUnknown = 0,
    RecruitPoolRookie = 1,
    RecruitPoolNormal = 2,
    RecruitPoolGameEvent = 3,
}

---@class GoodsOnSaleConditionType
GoodsOnSaleConditionType = {
    GoodsOnSaleConditionEmpty = 0,
    GoodsOnSaleConditionRoleLevel = 1,
    GoodsOnSaleConditionBuyGoods = 2,
}

---@class GoodsTakeOffConditionType
GoodsTakeOffConditionType = {
    GoodsTakeOffConditionEmpty = 0,
    GoodsTakeOffConditionDuration = 1,
}

---@class GoodsRefreshType
GoodsRefreshType = {
    GoodsRefreshUnknow = 0,
    GoodsRefreshDaily = 1,
    GoodsRefreshWeekly = 2,
    GoodsRefreshMonthly = 3,
    GoodsRefreshNever = 4,
}

---@class RecruitPoolStatus
RecruitPoolStatus = {
    RecruitPoolStatusUnknown = 0,
    RecruitPoolStatusOpen = 1, -- 卡池开启中并可抽取
    RecruitPoolStatusBeforeStartTime = 2, -- 未到开启时间
    RecruitPoolStatusAfterEndTime = 3, -- 卡池关闭，只有pushUpdate会使用
    RecruitPoolStatusOverRecruitLimit = 4, -- 卡池开启中但超过招募限制
}

---@class BattleResultType
BattleResultType = {
    BattleResultWin = 0, -- 胜利
    BattleResultGiveUp = 1, -- 放弃
    BattleResultFailure = 2, -- 失败
}

---@class CommonCheckInStatus
CommonCheckInStatus = {
    CommonCheckInNotStarted = 0,
    CommonCheckInOnGoing = 1,
    CommonCheckInExpired = 2,
}

---@class CheckInReceiveStatus
CheckInReceiveStatus = {
    CheckInReceiveUnavailable = 0, -- 不可领取
    CheckInReceiveNotReceived = 1, -- 未领取
    CheckInReceiveReceived = 2, -- 已领取
}

---@class GameEventModuleType
GameEventModuleType = {
    GameEventModuleUnknow = 0,
    GameEventModuleEntry = 1, -- 活动入口, 参数[无]
    GameEventModuleTask = 2, -- 活动任务, 参数[任务组id...]
    GameEventModuleLevelDropBoost = 3, -- 掉落增益, 参数[增加倍率, 关卡表类型, 关卡类型]
    GameEventModuleLevel = 4, -- 活动关卡, 参数[解锁组...]
    GameEventModuleShop = 5, -- 活动商店, 参数[解锁组...]
    GameEventModuleCheckIn = 6, -- 签到, 参数[签到id]
    GameEventModulePass = 7, -- 通行证, 参数[通行证id]
    GameEventModuleBossraid = 8, -- 总力战, 参数[总力战id]
    GameEventModuleDailyTask = 9, -- 活动每日任务, 参数[任务组id...]
    GameEventModuleWeeklyTask = 10, -- 活动每周任务, 参数[任务组id...]
    GameEventModulePaymentShop = 11, -- 氪金商店, 参数[解锁组...]
}

---@class GameEventModuleTimeModeType
GameEventModuleTimeModeType = {
    GameEventModuleTimeModeUnknow = 0,
    GameEventModuleTimeModeTimer = 1, -- 绝对时间
    GameEventModuleTimeModeRecentLogin = 2, -- 从登录时间开始算, 延迟x天开始, 第y天结束, 参数[x, y]
    GameEventModuleTimeModeRealStartDuration = 3, -- 真正开始时间开始算, 持续n天, 参数[n]
}

---@class GameEventStatus
GameEventStatus = {
    GameEventStatusWaiting = 0,
    GameEventStatusInProgress = 1,
    GameEventStatusEnded = 2,
}

---@class ModuleType
ModuleType = {
    ModuleTypeUnknown = 0,
    ModuleTypeMain = 1000, -- 主界面
    ModuleTypePackage = 2000, -- 背包
    ModuleTypeMail = 3000, -- 邮件
    ModuleTypeFormation = 4000, -- 编队
    ModuleTypeRecruit = 5000, -- 招募
    ModuleTypeTask = 6000, -- 任务
    ModuleTypeSetting = 7000, -- 设置
    ModuleTypeCatCafe = 8000, -- 猫咖
    ModuleTypeConstruction = 9000, -- 基建
    ModuleTypeShop = 10000, -- 商城
    ModuleTypeCharacter = 11000, -- 角色
    ModuleTypeCharacterDetail = 11001, -- 角色详情
    ModuleTypeCharacterLevelUp = 11002, -- 角色升级
    ModuleTypeCharacterAwaken = 11003, -- 角色觉醒
    ModuleTypeCharacterMerge = 11004, -- 角色同名突破
    ModuleTypeCharacterSkillLevelUp = 11005, -- 角色技能升级
    ModuleTypeLevel = 12000, -- 关卡
    ModuleTypeLevelMain = 12001, -- 主线
    ModuleTypeLevelResource = 12002, -- 资源
    ModuleTypeLevelTest = 12003, -- 试炼
    ModuleTypeLevelWeekly = 12004, -- 模拟幻境（周本）
    ModuleTypeLevelSelect = 12005, -- 推图选关
    ModuleTypeLevelDetail = 12006, -- 关卡详情
    ModuleTypeFriend = 13000, -- 好友
    ModuleTypeFriendCard = 13001, -- 好友名片
    ModuleTypeFriendList = 13002, -- 好友列表
    ModuleTypeFriendAdd = 13003, -- 添加好友
    ModuleTypeFriendApply = 13004, -- 好友申请
}

---@class TowerModuleType
TowerModuleType = {
    TowerModuleTypeStart = 0,
    TowerModuleTypeShield = 1, -- 护盾
    TowerModuleTypeCollision = 2, -- 碰撞
    TowerModuleTypeHalo = 3, -- 光环
    TowerModuleTypeAttack = 4, -- 攻击
    TowerModuleTypeHeal = 5, -- 治疗
    TowerModuleTypeElement = 6, -- 元素
    TowerModuleTypeEnd = 7,
}

---@class LoginChannel
LoginChannel = {
    LoginChannelUnkonw = 0,
    LoginChannelOffical = 1,
    LoginChannelQOO = 2,
    LoginChannelTest = 99,
}

---@class LoginPlatform
LoginPlatform = {
    LoginPlatformUnkonw = 0,
    LoginPlatformAndroid = 1,
    LoginPlatformIOS = 2,
}

---@class PaymentChannel
PaymentChannel = {
    PaymentChannelUnknow = 0,
    PaymentChannelOffical = 1,
    PaymentChannelQOO = 2,
    PaymentChannelTest = 99,
}

---@class PassStatus
PassStatus = {
    PassStatusUnknow = 0,
    PassStatusWaiting = 1,
    PassStatusProgressing = 2, -- 进行中
    PassStatusEnded = 3, -- 结束
}

---@class PassMembership
PassMembership = {
    PassMembershipUnknow = 0,
    PassMembershipNormal = 1,
    PassMembershipSpecial = 2,
    PassMembershipPremium = 3,
}

