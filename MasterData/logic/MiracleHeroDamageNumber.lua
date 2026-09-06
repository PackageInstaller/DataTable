-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroDamageNumber.lua

module("logic.extensions.miraclehero.view.MiracleHeroDamageNumber", package.seeall)

local MiracleHeroDamageNumber = class("MiracleHeroDamageNumber")

function MiracleHeroDamageNumber:ctor(componetContainer)
	self._container = componetContainer
	self._hudText = self._container:GetComponent("SpringHUDText")
	self._hudText.tweenScale = false
end

function MiracleHeroDamageNumber:initCell(numObj, type)
	self._numObj = numObj
	self._imageNum = self._numObj:GetComponent("UIImgNumeralText")
	self._imageNum.manual = true
	self._hudTransform = self._imageNum.transform
	self._type = type
end

function MiracleHeroDamageNumber:setValue(num)
	self.damage = math.floor(num)

	self._imageNum:SetText(self.damage)
end

function MiracleHeroDamageNumber:start(obj)
	local txt = tostring(self.damage)

	if self.isTreated or self.damage > 0 then
		txt = "+" .. txt
	end

	self._imageNum:SetText(txt)
	self._hudText:SetDelayTimeout(self.isLast and 0.5 or -1)
	self._hudText:StartSpring()
	self:_prepareTween()
	self:_appear(0)
	GameUtil.SetActive(self._container, true)

	self.targetObj = obj
	self.isInit = false
end

function MiracleHeroDamageNumber:isDone()
	return self._hudText:IsStop() and self._currIndex > self._activeCount
end

function MiracleHeroDamageNumber:update(deltaTime)
	self._time = self._time + deltaTime

	if self._time >= 0.05 and self._currIndex <= self._activeCount then
		self._time = self._time - 0.05
		self._currIndex = self._currIndex + 1

		if self._currIndex < self._activeCount then
			self:_appear(self._currIndex)
		end
	end

	if not self.isInit then
		local pos = GameUtil.getLocalPos(self.targetObj)

		GameUtil.setLocalPos(self._container, pos.x, pos.y, pos.z)

		self.isInit = true
	end
end

function MiracleHeroDamageNumber:_prepareTween()
	self._activeCount = self._imageNum.Count
	self._currIndex = 0
	self._time = 0

	for i = 0, self._activeCount - 1 do
		self._hudTransform:GetChild(i).gameObject:SetActive(false)
	end
end

function MiracleHeroDamageNumber:_appear(i)
	local go = self._hudTransform:GetChild(i).gameObject
	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, nil, nil, nil)
	local sy = math.random(-40, 40)

	UnityTweens.TweenPosition.StartTween(go, Vector3.New(x, sy, z), Vector3.New(x, y, z), 0.2, UnityTweens.EaseType.easeInOutBack)
	go:SetActive(true)
end

function MiracleHeroAttrCell:onDestroy()
	goutil.destroy(self._container.gameObject)
end

return MiracleHeroDamageNumber
