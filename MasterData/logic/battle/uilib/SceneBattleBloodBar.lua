-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/SceneBattleBloodBar.lua

module("logic.battle.uilib.SceneBattleBloodBar", package.seeall)

local M = class("SceneBattleBloodBar")
local kMinFill = 0.489
local kMaxFill = 0.896

function M:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function M:reset()
	self:setVisible(true)
	self:setMask(false)
	self:_clearAnim()
end

function M:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function M:buildUI()
	self._selfBloodGo = goutil.findChild(self.mainGO, "xuetiao/xuetiao_lan")
	self._friendBloodGo = goutil.findChild(self.mainGO, "xuetiao/xuetiao_huang")
	self._enemyBloodGo = goutil.findChild(self.mainGO, "xuetiao/xuetiao_hong")
	self._forecastCureGo = goutil.findChild(self.mainGO, "xuetiao/xuetiao_yujia")
	self._forecastDamageGo = goutil.findChild(self.mainGO, "xuetiao/xuetiao_yukou")
	self._forecastDoubleDamageGo = goutil.findChild(self.mainGO, "xuetiao/xuetiao_yukou_double")
	self._maskGo = goutil.findChild(self.mainGO, "xuetiao/mask")
	self._selfCircleBlood = self._selfBloodGo:GetComponent(typeof(SpaceX.SceneCircleBlood))
	self._friendCircleBlood = self._friendBloodGo:GetComponent(typeof(SpaceX.SceneCircleBlood))
	self._enemyCircleBlood = self._enemyBloodGo:GetComponent(typeof(SpaceX.SceneCircleBlood))
	self._forecastCureCircleBlood = self._forecastCureGo:GetComponent(typeof(SpaceX.SceneCircleBlood))
	self._forecastDamageCircleBlood = self._forecastDamageGo:GetComponent(typeof(SpaceX.SceneCircleBlood))
	self._forecastDoubleDamageCircleBlood = self._forecastDoubleDamageGo:GetComponent(typeof(SpaceX.SceneCircleBlood))
	self._maskCircleBlood = self._maskGo:GetComponent(typeof(SpaceX.SceneCircleBlood))
	self._forecastCureAnim = self._forecastCureGo:GetComponent(ComponentType.Animation)
	self._forecastDamageAnim = self._forecastDamageGo:GetComponent(ComponentType.Animation)
	self._forecastDoubleDamageAnim = self._forecastDoubleDamageGo:GetComponent(ComponentType.Animation)
end

function M:setVisible(status)
	goutil.setActive(self.mainGO, status)
end

function M:destroyUI()
	self:_clearAnim()
end

function M:setBlood(hpPercent)
	self._hpPercent = hpPercent

	self:clearForecast()

	self._curShowBloodPercent = hpPercent

	self:_setBlood(hpPercent)
end

function M:setActiveBloodBar(relationType)
	if relationType == BattleEnum.CampRelation.SAME then
		self._activeCircleBlood = self._selfCircleBlood

		goutil.setActive(self._selfBloodGo, true)
		goutil.setActive(self._friendBloodGo, false)
		goutil.setActive(self._enemyBloodGo, false)
	elseif relationType == BattleEnum.CampRelation.FRIEND or relationType == BattleEnum.CampRelation.NORMAL then
		self._activeCircleBlood = self._friendCircleBlood

		goutil.setActive(self._selfBloodGo, false)
		goutil.setActive(self._friendBloodGo, true)
		goutil.setActive(self._enemyBloodGo, false)
	elseif relationType == BattleEnum.CampRelation.ENEMY then
		self._activeCircleBlood = self._enemyCircleBlood

		goutil.setActive(self._selfBloodGo, false)
		goutil.setActive(self._friendBloodGo, false)
		goutil.setActive(self._enemyBloodGo, true)
	end
end

