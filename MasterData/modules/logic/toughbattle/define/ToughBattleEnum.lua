-- chunkname: @modules/logic/toughbattle/define/ToughBattleEnum.lua

module("modules.logic.toughbattle.define.ToughBattleEnum", package.seeall)

local ToughBattleEnum = _M

ToughBattleEnum.Mode = {
	Act = 2,
	Story = 1
}
ToughBattleEnum.HeroType = {
	Skill = 3,
	Hero = 1,
	Rule = 2
}
ToughBattleEnum.MapId_stage1 = 10731
ToughBattleEnum.MapId_stage2 = 10732
ToughBattleEnum.TicketConstId = 2
ToughBattleEnum.HoldTicketMaxLimitConstId = 4
ToughBattleEnum.DungeonMapCameraSize = 6.6
ToughBattleEnum.MapId_7_28 = 10728
ToughBattleEnum.ActElementId = 100709
ToughBattleEnum.FinishIconPos = {
	Vector2.New(37.7, -19.76),
	Vector2.New(48.75, -24.42),
	Vector2.New(42.58, -19.16),
	Vector2.New(34.11, -24.03),
	(Vector2.New(48.37, -17.84))
}
ToughBattleEnum.WordInterval = 3.5
ToughBattleEnum.WordTxtPosYOffset = 5
ToughBattleEnum.WordTxtPosXOffset = 2
ToughBattleEnum.WordTxtInterval = 0.2
ToughBattleEnum.WordTxtOpen = 0.7
ToughBattleEnum.WordTxtIdle = 1.1
ToughBattleEnum.WordTxtClose = 0.5
ToughBattleEnum.WordLine2Delay = 1
ToughBattleEnum.WordPlace = {
	{
		x = -600,
		y = -50
	},
	{
		x = 420,
		y = -120
	},
	{
		x = 500,
		y = 20
	},
	{
		x = 400,
		y = 150
	},
	{
		x = 360,
		y = 350
	},
	{
		x = -800,
		y = -200
	},
	{
		x = -500,
		y = -350
	},
	{
		x = -100,
		y = 400
	}
}

return ToughBattleEnum
