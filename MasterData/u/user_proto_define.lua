-- ============================
-- 说明
-- ret 返回值统一0为正常范围，非0值均为异常返回
-- 绝大多数消息为请求响应式即Request<->Response形式
-- 需要保证可靠性的（断线重连后不丢失）主动推送式方式，我定义为Subscribe<->Publish形式，操作上需要客户端预发一个订阅，服务端通过订阅的id进行主动推送
-- 不需要保证可靠性的（断线重连后丢失）主动推送式方式，比如其他人的聊天消息等允许断线后丢失的，后缀为Notify（只由服务器发起）
-- ============================
---@class IntArray
---@field values integer[] 一维数组


---@class TestProp
---@field prop integer


---@class Test1Req
---@field m1 integer
---@field str string
-- int32 m2 = 2;
-- int32 m3 = 3;


---@class Test1Resp
---@field ret integer


---@class Test2Req
---@field num1 integer
---@field num2 integer
---@field num3 integer
---@field num4 integer
---@field num5 integer
---@field num6 integer
---@field num7 integer
---@field num8 integer


---@class Test2Resp
---@field ret integer


---@class Test3Req
---@field userinfo UserInfo[]
---@field testb boolean


---@class Test3Resp
---@field ret integer
---@field testb boolean


-- 登录网关，重连后需要重发登录网关
---@class LoginGateReq
---@field aid integer
---@field subid integer
---@field zone_id integer
-- 重新连接后index需要递增
---@field index integer
-- local handshake = string.format("%s@%s#%s:%d", aid, zone_id, subid, index)
-- local hmac = crypt.hmac64(crypt.hashkey(handshake), secret)
---@field hmac string
---@field recon boolean 是否是断线重连


---@class LoginGateResp
-- 1 错误请求
-- 2 账户不存在
-- 3 index过期
-- 4 验证错误
-- 5 服务器内部错误
-- 6 用户已退出
-- 7 服务器繁忙
---@field ret integer


-- 打开界面日志
---@class OpenPanelReq
---@field panelName string
---@field source string


---@class OpenPanelResp
---@field ret integer


-- 是否可进入游戏
-- 防沉迷系统，是否需要重启热更
---@class CanEnterGameReq
---@field versionCode string
---@field versionBattle string 战斗版本


---@class CanEnterGameResp
---@field ret integer
---@field enterCode integer


-- 对时、加速外挂、连接检测请求
-- 10s请求一次（暂定），由客户端发起，如果20s内没有收到任何请求，假定客户端断线
-- 如果请求时间过快超过一定阈值及次数，则假定开启了加速外挂
-- 客户端可根据服务端时间进行对时
---@class TimeReq
-- 服务端当前秒数
---@field sec integer


---@class TimeResp
---@field ret integer
-- 服务端当前秒数
---@field sec integer
-- 服务端当前毫秒数
---@field msec integer
-- 服务端当前时区
---@field timeZone integer


---@class RegisterUserReq
---@field name string
---@field sex integer
---@field born integer
---@field head integer
---@field distinct_id string


---@class ErrorReason
---@field ret integer
---@field info string


---@class RegisterUserResp
---@field ret integer


---@class UserInfo
---@field aid integer
---@field uid integer
---@field zoneId integer
---@field name string
---@field sex integer
---@field exp integer 玩家经验值
---@field level integer 玩家等级
---@field head integer 头像
---@field borntime integer
---@field lastlogintime integer
---@field lastonlinetime integer
---@field nextResetTime integer
---@field lastResetTime integer
---@field servertime integer
---@field curBattlLevelId integer 当前战斗ID
---@field serverChannel string 服务器集群名，debug/debugtime
---@field heroList table<integer, HeroInfo> 英雄列表
---@field itemMap table<integer, ItemInfo> 道具列表
---@field formationMap table<integer, FormationData> 编队列表
---@field ticket TicketInfo 体力数据
---@field equipMap table<integer, EquipInfo> 装备列表
---@field onlyServerData UserOnlyServerData 用户后端零碎数据  TODO: 本地开发阶段需要保留
---@field pveLevelMap table<integer, PveLevelInfo> 关卡数据
---@field homeland HomeLandinfo 家园数据
---@field weaponMap table<integer, WeaponInfo> 武器列表
---@field missionList table<integer, MissionInfo> 任务信息
---@field userData UserData 用户数据
---@field handbookData table<integer, HandbookInfo> 图鉴数据
---@field skinList table<integer, SkinInfo> 皮肤列表
---@field posterData PosterData 看板娘信息
---@field gachaData GachaInfo 卡池相关数据
---@field headList table<integer, HeadData> 头像列表
---@field chapterAwardMap table<integer, ChapterAwardInfo> 章节奖励领取记录
---@field mailCollect table<integer, string> 邮件收藏记录
---@field affectionData AffectionDataInfo 好感度数据
---@field payDiamond table<integer, ResourceInfo> 充值货币
---@field guideInfoMap table<integer, integer> 引导数据
---@field technologyTree TechnologyTreeInfo 科技树数据
---@field generalShopData GeneralShopData 普通商店数据
---@field premiumShopMap table<integer, GoodsInfo> 充值商城数据 key: 商品id
---@field triggerEventMap table<integer, EventTriggerInfo> 事件触发器次数记录列表 key:EventTrigger配置ID
---@field dispatchData DispatchData 派遣数据
---@field regularActivityData RegularActivityInfo 周期活动数据
---@field extraRewardsMap table<integer, ExtraRewardsInfo> 资源关卡额外奖励信息
---@field funtionOpenMap table<integer, integer> 功能开放状态 key:功能ID value:状态 0未开放 1已开放 2已读
---@field userDefined string 自定义数据
---@field qnaireMap table<integer, QnaireInfo> 问卷调查数据 key:问卷ID
---@field genRoleFragData GenRoleFragInfo 跑片数据
---@field weatherForecastData WeatherForecastData 天气预报数据
---@field passDataMap table<integer, PassData> 通行证数据
---@field cycleCardDatas table<integer, CycleCardData> 周期卡数据 月卡 周卡
---@field signData table<integer, SignInfo> 签到数据
---@field activityMap table<integer, ActivityInfo> 活动信息
---@field miniPassMap table<integer, MiniPassInfo> 简易通行证数据
---@field combatIntelligenctInfo table<integer, CombatIntelligenceInfo> 紧急情报数据
---@field shareMap table<integer, ShareInfo> 分享奖励 key:分享类型


-- 分享数据
---@class ShareInfo
---@field count integer 今日分享次数
---@field isAlready boolean 是否已领奖


-- 资源数据
---@class ResourceInfo
---@field type integer
---@field num integer
---@field recharge integer 累计充值


-- 体力数据
---@class TicketInfo
---@field num integer 当前体力
---@field lastRecoverTime integer 上次恢复时间
---@field todayBuyCount integer 今日购买次数


-- 道具数据
---@class ItemInfo
---@field id integer 道具id
---@field num integer 数量
---@field expirationTime integer 过期时间


-- 装备数据
---@class EquipInfo
---@field id integer 实例化id
---@field cid integer 配置id
---@field level integer 等级
---@field exp integer 经验值
---@field star integer 星级
---@field ownerId integer 佩戴装备的英雄id
---@field isLock boolean 是否锁定


---@class HomelandActionInfo
---@field actionId integer 当前行为
---@field lastActionId integer 上次行为
---@field beginTime integer 开始时间


-- 英雄数据
---@class HeroInfo
---@field id integer 配置id
---@field level integer 等级
---@field exp integer 经验值
---@field star integer 星级
---@field equipSkin integer 已穿戴皮肤
---@field getTime integer 获得时间
---@field name string 名称
---@field isInHome boolean 是否在家园中
---@field carryEquip table<integer, integer> 携带装备
---@field talentTreeList integer[] 技能树列表
---@field talentTreeStage integer[] 技能树阶段列表
---@field EquippedSkillList integer[] 已装备技能id组
---@field carryWeapon table<integer, integer> 携带武器
---@field affectionLevel integer 好感度等级
---@field affectionExp integer 好感度经验值
---@field affectionEvent integer 好感度事件id 空为0
---@field energy integer 体力值
---@field affectionRewardList integer[] 好感度奖励领取记录列表
---@field attributeValList HeroHomelandAttributeValue[] 在家园中的属性（饱腹感、舒适度）
---@field homelandActionInfo HomelandActionInfo 家园当前行为
---@field getStarRewardFlag boolean 是否领取过升星奖励
---@field interactionInfo integer 交互数据
---@field voiceType integer 语音种类


