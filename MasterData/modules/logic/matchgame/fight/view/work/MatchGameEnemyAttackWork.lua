-- chunkname: @modules/logic/matchgame/fight/view/work/MatchGameEnemyAttackWork.lua

module("modules.logic.matchgame.fight.view.work.MatchGameEnemyAttackWork", package.seeall)

local MatchGameEnemyAttackWork = class("MatchGameEnemyAttackWork", BaseWork)

function MatchGameEnemyAttackWork:ctor()
	MatchGameController.instance:registerCallback(MatchGameFightEvent.EnemyAttackFinish, self.onSetDone, self)
end

function MatchGameEnemyAttackWork:onStart()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.EnemyAttackStart)
end

function MatchGameEnemyAttackWork:onSetDone()
	self:onDone(true)
end

function MatchGameEnemyAttackWork:clearWork()
	MatchGameController.instance:unregisterCallback(MatchGameFightEvent.EnemyAttackFinish, self.onSetDone, self)
end

return MatchGameEnemyAttackWork
