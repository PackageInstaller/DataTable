-- chunkname: @modules/logic/fight/view/FightViewSurvivalBossHp.lua

module("modules.logic.fight.view.FightViewSurvivalBossHp", package.seeall)

local FightViewSurvivalBossHp = class("FightViewSurvivalBossHp", FightViewBossHp)

FightViewSurvivalBossHp.DefaultOneMaxHp = 10000

function FightViewSurvivalBossHp:onInitView()
	FightViewSurvivalBossHp.super.onInitView(self)

	self.txtSurvivalHpCount = gohelper.findChildText(self.viewGO, "Alpha/bossHp/mask/container/#txt_survival_hp_count")

	gohelper.setActive(self.txtSurvivalHpCount.gameObject, true)

	self.bgHp = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/mask/container/unlimitedhp")
	self.bgHpGo = self.bgHp.gameObject

	gohelper.setActive(self.bgHpGo, true)

	self.shieldHp = self._imgHpShield

	gohelper.setActive(self.shieldHp.gameObject, true)

	self.hp = self._imgHp

	gohelper.setActive(self.hp.gameObject, true)

	self.tweenHp = 0
	self.tweenShieldHp = 0
	self.targetHp = 0
	self.targetShieldHp = 0

	local battleId = FightDataHelper.fieldMgr.battleId
	local battleCo = lua_battle.configDict[battleId]
	local type = battleCo and battleCo.bossHpType
	local typeArr = not string.nilorempty(type) and FightStrUtil.instance:getSplitCache(type, "#")

	self.oneMaxHp = typeArr and tonumber(typeArr[2]) or FightViewSurvivalBossHp.DefaultOneMaxHp
end

function FightViewSurvivalBossHp:_updateUI()
	if not self._bossEntityMO then
		return
	end

	self:directUpdateHp()
	self:refreshImageIcon()
	self:_refreshCareer()
	self:_detectBossHpSign()
	self:_detectBossMultiHp()
end

function FightViewSurvivalBossHp:refreshImageIcon()
	if not self._bossEntityMO then
		return
	end

	local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]

	if monsterCO then
		::label_3_0::

		local skinCO = FightConfig.instance:getSkinCO(monsterCO.skinId)
		local headIcon = skinCO and skinCO.headIcon

		if not string.nilorempty(headIcon) then
			gohelper.setActive(self._imgHead.gameObject, true)
			gohelper.getSingleImage(self._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinCO.headIcon))

			if monsterCO.heartVariantId ~= 0 then
				IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(monsterCO.heartVariantId), self._imgHeadIcon)
			end
		else
			gohelper.setActive(self._imgHead.gameObject, false)
		end
	end
end

function FightViewSurvivalBossHp:directUpdateHp()
	if not self._bossEntityMO then
		return
	end

	local maxHp = self._bossEntityMO.attrMO.hp
	local currentHp = self._bossEntityMO.currentHp

	currentHp = math.min(math.max(0, currentHp), maxHp)
	self.tweenHp = currentHp
	self.targetHp = currentHp
	self.tweenShieldHp = self._bossEntityMO.shieldValue
	self.targetShieldHp = self._bossEntityMO.shieldValue

	self:refreshHpAndShield()
	self:refreshReduceHP()
end

function FightViewSurvivalBossHp:_tweenFillAmount(duration)
	self:directUpdateHp()
end

function FightViewSurvivalBossHp:onCoverPerformanceEntityData(entityId)
	if not self._bossEntityMO or entityId ~= self._bossEntityMO.id then
		return
	end

	self:directUpdateHp()
end

FightViewSurvivalBossHp.HpDuration = 0.5

function FightViewSurvivalBossHp:_onHpChange(defender, num)
	if num == 0 then
		return
	end

	if not self._bossEntityMO then
		return
	end

	if defender.id ~= self._bossEntityMO.id then
		return
	end

	if num < 0 then
		gohelper.setActive(self._goHpEffect, true)

		self._aniHpEffect.enabled = true
		self._aniHpEffect.speed = 1

		self._aniHpEffect:Play("hpeffect", 0, 0)
	end

	self:clearHpTween()

	local maxHp = self._bossEntityMO.attrMO.hp

	self.targetHp = self.targetHp + num
	self.targetHp = math.min(math.max(0, self.targetHp), maxHp)
	self.hpTweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenHp, self.targetHp, FightViewSurvivalBossHp.HpDuration, self.frameSetHp, self.onHpTweenDone, self)
end

function FightViewSurvivalBossHp:frameSetHp(value)
	self.tweenHp = value

	self:refreshHpAndShield()
end

function FightViewSurvivalBossHp:onHpTweenDone()
	self.tweenHp = self.targetHp

	self:refreshHpAndShield()
end

function FightViewSurvivalBossHp:_onShieldChange(defender, num)
	if not self._bossEntityMO then
		return
	end

	if defender.id ~= self._bossEntityMO.id then
		return
	end

	self:clearShieldTween()

	self.targetShieldHp = self._bossEntityMO.shieldValue
	self.shieldTweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenShieldHp, self.targetShieldHp, FightViewSurvivalBossHp.HpDuration, self.frameSetShield, self.onShieldTweenDone, self)
