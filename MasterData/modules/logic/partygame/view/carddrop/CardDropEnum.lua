-- chunkname: @modules/logic/partygame/view/carddrop/CardDropEnum.lua

module("modules.logic.partygame.view.carddrop.CardDropEnum", package.seeall)

local CardDropEnum = _M

CardDropEnum.Type = {
	ShiTou = 1,
	CertainKill = 4,
	Invincible = 5,
	JianDao = 2,
	Bu = 3
}
CardDropEnum.Side = {
	Enemy = 2,
	My = 1
}
CardDropEnum.FloatType = {
	Heal = 3,
	Damage = 1,
	CriticalDamage = 2,
	Restrain = 4
}
CardDropEnum.FloatDuration = 1
CardDropEnum.TweenDuration = 0.3
CardDropEnum.FloatItemHeight = 50
CardDropEnum.FloatItemInitOffsetY = 320

local _StateId = -1

local function GetStateId()
	_StateId = _StateId + 1

	return _StateId
end

CardDropEnum.GameState = {
	None = GetStateId(),
	ShowAllPlayer = GetStateId(),
	ShowMyAndEnemy = GetStateId(),
	StartRound = GetStateId(),
	BothShowAnim = GetStateId(),
	Operate = GetStateId(),
	MyPlayCardReset = GetStateId(),
	CardShowing = GetStateId(),
	CardFly = GetStateId(),
	CardBattle = GetStateId(),
	Attack = GetStateId(),
	CalculateRank = GetStateId(),
	Coin = GetStateId(),
	GameResult = GetStateId(),
	GuideVsView = GetStateId(),
	GuidePromotion = GetStateId(),
	GuidePartyResult = GetStateId(),
	WaitDone = GetStateId()
}
CardDropEnum.AnimNameEnum = {
	Hit = "Hit",
	Cast = "Cast",
	Strike = "Strike",
	Punch = "Punch"
}
CardDropEnum.AttackSide = {
	Attacker = 1,
	Defender = 2
}
CardDropEnum.SettleState = {
	NotStart = 1,
	Victory = 2,
	Defeat = 3,
	Draw = 4
}
CardDropEnum.Variant = {
	Crit = 1,
	Vampirism = 2,
	None = 0
}
CardDropEnum.Variant2Icon = {
	[CardDropEnum.Variant.Crit] = "battlegame_bufficon_02",
	[CardDropEnum.Variant.Vampirism] = "battlegame_bufficon_01"
}
CardDropEnum.TypeLayout = typeof(UnityEngine.UI.LayoutElement)
CardDropEnum.HandCardSelectDuration = 0.1
CardDropEnum.HandCardResetDuration = 0.16
CardDropEnum.HandCardHideAnchorY = -300
CardDropEnum.HandCardSelectedAnchorY = 60
CardDropEnum.HandCardPivot = Vector2(1, 0.5)
CardDropEnum.HandCardAnchorMinMax = Vector2(1, 0.5)
CardDropEnum.HandCardWidth = 168
CardDropEnum.StartAnchorX = -2000
CardDropEnum.StartFlyDuration = 0.3
CardDropEnum.StartFlyInterval = 0.03
CardDropEnum.StartFlyEaseType = EaseType.OutCubic
CardDropEnum.HandCardScale = 1
CardDropEnum.BattleCardScale = 1.1
CardDropEnum.PlayCardPivot = Vector2(0, 0.5)
CardDropEnum.PlayCardAnchorMinMax = Vector2(0, 0.5)
CardDropEnum.PlayCardStarAnchorX = -200
CardDropEnum.FlyToBattleAreaDuration = 0.16
CardDropEnum.FlyToBattleAreaEaseType = EaseType.OutCubic
CardDropEnum.BattleCardAnchorMinMax = Vector2(1, 0)

return CardDropEnum
