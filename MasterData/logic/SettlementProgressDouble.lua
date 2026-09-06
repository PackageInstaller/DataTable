-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementProgressDouble.lua

module("logic.extensions.battlesettlement.view.SettlementProgressDouble", package.seeall)

local SettlementProgressDouble = class("SettlementProgressDouble", BSAnimPlay)

function SettlementProgressDouble:buildUI(parent)
	SettlementProgressDouble.super.buildUI(self, parent)

	self._txtTitle = goutil.findChildTextComponent(parent, "imgBgTarget/Text")
	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._txtProgressA = goutil.findChildTextComponent(parent, "imgBgTarget/txtProgressA")
	self._fillImgA = goutil.findChild(parent, "imgBgTarget/fillImgA"):GetComponent(goutil.Type_UIImage)
	self._txtProgressB = goutil.findChildTextComponent(parent, "imgBgTarget/txtProgressB")
	self._fillImgB = goutil.findChild(parent, "imgBgTarget/fillImgB"):GetComponent(goutil.Type_UIImage)

	goutil.setActive(self._parent, false)
end

function SettlementProgressDouble:onEnter(totalHeight, curPosY, delayTime, infoA, infoB, title)
	SettlementProgressDouble.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	goutil.setActive(self._parent, true)

	local curNumA = checknumber(infoA.curNum)
	local maxNumA = checknumber(infoA.maxNum)

	self._fillImgA.fillAmount = maxNumA == 0 and 0 or curNumA / maxNumA

	if infoA.color then
		self._fillImgA.color = GameUtil.getColorByHexColor(infoA.color)
	end

	self._txtProgressA.text = string.format("%s%s/%s", infoA.progressStr, curNumA, maxNumA)

	local curNumB = checknumber(infoB.curNum)
	local maxNumB = checknumber(infoB.maxNum)

	self._fillImgB.fillAmount = maxNumB == 0 and 0 or curNumB / maxNumB

	if infoB.color then
		self._fillImgB.color = GameUtil.getColorByHexColor(infoB.color)
	end

	self._txtProgressB.text = string.format("%s%s/%s", infoB.progressStr, curNumB, maxNumB)

	if not string.nilorempty(title) then
		self._txtTitle.text = title
	end

	return self:getNextData(true)
end

function SettlementProgressDouble:onExit()
	self._isEntered = false

	goutil.setActive(self._parent, false)
end

function SettlementProgressDouble:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementProgressDouble:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementProgressDouble:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function SettlementProgressDouble:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function SettlementProgressDouble:doKillTween()
	SettlementProgressDouble.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
end

function SettlementProgressDouble:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
end

return SettlementProgressDouble
