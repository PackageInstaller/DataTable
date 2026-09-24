-- chunkname: @modules/logic/matchgame/fight/view/work/MatchGameElementBombWork.lua

module("modules.logic.matchgame.fight.view.work.MatchGameElementBombWork", package.seeall)

local MatchGameElementBombWork = class("MatchGameElementBombWork", BaseWork)

function MatchGameElementBombWork:ctor()
	MatchGameController.instance:registerCallback(MatchGameFightEvent.BombElementItemFinish, self.onSetDone, self)
end

function MatchGameElementBombWork:onStart()
	return
end

function MatchGameElementBombWork:onSetDone()
	self:onDone(true)
end

function MatchGameElementBombWork:clearWork()
	MatchGameController.instance:unregisterCallback(MatchGameFightEvent.BombElementItemFinish, self.onSetDone, self)
end

return MatchGameElementBombWork
