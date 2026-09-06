-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementGiveBack.lua

module("logic.extensions.battlesettlement.view.SettlementGiveBack", package.seeall)

local SettlementGiveBack = class("SettlementGiveBack", BSAnimPlay)

function SettlementGiveBack:buildUI(parent)
	SettlementGiveBack.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._node = goutil.findChild(parent, "node"):GetComponent(goutil.Type_RectTransform)
	self._item1 = goutil.findChild(parent, "node/item1")
end

function SettlementGiveBack:onEnter(totalHeight, curPosY, delayTime)
	SettlementGiveBack.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	local isShow = false
	local enumType = BattleSettlementModel.instance:getType()

	if BattleSettlementModel.instance:isGiveBackTili(enumType) then
		local params = BattleSettlementModel.instance:getParams()

		if params and params.giveBackStrength then
			local cfgStr = string.format("%d:%d:%d", MatType.Strength, 1, params.giveBackStrength)

			MaterialMgr.setCellByCfg(cfgStr, self._item1)

			isShow = true
		elseif params and params.giveBackEnergy then
			MaterialMgr.setCellByCfg(params.giveBackEnergy, self._item1)

			isShow = true
		end
	end

	goutil.setActive(self._parent, isShow)

	return self:getNextData(isShow)
end

function SettlementGiveBack:onExit()
	self._isEntered = false

	self:doKillTween()
	goutil.setActive(self._parent, false)
	MaterialMgr.resetAll(self._item1)
end

function SettlementGiveBack:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementGiveBack:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementGiveBack:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function SettlementGiveBack:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	Framework.TransformUtil.SetAnchoredPos(self._node, 1500, self._node.anchoredPosition.y)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	curDelay = curDelay + self._delayTime1

	self._node:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function SettlementGiveBack:doKillTween()
	SettlementGiveBack.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._node:DOKill(true)
end

function SettlementGiveBack:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._node, 0, self._node.anchoredPosition.y)
end

return SettlementGiveBack
