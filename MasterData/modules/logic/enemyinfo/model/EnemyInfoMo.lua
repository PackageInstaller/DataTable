-- chunkname: @modules/logic/enemyinfo/model/EnemyInfoMo.lua

module("modules.logic.enemyinfo.model.EnemyInfoMo", package.seeall)

local EnemyInfoMo = pureTable("EnemyInfoMo")

function EnemyInfoMo:ctor()
	self.showLeftTab = false
	self.battleId = 0
	self.tabEnum = EnemyInfoEnum.TabEnum.Normal
end

function EnemyInfoMo:updateBattleId(battleId)
	if self.battleId == battleId then
		return
	end

	self.battleId = battleId

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.UpdateBattleInfo, self.battleId)
end

function EnemyInfoMo:setTabEnum(tabEnum)
	self.tabEnum = tabEnum
end

function EnemyInfoMo:setShowLeftTab(showLeftTab)
	self.showLeftTab = showLeftTab
end

return EnemyInfoMo
