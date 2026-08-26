-- chunkname: @modules/logic/bossrush/view/BossRushFightViewBossHp.lua

module("modules.logic.bossrush.view.BossRushFightViewBossHp", package.seeall)

local BossRushFightViewBossHp = class("BossRushFightViewBossHp", FightViewBossHp)

function BossRushFightViewBossHp:onInitView()
	FightViewBossHp.onInitView(self)

	self._gounlimited = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container/imgHp/#go_unlimited")
	self._imgunlimited = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/mask/container/unlimitedhp")

	local _vxRoot = gohelper.findChild(self._gounlimited, "vx_hp")

	self._vxColor = {
		[BossRushEnum.HpColor.Red] = gohelper.findChild(_vxRoot, "red"),
		[BossRushEnum.HpColor.Orange] = gohelper.findChild(_vxRoot, "orange"),
		[BossRushEnum.HpColor.Yellow] = gohelper.findChild(_vxRoot, "yellow"),
		[BossRushEnum.HpColor.Green] = gohelper.findChild(_vxRoot, "green"),
		[BossRushEnum.HpColor.Blue] = gohelper.findChild(_vxRoot, "blue"),
		[BossRushEnum.HpColor.Purple] = gohelper.findChild(_vxRoot, "purple")
	}
end

function BossRushFightViewBossHp:onOpen()
	self._damage = 0

	self:_resetUnlimitedHp()
	BossRushFightViewBossHp.super.onOpen(self)
end

function BossRushFightViewBossHp:onClose()
	BossRushFightViewBossHp.super.onClose(self)
	self:_resetUnlimitedHp()
end

function BossRushFightViewBossHp:_onHpChange(defender, num)
	BossRushFightViewBossHp.super._onHpChange(self, defender, num)

	if num ~= 0 and self._bossEntityMO and defender.id == self._bossEntityMO.id then
		if self._isUnlimitedHp then
			self._damage = self._damage + num

			self:_checkUnlimitedHp()
		else
			self._damage = 0
		end
	end
end

function BossRushFightViewBossHp:_checkUnlimitedHp()
	local finalHp = self:_getFinalBossHp()
	local index = Mathf.Abs(self._damage / finalHp)

	index = Mathf.Floor(index)

	local residueDamage = Mathf.Abs(self._damage) % finalHp
	local duration = 0.5 / FightModel.instance:getUISpeed()
	local fillAmount = (finalHp - residueDamage) / finalHp

	self._unlimitedFillAmount = fillAmount

	ZProj.TweenHelper.KillByObj(self._imgHp)

	if fillAmount > self._imgHp.fillAmount and self._curShield == 0 then
		local total = self._imgHp.fillAmount + fillAmount
		local time1 = self._imgHp.fillAmount / total * duration

		self._unlimitedTime2 = duration - time1

		ZProj.TweenHelper.DOFillAmount(self._imgHp, 0, time1)

		if self._curShield == 0 then
			ZProj.TweenHelper.KillByObj(self._imgHpShield)

			self._imgHpShield.fillAmount = 0
		end

		TaskDispatcher.cancelTask(self._onEndTween, self)
		TaskDispatcher.runDelay(self._onEndTween, self, time1)
	else
		ZProj.TweenHelper.DOFillAmount(self._imgHp, fillAmount, duration)
		BossRushModel.instance:syncUnlimitedHp(nil, fillAmount)
	end
end

function BossRushFightViewBossHp:_onEndTween()
	local hpFillAmount, shieldFillAmount = self:_getFillAmount()

	if self._unlimitedFillAmount then
		hpFillAmount = self._unlimitedFillAmount

		self:_changeUnlimitedHpColor(self._unlimitedHpNum + 1, self._unlimitedFillAmount)
		ZProj.TweenHelper.KillByObj(self._imgHp)

		self._imgHp.fillAmount = 1

		ZProj.TweenHelper.DOFillAmount(self._imgHp, hpFillAmount, self._unlimitedTime2 or 0.5)
	end

	self:_changeShieldPos(hpFillAmount)
	ZProj.TweenHelper.KillByObj(self._imgHpShield)

	self._imgHpShield.fillAmount = shieldFillAmount
end

function BossRushFightViewBossHp:_updateUI()
	BossRushFightViewBossHp.super._updateUI(self)

	if self._unlimitedHpNum and self._unlimitedHpNum > 0 then
		local finalHp = self:_getFinalBossHp()
		local residueDamage = Mathf.Abs(self._damage) % finalHp
		local residueHp = finalHp - self._curHp

		if self._curHp ~= finalHp - residueDamage then
			self._damage = -(finalHp * self._unlimitedHpNum + residueHp)
		end
	end
end