-- 英雄改名请求
---@class HeroChangeNameReq
---@field id integer 英雄配置id，对应CharacterTable表的id
---@field newName string 新名字


-- 英雄改名返回
---@class HeroChangeNameResp
---@field ret integer ActionFailReason
-- None, 成功
-- HeroNoFind, 没有找到英雄信息
-- NameInvalid, 名字不合法
-- NameTooLong, 名字过长


-- 英雄升级
---@class HeroLevelUpReq
---@field id integer 英雄配置id，对应CharacterTable表的id
---@field upLevel integer 目标等级


-- 英雄升级返回
---@class HeroLevelUpResp
---@field ret integer ActionFailReason
-- None, 成功
-- HeroNoFind, 没有找到英雄信息
-- HeroAlreadyLevel, 已经是目标等级
-- CfgNotFind, 升级等级不合法
-- ItemNoEnough, 道具不足


-- 英雄升星
---@class HeroStarUpReq
---@field id integer 英雄配置id，对应CharacterTable表的id


-- 英雄升星返回
---@class HeroStarUpResp
---@field ret integer ActionFailReason
-- None, 成功
-- HeroNoFind, 没有找到英雄信息
-- CfgNotFind, 没有找到英雄配置
-- ItemNoFind, 没有找到升星道具
-- ItemNoEnough, 道具不足
-- HeroStarMax, 星级已满
---@field rewardList RewardInfo[] 奖励列表


-- 请求领取英雄星级奖励
---@class GetHeroStarRewardReq
---@field id integer 英雄实例化id


-- 请求领取英雄星级奖励返回
---@class GetHeroStarRewardResp
---@field ret integer ActionFailReason
-- None, 成功
-- HeroNoFind, 没有找到英雄信息
-- CfgNotFind, 没有找到英雄配置
-- HeroStarRewardAlreadyGet, 星级奖励已领取
-- HeroStarNotEnough, 星级不足
---@field rewardList RewardInfo[] 奖励列表


-- 编队数据
---@class FormationData
---@field id integer
---@field formationList FormationInfo[]


-- 请求更改编队信息
---@class ChangeFormationListReq
---@field id integer
---@field formationList FormationInfo[]


---@class FormationInfo
---@field roleCid integer
---@field blockIndex integer


-- 更改编队信息返回
---@class ChangeFormationListResp
---@field ret integer
-- FormationFail_InvalidId，如果编队 id 越界
-- FormationFail_InvalidRole, 如果阵容英雄数量超过上限
-- FormationFail_NoRole,设置的英雄 id 不存在
-- FormationFail_SameRole, 存在设置同样的英雄 id


-- 消耗体力请求
---@class UseNormalTicketReq
---@field num integer


-- 消耗体力信息返回
---@class UseNormalTicketResp
---@field ret integer


-- 恢复体力刷新请求
---@class RecoverNormalTicketReq


---@class RecoverNormalTicketResp
---@field ret integer


-- 装备升级请求
---@class AddEquipExpReq
---@field id integer 装备的实例化 id
---@field useList CostInfo[] 消耗物品列表, 在升级的时候消耗的物品列表，CostInfo中的 id 是装备的实例化 id 和道具（110051, 110052, 110053, 110054）
-- CostInfo中的 type 是道具类型，对应GE.RewardType中的值。equip 是 3，item 是 1


-- 装备升级返回
---@class AddEquipExpResp
---@field ret integer
-- EquipNoFind, 装备不存在，这个是针对使用装备来升级装备的时候
-- EquipIsLock, 装备已锁定 这个是针对狗粮装备的异常
-- EquipIsEquip, 装备已装备 这个是针对狗粮装备的异常
-- ParameterInvalid, 参数错误 --自己来升级自己的情况下
-- 针对使用道具来升级装备的情况下：
-- NotLevelUpMaterial, 不是升级材料
-- ItemNoEnough, 道具不足
-- CfgNotFind, 没有找到相关配置
-- CurrencyNoEnough, 金币不足


-- 消耗物品结构
---@class CostInfo
---@field id integer 如果是武器和装备，则这个 id 是实例化id，如果是其他的道具，这个是道具的类型 id
---@field type integer 道具类型，对应GE.RewardType中的值
---@field num integer 数量


-- 用户后端零碎数据
---@class UserOnlyServerData
---@field nowEquipLimitId integer 当前装备最大实例化id
---@field nowWeaponLimitId integer 当前武器最大实例化id


-- 装备升星突破请求
---@class AddEquipStarReq
---@field id integer 装备的实例化 id
---@field useIdList integer[] 这里面的 userIdList 是装备的实例化 id，不包含其他的升星道具信息，其他的信息是通过查表获得的


-- 装备升星突破返回
---@class AddEquipStarResp
---@field ret integer
-- EquipNoFind, 装备不存在
-- CfgNotFind, 没有找到相关配置（这是一个内部错误，这个难以测试）
-- EquipLevelNotEnough, 升星是需要达到一定的等级需求，比如，5，10，15，20，25，30
-- EquipIsLock, 装备已锁定
-- EquipIsEquip, 装备已装备
-- ParameterInvalid, 参数错误, 判断消耗装备不能是自己
-- NotStarUpMaterial, 不是升级材料，这个是内部配置错误
-- ItemNoEnough, 道具不足
-- CurrencyNoEnough, 货币不足


-- 装备分解请求
---@class DecomposeEquipReq
---@field idList integer[] 待分解的装备实例化id列表


-- 装备分解返回
---@class DecomposeEquipResp
---@field ret integer
-- EquipNoFind, 装备不存在
-- EquipIsLock, 装备已锁定
-- EquipIsEquip, 装备已装备
-- CfgNotFind, 没有找到相关配置，这是一个内部错误
---@field rewardList RewardInfo[]


-- 英雄穿戴装备请求
---@class SetCharEquipReq
---@field charId integer 英雄id，这个id是配置id，针对 CharacterTable 表的 id
---@field partId integer 部位id，取值范围 1-4
---@field equipId integer 装备id，实例化 id


-- 英雄穿戴装备返回
---@class SetCharEquipResp
---@field ret integer
-- HeroNoFind, 英雄不存在
-- EquipNoFind, 装备不存在
-- ParameterInvalid, 参数错误, partId不合法,部位不匹配
-- CfgNotFind, 没有找到相关配置, 装备的配置信息没找到，英雄具体的配置信息没找到，这个是内部错误


-- 英雄装备卸下请求
---@class RemoveCharEquipReq
---@field equipId integer 装备实例化 id


-- 英雄装备卸下返回
---@class RemoveCharEquipResp
---@field ret integer
-- EquipNoFind, 装备不存在
-- HeroNoFind, 装备本身所在的英雄不存在，这是一个内部错误


-- 更改装备锁定状态请求
---@class ChangeEquipLockStateReq
---@field equipId integer 装备实例化 id


-- 更改装备锁定状态返回
---@class ChangeEquipLockStateResp
---@field ret integer
-- EquipNoFind, 装备不存在


-- 英雄装备技能请求
---@class EquipHeroSkillReq
---@field heroId integer 英雄id
---@field skillList integer[] 技能列表，SkillTable表id


-- 英雄装备技能返回
---@class EquipHeroSkillResp
---@field ret integer ActionFailReason
-- None, 成功
-- HeroNoFind, 没有找到英雄信息
-- SkillSlotMax, 技能槽已满
-- SkillNotHas, 技能未拥有
-- ParameterInvalid, 参数不合法


-- ==============好感度================ TODO: 功能制作中
-- 请求赠送英雄好感度礼物
---@class HeroAffectionGitfReq
---@field id integer 英雄id
---@field giftId integer 礼物id，道具id
---@field count integer 数量


-- 请求赠送英雄好感度礼物返回
---@class HeroAffectionGitfResp
---@field ret integer ActionFailReason
-- None, 成功
-- ParameterInvalid, 英雄ID不正确
-- HeroNoFind, 英雄不存在
-- ParameterInvalid, 礼物ID不正确
-- ItemNoFind, 没有找到道具配置
-- ItemNoEnough, 道具不足
-- CfgNotFind, 好感度等级不存在
-- AffectionLevelMax, 好感度等级已满
-- AffectionExpMax, 当前经验已满
---@field rewardList RewardInfo[] 奖励列表


