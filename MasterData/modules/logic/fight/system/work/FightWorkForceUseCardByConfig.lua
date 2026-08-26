-- chunkname: @modules/logic/fight/system/work/FightWorkForceUseCardByConfig.lua

module("modules.logic.fight.system.work.FightWorkForceUseCardByConfig", package.seeall)

local FightWorkForceUseCardByConfig = class("FightWorkForceUseCardByConfig", FightWorkItem)

function FightWorkForceUseCardByConfig:onConstructor()
	return
end

function FightWorkForceUseCardByConfig:onStart()
	FightDataHelper.stateMgr.forceUseCard = true

	self:checkForceUseCard()
end

function FightWorkForceUseCardByConfig:checkForceUseCard()
	local opList = FightDataHelper.operationDataMgr:getPlayCardOpList()
	local handCard = FightDataHelper.handCardMgr.handCard

	for i, card in ipairs(handCard) do
		local skillId = card.skillId

		if lua_fight_skill_force_use.configDict[skillId] then
			local beginRoundOp = FightOperationItemData.New()
			local proto = FightDef_pb.BeginRoundOper()

			proto.operType = 2
			proto.param1 = i
			proto.toId = "0"

			beginRoundOp:setByProto(proto)

			local work = self:com_registWork(FightAutoPlayCardWork, beginRoundOp)

			work:registFinishCallback(self.checkForceUseCard, self)
			self:cancelFightWorkSafeTimer()
			work:start()

			return
		end
	end

	self:onDone(true)
end

function FightWorkForceUseCardByConfig:onDestructor()
	FightDataHelper.stateMgr.forceUseCard = false
end

return FightWorkForceUseCardByConfig
