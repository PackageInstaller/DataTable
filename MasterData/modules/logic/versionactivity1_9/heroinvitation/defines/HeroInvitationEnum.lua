-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/defines/HeroInvitationEnum.lua

module("modules.logic.versionactivity1_9.heroinvitation.defines.HeroInvitationEnum", package.seeall)

local HeroInvitationEnum = _M

HeroInvitationEnum.ChapterId = 311
HeroInvitationEnum.InvitationState = {
	ElementLocked = 0,
	CanGet = 2,
	TimeLocked = 4,
	Finish = 3,
	Normal = 1
}
HeroInvitationEnum.MapDir = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}

return HeroInvitationEnum