-- 请求领取英雄好感度等级奖励
---@class HeroAffectionRewardReq
---@field id integer 英雄id
---@field level integer 所领取好感度等级


-- 请求领取英雄好感度等级奖励返回
---@class HeroAffectionRewardResp
---@field ret integer ActionFailReason
-- None, 成功
-- ParameterInvalid, 英雄ID不正确
-- HeroNoFind, 英雄不存在
-- CfgNotFind, 没有找到好感度配置
-- AffectionLevelMax, 好感度等级已满
-- AffectionExpNotEnought, 经验值不足
---@field rewardList RewardInfo[] 奖励列表


-- 好感度事件信息
---@class AffectionEventInfo
---@field id integer 事件id
---@field state integer 事件状态 开启1 关闭0


-- 接受好感度事件请求
---@class AcceptAffectionEventReq
---@field id integer 事件id
---@field selectIndex integer 选项索引


-- 接受好感度事件返回
---@class AcceptAffectionEventResp
---@field ret integer ActionFailReason
-- None, 成功
-- LackParameter, 缺少参数
-- AffectionEventNoFind, 好感度事件不存在
-- AffectionEventStateNotOpen, 好感度事件状态未开启
-- CfgNotFind, 配置不存在
-- OptionIndexError, 选项索引错误
-- HeroNoFind, 英雄不存在
-- EventNotOnCharacter, 事件不在英雄身上
---@field rewardList RewardInfo[] 奖励列表 或为空


-- 请求完成好感度事件委托
---@class DelegateEventFinishReq
---@field id integer 委托id 与事件id相同


-- 请求完成好感度事件委托返回
---@class DelegateEventFinishResp
---@field ret integer ActionFailReason
-- None, 成功
-- LackParameter, 缺少参数
-- DelegateEventNoFind, 委托事件不存在
-- DelegateEventStateNotUnclaimed, 委托事件状态未完成
---@field rewardList RewardInfo[] 奖励列表


-- 好感度数据
---@class AffectionDataInfo
---@field limitCount integer 每日已触发次数
---@field affectionEventMap table<integer, AffectionEventInfo> 好感度事件列表 key：homeEvent配置ID
---@field delegateEventList integer[] 事件委托列表


-- 事件触发器记录信息
---@class EventTriggerInfo
---@field id integer 事件id
---@field count integer 触发次数
---@field progress integer 进度


-- ==============================
-- 关卡数据
---@class PveLevelInfo
---@field id integer 关卡id
---@field state integer 关卡状态
---@field star integer 通关星级
---@field achieveList integer[] 已完成成就列表
---@field completeNum integer 通关次数
---@field battleNum integer 战斗次数
---@field dailyBattleNum integer 当天战斗次数


-- 请求解锁天赋树节点
---@class TalentTreeUnLockPointReq
---@field talentID integer 天赋id，天赋节点=天赋树组+按规则定义的 id，对接 TalentTreeTable中的 id
---@field heroId integer 英雄id


---@class TalentTreeUnLockPointResp
---@field ret integer
-- HeroNoFind, 英雄不存在
-- CfgNotFind, 没有找到相关配置
-- LackOfPrecond, 前置条件未满足
-- ItemNoEnough, 道具数量不足
-- ParameterInvalid, 重复获得
-- CurrencyNoEnough，资源不足


-- 请求解锁天赋树阶段
---@class TalentTreeStageUnlockReq
---@field stageID integer 阶段id
---@field heroId integer 英雄id


---@class TalentTreeStageUnlockResp
---@field ret integer
-- CfgNotFind,stageId 没找到相关配置
-- HeroNoFind, 英雄没有找到
-- LackOfPrecond, 前置条件未满足


-- 跑片数据
---@class GenRoleFragInfo
---@field availableCount integer 当日生成次数
---@field genRoleList integer[] 当日已生成过的英雄列表


-- 请求跑片开始
---@class GenRoleFragStartReq
---@field roleIdList integer[] 跑片英雄idlist


---@class GenRoleFragStartResp
---@field ret integer
---@field list RewardInfo[] 奖励数据


-- 签到数据
---@class SignInfo
---@field signIndex integer 当前签到天数
---@field alreadyAwards integer[] 已领奖励


-- 活动数据
---@class ActivityInfo
---@field state integer 活动状态 1--未开放 2--开放 3--已结束 4--已完成


-- 迷你通行证数据
---@class MiniPassInfo
---@field openExtraReward boolean 是否开启额外奖励


-- 请求签到奖励领取
---@class GetSignRewardReq
---@field signId integer 签到id
---@field signIndex integer 签到index


---@class GetSignRewardResp
---@field ret integer
---@field list RewardInfo[] 奖励数据


-- 科技树数据
---@class TechnologyTreeInfo
---@field researchLevelList integer[] 研究等级
---@field researchExpList integer[] 当前经验值
---@field treeNodeMap table<integer, integer> 树节点数据 key groupId value level


-- 请求解锁科技树阶段
---@class TechnologyTreeUnlockReq
---@field groupId integer 当前节点id


---@class TechnologyTreeUnlockResp
---@field ret integer
-- TechTreeNodeNotExist, 根据 groupId 没有找到对应的节点
-- TechTreeNodeMaxLevel，节点等级已满，这个是一个内部数据错误，需要伪造数据
-- TechTreeLevelNotEnough，等级不对，某一些节点需要达到一定的等级才能解锁
-- TechTreePreNodeNotUnlock, 解锁前置节点失败
-- ItemNoEnough, 道具不足


-- 派遣开始请求
---@class DispatchStartReq
---@field dispatchId integer 派遣id
---@field lineId integer 路线id
---@field roleIdList integer[] 派遣英雄


---@class DispatchStartResp
---@field ret integer


-- 派遣结束请求
---@class DispatchEndReq
---@field dispatchIdList integer[] 派遣id


---@class DispatchEndResp
---@field ret integer
---@field rewardList RewardInfo[] 点位奖励


-- 派遣章节奖励领取
---@class DispatchChapterRewardReq
---@field chapterId integer


---@class DispatchChapterRewardResp
---@field ret integer
---@field rewardList RewardInfo[] 奖励


-- 派遣数据
---@class DispatchData
---@field finishRouteList integer[] 派遣过的路线
---@field rewardRecordList integer[] 领奖记录
---@field dispatchTaskList table<integer, DispatchTaskInfo> 派遣任务数据 key DispatchTable id
---@field dispatchRandomTaskList table<integer, DispatchRandomTaskInfo> 随机任务数据 key DispatchTable id


-- 派遣路线数据
---@class DispatchTaskInfo
---@field dispatchId integer 派遣id
---@field lineId integer 路线id
---@field state integer 状态  1派遣中 2派遣完成
---@field finishTime integer 派遣结束时间
---@field roleIdList integer[] 派遣英雄
---@field pointInfo DispatchPointData[] 点位数据


-- 派遣点位数据
---@class DispatchPointData
---@field showTime integer 展示时间
---@field beginEnergy integer[] 初始精力
---@field endEnergy integer[] 结束精力
---@field reward RewardInfo[] 点位奖励


-- 派遣随机任务数据
---@class DispatchRandomTaskInfo
---@field dispatchId integer 派遣id
---@field endTime integer 任务消失时间
---@field lineId integer 关联路线id


-- 家园数据
---@class HomeLandinfo
---@field buildingList table<integer, HomeBuilding> 功能建筑数据
---@field rolePreRoom table<integer, integer> 英雄归属房间
---@field homeWalkHeroList integer[] 家园散步英雄列表
---@field lastUpdateStorageTime integer 一直会自然增长 在线不在线 在不在家园都会增加
---@field storageItemList RewardInfo[] 仓库道具
---@field lastUpdateEarningsTime integer 只有不在家园时候才会增长 = 0表示在家园
---@field earningsItemList RewardInfo[] 离线收益
---@field coveProps table<integer, CovePropsInfo> 互动物件道具信息
---@field coveBattleData CoveBattleData
---@field coveBoxRewards table<integer, CoveBoxReward>
---@field prosperityInfo ProsperityInfo 繁荣度数据


