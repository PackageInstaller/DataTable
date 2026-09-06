-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/familyhouding/SettlementBossDmage.lua

module("logic.extensions.battlesettlement.view.familyhouding.SettlementBossDmage", package.seeall)

local SettlementBossDmage = class("SettlementBossDmage", BSAnimPlay)

function SettlementBossDmage:buildUI(parent)
	SettlementBossDmage.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._dmageCol = goutil.findChild(parent, "dmageCol"):GetComponent(goutil.Type_RectTransform)
	self._fillImg = goutil.findChild(parent, "dmageCol/fillImg"):GetComponent(goutil.Type_UIImage)
	self._txtDmage = goutil.findChildTextComponent(parent, "dmageCol/txtDmage")
	self._prize = goutil.findChild(parent, "dmageCol/prize")
	self._prize_txt = goutil.findChildTextComponent(parent, "dmageCol/prize/txt")

	GameUtil.SetActive(self._parent, false)
end

function SettlementBossDmage:onEnter(totalHeight, curPosY, delayTime, curDmage, maxDmage, prizeLevel)
	SettlementBossDmage.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	GameUtil.SetActive(self._parent, true)

	curDmage = checknumber(curDmage)
	maxDmage = checknumber(maxDmage)
	self._fillImg.fillAmount = maxDmage == 0 and 0 or curDmage / maxDmage
	self._txtDmage.text = string.format("%s / %s", curDmage, maxDmage)
	self._prize_txt.text = prizeLevel

	return self:getNextData(true)
end

function SettlementBossDmage:onExit()
	self._isEntered = false

	GameUtil.SetActive(self._parent, true)
end

function SettlementBossDmage:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementBossDmage:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementBossDmage:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function SettlementBossDmage:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)
	Framework.TransformUtil.SetAnchoredPos(self._dmageCol, 1500, 0)
	self._dmageCol:DOAnchorPosX(0, curTime):SetDelay(curDelay + self._delayTime1)
end

function SettlementBossDmage:doKillTween()
	SettlementBossDmage.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._dmageCol:DOKill(true)
end

function SettlementBossDmage:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._dmageCol, 0, 0)
end

return SettlementBossDmage
