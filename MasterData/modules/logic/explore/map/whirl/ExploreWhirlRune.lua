-- chunkname: @modules/logic/explore/map/whirl/ExploreWhirlRune.lua

module("modules.logic.explore.map.whirl.ExploreWhirlRune", package.seeall)

local ExploreWhirlRune = class("ExploreWhirlRune", ExploreWhirlBase)
local addY = -0.1
local flyToTime1 = 0.47
local flyToTime2 = 0.03
local flyToTime = flyToTime1 + flyToTime2
local flyBackTime1 = 0.03
local flyBackTime2 = 0.47
local flyBackTime = flyBackTime1 + flyBackTime2
local flyToAnimLen = 1
local flyBackAnimLen = 1
local delayActiveRuneTime = 1
local activeRuneUnitStayTime = 0.4
local activeRuneUnitBackTime = activeRuneUnitStayTime + 0.6
local flyAnimPer = 0.5

function ExploreWhirlRune:onInit()
	self._resPath = "modules/explore/zj_01/jiaohu/prefabs/zj_01_jh_mfdj_01.prefab"

	self.trans:SetParent(ExploreController.instance:getMap():getHero().trans, false)
end

function ExploreWhirlRune:initComponents()
	return
end

function ExploreWhirlRune:flyToPos(isHigh, callback, callObj)
	if not self._runeTrans then
		callback(callObj)

		return
	end

	local hero = ExploreController.instance:getMap():getHero()

	self._toDir = hero.dir
	self._isHigh = isHigh
	self._tweenEndCallBack = callback
	self._tweenEndCallObj = callObj

	local prePos = self._runeTrans.position
	local preEulerAngles = self._runeTrans.eulerAngles
	local pos = hero:getPos():Clone()

	self._anim:Play("active", 0, flyAnimPer)
	self._anim:Update(0)

	self._prePos = self._runeTrans.position
	self._preEulerAngles = self._runeTrans.eulerAngles

	self._anim:Play(self:getFlyAnimName(), 0, 0)
	self._anim:Update(0)

	local eulerAngles = self._runeTrans.eulerAngles

	pos.y = self._runeTrans.position.y
	self._anim.enabled = false
	self._runeTrans.eulerAngles = preEulerAngles
	self._runeTrans.position = prePos

	local centerPos = (self._prePos + pos) / 2

	centerPos.y = pos.y + addY

	ZProj.TweenHelper.DOMove(self._runeTrans, centerPos.x, centerPos.y, centerPos.z, flyToTime1, self.onTweenPos, self, pos, EaseType.Linear)

	self._tweenId2 = ZProj.TweenHelper.DORotate(self._runeTrans, eulerAngles.x, eulerAngles.y, eulerAngles.z, flyToTime, self.onTweenEnd, self, nil, EaseType.Linear)
end

function ExploreWhirlRune:onTweenPos(pos)
	ZProj.TweenHelper.DOMove(self._runeTrans, pos.x, pos.y, pos.z, flyToTime2, nil, nil, nil, EaseType.Linear)
end

function ExploreWhirlRune:onTweenEnd()
	self._tweenId = nil
	self._tweenId2 = nil
	self._anim.enabled = true

	self._anim:Play(self:getFlyAnimName(), 0, 0)
	TaskDispatcher.runDelay(self.onAnimEnd, self, flyToAnimLen)
end

function ExploreWhirlRune:getFlyAnimName()
	return self:getDirStr()
end

function ExploreWhirlRune:getDirStr()
	if self._toDir == 0 then
		return "up"
	elseif self._toDir == 90 then
		return "right"
	elseif self._toDir == 180 then
		return "down"
	else
		return "left"
	end
end

function ExploreWhirlRune:onAnimEnd()
	if self._isHigh then
		self._tweenEndCallBack(self._tweenEndCallObj)

		self._tweenEndCallBack = nil
		self._tweenEndCallObj = nil
	else
		gohelper.setActive(self._effect2, false)
		gohelper.setActive(self._effect2, true)
		TaskDispatcher.runDelay(self._delayPlayRuneUnitAnim, self, activeRuneUnitStayTime)
		TaskDispatcher.runDelay(self.flyBack, self, activeRuneUnitBackTime)
	end
end

function ExploreWhirlRune:_delayPlayRuneUnitAnim()
	self._tweenEndCallBack(self._tweenEndCallObj)

	self._tweenEndCallBack = nil
	self._tweenEndCallObj = nil
end