-- 繁荣度数据
---@class ProsperityInfo
---@field currentLevel integer 当前繁荣等级
---@field dailyProsperityCount integer 今日行为渠道已累计繁荣值（跨天重置）
---@field globalConditionProgress table<integer, integer> 全局累计条件进度 key:conditionType value:累计值


-- 功能建筑
---@class HomeBuilding
---@field id integer 建筑id
---@field lastGenTime integer 上次产出时间
---@field level integer 建筑等级
---@field output HomeLandOutput[] 功能建筑已生产的资源 repeated自定义数据结构为空的时候通过resp传给客户端 output = 空 传不过来
---@field disposeHeroList integer[] 部署英雄


-- 功能建筑产出
---@class HomeLandOutput
---@field id integer 产出道具id
---@field num integer 产出数量
---@field type integer 类型


-- 领取家园建筑产出请求 多个
---@class GetBuildingsRewardReq
---@field constIds integer[] 功能建筑id


---@class GetBuildingsRewardResp
---@field ret integer
-- BuildingNotExist, 建筑不存在
-- BuildingNoOutput, 当前建筑还没有产出
---@field rewardList RewardInfo[]


-- 前端随机的散步英雄同步
---@class SetHomeShowHeroReq
---@field heroIdList integer[] 英雄id列表
---@field constructIdList integer[] 建筑id列表，家园的建筑物id, 10001~10013


---@class SetHomeShowHeroResp
---@field ret integer
-- HeroNoFind, 英雄不存在
-- BuildingNotExist, 建筑不存在
-- ParameterInvalid, 参数错误(参数数量不匹配)


-- 家园中建筑的部署英雄
---@class HomeDispose
---@field constructionId integer 功能建筑id
---@field heroIdList integer[] 英雄id列表


-- 设置家园中建筑的部署英雄
---@class SetHomeDisposesHeroReq
---@field homeDisposesHero HomeDispose[]


---@class SetHomeDisposesHeroResp
---@field ret integer


-- 设置家园中建筑的散步英雄
---@class SetHomeWalkHeroReq
---@field heroIdList integer[] 英雄id列表  -- 0代表随机


---@class SetHomeWalkHeroResp
---@field ret integer
-- LackParameter, 缺少参数
-- HeroNoFind, 英雄不存在
-- HeroInWork, 英雄正在工作
-- HomeWalkMax, 家园散步英雄已满


-- 家园升级请求
---@class HomeLvUpReq
---@field constructionId integer 功能建筑id


---@class HomeLvUpResp
---@field ret integer


-- 重复战斗请求
---@class BattleRepeatReq
---@field levelId integer 关卡id
---@field repeatNum integer 重复次数
---@field formationId integer 队伍id


---@class BattleRepeatResp
---@field ret integer
-- ParameterInvalid 重复次数不合法
-- CfgNotFind 关卡不存在
-- LevelNoPass 关卡未通关
-- TicketNoEnough 体力不足
---@field rewardList RewardInfo[]
---@field singleRewardList table<integer, SingleRewardInfo>
---@field extraRewardList RewardInfo[]
---@field extraSingleList table<integer, SingleRewardInfo>


---@class SingleRewardInfo
---@field list RewardInfo[]


-- 武器数据
---@class WeaponInfo
---@field id integer 实例化id
---@field cid integer 配置id
---@field level integer 等级
---@field exp integer 经验值
---@field ownerId integer 佩戴装备的英雄id
---@field isLock boolean 是否锁定
---@field accuracy integer 命中率
---@field quality integer 工艺值
---@field attributeList table<integer, WeaponEntry> 武器词条


-- 武器词条数据
---@class WeaponEntry
---@field id integer 词条id
---@field coefficient integer 词条系数
---@field special boolean 特殊强化


-- 武器分解请求
---@class DecomposeWeaponReq
---@field idList integer[] 待分解的武器实例化id列表


-- 武器分解返回
---@class DecomposeWeaponResp
---@field ret integer
-- WeaponNoFind, 武器不存在
-- WeaponIsLock, 武器已锁定
-- CfgNotFind, 没有找到相关配置
-- todo:装备如果已经被装备了，应该不能分解
---@field rewardList RewardInfo[]


-- 武器锁定状态修改请求
---@class ChangeWeaponLockStateReq
---@field weaponId integer 武器实例化id


-- 武器锁定状态修改返回
---@class ChangeWeaponLockStateResp
---@field ret integer
-- WeaponNoFind, 武器不存在


-- 英雄装备武器请求
---@class SetCharWeaponReq
---@field charId integer 英雄id
---@field partId integer 部位id, 1-4
---@field weaponId integer 武器id, 实例化 id


-- 英雄装备武器返回
---@class SetCharWeaponResp
---@field ret integer
-- HeroNoFind, 英雄不存在
-- WeaponNoFind, 武器不存在
-- ParameterInvalid, 参数错误
-- WeaponUnLockPart, 武器部位未解锁


-- 英雄卸下武器请求
---@class RemoveCharWeaponReq
---@field weaponId integer 武器id


-- 英雄卸下武器返回
---@class RemoveCharWeaponResp
---@field ret integer
-- WeaponNoFind, 武器不存在
-- HeroNoFind, 武器本身所在的英雄不存在，这是一个内部错误


-- 升级武器请求
---@class AddWeaponExpReq
---@field weaponId integer 武器实例化id
---@field useList CostInfo[] 消耗物品列表, 在升级的时候消耗的物品列表，CostInfo中的 id 是武器的实例化 id 和道具（？？？）
-- CostInfo中的 type 是道具类型，对应GE.RewardType中的值。


-- 升级武器返回
---@class AddWeaponExpResp
---@field ret integer
-- WeaponNoFind, 武器不存在
-- CfgNotFind, 没有找到相关配置，内部错误
-- ParameterInvalid, 参数错误
-- WeaponIsLock, 武器已锁定
-- WeaponIsEquip, 武器已装备
-- ItemNoEnough, 升级道具不足


-- 融合武器请求
---@class FuseWeaponReq
---@field fuseList FuseWeaponInfo[] 待融合的武器列表


-- 融合武器返回
---@class FuseWeaponResp
---@field ret integer
-- ParameterInvalid，参数错误，数量不对，锁定的数量不对，lockgroupId 身上没有
-- WeaponNoFind, 武器不存在
-- ItemNoFind, 没有找到融合道具，内部错误
-- ItemNoEnough, 道具不足
-- WeaponIsLock, 武器已锁定
-- WeaponIsEquip, 武器已装备
-- WeaponLevelNotEnough, 武器等级不够
-- WeaponErrorRare,  --武器稀有度错误
-- CfgNotFind, 没有找到相关配置，内部错误
---@field newWeaponId integer 新武器实例化id


-- 融合武器信息
---@class FuseWeaponInfo
---@field weaponId integer 武器实例化id
---@field lockGroupId integer 锁定的词条id


-- 武器制造请求
---@class WeaponProductionReq
---@field blueprintId integer 图纸id
---@field count integer 生产数量


-- 武器制造请求
---@class WeaponProductionResp
---@field ret integer
-- CfgNotFind, 没有找到相关配置
-- ItemNoFind, 没有找到制造道具
-- ItemNoEnough, 图纸不够
---@field rewardList RewardInfo[] 奖励列表


-- 图鉴信息
---@class HandbookInfo
---@field data table<integer, HandbookData>


-- 图鉴内容结构(等需要内容时增加对应字段)
---@class HandbookData
---@field getTime integer 获得时间
---@field count integer 拥有数量(仅装备和武器类型使用，剧情和怪物默认为0)
---@field isCollected boolean 是否已收藏，默认为false(未收藏)


-- 请求修改图鉴收藏状态（自动反转当前状态）
---@class SetHandbookCollectedReq
---@field bookType integer 图鉴类型 HandbookType
---@field id integer 图鉴id


---@class SetHandbookCollectedResp
---@field ret integer ActionFailReason
-- None, 成功
-- HandbookNoFind, 图鉴不存在（未解锁的图鉴不能收藏）
-- ParameterInvalid, 参数错误
---@field isCollected boolean 操作后的收藏状态


-- 皮肤信息
---@class SkinInfo
---@field getTime integer 获得时间


-- 请求穿戴皮肤
---@class EquipSkinReq
---@field heroId integer 英雄id
---@field skinId integer 皮肤id, CharacterSkinTable表的id