function M:forecast(hpPercent, forecastHpPercent, isDouble)
	hpPercent = hpPercent and hpPercent or self._hpPercent

	local isCure = hpPercent < forecastHpPercent

	if isCure then
		goutil.setActive(self._forecastCureGo, true)
		goutil.setActive(self._forecastDamageGo, false)
		goutil.setActive(self._forecastDoubleDamageGo, false)
		BattleSynAnimUtil.playAnimSyn(self._forecastCureAnim, "xuetiao_loop")
		self:_setBlood(hpPercent)
		self:_setCircleBlood(self._forecastCureCircleBlood, hpPercent, forecastHpPercent)
	else
		goutil.setActive(self._forecastCureGo, false)
		goutil.setActive(self._forecastDamageGo, true)
		goutil.setActive(self._forecastDoubleDamageGo, isDouble)
		BattleSynAnimUtil.playAnimSyn(self._forecastDamageAnim, "xuetiao_loop")
		self:_setBlood(forecastHpPercent)

		if isDouble then
			local halfHp = (hpPercent - forecastHpPercent) / 2

			self:_setCircleBlood(self._forecastDamageCircleBlood, hpPercent - halfHp, hpPercent)
			self:_setCircleBlood(self._forecastDoubleDamageCircleBlood, forecastHpPercent, forecastHpPercent + halfHp)
			BattleSynAnimUtil.playAnimSyn(self._forecastDoubleDamageAnim, "xuetiao_loop1")
		else
			self:_setCircleBlood(self._forecastDamageCircleBlood, forecastHpPercent, hpPercent)
		end
	end
end

function M:clearForecast()
	goutil.setActive(self._forecastCureGo, false)
	goutil.setActive(self._forecastDamageGo, false)
	goutil.setActive(self._forecastDoubleDamageGo, false)
	self:_clearAnim()
end

function M:_clearAnim()
	BattleSynAnimUtil.stopAnim(self._forecastCureAnim)
	BattleSynAnimUtil.stopAnim(self._forecastDamageAnim)
	BattleSynAnimUtil.stopAnim(self._forecastDoubleDamageAnim)
	DG.Tweening.DOTween.Kill(self.mainGO, true)
end

function M:_setBlood(hpPercent)
	self:_setCircleBlood(self._activeCircleBlood, 0, hpPercent)
	self:_setCircleBlood(self._maskCircleBlood, 0, hpPercent)
end

function M:_getFillNumByPercent(p)
	return kMinFill + (kMaxFill - kMinFill) * p
end

function M:_setCircleBlood(circleBlood, p1, p2)
	circleBlood:SetFromFillAndToFill(self:_getFillNumByPercent(p1), self:_getFillNumByPercent(p2))
end

function M:setPlaySpeed(speed)
	AnimationUtils.SetPlaySpeed(self._forecastCureAnim, speed)
	AnimationUtils.SetPlaySpeed(self._forecastDamageAnim, speed)
	AnimationUtils.SetPlaySpeed(self._forecastDoubleDamageAnim, speed)
end

function M:doBloodBarTween(hpPercent, time)
	if self._hpPercent == hpPercent then
		return
	end

	DG.Tweening.DOTween.Kill(self.mainGO, false)

	local lastBloodPercent = self._curShowBloodPercent

	self._hpPercent = hpPercent

	local tweenTime = time and time or 0.5

	self._tweener = DoTweenUtil.To(0, tweenTime, tweenTime, function(time)
		local progress = time / tweenTime

		self._curShowBloodPercent = lastBloodPercent + progress * (hpPercent - lastBloodPercent)

		self:_setBlood(self._curShowBloodPercent)
	end)

	self._tweener:OnComplete(function()
		self:_onCompleteTweener()
	end)
	self._tweener:SetTarget(self.mainGO)
end

function M:_onCompleteTweener()
	return
end

function M:setMask(isMask)
	goutil.setActive(self._maskGo, isMask)
end

return M