end

function FightViewSurvivalBossHp:frameSetShield(value)
	self.tweenShieldHp = value

	self:refreshHpAndShield()
end

function FightViewSurvivalBossHp:onShieldTweenDone()
	self.tweenShieldHp = self.targetShieldHp

	self:refreshHpAndShield()
end

function FightViewSurvivalBossHp:refreshHpAndShield()
	local hpFillAmount, shieldFillAmount = self:_getFillAmount()

	self.hp.fillAmount = hpFillAmount
	self.shieldHp.fillAmount = shieldFillAmount

	self:_changeShieldPos(hpFillAmount)
	self:refreshHpCount()
	self:refreshHpColor()
	self:refreshReduceHP()
end

function FightViewSurvivalBossHp:_getFillAmount()
	if not self._bossEntityMO then
		return 0, 0
	end

	local oneMaxHp = self.oneMaxHp
	local curHp = self.tweenHp % oneMaxHp

	if curHp == 0 and self.tweenHp > 0 then
		curHp = oneMaxHp
	end

	local hpPercent = curHp / oneMaxHp
	local shieldPercent = 0

	if oneMaxHp >= self.tweenShieldHp + curHp then
		hpPercent = curHp / oneMaxHp
		shieldPercent = (self.tweenShieldHp + curHp) / oneMaxHp
	else
		hpPercent = curHp / (curHp + self.tweenShieldHp)
		shieldPercent = 1
	end

	recthelper.setAnchorX(self._hp_container_tran, 0)

	return hpPercent, shieldPercent
end

FightViewSurvivalBossHp.HpCountColor = {
	Shield = "#1A1A1A",
	Normal = "#FFFFFF"
}

function FightViewSurvivalBossHp:refreshHpCount()
	local curHp = self.tweenHp
	local count = math.ceil(curHp / self.oneMaxHp)

	self.txtSurvivalHpCount.text = "×" .. tostring(count)

	local hasShield = self.tweenShieldHp > 0

	if hasShield then
		if not FightViewSurvivalBossHp.HpCountColor.Shield then
			local color = FightViewSurvivalBossHp.HpCountColor.Normal

			SLFramework.UGUI.GuiHelper.SetColor(self.txtSurvivalHpCount, color)
		end
	end
end

local Threshold = {
	0.3333333333333333,
	0.6666666666666666,
	1
}
local Color = {
	{
		"#B33E2D",
		"#6F2216"
	},
	{
		"#D9852B",
		"#693700"
	},
	{
		"#69995E",
		"#243B1E"
	}
}

function FightViewSurvivalBossHp:refreshHpColor()
	if not self._bossEntityMO then
		return
	end

	local entityMO = self._bossEntityMO

	if entityMO.attrMO and entityMO.attrMO.hp > 0 then
		if not entityMO.attrMO.hp then
			local maxHp = 1
			local curHp = self.tweenHp
			local color = self:getColor()

			if curHp <= self.oneMaxHp then
				SLFramework.UGUI.GuiHelper.SetColor(self.hp, color[1][1])
				gohelper.setActive(self.bgHpGo, false)

				return
			end

			local rate = curHp / maxHp
			local curThresholdIndex = 1
			local threshold = self:getThreshold()

			for index, thresholdValue in ipairs(threshold) do
				if rate <= thresholdValue then
					curThresholdIndex = index

					break
				end
			end

			local color = self:getColor()

			gohelper.setActive(self.bgHpGo, true)

			local colorList = color[curThresholdIndex]

			SLFramework.UGUI.GuiHelper.SetColor(self.hp, colorList[1])
			SLFramework.UGUI.GuiHelper.SetColor(self.bgHp, colorList[2])
		end
	end
end

function FightViewSurvivalBossHp:clearHpTween()
	if self.hpTweenId then
		ZProj.TweenHelper.KillById(self.hpTweenId)

		self.hpTweenId = nil
	end
end

function FightViewSurvivalBossHp:clearShieldTween()
	if self.shieldTweenId then
		ZProj.TweenHelper.KillById(self.shieldTweenId)

		self.shieldTweenId = nil
	end
end

function FightViewSurvivalBossHp:getThreshold()
	return Threshold
end

function FightViewSurvivalBossHp:getColor()
	return Color
end

function FightViewSurvivalBossHp:_checkBossAndUpdate()
	FightViewSurvivalBossHp.super._checkBossAndUpdate(self)

	if not self._bossEntityMO then
		self:clearShieldTween()
		self:clearHpTween()
	end
end

function FightViewSurvivalBossHp:onAiJiAoFakeDecreaseHp(entityId)
	return
end

function FightViewSurvivalBossHp:onDestroyView()
	self:clearShieldTween()
	self:clearHpTween()
	FightViewSurvivalBossHp.super.onDestroyView(self)
end

return FightViewSurvivalBossHp
