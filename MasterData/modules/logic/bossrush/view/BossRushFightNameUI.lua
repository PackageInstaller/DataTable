-- chunkname: @modules/logic/bossrush/view/BossRushFightNameUI.lua

module("modules.logic.bossrush.view.BossRushFightNameUI", package.seeall)

local BossRushFightNameUI = class("BossRushFightNameUI", FightNameUI)

function BossRushFightNameUI:_onLoaded()
	BossRushFightNameUI.super._onLoaded(self)

	self._topHp = gohelper.findChildImage(self._uiGO, "layout/hp/container/#img_unlimitedtophp")
	self._botHp = gohelper.findChildImage(self._uiGO, "layout/hp/container/#img_unlimitedbothp")

	self:_checkBoss()

	if self.isBoss then
		if self._imgHp then
			gohelper.setActive(self._imgHp.gameObject, false)
		end

		local hpFillAmount = self:_getFillAmount()
		local duration = 0.5 / FightModel.instance:getUISpeed()

		self._imgHp = self._topHp
		self._imgHp.fillAmount = hpFillAmount
		self._unlimitHp = BossRushModel.instance._unlimitHp

		if self._unlimitHp then
			self:_onChangeUnlimitedHpColor(self._unlimitHp.index)
			ZProj.TweenHelper.KillByObj(self._imgHp)

			if hpFillAmount > self._unlimitHp.fillAmount then
				ZProj.TweenHelper.DOFillAmount(self._imgHp, self._unlimitHp.fillAmount, duration)
			else
				self._imgHp.fillAmount = self._unlimitHp.fillAmount
			end

			gohelper.setActive(self._botHp.gameObject, true)
		else
			gohelper.setActive(self._botHp.gameObject, false)
			SLFramework.UGUI.GuiHelper.SetColor(self._topHp, "#9C4F30")
		end

		gohelper.setActive(self._topHp.gameObject, true)
	else
		gohelper.setActive(self._topHp.gameObject, false)
		gohelper.setActive(self._botHp.gameObject, false)
	end

	BossRushController.instance:registerCallback(BossRushEvent.OnUnlimitedHp, self._onUnlimitedHp, self)
end

function BossRushFightNameUI:onDestructor()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnUnlimitedHp, self._onUnlimitedHp, self)
end

function BossRushFightNameUI:_checkBoss()
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]

	if monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) then
		if not monsterGroupCO.bossId then
			local bossId
			local mo = self.entity:getMO()
			local enemyId = mo:getCO().id

			self.isBoss = FightHelper.isBossId(bossId, enemyId)
		end
	end
end

function BossRushFightNameUI:_onChangeUnlimitedHpColor(num)
	if not self.isBoss then
		return
	end

	local topColor, botColor = BossRushModel.instance:getUnlimitedTopAndBotHpColor(num)

	SLFramework.UGUI.GuiHelper.SetColor(self._topHp, topColor)
	SLFramework.UGUI.GuiHelper.SetColor(self._botHp, botColor)
	gohelper.setActive(self._botHp.gameObject, true)
end

function BossRushFightNameUI:_onUnlimitedHp(num, fillAmount)
	if self.isBoss then
		self._unlimitHp = BossRushModel.instance._unlimitHp

		ZProj.TweenHelper.KillByObj(self._imgHp)

		if self._unlimitHp then
			local topFill = self._topHp.fillAmount
			local duration = 0.5 / FightModel.instance:getUISpeed()

			if topFill < topFill then
				self._topHp.fillAmount = 1
			end

			ZProj.TweenHelper.DOFillAmount(self._imgHp, fillAmount, duration)
			self:_onChangeUnlimitedHpColor(num)
			gohelper.setActive(self._botHp.gameObject, true)
		else
			gohelper.setActive(self._botHp.gameObject, false)
		end
	end
end

return BossRushFightNameUI
