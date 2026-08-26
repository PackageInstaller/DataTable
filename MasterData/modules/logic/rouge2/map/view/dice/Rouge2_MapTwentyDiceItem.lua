-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapTwentyDiceItem.lua

local Rouge2_MapTwentyDiceItem = class("Rouge2_MapTwentyDiceItem", LuaCompBase)

Rouge2_MapTwentyDiceItem.rotationDict = {
	Vector3(175, 0, 0),
	Vector3(-45, 0, -60),
	Vector3(-232.5, 35, -60),
	Vector3(-56, 40, 175),
	Vector3(-235, 36.8, 180),
	Vector3(-60, 45, -70),
	Vector3(135, 0, 60),
	Vector3(225, 180, 0),
	Vector3(60.5, -135, -110),
	Vector3(-124.2, -140.8, -124.4),
	Vector3(54.8, 140.8, -124.4),
	Vector3(-119.5, 135, -110),
	Vector3(45, -180, 0),
	Vector3(-45, 0, 60),
	Vector3(-240, -45, -70),
	Vector3(-55, -36.8, 180),
	Vector3(124, -40, 175),
	Vector3(-52, -36, -60),
	Vector3(135, 0, -60),
	(Vector3(0, 0, 0))
}
Rouge2_MapTwentyDiceItem.rotationNum = tabletool.len(Rouge2_MapTwentyDiceItem.rotationDict)

function Rouge2_MapTwentyDiceItem:ctor(parent)
	self._parent = parent
end

function Rouge2_MapTwentyDiceItem:init(go)
	self.go = go
	self._rawImage = gohelper.findChildComponent(self.go, "image_icon", gohelper.Type_RawImage)
	self._goroot = gohelper.findChild(self.go, "go_root")
	self._gomodel = self._parent:getResInst(self._parent.viewContainer._viewSetting.otherRes[1], self._goroot)
	self._gorotation = gohelper.findChild(self._gomodel, "#go_rotation/rotation1/position/rotation/v3a2_ui_touzi_1")
	self._tranrotation = self._gorotation.transform
	self._goanimator = gohelper.findChild(self._gomodel, "#go_rotation")
	self._animator = gohelper.onceAddComponent(self._goanimator, gohelper.Type_Animator)
	self._gocamera = gohelper.findChild(self._gomodel, "#go_camera")
	self._camera = self._gocamera:GetComponent("Camera")

	local width = recthelper.getWidth(self._rawImage.transform)
	local height = recthelper.getHeight(self._rawImage.transform)

	self._rt = UnityEngine.RenderTexture.GetTemporary(width, height, 0, UnityEngine.RenderTextureFormat.ARGB32)
	self._camera.targetTexture = self._rt
	self._rawImage.texture = self._rt
end

function Rouge2_MapTwentyDiceItem:addEventListeners()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnJumpFinishDice, self._onJumpFinishDice, self)
end

function Rouge2_MapTwentyDiceItem:initInfo(diceInfo)
	self._diceId = diceInfo[1]
	self._randomIndex = diceInfo[2]
	self._animator.enabled = false

	self:initRotation()
	self:setUse(true)
end

function Rouge2_MapTwentyDiceItem:initRotation()
	local randomIndex = math.random(1, Rouge2_MapTwentyDiceItem.rotationNum)

	if not self._lastRandomIndex then
		local targetRandomIndex = randomIndex
		local rotation = Rouge2_MapTwentyDiceItem.rotationDict[targetRandomIndex]

		if not rotation then
			return
		end

		transformhelper.setLocalRotation(self._tranrotation, rotation.x, rotation.y, rotation.z)
	end
end

function Rouge2_MapTwentyDiceItem:dice()
	if not self._isUse then
		return
	end

	if not Rouge2_MapTwentyDiceItem.rotationDict[self._randomIndex] then
		local rotation = Vector3.zero

		self._rotateTweenId = ZProj.TweenHelper.DOLocalRotate(self._tranrotation, rotation.x, rotation.y, rotation.z, 0.2, self._delayTweenRotate, self, nil, EaseType.Linear)
		self._lastRandomIndex = self._randomIndex
	end
end

function Rouge2_MapTwentyDiceItem:forceSet()
	self._animator.enabled = false

	if not Rouge2_MapTwentyDiceItem.rotationDict[self._randomIndex] then
		transformhelper.setLocalRotation(self._tranrotation, Rouge2_MapTwentyDiceItem.rotationDict[self._randomIndex].x, Rouge2_MapTwentyDiceItem.rotationDict[self._randomIndex].y, Rouge2_MapTwentyDiceItem.rotationDict[self._randomIndex].z)
	end
end

function Rouge2_MapTwentyDiceItem:_delayTweenRotate()
	self._animator.enabled = true

	self._animator:Play("interaction", 0, 0)
end

function Rouge2_MapTwentyDiceItem:setUse(isUse)
	self._isUse = isUse

	gohelper.setActive(self.go, isUse)
end

function Rouge2_MapTwentyDiceItem:_onJumpFinishDice()
	if not self._isUse then
		return
	end

	local rotation = Rouge2_MapTwentyDiceItem.rotationDict[self._randomIndex]

	if not rotation then
		return
	end

	self:killTween()

	self._animator.enabled = true

	self._animator:Play("interaction", 0, 1)
	transformhelper.setLocalRotation(self._tranrotation, rotation.x, rotation.y, rotation.z)
end

function Rouge2_MapTwentyDiceItem:killTween()
	if self._rotateTweenId then
		ZProj.TweenHelper.KillById(self._rotateTweenId)

		self._rotateTweenId = nil
	end
end

function Rouge2_MapTwentyDiceItem:onDestroy()
	if self._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
		self._rawImage.texture = nil
		self._camera.targetTexture = nil
	end

	self._camera = nil

	self:killTween()
end

return Rouge2_MapTwentyDiceItem