-- 请求穿戴皮肤回调
---@class EquipSkinResp
---@field ret integer ActionFailReason
-- None, 成功
-- HeroNoFind, 没有找到英雄信息
-- SkinNotHas, 没有找到皮肤信息


-- 看板娘信息
---@class PosterData
---@field SkinId integer 皮肤id
---@field PosX integer 位置x
---@field PosY integer 位置y
---@field Size integer 缩放


-- 设置看板娘
---@class SetPosterDataReq
---@field posterId integer 看板娘id, CharacterSkinTable表的id


---@class SetPosterDataResp
---@field ret integer ActionFailReason
-- None, 成功
-- SkinNotHas, 没有找到看板娘信息


-- 更改看板娘位置缩放
---@class SetPosterPosReq
---@field PosX integer
---@field PosY integer
---@field Size integer


---@class SetPosterPosResp
---@field ret integer


---@class GachaInfo
---@field countMap table<integer, GachaCountInfo> 卡池计数组数据
---@field recordData GachaRecordInfo 抽卡记录
---@field guarantMap table<integer, GachaGuarantInfo> 卡池保底次数


---@class GachaCountInfo
---@field num integer 计数
---@field totalNum integer 总抽取数


---@class GachaGuarantInfo
---@field data table<integer, integer> 卡池对应计数组保底次数


---@class GachaRecord
---@field raffleId integer 卡池id
---@field type integer 奖励类型
---@field id integer 具体id
---@field gachaTime integer 抽取时间


---@class GachaRecordInfo
---@field count integer 上传次数
---@field tempUrlList table<integer, string> 上传路径, key: 上传序号， value: 上传路径
---@field recordList GachaRecord[] 抽卡记录


-- ============================
-- 初始信息
-- 请求时机由客户端自定，这个时机只是一般性考量
-- ============================
-- 数数日志公共事件属性记录
---@class RecordSuperPropertiesReq
---@field info SuperPropertiesInfo


-- 公共事件属性
---@class SuperPropertiesInfo
---@field zone_offset integer 时区偏移
---@field screen_height integer 屏幕高度
---@field screen_width integer 屏幕宽度
---@field country_code string 国家地区代码
---@field ip string 客户端ip
---@field province string 省份
---@field country string 国家地区
---@field city string 城市
---@field lib_version string SDK版本
---@field os string 操作系统
---@field device_id string 设备号
---@field bundle_id string 应用包名
---@field device_model string 设备型号
---@field system_language string 系统默认语言
---@field network_type string 网络类型
---@field lib string SDK类型
---@field os_version string 操作系统版本
---@field app_version string app版本
---@field simulator boolean 是否为模拟器
---@field install_time integer App安装时间


---@class RecordSuperPropertiesResp
---@field ret integer


-- 获取英雄信息
---@class UserInfoReq
---@field uid integer
---@field part boolean
---@field channel integer
---@field deviceType integer
---@field deviceSubType integer


---@class UserInfoResp
-- 1 英雄不存在
---@field ret integer
---@field user_info UserInfo
---@field over boolean


---@class UserListReq


---@class UserListResp
---@field ret integer
---@field user_infos UserInfo[]


-- 获得某功能数据
---@class GetFunctionDataReq
---@field functions string[] 样例"mailCollect"、"passDataMap"


---@class GetFunctionDataResp
---@field ret integer
---@field functions string[]


---@class CharDelReq
---@field uid integer


---@class CharDelResp
---@field ret integer


---@class EnterSceneReq
---@field reEnter boolean
---@field chatline integer
-- 暂时只用作选完英雄进入游戏场景，后面可用作跳转地图通用协议
---@field channel integer
---@field deviceType integer
---@field deviceSubType integer


---@class EnterSceneResp
---@field ret integer
---@field notDealedMailNum integer


---@class UserInfoUpdate
---@field userinfo UserInfo


---@class KickNtf
-- 1 另一个地方登录，2 账号被踢
---@field reason integer


-- 未满18岁游戏超时通知
---@class None18OvertimeNtf
---@field enterCode integer


---@class GameVersionNeedUpdateNtf


-- 请求恢复体力
---@class BuyNormalTicketReq
---@field mode integer 模式，GE.TicketAddType
---@field id integer id，mode=1时，id是道具id，mode=2时，id不用传
---@field num integer 数量，mode=1时，num是购买数量，mode=2时，num不用传


---@class BuyNormalTicketResp
---@field ret integer ActionFailReason
-- None, 成功
-- ItemNoEnough, 道具不足
-- CfgNotFind, 没有找到道具配置
-- ParameterInvalid, 参数错误
-- TicketBuyMax, 购买次数已达上限
-- CurrencyNoEnough, 货币不足


---@class RewardInfo
---@field id integer 对应类型表的id
---@field type integer 对应类型表的类型
---@field num integer 数量
---@field extraType integer 额外类型


-- 请求读取功能
---@class ReadFunctionReq
---@field functionId integer 功能id


-- 请求读取功能返回
---@class ReadFunctionResp
---@field ret integer ActionFailReason


-- 抽卡
---@class StartRaffleReq
---@field raffleId integer 卡池id，GachaPoolTable表的id
---@field count integer 抽卡次数，1、10


---@class StartRaffleResp
---@field ret integer ActionFailReason
-- None, 成功
-- ParameterInvalid, 参数错误
-- CfgNotFind, 卡池不存在
-- ActivityNotOpen, 卡池未开启
-- ItemNoEnough, 道具不足
---@field rewardList RewardInfo[]


-- 卡池测试
---@class TestRaffleReq
---@field raffleId integer
---@field count integer


---@class TestRaffleResp
---@field ret integer
---@field rewardList RewardInfo[]


-- 引导抽卡协议
---@class GuideRaffleReq


---@class GuideRaffleResp
---@field ret integer
---@field rewardList RewardInfo[]


-- 记录引导id
---@class ChangeGuideIDReq
---@field guideType integer
---@field guideId integer


---@class ChangeGuideIDResp
---@field ret integer
---@field guideInfoMap table<integer, integer>


-- 请求更换签名
---@class ChangeSignReq
---@field signTxt string


-- 请求更换签名返回
---@class ChangeSignResp
---@field ret integer


-- 头像信息
---@class HeadData
---@field getTime integer 获得时间


-- 请求更换头像
---@class ChangeHeadReq
---@field HeadId integer


-- 请求更换头像返回
---@class ChangeHeadResp
---@field ret integer


-- 请求更换名字
---@class ChangeNameReq
---@field newName string


---@class ChangeNameResp
---@field ret integer


-- 章节星级奖励信息
---@class ChapterAwardInfo
---@field getTime integer 获得时间


-- 请求领取章节奖励
---@class GetChapterAwardReq
---@field id integer


---@class GetChapterAwardResp
---@field ret integer
---@field rewardList RewardInfo[]


-- 周期活动数据
---@class RegularActivityInfo
---@field simulatedActivity SimulatedActivityInfo 模拟演习
---@field bossActivity BossActivityInfo 危境攻坚


-- 模拟演习信息
---@class SimulatedActivityInfo
---@field simulatedLevelMap table<integer, SimulatedLevelInfo> 关卡层数据
---@field maxFloor integer 往期最高层
---@field nowPeriod integer 当前期数
---@field closingTime integer 当期结束时间


-- 模拟演习关卡层信息
---@class SimulatedLevelInfo
---@field getReward boolean 是否领取层奖励
---@field levelList integer[] 已通关关卡列表


-- 请求领取模拟演习层奖励
---@class GetSimulatedAwardReq
---@field floorId integer


---@class GetSimulatedAwardResp
---@field ret integer
---@field rewardList RewardInfo[]


-- 请求模拟演习扫荡战斗
---@class SimulatedSweepReq
---@field formationId integer


---@class SimulatedSweepResp
---@field ret integer
---@field rewardList RewardInfo[]


-- 危境攻坚信息
---@class BossActivityInfo
---@field bossLevelMap table<integer, BossLevelInfo> boss相关数据
---@field scoreRewardList integer[] 当期分数奖励列表
---@field nowPeriod integer 当前期数
---@field closingTime integer 当期结束时间


-- 危境攻坚Boss信息
---@class BossLevelInfo
---@field nowScore integer 当前分数
---@field maxScore integer 往期最高分数
---@field maxDifficulty integer 最高通过难度
---@field tagList integer[] boss所选Tag列表


