-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneGameFloatComp.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneGameFloatComp", package.seeall)

local HedoneGameFloatComp = class("HedoneGameFloatComp", LuaCompBase)

function HedoneGameFloatComp:init(go)
	self._go = go
	self._trans = self._go.transform
	self._goFloatItem = gohelper.findChild(go, "#go_floatItem")
	self._floatItemPool = {}
	self._usingFloatItemDict = {}
	self._accumulateTime = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.FloatAccumulateTime, false, true)
	self._accumulatedDamage = 0
	self._accumulatedIsCrit = false
	self._isTimerRunning = false
end

function HedoneGameFloatComp:showFloat(floatNum, isCrit)
	if not floatNum then
		return
	end

	self._accumulatedDamage = self._accumulatedDamage + floatNum
	self._accumulatedIsCrit = self._accumulatedIsCrit or isCrit

	if not self._isTimerRunning then
		self._isTimerRunning = true

		TaskDispatcher.runDelay(self._onAccumulateTimeout, self, self._accumulateTime)
	end
end

function HedoneGameFloatComp:setPosition(x, y)
	if not x or not y then
		return
	end

	transformhelper.setLocalPos(self._trans, x, y, 0)
end

function HedoneGameFloatComp:_onAccumulateTimeout()
	self._isTimerRunning = false

	local damage = self._accumulatedDamage
	local isCrit = self._accumulatedIsCrit

	self._accumulatedDamage = 0
	self._accumulatedIsCrit = false

	self:_doShowFloat(damage, isCrit)
end

function HedoneGameFloatComp:_doShowFloat(floatNum, isCrit)
	local floatItem = self:_getFloatItem()

	if not floatItem then
		return
	end

	floatItem.txt.text = floatNum

	recthelper.setAnchorX(floatItem.transCrit, isCrit and 0 or HedoneGameEnum.Const.DisablePos)

	floatItem.txtCanvasGroup.alpha = 1

	floatItem.animatorPlayer:Play(UIAnimationName.Open, self._onPlayAnimaFinish, {
		self = self,
		floatItem = floatItem
	})

	self._usingFloatItemDict[floatItem] = true
end

function HedoneGameFloatComp:_getFloatItem()
	if #self._floatItemPool > 0 then
		return table.remove(self._floatItemPool)
	end

	local go = gohelper.cloneInPlace(self._goFloatItem, "floatItem")

	if gohelper.isNil(go) then
		return
	end

	local floatItem = self:getUserDataTb_()

	floatItem.go = go
	floatItem.trans = go.transform
	floatItem.txt = gohelper.findChildText(go, "#txt_float")
	floatItem.txtCanvasGroup = gohelper.onceAddComponent(floatItem.txt.gameObject, gohelper.Type_CanvasGroup)

	local goCrit = gohelper.findChild(go, "#txt_float/#go_crit")

	floatItem.transCrit = goCrit.transform

	recthelper.setAnchorX(floatItem.transCrit, HedoneGameEnum.Const.DisablePos)

	floatItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(go)

	return floatItem
end

function HedoneGameFloatComp._onPlayAnimaFinish(params)
	if not params then
		return
	end

	local self = params.self
	local floatItem = params.floatItem

	self:_recycleFloatItem(floatItem)
end

function HedoneGameFloatComp:_recycleFloatItem(floatItem)
	if not floatItem then
		return
	end

	floatItem.txtCanvasGroup.alpha = 0

	if not self._usingFloatItemDict[floatItem] then
		return
	end

	self._usingFloatItemDict[floatItem] = nil
	self._floatItemPool[#self._floatItemPool + 1] = floatItem
end

function HedoneGameFloatComp:recycleAllFloatItem()
	if self._isTimerRunning then
		TaskDispatcher.cancelTask(self._onAccumulateTimeout, self)

		self._isTimerRunning = false
	end

	self._accumulatedDamage = 0
	self._accumulatedIsCrit = false

	for floatItem, _ in pairs(self._usingFloatItemDict) do
		self:_recycleFloatItem(floatItem)
	end
end

function HedoneGameFloatComp:getGO()
	return self._go
end

function HedoneGameFloatComp:onDestroy()
	self:recycleAllFloatItem()
end

return HedoneGameFloatComp