function BossRushFightViewBossHp:_detectBossMultiHp()
	local info = BossRushModel.instance:getMultiHpInfo()
	local multiHpIdx = info.multiHpIdx
	local multiHpNum = info.multiHpNum

	if not self._hpMultiAni or multiHpIdx == 0 then
		self._hpMultiAni = {}
	end

	gohelper.setActive(self._multiHpRoot, multiHpNum > 1)

	if multiHpNum > 1 then
		self:com_createObjList(self._onMultiHpItemShow, multiHpNum, self._multiHpItemContent, self._multiHpItem)
	end

	gohelper.setActive(self._multiHpItem.gameObject, true)

	local hpunlimited = gohelper.findChild(self._multiHpItem.gameObject, "hp_unlimited")
	local hp = gohelper.findChild(self._multiHpItem.gameObject, "hp")

	gohelper.setActive(hpunlimited, true)
	gohelper.setActive(hp, false)
	self._multiHpItem.transform:SetSiblingIndex(0)

	if not self._lastMultiHpIdx or self._lastMultiHpIdx ~= multiHpIdx then
		self:_oneHpClear(multiHpIdx - multiHpNum + 1)
	end

	self._lastMultiHpIdx = multiHpIdx

	if self._imgHp.fillAmount == 0 then
		ZProj.TweenHelper.KillByObj(self._imgHp)

		self._imgHp.fillAmount = 1
	end
end

local _multiHpAniIdle = "idle"
local _multiHpAniClose = "close"

function BossRushFightViewBossHp:_onMultiHpItemShow(obj, data, index)
	if index == 1 then
		gohelper.setActive(obj, false)
	else
		local info = BossRushModel.instance:getMultiHpInfo()
		local multiHpIdx = info.multiHpIdx
		local multiHpNum = info.multiHpNum
		local image_HPFG1 = gohelper.findChild(obj, "hp")
		local ani = obj:GetComponent(typeof(UnityEngine.Animator))
		local showHp = index <= multiHpNum - multiHpIdx

		if not self._hpMultiAni[index] then
			gohelper.setActive(image_HPFG1, showHp)

			if showHp then
				self._hpMultiAni[index] = _multiHpAniIdle or _multiHpAniClose
			end
		elseif showHp then
			if not _multiHpAniIdle then
				local newAni = _multiHpAniClose

				if self._hpMultiAni[index] ~= newAni then
					self._hpMultiAni[index] = newAni

					ani:Play(self._hpMultiAni[index])
				end
			end
		end
	end
end

function BossRushFightViewBossHp:_changeUnlimitedHpColor(num, fillAmount)
	local topColor, botColor, col = BossRushModel.instance:getUnlimitedTopAndBotHpColor(num)

	SLFramework.UGUI.GuiHelper.SetColor(self._imgHp, topColor)
	SLFramework.UGUI.GuiHelper.SetColor(self._imgunlimited, botColor)

	for i, v in ipairs(self._vxColor) do
		gohelper.setActive(v, i == col)
	end

	BossRushModel.instance:syncUnlimitedHp(num, fillAmount)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnUnlimitedHp, num, fillAmount)
end

function BossRushFightViewBossHp:_oneHpClear(index)
	self._unlimitedHpNum = index

	if self._unlimitedHpNum >= 0 then
		self._isUnlimitedHp = true

		gohelper.setActive(self._gounlimited, true)
		gohelper.setActive(self._imgunlimited.gameObject, true)
	end

	if self._unlimitedHpNum == 0 then
		ZProj.TweenHelper.KillByObj(self._imgHp)

		self._imgHp.fillAmount = 1

		self:_changeUnlimitedHpColor(self._unlimitedHpNum, 1)
	end
end

function BossRushFightViewBossHp:_getFinalBossHp()
	local entityMO = self._bossEntityMO

	if entityMO then
		return (entityMO.attrMO and entityMO.attrMO.hp > 0 or nil) and (entityMO.attrMO.hp or 1)
	end
end

function BossRushFightViewBossHp:_resetUnlimitedHp()
	self._unlimitedHpNum = nil
	self._isUnlimitedHp = nil

	ZProj.TweenHelper.KillByObj(self._imgHp)
	TaskDispatcher.cancelTask(self._onEndTween, self)
	gohelper.setActive(self._gounlimited, false)
	gohelper.setActive(self._imgunlimited, false)
	BossRushModel.instance:resetUnlimitedHp()
end

function BossRushFightViewBossHp:_onMonsterChange(oldEntityMO, newEntityMO)
	BossRushFightViewBossHp.super._onMonsterChange(self, oldEntityMO, newEntityMO)

	if newEntityMO then
		BossRushController.instance:_refreshCurBossHP()
	end
end

return BossRushFightViewBossHp
