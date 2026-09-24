-- chunkname: @modules/logic/matchgame/fight/defines/MatchGameFightEvent.lua

module("modules.logic.matchgame.fight.defines.MatchGameFightEvent", package.seeall)

local MatchGameFightEvent = _M
local _get = GameUtil.getUniqueTb(1000)

MatchGameFightEvent.MoveFillElementItemFinish = _get()
MatchGameFightEvent.BombElementItemFinish = _get()
MatchGameFightEvent.HeroAttackStart = _get()
MatchGameFightEvent.HeroAttackFinish = _get()
MatchGameFightEvent.EnemyAttackStart = _get()
MatchGameFightEvent.EnemyAttackFinish = _get()
MatchGameFightEvent.ContinueGame = _get()
MatchGameFightEvent.QuitGame = _get()
MatchGameFightEvent.RestartGame = _get()
MatchGameFightEvent.RefreshTargetGoal = _get()
MatchGameFightEvent.BeginGameStartRoundTime = _get()
MatchGameFightEvent.OnSkillNoneCondition = _get()
MatchGameFightEvent.OnSkillCastCondition = _get()
MatchGameFightEvent.OnMatchCountMoreThanCondition = _get()
MatchGameFightEvent.OnFeverEnterCondition = _get()
MatchGameFightEvent.OnBattleStartCondition = _get()
MatchGameFightEvent.OnTurnStartCondition = _get()
MatchGameFightEvent.OnTurnEndCondition = _get()
MatchGameFightEvent.OnRemoveSkillBuff = _get()
MatchGameFightEvent.OnChainNumAdd = _get()
MatchGameFightEvent.RefreshChallengeScore = _get()
MatchGameFightEvent.OnStartDragElementGuide = _get()
MatchGameFightEvent.OnDragElementGuideFinish = _get()
MatchGameFightEvent.OnEnterFeverStateGuide = _get()
MatchGameFightEvent.OnGuideRoundTimeEnd = _get()
MatchGameFightEvent.OnGuideOpenCareerTipView = _get()
MatchGameFightEvent.OnGuideCloseCareerTipView = _get()

return MatchGameFightEvent
