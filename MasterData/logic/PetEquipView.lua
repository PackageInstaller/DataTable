-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipView.lua

module("logic.extensions.equipment.view.PetEquipView", package.seeall)

local PetEquipView = class("PetEquipView", ViewComponent)
local TriggerTime = 1

function PetEquipView:ctor()
	PetEquipView.super.ctor(self)

	self.equipItemList = nil
	self.equipInfoList = nil
	self.decorationInfo = nil
	self.isRedPoint = false
end

function PetEquipView:bindEvents()
	PetEquipView.super.bindEvents(self)
	self._btnLongPressHelper:addClickHandler(GameUtil.handler(self._onBtnClickInTakeOff, self))
	self._btnLongPressHelper:addPressStartHandler(GameUtil.handler(self._onBtnPressStartInTakeOff, self))
	self._btnLongPressHelper:addPressEndHandler(GameUtil.handler(self._onBtnPressEndInTakeOff, self))
	self._btnLongPressHelper:addPressUpdateHandler(GameUtil.handler(self._onBtnPressUpdateInTakeOff, self))
	self._btnLongPressHelper:onPressTimeHandler(TriggerTime + 0.3, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self))
	GameUtil.asBtn(self.wearAllBtnGo):AddClickListener(self.OnClickWearAllBtn, self)
end

function PetEquipView:unbindEvents()
	PetEquipView.super.unbindEvents(self)
	self._btnLongPressHelper:clearAllHandlers()
	GameUtil.asBtn(self.wearAllBtnGo):RemoveClickListener()

	if self.equipItemList == nil and #self.equipItemList == 0 then
		return
	end

	for i = 1, #self.equipItemList do
		if self.equipItemList[i] and self.equipItemList[i].itemGo then
			GameUtil.asBtn(self.equipItemList[i].itemGo):RemoveClickListener()
		end
	end
end

function PetEquipView:onExit()
	PetEquipView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self.UpdataAllInfoMos, self)
	GlobalDispatcher:removeListener(GlobalNotify.PET_EQUIP_CHANGES, self.UpdataAllInfoMos, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetChanged, self.UpdataPetChanged, self)
end

function PetEquipView:destroyUI()
	PetEquipView.super.destroyUI(self)

	self.equipItemList = nil
	self.equipInfoList = nil
	self.decorationInfo = nil
end

function PetEquipView:buildUI()
	PetEquipView.super.buildUI(self)

	local bgGo = self:getGo("viewBgGo")
	local equipAllGo = goutil.findChild(bgGo, "equipAll")

	self.takeOffBtnGo = goutil.findChild(bgGo, "onekeyUnload/takeOffBtn")
	self._imgTakeOffBtnProgress = goutil.findChildImageComponent(bgGo, "onekeyUnload/progress")
	self._btnLongPressHelper = BtnLongPressHelper.create(self.takeOffBtnGo)
	self.wearAllBtnGo = goutil.findChild(bgGo, "wearAllBtn")
	self.waRedPointGo = goutil.findChild(self.wearAllBtnGo, "waRedPoint")

	self.waRedPointGo:SetActive(false)

	self.allPowerGo = goutil.findChild(bgGo, "allPowerGo")
	self.powerTxt = goutil.findChildTextComponent(self.allPowerGo, "powerTxt")

	self.allPowerGo:SetActive(false)

	if self.equipItemList and #self.equipItemList > 0 then
		return
	end

	if equipAllGo.transform.childCount ~= 6 then
		print("sr_ (错误)PetEquipView:buildUI()  精灵装备槽不为6个，请检查！")

		return
	end

	self.equipItemList = {}

	for i = 1, 6 do
		local go = equipAllGo.transform:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")
		local index = tonumber(names[2])

		self.equipItemList[index] = {}
		self.equipItemList[index].itemGo = go
		self.equipItemList[index].stateSpt = goutil.findChildComponent(go, "stateSpt", "UIImageSpriteChange")
		self.equipItemList[index].redPointGo = goutil.findChild(go, "redPoint")
		self.equipItemList[index].showSignGo = goutil.findChild(go, "showSignGo")

		if i >= 5 then
			self.equipItemList[index].kuangIma = goutil.findChildComponent(go, "kuangIma", "UIImageSpriteChange")
		end

		self.equipItemList[index].redPointGo:SetActive(false)
		self.equipItemList[index].showSignGo:SetActive(false)
		GameUtil.asBtn(go):AddClickListener(function()
			self:OnClickEquipItem(index)
		end, self)
	end

	GameUtil.SetActive(self._imgTakeOffBtnProgress, false)
