-- chunkname: @modules/logic/matchgame/fight/view/work/MatchGameHeroAttackWork.lua

module("modules.logic.matchgame.fight.view.work.MatchGameHeroAttackWork", package.seeall)

local MatchGameHeroAttackWork = class("MatchGameHeroAttackWork", BaseWork)

function MatchGameHeroAttackWork:ctor()
	MatchGameController.instance:registerCallback(MatchGameFightEvent.HeroAttackFinish, self.onSetDone, self)
end

function MatchGameHeroAttackWork:onStart()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.HeroAttackStart)
end

function MatchGameHeroAttackWork:onSetDone()
	self:onDone(true)
end

function MatchGameHeroAttackWork:clearWork()
	MatchGameController.instance:unregisterCallback(MatchGameFightEvent.HeroAttackFinish, self.onSetDone, self)
end

return MatchGameHeroAttackWork
