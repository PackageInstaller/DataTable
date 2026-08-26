-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType6.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType6", package.seeall)

local FightRestartAbandonType6 = class("FightRestartAbandonType6", FightRestartAbandonType1)

function FightRestartAbandonType6:episodeCostIsEnough()
	if DungeonModel.instance:getChapterRemainingNum(DungeonEnum.ChapterType.Equip) > 0 then
		self._box_type = MessageBoxIdDefine.EquipFreeRestart

		return true
	end

	return FightRestartAbandonType6.super.episodeCostIsEnough(self)
end

return FightRestartAbandonType6
