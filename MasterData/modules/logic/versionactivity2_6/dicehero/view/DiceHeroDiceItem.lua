-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroDiceItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDiceItem", package.seeall)

local DiceHeroDiceItem = class("DiceHeroDiceItem", LuaCompBase)

function DiceHeroDiceItem:ctor(param)
	self._index = param.index
end

local rotationDict = {
	Vector3(90, 0, 0),
	Vector3(90, 90, 0),
	Vector3(90, 180, 0),
	Vector3(90, -90, 0),
	Vector3(0, 0, 0),
	(Vector3(180, 0, 0))
}

function DiceHeroDiceItem:init(go)
	self.go = go
	self._anim = gohelper.findChildAnim(go, "")
	self._goselect = gohelper.findChild(go, "#go_select")
	self._imagenum = gohelper.findChildImage(go, "#image_num")
	self._imageicon = gohelper.findChildImage(go, "#simage_dice")
	self._golimitlock = gohelper.findChild(go, "#go_lock")
	self._golock = gohelper.findChild(go, "#go_limitlock")
	self._golight = gohelper.findChild(go, "#go_light")
	self._gogray = gohelper.findChild(go, "#go_gray")
	self._diceRoot = gohelper.findChild(go, "touzi_ani/touzi").transform
	self._uimeshes = self:getUserDataTb_()

	for i = 0, self._diceRoot.childCount - 1 do
		local diceMeshGo = self._diceRoot:GetChild(i).gameObject
		local diceNum = tonumber(diceMeshGo.name) or 1

		self._uimeshes[diceNum] = diceMeshGo:GetComponent(typeof(UIMesh))
	end

	self:_refresh(true)
end

function DiceHeroDiceItem:onStepEnd(isFirst)
	self:_refresh(isFirst)
end

function DiceHeroDiceItem:_refresh(isFirst)
	local diceMo = DiceHeroFightModel.instance:getGameData().diceBox.dices[self._index]

	if diceMo and not diceMo.deleted then
		self:updateInfo(diceMo, isFirst)
	elseif self.diceMo then
		self.diceMo = nil

		self._anim:Play("out")
	else
		self._anim:Play("out", 0, 1)
	end
end

function DiceHeroDiceItem:updateInfo(diceMo, isFirst)
	if (not self.diceMo or self.diceMo.deleted or self.diceMo.uid ~= diceMo.uid) and not DiceHeroFightModel.instance.tempRoundEnd and not isFirst then
		self._anim:Play("in", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
	end

	if self.diceMo then
		DiceHeroHelper.instance:unregisterDice(self.diceMo.uid)
	end

	DiceHeroHelper.instance:registerDice(diceMo.uid, self)

	self.diceMo = diceMo

	local nowRotation = rotationDict[diceMo.num]

	if nowRotation then
		transformhelper.setLocalRotation(self._diceRoot, nowRotation.x, nowRotation.y, nowRotation.z)
	end

	local diceCo = lua_dice.configDict[diceMo.diceId]

	if diceCo then
		local arr = string.splitToNumber(diceCo.suitList, "#")

		for diceNum, uiMesh in pairs(self._uimeshes) do
			local suitCo = lua_dice_suit.configDict[arr[diceNum]]

			if suitCo then
				local texture = DiceHeroHelper.instance:getDiceTexture(suitCo.icon)

				if texture then
					uiMesh.texture = texture

					uiMesh:SetMaterialDirty()
				end
			end
		end
	end

	self:refreshLock()
	self:setSelect(false)
end

function DiceHeroDiceItem:refreshLock()
	gohelper.setActive(self._golock, self.diceMo.status == DiceHeroEnum.DiceStatu.SoftLock)
	gohelper.setActive(self._golimitlock, self.diceMo.status == DiceHeroEnum.DiceStatu.HardLock)
end

function DiceHeroDiceItem:setSelect(isSelect, isCanSelect)
	if self.diceMo then
		local isHardLock = self.diceMo.status == DiceHeroEnum.DiceStatu.HardLock

		gohelper.setActive(self._goselect, isSelect)

		if isCanSelect == nil then
			gohelper.setActive(self._golight, false)
			gohelper.setActive(self._gogray, isHardLock)
		else
			gohelper.setActive(self._golight, isCanSelect)
			gohelper.setActive(self._gogray, not isCanSelect or isHardLock)
		end
	end
end

function DiceHeroDiceItem:markDeleted()
	if not self.diceMo then
		return
	end

	self.diceMo.deleted = true

	self._anim:Play("out", 0, 0)
	self:setSelect(false)
end

function DiceHeroDiceItem:playRefresh(diceMo)
	self.diceMo = diceMo

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
	self._anim:Play("refresh", 0, 0)

	local nowRotationX, nowRotationY, nowRotationZ = transformhelper.getLocalRotation(self._diceRoot)

	ZProj.TweenHelper.DOLocalRotate(self._diceRoot, nowRotationX + math.random(100, 200), nowRotationY + math.random(100, 200), nowRotationZ + math.random(100, 200), 0.2, self._delayTweenRotate, self, nil, EaseType.Linear)
	TaskDispatcher.runDelay(self._refresh, self, 0.6)
end

function DiceHeroDiceItem:_delayTweenRotate()
	local nowRotationX, nowRotationY, nowRotationZ = transformhelper.getLocalRotation(self._diceRoot)

	ZProj.TweenHelper.DOLocalRotate(self._diceRoot, nowRotationX + math.random(100, 200), nowRotationY + math.random(100, 200), nowRotationZ + math.random(100, 200), 0.2, self._delayTweenRotate2, self, nil, EaseType.Linear)
end

function DiceHeroDiceItem:_delayTweenRotate2()
	local nowRotation = rotationDict[self.diceMo.num]

	if nowRotation then
		ZProj.TweenHelper.DOLocalRotate(self._diceRoot, nowRotation.x, nowRotation.y, nowRotation.z, 0.2, nil, nil, nil, EaseType.Linear)
	end
end

function DiceHeroDiceItem:startRoll()
	if not self.diceMo or self.diceMo.deleted then
		self._anim:Play("out", 0, 1)

		return
	end

	self._anim:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
end

function DiceHeroDiceItem:onDestroy()
	TaskDispatcher.cancelTask(self._refresh, self)

	if self.diceMo then
		DiceHeroHelper.instance:unregisterDice(self.diceMo.uid)
	end
end

return DiceHeroDiceItem
