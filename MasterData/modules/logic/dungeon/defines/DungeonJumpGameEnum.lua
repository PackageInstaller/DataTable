-- chunkname: @modules/logic/dungeon/defines/DungeonJumpGameEnum.lua

module("modules.logic.dungeon.defines.DungeonJumpGameEnum", package.seeall)

local DungeonJumpGameEnum = _M

DungeonJumpGameEnum.EleementId2JumpMapIdDict = {}
DungeonJumpGameEnum.episodeId = 282011
DungeonJumpGameEnum.battleGuideId = 28103
DungeonJumpGameEnum.elementId = 101012
DungeonJumpGameEnum.ConstId = {
	MaxJumpDistance = 1,
	ShowSnowEffectParams = 7,
	NodeSize = 6,
	DistancePerSecond = 3,
	MaxCircleSize = 5,
	JumpTime = 4
}
DungeonJumpGameEnum.JumoNodeBg = {
	"v2a8_dungeon_jump_block1",
	"v2a8_dungeon_jump_block2",
	"v2a8_dungeon_jump_block3",
	"v2a8_dungeon_jump_block4"
}

return DungeonJumpGameEnum
