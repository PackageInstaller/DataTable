-- chunkname: @modules/logic/sp02/atomic/define/AtomicEnum.lua

module("modules.logic.sp02.atomic.define.AtomicEnum", package.seeall)

local AtomicEnum = _M

AtomicEnum.ConstId = {
	EmergencyExpireTime = 4,
	WholeMapCameraPos = 6,
	MaxAlarmLevel = 10,
	AdditionRule3 = 13,
	AdditionRule4 = 14,
	TalentSlotCount = 5,
	WholeMapPos = 3,
	WholeMapUrl = 2,
	TalentCoin = 1,
	AdditionRule1 = 11,
	AdditionRule2 = 12,
	TaskBigRewards = 16,
	AtomicTalentMaxCoinNum = 19,
	TalentUnlock = 15,
	AtomicGameSuccTime = 18,
	WholeMapCameraRot = 8,
	AlarmLevelUpValue = 9
}
AtomicEnum.PlayerPrefsKey = {
	AtomicDataBaseNewFlag = "AtomicDataBaseNewFlag",
	AtomicDataBaseUnlockFlag = "AtomicDataBaseUnlockFlag"
}
AtomicEnum.AVGPlayStoryId = 2038503

return AtomicEnum
