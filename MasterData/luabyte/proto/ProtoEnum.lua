--auto generate ,dont modify !!!
friendpb = friendpb or {}

friendpb.ErrorCode ={
	Success=0,
	Internal=1,----服务器内部错误
	ServerBusy=2,----服务器繁忙
	SystemError=3,----系统错误
	InvalidData=4,----客户端发送数据不合法
	FuncNotOpen=23,----功能未开放
	
	FriendAlreadyRequest=720,----已经添加申请
	FriendAlreadyExists=721,----已经是好友
	FriendInBlack=722,----申请好友对象在黑名单中
	FriendIsFull=723,----自己好友列表已经满了
	TargetFriendFull=724,----申请好友对象的好友列表已经满了
	InTargetBlack=725,----自己在目标对象的黑名单中
	TargetIsOffline=726,----目标对象不在线
	FriendRequestNotExists=727,----好友请求不存在
	WaitForSocial=728,----等待社交服务器响应
	IsNotFriend=729,----非朋友关系
	AddSelfFriend=730,----加自己为好友
	FriendIsOffline=731,----好友不在线
	FriendAlreadyGivePoints=732,----已经赠送友情点
	FriendAlreadyDrawnPoints=733,----已经领取友情点
	FriendNotGivePoints=734,----好友没有赠送友情点
	FriendInvalidSlot=735,----无效的槽位
	FriendHeroNotAtHelpSlot=736,----此英雄不在好友的助战槽位上
	FriendHelpTimesNotEnough=737,----助战次数不够
	FriendRemarkTooLong=738,----好友备注太长
	FriendInvalidUID=739,----非法的UID
	FriendFindNoResult=740,----没有查找到uid对应的角色
	FriendAlreadyDrawnHelpBonus=741,----已经领取助战奖励
	FriendAddRequestFull=742,----同时申请的好友已达上限
	FriendRequestAlreadySend=743,----好友已经发送好友申请
	HeroNotExists=744,----英雄不存在
	FriendInvalidHeroCount=745,----错误的英雄数量
	AccountNotExists=746,----账号不存在
	TargetFriendAddRequestFull=747,----目标对象的好友申请列表已满
	FriendRemarkSensitive=748,----好友备注存在敏感词
}

friendpb.InfoType ={
	Level=0,----等级
	SkillLevel=1,----技能等级
	CoreLevel=2,----核心等级
	AIWeapon=3,----AI武器
	Favor=4,----好感度
	AwakeLevel=5,----觉醒等级
	Grade=6,----突破等级
	GenesStar=7,----基因链等级
	Skin=8,----皮肤
}

protocol = protocol or {}

protocol.MailState ={
	MS_NEW=0,
	MS_OPEN=1,
	MS_EXTRACT=2,
	MS_DELETE=3,
}

protocol.EnterType ={
	Normal=0,----0普通进入
	ReConn=1,----1断线重连
}

protocol.MailOpt ={
	MO_OPEN=0,
	MO_EXTRACT=1,
	MO_DELETE=2,
}

protocol.ECurrencyType ={
	ECT_None=0,
	Coin=1,----星币(游戏币)
	Exp=2,----战斗程序（账户经验值）
	HeroExp=3,----作战影像（英雄经验值）
	HeroBreak=4,----催化装置（英雄突破值）
	Gold=5,----星钻(钻石)
	Source=6,----阿尔法石(人民币)
	FCoin=7,----家具代币
	Heart=23,----心结代币
	Ticket=24,----礼物票据
	DailyAP=25,----日常活跃点
	WeeklyAP=26,----周长活跃点
	SkillPoint=27,----技能点
	CommanderScope=28,----长官积分
}

protocol.StudioType ={
	Undefined=0,----0空舱室，未定义
	Bridge=1,----1舰桥
	Produce=2,----2制造舱
	Train=3,----3训练舱
	Communication=4,----4通讯室
	Dormitory=5,----5宿舍
	Canteen=6,----6厨房
}

protocol.PlatformId ={
	DEVELOPER=0,----内部测试
	XiaoNiu=3,----小牛官方
	XiaoNiuIOS=5,----小牛官方IOS
	HYKB=13,----好游快爆渠道
	TapTap=86,----Taptap渠道
	Bilibili=87,----B站
}

protocol.BattleRes ={
	FAIL=0,
	WIN=1,
	DRAW=255,
}

