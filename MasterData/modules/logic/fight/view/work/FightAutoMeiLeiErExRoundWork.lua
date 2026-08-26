-- chunkname: @modules/logic/fight/view/work/FightAutoMeiLeiErExRoundWork.lua

module("modules.logic.fight.view.work.FightAutoMeiLeiErExRoundWork", package.seeall)

local FightAutoMeiLeiErExRoundWork = class("FightAutoMeiLeiErExRoundWork", FightWorkItem)

function FightAutoMeiLeiErExRoundWork:onConstructor()
	self.SAFETIME = 10
end

function FightAutoMeiLeiErExRoundWork:onStart(entity)
	self:com_registFightEvent(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail)
	FightDataHelper.meiLeiErExRoundDataMgr:refreshData()

	self.fromId = FightDataHelper.meiLeiErExRoundDataMgr.fromId

	if FightDataHelper.meiLeiErExRoundDataMgr.value >= FightDataHelper.meiLeiErExRoundDataMgr.trigger then
		FightRpc.instance:sendUseClothSkillRequest(0, self.fromId, "0", FightEnum.ClothSkillType.MeiLeiErExtraRound)
		self:cancelFightWorkSafeTimer()

		return
	end

	self:onDone(true)
end

function FightAutoMeiLeiErExRoundWork:_onRespUseClothSkillFail()
	self:onDone(true)
end

return FightAutoMeiLeiErExRoundWork