-- 请求领取危境攻坚Boss积分奖励
---@class GetBossScoreAwardReq
---@field scoreId integer 积分任务id（填0则领取所有）


---@class GetBossScoreAwardResp
---@field ret integer
---@field rewardList RewardInfo[]


-- 请求更新危境攻坚Boss战所选tag
---@class SetWeeklyBossTagReq
---@field bossId integer Boss ID
---@field tagList integer[] Tag列表


---@class SetWeeklyBossTagResp
---@field ret integer


-- 材料关卡额外奖励信息
---@class ExtraRewardsInfo
---@field count integer
---@field extraCount integer 额外次数


-- 请求打开道具礼包
---@class OpenGiftPackReq
---@field id integer
---@field num integer
---@field selectIndex integer


---@class OpenGiftPackResp
---@field ret integer
---@field rewardList RewardInfo[]


-- 请求修改英雄语种
---@class SetCharVoiceReq
---@field idList integer[] 英雄id列表
---@field type integer 语种


---@class SetCharVoiceResp
---@field ret integer


-- 请求修改英雄初始语种
---@class SetCharInitVoiceReq
---@field type integer 语种


---@class SetCharInitVoiceResp
---@field ret integer


-- ///////////////// 邮件相关 ///////////////////
---@class MailInfo
---@field id integer
---@field state integer
---@field stamp integer
---@field title string
---@field content string
---@field extra MailExtra
---@field reward RewardInfo[]


---@class MailExtra
---@field sender string


-- 邮件列表请求
---@class MailListReq
---@field stamp integer


---@class MailListResp
---@field ret integer
---@field mailList MailInfo[]
---@field stamp integer


-- 邮件操作请求
---@class MailActionReq
---@field id integer
---@field action integer


---@class MailActionResp
---@field ret integer
---@field rewards RewardInfo[]


---@class MailNtf
---@field mails MailInfo[]


-- 收藏邮件，此功能邮件数据隔离
---@class MailCollectReq
---@field id integer


---@class MailCollectResp
---@field ret integer
---@field mailList MailInfo[]


-- ///////////////// 公告相关 ///////////////////
-- 公告更新
---@class NoticeNtf


-- /////////////////成就相关（真 任务系统）/////////////////
-- /任务信息
---@class MissionInfo
---@field id integer 任务ID
---@field state integer 状态
---@field progress integer 总进度
---@field type integer 类型   系统标识 1 task 2 affection 加个枚举
---@field conditionProgress table<integer, integer> 任务条件进度列表 key:条件类型ID value:当前进度


-- /领取任务奖励请求
---@class GetMissionRewardReq
---@field idList integer[] 任务id列表


---@class GetMissionRewardResp
---@field ret integer ActionFailReason
-- None, 成功
-- TaskNoFind, 未找到任务信息
-- CfgNotFind, 未找到任务配置表
-- TaskNoFinish, 任务状态不正确
---@field rewardList RewardInfo[]


-- 提交领取任务奖励
---@class SubmitClaimMissionRewardReq
---@field idList integer[] 任务id列表


---@class SubmitClaimMissionRewardResp
---@field ret integer ActionFailReason
---@field rewardList RewardInfo[]


-- 用户数据
---@class UserData
---@field LoginDay integer 登陆天数
---@field AchieveLevel integer 成就等级
---@field AchieveExp integer 成就经验值
---@field UserSign string 玩家签名
---@field TotalGachaNum integer 玩家抽卡总次数
---@field GetSSRNum integer 玩家获得的SSR数量
---@field LevelMainMax integer 主线最大关卡
---@field GotGuideGachaAward boolean 是否获取引导抽卡奖励
---@field LastDailyRefreshTime integer 上次跨天刷新时间，（关卡额外次数奖励可用）
---@field LevelDifficultMax integer 困难最大关卡
---@field handbookMigrated boolean 图鉴数据是否已迁移
---@field SevenDayTaskCurrentDay integer 七日任务当前天数（0表示未开启，1-7表示第几天）
---@field GotGuideBlueprintAward boolean 是否获取引导蓝图奖励
---@field CharInitVoice integer 英雄初始语种


-- 战斗英雄数据
---@class BattleHeroInfo
---@field id integer 配置id
---@field level integer 等级
---@field exp integer 经验值
---@field star integer 星级
---@field equipSkin integer 已穿戴皮肤
---@field getTime integer 获得时间          --TODO: 改为创建时间
---@field name string 名称
---@field isInHome boolean 是否在家园中
---@field carryEquip table<integer, integer> 携带装备
---@field talentTreeList integer[] 技能树列表
---@field talentTreeStage integer[] 技能树阶段列表
---@field EquippedSkillList integer[] 已装备技能id组
---@field carryWeapon table<integer, integer> 携带武器
---@field hp integer 血量
---@field armor integer 装甲
---@field evade integer 机动
---@field bombard integer 炮击
---@field torpedo integer 雷击
---@field lucky integer 幸运
---@field airdefense integer 防空
---@field effectiveSkill integer[] 被动技能
---@field weaponRatio integer 武器属性加成
---@field load integer 载重
---@field allDmg integer 战力


---@class BattleStartInfo
---@field level integer
---@field randomseed integer
---@field heroInfoMap table<integer, BattleHeroInfo>
---@field weaponCidMap table<integer, integer>
---@field levelInfo PveLevelInfo
---@field weeklyBossTagList integer[]
---@field weeklyBossPveLevelId integer


-- 请求开始战斗
---@class BattleStartReq
---@field level integer 关卡id, 对应PveLevelTable中的 id
---@field heroCidList integer[] 英雄cid列表
---@field enterMeans integer 进入方法：GE.EnterBattleType


-- ParameterInvalid， 参数错误
-- CfgNotFind, 没有找到levelCid对应的相关配置
-- TicketNoEnough, 体力不足
-- LackOfPrecond, 缺少前置条件
-- FormationFail_NoRole, 阵型失败，没有英雄
-- FormationFail_InvalidRole, 英雄数量参数不对
-- FormationFail_SameRole, 阵型失败，英雄重复
---@class BattleStartResp
---@field ret integer
---@field battleStartInfo BattleStartInfo


---@class ReportHeroData
---@field id integer
---@field cid integer
---@field blockCid integer
---@field camp integer
---@field level integer
---@field showLevel integer
---@field isMonster boolean
---@field activeAIId integer
---@field unactiveAIId integer
---@field isOnFormationBlock boolean


---@class CoveSkillData
---@field type integer
---@field skillId integer


---@class OrderReportInitData
---@field level integer
---@field heroInfoList ReportHeroData[]
---@field coveSkillList CoveSkillData[]


---@class OrderResultData
---@field allRoleBlockDic table<integer, integer> 英雄所在地格字典
---@field skillId integer 技能id
---@field targetBlockId integer 技能目标地格
---@field mainSkillTargetId integer 技能主目标英雄id


---@class BaseOrderReport
---@field roleId integer 英雄id
---@field blockId integer 地格id
---@field path integer[] 移动路径
---@field skillId integer 技能id
---@field result OrderResultData 指令结果数据


---@class OrderReportData
---@field type integer GE.BattleReportType
---@field data BaseOrderReport 基础战斗指令数据


---@class BattleResultData
---@field star integer
---@field achieveList integer[] 成就列表
---@field rounds integer 战斗回合数
---@field backtraceTimes integer 回溯次数
---@field friendCampDamage integer 我方总伤害


---@class BattleOrderReport
---@field initData OrderReportInitData
---@field orders OrderReportData[]
---@field result integer 战斗结果 1 胜利 2 失败
---@field resultData BattleResultData 战斗结果数据


---@class BattleRoleLogData
---@field roleId integer
---@field totalDamage integer
---@field totalDamageTaken integer
---@field totalHeal integer
---@field activeSkillCount integer
---@field criticalHitCount integer
---@field roleStartPositions integer[] 英雄初始位置列表


---@class BattleLogData
---@field autoSwitchCount integer
---@field battleRoleLogData BattleRoleLogData[]
---@field useGMToWinBattle boolean 是否使用GM指令赢得战斗


