-- chunkname: @modules/logic/fight/view/FightViewBossEnergy.lua

module("modules.logic.fight.view.FightViewBossEnergy", package.seeall)

local FightViewBossEnergy = class("FightViewBossEnergy", FightBaseView)

function FightViewBossEnergy:onConstructor(entityMo)
	self._bossEntityMO = entityMo
end

function FightViewBossEnergy:onInitView()
	self._imghpbar = gohelper.findChildImage(self.viewGO, "image_hpbarbg/image_hpbarfg")
	self._imgSignEnergyContainer = gohelper.findChild(self.viewGO, "image_hpbarbg/divide")
	self._imgSignEnergyItem = gohelper.findChild(self.viewGO, "image_hpbarbg/divide/#go_divide1")
	self._txtnum = gohelper.findChildTextMesh(self.viewGO, "image_hpbarbg/#txt_num")
	self._gomax = gohelper.findChild(self.viewGO, "image_hpbarbg/max")
	self._gobreak = gohelper.findChild(self.viewGO, "image_hpbarbg/breakthrough")
end

function FightViewBossEnergy:addEvents()
	self:com_registFightEvent(FightEvent.PowerChange, self._onPowerChange)
end

function FightViewBossEnergy:removeEvents()
	return
end

function FightViewBossEnergy:onOpen()
	gohelper.setActive(self._gobreak, false)

	local config = self._bossEntityMO:getCO()

	gohelper.CreateObjList(self, self._bossEnergySignShow, (not string.nilorempty(config.energySign) or nil) and string.splitToNumber(config.energySign, "#"), self._imgSignEnergyContainer, self._imgSignEnergyItem)

	local energyInfo = self._bossEntityMO:getPowerInfo(FightEnum.PowerType.Energy)

	self:_setValue(energyInfo.num / 1000, false)
end

function FightViewBossEnergy:_bossEnergySignShow(obj, data, index)
	recthelper.setAnchorX(obj.transform, data / 1000 * recthelper.getWidth(obj.transform.parent.parent))
end

function FightViewBossEnergy:_onPowerChange(entityId, powerId, oldNum, newNum)
	if self._bossEntityMO.id == entityId and FightEnum.PowerType.Energy == powerId and oldNum ~= newNum then
		self:_setValue(newNum / 1000, true)
	end
end

function FightViewBossEnergy:_setValue(value, tween)
	if tween then
		ZProj.TweenHelper.KillByObj(self._imghpbar)
		ZProj.TweenHelper.DOFillAmount(self._imghpbar, value, 0.2)
	else
		self._imghpbar.fillAmount = value
	end

	self._txtnum.text = string.format("%s%%", math.floor(value * 1000) / 10)

	gohelper.setActive(self._gomax, value == 1)
	gohelper.setActive(self._gobreak, value > 1)
end

return FightViewBossEnergy
