-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementProgress.lua

module("logic.extensions.battlesettlement.view.SettlementProgress", package.seeall)

local SettlementProgress = class("SettlementProgress", BSAnimPlay)

function SettlementProgress:buildUI(parent)
	SettlementProgress.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._txtTitle = goutil.findChildTextComponent(parent, "imgBgTarget/Text")
	self._txtProgress = goutil.findChildTextComponent(parent, "imgBgTarget/txtProgress")
	self._fillImg = goutil.findChild(parent, "imgBgTarget/fillImg"):GetComponent(goutil.Type_UIImage)

	goutil.setActive(self._parent, false)
end

function SettlementProgress:onEnter(totalHeight, curPosY, delayTime, curNum, maxNum, progressStr)
	SettlementProgress.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	goutil.setActive(self._parent, true)

	curNum = checknumber(curNum)
	maxNum = checknumber(maxNum)
	self._fillImg.fillAmount = maxNum == 0 and 0 or curNum / maxNum
	self._txtProgress.text = string.format("%s%s/%s", progressStr, curNum, maxNum)

	return self:getNextData(true)
end

function SettlementProgress:onExit()
	self._isEntered = false

	goutil.setActive(self._parent, false)
end

function SettlementProgress:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementProgress:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementProgress:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function SettlementProgress:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function SettlementProgress:doKillTween()
	SettlementProgress.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
end

function SettlementProgress:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
end

return SettlementProgress
