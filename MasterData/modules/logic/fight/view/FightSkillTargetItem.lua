-- chunkname: @modules/logic/fight/view/FightSkillTargetItem.lua

module("modules.logic.fight.view.FightSkillTargetItem", package.seeall)

local FightSkillTargetItem = class("FightSkillTargetItem", LuaCompBase)

function FightSkillTargetItem:init(go)
	self.go = go
	self._cardIcon = gohelper.findChildSingleImage(go, "icon")
end

function FightSkillTargetItem:onUpdateMO(entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)
	local skinConfig = FightConfig.instance:getSkinCO(entityMO.skin)

	self._cardIcon:LoadImage(entityMO:isEnemySide() and ResUrl.monsterHeadIcon(skinConfig.headIcon) or ResUrl.getHeadIconSmall(skinConfig.retangleIcon))

	if entityMO:isMonster() then
		local monsterCo = lua_monster.configDict[entityMO.modelId]

		if monsterCo and monsterCo.heartVariantId ~= 0 then
			self._cardImage = gohelper.findChildImage(self.go, "icon")

			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(monsterCo.heartVariantId), self._cardImage)
		end
	end
end

function FightSkillTargetItem:onDestroy()
	self._cardIcon:UnLoadImage()
end

return FightSkillTargetItem
