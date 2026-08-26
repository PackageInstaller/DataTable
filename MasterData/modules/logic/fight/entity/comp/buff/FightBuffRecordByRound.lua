-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffRecordByRound.lua

module("modules.logic.fight.entity.comp.buff.FightBuffRecordByRound", package.seeall)

local FightBuffRecordByRound = class("FightBuffRecordByRound")

function FightBuffRecordByRound:onBuffStart(entity, buffMo)
	self.entity = entity

	FightController.instance:registerCallback(FightEvent.ALF_AddRecordCardData, self.onUpdateRecordCard, self)
	self:onUpdateRecordCard(buffMo)
end

function FightBuffRecordByRound:onUpdateRecordCard(buffMo)
	if buffMo then
		if not buffMo.actCommonParams then
			local actParam = ""
			local list = FightStrUtil.instance:getSplitToNumberCache(actParam, "#")

			if self.entity.heroCustomComp then
				local alfCustomComp = self.entity.heroCustomComp:getCustomComp()

				if self.entity.heroCustomComp then
					self.entity.heroCustomComp:setCacheRecordSkillList(list)
				end

				FightController.instance:dispatchEvent(FightEvent.ALF_AddRecordCardUI)
			end
		end
	end
end

function FightBuffRecordByRound:onBuffEnd()
	self:clear()
end

function FightBuffRecordByRound:clear()
	FightController.instance:unregisterCallback(FightEvent.ALF_AddRecordCardData, self.onUpdateRecordCard, self)
end

function FightBuffRecordByRound:dispose()
	self:clear()
end

return FightBuffRecordByRound
