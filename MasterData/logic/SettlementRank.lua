-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementRank.lua

module("logic.extensions.battlesettlement.view.SettlementRank", package.seeall)

local SettlementRank = class("SettlementRank", BSAnimPlay)

function SettlementRank:buildUI(parent)
	SettlementRank.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._node = goutil.findChild(parent, "node"):GetComponent(goutil.Type_RectTransform)
	self._txtLeft = goutil.findChild(parent, "node/txtLeft"):GetComponent(goutil.Type_UIText)
	self._txtRight = goutil.findChild(parent, "node/txtRight"):GetComponent(goutil.Type_UIText)
end

function SettlementRank:onEnter(totalHeight, curPosY, delayTime)
	SettlementRank.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	goutil.setActive(self._parent, true)

	local params = BattleSettlementModel.instance:getParams()
	local enumType = BattleSettlementModel.instance:getType()

	if params and enumType == BattleSettlementModel.Enum.Arena then
		self._txtLeft.text = params.preRank
		self._txtRight.text = params.postRank
	elseif enumType == BattleSettlementModel.Enum.KingArena then
		self._txtLeft.text = checknumber(params.oldRank)
		self._txtRight.text = checknumber(params.newRank)
	else
		self._txtLeft.text = -1
		self._txtRight.text = -1
	end

	return self:getNextData()
end

function SettlementRank:onExit()
	self._isEntered = false

	self:doKillTween()
	goutil.setActive(self._parent, false)
end

function SettlementRank:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementRank:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementRank:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function SettlementRank:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	Framework.TransformUtil.SetAnchoredPos(self._node, 1500, self._node.anchoredPosition.y)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	curDelay = curDelay + self._delayTime1

	self._node:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function SettlementRank:doKillTween()
	SettlementRank.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._node:DOKill(true)
end

function SettlementRank:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._node, 0, self._node.anchoredPosition.y)
end

return SettlementRank
