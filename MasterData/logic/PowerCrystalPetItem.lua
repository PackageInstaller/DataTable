-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalPetItem.lua

module("logic.extensions.powercrystal.PowerCrystalPetItem", package.seeall)

local PowerCrystalPetItem = class("PowerCrystalPetItem")

function PowerCrystalPetItem:ctor(go)
	self.model = PowerCrystalModel.instance
	self.mainGO = go.gameObject
	self.isGray = false

	self:buildUI()
	self:initEvent()
end

function PowerCrystalPetItem:removeEvent()
	removetimer(self._startTimer, self)
	GameUtil.asBtn(self.mainGO):RemoveClickListener()
	PowerCrystalController.instance:unregisterLocalNotify(PowerCrystalModel.PutInPetSuccess, self._putInPetSuccessed, self)
	PowerCrystalController.instance:unregisterLocalNotify(PowerCrystalModel.PlaySlotEffect, self.playSlotEffect, self)
end

function PowerCrystalPetItem:initEvent()
	GameUtil.asBtn(self.mainGO):AddClickListener(function(eventData)
		self:_clickGo()
	end)
	PowerCrystalController.instance:registerLocalNotify(PowerCrystalModel.PutInPetSuccess, self._putInPetSuccessed, self)
	PowerCrystalController.instance:registerLocalNotify(PowerCrystalModel.PlaySlotEffect, self.playSlotEffect, self)
end

function PowerCrystalPetItem:buildUI()
	self._goImgIcon = goutil.findChild(self.mainGO, "imgIcon")
	self._goImgLock = goutil.findChild(self.mainGO, "imgLock")
	self._goImgAdd = goutil.findChild(self.mainGO, "imgAdd")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime")
	self._goDot = goutil.findChild(self.mainGO, "imgDot")
	self._imgBg = goutil.findChild(self.mainGO, "imgBg"):GetComponent("UIImageSpriteChange")
	self._txtLevel = goutil.findChildComponent(self.mainGO, "level", "Text")
	self._goLevelBg = goutil.findChild(self.mainGO, "bg")
end

function PowerCrystalPetItem:setMo(data, pos_id)
	removetimer(self._startTimer, self)

	pos_id = data and data.slotId or pos_id
	self.data = data
	self._mo = data and BagPetsFacade.instance:getPetInfo(data.petId)
	self.pos_id = pos_id

	self:_setCurrState(pos_id)
	self:_setItemStateShow(pos_id)
	self._imgBg:SetState(0)

	if self._mo and self._mo.raceId then
		self:setRaceId(self._mo.raceId)
		self._imgBg:SetState(self._mo.rare)
	end
end

