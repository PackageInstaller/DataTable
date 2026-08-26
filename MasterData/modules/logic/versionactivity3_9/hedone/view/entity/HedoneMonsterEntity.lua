-- chunkname: @modules/logic/versionactivity3_9/hedone/view/entity/HedoneMonsterEntity.lua

module("modules.logic.versionactivity3_9.hedone.view.entity.HedoneMonsterEntity", package.seeall)

local HedoneMonsterEntity = class("HedoneMonsterEntity", HedoneBaseEntity)

function HedoneMonsterEntity:_onInit()
	self._imageshow = gohelper.findChildImage(self._go, "#simage_show")

	transformhelper.setLocalRotation(self._imageshow.transform, 0, 180, 0)

	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._go)
	self._animator = self._go:GetComponent(gohelper.Type_Animator)
end

function HedoneMonsterEntity:_onSetUid()
	local id = self:getId()
	local imgName = HedoneConfig.instance:getHedoneMonsterImage(id)

	UISpriteSetMgr.instance:setV3a9HedoneSprite(self._imageshow, imgName, true)
end

function HedoneMonsterEntity:refreshScale()
	local id = self:getId()
	local scale = HedoneConfig.instance:getHedoneMonsterScale(id)

	transformhelper.setLocalScale(self._trans, scale, scale, scale)
end

function HedoneMonsterEntity:onTakeDamage(damage, isCrit)
	self:playAnim(HedoneGameEnum.EntityAnimName.Hit)
end

function HedoneMonsterEntity:setYLevel(yLevel, parentGO)
	if self._curYLevel and self._curYLevel == yLevel or gohelper.isNil(parentGO) then
		return
	end

	self._curYLevel = yLevel

	gohelper.setParent(self._go, parentGO)
end

return HedoneMonsterEntity
