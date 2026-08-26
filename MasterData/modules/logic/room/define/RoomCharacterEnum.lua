-- chunkname: @modules/logic/room/define/RoomCharacterEnum.lua

module("modules.logic.room.define.RoomCharacterEnum", package.seeall)

local RoomCharacterEnum = _M

RoomCharacterEnum.CharacterState = {
	Revert = 3,
	Temp = 2,
	Map = 1
}
RoomCharacterEnum.CharacterMoveState = {
	BirthdayIdle = 5,
	Sleep = 6,
	Idle = 1,
	Stuck = 4,
	MaxMoodEating = 7,
	SpecialIdle = 3,
	Move = 2
}
RoomCharacterEnum.SourceState = {
	Place = 1,
	Train = 2
}
RoomCharacterEnum.CharacterAnimStateName = {
	BirthdayLoop = "idle_birthday_loop",
	SleepStart = "sleep_start",
	Eat = "eat",
	BirthdayUp = "idle_birthday_up",
	SleepEnd = "sleep_end",
	Produce = "produce",
	SpecialIdle = "idle_room",
	Touch = "click",
	Sleep = "sleep",
	Collect = "collect",
	Idle = "idle",
	Stuck = "stuck",
	Taming = "taming",
	Taming2 = "taming2",
	Taming3 = "taming3",
	Walk = "walk"
}
RoomCharacterEnum.CharacterTamingAnimList = {
	RoomCharacterEnum.CharacterAnimStateName.Taming,
	RoomCharacterEnum.CharacterAnimStateName.Taming2,
	RoomCharacterEnum.CharacterAnimStateName.Taming3
}
RoomCharacterEnum.CharacterLoopAnimState = {
	[RoomCharacterEnum.CharacterMoveState.Idle] = true,
	[RoomCharacterEnum.CharacterMoveState.Move] = true
}
RoomCharacterEnum.LoopAnimState = {
	[RoomCharacterEnum.CharacterAnimStateName.Idle] = true,
	[RoomCharacterEnum.CharacterAnimStateName.BirthdayLoop] = true,
	[RoomCharacterEnum.CharacterAnimStateName.Sleep] = true
}
RoomCharacterEnum.CharacterNextAnimNameDict = {
	[RoomCharacterEnum.CharacterMoveState.Idle] = {
		[RoomCharacterEnum.CharacterAnimStateName.SleepEnd] = RoomCharacterEnum.CharacterAnimStateName.Idle,
		[RoomCharacterEnum.CharacterAnimStateName.Eat] = RoomCharacterEnum.CharacterAnimStateName.Idle
	},
	[RoomCharacterEnum.CharacterMoveState.MaxMoodEating] = {
		[RoomCharacterEnum.CharacterAnimStateName.SleepEnd] = RoomCharacterEnum.CharacterAnimStateName.Eat,
		[RoomCharacterEnum.CharacterAnimStateName.Eat] = RoomCharacterEnum.CharacterAnimStateName.Idle
	},
	[RoomCharacterEnum.CharacterMoveState.BirthdayIdle] = {
		[RoomCharacterEnum.CharacterAnimStateName.BirthdayUp] = RoomCharacterEnum.CharacterAnimStateName.BirthdayLoop
	},
	[RoomCharacterEnum.CharacterMoveState.Sleep] = {
		[RoomCharacterEnum.CharacterAnimStateName.SleepEnd] = RoomCharacterEnum.CharacterAnimStateName.Eat,
		[RoomCharacterEnum.CharacterAnimStateName.Eat] = RoomCharacterEnum.CharacterAnimStateName.SleepStart,
		[RoomCharacterEnum.CharacterAnimStateName.SleepStart] = RoomCharacterEnum.CharacterAnimStateName.Sleep
	}
}
RoomCharacterEnum.XingTiIdleAnimStateName = "idle_special"
RoomCharacterEnum.CharacterAnimalAnimStateName = {
	Idle = "idle",
	Jump = "jump"
}
RoomCharacterEnum.CharacterAnimState = {
	[RoomCharacterEnum.CharacterMoveState.Idle] = RoomCharacterEnum.CharacterAnimStateName.Idle,
	[RoomCharacterEnum.CharacterMoveState.Move] = RoomCharacterEnum.CharacterAnimStateName.Walk,
	[RoomCharacterEnum.CharacterMoveState.SpecialIdle] = RoomCharacterEnum.CharacterAnimStateName.SpecialIdle,
	[RoomCharacterEnum.CharacterMoveState.Stuck] = RoomCharacterEnum.CharacterAnimStateName.Stuck,
	[RoomCharacterEnum.CharacterMoveState.BirthdayIdle] = RoomCharacterEnum.CharacterAnimStateName.BirthdayUp
}
RoomCharacterEnum.maskInteractAnim = {
	interact3 = true,
	interact2 = true,
	interact = true
}
RoomCharacterEnum.CharacterOrderType = {
	FaithUp = 3,
	RareDown = 2,
	FaithDown = 4,
	RareUp = 1
}
RoomCharacterEnum.SyncOperate = {
	Delete = 3,
	Update = 1,
	Overwrite = 2
}
RoomCharacterEnum.ErrorTryPlaceCharacter = {
	MaxCount = -1
}
RoomCharacterEnum.MaterialPath = "spine/xiaowu_character.mat"
RoomCharacterEnum.MoveStraightAngleLimitStrict = 25
RoomCharacterEnum.MoveStraightAngleLimit = 30
RoomCharacterEnum.MoveThroughBridge = 40
RoomCharacterEnum.CharacterHeightOffset = 0.109
RoomCharacterEnum.AnimalDuration = 2
RoomCharacterEnum.ClickTimes = 4
RoomCharacterEnum.ClickInterval = 3
RoomCharacterEnum.WaitingTimeAfterTouch = 1
RoomCharacterEnum.DialogClickCDTime = 0.5
RoomCharacterEnum.InteractionType = {
	Animal = 3,
	Building = 1,
	Dialog = 2
}
RoomCharacterEnum.InteractionState = {
	Complete = 3,
	Start = 2,
	None = 1
}
RoomCharacterEnum.ShowTimeFaithOp = {
	FaithOne = 2,
	FaithAll = 3,
	None = 1
}
RoomCharacterEnum.CameraFocus = {
	MoreShowList = 2,
	Normal = 1
}
RoomCharacterEnum.CharacterIdleAnimReplaceName = {
	[3025] = RoomCharacterEnum.XingTiIdleAnimStateName
}
RoomCharacterEnum.CommonEffect = {
	CritterAngry = 10001,
	CritterHighQuality = 10002,
	RightFoot = "common/v1a8_xuedijiaoyin_r",
	LeftFoot = "common/v1a8_xuedijiaoyin_l"
}
RoomCharacterEnum.TooNearDistance = 0.25
RoomCharacterEnum.BloomMaskDistance = 2
RoomCharacterEnum.BuilingInteractionNodeRadius = 0.2

return RoomCharacterEnum
