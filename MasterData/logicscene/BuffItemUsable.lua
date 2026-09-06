-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffItemUsable.lua

module("logicscene.scene.battle.skills.buffs.BuffItemUsable", package.seeall)

local BuffItemUsable = class("BuffItemUsable", BuffBase)

function BuffItemUsable:ctor(buffCo, unit, itemId)
	self.itemId = itemId

	BuffItemUsable.super.ctor(self, buffCo, unit)
end

function BuffItemUsable:_buildEffects()
	local item = BattleItemsModel.instance:getBattleItemById(self.itemId)

	self.sustainEffectCo = item:selectTargetEff()
end

function BuffItemUsable:getBuffId()
	return UnitCompBuffList.ItemUsableId
end

function BuffItemUsable:onBuffBegin()
	self._unit.attrs:setItemUsedLocking(true)
	BuffItemUsable.super.onBuffBegin(self)
end

function BuffItemUsable:onBuffEnd()
	self._unit.attrs:setItemUsedLocking(false)
	BuffItemUsable.super.onBuffEnd(self)
end

function BuffItemUsable:isCustomBuff()
	return true
end

return BuffItemUsable
