-- chunkname: @modules/logic/fight/view/FightViewMultiBossHp.lua

module("modules.logic.fight.view.FightViewMultiBossHp", package.seeall)

local FightViewMultiBossHp = class("FightViewMultiBossHp", FightViewBossHp)

function FightViewMultiBossHp:onInitView()
	FightViewMultiBossHp.super.onInitView(self)

	self._ani = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self._ani:Play("idle", nil, nil)
end

function FightViewMultiBossHp:onConstructor(entityId)
	self._entityId = entityId
end

function FightViewMultiBossHp:_checkBossAndUpdate()
	self._bossEntityMO = self:_getBossEntityMO()

	if self._bossEntityMO then
		gohelper.setActive(self.viewGO, true)
		gohelper.setActive(self._bossHpGO, true)
		self:_refreshBossHpUI()
	end
end

function FightViewMultiBossHp:_onEntityDead(entityId)
	if self._bossEntityMO and self._bossEntityMO.id == entityId then
		self._bossEntityMO = nil

		self:_tweenFillAmount()
		self._ani:Play("die", nil, nil)
	end
end

function FightViewMultiBossHp:_getBossEntityMO()
	return FightDataHelper.entityMgr:getById(self._entityId)
end

return FightViewMultiBossHp
