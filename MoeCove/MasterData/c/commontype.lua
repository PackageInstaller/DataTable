Quality = {
	Green = 1,	-- 绿
	Blue = 2,	-- 蓝
	Purple = 3,	-- 紫
	Orange = 4, -- 橙
	UR = 5,		--彩
}

--支付枚举
PayType = 
{
	Test = 0,
	AliPay = 1,
	Weixin = 2,
	Unity = 3,
}

SexType = {
	Male = 1,
	Female = 2,
	Eunuch = 3,
}

ActionNTF = {
	pub_add = 1,			--增加
	pub_modify = 2,			--修改
	pub_remove = 3,			--移除
}


-- 行动失败原因，后续新加错误码，一个功能50个预留
---@enum ActionFailReason
ActionFailReason = {
	None = 0,				-- 没有错误
	Failed = 1,				-- 失败
	FailedEnum = 2,			-- 失败，未找到枚举
	LackParameter = 3,		-- 缺乏参数
	ParameterInvalid = 4,	-- 参数不合法

	SystemBusy = 5,			--系统繁忙，请稍后再试
	SystemError = 6,		-- 系统错误
	UnknowError = 7,		-- 未知错误
	NetworkConnectionFaulty = 8,-- 网络连接不通畅

	--体力
	TicketNoEnough = 10,		-- 体力不足
	ErrorTicketMode = 11,		--错误的增加体力模式
	TicketBuyMax = 12,			--体力购买次数达到最大
	TicketHasMax = 13,			--体力已达到最大值

	--道具
	ItemNoEnough = 20,			-- 道具不足
	ItemNoFind = 21,			-- 道具未找到
	ItemWarehouseFull = 22,		--道具仓库数量已满
	NotLevelUpMaterial = 23,	--不是升级材料
	NotStarUpMaterial = 24,		--不是升星材料
	ItemDeductFailed = 25,		--道具扣除失败

	--货币
	CurrencyNoEnough = 26,		-- 货币不足
	CurrencyMax = 27,			-- 货币数量已达上限

	--配置
	CfgNotFind = 30,			-- 配置未找到
	LackOfPrecond = 31,			-- 前置条件不足
	LevelNoEnough = 32,			-- 玩家等级不足
	UserLevelMax = 33,			-- 玩家已达到等级上限
	CfgError = 34,				-- 配置错误
	EquipWarehouseFull = 35,	--装备仓库数量已满
	WeaponWarehouseFull = 36,	--武器仓库数量已满
	InsufficientNumberChallenges = 37,	--挑战次数不足
	--英雄
	HeroNoFind = 40,			-- 英雄未找到
	HeroNoEnough = 41,			-- 英雄数量不足
	HeroLevelMax = 42,			-- 英雄已达到等级上限
	HeroStarMax = 43,			-- 英雄已达到星级上限
	HeroAlreadyLevel = 44,		-- 已经是目标等级
	HeroStarRewardAlreadyGet = 45,	-- 英雄升星奖励已领取
	HeroStarNotEnough = 46,		-- 星级不足无法领取星级奖励 
	HeroStarNotReach = 47,		-- 角色星级未达到要求
	HeroFragIsFull = 48,        --角色升星碎片已满
	HeroStarNull = 49,			--该角色无星级奖励

	--皮肤
	SkinNotHas = 50,			--皮肤未拥有
	SkinIsEquip = 51,			--皮肤已穿戴
	SkinAlreadyHas = 52,		--皮肤已存在

	--头像
	HeadNothas = 60,			--头像未拥有
	HeadIsEquip = 61,			--头像已穿戴
	HeadAlready = 62,			--头像已存在

	--装备
	EquipNoFind = 70,			-- 装备未找到
	EquipIsEquip = 71,			-- 装备已穿戴
	EquipNotEquip = 72,			-- 装备未穿戴
	EquipIsLock = 73,			-- 装备已上锁
	EquipLevelNotEnough = 74,	--装备等级不够
	EquipLTypeError = 75,		--装备类型错误
	EquipLevelMax = 76,			--装备已达到最高等级
	WeaponLevelMax = 77,		--武器已达到最高等级

	--武器
	WeaponNoFind = 80,			-- 武器未找到
	WeaponIsEquip = 81,			-- 武器已穿戴
	WeaponNotEquip = 82,		-- 武器未穿戴
	WeaponIsLock = 83,			-- 武器已上锁
	WeaponOverLoad = 84,		-- 武器已超载
	WeaponSlotMax = 85,			-- 武器槽已满
	WeaponTypeError = 86,		--武器类型错误
	WeaponLevelNotEnough = 87,	--武器等级不够
	WeaponErrorRare = 88,		--武器稀有度错误
	WeaponUnLockPart = 89,		--武器部位未解锁
	

	--技能
	SkillNotHas = 90,			-- 技能未拥有
	SkillIsEquip = 91,			-- 技能已装备
	SkillNotEquip = 92,			-- 技能未装备
	SkillSlotMax = 93,			-- 技能槽已满

	--建筑
	BuildingNotExist = 100,				--建筑不存在
	BuildingNoOutput = 101,				--没有可领取的产出资源
	BuildingNoWorkHero = 102,		--没有工作英雄
	BuildingHasWorkHero = 103,	--已有工作英雄

	--奖励
	NotReward = 110,		--无可领取奖励
	AwardAlready = 111,		--奖励已领取
	HaveExisted = 112,		-- 奖励已存在

	--任务
	TaskNoFind = 120,		--任务未找到
	TaskNoFinish = 121,		--任务未完成
	TaskNoOpen = 122,		--任务未开启
	TaskAlreadyFinish = 123,	--任务已完成
	AchieveLevelMax = 124,	--成就等级已满
	TaskAlreadyReceive = 125,	--任务已领取

	--活动
	ActivityNotOpen = 130,				--活动未开启
	ActivityNotFinish = 131,			--活动未完成

	--关卡
	LevelNoFind = 140,		--关卡未找到
	LevelNoOpen = 141,		--关卡未开启
	LevelNoPass = 142,		--关卡未通关

	--商店
	ShopGoodsNoFind = 150,	-- 商品不存在
	ShopGoodsBuyMax = 151,	-- 商品购买达到上限
	ShopGoodsBuyGlobalMax = 152,	-- 商品购买达到全局上限
	ShopNoFind = 153,		-- 商店不存在
	ShopRefreshMax = 154,	-- 商店刷新次数达到上限
	ShopNoRefresh = 155,	-- 商店不可以刷新
	ShopNoOpen = 156,		-- 商店未开启
	ShopRechargeLimit = 157,-- 每月充值额度达到上限
	ShopRechargeOneceLimit = 158,-- 单笔充值额度达到上限
	ShopGoodsDated = 159,	-- 商品已过期

	--邮件
	NoMail = 160,				-- 邮件不存在
	MailAlreadyDeleted = 161,	-- 邮件已删除
	MailNoReward = 162,			-- 该邮件没有奖励
	MailRewardAlreadyReceived = 163,-- 邮件奖励已领取过
	MailRewardAlreadyRead = 164,-- 邮件已读
	MailRewardNotReceived = 165,	-- 邮件奖励未领取

	--战斗
	BattleNoTimes = 170,	-- 战斗次数不足
	BattleAlreadyIn = 171,	-- 已在战斗中
	BattleNoFind = 172,		-- 战斗未找到
	BattleResultMismatch = 173,		-- 战斗结果不一致
	BattleReportParseFail = 174, -- 战报解析失败
	BattleLogParseFail = 175,	-- 战斗日志解析失败
	BattleNoLevelData = 176,	-- 没有关卡数据
	BattleLevelMismatch = 177,	-- 战斗关卡不一致
	BattleNoMatchParam = 178,	-- 没有匹配参数
	BattleVersionMismatch = 179,	-- 战斗版本不一致
	BattleNodeNotFound = 180,	-- 战斗服务器未找到


	--签到
	SignInAlready = 185,	-- 已签到
	SignInNoFind = 186,		-- 未找到签到信息
	SignNotOpen = 187, 		--签到未开启
	SignAlreadyGet = 188, --签到奖励已领取

	--好感度
	AffectionItemNotGift = 190,					-- 赠送的物品不是好感度礼物
	AffectionEventNoFind = 191,					-- 好感度事件数据未找到
	AffectionEventStateNotOpen = 192,			-- 无法完成未激活的好感度事件
	AffectionEventAlreadyInDelegate = 193,		-- 该好感度事件已在委托列表中
	AffectionLevelMax = 194,					-- 好感度 等级已满
	AffectionExpMax = 195,						-- 好感度 经验已满
	AffectionExpNotEnough = 196,				-- 升级好感度经验不足
	AffectionOptionIndexError = 197,			-- 完成事件选项索引错误
	AffectionEventNotOnCharacter = 198,			-- 完成事件时事件角色身上不存在
	AffectionEventStateError = 199,				-- 好感度事件状态错误
	DelegateEventNoFind = 200,					-- 委托事件未找到
	DelegateEventStateNotUnclaimed = 201,		-- 委托事件不可领取
	DelegateEventListFull = 202,				-- 委托事件列表已满
	AffectionLevelNotReach = 203,				-- 好感度等级未达到
	AffectionRewardAlreadyGet = 204,				-- 好感度奖励已领取
	AffectionRRoleNotGift = 205,				-- 特殊角色无法赠送好感度礼物

	--编队
	FormationFail_NoRole = 300,		--编队失败，玩家未拥有该角色
	FormationFail_SameRole = 301,	--编队失败，编队中有相同角色
	FormationFail_InvalidRole = 302,	--编队失败，编队中角色数量超过上限
	FormationFail_InvalidId = 303,		--编队失败，编队id不合法
	StoryFormation_HaveRole = 304,	--编队失败，剧情中有角色
	FormationFail_NoCharacter = 305,	--编队失败，没有角色
	FormationFail_NoNPC = 306,	--编队失败，缺少npc
	FormationFail_NoFormation = 307,	--战斗失败，没有找到阵容
	FormationFail_NotMatch = 308,	--战斗失败，编队不一致
	FormationFail_RoleNotMatch = 309,	--战斗失败，编队角色不一致

	--家园
	HomeWalkMax = 400,		--家园散步部署超出上限
	HeroInWork = 401,		--角色正在工作
	HeroNotInHome = 402,		--角色不在家园
	BuildingMaxLevel = 403,		--建筑已达到最大等级
	HeroInWalk = 404,		--角色正在散步
	BuildingCanNotLevelUp = 405,	--建筑不能升级
	BuildingInteractMax = 406,		--建筑互动次数上限

	--科技树
	TechTreeNodeNotExist = 500,	--科技树节点不存在
	TechTreeNodeMaxLevel = 501,	--科技树节点已满级
	TechTreeLevelNotEnough = 502,	--科技树等级不足
	TechTreePreNodeNotUnlock = 503,	--科技树前置节点未解锁

	--天赋
	TalentNoFind = 600,			-- 天赋未找到
	TalentAlreadyHas = 601,		-- 天赋已拥有
	TalentStageAlreadyHas = 602,	-- 天赋阶段已拥有

	--模拟演习
	SimulatedIsProgress = 650,	-- 模拟演习正在进行中
	SimulatedIsResetting = 651,	-- 模拟演习正在重置中
	NoSimulatedSweep = 652,		-- 没有可扫荡的层数

	--调查问卷
	QnaireNotExist = 700,	-- 问卷不存在
	QnaireNotCompleted = 701,	-- 问卷未完成
	QnaireAlreadyRewarded = 702,	-- 问卷奖励已领取


	----------------------------------------------------------------------------
	-- 创建角色
	NameNotLegal = 996,	-- 输入内容不合法，请更改
	NameShouldBeChinese = 997,	-- 只能使用汉字
	NameEmpty = 998,	-- 名称为空
	NameForbiddenWord = 999,	-- 输入内容涉及敏感词，请更改
	NameContainsInvalidChar = 1000,	-- 名字中存在非法字符
	NameTooLong = 1001,			-- 名字不能超过7个字符
	NameTooShort = 1002,			-- 名字太短
	AccountOnlyAlphaNum = 1003,	-- 账号只能由6-16位英文和数字组成
	AcPwShouldBe616 = 1004,		-- 密码需要由6-16位字符组成
	SameNameCharExists = 1005,	-- 已存在该名字的角色

	UserNotExist = 1006,		-- 角色不存在
	UserNotThisAccount = 1007,	-- 角色不属于该账号
	UserExists = 1008,			-- 角色已创建
	UserNotExisted = 1009,		-- 角色还未创建
	CreateUserFailed = 1010,	-- 角色创建失败
	CreateUserExceedMax = 1011,	-- 角色创建数量达到上限
	NotLoadUserInfo = 1012,		-- 角色数据尚未读取
	CharNotExist = 1013,		-- 角色不存在 uid不存在(在某个账号上）
	CharDelFailed = 1014,		-- 角色删除失败
	CharDelOnceDay = 1015,		-- 一天只能删除一个角色
	CharCreate4Day = 1016,		-- 一天只能创建四个角色
	ProtocolDuplicate = 1017,	-- 协议重复

	-- GM
	GmNoCommand = 1100,			-- 没有此GM命令
	GmNoEnoughParam = 1101,		-- GM命令参数不够
	GmWrongParam = 1102,		-- GM命令参数不正确
	GmNotEnoughLevel = 1103,	-- GM级别不够

	-- 支付
	PayOrderNotFound = 1200,		-- 找不到订单
	PayValidateFailed = 1201,		-- 支付失败
	PayOrderNotThisUser = 1202,		-- 不是该用户的订单
	HavePayOrderNotDone = 1203,		-- 还有未完成的订单
	PayOrderHaveDone = 1204,		-- 已完成的订单
	CreatePayOrderFailed = 1205,		-- 订单错误
    PayValidateFailed_CheckError = 1206,		--支付失败，不满足购买条件(空内容)
	OtherPayOrderNotDone = 1207,		-- 其他设备或者平台还有未完成的订单
	NotExistPayChannel = 1208,		-- 不存在的支付渠道
	UpdatePayOrderFailed = 1209,		-- 更新订单失败
	PayNtfAlreadyExist = 1210,		-- 重复的支付信息
	RefundNtfAlreadyExist = 1211,		-- 重复的退款信息
	CreatePayNtfFailed = 1212,		-- 创建支付信息失败
	CreateRefundNtfFailed = 1213,		-- 创建退款信息失败
	UpdatePayNtfFailed = 1214,		-- 更新支付信息失败
	UpdateRefundNtfFailed = 1215,		-- 更新退款信息失败
	NoPayResult = 1216,		-- 未处理支付类型
	PayQueryValidateFailed = 1217,		-- 支付查询验证失败
	RefundQueryValidateFailed = 1218,		-- 退款查询验证失败
	CreateRefundOPFailed = 1219,		-- 保存退款操作失败
	RefundResultValidateFailed = 1220,		-- 退款结果验证失败
	PayOrderHaveRefund = 1221,		-- 不能重复退款
	PayInitialFail = 1222,		-- 支付初始化失败
	PayMentError = 1223,		-- 订单处理异常
	RefundNtfValidateFailed = 1224,		-- 退款通知验证失败
    PayIdentifyToPayIDFailed = 1225,    -- 查找订单记录失败，请联系客服补单
	PayServerCheckFail = 1226,    -- 支付发货失败

	PayRefund_Currency = 1227,	-- 不支持该货币支付,重新登录后会退款
	PayValidate_Pending = 1228,	-- 应用商店订单处理中，请稍后重新启动游戏再试
	PayValidate_Error = 1229,	-- 支付状态异常，请重新登录

	ShopNotRechargeGoods = 1230,			--不是充值商品
	ShopGoodsPriceError = 1231,			--商品价格错误
	payChannelPermissionDenied = 1232,	--支付渠道没有权限
	payChannelError = 1233,				--支付渠道错误
	ChannelOrderHaveDone = 1234,		-- 渠道订单已完成，不需要重复处理


	-- 工单
	WorkOrderNoTitle = 1300,		-- 会话没有标题
	WorkOrderTitleTooLong = 1301,	-- 会话标题太长
	WorkOrderTitleTooShort = 1302,	-- 会话标题太短
	WorkOrderNoContent = 1303,		-- 会话没有内容
	WorkOrderContentTooLong = 1304,	-- 会话内容太长
	WorkOrderContentTooShort = 1305,-- 会话内容太短
	WorkOrderCreateFailed = 1306,	-- 会话创建失败
	WorkOrderDealingTooMany = 1307,	-- 未结束的会话太多
	WorkOrderActionIncorrect = 1308,-- 会话行为不正确
	WorkOrderNoPermission = 1309,	-- 没有权限执行该会话操作
	WorkOrderIsDealing = 1310,		-- 已有其他人处理
	WorkOrderIsFinished = 1311,		-- 会话已被标记为完成
	WorkOrderReplyFailed = 1312,	-- 会话回复失败
	WorkOrderServeCantClose = 1313,	-- 不能结束会话
	WorkOrderIsNotDealing = 1314,	-- 会话不在处理中
	WorkOrderNotInUser = 1315,		-- 角色没有该会话


	--手机号绑定
	BindPhoneTimeout = 1400,			--操作超时
    BindPhoneNumberError = 1401,		--手机号不正确
    BindPhoneVerifyCodeError = 1402,	--验证码不正确
    BindPhoneVerifyError = 1403,		--验证码校验不正确
    BindPhonFaild = 1404,				--绑定失败
    BindPhonUserAlready = 1405,			--该账号已绑定手机
	BindPhonNumberAlready = 1406,		--该手机号已被其他账号绑定，请更换手机号

	--好友
	FriendNotFindPlayer = 1500,		--没有找到目标玩家
	FriendMyFriendMax = 1501,		--自己好友已满
	FriendFriendMax = 1502,			--对方好友已满
	FriendAlreadyReq = 1503,		--已经申请过了
	FriendAlreadyAdd = 1504,		--已添加此好友
	FriendNotFindReq = 1505,		--未找到此人请求
	FriendCannotOperateSelf = 1506,	--不能对自己操作
	FriendPointGetMax = 1507,		--友情点领取次数已满
	FriendPointGiveMax = 1508,		--友情点赠送次数已满
	FriendPointAlreadyGet = 1509,	--友情点已领取过
	FriendPointAlreadyGive = 1510,	--友情点已赠送过
	FriendReqListMax = 1511,		--申请列表已满
	FriendPointNotGive = 1512,		--友情点未赠送

	--派遣
	DispatchStateError = 1600,		--派遣状态错误
	DispatchNotFind = 1601,		--派遣未找到
	DispatchLineNotFind = 1602,	--路线未找到
	RoleInDispatch = 1603,		--角色正在派遣中
	DispatchChapterNotFinish = 1604,	--派遣章节未完成
	DispatchChapterRewardReceived = 1605,	--派遣章节奖励已领取
	DispatchRoleNumExceed = 1606,	--派遣角色数量超出上限

	--功能开启
	FunctionOpenNotExist = 1700,		--功能不存在
	FunctionOpenNotOpen = 1701,			--功能未开启

	---家园行为
	HomelandAction_HeroNotFind = 1801,
	HomelandAction_ConfigError = 1802,
	HomelandAction_MaxCharacter = 1803,			---场上人数超出最大人数
	HomelandAction_GetoffWorkError = 1804,			---行为错误

	Homeland_Earnings_Error = 1806,
	
	Homeland_Earnings_ConfigError = 1807,
	Homeland_EarningsItemEmpty = 1808,			---离线奖励为空
	Homeland_Earnings_LastTimeError = 1809,

	--自定义数据
	userDefinedTooLong = 1900,			--自定义数据太长

	--跑片
	LackOfTimes = 2000,			--可生成次数不足
	RoleAlreadyGen = 2001,		--角色已生成过
	RoleFragSlotNotUnlock = 2002,	--角色碎片槽位未解锁

	--调查问卷
	PassNotExist = 2100,	-- 通行证不存在
	PassRewardNotGet = 2101,	-- 通行证奖励未解锁，不能领取
	PassAdvanceNotOpen = 2102,	-- 高级通行证未解锁，不能领取
	PassRewardReceived = 2103,	-- 奖励已领取，不能重复领取
	PassConfigError = 2104,	-- 通行证表数据有问题，没有任何一条数据
	PassAdvanceOpened = 2105,	-- 通行证高级通行证已解锁，不能重复解锁
	PassSuperAdvanceOpened = 2106,	-- 通行证超级通行证已解锁，不能重复解锁
	PassActivityTagNotExist = 2107,	-- 通行证活动标签错误

	--互动道具
	CoveUsableItemNotExist = 2201, ---互动道具不存在
	CoveUsableItemInsufficientAttempts = 2202, ---互动道具领奖次数不足

	--图鉴
	HandbookNoFind = 2300,			-- 图鉴未找到

	Intelligence_EnterBattle_IsFinish = 2401,  ---当前情报已经完成
	Intelligence_EnterBattle_IsLock = 2402,	---当前情报未开启
	Intelligence_EnterBattle_IsPast = 2403,	---当前情报未开启


	HeroIsTalk = 2501,		---英雄已经交互过


	HomeBattleNotOpen = 2601,	---家园战斗未开启
	HomeBattleNotEnoughReward = 2602,	---家园战斗未开启
	HomeBattleGetRewardPosError = 2603,	---家园战斗未开启

	NotFindRedeemCode = 2700,				--兑换失败，请填写正确的兑换码
	RedeemCodeInvalid = 2701,				--兑换码已失效，已被别人领取
	RedeemCodeAlreadyReceived = 2702,		--兑换码已领取，已被自己领取
	RedeemCodeExpired = 2703,				--兑换码已过期，超过结束时间
	RedeemCodeNotEffective = 2704,			--兑换码未生效，未到达开始时间
	RedeemCodeChannelInconsistent = 2705,	--兑换码渠道不一致
	RedeemCodeDeleted = 2706,				--兑换码已删除，平台将其作废
	RedeemCodeZoneInconsistent = 2707,		--兑换码区服不一致
	RedeemCodeAlreadyReceivedGift = 2708,	--兑换码同批次已领取，同一批次只能领取一次
	RedeemCodeNotFindRecord = 2709,		--(领取确认时)兑换码记录未找到
	RedeemCodeWaitVerify = 2710,			--(领取确认时)等待验证中
	RedeemCodeNotFindType = 2711,			--(领取确认时)未找到兑换码类型
}



--系统邮件类型
SysMailType =
{
	All = 0,			--全部玩家(已有角色的玩家)
	Common = 1, 		--指定id玩家{1,2,3}
	LoginTimeRange = 2, --指定时间段登录的玩家（要求：结束时间>=当前时间, 有效期要大于活动跨度）
	CreateUser = 3,		--新创建角色登录

	Max = 4,
}

MailState =
{
	NotRead  = 0,	--未读
	Read = 1,		--已读
	Received = 2,	--领取
	Deleted = 3,	--删除

	ReceiveAll = 10,	--一键领取
	DeleteAll = 11,		--一键删除
	ReadAll = 12,		--一键已读
}

--注册时设备类型
GE.DeviceType =
{
	Editor = 7,
	IOS = 8,
	Android = 11,
	WebGLPlayer = 17,
}

GE.DeviceSubType =
{
	--原生移动端
	iOS_Native = 1, 
	Android_Native = 2,

	--WebGL移动端
	iOS_WebGL = 11,
	Android_WebGL = 12,
	--WebGL桌面端
	Windows_WebGL = 16,
	macOS_WebGL = 17,

	--Editor桌面端
	Windows_Editor = 31,
	macOS_Editor = 32,
}

GE.Channel =
{
	None = 0,
	Editor = -1,

	Abroad = 1,---Android,IOS都有
	Apple = 2,
	InternalTest = 5,	--内部测试服
	ExternalShow = 6,	--对外展示服

	Formal_Official = 10,	---官方渠道 Android,IOS都有

	Formal_TapTap = 20,---TapTap渠道 目前只有Android
	Formal_HaoYou = 21,---好游渠道 目前只有Android
	Channel_bilibili = 100,---B站渠道 目前只有Android

	Channel_4399 = 110,---4399渠道
	Channel_233 = 111,---233渠道

	--小程序测试包登录渠道，游戏中转为正式渠道使用
	Test_Xipu_Mini_WX = 201,	--xipu微信小程序测试
	Test_Xipu_Mini_QQ = 202,	--xipuQQ小程序测试
	Test_Xipu_Mini_DY = 203,	--xipu抖音小程序测试
	Test_Xipu_Mini_ZFB = 204,	--xipu支付宝小程序测试

	-- xipu包
	Channel_Xipu = 1000,
	Channel_Xipu2 = 1001, --- 正式包
	-- Channel_Xipu_Lianyun = 1002, --- 联运包
	
	-- Channel_Xipu_TapTap = 1020, --- xipu Tap
	-- Channel_Xipu_HaoYou = 1021, --- xipu haoyou

	-- Channel_Xipu_Huawei = 1050, --- xipu 华为
	-- Channel_Xipu_Oppo = 1051, --- xipu oppo
	-- Channel_Xipu_Vivo = 1052, --- xipu vivo
	-- Channel_Xipu_xiaomi = 1053, --- xipu xiaomi
	-- Channel_Xipu_9you = 1054, --- xipu 九游
	-- Channel_Xipu_4399 = 1055, --- xipu 4399
	-- Channel_Xipu_Bilili = 1056, --- xipu bilibili

	
	Channel_Xipu_App_End = 1200, --- xipuApp终点编号

	Channel_Xipu_Mini_WX = 1201,	--xipu微信小程序
	Channel_Xipu_Mini_QQ = 1202,	--xipuQQ小程序
	Channel_Xipu_Mini_DY = 1203,	--xipu抖音小程序
	Channel_Xipu_Mini_ZFB = 1204,	--xipu支付宝小程序

	Channel_Xipu_Mini_End = 1250, -- xipu小程序终点编号

	Channel_Xipu_End = 1300, --- xipu终点编号

	Quick_Origin = 100000,---目前只有Android
	Quick_HuaWei = 100024,---目前只有Android
	Quick_Oppo = 100023,---目前只有Android
	Quick_Vivo = 100017,---目前只有Android
	Quick_Mi = 100015,---目前只有Android
	Quick_UC = 100009,---目前只有Android
	Quick_4399 = 100027,---目前只有Android

}

GE.TimelineCallBackName = {
	BossTips1 = "BossTips1",	--warning
	BossTips2 = "BossTips2",	--boss名称
}

GE.PaySDK =
{
	Unknown = -1,
	Editor = 0,

	Unity = 3,

	Official = 10,

	TapTap = 20,
	HuaWei = 21,
	Oppo = 22,
	Vivo = 23,

	QuickSDK = 50,

	XipuSDK = 1000,
	XipuMiniSDK = 1001,
}

GE.PayChannel =
{
	GooglePlay = 1,
	Apple = 2,


	Alipay = 11,
	WXpay = 12,
	UnionPayWeb = 13,

	HuaWei = 21,
	Oppo = 22,
	Vivo = 23,

	QuickSDK = 50,
	TestPay = 100,

	XipuSDK = 1000,
	XipuMiniSDK = 1001,
	XipuAbroadSDK = 1002,
	XipuWebSDK = 1003,

	Unknown = -1,
}

--支付折扣渠道
GE.PayDiscountChannel = {
	Official = 1,
	Bilibili = 2,
}

GE.PlatformChannel =
{
	Android = 1,
	IOS = 2,

	Unknown = -1,
}

GE.PayResult =
{
	Wait = 1,
	Success = 2,
	NotPay = 3,
	ValidateFailed = 4,
	Cancel = 5,
	ServerRefund = 7,
	QueryFailed = 8,
    IdentifyToPayIDFailed = 9,
    ServerCheckFail = 10,
	HaveDone = 11,
	SuccessLimitNoReward = 12,
}

GE.PayErrorCode = 
{
	Error1 = 1,
	Error2 = 2,
	Error3 = 3,
	Error4 = 4,
	Error5 = 5,
	Error6 = 6,
}

GE.LoginType = 
{
	Official = 1,			-- 官方账号密码体系
	
	TapTap = 20,			-- TapTap登录
	WeiXin = 21,			-- 微信登录(APP微信登录)
	QQ = 22,				-- QQ登录
	XingXiu = 23,				-- 星宿登录
	WeiXinMini = 24,			-- 微信登录(小程序微信登录)
	
	Firebase_Email = 30, 	-- Firebase_Email账号登录
	Firebase_Google = 31, 	-- Firebase_Google账号登录
	Firebase_Facebook = 32, -- Firebase_Facebook账号登录
	Firebase_Twitter = 33,  -- Firebase_Twitter账号登录
	Firebase_Phone = 34, 	-- Firebase_Phone手机验证码登录
	Firebase_Apple = 35, 	-- Firebase_Apple账号登录

	QuickWrap = 99,			-- QuickSdk登录
	
	-- 枚举名不能修改
	Huawei = 100,			-- 华为登录

	XipuWrap = 1000,	-- 喜扑
	XipuMiniWrap = 1001,	-- 喜扑登录小程序
}

GE.SDKFuncType = {
	Login = 1,	--登录
	Bind = 2,	--绑定
	Auth = 3,	--实名认证
}

GE.GameConnectType = {
	Connect = 0,	-- 连接授权
	EnterGame = 1,	-- 进入游戏
	Reconnect = 2,	-- 断线重连
	Disconnect = 3,	-- 断开连接
	Logout	   = 4,	-- 登出(对象从服务器内存删掉)
	Kicked	   = 5,	-- 被踢
}

GE.FireBaseCode = {
	None = 0,
	EmailAlreadyInUse = 8,
	InvalidEmail = 11,
	WrongPassword = 12,
	TooManyRequests = 13,
	UserNotFound = 14,
	--UserMismatch = 22, -- The supplied credentials do not correspond to the previously signed in user
	WeakPassword = 23,
	MissingEmail = 37,
	Cancelled = 58,
	UnverifiedEmail = 74,
}

--服务器自定义数据存储枚举
GE.CustomDataKey = {
	AffectionWatched = "AffectionWatched",	--好感度角色查看列表
	HomelandRoleTalk = "HomelandRoleTalk", --家园角色对话数据
	-- ActivityEndTime = "ActivityEndTime", --活动结束时间table
	FunctionOpenWatched = "FunctionOpenWatched", --功能开启已查看列表
	LevelOpenWatched = "LevelOpenWatched", --关卡开启已查看列表 {int}
}

--本地自定义数据存储枚举存储
GE.LocalCustomDataKey = {
	BGMValue = "BGMValue",	--背景音乐音量
	SEValue = "SEValue",	--音效音量
	CVValue = "CVValue",	--CV音量
	AllValue = "AllValue",	--总音量
	BGMIsOn = "BGMIsOn",	--背景音乐开关
	SEIsOn = "SEIsOn",		--音效开关
	CVIsOn = "CVIsOn",	    --CV开关
	AllIsOn = "AllIsOn", 	--总开关
	
	TimeLineIsOn = "TimeLineIsOn", --战斗大招动画开关
	CameraIsOn = "CameraIsOn", --战斗表现切镜开关
	setFightSpeed = "setFightSpeed", --战斗倍速
	-- IdleOptimizerEnabled = "IdleOptimizerEnabled", --后台运行优化开关

	SceneSetting_OpenType = "SceneSetting_OpenType", --家园 时间流逝开启状态
	SceneSetting_DayTimeType = "SceneSetting_DayTimeType", --家园时间
	SceneSetting_TimeScale = "SceneSetting_TimeScale", --家园时间缩放
	SceneSetting_RectifyTime = "SceneSetting_RectifyTime", --家园 上次校准时间
	SceneSetting_DefaultSceneType = "SceneSetting_DefaultSceneType", --默认显示场景类型
	
	LocalServerTest = "LocalServerTest", --本地测试开关

	QualitySettingsLevel = "QualitySettingsLevel", --画质等级
	QualitySettingsData = "QualitySettingsData", --画质数据

	MaxAdjustValue = "MaxAdjustValue", --UI最大适配值
	BattleCameraDistance = "BattleCameraDistance", --战斗摄像机距离
	BattleCameraAngle = "BattleCameraAngle", --战斗摄像机角度
	CoveCameraAngle = "CoveCameraAngle", --家园摄像机角度

	WatchedActivityList = "WatchedActivityList", --已观看活动列表
	QuestionPanelCustomDataKey = "QuestionPanelCustomDataKey", --调查问卷列表相关 
}

GE.PanelType = {
	LoginUI 	 	= 1,	-- 登录界面
	ServerListUI 	= 2,	-- 服务器列表
	MainPanel 		= 3,	-- 主界面
	MsgBox 	 		= 4,	-- 提示界面
	WinSDK			= 5,	-- WinSDK登录界面
	LoginRealNamePanel 	= 6,	-- 登录实名认证界面
	LoginResetPasswordPanel 	= 7,	-- 登录重置密码界面
	LoginEnrollPanel 	= 8,	-- 登录注册界面
	CheckAgreementPanel 	= 9,	-- 登录协议界面
	CreateRolePanel 	= 10,	-- 创建角色界面
	ProtoAgreementCheck = 11,	-- 协议勾选界面

	FormationPanel 	= 20,	-- 编队界面
	StoryPanel 		= 21,	-- 剧情界面
	ReceiveRewardPanel 	= 22,	-- 领取奖励界面
	UserGuidePanel 	= 23,	-- 新手引导界面
	RaffleOpenGiftPanel	= 24,	-- 抽奖开宝箱界面
	MissionMsgPanel 	= 25,	-- 任务消息界面
	OPMotionComicsPanle = 26,	-- OP剧情漫画界面
	SkillRangePanel 	= 27,	-- 技能范围界面
	ItemMsgPanel 	= 28,	-- 道具提示界面
	DockPanel 		= 29,	-- 船坞界面
	CharacterActionPanel = 30,	-- 角色动作界面
	RolePanel 		= 31,	-- 角色界面
	LevelUpPanel 	= 32,	-- 升级界面
	WarePanel 		= 33,	-- 仓库界面
	FormationRoleMsgPanel = 34,	-- 编队角色信息界面
	FormationListPanel = 35,	-- 编队列表界面
	BattleMainPanel = 36,	-- 战斗主界面
	FormationMovePanel = 37,	-- 编队行动顺序界面
	BuyTicketPanel = 38,	-- 购买体力界面
	FriendPanel = 39,	-- 好友界面
	EquipPanel = 40,	-- 装备界面
	EquipIntensifyPanel = 41,	-- 装备强化界面
	LevelMapPanel = 42,	-- 关卡地图界面
	LevelDetailPanel = 43,	-- 关卡详情界面
	RoleTagPanel = 44,	-- 角色标签界面
	SkillTreePanel = 45,	-- 技能树界面
	SkillTreeChosePanel = 46,	-- 技能树选择界面
	SkillTreeStagePanel = 47,	-- 技能树阶段界面
	BattleStoryPanel = 48,	-- 战斗剧情界面
	SeaMapPanel = 49,	-- 海图界面
	EquipMsgPanel = 50,	-- 装备提示界面
	BattleRoleMsgPanel = 51,	-- 战斗角色信息界面
	BattleWinPanel = 52,	-- 战斗胜利界面
	BattleLosePanel = 53,	-- 战斗失败界面
	EquipDelPanel = 54,	-- 装备删除界面
	EquipLevelPanel = 55,	-- 装备升级界面
	EquipStarPanel = 56,	-- 装备升星界面
	EquipDelFastPanel = 57,	-- 装备批量删除界面
	FilterPanel = 58,	-- 筛选界面
	SkillTreeOnPanel = 59,	-- 技能树开启界面
	SeaMapScenesPanel = 60,	-- 海图场景界面
	RegularLevelPanel = 61,	-- 常规关卡界面
	MaterialLevelPanel = 62,	-- 材料关卡界面
	BattleRepeatPanel = 63,	-- 重复战斗界面
	RepeatRewardPanel = 64,	-- 重复战斗奖励界面
	SkillChangePanel = 65,	-- 技能更换界面
	WeaponPanel = 66,	-- 武器界面
	WeaponLevelUpPanel = 67,	-- 武器升级界面
	WeaponFusePanel = 68,	-- 武器合成界面
	WeaponAttrChangePanel = 69,	-- 武器属性更换界面
	WarringTaskPanel = 70,	-- 战斗任务界面
	TaskPanel = 71,	-- 任务界面
	AchieveRewardPanel = 72,	-- 成就奖励界面
	BattleSetupPanel = 73,	-- 战斗设置界面
	ShowRoleSpinePanel = 74,	-- 显示角色Spine界面
	UseCountPanel = 75,	-- 使用次数界面
	StoryHandbookPanel = 76,	-- 剧情图鉴界面
	StoryChapterPanel = 77,	-- 剧情章节界面
	StarUpPanel = 78,	-- 星级提升界面
	ConfigPanel = 79,	-- 配置界面
	StoryLogPanel = 80,	-- 剧情日志界面
	MailPanel = 81,	-- 邮件界面
	LevelMapMsgPanel = 82,	-- 关卡地图提示界面
	RaffleMainPanel = 85,	-- 抽奖主界面
	PosterPanel = 86,	-- 看板娘界面
	PosterAdjustPanel = 87,	-- 看板娘调整界面
	RaffleRecordPanel = 88,	-- 抽奖记录界面
	SkinPanel = 89,	-- 皮肤界面
	SkinViewPanel = 90,	-- 皮肤查看界面
	UserPanel = 91,	-- 玩家信息界面
	HeadChosePanel = 92,	-- 头像选择界面
	DockRolePanel = 93,	-- 船坞角色信息界面
	InterludeLoadingPanel = 94,	-- 加载界面
	AgeTips = 95,	-- 年龄提示界面
	BattleRestrictionPanel = 97,	-- 战斗属性克制界面
	HomeFuncPanel = 98,	-- 家园功能界面
	HomeDisposePanel = 99,	-- 家园布置界面
	CustomMsgPanel = 100,	-- 自定义消息界面
	HomeWeaponProPanel = 101,	-- 家园武器加工界面
	HomeWeaponProMsgPanel = 102,	-- 家园武器加工提示界面
	HomeQuickDisposePanel = 103,	-- 家园快速布置界面
	SkillMsgPanel = 104,	-- 技能信息界面
	HomeWalkPanel = 105,	-- 家园散步界面
	HomeSchedulePanel = 106,	-- 家园日程界面
	SkillInfoListPanel = 107,	-- 技能信息列表界面
	TechnologyTreePanel = 108,	-- 科技树界面
	TechnologyTreePagePanel = 109,	-- 科技树页面界面
	AffectionEventListPanel = 110,	-- 好感度事件列表界面
	AffectionEventPanel = 111,	-- 好感度事件界面
	RechargePanel = 112,	-- 充值界面
	DispatchMainPanel = 113,	-- 派遣主界面
	DispatchDetailPanel = 114,	-- 派遣详情界面
	DispatchBattlePanel = 115,	-- 派遣战斗界面
	HandBooksPanel = 116,	-- 图鉴界面
	SimulatedLevelPanel = 117,	-- 模拟演习关卡界面
	SimulatedRewardPanel = 118,	-- 模拟演习奖励界面
	SimulatedInfoPanel = 119,	-- 模拟演习信息界面
	HomeLvUpPanel = 120,	-- 家园升级界面
	NoticePanel = 121,	-- 公告界面
	SimulatedSweepRewardPanel = 122,	-- 模拟演习扫荡奖励界面
	RaffleAnimationPanel = 123,	-- 抽奖动画界面
	SSRTipsPanel = 124,	-- SSRTips界面
	ShowCharacterPanel = 125,	-- 显示角色界面
	RaffleResultPanel = 126,	-- 抽奖结果界面
}

GE.EnterGameCode = {
	CanEnter = 1,				-- 能正常进入游戏
	CantEnterOvertime18 = 2,	-- 未满18岁超过限制时间
	CantEnterBetween228 = 3,	-- 未满18 22:00-8:00无法登录
	-- 新政策
	CanOnlyEnterByNewPolicy1 = 4,	-- 未满18只能在周五、周六、周日和法定节假日每日的20时至21时游戏
	CantEnterUnder16 = 5,			-- 未满16岁，不能进入游戏
	TodayOnlineFull1Hour18 = 6,		-- 未满18岁，今日在线已满1小时，不能进入游戏

	GameVersionNeedUpdate = 10,	-- 游戏需要重启更新
}

GE.WorkOrderMessageAction = {
	UserReply = 1,	-- 玩家回复
	ServeReply = 2,	-- 工作人员回复
	UserFinish = 3,	-- 玩家结束工单
	SystemFinish = 4,	-- 系统自动结束工单(超过时间)
}

GE.WorkOrderAction = {
	AddOrder = 1,	-- 玩家添加工单
	Reply = 2,		-- 玩家或工作人员回复
	Deal = 3,		-- 工作人员开始处理
	CloseOrder = 4,	-- 玩家结束工单
	CancelDeal = 5,	-- 工作人员取消在处理的状态
}

GE.WorkOrderState = {
	NotDealed = 1,	-- [尚未受理] 用户刚提交了问题，暂时还没有受理，正在客服队列中等候
	NotSolved = 2,	-- [尚未解决] 用户对正在处理的问题重新提交了回复，暂时还没有对用户的回复作出响应
	
	Dealing = 4,	-- [正在处理] 正在处理问题，可能需要一定的处理时间
	WaitUser = 5,	-- [等待回应] 处理问题需要用户的配合，客服已向用户提出并正在等待用户的回复
	Finished = 6,	-- [处理完成] 问题已经解决或已全部答复

	Received = 3,	-- [已经受理] 已经受理了用户提交的问题，开始处理问题 目前可能没有
}

GE.WorkOrderType = {
	Suggest = 1,	-- 建议
	Ask = 2,		-- 咨询
	Bug = 3,		-- Bug
	Pay = 4,		-- 支付
}

GE.ReleaseType = {
	Develop = 0,		-- 开发版本
	Auditing = 1,	-- 版号版本
	Abroad = 2,		-- 海外版本
	Formal = 3,		-- 国内正式版(release)
	CN_Channel_QA = 4, -- 国内渠道QA测试版

}

--数数日志区分 服务器
GE.LogServerId = {
	--内网
	Debug = 1,
	DebugTime = 2,
	QA = 3,
	Audit = 4,

	--外网测试
	Release_1 = 11,	--bate内网测试
	Release_2 = 12,	--bate云测
	Release_3 = 13,	--一测
}

LocalLanguage =
{
	ChineseSimplified = "ChineseSimplified",					--简体中文
	ChineseSimplifiedCensored = "ChineseSimplifiedCensored",	--简体中文(和谐版)
	ChineseTraditional = "ChineseTraditional",
	English = "English",
}

--微信场景值枚举
GE.WechatSceneList = {
	app = 1104,		--我的小程序
	destop = 1023,	--桌面进入
	destopIos = 1194,	--ios桌面进入
	search = 1053	--搜一搜进入
}

--小程序订阅功能枚举
GE.MiniSubscribFunc = {
	h5VerUpdate = 0,		--版本更新
	signIn = 1,				--签到提醒
	strengthRecover = 2,	--体力恢复提醒
}

--奖励类型
---@enum GE_RewardType
GE.RewardType =
{
	ItemProp = 1,		--道具
	Character = 2,		--角色
	Equipment = 3,		--装备
	Weapon = 4,			--武器
	Affection = 5,		--好感度
	PassUnlock = 6,		--通行证-解锁高级通行证
	PassExp = 7,		--通行证-增加通行证经验
	PassLevel = 8,		--通行证-增加通行证等级
	PassSuper = 9,		--通行证-解锁超级通行证
	CycleCard = 10,		--月卡周卡道具简易通行证解锁高级
	Skin = 12,			--皮肤
	MiniPassUnlock = 13,--
}

--道具类型（对应item_prop表Type）
GE.ItemPropType = 
{
	CharToken = 3,			--角色碎片
	Material = 4,			--材料
	Item = 5,				--道具
	Strength = 98,			--体力
	Currency = 99,			--货币
	-- BattleItem = 7,
	-- CultivationItem = 9, 	--养成道具
	UserExp = 100,			--用户经验
}

--资源类型（对应item_prop表id）
GE.ResourceType = 
{
	Gold = 100003,
	Strength = 100010,
	PayDiamond = 100001,
	FreeDiamond = 100002,
}

--剧情初始化加载类型
GE.InitAvgScriptType = 
{
	CreateSpine = "CreateSpine",--加载角色Spine
	CreateEffect = "CreateEffect",--加载特效预制体
	CreateHeadSpine = "CreateHeadSpine",--加载角色Spine(头像用)
	CreateCGSpine = "CreateCGSpine", --加载CGSpine
	CreateBackGround = "CreateBackGround",--加载背景
	CreateBGM = "CreateBGM"--加载bgm
}

--剧情脚本类型
GE.StoryScriptType = 
{
	DoTalk = 1,				--对话
	ShowChoice = 2,			--选项
	EndChoice = 3,			--选项结束
	ChangeBackGround = 4,	--场景
	ChangeBGM = 5,			--音乐
	ScreenShake = 6,		--镜头震动
	ShowPicture = 7,		--图片
	HidePicture = 8,		--隐藏图片
	DoNarration = 9,		--旁白
	ShowEffect = 10,		--特效
	RemoveEffect = 11,		--移除特效
	RoleMove = 12,			--角色运动
	DoTelephony = 13,		--通讯
	DoWait = 14,			--等待
	DoCurtain = 15,			--幕布
	SoundEffect = 16,		--音效
	DoPauseBGM = 17,		--音乐暂停
	DoResumBGM = 18,		--音乐恢复
	ComeOnStage = 19,		--角色登场
	DoSilent = 20,			--沉默
	ScreenFlicker = 21,		--屏幕闪烁
	RoleClear = 22,			--立绘清屏
	DoNotMoveTalk =23,		--固定对话
	ShowCG = 24,			--CG
	HideCG = 25,			--隐藏CG
	CGAction = 26,			--CG运动
	HideUI = 27,			--隐藏UI
	RoleSlot = 28,			--换装开关
	BackGroundAction = 29, 	--场景运动
	KeepBGM = 30,			--保持当前BGM
}

---@enum ClickSoundType
GE.ClickSoundType = 
{
	Click = 1,				--点击音效
	Back = 2,				--导航栏返回音效
}

--剧情资源分类(对应StoryResource表中camp字段)
GE.StoryResourceCamp = 
{
	Role = 1,		--角色
	Enemy = 2,		--敌人
	NPC = 3,		--NPC
}

--奖励随机类型
GE.AwardRandomType = {
	Merge = 1,		--合并权重
	Single = 2		--单独判定
}

--奖励类型 （任务用）
GE.AwardType = {
	Common = 1,
	Random = 2,
}

--活动类型
GE.ActivityType = {
	Simulated = 1,	-- 周活动-爬塔-模拟演习
	Pass = 2,		-- 通行证
	Boss = 3,		-- Boss战
	Sign = 4,		-- 签到
	FirstCharge = 5,	-- 首充返利活动
	HeroExchange = 6,	--英雄兑换活动
	SevenDayTask = 7,	-- 七日任务
	CommanderRank = 8,	-- 指挥官等级
	GenRoleFragExtra = 9,	-- 角色碎片加成活动
	ActivityStory = 10,  --剧情活动
	PortConstruction = 11, --港区建设
}

--子活动类型
GE.ActivitySecondaryType = {
	Trial = 1, --试用
	Shop = 2, --商店
	Task = 3, --任务
	Level = 4, --关卡
}

--公共活动
GE.PublicActivityType = {
	[GE.ActivityType.Simulated] = 1,	-- 周活动-爬塔-模拟演习
	[GE.ActivityType.Boss] = 30001,		-- Boss战
}

--活动状态
GE.ActivityState = {
	NotOpen = 1,	--未开放
	Open = 2,		--开放
	Ended = 3,		--已结束
	Finish = 4,		--已完成
}

--跳转枚举
GE.TurnToType = {
	TechnologyTreePagePanel = 1,	--科技树页签界面跳转
	TechnologyTreePanel = 2,		--科技树跳转
	RaffleMainPanel = 3,		--抽卡界面跳转
	HomeFuncPanel = 4,		--家园功能界面跳转
	HomeWeaponProPanel = 5,		--武器制造界面跳转
	WeaponFusePanel = 6,		--武器合成界面跳转
	DispatchMainPanel = 7,		--派遣界面跳转
	SeaMapPanel = 8,		--海域入口跳转
	MaterialLevelPanel = 9,		--材料关卡跳转
	LevelMapPanel = 10,		--关卡入口跳转
	SimulatedLevelPanel = 11,		--模拟演习界面跳转
	GameShopPanel = 12,
	HomelandShopPanel = 13,
	GoodsItemPanel = 14,
	MainPanel = 15,  --主界面避风港跳转
	DockRolePanel = 16,  --船坞跳转
	WarePanel = 17,  --仓库跳转
	GenRoleFragPanel = 18,  --角色碎片跳转
	-- SeaMap = 1,		--海域跳转
	-- LevelMap = 2,	--海图跳转 关卡界面
	-- WarePanel = 3,  --仓库
	ActivityPanel = 19,	--活动界面跳转
	HomeLvUpPanel = 20,	--家园升级界面跳转
	WeeklyBossMainPanel = 21,	--危境攻坚界面跳转
	CombatIntelligenctPanel = 22,	--情报界面跳转
	GiftUsePanel = 23, --礼包使用界面跳转
	ItemExchagnePanel = 24,  ---- 兑换界面
	ProsperityPanel = 25, -- 繁荣度界面
}

--通用解锁条件枚举
---@enum CommonLockJudgeType
GE.CommonLockJudgeType = {
	Level = 1,			--关卡
	UserLevel = 2,		--玩家等级
	BulidLevel = 3,		--建筑等级
	Time = 4,			--时间
	Questionnaire = 5,	--问卷完成
	ProsperityLevel = 6,	--繁荣度等级达到
}

--功能开启模块枚举
---@enum FunctionOpenModule
GE.FunctionOpenModule = {
	DifficultyMode = 1,		--困难模式
	RegularClearance = 2,	--常规清剿
	ExperienceMaterial = 3,	--经验材料
	EquipmentMaterial = 4,	--装备材料
	TalentTreeMaterial = 5,	--天赋材料
	TechTreeMaterial = 6,	--科技树材料
	PeriodicEvent = 7,		--周期性活动
	SimulationDrill = 8,	--模拟演习
	Gacha = 9,				--抽卡
	Task = 10,				--任务
	Mailbox = 11,			--邮箱
	ShipDispatch = 12,		--船只派遣
	TechTree = 13,			--科技树
	TechTreeDestroyerCruiser = 14,		--科技树驱逐巡洋舰
	TechTreeBattleshipCarrier = 15,		--科技树战列航母
	TechTreeSubmarineLogistics = 16,	--科技树潜艇后勤
	Home = 17,					--家园
	Question = 18,				--问卷调查
	WeaponMake = 19,				--武器制造
	WeaponFuse = 20,				--武器合成
	GenRoleFrag = 21,				--角色碎片
	HomelandShop = 22,			---家园商店
	GameShop = 23,				---商城
	PASSPORT = 24,				--通行证开启条件
	SignPop = 25,				--签到弹窗
	WeeklyBossChallenges = 26,	--危境攻坚	
	SevenDayTask = 27,			--七日任务
	HankBook = 28,						---图鉴
	AffectionEvent = 29,					---好感度事件
	CoveBattle = 30,						---深海入侵
	HomePatrol = 31,						---港区巡逻
	HomeWalk = 32,						---港区散步
	RoleAffectionl = 33,						---共鸣
	RoleFiles = 34,						---角色档案
	CombatIntelligenct = 35,						---情报界面
	WeatherForecastPanel = 36,						---天氣预报界面
	SceneSetting = 37,						---天氣预报界面
	MiniGame = 38,						---小游戏
}

--功能模块开启状态
---@enum FunctionOpenState
GE.FunctionOpenState = {
	Lock = 1,		--锁定
	Open = 2,		--开启
	Read = 3,		--已读
}

--功能未开放的情况下的显示枚举
GE.FunctionNotOpenDisType = {
	Hide = 0,		--隐藏入口
	Lock = 1,		--锁
}

--导航栏枚举
GE.NavigationType = {
	MainPanel = 100,					--主界面
	DockRolePanel = 101,				--船坞
	DockRolePanel_Info = 102,			--船坞	信息页签
	DockRolePanel_Info_Affectionl = 112,	--船坞	羁绊
	DockRolePanel_Info_Files = 113,	--船坞	档案
	StarUpPanel = 103,					--升星
	EquipPanel_Weapon = 104,			--装备界面 武器页签
	EquipPanel_Equip = 106,				--装备界面 装备页签
	WeaponPanel = 105,					--选择装备界面
	SkillTreePanel = 107,				--技能树
	SkinPanel = 108,					--皮肤
	SkinView = 109,						--皮肤预览
	TaskPanel = 401,					--任务
	WarePanel = 501,					--仓库
	RaffleMainPanel = 601,				--抽卡
	SeaMapPanel = 701,					--海域入口
	LevelMapPanel = 702,				--关卡入口
	TechnologyTree = 703,                   --科技树
	MaterialLevelPanel_Exp = 801,		--经验本
	MaterialLevelPanel_Tech = 802,		--科技树本
	MaterialLevelPanel_Skill = 803,		--技能树本
	MaterialLevelPanel_Equip = 804,		--装备本
	UserPanel = 901,					--主界面左上角用户详情
	ConfigPanel = 1001,					--设置界面
	MailPanel = 1101,					--主界面邮箱
	WeaponLevelUpPanel = 201,			--武器升级界面
	WeaponFusePanel = 202,				--武器合成		
	EquipIntensifyPanel_LevelUp = 301,	--装备强化
	EquipIntensifyPanel_StarUp = 302,	--装备突破
	
	PosterPanel = 1201,					--秘书舰
	EquipDel_Weapon = 203,				--武器分解	
	EquipDel_Equip = 303,				--装备分解

	SkinPanel_Action = 110,				--皮肤 展示动作
	HomeWeaponProPanel = 204,			--武器制造

	HomeQuickDispose = 1301,				--港区全局
	HomeWalk = 1302,				--港区散步
	CommandRoom = 1303,            --指挥室
	Armory  = 1304,                  --武器工坊
	BulletFactory = 1305,          --弹药工坊
	Aluminum = 1306,               --铝厂
	Steel = 1307,                  --钢铁厂
	Oil = 1308,                    --油厂
	HomePatrol = 1309,				--港区巡逻
	Dormitory = 1310,				---宿舍
	TrainingCenter = 1311,				---训练中心
	ShopRechargePanel = 1401,		--商城氪金界面
	Handbooks = 1501,		--图鉴
	HandbooksChar = 1502,	--角色图鉴
	HandbooksWeapon = 1503,	--武器图鉴
	HandbooksEquip = 1504,	--装备图鉴
	HandbooksStory = 1505,	--剧情图鉴
	StoryListPanel = 1506,	-- 剧情列表界面

	DispatchPanel = 1601,			--派遣界面

	SimulatedLevelPanel = 1701,		--模拟演习界面
	QuestionPanel = 1801,		--问卷调查
	HomelandShopPanel = 1901,				--家园商店
	GameShopPanel = 2001,				--游戏商店
	GoodsItemPanel = 2002,				--购买界面

	PassPanel = 2101,				--通行证
	GoodsItemPanel = 2201,				--游戏商店
	GenRoleFrag = 2201,              --跑片
	FriendPanel = 2401,				--好友
	SignPopPanel = 2501,				--签到弹窗
	WeeklyBossMainPanel = 2601,		--周boss主界面
	ActivityPanel = 2701,				--活动界面
	SevenDaysTaskPanel = 2801,			--七日任务界面
	CombatIntelligenctPanel = 2901,				--情报界面
	HomeLvUpPanel = 3001,				--家园升级界面
}

--提示内容类型
---@enum InstructionsType
GE.InstructionsType = {
	picture = 1,		--图片
	text = 2,			--文本
}

--提示文字内容类型枚举
GE.InstructionsContentType = {
	iconList = 101,	--图标列表
	gachaMsgList = 102,	--抽卡说明列表
}

--章节表DeepType枚举
GE.ChapterDeepType = {
	Exp = 1,		--经验本
	Skill = 2,		--技能树
	Technology = 3,	--科技树
	Equip = 4,		--装备
}

--关卡入口类型(根据关卡玩法区分)
---@enum LevelBattleType
GE.LevelBattleType = {
	Normal = 1,		--普通关卡
	Simulated = 2,	--模拟关卡
}

--产出消耗渠道
---@enum EventItemType
GE.EventItemType = {
	GM			= 0,	--gm命令
	Test		= 1,	--测试
	Init		= 2,	--初始化
	Summon		= 3,	--抽卡
	Achievement	= 4,	--成就
	SignIn		= 5,	--签到
	Task		= 6,	--任务
	Battle		= 7,	--战斗
	Sweep		= 8,	--扫荡
	Mail		= 9,	--邮件
	BuyGoods	= 10,	--购买商品
	RefreshShop	= 11,	--刷新商店
	Activity	= 12,	--活动
	Natural 	= 13,	--自然恢复
	Advert 		= 14,	--广告
	MoneyPay	= 15,	--充值
	Passport 	= 16,	--通行证
	RedeemCode 	= 17,	--兑换码
	FirstRecharge = 18,	--首充奖励
	changeUserName = 19,--玩家改名
	BuyTicket = 20,		--购买体力
	CurrencyUse = 21,	--使用货币
	HeroStarUp	= 22,	--英雄升星
	HeroLevelUp	= 23,	--英雄升级
	EquipDecompose	= 24,	--装备分解
	EquipLevelUp	= 25,	--装备升级
	EquipStarUp		= 26,	--装备突破
	WeaponDecompose	= 27,	--武器分解
	WeaponLevelUp	= 28,	--武器升级
	WeaponFuse 		= 29,	--武器融合
	HomeBuilding	= 30,	--家园建筑奖励
	WeaponProduce	= 31,	--武器生产
	LevelAchievement= 32,	--关卡成就
	ChapterStar		= 33,	--章节星级奖励
	AffectionLevelUp	= 34,	--英雄好感度等级提升
	AffectionEventAccept= 35,	--接受好感度事件
	AffectionEventFinish= 36,	--完成好感度事件
	AffectionGiveGift	= 37,	--好感度赠送礼物
	TechnologyNodeLevelUp = 41,	--科技树节点升级
	TalentNodeUnlock = 42,	--天赋树节点解锁
	HomeLvUp = 43,	-- 家园升级
	Dispatch = 44,	--派遣
	OpenItem = 45,	--打开道具
	Simulated = 46,	--模拟演习
	SimulatedSweep = 47,	--模拟演习扫荡
	Qnaire = 48,	--问卷调查
	GenRoleFrag = 49,	--角色碎片合成
	PASS = 50,	--通行证
	UserLevelUp = 51,	--玩家升级
	CycleCard = 52,		--月卡周卡

	--家园
	HomeAction = 53,	--家园英雄行为
	HomeEarnings = 54,	--家园离线收益
	HomeCoveUsableItem = 55,	--家园互动道具
	BossScoreReward = 56,	--boss积分奖励
	HomeCoveBattle = 57,	--家园战斗道具

	Share = 58,	--分享

	--好友
	FriendPoint = 600,	--友情点

	Wechat_Xipu_BindPhone = 700,	--绑定手机号
	Wechat_Share = 1001,		--微信分享
	Wechat_EnterScene = 1002,	--微信进入场景
	Wechat_Subscribe = 1003,	--微信订阅
	Wechat_GiftNtf = 1004,		--微信礼包
	Wechat_SousouSignIn = 1005,	--微信搜一搜签到
	Wechat_GameClubTask = 1006,	--微信游戏圈任务

}

---@enum NameChangeType
GE.NameChangeType = {
	RegisterName = 1,	--注册取名
	ChangeHeroName = 2,	--修改英雄昵称
	ChangeUserName = 3,	--修改玩家昵称
	ChangeUserSign = 4,	--修改玩家签名
}

--跳转锁定类型
---@enum JumpLockType
GE.JumpLockType = {
	ChapterUnLock = 1,			--主线章节解锁
	LevelUnlock = 2,		--关卡解锁
	FuncOpen = 3,		--功能玩法解锁
	ItemNum = 4,		--道具数量
}

--英雄养成类型
GE.HeroDevelopType = {
	Get = 0,		--获取
	Exp = 1,		--经验
	Level = 2,		--等级
	Star = 3,		--星级
	AffectionExp = 4,	--好感度经验
	AffectionLevel = 5,	--好感度等级
	Talent = 6,			--天赋树节点
	EquipWeapon = 7,	--穿戴武器或装备
}

--装备养成类型
GE.EquipDevelopType = {
	Get = 0,		--获取
	Exp = 1,		--经验
	Level = 2,		--等级
	Star = 3,		--星级
	OwnerId = 4,	--拥有者id
	LockState = 5,	--锁定状态 0未锁定 1已锁定
}

--武器养成类型
GE.WeaponDevelopType = {
	Get = 0,		--获取
	Exp = 1,		--经验
	Level = 2,		--等级
	OwnerId = 3,	--拥有者id
	LockState = 4,	--锁定状态 0未锁定 1已锁定
}

--登录区服错误码
GE.LoginZoneCode = 
{
	none = 0,
	faile1 = 1,		--登录失败1
	urepeat = 2,	--重复登录
	faile3 = 3,		--登录失败3
	faile4 = 4,		--登录失败4
	noBindPhone = 5,		--还没绑定手机号
	serverClose = 6,		--服务器关闭、服务器维护中
	permissionDenied = 7,	--没有权限登录
	memAvailableLimit = 8,	--服务器繁忙
}

--踢人错误码
GE.KickReasonCode =
{
	otherLogin = 1,		--别的地方登录
	serverKick = 2,		--被服务器踢出
	serverClose = 3,		--服务器关闭
	switchGateway = 4,		--切换网关
	protocolDuplicate = 5,	--协议重复
}

--白名单类型
GE.writeListType = 
{
	ip = 1,		--ip白名单
	aid = 2,	--账号id白名单
}

--白名单操作
GE.writeListOperate = 
{
	init = 0,	--初始化缓存
	find = 1,	--查看
	add = 2,	--增加
	update = 3,	--更新
	delete = 4,	--删除
}

--兑换码类型
GE.redeemCodeType = 
{
	common = 1,		--通用码
	normal = 2,		--普通码
	max = 3,
}

--兑换码领取id类型
GE.redeemCodeGetId = 
{
	aid = 1,		--账号id
	uid = 2,		--角色id
	max = 3,
}

--兑换码领取状态
GE.redeemCodeGetStatus = 
{
	wait_verify = 0,		--等待验证
	get_reward = 1,			--验证通过，领取奖励
	confirm_reward = 2,		--确认领取奖励
	delete = 3,				--删除
}

--实名认证行为枚举
GE.authenticationAction = 
{
	online = 1,		--上线
	offline = 0,	--下线
}

--实名认证认证结果
GE.authenticationResult =
{
	success = 0,		--认证成功
	authIng = 1,		--认证中
	failed = 2,			--认证失败
}


-----------------------------舰L New---------------------------

GE.EquipSortType = {
	default = 1,			--默认
	level = 2,				--等级
	quality = 3,			--稀有度
}

---@enum EquipHandBookSortType
GE.EquipHandBookSortType = {
	default = 1,			--默认
	type = 2,				--类型
	quality = 3,			--稀有度
	count = 4,				--持有数量
}

GE.EquipSortTypeName = {
	"default",				--默认
	"level",				--等级
	"quality",				--稀有度
}

---@enum EquipHandBookSortTypeName
GE.EquipHandBookSortTypeName = {
	"default",				--默认
	"type",					--类型
	"quality",				--稀有度
	"count",				--持有数量
}

--装备图鉴筛选-装备类型（对应EquipmentTable表中equipType字段）
---@enum EquipHandbookFiltrateType
GE.EquipHandbookFiltrateType = {
	shell = 1,				--炮弹
	torpedo = 2,			--鱼雷
	missile = 3,			--导弹
	airBomb = 4,			--航空炸弹
	airTorpedo = 5,			--航空鱼雷
	armor = 21,				--装甲
	engine = 31,			--发动机
	fighter = 41,			--战斗机
	fireControl = 42,		--火控设备
	radar = 43,				--雷达
	repair = 44,			--维修设备
}

---@enum WeaponHandbookFiltrateType
GE.WeaponHandbookFiltrateType = {
	largeCaliber = 1,		--大口径炮
	mediumCaliber = 2,		--中口径炮
	smallCaliber = 3,		--小口径炮
	torpedoLauncher = 4,	--鱼雷发射器
	bomber = 5,				--轰炸机
	torpedoBomber = 6,		--鱼雷机
	missileLauncher = 7,	--导弹发射器
	submarineTorpedo = 8,	--鱼雷发射器(潜艇)
}

--图鉴排序类型
GE.HandbookSortType = {
	default = 1,	--默认
	quality = 2,	--品质
	type = 3,		--类型
	ownCount = 4,	--持有数量
	nature = 5,		--属性
}

GE.HandbookSortTypeName = {
	"default",		--默认
	"quality",		--品质
	"type",			--类型
	"ownCount",		--持有数量
	"nature",		--属性
}

GE.WeaponSortType = {
	default = 1,			--默认
	level = 2,				--等级
	quality = 3,			--稀有度
	loadValue = 4,			--载重
	point = 5,				--评分
}

GE.WeaponSortTypeName = {
	"default",				--默认
	"level",				--等级
	"quality",				--稀有度
	"loadValue",			--载重
	"point",				--评分
}

---@enum WeaponHandBookSortType
GE.WeaponHandBookSortType = {
	default = 1,			--默认
	quality = 2,			--品质
	type = 3,				--类型
	count = 4,				--持有数量
}

---@enum WeaponHandBookSortTypeName
GE.WeaponHandBookSortTypeName = {
	"default",				--默认
	"quality",				--品质
	"type",					--类型
	"count",				--持有数量
}

--剧情图鉴排序类型
---@enum StoryHandBookSortType
GE.StoryHandBookSortType = {
	default = 1,        --默认
	storyOrder = 2,     --剧情顺序
}

---@enum StoryHandBookSortTypeName
GE.StoryHandBookSortTypeName = {
	"default",			--默认
	"storyOrder",		--剧情顺序
}

--角色排序枚举
GE.RoleSortType = {
	default = 1,			--默认
	level = 2,				--等级
	star = 3,				--星级
	quality = 4,	 		--稀有度
	favorability = 5,	 	--好感度
	allDmg = 6,				--综合伤害
	getTime = 7,			--获取顺序
	nature = 8,				--属性
}

--角色排序枚举（名
GE.RoleSortTypeName = {
	"default",			--默认
	"level",			--等级
	"star",				--星级
	"quality",	 		--稀有度
	"favorability",	 	--好感度
	"allDmg",			--综合伤害
	"getTime",			--获取顺序
	"nature",			--属性
}

--属性类型列表
---@enum NatureType
GE.NatureType = {
	hp = 1,					--耐久
	bombard = 2,			--炮击
	torpedo = 3,			--雷击
	armor = 4,				--装甲
	evade = 5,				--机动
	airdefense = 6,			--防空
	lucky = 7,				--幸运
}

--属性类型列表（名
GE.NatureTypeName = {
	"hp",			--耐久
	"bombard",		--炮击
	"torpedo",		--雷击
	"armor",		--装甲
	"evade",		--机动
	"airdefense",	--防空
	"lucky",		--幸运
}
-- GE.NatureTypeName = DLuaUtil.GetReverseTable(GE.NatureType)

--英雄稀有度
GE.HeroRankStar = {
	N = 2,
	R = 3,
	SR = 4,
	SSR = 5,
}

--资源背景类型
---@enum ResBgType
GE.ResBgTYpe = {
	normal = 1,		--普通
	ticket = 2,		--体力
	res = 3,		--资源
}

-- --抽卡说明类型枚举
-- ---@enum RaffleMsgType
-- GE.RaffleMsgType = {
-- 	RulesTxt = 1,	--抽卡规则文本(带星星)
-- 	Cube = 2,		--占位符
-- 	RankMsgTxt = 3,	--稀有度文本（带SSR图标）
-- 	MsgTxt = 4,		--普通文本
-- 	MsgView = 5,	--英雄图标列表
-- }

--抽卡说明类型枚举
---@enum RaffleMsgType
GE.RaffleMsgType = {
	"RulesTxt",	--抽卡规则文本(带星星)
	"cube",		--占位符
	"RankMsgTxt",	--稀有度文本（带SSR图标）
	"MsgTxt",		--普通文本
	"MsgView",	--英雄图标列表
}

----------------------家园相关----------------------

--家园角色交互菜单类型枚举
---@enum GE.ClickMenuType
GE.ClickMenuType = {
	home = 1,	--首页
	talk = 2	--聊天
}
--家园透视相机类型枚举
---@enum GE.HomeLandPerspectiveType
GE.HomeLandPerspectiveType = {
	Whole = 1,		--家园全局移动相机
	HomeFunc = 2,	--家园功能聚焦相机
}

--家园建筑工作区枚举
GE.HomeLandWorkAreaType = {
	None = 0,
	work = 1
}

--家园建筑工作枚举
GE.HomeLandWorkType = {
	Resource = 2	--资源产出
}

--家园建筑类型枚举
---@enum CoustructionEnum
GE.CoustructionEnum = {
	Road = 10001,				--道路
	BigSquare = 10002,			--大广场
	Armory = 10003,				--武器工坊
	WS2 = 10011,				--工作区2  弹药
	SmallSquare = 10005,		--小广场
	TrainingCenter = 10006,				---训练中心
	Cafe = 10007,				--咖啡厅
	WS3 = 10008,				--工作区3
	Shop = 10004,				--小卖铺
	CommandRoom = 10009,		--指挥室
	Steel = 10013,				--钢场
	OilWell = 10010,			--油井
	AdmiralRoom = 10016,		--提督室
	Aluminum = 10012,			--铝厂
	Dormitory = 10018,			--宿舍
	Intelligenct = 10019,		--公告栏
	MiniGame = 10025,			--小游戏
	PatrolRoom = 10099,			--巡逻广场
}

--科技树页签类型
---@enum TechnologyTreeType
GE.TechnologyTreeType = {
	page1 = 1,		--驱逐巡洋
	page2 = 2,		--战列航母
	page3 = 3,		--潜艇后勤
	page4 = 4,		--家园
}

--科技树节点效果类型
---@enum TechTreeNodeEffectType
GE.TechTreeNodeEffectType = {
	Attr = 1,		--属性提升
	Reward = 2,		--获得奖励
	Skill = 3,		--获得技能
	HomeLandOutput = 4,		--家园产出
}

--科技树家园加成类型
---@enum TechTreeHomeUpType
GE.TechTreeHomeUpType = {
	OutPut = 1,		--产出提升
	DispatchRecover = 2,	--派遣回复提升
	--GenRoleFragSlot = 3,	--角色碎片栏位解锁
	--GenRoleFragAdd = 4,	--角色碎片获取提升
	WalkRoleCount = 5,	--散步角色数量提升
}



--舰船类型枚举（大类）
GE.AttributeType = {
	All = 0,		--全部
	BB = 1,			--战列舰
	CA = 2,			--巡洋舰
	DD = 3,			--驱逐舰
	AO = 4,			--补给舰
	CV = 5,			--航空母舰
	SS = 6,			--潜艇
	SP = 7,			--特殊
}

--关卡状态
GE.LevelStateType = {
	Going = 1,				--进行中
	Finish = 2,				--已完成
}

--关卡类型(对应PveLevel表中type字段)
GE.LevelType = {
	Battle = 1,		--战斗
	Story = 2,		--剧情
	Res = 3,		--资源点
	Once = 4,		--一次性关卡
}

--关卡大类(对应PveLevel表中typemain字段)
---@enum LevelTypeMain
GE.LevelTypeMain = {
	Other = 0,		--其他
	Main = 1,		--主线
	Difficulty = 3,	--主线困难
	Simulated = 4,	--模拟演习
	Material = 5,	--日常材料
	WeeklyBoss = 6,	--危境攻坚
	ExpMaterial = 7,	--经验材料
	TalentMaterial = 8,	--天赋材料
	TechMaterial = 9,	--科技树材料
	EquipMaterial = 10,	--装备材料
	Intelligence = 11,	--情报关卡
}

--地图关卡节点类型
GE.LevelPointType = {
	Normal = 1,		--普通节点）
	Once = 2,		--一次性节点
}

--演出剧情行为类型
GE.BattleStoryAction = {
	RoleMove = 1,--角色移动
	RoleTurn = 2,--角色转向
	RoleAction = 3,--角色动作
	RoleSpeak = 4,--角色对话气泡
	RoleEmote = 5,--角色表情气泡
	CameraMove = 8,--相机移动
	CameraZoom = 9,--相机缩放
	Wait = 10,--等待并进入下一Cut
	SetBGM = 11,--控制BGM
	PlaySE = 12,--播放音效
	GalStory = 13,--插入gal对话
	EndStory = 14,--剧情结束
	InitRole = 15,--初始化角色
	InitCamera = 16,--初始化相机
	InitMap = 17,--初始化地图
	RoleVisible = 18,--角色显示隐藏
	RoleAttack = 19,--角色攻击目标
	ShowEffect = 20,--显示特效
	ChangeCamera = 21,--切换相机
	InitSceneEffect = 22,--初始化场景特效
	RoleSpeakAuto = 23,--角色自动对话气泡
	Curtain = 24,--幕布
	RoleTeleport = 25,--角色瞬移
	HomeLandBuildingLVUp = 26,--家园建筑升级动画
	HomelandCameraMove = 27,--家园相机移动
}

--演出对话气泡类型
GE.SpeakBubbleType = {
	Big = 1,--带名字头像气泡
	Middle = 2,--仅两行文字气泡
	Small = 3,--仅一行八个字气泡
}

--人物spine动作基础类型
GE.RoleSpineActionType = {
	Action = 1,		--动作
	Emote = 2,		--表情
	Effect = 10,	--特效
}

--剧情文本正则表达式类型
GE.StoryTextRegex = {
	Pause = "{Pause=(%d+%.?%d*)}",
	Action = "{Action=([^,}]+)}",
	ActionAndTime = "{Action=(%d+%.?%d*),Time=(%d+%.?%d*)}",--看板娘功能使用
}

--剧情内容完成类型(埋点用)
GE.StoryContentFinishType = {
	NormalClick = 1,	--自然完成
	QuickClick = 2,		--加速完成
	AutoPlay = 3,		--自动播放完成
}

--看板娘互动基础类型(对应SkinAction表type字段)
GE.SkinActionType = {
	Base = 100,			--基础类型
	HoldChange = 101,	--可保持的大变化
	ChangeToBase = 102,	--自动切换回基础状态
	PartChange = 201,	--局部变化
	OneTimeChange = 301,--一次性变化
}

--看板娘局部变化控制状态类型
GE.SkinPartChangeState = {
	Open = 1,		--开启
	Close = 2,		--关闭
	Change = 3,		--切换
}

--章节类型(对应Chapter表Type字段)
GE.ChapterType = {
	MainStory = 1,		--主线章节
	Material = 2,		--材料章节
	MainDifficult = 3,	--主线章节困难
}

--触发器刷新类型
---@enum EventTriggerRefreshType
GE.EventTriggerlimitType = {
	Daily = 1,		--每日
	Weekly = 2,		--每周
	Monthly = 3,	--每月
}

--好感度事件类型
GE.AffectionEventType = {
	Normal = 1,					--普通事件
	Delegate = 2,				--委托事件
}

--好感度事件效果枚举
GE.AffectionEventEffectType = {
	Null = 101,						--暂时放置
	GiveUp = 102,					--放弃
	IgnoreConditionEvent = 103,		--激活事件
	CloseEvent = 104,				--关闭事件
	AcceptDelegate = 105,			--接受委托
}

--好感度事件开启状态
---@enum AffectionEventState
GE.AffectionEventState = {
	Close = 0,		--关闭
	Open = 1,		--开放
}

--好感度事件激活条件类型
GE.AffectionEventActivationType = {
	Affection = 101,		--指定角色的好感度到达指定数值
	LevelFinish = 102,		--指定关卡完成
}

GE.EventTriggerSystemType = {
	Affection = 1,		--好感触发器
	Dispatch = 2,		--派遣触发器
	CombatIntellgence = 3,			--情报触发
	HomelandBattle = 4,			--家园战斗
}

--任务系统类型 （用于区分任务属于哪个系统不在task表内）
---@enum MissionSystemType
GE.MissionSystemType = {
	task = 1,			--任务系统
	affection = 2,		--好感系统
}

--任务状态
GE.MissionState = {
	Unclaimed = 1,		--待领取
	Lock = 2,			--未解锁
	Progress = 3,		--进行中
	Received = 4,		--已领取
	Closed = 5,			--已关闭
}

--任务类型
--新增任务类型需要的操作
-- GE.MissionMsgTitleStr 同步
-- GE.MissionMsgContentColor 同步
-- SetMissionListInfoNtf 方法里面处理是否需要提示弹窗
-- MissionMsgPanel预制体里控制背景图
GE.MissionType = {
	EveryDay = 1,		--每日
	EveryWeek = 2,		--每周
	Achieve = 3,		--成就
	AchieveLevel = 4,	--成就积分
	PassTask = 5,		--通行证任务
	BossTask = 6,		--危境攻坚任务
	FirstCharge = 7,	-- 首充返利活动
	HeroExchange = 8,	--英雄兑换活动
	SevenDayTask = 9,	--七日登录任务
	CommanderRank = 10, --指挥官等级任务
	HomeLandEvent = 11,		--家园交互任务
	ActivityTask = 12,		--活动任务
	Prosperity = 13,		--繁荣度任务
	PortConstruction = 14,		--港口建设任务
}

--活动类型、任务类型对应关系
GE.ActivityMissionType = {
	[GE.ActivityType.Pass] = GE.MissionType.PassTask,
	[GE.ActivityType.FirstCharge] = GE.MissionType.FirstCharge,
	[GE.ActivityType.HeroExchange] = GE.MissionType.HeroExchange,
	[GE.ActivityType.SevenDayTask] = GE.MissionType.SevenDayTask,
	[GE.ActivityType.CommanderRank] = GE.MissionType.CommanderRank,
	[GE.ActivityType.PortConstruction] = GE.MissionType.PortConstruction
}

--任务类型对应活动id
GE.MissionActivityId = {
	[GE.MissionType.CommanderRank] = 80001,	--指挥官等级活动id
}

--任务刷新类型
GE.MissionRefreshType = {
	None = 0,			--不刷新
	Daily = 1,			--每日刷新
	Weekly = 2,			--每周刷新
	Monthly = 3,		--每月刷新
}

--成就详细类型
GE.MissionDetailType = {
	Battle = 1,				--战斗
	Home = 2,				--家园
	Map = 3,				--地图
	Special = 4,			--特殊
	Other = 5,				--其他
}

--成就详细类型
GE.MissionDetailTypeName = {
	"AchievementTitle_1",				--战斗
	"AchievementTitle_2",				--家园
	"AchievementTitle_3",				--养成
	"AchievementTitle_4",				--其他
}

--每日任务详细类型
GE.DayTaskType = {
	DayCommon = 1,			--每日常规
	DayPoint = 2,			--每日阶段奖励
}

--每周任务详细类型
GE.WeekTaskType = {
	WeekCommon = 1,			--每周常规
	WeekPoint = 2,			--每周阶段奖励
}

--七日任务详细类型
GE.SevenDayTaskType = {
	SevenDayCommon = 1,		--七日普通任务(完成后增加积分)
	SevenDayPoint = 2,		--七日积分任务(需要累计积分)
}

--任务默认状态 目前用于任务锁定时也计数
GE.MissionCommonState = {
	None = 1,			--暂无效果
	LockCount = 2,		--锁定时计数
}

--任务解锁条件
GE.MissionUnLockType = {
	ClearTask = 1,				--完成指定任务
	ClearLevel = 2,				--通关指定关卡
	UserLevel = 3,				--玩家达到指定等级
	DayCount = 4,				--注册后经过的天数
	HomeLandBuildLevel = 5,			--家园指定建筑达到指定等级	TODO暂无效果
}

--任务解锁条件
GE.MissionUnLockTypeName = {
	[1] = "ClearTask",				--完成指定任务
	[2] = "ClearLevel",				--通关指定关卡
	[3] = "UserLevel",				--玩家达到指定等级
	[4] = "DayCount",				--注册后经过的天数
	[5] = "HomeLandBuildLevel",			--家园指定建筑达到指定等级
}

--任务完成条件名
---@enum MissionFinishTypeName
GE.MissionFinishTypeName = {
	[1] = "ClearTask",					--完成指定任务（组）
	[2] = "ClearLevel",					--通关指定关卡 (组)
	[3] = "UserLevel",					--玩家达到指定 等级
	[4] = "ClearLevelType",				--通关指定类型关卡次数（扫荡不生效）
	[5] = "ClearLevelTypeCount",		--通关任意关卡 次数
	[6] = "ClearLevelCount",			--通关指定关卡 次数
	[7] = "KillEnemyCount",				--累计击败任意敌人数量
	[8] = "KillEnemyTypeCount",			--累计击败指定敌人数量
	[9] = "MakeWeapon",					--制作一件武器
	[10] = "RoleLevel",					--任意数量角色达到指定等级
	[11] = "RoleSkillTree",				--任意数量角色激活天赋树节点数
	[12] = "UseTicket",					--累计消耗体力
	[13] = "RoleLevelUp",				--角色升级
	[14] = "WeaponLevel",				--武器强化(不用升级)
	[15] = "EquipLevel",				--装备强化(不用升级)
	[16] = "EquipStarUp",				--装备突破
	[17] = "GetPoint",					--达到指定积分值
	[18] = "GetRole",					--角色累计获取
	[19] = "ClearTaskCount",			--完成任务数量
	[20] = "AchieveLevel",				--成就等级
	[21] = "AssignHeroReachLevel",		--指定角色 达到指定等级  {21，指定角色id，等级}
	[22] = "SpecifiedRoleCountWithAffectionLevel",		--指定数量角色 达到指定好感度等级
	[23] = "AssignHeroReachAffectionLevel",					--指定角色 达到指定好感度等级
	[24] = "SpecifiedRoleCountWithRankReachStar",			--指定数量 指定稀有度角色 达到指定星级
	[25] = "AssignHeroReachStar",				--指定角色 达到指定星级
	[26] = "DrawCardCount",						--累计抽卡次数
	[27] = "GetRoleWithRankCount",				--累计获取指定稀有度角色数量
	[28] = "FinishHomeEventById",				--完成指定id的家园事件
	[29] = "FinishHomeEventCount",				--完成指定数量的家园事件
	[30] = "FinishDispatchCount",				--完成派遣次数
	[31] = "FinishDispatchById",				--完全通关指定id的派遣任务
	[32] = "CollectSpecificResourceCount",		--累计收取指定数量的指定资源（油弹钢铝）
	[33] = "GetItemCountById",					--累计获取指定数量的指定id物品
	[34] = "UpgradeHomeBuildingToLevel",			--指定家园建筑 升到指定等级
	[35] = "OwnEquipCountByLevelPartRank",			--累计拥有 指定数量的 指定等级的 指定部位的 指定稀有度的 装备
	[36] = "TowerJoinCount",					--参与爬塔次数
	[37] = "TowerReachLevel",					--爬塔达到指定层数
	[38] = "CurrentActionPointReachValue",			--当前行动点达到指定数值
	[39] = "RoleCountFinishTalentStage",			--指定数量角色 完成天赋树指定阶段数
	[40] = "SelectHomeEventOptionById",			--指定家园事件选择指定选项
	[41] = "MultiEvent",						--多事件
	[42] = "GiveAssignGiftToRoleCount",  		--给指定角色赠送指定数量的指定礼物
	[43] = "LoginDayCount",						--累计登录天数
	[44] = "GiveGiftToRoleCount",  				--给指定角色赠送指定数量的礼物
	[45] = "LoginDayCountAfterUnlock",			--累计登录天数（任务解锁后）
	[46] = "GetDifferentWeaponTypeCount",		--获得X种武器 （需求要调整，暂时不做）
	[47] = "AssignHeroReachSpecificLevel", 		--指定角色提升指定等级
	[48] = "BuyItemCountByShopType",			--指定商店类型购买多少次商品
	[49] = "BossLevelReachPoint",				--危境攻坚(BOSS战)指定boss历史最高积分达到XX
	[50] = "BossLevelClearDifficult",			--危境攻坚(BOSS战)指定boss通关指定难度
	[51] = "BossLevelGetPointInRound",			--危境攻坚(BOSS战)指定boss，X个回合获得XX积分
	[52] = "FirstCharge",						--首充返利活动{52,金额}
	[53] = "ConsumeItem",						--消耗道具{53,id,num}
	[54] = "RefreshShop",						--商店刷新次数{54,商店ID,次数}
	[55] = "SyncTrainingCount",				--同步训练次数{55,次数}
	[56] = "SupportEquipReachLevel",			--指定数量的支援舰装强化至指定等级{56,等级,数量}
	[57] = "AttackWeaponReachLevel",			--指定数量的攻击舰装强化至指定等级{57,等级,数量}
	[58] = "TechTreeActivateNodeCount",		--激活指定科技基盘的指定数量节点{58,科技基盘类型,激活节点数量}
	[59] = "RoleCountReachStar",				--指定数量角色达到指定星级{59,星级,数量}
	[60] = "CompleteAllDailyTask",			--完成所有每日任务{60,难度}
	[61] = "SevenDayTaskAllComplete",		--七日任务所有任务完成{61}
	[62] = "ChatWithHomeRole",				--与家园中任意角色进行聊天{62,次数}
	[63] = "ConsumeItemCountById",			--消耗指定数量的指定id货币{63,货币id,数量}
	[64] = "Prosperity",					--繁荣度累计值达到指定数量{64,目标值}
	[65] = "MultiHomeBuildingReachLevel",	--指定多个建筑均达到指定等级{65,{{建筑id,等级},{建筑id,等级}...}}
	[66] = "ProsperityReachLevel",			--繁荣等级达到指定等级{66,繁荣等级}
}

--任务完成条件
---@enum MissionFinishType
GE.MissionFinishType = {
	ClearTask = 1,					--完成指定任务（组）
	ClearLevel = 2,					--通关指定关卡 (组)
	UserLevel = 3,					--玩家达到指定 等级
	ClearLevelType = 4,				--通关指定类型关卡次数（扫荡不生效）
	ClearLevelTypeCount = 5,		--通关任意关卡 次数
	ClearLevelCount = 6,			--通关指定关卡 次数
	KillEnemyCount = 7,				--累计击败任意敌人数量
	KillEnemyTypeCount = 8,			--累计击败指定敌人数量
	MakeWeapon = 9,					--制作一件武器
	RoleLevel = 10,					--任意数量角色达到指定等级
	RoleSkillTree = 11,				--任意数量角色激活天赋树节点数
	UseTicket = 12,					--累计消耗体力
	RoleLevelUp = 13,				--角色升级
	WeaponLevel = 14,				--武器强化(不用升级)
	EquipLevel = 15,				--装备强化(不用升级)
	EquipStarUp = 16,				--装备突破
	GetPoint = 17,					--达到指定积分值
	GetRole = 18,					--角色累计获取
	ClearTaskCount = 19,			--完成任务数量
	AchieveLevel = 20,				--成就等级
	AssignHeroReachLevel = 21,		--指定角色 达到指定等级
	SpecifiedRoleCountWithAffectionLevel = 22,		--指定数量角色 达到指定好感度等级
	AssignHeroReachAffectionLevel = 23,					--指定角色 达到指定好感度等级
	SpecifiedRoleCountWithRankReachStar = 24,			--指定数量 指定稀有度角色 达到指定星级
	AssignHeroReachStar = 25,				--指定角色 达到指定星级
	DrawCardCount = 26,						--累计抽卡次数
	GetRoleWithRankCount = 27,				--累计获取指定稀有度角色数量
	FinishHomeEventById = 28,				--完成指定id的家园事件
	FinishHomeEventCount = 29,				--完成指定数量的家园事件
	FinishDispatchCount = 30,				--完成派遣次数
	FinishDispatchById = 31,				--完全通关指定id的派遣任务
	CollectSpecificResourceCount = 32,		--累计收取指定数量的指定资源（油弹钢铝）
	GetItemCountById = 33,					--累计获取指定数量的指定id物品
	UpgradeHomeBuildingToLevel = 34,		--指定家园建筑 升到指定等级
	OwnEquipCountByLevelPartRank = 35,		--累计拥有 指定数量的 指定等级的 指定部位的 指定稀有度的 装备
	TowerJoinCount = 36,					--参与爬塔次数
	TowerReachLevel = 37,					--爬塔达到指定层数
	CurrentActionPointReachValue = 38,		--当前行动点达到指定数值
	RoleCountFinishTalentStage = 39,		--指定数量角色 完成天赋树指定阶段数
	SelectHomeEventOptionById = 40,			--指定家园事件选择指定选项
	MultiEvent = 41,						--多事件
	GiveAssignGiftToRoleCount = 42,  		--给指定角色赠送指定数量的指定礼物
	LoginDayCount = 43,						--累计登录天数
	GiveGiftToRoleCount = 44,  				--给指定角色赠送指定数量的礼物
	LoginDayCountAfterUnlock = 45,			--累计登录天数（任务解锁后）
	GetDifferentWeaponTypeCount = 46,		--获得X种武器 （需求要调整，暂时不做）
	AssignHeroReachSpecificLevel = 47, 		--指定角色提升指定等级
	BuyItemCountByShopType = 48,			--指定商店类型购买多少次商品
	BossLevelReachPoint = 49,				--危境攻坚(BOSS战)指定boss历史最高积分达到XX
	BossLevelClearDifficult = 50,			--危境攻坚(BOSS战)指定boss通关指定难度
	BossLevelGetPointInRound = 51,			--危境攻坚(BOSS战)指定boss，X个回合获得XX积分
	FirstCharge = 52,						--首充返利活动{52,金额}
	ConsumeItem = 53,						--消耗道具{53,id,num}
	RefreshShop = 54,						--商店刷新次数{54,商店ID,次数}
	SyncTrainingCount = 55,				--同步训练次数{55,次数}
	SupportEquipReachLevel = 56,		--指定数量的支援舰装强化至指定等级{56,等级,数量}
	AttackWeaponReachLevel = 57,		--指定数量的攻击舰装强化至指定等级{57,等级,数量}
	TechTreeActivateNodeCount = 58,	--激活指定科技基盘的指定数量节点{58,科技基盘类型,激活节点数量}
	RoleCountReachStar = 59,			--指定数量角色达到指定星级{59,星级,数量}
	BossLevelClearAnyDifficult = 60,	--通过危境攻坚任意指定难度关卡{60,难度}
	SevenDayTaskAllComplete = 61,		--七日任务所有任务完成{61}
	ChatWithHomeRole = 62,				--与家园中任意角色进行聊天{62,次数}
	ConsumeItemCountById = 63,			--消耗指定数量的指定id货币{63,货币id,数量}
	Prosperity = 64,					--繁荣度累计值达到指定数量{64,目标值}
	MultiHomeBuildingReachLevel = 65,	--指定多个建筑均达到指定等级{65,{{建筑id,等级},{建筑id,等级}...}}
	ProsperityReachLevel = 66,			--繁荣等级达到指定等级{66,繁荣等级}
}

--繁荣度增加渠道
GE.ProsperityChannel = {
	Item = 1,		--道具渠道（不受每日上限）
	Behavior = 2,	--行为渠道（受每日上限）
}

--繁荣度代替道具id（不入背包，直接转化为繁荣値）
GE.ProsperityItemId = 100016

--获取繁荣度途径
GE.GetProsperityType = {
	SayHi = 1,				--打招呼
	HomeEvent = 2,			--家园事件
	SyncTraining = 3,		--同步训练
	MiniGame =  4,			--小游戏
}

--特殊状态
GE.MissionSpecialType = {
	None = 1,					--无特殊情况
	LockNoAdd = 2,				--未解锁不累计
	Hide = 3,					--隐藏
}

--任务完成提示标题多语言(key值对应任务类型)
GE.MissionMsgTitleStr = {
	[1] = "TaskComplete_1",		--每日任务完成标题
	[2] = "TaskComplete_2",		--每周任务完成标题
	[3] = "TaskComplete_3",		--成就任务完成标题
	[5] = "TaskComplete_5",		--通行证任务完成标题
	[6] = "TaskComplete_3",		--boss战任务完成标题
}

--任务完成内容描述字体颜色(key值对应任务类型)
GE.MissionMsgContentColor = {
	[1] = "333333",	--每日任务颜色
	[2] = "4D3204",	--每周任务颜色
	[3] = "0E588C",	--成就任务颜色
	[5] = "063832",	--通行证任务颜色
	[6] = "0E588C",	--boss战任务颜色
}

--图鉴类型
---@enum HandbookType
GE.HandbookType = {
	Hero = 1,			--角色
	Monster = 2,		--怪物
	Equip = 3,			--装备
	Weapon = 4,			--武器
	Story = 6,			--故事
}

--技能树额外解锁条件
GE.TreeExtraUnlock = {
	Level = 1,			--等级
	AffectionLevel = 2,	--好感度等级
}

--进入战斗方法
GE.EnterBattleType = {
	Normal = 1,			--正常进入
	NextLevel = 2,		--下一关进入
	Restart = 3,		--重新开始进入
}

---@enum BattleResultType
--战斗结果类型
GE.BattleResultType = {
	Win = 1,			--胜利
	Lose = 2,			--失败
	Exit = 3,			--退出
	Restart = 4,		--重新开始
	Cheat = 5,			--作弊
	Offline = 6,		--离线
}

--公告界面页签
GE.NoticePage = {
	Event = 1,		--活动公告
	System = 2		--系统公告
}

--角色语种
GE.RoleLanguage = {
	Special = 0,--特殊
	CHS = 1,	--中文
	JP = 2,		--日文
}

---------------------------------------------------------------------------------------------------------------------------

---Buff叠加类型
GE.BuffOverlayType = {
	Independent = 1, -- 独立
	Replace = 2, --替换
	AddLevel = 3, --叠加
}

-----------------------------舰L 战斗---------------------------

---战斗状态
---@enum BattleStateEnum
GE.BattleState = {
	Formation = 1,		--布阵
	FormationFinish = 2,	--布阵完成
	RoundStart = 3,		--回合开始
	SwitchCamp = 4,		--切换阵营
	RoleAction = 5,		--角色行动
	RoundEnd = 6,		--回合结束
	BattleWin = 7,		--战斗胜利
	BattleLose = 8,		--战斗失败
	BattleResult = 9,	--战斗结算
	BattleInit = 10,	--战斗初始化
	BattleStart = 11,	--战斗开始
	InBacktrace = 12,	--回溯
	PlayStory = 13,		--故事模式
	LoadingFinish = 14,	--加载完成
	WaitInputOrder = 15,	--等待玩家输入指令
	AfterInputOrder = 16,	--玩家输入指令后
	AfterRoleAction = 17, 	--角色行动后
	OnBacktrace = 18,	--回溯中,重置战斗天气和角色位置提示标志
}

---@enum ClientBattleShowType
GE.ClientBattleShowType = {
	SelectRole = 1,		--选择角色
	PreMove = 2,		--预移动
	PrepareSkill = 3,	--准备技能
	RefreshRoleAction = 4,	--刷新角色行动
	SelectSKillTarget = 5,	--选择技能目标
	ResetPos = 6,		--重置位置
}

---技能类型
GE.SkillType = {
	Talent = 1,		--天赋
	Normal = 2,		--普攻
	Active = 3,		--主动
	Passive = 4,	--被动
	Preparatory = 5,	--准备类型技能，技能目标为地格
	PreparatoryRole = 6,	--准备类型，技能目标为角色
}

---技能效果类型
---@enum SkillAffixType
GE.SkillAffixType = {
	ModifyAttrib = 100,		--调整属性
	ModifyRestraintRatio = 101,  --调整舰种克制修正
    ModifyTerrainRatio = 102,  --调整地形修正
	ModifyAttribByOther = 103,  --根据另一个属性来调整当前属性
	ChangeSkillSelectRange = 110,  --改变技能选择距离
    ChangeSkillCoverRange = 111,   --改变技能覆盖距离
	ChangeSkillSelectRangeBySkillTag = 112,  --根据技能标签改变技能选择距离
	ModifyHp = 200,			--修改生命值
	BanHealth = 205,        --禁疗
	MustLeftOneHp = 211,    --必须留一滴血
	CanNotBeDamage = 212,       --无法被伤害
	TransferDamageToBuffSource = 217, --将受到的伤害传递给buff来源方
	ModifyHpToSetValue = 214, --恢复生命值到指定数值
	ModifyHpByDamageValue = 215,  --根据造成的伤害恢复生命值
	ModifyTargetHpByBeDamageValue = 216,  --根据受到的伤害对目标修改生命值
	MoveAgain = 301,		--再移动
	ActionAgain = 302,		--再行动
	MoveCostChange = 304,   --移动消耗变化
	ReduceTargetSkillCDNum = 305,  --减少所有技能CD
	ChangeTargetCurSkillCDNum = 306, --改变当前技能CD
	guardTarget = 307,      --护卫目标
	ChangeSkillAmmo = 308,  --改变技能弹药数量
	ResetActionState = 309,  --改变行动状态
	IgnoreEnemyBlock = 310,		--无视敌方占据的格子
	ImmuneEffect = 400,			--效果不生效
	ImmuneEffectTrigger = 401,	--效果触发器不生效
	ImmuneBuff = 402,			--Buff无法添加
	CanNotDoAction = 403,       --眩晕，处于无法行动状态
	ImmuneBuffEffect = 404,     --免疫BUFF生效效果
    CanNotUseActiveSkill = 405,              --不能使用主动技能
	OnlyFriendCanSelectRole = 407, --潜行状态，只有友方可以选中自己
	CreateRole = 500,			--创建角色
	DoSkill = 1000,			--执行技能
	DoSkillOnTarget = 1001,	--对目标执行技能
    repelOrZoomInTaget = 1200,      --强制使敌方位移
    repelOrZoomInTagetByDir = 1201, --强制使敌方按配置方向位移
	repelOrZoomInTargetBySourceSkillDir = 1202,  --强制使敌方按技能发起方选择释放的技能方向位移
    DispelBuff = 2001,              --驱散Buff
    StealBuff = 2002,               --窃取Buff
	DispelAndAddBuff = 2003,        --驱散并添加buff
    HaloBuff = 2006,                --光环Buff
    IgnoreGuard = 2007,                      --无视目标身上的护卫效果
	AddBuffRoundOffset = 2008,        --被添加的Buff回合数修正
	SetBuffRoundOffset = 2009,        --为其他角色添加Buff回合数修正
	KeepBuffRoundByTagOffset = 2010,       --保持特定标签Buff回合数不变
    replaceActiveSkill = 2100,      --替换主动技能
    replacePassiveSkill = 2101,     --替换被动技能
    additionalPassiveSkill = 2102,  --添加被动技能

	BlockMoveCostChange = 9999,	--经过地格的移动消耗变化
}

---改变技能覆盖范围类型
---@enum SkillRangeChangeType
GE.SkillRangeChangeType = {
	Normal = 1,  --普通攻击
	Skill = 2,  --技能
	All = 3,  --全部
}

---技能范围扩散类型
---@enum SkillRangeType
GE.SkillRangeType = {
	Normal = 1,	--常规扩散
	Cross = 2,	--十字形扩散
	Rectangular = 3,	--矩形扩散
	SelectDirction = 4,  --指定方向的矩形扩散
	AllMap = 5,  --全图范围
}

---技能攻击类型
GE.SkillAttackType = {
	Close = 1,	--近战
	Remote = 2,	--远程
	AOE = 3,	--群体
	Other = 4,	--其他
	Cure = 5,	--治疗
}

---技能伤害类型
---@enum SkillDamage
GE.SkillDamageType = {
	Bombard = 1,	--炮击
	Torpedo = 2,	--雷击
	AirBombard = 3,	--航空炮击
	AirTorpedo = 4,	--航空雷击
	Repair = 5,		--维修
}

---战斗镜头跟随类型
---@enum FollowTargetType
GE.FollowTargetType = {
	Move = 1,	--移动跟随 行动角色移动超框
	Action = 2,	--行动跟随 目标地格
	BeforeAction = 3,	--行动前跟随 行动角色地格
	Select = 4,	--选择角色跟随 目标地格
}

---@enum SkillCalculateType
GE.SkillCalculateType = {
	Normal = 1,		--普通
	AirDefense = 2,	--防空
	Repair = 3,		--维修
	NonDamage = 4,  --无伤害，仅做表现
}

---战斗目标选择类型
GE.SkillOperateType = {
	SelfBlock = 1,	--原地
	Block = 2,		--格子
	Enemy = 3,		--敌人
	Friend = 4,		--友方
	Direction = 5,	--方向
	FriendNoSelf = 6,	--友方排除自己
	NonRoleBlock = 7,	--非角色占据的格子
	SelfRange = 99, --自身一定范围内
}

---战斗效果目标类型
---@enum SkillEffectTarget
GE.SkillEffectTargetType = {
	--- 筛选技能范围内的目标
	Self = 1,	--自己
	Enemy = 2,	--敌人
	Friend = 3,	--友方
	Block = 4, --格子
	RangeAllTarget = 5, --范围内所有目标
	FrinedWithoutSelf = 6, --范围内所有友方，不包括自身
	FriendWithoutSummoned = 7, --范围内所有友方，不包括召唤物
	FriendWithoutSummonedAndSelf = 8, --范围内所有友方，不包括召唤物和自身

	--- 全局目标
	AllFriend = 100,	--我方全体
	FriendNoSelf = 101,       --友方排除自己
	AllEnemy = 102, --敌方全体
	AllRole = 103, --所有目标
	AllFriendWithoutSummoned = 104, --我方全体，不包括召唤物
	AllFriendWithoutSelfAndSummoned = 105, --我方全体，不包括召唤物和自身

	HasActionWithSelf = 201, --与自身有交互的对象
	SkillTarget = 202, --技能自身的目标
	ActiveSkillTarget = 203, --当前回合主动技能的目标
	SkillEffectTarget = 204, --技能效果的目标

	CurrentRoundDefeatRole = 301, --本回合被击败的角色
	CurActionRole = 302, --当前行动角色
}

---战斗效果目标类型
GE.FilterTargetType = {
	Self = 1,               --自己
	Enemy = 2,              --敌人
	FriendNoSelf = 3,       --友方
	CurrentSkillTarget = 4, --当前技能目标
	SkillTarget = 5, --主动技能的目标
	HasActionWithSelf = 6, --与自身有过交互目标
	Block = 11,             --格子
}

--战斗表现飞机类型
---@enum PerformancePlaneType
GE.PerformancePlaneType = {
	BombPlane = 1,	--轰炸机
	TorpedoPlane = 2,	--鱼雷机
}

---战斗表现类型
---@enum SkillPerformanceType
GE.SkillPerformanceType = {
	ShootBullet = 1,	--发射子弹
	JustHit = 2,		--直接命中
	AreaAttack = 3,		--范围技能命中
	JustEffect = 4,		--直接效果 没有战报数据
	PlaneAttack = 5,	--航空攻击
	TorpedoAttack = 6,	--鱼雷
	RailAttack = 7,		--轨道攻击
	PlaneBombing = 8,  	--地毯式轰炸
	MissileAttack = 9,	--导弹攻击
	ImpactAttack = 10,	--打击攻击
	SideAttack = 11,	--侧翼攻击
	DroneAttack = 12,	--无人机攻击
}

---战斗表现子弹计算类型
---@enum BulletNumType
GE.BulletNumType = {
	one = 1,
	bulletList = 2,
	plane = 3,		--飞机特殊处理
}

---技能表现类型与子弹数量类型的对应关系
GE.SkillPerformanceToBulletNumType = {
	[GE.BulletNumType.one] = {
		GE.SkillPerformanceType.AreaAttack,
		GE.SkillPerformanceType.PlaneBombing,
		GE.SkillPerformanceType.JustEffect,
		GE.SkillPerformanceType.RailAttack,
		GE.SkillPerformanceType.ImpactAttack,
	},
	[GE.BulletNumType.bulletList] = {
		GE.SkillPerformanceType.ShootBullet,
		GE.SkillPerformanceType.JustHit,
		GE.SkillPerformanceType.TorpedoAttack,
		GE.SkillPerformanceType.MissileAttack,
		GE.SkillPerformanceType.SideAttack,
		GE.SkillPerformanceType.DroneAttack,
	},
	[GE.BulletNumType.plane] = {
		GE.SkillPerformanceType.PlaneAttack,
	},
}

---战斗命中类型
---@enum BulletHitType
GE.BulletHitType = {
	Miss = 1,			--0伤害
	Partial = 2,		--部分伤害
	Hit = 3,			--全额伤害
}

---战斗表现类型
---@enum BulletDisType
GE.BulletDisType = {
	Miss = 1,			--未命中
	Ricochet = 2,		--跳弹
	Hit = 3,			--命中
	Partial = 4,		--擦弹
	DefReduce = 5,		--防护消耗
	Unexcite = 6,		--未激发
}

--炮击类型的命中对应表现类型
GE.CannonHitToDis = {
	[GE.BulletHitType.Miss] = {
		GE.BulletDisType.Miss,
		GE.BulletDisType.Ricochet
	},
	[GE.BulletHitType.Partial] = {
		GE.BulletDisType.Partial,
	},
	[GE.BulletHitType.Hit] = {
		GE.BulletDisType.Hit,
	},
}

--轰炸类型的命中对应表现类型
GE.BombHitToDis = {
	[GE.BulletHitType.Miss] = {
		GE.BulletDisType.Miss,
		GE.BulletDisType.Ricochet
	},
	[GE.BulletHitType.Partial] = {
		GE.BulletDisType.Partial,
	},
	[GE.BulletHitType.Hit] = {
		GE.BulletDisType.Hit,
	},
}

--鱼雷类型的命中对应表现类型
GE.TorpedoHitToDis = {
	[GE.BulletHitType.Miss] = {
		GE.BulletDisType.Miss,
		GE.BulletDisType.DefReduce
	},
	[GE.BulletHitType.Partial] = {
		GE.BulletDisType.Partial,
	},
	[GE.BulletHitType.Hit] = {
		GE.BulletDisType.Hit,
	},
}

--导弹类型的命中对应表现类型 目前同炮击
GE.MissileHitToDis = {
	[GE.BulletHitType.Miss] = {
		GE.BulletDisType.Miss,
		GE.BulletDisType.Ricochet
	},
	[GE.BulletHitType.Partial] = {
		GE.BulletDisType.Partial,
	},
	[GE.BulletHitType.Hit] = {
		GE.BulletDisType.Hit,
	},
}

--侧翼攻击的命中对应表现类型
GE.MissileHitToDis = {
	[GE.BulletHitType.Miss] = {
		GE.BulletDisType.Miss,
	},
	[GE.BulletHitType.Partial] = {
		GE.BulletDisType.Partial,
	},
	[GE.BulletHitType.Hit] = {
		GE.BulletDisType.Hit,
	},
}
---技能时机
-- GE.SkillTiming =
-- {
-- 	BattleInit = 1, --战斗初始化
-- 	OnAction = 2, --行动时
-- 	OnActionFinish = 3, --行动完成时
-- 	ActionFeedback = 5,	--行动反馈
-- 	AfterAction = 4, --行动后
-- }

---战斗时机
---@enum BattleTiming
GE.BattleTiming =
{
	BattleInit = 1, 	--战斗初始化
	BattleStart = 2,	--战斗开始
	RoundStart = 3, 	--轮次开始
	BeforeAction = 4,	--行动前
	OnAction = 5,		--行动时
	ActionFeedback = 6,	--行动反馈
	OnActionFinish = 7, --行动完成时
	AfterAction = 8, 	--行动后
	RoundEnd = 9,		--轮次结束
	AfterMove = 10,		--移动后
	AfterSkill = 11,	--释放技能后
	BeforeRoleTurn = 12,--角色回合前
	SwitchCamp = 13,	--阵营切换
	PlayAVGEnd = 14,	--AVG剧情结束
	RoleHpChange = 15, --角色血量变化
	BeforeChangeRole = 100, --当前角色行动完，切换到下一角色前
}

---行动类型
---@enum ActionType
GE.ActionType = {
	DoSkill = 1, --执行技能
	Standby = 2, --待机
}

GE.BuffType = {
	Normal = 1,  --通常
	Block = 2,   --光环或者地格施加的buff
}

---主动技能一次覆盖目标选择限制
---@enum SkillSelectType
GE.SkillSelectType = {
	None = 1,       --无限制
	OnlyFriend = 2, --仅友方可选中
	OnlyEnemy = 3,  --仅敌方技能可选中
	NoOneCanSelect = 4, --无法选中
}

---AI的状态
---@enum RoleAIState
GE.RoleAIState = {
    Nonactive = 1, --未激活状态
    Active = 2, --激活状态
    Patrol = 3, --巡逻
}

---AI自动移动的类型
---@enum RoleAIMove
GE.RoleAIMove = {
    enemy = 1, --移动到敌人附近
    friend = 2,    --移动到队友附近
}

---AI技能判断类型
---@enum AISkillType
GE.AISkillType = {
	Passive = 0, --被动
	SingleHealth = 1, --单体治疗
	MultiHealth = 2, --群体治疗
	SinglePersonHit = 3, --单体伤害
	AOE = 4, --群体伤害
}

---属性类型
---@enum AttribType
GE.AttribType = {
	Hp = 1, --血量
	Bombard = 2, --炮击
	Torpedo = 3, --雷击
	Armor = 4, --装甲
	Evade = 5, --机动
	AirDefense = 6, --防空
	Lucky = 7, --幸运
	BaseDamageRate = 8, --基本伤害倍率
	MaxHp = 9, --最大血量
	MovePower = 10, --移动力

	CurHpPercent = 50, --当前血量百分比
	CurLostHpPercent = 51, --当前损失血量百分比

	RestraintRatio = 101,  --舰种克制修正
	TerrainRatio = 102,  --地形修正
	DamageRatio = 103,  --伤害修正
	SkillAddRatio = 104,  --技能附加修正
	CritRatio = 105,  --暴击伤害修正
	AtkDisRatio = 106,  --攻击距离修正
    HitRatio = 107,    --AOE和其他攻击系数加成
	RestraintBuffRatio = 109,  --伤害减免Buff(B类)
	IntelHuntCut = 112,  --受伤减免系数
	HealthRatio = 116,  --治疗他人的修正系数
	BeHealthRatio = 117,  --受到治疗的修正系数
	CritRateRatio = 118,  --暴击率修正
	DamageRatioB = 119,  --伤害修正B类
	AntiCritRateRatio = 120,  --抗暴击率修正
	ModifyHpRatio = 121,  --真实伤害修正
}

---关卡目标类型
---@enum LevelTargetType
GE.LevelTargetType = {
	DefeatAllEnemies = 1,  --敌方全灭
	DefeatTargetEnemy = 2,  --击败特定目标
	CompleteWithinSpecifiedRound = 3,  --对比回合数
	OurSideDefeatedLessThan = 4,  --我方被击败人数
	OurSideAllDefeated = 5,  --我方全灭
	SpecialBattleEvent = 6,	--特殊战斗事件
	NoTarget = 7,  -- 无胜利和失败条件
}

---技能条件类型
GE.SkillConditionType = {
	CompareTiming = 1,	--比对时机
	IsEngagedInBattle = 2,	--是否发生战斗（当前行动）
	CompareAtkAttriType = 100,	--比对技能类型
	CompareAtkDmgType = 101,	--比对伤害类型
	CompareActionTagType = 102, --比对行动标签
	CompareAttributeType = 103, --比对舰种
	CompareMoveDistance = 104, --对比移动距离
	CompareTargetDistance = 105, --对比和目标之间的距离
	CompareSkillTargetCount = 106, --对比技能作用数量
	CompareConditionTargetInRange = 107, --对比目标范围内满足条件的数量
	CompareTargetAttributeValue = 108, --对比目标属性值和具体数值的对比
	CompareAttributeWithTarget = 109, --与目标对比某项属性值
	CompareHpPrecent = 110, --对比血量百分比
	CompareBuffTagCount = 111, --比对目标指定类型的buff数量
	CompareTargetBlockTag = 112, --比对目标地格类型
	CompareIsInEnemyAttactRange = 113, --比对是否在敌人攻击范围内
	CampareHasAction = 114, --检测是否有交互
	CampareCurSkillId = 115,  --检测当前effect是否属于当前技能
    CompareTargetAttributeWithTarget = 116, --与目标对比某项属性值
	CompareHpPrecentWithTarget = 117, --对比来源和目标的血量百分比
	CompareTargetIsAlive = 118, --检测目标是否存活
	CompareTargetRemainMovePower = 119, --检测目标的剩余移动力
	CompareSourceAndTargetIsOnStraightLine = 120, --检测来源和目标是否在同一直线上
	CompareTargetRestraintNum = 121, --对比目标的舰种克制系数
	CompareTargetBuffTag = 122, --筛选目标携带的buff标签
}

---条件比对类型
---@enum ConditionCompareType
GE.ConditionCompareType = {
	Equal = 1,			--等于
	Bigger = 2,			--大于
	BiggerOrEqual = 3,	--大于等于
	Smaller = 4,		--小于
	SmallerOrEqual = 5,	--小于等于
	NotEqual = 6,		--不等于
	Invert = 7			--取反
}

---战报类型
---@enum BattleReportType
GE.BattleReportType = {
	RoleCreate = 1,
	RoleRemove = 2,
	RoleMove = 3,
	RoleAttack = 4,
	-- RoleHit = 5,
	BlockCreate = 6,
	RoleStandby = 7,
	AllRoleActive = 8,
	ShowBattleStart = 40,  --显示战斗开始
	ShowBattleRound = 9,
	ShowCurrCamp = 10,
	ShowHitNumber = 11,
	ShowEffectTip = 12,
	RoleTurnDirection = 13,
	ShootBullet = 14,
	ShowRoleHp = 15,
	ShowTargetEffect = 16,
	RoleTimeline = 17,
	PlayAVG = 18,
	ShowDefeat = 19,
	RoleActive = 20,
	RoleChangeAttribute = 22,
	RefreshHeroBuffState = 23,
	JustHit = 24,
	AreaAttack = 25,
	ChangeAttackVcam = 26,
	JustEffect = 27,
	PlaneAttack = 28,
	TorpedoAttack = 29,
	RailAttack = 30,
	PlaneBombing = 31,
	ProtectAction = 32,
	MissileAttack = 33,
	ImpactAttack = 34,
	RoleFaceToface = 35, --角色释放技能时面对面
	LookAtBlockReport = 36, --相机移动到格子
	RemoveEventObjReport = 38, --移除事件对象(战报驱动)
	SmoothFollowTargetReport = 37, --平滑跟随目标(超出规定屏幕范围才会移动)
	SideAttack = 39, --侧翼攻击
	DroneAttack = 41, --无人机攻击
	RoleOffsetMove = 42,	--角色偏移移动(下潜类)
	RoleMaxHpChange = 43, --角色最大血量变化
	WeatherChange = 44, --天气变化
	BossScoreChange = 45, --BOSS积分变化
	ShowPrepareSkillRange = 100, --显示准备类的技能范围
	RemovePrepareSkillRange = 101, --移除准备类的技能范围
}

---战斗指令类型
---@enum BattleOrderType
GE.BattleOrderType = {
	RoleMove = 1,		--角色移动
	RoleDoSkill = 2,	--角色施放技能
	RoleStandby = 3,	--角色待机
	SelectRole = 4,		--选中角色
	SelectBlock = 5,	--选中格子
	SelectSkill = 6,	--选中技能
}

---效果触发方式类型
---@enum EffectTriggerMethodType
GE.EffectTriggerMethodType = {
	Whole = 1, --整体
	Draw = 2, --抽选
	OneByOne = 3, --逐个
}

---效果触发内容类型
---@enum EffectTriggerValueType
GE.EffectTriggerValueType = {
	Buff = 1,
	Effect = 2,
	All = 3
}

---属性期限类型
GE.AttribPeriodType =
{
	Forever = 1, --永久
	Once = 2, --单次
	Skill = 3, --技能期间
	Round = 4, --回合期间
	Action = 5, --行动期间
	ByOther = 6,  --受其他属性影响的数值
}

---角色朝向类型
---@enum RoleDirectionType
GE.RoleDirectionType =
{
	Up = 1, --上
	Right = 2, --右
	Down = 3, --下
	Left = 4, --左
	RightDown = 5, --右下
}

---战斗数据统计类型
GE.BattleStatisticType =
{
	Damage = 11, --伤害
	TakeDamage = 12, --承受伤害
	Repair = 13, --维修
}
---@enum BattleCampType
GE.BattleCampType = {
	Friend = 1,
	Enemy = 2,
	FriendNPC = 3
}

---@enum RoleActionType
GE.RoleActionType = {
	Normal = 1,		--正常
	OnlyMove = 2	--仅移动
}

---@enum MovePowerType
GE.MovePowerType = {
	Normal = 1,		--正常移动范围
	Remain = 2,		--本回合剩余移动范围
	Fixed = 3,		--读取效果配置的移动范围
}
--- 行动标签
---@enum ActionTag
GE.ActionTagType = {
	MyTurn = 1,		--我方回合
	HasBeHurt = 2,		--受到过伤害
	HasHurtOther = 3, --造成过伤害
	HasCriticalOther = 4, --造成暴击
	HasBeCritical = 5, --受到暴击
	HealOther = 6, --造成治疗
	HasBeHeal = 7, --受到治疗
	UseSkill = 8, --使用技能
	UseNormalAttack = 9, --使用普攻
	HasInBattle = 10, --发生战斗
	OnlyStand = 11, --仅待机
	HasKillEnemy = 12, --消灭敌人
	HpHasChange = 13, --血量发生变化
	BuffHasChange = 14, --Buff发生变化
	TriggerMustLeftOneHp = 15,  --触发了免死
	ActionAgain = 16, --再行动
	GuardOther = 17, --护卫了其他单位

	DamageTypeBombard = 31,	--受到炮击
	DamageTypeTorpedo = 32,	--受到雷击
	DamageTypeAirBombard = 33,	--受到航空炮击
	DamageTypeAirTorpedo = 34,	--受到航空雷击
	-- DamageTypeRepair = 35,		--受到维修
	DamageTypeAOE = 36,		--受到AOE伤害

	DamageTypeNotAirAttack = 37,	--受到非航空攻击
	DamageTypeAirAttack = 38,	--受到航空攻击
}

---战斗角色状态
GE.BattleRoleState = {
	ActionState = 1,	--行动状态
	ChooseState = 2,	--选择目标状态
	DoSkillState = 3	--施放技能状态
}

---------------------------------------------------------------------------------------------------------------------------

-----------------------------舰L 战斗事件---------------------------

---回合切换时的枚举
---@enum BattleMainPanelRoundShowType
GE.BattleMainPanelRoundShowType = {
	None = 0,	--无
	MyTurn = 1,	--我方回合
	EnemyTurn = 2,	--敌方回合
	BattleStart = 3,	--战斗开始
	EnemyReinforcements = 4,	--敌方增援
}

--事件初始化类型(对应事件表中create_baseinfo字段initcr参数)
GE.EventInitType = {
	Immediately = 1,	--副本创建时创建
	ByOtherEvent = 2,	--由其他触发器创建
}

--事件触发条件
GE.EventCondition = {
	DoConditionCheckNowCount = 1,			--回合数达到某回合后触发
	DoConditionCheckCharPosition = 2,		--角色进入(离开)指定位置(范围)触发
	DoConditionDefeatEnemy = 3,				--击败指定怪物(组)后触发
	DoConditionCheckHpPercentByID = 4,		--生命值大于(小于，等于)指定百分比时触发
	DoConditionCheckFormationCharCount = 5,	--我方上阵人数达到特定人数后触发
	DoConditionCheckDefeatChar = 6,			--我方阵亡单位达到对应人数时触发
	DoConditionCheckDataById = 7,			--根据id查找存储数据,满足条件触发
	DoConditionEveryFewRounds = 8,			--每回合(或对应节点)检测并计数,达到配置次数触发
	DoConditionCheckPlayAVGId = 9,			--检测AVG剧情是否播放完毕
	DoConditionTrueImmediately = 100,		--无条件立即触发
}

--事件触发结果
GE.EventResult = {
	DoResultCreatNPC = 1,				--生成NPC(我方角色、剧情NPC等)
	DoResultRemoveNPC = 2,				--移除NPC(我方角色，敌方怪物、剧情NPC等)
	DoResultMoveNPC = 3,				--移动NPC(我方角色，敌方怪物、剧情NPC等)
	DoResultBattleIsOver = 4,			--结束战斗(胜利/失败)
	DoResultSetEffectByRoleId = 5,		--给指定id的单位增加(或移除)effect(或effectGroup)
	DoResultSetEffectByRange = 6,		--给指定范围的单位施加单个(或多个)Effect
	DoResultSetBattleEvent = 7,			--增加(移除)战斗事件
	DoResultSaveDataById = 8,			--根据配置id计数
	DoResultRewriteInterval = 9,		--修改事件计数单位(对应EventCondition 8 的事件)
	DoResultAddAchievementID = 10,		--添加一个成就id
	DoResultRemoveAchievementID = 11,	--移除一个成就id
	DoResultRemoveLevelStar = 12,		--扣除一颗关卡星级
	DoResultCreatERole = 13,			--生成角色
	DoResultPlayAVG = 14,				--播放AVG剧情
	DoResultChangeCamp = 15,			--切换单位阵营
    ChangeLevelTargetActive = 16,       --改变关卡胜利条件
	doResultRemoveNPCByBlockCid = 17,	--通过block的col和row移除NPC(我方角色，敌方怪物、剧情NPC等)
	DoResultTimeline = 18,				--Timeline
}

--事件前端表现
GE.EventPerformance = {
	DoPerfShowSpecialFloor = 1,			--在配置范围内显示特殊格子
	DoPerfShowEffectDelay = 2,			--在配置范围内显示特效格子(延时)
}

--档案解锁条件
GE.FilesUnlockType = {
	affectionLevel = 1,	--好感度等级
}

--寄存Toast界面功能类型
GE.DepositToastType = {
	RaffleOne = 1,
	RaffleTen = 2,
	Battle = 3,
	BattleRepeat = 4,	--扫荡结算
}

--卡池类型
GE.RaffleType = {
	LimitUp = 1,	--限定UP
	Normal = 2,		--普通
	Mixed = 3,		--混合
}

---------------------------------------------------------------------------------------------------------------------------

---@enum CustomMsgType
GE.CustomMsgType = {
	Equip = 1,      --装备
    Weapon = 2,     --武器
    Item = 3,       --道具

	Character = 4,
	Skin = 5,
}


GE.ItemTimeType = {
	ArrivalTime = 1,			--到达这个时间
	ExpirationTime = 2,				--保质期
}

--道具类型
GE.ItemType = {
	"weapon", 		--武器
	"equip", 		--装备
	"debris", 		--碎片
	"materials", 	--材料
	"item",			--道具	
}

--道具类型
--TODO此枚举应该只在仓库中使用，休要抽时间修改其他位置调用逻辑
GE.ItemTypeIndex = {
	weapon = 1, 		--武器
	equip = 2, 		--装备
	debris = 3, 		--碎片
	materials = 4, 	--材料
	item = 5,			--道具	
	Character = 6,   --角色
	skin = 7,
	ticket = 98,		--体力
	res = 99,		--资源
}

--道具使用类型枚举(对应Item表中的useType字段)
GE.ItemUseType = {
	unusable = 1,				--无法使用
	gift = 2,					--礼包
	multiple = 3,				--自选礼包
	stamina = 4,				--体力药
	equipExp = 5,				--装备经验
	weaponExp = 6,				--武器经验
	randomGift = 9,				--随机礼包
	autoGift = 10,				--自动打开的礼包
}

---@enum TicketAddType
GE.TicketAddType = {
	item = 1,		--使用道具恢复
	buyTicket = 2,  --购买体力恢复
}

--道具效果类型枚举(对应Item表中的effect字段中第一个参数)
GE.ItemEffectType = {
	ticketAdd = 1,		--体力恢复
	equipExp = 2,		--装备经验
	weaponExp = 3,		--武器经验
	heroExp = 4,		--角色经验
	affection = 5,		--好感度经验
}

--词条枚举
GE.TagType = {
	shipType = 1,			--舰种词条
	debuff = 2,				--负面词条
	dwelling = 3,			--后勤词条
	common = 4,				--通用词条
	influence = 5,			--势力词条
	affection = 6,			--好感度词条
	exclusive = 7,			--专属词条
}


--词条效果类型
---@enum TagEffectType
GE.TagEffectType = {
	buildGainUp = 1,		--产出建筑产量增加
	weaponGainUp = 2,		--武器制造概率额外获得
	expendReduction = 3,	--武器制造消耗降低
	battleFlagship = 4,		--在总旗舰岗位上对战斗影响
	battleObserver = 5,		--在观察员岗位上对战斗影响
	battleReporter = 6,		--在通讯员岗位上对战斗影响
	battleCommander = 7,	--在指挥员岗位上对战斗影响
	battleSkill = 8,        --战斗技能
	dispatchBattlePointUp = 9,	--派遣战斗点增加
	dispatchHpReduce = 10,		--派遣体力消耗减少
}

--剧情图鉴筛选-章节解锁状态
---@enum StoryUnlockState
GE.StoryUnlockState = {
	All = 0,        --全部
	Unlocked = 1,   --已解锁
	Locked = 2,     --未解锁
}

--剧情图鉴筛选-收藏状态
---@enum StoryCollectState
GE.StoryCollectState = {
	All = 0,           --全部
	Collected = 1,     --收藏
	NotCollected = 2,  --未收藏
}

--剧情图鉴筛选-活动类型
---@enum StoryActivityType
GE.StoryActivityType = {
	All = 0,       --全部
	Normal = 1,    --常规
	Festival = 2,  --节日
}

--剧情标签类型（对应PlotChapterTable表中tag[1]字段）
---@enum PlotTagType
GE.PlotTagType = {
	Normal = 1,    --常规
	Festival = 2,  --节日
}

--图纸类型
---@enum BlueprintType
GE.BlueprintType = {
	infnity = 1,		--无限蓝图
	normal = 2,			--普通蓝图
	Guide = 3,			--引导用蓝图
}

--天赋树类型
GE.TalentType = {
	selectPiont = 1,			--技能选择节点
	skillPoint = 2,				--技能节点
	naturePoint = 3,			--属性节点
	changePoint = 4,			--标签变化节点
	skinPoint = 5,				--特殊立绘节点
}

--天赋树类型2.0
GE.TalentTypeNew = {
	naturePoint = 1,			--属性
	skillChosePoint = 10,		--技能选择
	getSkillPoint = 11,			--获得技能
	getTagPoint = 21,			--获得词条
	changeTagPoint = 22,		--替换词条
	delTagPoint = 23,			--删除词条
	skinPoint = 31,				--激活特殊立绘
	unlockWeaponPoint = 32,		--解锁武器栏位 并 增加负载（配置格式：{32, 负载增加量}）
	loadUpPoint = 33,			--负载值增加
}

--天赋特殊效果类型
GE.TalentSpecialEffect = {
	addSkill = 1,			--获得技能
	addTag = 2,				--获得词条
	changeTag = 3,			--替换词条
	delTag = 4,				--删除词条
	skin = 5,				--特殊立绘
	weaponVacancy = 6,		--武器栏位
	loadUp = 7,				--增加负载值
}

--装备类型
GE.EquipType = {
	equip = 1,				--装备
	sp = 2,					--专属
	rankUp = 5,				--突破材料
}

--海图 关卡选择界面toggle枚举
GE.SeaMapToggleType = {
	mainStory = 1,
	residentStory = 2,
	activityStory = 3,
}

--快速选择筛选
GE.FastDelScreen = {
	RankGreen = 1,			--选择 绿色及以下
	RankBlue = 2,			--选择 蓝色及以下
	RankPurple = 3,			--选择 紫色及以下
	RankOrange = 4,			--选择 金色及以下
	isLevelUp = 5,			--排除已强化
}

--阶段等级类型
GE.LevelDataType = {
	user = 1,				--玩家
	role = 2,				--角色
	build = 3,				--建筑
	weaponGreen = 4,		--绿色武器
	weaponBlue = 5,			--蓝色武器
	weaponPurple = 6,		--紫色武器
	weaponGolden = 7,		--金色武器
	weaponColour = 8,		--彩色武器
	achieve = 9,			--成就等级
	affection = 10,			--好感度等级
	techTree = 12,			--科技树等级
}

--武器词条属性类型(对应WeaponEntry表type字段)
GE.WeaponEntryAttrType = {
	integer = 1,		--整数
	percentage = 2,		--百分数
	specialSkill = 3,	--特殊技能
}

GE.EffectRefreshType = {
	RefreshAfterRound = 1,   --间隔一定回合刷新
	NeverRefresh = 2,        --全局限制，不刷新
}

---@enum MonsterActiveEventType
GE.MonsterActiveEventType = {
	NoCondition = 1,  --无条件激活，在战斗开启时检测
	TargetInAtkRange = 2,  --有目标进入攻击范围
	BeHurt = 3,  --自身受到攻击
	FightRound = 4,  --达到一定回合数
	RoleDie = 5,  --单位死亡
}

--装备升级类型
GE.EquipLevelType = {
	Normal = 1,  --普通
	Advanced = 2,  --进阶
}

--好友操作行为
GE.OperateFriend = {
	suggest = 0,	--请求推荐
	find = 1,		--查找
	reqAdd = 2,		--请求添加
	applyAdd = 3,	--同意添加
	del = 4,		--删除
	rejectAdd = 5,	--拒绝申请

	--扩展操作
	receiveFriendPoint = 11,--领取友情点
	giveFriendPoint = 12,	--赠送友情点
}

--好友推送
---@enum OperateFriendPush
GE.OperateFriendPush = {
	friendList = 1,		--好友列表
	requestList = 2,	--请求列表
	searchFriend = 3,	--搜索好友
	suggestFriendList = 4,	--好友推荐列表
}

--商城消耗类型
---@enum ShopGroupType
GE.ShopGroupType = 
{
	type1 = 1,	--商店1
	type2 = 2,	--商店2
}


--商城消耗类型
---@enum ShopCostType
GE.ShopCostType = 
{
	recharge = 1,	--充值资源
	resource = 2,	--游戏资源
}

--商店/商品的限购/刷新类型
---@enum ShopLimitType
GE.ShopLimitType =
{
	None = 0,	--无限购、不刷新
	Daily = 1,	--每日限购
	Weekly = 2,	--每周限购
	Monthly = 3,	--每月限购
	Round = 4,		--每轮限购
	Forever = 5,	--永久限购
}

--商品组控制类型
GE.ShopGroupControlType =
{
	None = 0,	--无控制
	All = 1,	--整店全要
	Random = 2,	--组内随机
}

--触发器类型
---@enum EventTriggerType
GE.EventTriggerType = {
	EveryBattle = 1,	--任意战斗
	CreateWeapon = 2,	--制造武器
	HeroLevelUp = 3,	--角色升级(手动)
	UseTicket = 4,		--消耗体力
	UseMoney = 5,		--消耗金币
}

--派遣状态
GE.DispatchState = {
	Dispatching = 1,	--派遣中
	Finish = 2,			--已完成
}

--派遣类型
GE.DispatchType = {
	Random = 1,		--随机派遣
	Chapter = 2,	--章节派遣
}

--家园建筑功能效果类型
GE.HomeBuildEffectType = {
	Produce = 1,		--生产
	UnlockPos = 2,	--解锁位置
	OpenWeapon1 = 5,	--开放武器合成
	OpenWeapon2 = 6,	--开放武器制造
	UnlockWeaponPaper = 7,	--解锁指定武器图纸
	GenRoleSlot = 8,	--生成角色槽位
}

--房间门状态
---@enum RoomDoorState
GE.RoomDoorState = {
	Open = 1,	--打开
	Close = 2,	--关闭
	Lock = 3,	--锁定
}

--房间门类型
---@enum RoomDoorType
GE.RoomDoorType = {
	ElevatorDoor = 99,	--电梯门
	WeaponDoor = 3,		--武器室门
	TiDuShiDoor = 7,	--提督室门
}

---点击地格操作结果类型
---@enum ClickBlockResultType
GE.ClickBlockResultType = {
	None = 0,	--无结果
	SelectSkillTarget = 1,	--选择技能目标
	SelectSKillEffectTarget = 2,	--选择技能二次覆盖目标
	SelectBlock = 3,	--选择地格
}

--档案类型
---@enum ArchiveType
GE.ArchiveType = {
	normal = 1,		--普通档案
	avg = 2,		--剧情档案
}

---@enum SignType
GE.SignType = {
	normalSign = 1, --常驻签到
	activitySign = 2, --活动签到
}

--画质类型
---@enum GraphicsQualityType
GE.GraphicsQualityType = {
	Low = 1,		--低
	Medium = 2,		--中
	High = 3,		--高
	VeryHigh = 4,	--超高
	Custom = 5,		--自定义
}

--阴影品质
---@enum ShadowResolution
GE.ShadowResolution = {
	None = 0,		--无阴影
	Low = 512,		--低
	Medium = 1024,	--中
	High = 2048,	--高
	VeryHigh = 4096,--超高
}

--显示分辨率
---@enum ResolutionType
GE.ResolutionType = {
	HD = 720,		--720P
	FHD = 1080,		--1080P
	QHD = 1440,		--1440P
	Origin = 0,		--原生分辨率
}

--渲染缩放类型
---@enum RenderScaleType
GE.RenderScaleType = {
	VeryHigh = 1,	--极高
	High = 2,	--高
	Medium = 3,	--中
	Low = 4,		--低
	VeryLow = 5,	--极低
}

--贴图质量
---@enum TextureQualityType
GE.TextureQualityType = {
	Low = 2,		--低
	Medium = 1,		--中
	High = 0,		--高
}

--帧率类型
---@enum FrameRateType
GE.FrameRateType = {
	FPS30 = 30,		--30帧
	FPS45 = 45,		--45帧
	FPS60 = 60,		--60帧
	FPS90 = 90,		--90帧
	FPS120 = 120,	--120帧
}

--抗锯齿类型
---@enum AntiAliasingType
GE.AntiAliasingType = {
	None = 1,		--无
	TimesTwo = 2,	--2倍采样
	TimesFour = 4,	--4倍采样
	TimesEight = 8,	--8倍采样
}

--水面质量类型
---@enum WaterQualityType
GE.WaterQualityType = {
	Low = 0,		--低
	Medium = 1,		--中
	High = 2,		--高
}

--卸载玩家数据状态
GE.UnloadUserState = 
{
	localMem = 1, --本地内存
	redisMem = 2, --redis内存
}

--agent加载状态
GE.AgentLoadState = 
{
	reAllotAgent = 0,	--重新分配agent
	noInit = 1,			--没有初始化Agent
	noUser = 2,			--没有初始化数据
	userNoLoad = 3,		--user数据没有加载
}

--账号状态
GE.AccountLoginState = {
	loginAuthSuc = 1, --登录认证成功
	zoneListSuc = 2, --获取区服列表成功
	loginZoneSuc = 3, --登录区服成功
	loginGateSuc = 4, --登录网关授权成功
	reconGateSuc = 5, --重连网关授权成功

	userListSuc = 11, --获取用户列表成功
	regUserSuc = 12, --注册用户成功
	loadDbUser = 13, --加载db角色
	loadCacheUser = 14, --加载缓存角色
	loadRedisUser = 15, --加载redis角色
	getUserInfoSuc = 16, --获取角色信息成功
	enterSceneSuc = 17, --进入场景成功
	userOnline = 18, --用户在线

	userOffline = 21, --用户离线(game缓存还在)
	userLogout = 22, --用户退出(game缓存释放)
	userLoginKickOffline = 23, --用户登录被踢离线(game缓存还在)
	userLoginKickLogout = 24, --用户登录被踢退出(game缓存释放)
	userGmKickOffline = 25, --用户被GM踢离线(game缓存还在)
	userGmKickLogout = 26, --用户被GM踢下线(game缓存释放)
	userServerCloseKickOffline = 27, --用户服务器关闭被踢离线(game缓存还在)
	userServerCloseKickLogout = 28, --用户服务器关闭被踢下线(game缓存释放)
	userSwitchGatewayKickOffline = 29, --用户切换网关被踢离线(game缓存还在)
	userSwitchGatewayKickLogout = 30, --用户切换网关被踢下线(game缓存释放)
	userProtocolDuplicateKickOffline = 31, --用户协议重复被踢离线(game缓存还在)
	userProtocolDuplicateKickLogout = 32, --用户协议重复被踢下线(game缓存释放)

	userCSLogout = 51, --用户centerserver缓存释放
	userRedisLogout = 52, --用户redis缓存释放

}

GE.AccountLoginStateStr = {
	[GE.AccountLoginState.loginAuthSuc] = "登录认证成功",
	[GE.AccountLoginState.zoneListSuc] = "获取区服列表成功",
	[GE.AccountLoginState.loginZoneSuc] = "登录区服成功",
	[GE.AccountLoginState.loginGateSuc] = "登录网关授权成功",
	[GE.AccountLoginState.reconGateSuc] = "重连网关授权成功",

	[GE.AccountLoginState.userListSuc] = "获取用户列表成功",
	[GE.AccountLoginState.regUserSuc] = "注册用户成功",
	[GE.AccountLoginState.loadDbUser] = "加载db角色",
	[GE.AccountLoginState.loadCacheUser] = "加载缓存角色",
	[GE.AccountLoginState.loadRedisUser] = "加载redis角色",
	[GE.AccountLoginState.getUserInfoSuc] = "获取角色信息成功",
	[GE.AccountLoginState.enterSceneSuc] = "进入场景成功",
	[GE.AccountLoginState.userOnline] = "用户在线",

	[GE.AccountLoginState.userOffline] = "用户离线(game缓存还在)",
	[GE.AccountLoginState.userLogout] = "用户退出(game缓存释放)",
	[GE.AccountLoginState.userLoginKickOffline] = "用户登录被踢离线(game缓存还在)",
	[GE.AccountLoginState.userLoginKickLogout] = "用户登录被踢退出(game缓存释放)",
	[GE.AccountLoginState.userGmKickOffline] = "用户被GM踢离线(game缓存还在)",
	[GE.AccountLoginState.userGmKickLogout] = "用户被GM踢下线(game缓存释放)",
	[GE.AccountLoginState.userServerCloseKickOffline] = "用户服务器关闭被踢离线(game缓存还在)",
	[GE.AccountLoginState.userServerCloseKickLogout] = "用户服务器关闭被踢下线(game缓存释放)",
	[GE.AccountLoginState.userSwitchGatewayKickOffline] = "用户切换网关被踢离线(game缓存还在)",
	[GE.AccountLoginState.userSwitchGatewayKickLogout] = "用户切换网关被踢下线(game缓存释放)",
	[GE.AccountLoginState.userProtocolDuplicateKickOffline] = "用户协议重复被踢离线(game缓存还在)",
	[GE.AccountLoginState.userProtocolDuplicateKickLogout] = "用户协议重复被踢下线(game缓存释放)",

	[GE.AccountLoginState.userCSLogout] = "用户centerserver缓存释放",
	[GE.AccountLoginState.userRedisLogout] = "用户redis缓存释放",
}


HomelandAction = {

	None = 0,
	Move = 1,
	
}


--家园功能建筑显示类型
---@enum WorkingRoomType
WorkingRoomType = {
	Error = -1,
	None = 0,
	CommandRoom = 1,  --指挥室
	WeaponRoom = 2,   --武器室	
	ProduceRoom = 3,  --生产室
}

--家园功能建筑显示类型
---@enum HomeActionType
HomeActionType = {
	None = 0,
	Patorl = 1,  --巡逻
	Working = 2,   --工作中
	GotoWork = 3,	--上班
	GetoffWork = 4, --下班

	Type_5 = 5,		-- 吃饭
	Type_6 = 6,		-- 游泳
	Type_7 = 7,		-- 钓鱼
}

---物品数量显示类型
---@enum ItemNumShowType
GE.ItemNumShowType = {
	Normal = 1,		--正常显示
	OverflowWithK = 2,	--溢出10w显示为k
}


---活动所属功能类型
---@enum ActivityFunctionType
GE.ActivityFunctionType = {
	MainPanel = 1,	--主界面
	Activity = 2,		--活动
	ActivityPanel = 3,		--活动面板
}

---@enum PrivilegeType 特权类型
PrivilegeType = {
	LevelMapCleanAddCount_1 = 1,	---普通扫荡次数
	LevelMapCleanAddCount_3 = 2,	---主线扫荡次数
	LevelMapCleanAddCount_5 = 3,	---材料扫荡次数
	ApBuyAddCount = 4,		---体力购买次数
	MaterialExtraAddCount_1 = 101,		---材料类型1 双倍次数
	MaterialExtraAddCount_2 = 102,		---材料类型2 双倍次数
	MaterialExtraAddCount_3	= 103,		---材料类型3 双倍次数
	MaterialExtraAddCount_4 = 104,		---材料类型4 双倍次数
}

GE.WeeklyBossEffectType = {
	FriendCampSkill = 1,	--我方阵营技能
	EnemyCampSkill = 2,		--敌方阵营技能
	AllCampSkill = 3,		--全阵营技能
	ShipAttribute = 4,		--舰船舰种限制
}

---@enum PushData 需要主动请求的数据
GE.PushData = {
	mailCollect = "mailCollect",  --邮件收藏
	handbookData = "handbookData",    --图鉴数据
	gachaData = "gachaData",  --卡池相关数据
	-- dispatchData = "dispatchData", --派遣数据
	genRoleFragData = "genRoleFragData", --跑片数据 TODO
	chapterAwardMap = "chapterAwardMap", --章节奖励领取记录
	regularActivityData = "regularActivityData", --周期活动数据
	extraRewardsMap = "extraRewardsMap", --资源关卡额外奖励信息
	formationMap = "formationMap", --编队列表
	headList = "headList", --头像列表

	-- mailInfo = "mailInfo", --邮件列表 走原有协议
	friendInfo = "friendInfo", --好友数据
	passDataMap = "passDataMap", --通行证数据
	generalShopData = "generalShopData", --普通商店数据
	premiumShopMap = "premiumShopMap", --充值商城数据
	cycleCardDatas = "cycleCardDatas", --周期卡数据
	affectionData = "affectionData", --好感度数据
	weatherForecastData = "weatherForecastData", --天气预报数据
	missionList = "missionList", --任务信息
	equipMap = "equipMap", --装备列表
	weaponMap = "weaponMap", --武器列表
	skinList = "skinList", --皮肤列表
	technologyTree = "technologyTree",     --科技树数据
}

--没有主动请求前，推送的数据废弃
GE.ToObsoletePushData = {
	mailCollect = "mailCollect",  --邮件收藏
	handbookData = "handbookData",    --图鉴数据
	gachaData = "gachaData",  --卡池相关数据
	-- dispatchData = "dispatchData", --派遣数据
	genRoleFragData = "genRoleFragData", --跑片数据
	chapterAwardMap = "chapterAwardMap", --章节奖励领取记录
	regularActivityData = "regularActivityData", --周期活动数据
	extraRewardsMap = "extraRewardsMap", --资源关卡额外奖励信息
	formationMap = "formationMap", --编队列表
	headList = "headList", --头像列表
}

--popUI时主动请求的界面与所需数据对照
GE.PopUIPushData = {
	PosterPanel = {GE.PushData.skinList},
	MailPanel = {GE.PushData.mailCollect},
	TaskPanel = {GE.PushData.missionList},
	FriendPanel = {GE.PushData.friendInfo},
	HeadChosePanel = {GE.PushData.headList},
	HandBooksPanel = {GE.PushData.handbookData},
	LevelMapMsgPanel = {GE.PushData.handbookData},
	-- DispatchMainPanel = {GE.PushData.dispatchData},
	RaffleMainPanel = {GE.PushData.gachaData},
	HomelandShopPanel = {
		GE.PushData.generalShopData,
		GE.PushData.equipMap,
		GE.PushData.weaponMap,
	},
	FormationListPanel = {GE.PushData.formationMap},
	TechnologyTreePagePanel = {GE.PushData.technologyTree},
	DockRolePanel = {
		GE.PushData.equipMap,
		GE.PushData.weaponMap,
		GE.PushData.skinList,
		GE.PushData.technologyTree,
	},
	WarePanel = {
		GE.PushData.equipMap,
		GE.PushData.weaponMap,
	},
	SeaMapPanel = {
		GE.PushData.chapterAwardMap,
		GE.PushData.regularActivityData,
		GE.PushData.extraRewardsMap,
		GE.PushData.technologyTree,
	},
	GameShopPanel = {
		GE.PushData.generalShopData,
		GE.PushData.premiumShopMap,
		GE.PushData.cycleCardDatas,
	},
	GenRoleFragPanel = {
		GE.PushData.genRoleFragData,
	},
}

---@enum ConstructionLevelEffectType  建筑效果类型
GE.ConstructionLevelEffectType = {

	Product = 1,	----产出
	UnlockBuildPos = 2,	---解锁位置
	UnlockPos_Walk = 3,	---解锁散步位置
	UnlockPos_Patrol = 4,	---解锁巡逻位置
	OpenWeaponCompound = 5,		----解锁武器合成
	UnlockWeaponManufacturing = 6,		---解锁武器制造
	UnlockWeaponDrawing = 7,		---物体图纸
	UnlockSyncTrainingPos = 8,				----同步训练栏位
}

--日志快照类型
GE.LogSnapshotType = {
	hero = 1,		--英雄
	equip = 2,		--装备
	weapon = 3,		--武器
	max = 4,		--最大值
}

--分享类型
GE.ShareType = {
	common = 1,		--普通分享
	max = 2,		--最大值
}



--region 自走棋相关枚举-------------------------
---@enum AutoChessMoveType
GE.AutoChessMoveType = {
	None = 0,		---无
	Grid = 1,		---格子移动
	Point = 2,		---移动到指定位置
	Bezier = 3,		---抛物线
	target = 4,		---追踪目标
	Line = 5,		---直线移动
}


---@enum EntityType 角色类型
GE.EntityType = {
	None = 0,
	Player = 1,
	Summon = 2,
	Bullet = 3,
}

---@enum AutoChessFlag
GE.AutoChessFlag = {
    --几种状态的旗标
    eStatus_None = 0,
    eStatus_Fixed = 1, --不能移动
    eStatus_Silence = 2, --禁魔不能施法不能打断施法
    eStatus_Hide = 4, --隐身
    eStatus_NoAttack = 8, --不能攻击
    eStatus_Invincibility = 16, --无敌状态
	eStatus_KeepFacing = 32, --不能转向
}


---@enum AutoChessAttributeType
GE.AutoChessAttributeType = {
	None                   	   	= 0,
	HP                         	= 1,	-- 当前血量
	MP                         	= 2,	-- 当前蓝量
	Level                      	= 3,	-- 等级
	Exp                        	= 4,	-- 经验
	MaxHP                      	= 5, 	-- 最大血量
	MaxMP                      	= 6, 	-- 最大蓝量
	HPRecover                  	= 7, 	-- 血量回复
	MPRecover                  	= 8, 	-- 蓝量回复
	AttackSpeed                	= 9, 	-- 攻击速度
	AttackRange                	= 10,	-- 攻击距离
	MoveSpeed                  	= 11,	-- 移动速度
	torpedo                		= 14,	-- 法术攻击力  雷击
	bombard           			= 15,	-- 物理攻击力  炮击
	armor                 		= 16,	-- 物理防御	  装甲
	evade						= 17,   ---机动
	airdefense					= 18,	---防空
	lucky 						= 19,	---幸运影响暴击率
}

---@enum AutoChessDamageType 子弹命中类型
GE.AutoChessDamageType = {
	None = 0,
	Ap = 1,   ---物理伤害
    Ad = 2,   ---魔法伤害
    Type3 = 3,---真实伤害
	Type4 = 4,---回血伤害
}

---@enum AutoChessSearchType 检索类型
GE.AutoChessSearchType = {

	None = 0,
	Friend = 1,		---是否同正营  不包括自己
	Enemy = 2,		---是否同敌营
	Player = 4,		---是否角色
	Monster = 8,	---是否是怪物
	Bullet = 16,	---是否是子弹
	Me = 32,		---是否包含施法者
	Invinsible = 64,---是否包含无敌单位
}

---@enum AutoChessBulletHitType 子弹命中类型
GE.AutoChessBulletHitType = {
	None = 0,
	DestroyOnHit = 1,   ---单体命中后销毁 (单次判定)
    Pierce = 2,         ---穿透 (可贯穿多个目标)
	TargetGrid = 3,		---命中到目标格子
}


---@enum AutoChessSelectShape 技能选区（范围）形状枚举
GE.AutoChessSelectShape = {
    None = 0,       -- 无选区（单体锁定技能）
    Circle = 1,     -- 圆形 -- 【所需参数】: radius (半径)
    Rect = 2,       -- 矩形 -- 【所需参数】: length  width 
    Ring = 3,       -- 环形 -- 【所需参数】: outerRadius (大半径), innerRadius (小半径)
    Sector = 4,     -- 扇形 -- 【所需参数】: radius (半径), angle (角度)            
    Point = 6,      -- 点/距离 (保留你原表里的设定，通常用于固定坐标点爆炸)
}

---@enum AutoChessFilterSortType 检索优先级类型
GE.AutoChessFilterSortType = {
	None = 0,
	Profession = 1,		----职业
	Hp = 2,				---血量
}

-- 
---@enum AutoChessCompareType 比较操作符
GE.AutoChessCompareType = {
	None = 0,
    Equal = 1,         -- 等于 (==)
    NotEqual = 2,      -- 不等于 (~=)
    Greater = 3,       -- 大于 (>)
    GreaterEqual = 4,  -- 大于等于 (>=)
    Less = 5,          -- 小于 (<)
    LessEqual = 6,     -- 小于等于 (<=)
}


---@enum AutoChessConditionType 条件判断类型
GE.AutoChessConditionType = {

	Distance = 1,      				-- 判断和目标距离
    HpRatio = 2,       				-- 判断血量百分比
	MpRatio = 3,       				-- 判断蓝量百分比
	Attribute = 4,					-- 判断属性
    HasBuff = 5,       				-- 判断目标是否拥有buff
	EventType = 6,					---判断事件类型
    DamageType = 8,					---判断伤害类型  
    SkillType = 9,					---判断技能类型
    TargetClass = 10,        		---检测目标职业
	TargetType = 11,				---判断目标类型 1攻击方 2目标方, 3buff来源方, 4攻击方主人
	SkillScope = 12,				---判断是否在技能范围内
	TargetMask = 13,				---判断目标Mask
	Count = 14,						---判断目标数量
}

--- 战斗事件枚举 (用于 Buff/Modifier 系统的时间分发)
---@enum AutoChessCombatEvent
GE.AutoChessCombatEvent = {
    OnBeforeDamage  = 1,  		-- 伤害前 (用于：减伤、护盾、伤害转换)           		4
    OnAfterDamage   = 2,  		-- 伤害后 (用于：受击反伤、受击加速、挨打回蓝)		 8
    OnFatalDamage  	= 3,  	-- 承受致命伤害时 (用于：名刀锁血、蛮王大招、不屈)		5
    OnDeath         = 4, -- 死亡时 (用于：复活甲、死后自爆、变成僵尸)   		6
    OnSkillCast     = 5, -- 释放技能时 (用于：释放技能后下一次普攻强化/耀光, 触发法术吸血)   															

	--Buff
	OnStackChanged 	= 6,	---层数改变  
	OnTick = 7,							---用于检测光环 0.5秒执行一次
}

---@enum AutoChessConditionTargetType 条件判断类型
GE.AutoChessConditionTargetType = {
	None = 0,
	Self = 1,
	Actor = 2,  			---发起者
	Receiver = 3, 			---作用方
	Source = 4,				---发起者主人来源 如果没有主人, 就是Actor发起者
	BuffSource = 5,			----buff来源对象
	AllEntity = 6,			----所有目标
}

-----------------------幸存者相关枚举-----------------------

---幸存者游戏状态
---@enum SurvivalStateEnum
GE.SurvivalStateEnum = {
	Pause = 1,		--暂停
	Battle = 2,		--战斗中
	Prepare = 3,	--准备中
	GameOver = 4	--游戏结束
}

---幸存者广播事件类型
---@enum SurvivalEventType
GE.SurvivalEventType = {
	RoleCreate = 1,	--角色生成
	KillEnemyAll = 2,	--击杀所有敌人
	PlayerHpChange = 3,	--玩家血量变化
	GameOver = 4,	--游戏结束
	PlayerExpChange = 5,	--玩家经验变化
}

---幸存者技能效果类型（SurvivorSkillTable.effectType）
---@enum SurvivalSkillType
GE.SurvivalSkillType = {
	CreateBullet = 1,	--生成子弹
	AreaEffect = 2,		--区域效果（冲击波/导弹AoE等）
	AttributeBonus = 3,	--增幅基础属性，effectParameter[1] 为属性加成列表
}

---技能方向/瞄准（effectParameter[3] 第2项）
---@enum SurvivalAimType
GE.SurvivalAimType = {
	NearbyFollow = 1,		--记录目标，角度实时跟随目标
	NearbyDirection = 2,	--朝向目标（角度不再变化）
	NearbyAimForward = 3,	--根据目标速度与朝向预判落点（创建时快照）
}

---技能起点（effectParameter[3] 第1项；子弹固定 Self）
---@enum SurvivalSkillOrigin
GE.SurvivalSkillOrigin = {
	Self = 1,		--自身（圆形可跟随角色）
	FixedPoint = 2,	--释放时固定坐标
	AimTarget = 3,	--目标点（由 SurvivalAimType 决定当前/预判位置）
}

---区域效果伤害结算类型（配置字段 settle）
---@enum SurvivalAreaSettle
GE.SurvivalAreaSettle = {
	ExpandSweep = 1,	--扩散扫过，波前进入范围时命中
	ExpandOnce = 2,	--扩散到最大半径时结算一次
	FixedTick = 3,	--定时检测，按 interval 周期判定
}

---区域效果形状（配置字段 shape）
---@enum SurvivalAreaShape
GE.SurvivalAreaShape = {
	Circle = 1,	--圆形（默认）
	Beam = 2,	--激光束（原点+方向+长宽）
}

---幸存者道具效果类型（SurvivorItemTable.effectType）
---@enum SurvivalItemEffectType
GE.SurvivalItemEffectType = {
	Exp = 1,	--经验，effectParameter[1] 为经验值
	Heal = 2,	--治疗当前主控，effectParameter[1] 为最大生命值百分比
}

---幸存者技能触发类型
---@enum SurvivalSkillTriggerType
GE.SurvivalSkillTriggerType = {
	OnAdd = 0,	--添加技能时立即生效
	CdEnd = 1,	--CD结束自动触发
	BeHit = 2,	--受到伤害时触发
	OnHit = 3,	--击中敌人时触发
	OnHitByBullet = 4,	--子弹击中敌人时触发
	OnHitByAreaEffect = 5,	--区域效果击中敌人时触发
}

---幸存者技能释放类型（SurvivorSkillTable.skillType）
---@enum SurvivalSkillReleaseType
GE.SurvivalSkillReleaseType = {
	Passive = 0,	--纯被动，不参与手动/自动释放
	Manual = 1,	--手动释放
	Auto = 2,	--自动释放
}

---技能瞄准规则
---@enum SurvivalAimRule
GE.SurvivalAimRule = {
	Priority = 1,		--优先攻击目标
	Only = 2,	--只攻击目标
	Forbid = 3	--不攻击目标
}

---幸存者生成点类型
---@enum SurvivalSpawnType
GE.SurvivalSpawnType = {
	FarRandom = 1,	--远随机点
}

---幸存者阵营
---@enum SurvivalTeam
GE.SurvivalTeam = {
	friend = 1,	--友方
	enemy = 2,	--敌方
}

---幸存者属性类型
---@enum SurvivalAttribType
GE.SurvivalAttribType = {
	Hp = 1,	--血量
	BulletAttack = 2,	--子弹攻击力
	TorpedoAttack = 3,	--鱼雷攻击力
	CollisionAttack = 4,	--碰撞攻击力
	Armor = 5,	--装甲
	Evade = 6,				--机动
	AirDefense = 7,			--防空
	Lucky = 8,				--幸运
	ExtraBulletNum = 9,		--子弹数量
	BulletSpeed = 10,		--子弹速度
	BulletAngle = 11,		--子弹散射角度
	MoveSpeed = 12,			--移动速度
	Range = 13,				--角色碰撞范围 直径
	BulletRange = 14,		--子弹碰撞范围 直径
	BulletPenetration = 15,	--子弹穿透次数
	BulletSustain = 16,		--子弹持续时间
	BeamLength = 17,	--激光束长度
	BeamWidth = 18,	--激光束宽度（直径）
}

---幸存者子弹伤害类型
---@enum SurvivalBulletDamageType
GE.SurvivalBulletDamageType = {
	Bullet = 1,	--炮击
	Torpedo = 2,	--鱼雷
}

GE.ServerTimeOperate = 
{
	get = 1, --获取当前时间
	alter = 2, --修改时间
	regain = 3, --还原系统时间
}

GE.NodeReadyType = {
	clusterConnect = 1,		--集群连接
	nodeReadyFinish = 2,	--节点准备完成
	allFinish = 3,	--全部完成
}
