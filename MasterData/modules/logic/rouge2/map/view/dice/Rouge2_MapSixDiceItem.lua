-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapSixDiceItem.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapSixDiceItem", package.seeall)

local Rouge2_MapSixDiceItem = class("Rouge2_MapSixDiceItem", LuaCompBase)

Rouge2_MapSixDiceItem.rotationDict = {
	Vector3(90, 0, 0),
	Vector3(90, 180, 0),
	Vector3(90, 90, 0),
	Vector3(90, -90, 0),
	Vector3(0, 0, 0),
	(Vector3(180, 0, 0))
}
Rouge2_MapSixDiceItem.rotationNum = tabletool.len(Rouge2_MapSixDiceItem.rotationDict)

local RandomRotationDuration = 1.5
local RandomRotationStep = 0.3
local TargetRotationDuration = 0.2

function Rouge2_MapSixDiceItem:init(go)
	self.go = go
	self._anim = self.go:GetComponent(gohelper.Type_Animator)
	self._goNormal = gohelper.findChild(self.go, "touzi_ani/touzi")
	self._tranNormal = self._goNormal.transform

	self:initRotation()
end

function Rouge2_MapSixDiceItem:addEventListeners()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnJumpFinishDice, self._onJumpFinishDice, self)
end

function Rouge2_MapSixDiceItem:initRotation()
	local randomIndex = math.random(1, Rouge2_MapSixDiceItem.rotationNum)

	if not self._lastRandomIndex then
		local targetRandomIndex = randomIndex
		local rotation = Rouge2_MapSixDiceItem.rotationDict[targetRandomIndex]

		if not rotation then
			return
		end

		self._lastRandomIndex = targetRandomIndex

		transformhelper.setLocalRotation(self._tranNormal, rotation.x, rotation.y, rotation.z)
	end
end

function Rouge2_MapSixDiceItem:initInfo(diceInfo)
	self._diceId = diceInfo[1]
	self._randomIndex = diceInfo[2]

	self:setUse(true)
end

function Rouge2_MapSixDiceItem:dice()
	self._anim.enabled = true

	self._anim:Play("in", 0, 0)
	self._anim:Update(0)
	self:_randomRotation()
	TaskDispatcher.runDelay(self._checkIsTween2Rotation, self, RandomRotationDuration)
end

function Rouge2_MapSixDiceItem:forceSet()
	self._anim.enabled = false

	self:killTween()

	if not Rouge2_MapSixDiceItem.rotationDict[self._randomIndex] then
		transformhelper.setLocalRotation(self._tranNormal, Rouge2_MapSixDiceItem.rotationDict[self._randomIndex].x, Rouge2_MapSixDiceItem.rotationDict[self._randomIndex].y, Rouge2_MapSixDiceItem.rotationDict[self._randomIndex].z)
	end
end

function Rouge2_MapSixDiceItem:_randomRotation()
	local nowRotationX, nowRotationY, nowRotationZ = transformhelper.getLocalRotation(self._tranNormal)

	self._rotateTweenId = ZProj.TweenHelper.DOLocalRotate(self._tranNormal, nowRotationX + math.random(100, 200), nowRotationY + math.random(100, 200), nowRotationZ + math.random(100, 200), RandomRotationStep, self._onRandomRoationDone, self, nil, EaseType.Linear)
end

function Rouge2_MapSixDiceItem:_onRandomRoationDone()
	self:_randomRotation()
end

function Rouge2_MapSixDiceItem:_checkIsTween2Rotation()
	self:killTween()
	self:_delayTweenRotate()
end

function Rouge2_MapSixDiceItem:_delayTweenRotate()
	local nowRotation = Rouge2_MapSixDiceItem.rotationDict[self._randomIndex]

	if nowRotation then
		self._rotateTweenId = ZProj.TweenHelper.DOLocalRotate(self._tranNormal, nowRotation.x, nowRotation.y, nowRotation.z, TargetRotationDuration, nil, nil, nil, EaseType.Linear)
	end
end

function Rouge2_MapSixDiceItem:setUse(isUse)
	self._isUse = isUse

	self:killTween()
	gohelper.setActive(self.go, isUse)
end

function Rouge2_MapSixDiceItem:_onJumpFinishDice()
	if not self._isUse then
		return
	end

	local rotation = Rouge2_MapSixDiceItem.rotationDict[self._randomIndex]

	if not rotation then
		return
	end

	self:killTween()
	self._anim:Play("in", 0, 1)
	transformhelper.setLocalRotation(self._tranNormal, rotation.x, rotation.y, rotation.z)
end

function Rouge2_MapSixDiceItem:killTween()
	if self._rotateTweenId then
		ZProj.TweenHelper.KillById(self._rotateTweenId)

		self._rotateTweenId = nil
	end

	TaskDispatcher.cancelTask(self._checkIsTween2Rotation, self)
end

function Rouge2_MapSixDiceItem:onDestroy()
	self:killTween()
end

return Rouge2_MapSixDiceItem