end

function PetEquipView:onEnter()
	PetEquipView.super.onEnter(self)

	self.isRedPoint = false

	self:UpdataAllInfoMos()
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self.UpdataAllInfoMos, self)
	GlobalDispatcher:addListener(GlobalNotify.PET_EQUIP_CHANGES, self.UpdataAllInfoMos, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self.UpdataPetChanged, self)
end

function PetEquipView:UpdataAllInfoMos(info)
	local petInfo = BagPetsController.instance:GetCurPetMo()

	if not petInfo then
		return
	end

	local allPower = 0

	self.equipInfoList = {}

	if PetEquipController.instance.isEquipInit then
		self.equipInfoList = PetEquipModel.instance:GetWearEquipInfosByPetInfo(petInfo)
		allPower = PetEquipModel.instance:GetWearEquipAllPower(petInfo, self.equipInfoList)
	end

	if allPower > 0 then
		self.powerTxt.text = tostring(allPower)

		self.allPowerGo:SetActive(true)
	else
		self.powerTxt.text = ""

		self.allPowerGo:SetActive(false)
	end

	if not self.isRedPoint then
		self.waRedPointGo:SetActive(false)
	end

	if self.equipItemList == nil or #self.equipItemList == 0 then
		return
	end

	for i = 1, #self.equipInfoList do
		if self.equipItemList[i] and self.equipItemList[i].itemGo then
			MaterialMgr.resetAll(self.equipItemList[i].itemGo)
			self.equipItemList[i].redPointGo:SetActive(false)
			self.equipItemList[i].showSignGo:SetActive(false)

			if not self.equipInfoList[i].isOpen then
				self.equipItemList[i].stateSpt.gameObject:SetActive(true)
				self.equipItemList[i].stateSpt:SetState(1)

				if i >= 5 then
					self.equipItemList[i].kuangIma:SetState(0)
				end
			else
				if not self.equipInfoList[i].isWear then
					self.equipItemList[i].stateSpt.gameObject:SetActive(true)
					self.equipItemList[i].stateSpt:SetState(0)

					if i >= 5 then
						self.equipItemList[i].kuangIma:SetState(0)
					end
				else
					self.equipItemList[i].stateSpt.gameObject:SetActive(false)

					local subLua = MaterialMgr.setCellByData(MatType.Equipment, self.equipInfoList[i].info, self.equipItemList[i].itemGo)

					if subLua then
						subLua.binder:CancelBtnClick()

						if self.equipInfoList[i].isAddSttr then
							subLua.binder:SetView(self)
							subLua.binder:PlayAttrTypeEffect()
						else
							subLua.binder:PlayAttrTypeEffect(true)
						end
					end

					if i >= 5 then
						self.equipItemList[i].kuangIma:SetState(1)
					end
				end

				if PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Wear) or PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.TuPo) then
					self.equipItemList[i].redPointGo.transform:SetAsLastSibling()

					self.isRedPoint = true

					self.equipItemList[i].redPointGo:SetActive(true)
				end

				if PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Strengthen) then
					self.equipItemList[i].showSignGo.transform:SetAsLastSibling()
					self.equipItemList[i].showSignGo:SetActive(true)
				end
			end
		end
	end

	self.waRedPointGo:SetActive(self.isRedPoint)
end

function PetEquipView:UpdataPetChanged(ids)
	local petId = BagPetsController.instance:GetCurPetId()

	for id, value in pairs(ids or {}) do
		if id and value and id == petId then
			self:UpdataEquipPosRedPoint()

			return
		end
	end
end

