-- chunkname: @modules/logic/fight/view/work/FightAutoPlayCardWork.lua

module("modules.logic.fight.view.work.FightAutoPlayCardWork", package.seeall)

local FightAutoPlayCardWork = class("FightAutoPlayCardWork", FightWorkItem)

function FightAutoPlayCardWork:onConstructor(beginRoundOp)
	self.SAFETIME = 10
	self._beginRoundOp = beginRoundOp
end

function FightAutoPlayCardWork:onStart()
	if not self._beginRoundOp then
		self:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, self._beginRoundOp.toId)

	local index = self._beginRoundOp.param1
	local toId = self._beginRoundOp.toId
	local param2 = self._beginRoundOp.param2
	local param3 = self._beginRoundOp.param3
	local cardParam1 = self._beginRoundOp.cardParam1
	local work = FightMsgMgr.sendMsg(FightMsgId.RegistPlayHandCardWork, index, toId, param2, param3, cardParam1)

	self:playWorkAndDone(work)
end

return FightAutoPlayCardWork