function PowerCrystalPetItem:setRaceId(rid)
	local cfg = CharacterConfig.instance:getPetCo(rid)

	if not cfg then
		printError("t_pet id not exist:" .. rid)

		return
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(cfg.faceIds))

	if not modelCo then
		printError("t_model id not exist:" .. cfg.faceIds)

		return
	end

	uGuiUtil.setSpriteToImage(self._goImgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
end

function PowerCrystalPetItem:_clickGo()
	local state = self._posState

	if state == GameEnum.PowerCrystalPosType.Lock then
		self:_doUnLockSlot()
	elseif state == GameEnum.PowerCrystalPosType.Hold then
		self:_doPutOffPet()
	elseif state == GameEnum.PowerCrystalPosType.Cool then
		self:_doRemoveCool()
	elseif state == GameEnum.PowerCrystalPosType.Empty then
		self:_doPutInPet()
	end
end

function PowerCrystalPetItem:_setCurrState(pos_id)
	self._posState = self.model:getSlotState(pos_id)
end

function PowerCrystalPetItem:_setItemStateShow(pos_id)
	self._txtTime.text = ""
	self._txtLevel.text = ""

	local state = self._posState

	goutil.setActive(self._goImgIcon, state == GameEnum.PowerCrystalPosType.Hold)
	goutil.setActive(self._goImgAdd, state == GameEnum.PowerCrystalPosType.Empty)
	goutil.setActive(self._goImgLock, state == GameEnum.PowerCrystalPosType.Lock)
	goutil.setActive(self._txtTime.gameObject, state == GameEnum.PowerCrystalPosType.Cool)
	goutil.setActive(self._goDot, false)
	goutil.setActive(self._goLevelBg, state == GameEnum.PowerCrystalPosType.Hold)

	if state == GameEnum.PowerCrystalPosType.Cool then
		self:_setCoolTime()
	elseif state == GameEnum.PowerCrystalPosType.Lock then
		local dot = self.model:checkSlotOpenRedDot(self.pos_id)

		goutil.setActive(self._goDot, dot)
	elseif state == GameEnum.PowerCrystalPosType.Hold then
		if self.data then
			self._txtLevel.text = self.data.curLv .. "级" or ""
		end
	end
end

function PowerCrystalPetItem:_setCoolTime()
	removetimer(self._startTimer, self)

	local time = self.model:getSlotCoolTime(self.pos_id)

	if time > 0 then
		settimer(1, self._startTimer, self)
		self:_startTimer()
	end
end

function PowerCrystalPetItem:_startTimer()
	local time = self.model:getSlotCoolTime(self.pos_id)

	time = math.max(time - 1, 0)
	self._txtTime.text = "冷却中\n" .. TimeUtil:timeConvert2(time, nil, true)

	if time <= 0 then
		removetimer(self._startTimer, self)
		self.model:setCoolEnd(self.pos_id)
		self:setMo(self.data, self.pos_id)
	else
		self.model:setSlotCoolTime(self.pos_id, time)
	end
end

function PowerCrystalPetItem:OnDestroy()
	self:clearEffect()
	self:removeEvent()
end

function PowerCrystalPetItem:_doUnLockSlot()
	self.model:clickToUnlockSlot(self.pos_id)
end

function PowerCrystalPetItem:_doRemoveCool()
	local time = self.model:getSlotCoolTime(self.pos_id)

	if time <= 0 then
		return
	end

	local matNum = self.model:getUnLockSlotCostByTime(time)
	local matType, matId = MatType.Diamond, 2
	local itemStr = MaterialMgr.createSerName(matType, matId)
	local goodsStr = TipsFacade.instance:getContentMatStr(itemStr, 50, -10, true)
	local content = "花费" .. goodsStr .. "<color=#d44c28>X" .. matNum .. "</color>可以立即刷新冷却，是否刷新？"

	local function okFunc()
		local time = self.model:getSlotCoolTime(self.pos_id)

		if time <= 0 then
			FloatWordMgr.instance:show("冷却时间已结束，无需刷新")

			return
		end

		PowerCrystalController.instance:sendPM_PowerCrystalClearSlotCdReq(self.pos_id)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, okFunc, nil)
end

function PowerCrystalPetItem:_doPutInPet()
	local pet_id_list, race_id_list = self.model:getFilterList()

	local function filterFunc(pet)
		return not pet_id_list[pet.petId]
	end

	local select_petId

	local function sendFunc()
		if select_petId then
			PowerCrystalController.instance:sendPM_PowerCrystalPutInSlotReq(self.pos_id, select_petId)
		end
	end

	local function okFunc(petId)
		select_petId = petId

		local info = BagPetsFacade.instance:getPetInfo(petId)

		if info and race_id_list[info.raceId] then
			local cfg = CharacterConfig.instance:getPetCo(info.raceId)

			if cfg then
				local str = cfg.name .. "已在力量之核中，是否继续放入？"

				TipsFacade.instance:openPopupWindow("提示", str, sendFunc)

				return
			end
		end

		sendFunc()
	end

	PetSelectController.instance:OpenView(true, lang("请选择展示<color=#0068b7>1</color>只精灵"), filterFunc, okFunc)
end

function PowerCrystalPetItem:_doPutOffPet()
	UIStateManager.instance:open(ViewName.PowerCrystalDown, self.pos_id)
end

function PowerCrystalPetItem:_putInPetSuccessed(slotId)
	if self.pos_id == slotId then
		PowerCrystalController.instance:localNotify(PowerCrystalModel.PlayMoveEffect, GameUtil.getPos(self.mainGO), slotId)
	end
end

function PowerCrystalPetItem:playSlotEffect(slotId)
	if self.pos_id == slotId then
		self:clearEffect()

		local parentTrans = self._goImgIcon.transform

		local function finishCall()
			UIStateManager.instance:open(ViewName.PowerCrystalUp, slotId)
		end

		self.effect = UIEffectManager.instance:playEffect(self, "fx_ui_zhuangbeijiemian/fx_ui_zhangbeijiemian_chuxian.prefab", parentTrans, 0, 0, false, false, finishCall, function(uiEffect)
			self.effect:setParent(parentTrans)
			self.effect:setScale(1)
			self.effect:setLocalPos()
		end)

		local order = UGUIToolHelper.GetNodeCanvansSortingOrder(parentTrans.gameObject)

		self.effect:setSortingOrder(order + 1)
	end
end

function PowerCrystalPetItem:clearEffect()
	if self.effect then
		UIEffectManager.instance:stopEffect(self.effect)
	end
end

return PowerCrystalPetItem