function PetEquipView:UpdataEquipPosRedPoint()
	self.isRedPoint = false

	local petInfo = BagPetsController.instance:GetCurPetMo()

	if self.equipItemList == nil or petInfo == nil then
		self.waRedPointGo:SetActive(self.isRedPoint)

		return
	end

	for i = 1, #self.equipItemList do
		if self.equipItemList[i] and self.equipItemList[i].redPointGo then
			local redPoint = PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Wear) or PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.TuPo)
			local showSign = PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Strengthen)

			self.equipItemList[i].redPointGo:SetActive(redPoint)
			self.equipItemList[i].showSignGo:SetActive(showSign)

			if redPoint then
				self.equipItemList[i].redPointGo.transform:SetAsLastSibling()

				self.isRedPoint = true
			end

			if showSign then
				self.equipItemList[i].showSignGo.transform:SetAsLastSibling()
			end
		end
	end

	self.waRedPointGo:SetActive(self.isRedPoint)
end

function PetEquipView:OnClickEquipItem(index)
	if self.equipInfoList == nil or self.equipInfoList[index] == nil then
		return
	end

	local info = self.equipInfoList[index]

	if not info.isOpen then
		FloatWordMgr.instance:show(lang("text_equip_not_open"))

		return
	end

	if info.info == nil or not info.isWear then
		UIStateManager.instance:open(ViewName.PetEquipChangeBagView, index)

		return
	end

	if info.info then
		UIStateManager.instance:open(ViewName.PetEquipInfo, info.info)

		return
	end
end

function PetEquipView:OnClickTakeoffBtn()
	local petInfo = BagPetsController.instance:GetCurPetMo()
	local unloadList = PetEquipModel.instance:ClickTakeoffAllEquips(petInfo)

	if unloadList == nil or #unloadList == 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_84"))

		return
	end

	PetEquipController.instance:CSOneKeyUnloadEquipReq({
		petInfo.petId
	})
end

function PetEquipView:_onBtnClickInTakeOff()
	self:OnClickTakeoffBtn()
end

function PetEquipView:_onBtnPressStartInTakeOff()
	self._imgTakeOffBtnProgress.fillAmount = 0

	GameUtil.SetActive(self._imgTakeOffBtnProgress, true)
end

function PetEquipView:_onBtnPressEndInTakeOff(pressTime)
	GameUtil.SetActive(self._imgTakeOffBtnProgress, false)
end

function PetEquipView:_onBtnPressUpdateTimeOverOnce(pressTime)
	UIStateManager.instance:push(ViewName.OneKeyUnloadPetView)
end

function PetEquipView:_onBtnPressUpdateInTakeOff(deltaTime, pressTime)
	self._imgTakeOffBtnProgress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function PetEquipView:OnClickWearAllBtn()
	local petInfo = BagPetsController.instance:GetCurPetMo()
	local equipList, dectInfo, isHave, isBest = PetEquipModel.instance:ClickWearAllBestEquips(petInfo)

	if not isHave then
		FloatWordMgr.instance:show(lang("text_equip_desc_85"))

		return
	end

	if not isBest then
		FloatWordMgr.instance:show(lang("text_equip_desc_86"))

		return
	end

	local ids = {}

	for i = 1, #equipList do
		if equipList[i].info then
			table.insert(ids, equipList[i].info.onlyId)
		end
	end

	if dectInfo and dectInfo.info and dectInfo.isBest then
		PetEquipController.instance:CSOneKeyWearEquipReq(petInfo.petId, ids, dectInfo.info.onlyId)
	else
		local tips = ""

		if ids and #ids > 0 then
			for i = 1, #ids do
				local tempMo = PetEquipModel.instance:GetEquipInfo(ids[i])

				if tempMo == nil then
					tips = string.format("%s +   出错装备id=%s, 类型=%s, 精灵信息id=%s", tips, ids[i], type(ids[i]), petInfo.petId)
				end
			end
		end

		if not string.nilorempty(tips) then
			forcePrint("sr===========================装备一键穿戴===============forcePrint", tips)
			printError("sr===========================装备一键穿戴====================printError", tips)
		end

		PetEquipController.instance:CSOneKeyWearEquipReq(petInfo.petId, ids)
	end
end

return PetEquipView