protocol.Options ={
	DB_UPDATE=0,
	DB_ADD=1,
	DB_DELETE=2,
}

protocol.CollectOpt ={
	ColOPEN=0,----打开查看
	ColEXTRACT=1,----0新增，1领取（清空）
}

protocol.EGameModel ={
	ERoleInfo=0,----玩家信息
	ERoleMission=1,----关卡
	ERoleItem=2,----道具
	ERoleHero=3,----英雄
	ERoleTeam=4,----编队
	ERoleCycleEvent=5,----周期事件
	ERoleTask=6,----任务
	ERoleActivity=7,----活动
	ERoleChapter=8,----章节
	ERoleCollect=9,----挂机
	ERoleLottoRec=10,----抽卡
	ERoleStudio=11,----后宅
	ERoleExtraBuff=12,----额外buff(额外词条)
	ERoleHeroStory=13,----英雄剧情(通信仓剧情)
	ERoleGameMail=14,----邮件
	ERoleCdk=15,----兑换码
	ERoleExpMission=16,----远征
}

protocol.EACTType ={
	EACT_Common=0,
	EACT_Daily=1,
	EACT_Weekly=2,
}

protocol.ECycleEvent ={
	None=0,
	ECET_Min=1000,
	ECET_OnlineTime=1001,----在线时间(累计在线时间,上次登录时间,最后下线时间)
	ECET_Guide_Award=1002,----新手引导奖励(Value=GetDateHourVal,Field0=领奖标志位)
	ECET_Award_Online=1003,----在线时长奖励(Value=GetDateHourVal,Field0=活动id，Field1=领奖索引,Field2=累计时间例如：1当天第一次)
	ECET_Award_Sign=1004,----签到奖励(Value=年月,Field0=签到次数，Field1=补签次数Field2=上次签到ID)
	ECET_Award_Sign7=1005,----7连签到奖励(Value=GetDateVal，Field0=次数,Field1=活动id,Field2=GetDateVal上次领奖日期)
	ECET_Award_SignAll=1006,----无限签到(Value=GetDateVal起始签到日期,Field0=签到累计,Field1=上次领奖ID,Field2=最后签到日期)
	ECET_Account_Rec=1007,----账户记录(Value=全服邮件ID,Field0=作弊嫌疑,)
	ECET_Shop_Refresh=1008,----商店刷新(value=ShopId,Field0=剩余免费刷新次数Field1=下一次免费刷新时间Field2=剩余道具刷新次数)
	ECET_Daily_Elite=1009,----日常精英副本次数(Value=GetDateHourVal,Field0=精英副本通关次数Field1=精英副本通关上限）
	ECET_Daily_Task=1010,----日常任务(Value=GetDateHourVal,Field0=活跃度,Field1=领奖掩码)
	ECET_Weekly_Task=1011,----周常任务(Value=GetDateHourVal,Field0=活跃度,Field1=领奖掩码)
	ECET_Avatar_Petting=1012,----Avatar抚摸，日常刷新(Value=GetDateHourVal,Field0=抚摸次数,Field1=投喂次数),
	ECET_Activity_Record=1013,----活跃度纪录(Value=GetDateHourVal,Field0=活跃度,Field1=领奖纪录)
	ECET_Novice_Guide=1014,----新手引导(Value=GetDateVal起始日期,Field0=主线,Field1=分支,Field2=完成跳过0不跳过，1跳过所有引导)
	ECET_Lotto_Free=1015,----每日免费抽卡记录（Value=GetDateHourVal,Field0=抽卡次数,Field1=抽卡次数,Field2=抽卡次数）
	ECET_Recharge_Record=1016,----充值奖励(Value=GetDateVal请求充值次数,Field0=首充奖励标志位,Field1=成功充值次数,Field2=累计充值金额)
	ECET_Recharge_ActivityRecord=1017,----首冲充值奖励(Value=GetDateVal,Field0=首充完成标志位,Field1=领奖标志位,Field2=)
	ECET_Seven_Day_Target=1018,----三日目标(value=GetDateHourVal，Field0=活动id,Field1=积分,Field2=领奖标志位0-15位积分奖励16-31位购买标记)
	ECET_Free_Express=1019,----免费快递(value=GetDateHourVal，Field0=使用册数,Field1=最大次数)
	ECET_Cost_Item_Express=1020,----消耗道具快递(value=GetDateHourVal，Field0=使用册数,Field1=最大次数)
	ECET_Daily_Gift=1021,----日常礼物(value=GetDateHourVal，Field0=领取位)
	ECET_Everyday_Feedback_Gift=1022,----回礼每日触发次数限制，每天只有前几次才领取(value=今天领取的次数，m_nField0=nNextRefreshTime,下一次刷新的时间)
	ECET_AtmosphereCount=1023,----总氛围值m_nValue：值
	
	ECET_Online_Act_Config=1024,----在线活动配置(value=activityId，Field0=开始时间Field1=结束时间)30
	ECET_Limit_Time_Copy_Act_Config=1025,----限时活动配置(value=activityId，Field0=开始时间Field1=结束时间)
	ECET_Seven_Day_Target_Act_Config=1026,----三日目标任务配置(value=activityId，Field0=开始时间Field1=结束时间)
	ECET_Seven_Day_Login_Act_Config=1027,----七天登录配置(value=activityId，Field0=开始时间Field1=结束时间)
	ECET_Voting_Act_Config=1028,----票选活动配置(value=activityId，Field0=开始时间Field1=结束时间)
	ECET_Airship_Upgrade_Act_Config=1029,----飞船升级配置(value=activityId，Field0=开始时间Field1=结束时间)
	ECET_Exchange_Act_Config=1030,----兑换活动配置(value=activityId，Field0=开始时间Field1=结束时间)
	ECET_Seven_Day_Login=1031,----七天登录活动(value=时间戳,Field0=签到天数Field1=activityId)
	
	ECET_Hero_Special_Daily=1032,----每日特殊事件触发次数(value=时间戳,Field0=今日剩余可触发特殊事件的次数)
	ECET_Fast_Collect=1033,----每日特殊事件触发次数(value=时间戳,Field0=今天免费挂机次数，Field1=今天星钻挂机次数Field2=今天快速挂机次数)
	ECET_Hero_Lotty_Daily=1034,----每日特殊事件触发次数(value=时间戳,Field0=今天抽奖次数，Field1=抽卡次数上限)
	ECET_Item_Lotty_Daily=1035,----每日特殊事件触发次数(value=时间戳,Field0=今天抽奖次数，Field1=抽卡次数上限)
	
	ECET_ROLE_MASK=1037,----玩家位掩码标记
}

protocol.GmCmdType ={
	CMD_None=0,
	CMD_Add_ITEM=1,----添加道具格式([{"itemId":1,"cnt":1}...])
	CMD_Recharge=2,----充值"chargeId"
	CMD_Add_HERO_FAVOR=3,----增加英雄饱食度格式({"hero":1001,"favor":10})
	CMD_UnLockHeroAllStory=4,----一键解锁英雄对话剧情格式:解锁的id(空字符串表示全部解锁)
	CMD_Recharge_MonthCard=5,----充月卡不需要参数
	CMD_Recharge_Shop_Buy=6,----商城礼包{"shopId":1,"shopItemId":1,"cnt":1}
	CMD_Recharge_Pass=7,----充值通行证
	CMD_Hero_Attribute=8,----({"heroId":1001,"type":1,"value":1})type=1觉醒等级
	
	CMD_SetHeroBreakAndLevel=100,----设置英雄的等级和break等级
	CMD_SetHeroEater=101,----设置英雄饱食度
	CMD_StudioRoomFull=102,----创建舱室并升满级
	
	CMD_RechargeYK=103,----模拟游卡充值成功,参数为订单id(string)
	
	CMD_OpenStudioDorm=104,----立即开启宿舍功能
	
	CMD_RandomPRD=10002,----prd随机算法测试
	CMD_ActiveFirstRecharge=10003,----激活首冲
	CMD_ResetLottoCount=10004,----重置每次抽奖次数限制，并添加道具
}

protocol.ItemType ={
	E_Normal_Item=0,
	E_Hero=1,
	E_FurnitureConvert=2,
}

protocol.NoticeType ={
	PrivateNotice=0,----私人通知
	PublicNotice=1,----全服公告
	CycleNotice=2,----周期公告(pic)
}

protocol.GameNoticeType ={
	Refresh=0,----0-刷新公告
	StopAll=1,----1-停止所有公告
}

protocol.TurntableCard ={
	FixedPoints=0,----指定卡
	SlowDown=1,----减速卡
	GetAll=2,----全拿卡
}

