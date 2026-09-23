local this = {}

this.TriggerType={
	None=0,--不触发
	Push=1,--是投掷出来的点数时触发
	Press=2,--路过触发
}

--格子类型
this.GridType={
	Start=1,--起点
	RandReward=2,--获得随机奖励
	RandEvent=3,--随机事件
	Move=4,--移动
	TP=5,--传送
}

this.EventType={
	ExStep=1, --多走N步
	FixedStep=2,--行走固定步数
	MagnStep=3,--行走N倍步数
}

_G.RichManAction={
	Idle=1, --待机
	FullRound=2, --完成一圈
	RandEvent=3, --随机事件
	TP=4, --传送事件
	Award=5, --奖励显示
	Move=6, --移动事件
	RandTween=7,--骰子动画
}

return this;