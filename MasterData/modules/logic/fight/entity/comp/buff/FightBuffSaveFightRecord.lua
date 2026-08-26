-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffSaveFightRecord.lua

module("modules.logic.fight.entity.comp.buff.FightBuffSaveFightRecord", package.seeall)

local FightBuffSaveFightRecord = class("FightBuffSaveFightRecord")

function FightBuffSaveFightRecord:onBuffStart(entity, buffMo)
	local array = FightStrUtil.instance:getSplitToNumberCache(buffMo.actCommonParams, "#")

	if array then
		FightModel.instance:setRoundOffset(tonumber(array[2]))
		FightController.instance:dispatchEvent(FightEvent.RefreshUIRound)
	end
end

function FightBuffSaveFightRecord:clear()
	return
end

function FightBuffSaveFightRecord:onBuffEnd()
	self:clear()
end

function FightBuffSaveFightRecord:dispose()
	self:clear()
end

return FightBuffSaveFightRecord