---@class ReportRoleDoSkillData
---@field cid integer
---@field sourceBlockId integer
---@field sourceBuffIdList integer[]
---@field targetBuffIdList integer[]
---@field skillId integer
---@field curSourceHp integer
---@field curTargetHp integer
---@field isCrit boolean
---@field targetCId integer
---@field targetBlockId integer
---@field targetLevel integer
---@field damageValue integer
---@field terrainId integer


-- 请求战斗结果
---@class BattleResultReq
---@field orderReport BattleOrderReport 战斗回放数据
---@field battleLogData BattleLogData 战斗日志数据
---@field simpleVerifyData ReportRoleDoSkillData[] 简易验证数据


---@class HeroData
---@field id integer
---@field cid integer
---@field level integer
---@field exp integer


---@class BattleResultResp
---@field ret integer
-- BattleNoFind, 战斗数据不存在
-- CfgNotFind, 配置文件不存在
-- ParameterInvalid, 战斗回放数据错误（类似这种），跟 startInfo 不一致等
-- BattleResultMismatch, 战斗结果不匹配
---@field result boolean
---@field levelId integer
---@field star integer
---@field heroExp integer
---@field userExp integer
---@field fristDrop RewardInfo[]
---@field rewardList RewardInfo[]
---@field rolesDataList HeroData[]
---@field achieveRewardList RewardInfo[]
---@field extraRewardList RewardInfo[]


-- 请求生成自动战斗战报
---@class GenerateAutoBattleReportReq
---@field levelCid integer 关卡cid
---@field heroCidList integer[] 英雄cid列表


---@class GenerateAutoBattleReportResp
---@field ret integer
-- ParameterInvalid， 参数错误
-- CfgNotFind, 没有找到levelCid对应的相关配置
-- LackOfPrecond, 缺少前置条件
-- FormationFail_NoRole, 阵型失败，没有英雄
-- FormationFail_InvalidRole, 英雄数量参数不对
-- FormationFail_SameRole, 阵型失败，英雄重复
---@field orderReport BattleOrderReport 战斗回放数据
---@field battleStartInfo BattleStartInfo 战斗开始信息
---@field simpleVerifyData ReportRoleDoSkillData[] 简易验证数据


-- 请求验证战斗战报
---@class VerifyBattleReportReq
---@field orderReport BattleOrderReport 战斗回放数据
---@field battleStartInfo BattleStartInfo 战斗开始信息
---@field simpleVerifyData ReportRoleDoSkillData[] 简易验证数据


---@class VerifyBattleReportResp
---@field ret integer
-- None, 成功
-- ParameterInvalid, 参数错误
-- BattleResultMismatch, 战斗结果不匹配


-- =============工单===============
---@class WorkOrderItem
---@field id integer
---@field user_uid integer
---@field order_id integer
---@field stamp integer
---@field title string
---@field content string
---@field type integer
---@field state integer
---@field with_uid integer
---@field action integer
---@field userName string 英雄名字


---@class WorkOrderReq
---@field order_id integer


---@class WorkOrderResp
---@field order WorkOrderItem


---@class WorkOrderListReq
---@field stamp integer 初始传0，后续传服务返回值


---@class WorkOrderListResp
---@field res ErrorReason
---@field orders WorkOrderItem[]
---@field stamp integer
---@field left integer


---@class WorkOrderDetailReq
---@field order_id integer
---@field stamp integer 初始传nil(不传)，后续传服务返回值


---@class WorkOrderDetailResp
---@field res ErrorReason
---@field content string
---@field messages WorkOrderItem[]
---@field stamp integer
---@field left integer


---@class WorkOrderActionReq
---@field action integer 新增/回复/处理/关闭
---@field order WorkOrderItem


---@class WorkOrderActionResp
---@field res ErrorReason
---@field orderOrMessage WorkOrderItem


---@class WorkOrderOperationNtf
---@field operation integer 工单操作
---@field orderOrMessage WorkOrderItem


-- ==============================
-- 设置自定义数据
---@class SetUserDefinedReq
---@field info string 序列化


---@class SetUserDefinedResp
---@field ret integer


-- ==============================
---@class FriendInfo
---@field uid integer
---@field lastOnlineTime integer 最后登录时间，0：在线
---@field reqTime integer 申请时间
---@field addTime integer 添加时间
---@field baseInfo FriendBaseInfo


---@class FriendBaseInfo
---@field name string
---@field head integer
---@field level integer
---@field heroNum integer 舰娘数量
---@field currLevelId integer 主线进度
---@field userSign string 玩家签名
---@field regDate integer 注册日期
---@field loginDay integer 累计登录天数
---@field birthday integer 生日


-- 通知自身好友数据
---@class SelfFriendDataNTF
---@field friendPointGive table<integer, integer> 友情点赠送 uid => time
---@field friendPointGet table<integer, boolean> 友情点领取 uid => true


-- 推送好友数据
---@class FriendInfoNTF
---@field operate integer 1好友列表、2请求列表、3搜索好友、4推荐好友
---@field friendList table<integer, FriendInfo>


-- 好友操作
---@class OperateFriendReq
---@field operate integer GE.OperateFriend
---@field uidList integer[]


---@class OperateFriendResp
---@field ret integer ActionFailReason
---@field successList integer[] 成功的uid
-- None, 成功
-- FriendNotFindPlayer, 没有找到目标玩家
-- FriendMyFriendMax, 自己好友已满
-- FriendFriendMax, 对方好友已满
-- FriendAlreadyReq, 已经申请过了
-- FriendAlreadyAdd, 已添加此好友
-- FriendNotFindReq, 没有找到申请
-- FailedEnum, 未找到操作枚举


-- 领取友情点
---@class GetFriendPointReq
---@field uidList integer[] uid列表


---@class GetFriendPointResp
---@field ret integer ActionFailReason
---@field successList integer[]
-- None, 成功
-- LackParameter, 缺少参数
-- FriendPointGetMax, 领取次数已达上限
-- FriendNotFindPlayer, 没有找到目标玩家
-- FriendPointAlreadyGet, 已领取过了
---@field rewardList RewardInfo[] 奖励列表


-- 赠送友情点
---@class GiveFriendPointReq
---@field uidList integer[] uid列表


---@class GiveFriendPointResp
---@field ret integer ActionFailReason
---@field successList integer[]
-- None, 成功
-- LackParameter, 缺少参数
-- FriendPointGiveMax, 赠送次数已达上限
-- FriendNotFindPlayer, 没有找到目标玩家
-- FriendPointAlreadyGive, 已赠送过了


-- gm命令
---@class GmCommandReq
---@field content string


---@class GmCommandResp
---@field ret integer


-- ////////////////////////////////////////////////////////
-- 普通商店数据
---@class GeneralShopData
---@field shopRefreshMap table<integer, ShopInfo> 商店刷新数据 key:商店id
---@field generalGoodsMap table<integer, GoodsInfo> 普通商品数据 key: 商品id


-- 商店数据
---@class ShopInfo
---@field nextRefreshTime integer 下次刷新时间
---@field refreshNum integer 已手动刷新次数


-- 普通商品数据
---@class GoodsInfo
---@field id integer 商品id
---@field buyTimes integer 购买次数
---@field shopTab integer 商店页签id
---@field nextRefreshTime integer 下次刷新时间


-- 商店购买
---@class ShopBuyReq
---@field goodsId integer 商品id
---@field buyNum integer 购买数量


---@class ShopBuyResp
---@field ret integer ActionFailReason
-- None, 成功
-- ParameterInvalid, 参数不合法
-- CfgNotFind, 没有找到商店配置
-- ShopNoOpen, 商店未开启
-- LackOfPrecond, 缺少商店前置条件
-- CfgNotFind, 没有找到商品配置
-- ShopGoodsNoFind, 商品不存在
-- ShopGoodsBuyGlobalMax, 商品购买达到全局上限
-- ShopGoodsBuyMax, 商品购买达到上限
-- LackOfPrecond, 缺少商品前置条件
-- ItemNoEnough, 道具不足
---@field rewardList RewardInfo[]


-- 商店刷新
---@class ShopRefreshReq
---@field shopId integer 商店id


---@class ShopRefreshResp
---@field ret integer ActionFailReason
-- None, 成功
-- CfgNotFind, 没有找到商店配置
-- ShopNoRefresh, 商店不可以刷新
-- ShopNoOpen, 商店未开启
-- LackOfPrecond, 缺少商店前置条件
-- ShopNoFind, 商店不存在
-- ShopRefreshMax, 商店刷新次数已达上限
-- ItemNoEnough, 道具不足


