-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentLineItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentLineItem", package.seeall)

local Rouge2_BackpackTalentLineItem = class("Rouge2_BackpackTalentLineItem", LuaCompBase)

function Rouge2_BackpackTalentLineItem:init(go)
	self.go = go
	self._goNormalLine = gohelper.findChild(self.go, "go_NormalLine")
	self._goActiveLine = gohelper.findChild(self.go, "go_ActiveLine")
	self._tran = self.go:GetComponent(gohelper.Type_RectTransform)
	self._tranNormalLine = self._goNormalLine:GetComponent(gohelper.Type_RectTransform)
	self._tranActiveLine = self._goActiveLine:GetComponent(gohelper.Type_RectTransform)
	self._imageActiveLine = gohelper.findChildImage(self.go, "go_ActiveLine")
	self._lineWidth = self._tran.sizeDelta.y
	self._sizeDelta = Vector2()
	self._lineAngle = Vector3()
end

function Rouge2_BackpackTalentLineItem:addEventListeners()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
end

function Rouge2_BackpackTalentLineItem:removeEventListeners()
	return
end

function Rouge2_BackpackTalentLineItem:connect(preTalentItem, nextTalentItem)
	gohelper.setActive(self.go, true)
	gohelper.setAsFirstSibling(self.go)

	self._preTalentItem = preTalentItem
	self._nextTalentItem = nextTalentItem
	self._preTalentId = self._preTalentItem:getTalentId()
	self._nextTalentId = self._nextTalentItem:getTalentId()
	self.go.name = string.format("line_%s_%s", self._preTalentId, self._nextTalentId)

	self:refresh()
end

function Rouge2_BackpackTalentLineItem:refresh()
	self:refreshDir()
	self:refreshStatus()
end

function Rouge2_BackpackTalentLineItem:refreshDir()
	local preConnectPos = self._preTalentItem:getConnectPos()
	local nextConnectPos = self._nextTalentItem:getConnectPos()
	local dis = Vector2.Distance(preConnectPos, nextConnectPos)

	self._sizeDelta:Set(dis, self._lineWidth)

	self._tran.sizeDelta = self._sizeDelta

	local linePosX = (preConnectPos.x + nextConnectPos.x) / 2
	local linePosY = (preConnectPos.y + nextConnectPos.y) / 2

	recthelper.setAnchor(self._tran, linePosX, linePosY)
	self._lineAngle:Set(0, 0, self:calcAngle(preConnectPos, nextConnectPos))

	self._tran.localEulerAngles = self._lineAngle
end

function Rouge2_BackpackTalentLineItem:calcAngle(preConnectPos, nextConnectPos)
	local direction = nextConnectPos - preConnectPos
	local angle = Mathf.Atan2(direction.x, direction.y) * Mathf.Rad2Deg

	return -angle + 90
end

function Rouge2_BackpackTalentLineItem:refreshStatus()
	local preTalentStatus = Rouge2_BackpackModel.instance:getTalentStatus(self._preTalentId)
	local nextTalentStatus = Rouge2_BackpackModel.instance:getTalentStatus(self._nextTalentId)
	local isLineActive = preTalentStatus == Rouge2_Enum.BagTalentStatus.Active and nextTalentStatus == Rouge2_Enum.BagTalentStatus.Active

	gohelper.setActive(self._goActiveLine, isLineActive)

	self._preIsLineActive = self._isLineActive
	self._isLineActive = isLineActive

	if self._preIsLineActive == nil then
		self._preIsLineActive = isLineActive
	end

	self:playAnim()
end

function Rouge2_BackpackTalentLineItem:playAnim()
	self:killTween()

	if self._preIsLineActive == self._isLineActive then
		self._imageActiveLine.fillAmount = 1

		return
	end

	local duration = self._sizeDelta.x * Rouge2_Enum.BagTalentLineTweenDuration

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, duration, self._tweenActiveLineFrameCb, nil, self)
end

function Rouge2_BackpackTalentLineItem:_tweenActiveLineFrameCb(value)
	self._imageActiveLine.fillAmount = value
end

function Rouge2_BackpackTalentLineItem:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function Rouge2_BackpackTalentLineItem:reset()
	gohelper.setActive(self.go, false)
end

function Rouge2_BackpackTalentLineItem:_onUpdateRougeInfo()
	self:refreshStatus()
end

function Rouge2_BackpackTalentLineItem:onDestroy()
	self:killTween()
end

return Rouge2_BackpackTalentLineItem