function ExploreWhirlRune:flyBack()
	gohelper.setActive(self._activeRoot, true)

	if self._isHigh then
		gohelper.setActive(self._effect1, false)
		gohelper.setActive(self._effect1, true)
		AudioMgr.instance:trigger(AudioEnum.Explore.ActiveRune)
		TaskDispatcher.runDelay(self._delayShowActiveEffect, self, delayActiveRuneTime)
	else
		self:_delayShowActiveEffect()
	end
end

function ExploreWhirlRune:_delayShowActiveEffect()
	gohelper.setActive(self._activeRoot2, true)
	gohelper.setActive(self._normalRoot, false)

	self._anim.enabled = true

	self._anim:Play(string.format("back_%s", self:getDirStr()), 0, 0)
	TaskDispatcher.runDelay(self.onBackAnimEnd, self, flyBackAnimLen)
end

function ExploreWhirlRune:onBackAnimEnd()
	self._anim.enabled = false

	if not self._prePos then
		self:onTweenEnd2()

		return
	end

	local pos = self._runeTrans.position
	local centerPos = (self._prePos + pos) / 2

	centerPos.y = pos.y + addY

	ZProj.TweenHelper.DOMove(self._runeTrans, centerPos.x, centerPos.y, centerPos.z, flyBackTime1, self.onTweenPos2, self, self._prePos, EaseType.Linear)

	self._tweenId2 = ZProj.TweenHelper.DORotate(self._runeTrans, self._preEulerAngles.x, self._preEulerAngles.y, self._preEulerAngles.z, flyBackTime, self.onTweenEnd2, self, nil, EaseType.Linear)
	self._prePos = nil
end

function ExploreWhirlRune:onTweenPos2(pos)
	ZProj.TweenHelper.DOMove(self._runeTrans, pos.x, pos.y, pos.z, flyBackTime2, nil, nil, nil, EaseType.Linear)
end

function ExploreWhirlRune:onTweenEnd2()
	self._anim.enabled = true
	self._tweenId = nil
	self._tweenId2 = nil

	self._anim:Play("active", 0, flyAnimPer)
	ExploreModel.instance:setStepPause(false)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Rune)
end

function ExploreWhirlRune:onResLoaded()
	self._anim = gohelper.findChildComponent(self._displayGo, "zj_01_jh_mfdj_01/root", typeof(UnityEngine.Animator))

	local runeGo = gohelper.findChild(self._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan")

	self._runeTrans = runeGo.transform
	self._normalRoot = gohelper.findChild(self._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/normal")
	self._activeRoot = gohelper.findChild(self._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect")
	self._activeRoot2 = gohelper.findChild(self._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/emissive")
	self._effect1 = gohelper.findChild(self._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect_jihuo")
	self._effect2 = gohelper.findChild(self._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect_fanjihuo")

	gohelper.setActive(self._effect1, false)
	gohelper.setActive(self._effect2, false)
	self:checkActive()
end

function ExploreWhirlRune:checkActive()
	local runeItemNO = ExploreBackpackModel.instance:getItemMoByEffect(ExploreEnum.ItemEffect.Active)

	if not runeItemNO then
		return
	end

	local itemStatus = runeItemNO.status
	local isActive = ExploreEnum.RuneStatus.Active == itemStatus

	gohelper.setActive(self._activeRoot, isActive)
	gohelper.setActive(self._activeRoot2, isActive)
	gohelper.setActive(self._normalRoot, not isActive)
end

function ExploreWhirlRune:destroy()
	TaskDispatcher.cancelTask(self.onAnimEnd, self)
	TaskDispatcher.cancelTask(self.onBackAnimEnd, self)
	TaskDispatcher.cancelTask(self._delayShowActiveEffect, self)
	TaskDispatcher.cancelTask(self._delayPlayRuneUnitAnim, self)
	TaskDispatcher.cancelTask(self.flyBack, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._tweenId2 then
		ZProj.TweenHelper.KillById(self._tweenId2)

		self._tweenId2 = nil
	end

	if self._runeTrans then
		ZProj.TweenHelper.KillByObj(self._runeTrans)

		self._runeTrans = nil
	end

	self._tweenEndCallBack = nil
	self._tweenEndCallObj = nil
	self._anim = nil
	self._activeRoot = nil
	self._activeRoot2 = nil

	ExploreModel.instance:setStepPause(false)
	ExploreWhirlRune.super.destroy(self)
end

return ExploreWhirlRune
