-- chunkname: @modules/logic/matchgame/fight/view/work/MatchGameElementItemMoveFillWork.lua

module("modules.logic.matchgame.fight.view.work.MatchGameElementItemMoveFillWork", package.seeall)

local MatchGameElementItemMoveFillWork = class("MatchGameElementItemMoveFillWork", BaseWork)

function MatchGameElementItemMoveFillWork:ctor(elementItemMap)
	self.elementItemMap = elementItemMap

	MatchGameController.instance:registerCallback(MatchGameFightEvent.MoveFillElementItemFinish, self.onSetDone, self)
end

function MatchGameElementItemMoveFillWork:onStart()
	local fillRounds = MatchGameFightModel.instance:computeGravityAndFill(self.elementItemMap)

	if not fillRounds or #fillRounds == 0 then
		self:onSetDone()
	end
end

function MatchGameElementItemMoveFillWork:onSetDone()
	self:onDone(true)
end

function MatchGameElementItemMoveFillWork:clearWork()
	MatchGameController.instance:unregisterCallback(MatchGameFightEvent.MoveFillElementItemFinish, self.onSetDone, self)
end

return MatchGameElementItemMoveFillWork
