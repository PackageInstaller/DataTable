-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroEffectItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEffectItem", package.seeall)

local DiceHeroEffectItem = class("DiceHeroEffectItem", LuaCompBase)

function DiceHeroEffectItem:init(go)
	self.go = go
	self._trans = go.transform
	self._godamage = gohelper.findChild(go, "damage")
	self._txtdamage = gohelper.findChildText(go, "damage/x/txtNum")
	self._goshield = gohelper.findChild(go, "shield")
	self._txtshield = gohelper.findChildText(go, "shield/x/txtNum")
	self._gohero = gohelper.findChild(go, "#go_hpFlyItem_hero")
	self._goenemy = gohelper.findChild(go, "#go_hpFlyItem_enemy")
	self._goeffectenergy = gohelper.findChild(go, "#go_hpFlyItem_energy")
	self._goeffectshield = gohelper.findChild(go, "#go_hpFlyItem_shield")
end

function DiceHeroEffectItem:initData(type, fromPos, toPos, num)
	ZProj.TweenHelper.KillByObj(self._trans)
	gohelper.setActive(self._godamage, type == 1)
	gohelper.setActive(self._gohero, type == 2)
	gohelper.setActive(self._goenemy, type == 3)
	gohelper.setActive(self._goshield, type == 4)
	gohelper.setActive(self._goeffectenergy, type == 5)
	gohelper.setActive(self._goeffectshield, type == 6)
	transformhelper.setPos(self._trans, fromPos.x, fromPos.y, fromPos.z)

	if type == 1 then
		self._txtdamage.text = num

		transformhelper.setLocalRotation(self._trans, 0, 0, 0)
	elseif type == 4 then
		self._txtshield.text = num

		transformhelper.setLocalRotation(self._trans, 0, 0, 0)
	else
		local localPos = self._trans.parent:InverseTransformPoint(toPos)

		ZProj.TweenHelper.DOLocalMove(self._trans, localPos.x, localPos.y, localPos.z, 0.5)

		local angle = math.deg(math.atan2(toPos.y - fromPos.y, toPos.x - fromPos.x)) + 180

		transformhelper.setLocalRotation(self._trans, 0, 0, angle)
	end
end

return DiceHeroEffectItem