-- ========================================================
-- 支付相关
-- ========================================================
-- 支付初始化
---@class payInitializeReq
---@field identify string 包名
---@field device string 设备名
---@field deviceType integer 平台(安卓,苹果)


---@class payInitializeResp
---@field ret integer
---@field item integer 购买道具
---@field id integer 购买道具
---@field game_trade_no string 游戏内订单


-- 客户端验证支付
---@class payClientCheckReq
---@field game_trade_no string


---@class payClientCheckResp
---@field ret integer
---@field success boolean
---@field item integer


-- 支付请求
---@class payReq
---@field itemid integer
---@field identify string 包名
---@field device string 设备名
---@field deviceType integer 平台(安卓,苹果)
---@field pay_channel integer 支付渠道
---@field extra integer 支付额外参数


---@class payResp
---@field ret integer
---@field orderString string
---@field game_trade_no string 游戏内订单


-- 支付结果
---@class payResultReq
---@field game_trade_no string 订单id
---@field identify string 包名
---@field receipt string
---@field success boolean
---@field pay_channel integer 支付渠道
---@field device string 设备名
---@field deviceType integer 平台(安卓,苹果)
---@field orderString string
---@field purchaseToken string
---@field result_msg string 额外信息


---@class payResultResp
---@field ret integer
---@field receipt_order string


-- 支付成功通知
---@class paySuccessNtf
---@field item integer
---@field game_trade_no string
-- RewardsInfo rewards = 3;
---@field rewards RewardInfo[]
---@field reason integer
---@field receipt_order string
---@field success boolean
---@field pay_channel integer 支付渠道


-- 支付退款通知
---@class refundSuccessNtf
---@field item integer
---@field game_trade_no string
---@field reason integer
---@field pay_channel integer 支付渠道


-- 单个英雄请求数据
---@class HeroActionInfo
---@field heroId integer
---@field actionId integer


-- 设置英雄行为资源数量请求
---@class ReportHeroHomeActionCompletedReq
---@field heroActions HeroActionInfo[]


---@class HeroHomelandAttributeValue
---@field type integer
---@field val integer


-- 单个英雄请求返回数据
---@class HeroActionPushInfo
---@field ret integer
---@field heroId integer
---@field actionId integer
---@field attributeVals HeroHomelandAttributeValue[] 更新资源数量
---@field rewardList RewardInfo[] 奖励列表


---@class ReportHeroHomeActionCompletedResp
---@field ret integer
---@field infos HeroActionPushInfo[]


-- 设置家园进出请求
---@class ReportHomelandEnterExitReq
---@field isEnter boolean


-- 设置家园进出请求返回
---@class ReportHomelandEnterExitResp
---@field ret integer
---@field isEnter boolean


-- 领取家园收益请求
---@class ReportHomelandGetEarningRewardReq


-- 领取家园收益请求 返回
---@class ReportHomelandGetEarningRewardResp
---@field ret integer
---@field rewardList RewardInfo[] 奖励列表


-- 调查问卷
---@class QnaireInfo
---@field qnaireId integer 问卷id
---@field isCompleted boolean 是否已完成
---@field isRewarded boolean 是否已领奖


-- 领取调查问卷奖励请求
---@class GetQnaireRewardReq
---@field qnaireId integer 问卷id


---@class GetQnaireRewardResp
---@field ret integer
---@field rewardList RewardInfo[] 奖励列表


---@class WeatherForecastData
---@field nextRefreshTime integer
---@field curWeekData DayWeatherData[]
---@field nextWeekData DayWeatherData[]


---@class DayWeatherData
---@field dayWeatherData WeatherData[]


---@class WeatherData
---@field type integer 天气类型
---@field startTime integer 开始时间  当前的开始时间
---@field durationTime integer 持续时间


-- ========================================================
-- 通行证相关
-- ========================================================
---@class PassData
---@field id integer
---@field level integer
---@field levelExp integer
---@field openAdvance integer
---@field openSuperAdvance integer
---@field basePassRwdStates integer[] 基础通行证领奖结果
---@field advancePassRwdStates integer[] 高级通行证领奖结果
---@field isClosed integer 通行证活动关闭已完成发奖


-- 领取通行证奖励
---@class GetPassRewardReq
---@field id integer 当前通行证id
---@field level integer 当前通行证等级
---@field rewardState integer //当前通行证领取奖励类型  ，1 基础通行证奖励 2  高级通行证奖励 3 领取全部


-- 领取通行证奖励返回
---@class GetPassRewardResp
---@field ret integer
---@field rewardList RewardInfo[] 奖励列表


---@class CycleCardData
---@field cycleId integer
---@field endTime integer
---@field lastGetRewardTime integer


---@class CovePropsInfo
---@field id integer
---@field getCount integer
---@field dropList integer[] 掉落库


-- 添加家园互动道具奖励
---@class ReportHomelandCovePropsAddRewardReq
---@field id integer
---@field actionId integer


-- 添加家园互动道具奖励 返回
---@class ReportHomelandCovePropsAddRewardResp
---@field ret integer
---@field id integer
---@field rewards integer[]


-- 领取家园互动道具奖励
---@class ReportHomelandCovePropsGetRewardReq
---@field id integer


-- 领取家园互动道具奖励 返回
---@class ReportHomelandCovePropsGetRewardResp
---@field ret integer
---@field id integer
---@field rewardList RewardInfo[] 奖励列表


-- 情报数据
---@class CombatIntelligenceInfo
---@field id integer
---@field createTime integer
---@field finish boolean


-- 进出关卡
---@class BattleEnterLevelReq
---@field levelId integer


-- 进出关卡 返回
---@class BattleEnterLevelResp
---@field ret integer


-- 英雄交互对话请求
---@class ReportHomelandCoveHeroInteractionReq
---@field heroId integer
---@field talkId integer


-- 英雄交互对话 返回
---@class ReportHomelandCoveHeroInteractionResp
---@field ret integer


-- 请求客服链接
---@class GetSupportLinkReq
-- 不用传参


---@class GetSupportLinkResp
---@field ret integer
---@field link string


-- 家园战斗信息
---@class CoveBattleData
---@field fightId integer 当前战斗ID
---@field createTime integer fightId为战斗id时，createTime为战斗开始时间，fightId=0时，createTime为上次战斗结束时间
---@field cacheBattleCount integer 剩余战斗次数
---@field boxCachePos table<integer, CovePos> 缓存怪物位置


-- 家园宝箱信息
---@class CoveBoxReward
---@field uid integer
---@field boxId integer
---@field overTime integer
---@field pos CovePos


---@class CovePos
---@field x integer
---@field y integer
---@field z integer


-- 同步家园战斗奖励坐标请求
---@class ReportCreateHomelandBattleRewardBoxReq
---@field covePoints table<integer, CovePos> 奖励位置  怪物索引
---@field isCrateReward boolean


-- 同步家园战斗奖励坐标 返回
---@class ReportCreateHomelandBattleRewardBoxResp
---@field ret integer
---@field coveBoxReward CoveBoxReward[] 返回奖励


-- 汇报家园结束战斗
---@class ReportHomelandBattleGameOverReq


-- 汇报家园结束战斗 返回
---@class ReportHomelandBattleGameOverResp
---@field ret integer
---@field coveBoxReward CoveBoxReward[] 返回奖励


-- 领取家园宝箱请求
---@class ReportGetHomelandBattleRewardBoxReq
---@field uids integer[] 奖励位置


-- 领取家园宝箱 返回
---@class ReportGetHomelandBattleRewardBoxResp
---@field ret integer
---@field rewardList RewardInfo[] 返回奖励


-- 通用奖励推送
---@class RewardNTF
---@field rewardList RewardInfo[]


-- 请求领取兑换码奖励
---@class GetRedeemCodeAwardReq
---@field code string


---@class GetRedeemCodeAwardResp
---@field ret integer


-- 请求游戏分享
---@class GameShareReq
---@field shareType integer 分享类型


---@class GameShareResp
---@field ret integer
---@field rewardList RewardInfo[]


-- ============================
-- 繁荣度系统
-- ============================
-- 繁荣度一键领取奖励
---@class OneKeyCollectHomelandResourceReq


---@class OneKeyCollectHomelandResourceResp
---@field ret integer
---@field rewardList RewardInfo[]

