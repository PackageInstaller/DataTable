-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetStarView.lua

module("logic.extensions.bag.view.stack.PetStarView", package.seeall)

local PetStarView = class("PetStarView", ViewComponent)

function PetStarView:ctor()
	PetStarView.super.ctor(self)
end

function PetStarView:destroyUI()
	PetStarView.super.destroyUI(self)
end

function PetStarView:onExitFinished()
	PetStarView.super.onExitFinished(self)
end

function PetStarView:onEnterFinished()
	PetStarView.super.onEnterFinished(self)
end

function PetStarView:unbindEvents()
	PetStarView.super.unbindEvents(self)
	self._btnRule:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._customInput:RemoveListener()
end

function PetStarView:bindEvents()
	PetStarView.super.bindEvents(self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
end

function PetStarView:onExit()
	PetStarView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._updateUI, self)
end

function PetStarView:buildUI()
	PetStarView.super.buildUI(self)

	self._stars = {}

	local stars = self:getGo("stars").transform
	local childCount = stars.childCount

	for i = 1, childCount do
		local go = stars:GetChild(i - 1).gameObject

		table.insert(self._stars, go)
		goutil.setActive(go, false)
	end

	self._slots = {}

	local slots = self:getGo("slots").transform

	childCount = slots.childCount

	for i = 1, slots.childCount do
		local go = slots:GetChild(i - 1).gameObject
		local slot = {}

		slot.mainGO = go
		slot.equipItem = goutil.findChild(go, "equipItem")
		slot.txtPlus = goutil.findChildComponent(go, "txtPlus", "Text")
		slot.redPoint = goutil.findChild(go, "redPoint")
		slot.equipCell = EquipCell.New(slot.equipItem)
		slot.btnSwitch = Framework.ButtonAdapter.GetFrom(go, "btnSwitch")

		slot.btnSwitch:AddClickListener(function()
			self:_onClickSwitch(i)
		end)

		slot.btn = Framework.ButtonAdapter.Get(go)

		slot.btn:AddClickListener(function()
			self:_onClickSlot(i)
		end)
		table.insert(self._slots, slot)
		goutil.setActive(slot.btnSwitch.gameObject, false)
	end

	self._btnReplace = self:getBtn("btnReplace")
	self._btnDetail = self:getBtn("btnDetail")
	self._btnRule = self:getBtn("btnRule")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._btnUpgrade = self:getBtn("btnUpgrade")
	self._txtLeftLv = goutil.findChildComponent(self.mainGO, "txtLeftLv", "Text")
	self._txtRightLv = goutil.findChildComponent(self.mainGO, "txtRightLv", "Text")
	self._goTips = self:getGo("tips")
	self._txtTips = goutil.findChildComponent(self._goTips, "txtTips", "Text")
	self._customInput = UICustomInput.Get(self._goTips)

	goutil.setActive(self._goTips, false)

	self._attrs = ItemEquipAttrs.New(self:getGo("attrs/scrollrect/attrs"))
	self._txtAttrEmptyTips = self:getGo("attrs/txtAttrEmptyTips")
	self._equipTipsPoint = self:getGo("equipTipsPoint")
end

function PetStarView:onEnter()
	PetStarView.super.onEnter(self)
	self:_updateUI()
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._updateUI, self)
end

function PetStarView:_updateUI()
	local petMo = BagPetsController.instance:GetCurPetMo()

	self._petMo = petMo

	self:_updateSlots()
	self:_updateStars(petMo._starLevel)
	self:_updateStarAttrs()
end

function PetStarView:_updateSlots()
	local canUpgrade = self._petMo._starLevel < CharacterConfig.MAX_STAR_LVL

	for i = 1, CharacterConfig.MAX_STAR_SLOT_COUNT do
		local slot = self._slots[i]
		local useEquip = self._petMo:getSlotEquip(i)
		local equipLv = 0

		if useEquip ~= nil then
			equipCfg = StarEquipmentConfig.instance:getEquipCfg(useEquip.equipmentId)

			goutil.setActive(slot.equipItem, true)

			equipLv = useEquip.level

			goutil.setActive(slot.redPoint, false)
		else
			local equipId = CharacterConfig.instance:getRecommendEquipId(self._petMo.raceId, self._petMo._starLevel, i)

			equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipId)

			local matNum = MaterialFacade.instance:getMatNumber(MatType.StarEquipment, equipId)

			goutil.setActive(slot.equipItem, matNum > 0)
			goutil.setActive(slot.redPoint, matNum > 0)
		end

		canUpgrade = canUpgrade and useEquip ~= nil and equipLv == StarEquipmentConfig.MaxStarEquipmentLv

		slot.equipCell:onSetMo(equipCfg, equipLv)
		uGuiUtil.setGoGrayState(slot.equipItem, useEquip == nil)
	end

	goutil.setActive(self._btnOneKey.gameObject, not canUpgrade)
	goutil.setActive(self._btnUpgrade.gameObject, canUpgrade)
end

function PetStarView:_updateStars(starLv)
	for i = 1, #self._stars do
		goutil.setActive(self._stars[i], i <= starLv)
	end

	self._txtLeftLv.text = string.format("星级%s", starLv)
	self._txtRightLv.text = string.format("星级%s", starLv + 1)

	goutil.setActive(self._txtRightLv.gameObject, false)

	if starLv <= 2 then
		self._txtTips.text = "4个星辉升级到满级后可升星"
	elseif starLv == 3 then
		self._txtTips.text = "4个星辉升级到满级后可升星，且开启星辉突破功能"
	elseif starLv == 4 then
		self._txtTips.text = "已升至最高星级"
	end
end

function PetStarView:_updateStarAttrs()
	local propertyApps = {}
	local findEquip = false

	for slotIndex = 1, CharacterConfig.MAX_STAR_SLOT_COUNT do
		local equipMo = self._petMo:getSlotEquip(slotIndex)

		if equipMo ~= nil then
			findEquip = true

			local equipLvCfg = StarEquipmentConfig.instance:getEquipLvCfg(equipMo.equipmentId, equipMo.level)

			table.insert(propertyApps, equipLvCfg.propertyApp)
		end
	end

	self._attrs:updateAttrsWithMos(propertyApps)
	goutil.setActive(self._txtAttrEmptyTips, not findEquip)
end

function PetStarView:_onClickClose()
	self:close()
end

function PetStarView:_onClickRule()
	goutil.setActive(self._goTips, true)
end

function PetStarView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._goTips, false)
	end
end

function PetStarView:_onClickSlot(i)
	local useEquip = self._petMo:getSlotEquip(i)
	local data
	local btnText = ""
	local btnCall

	if useEquip ~= nil then
		data = useEquip

		local equipCfg = StarEquipmentConfig.instance:getEquipCfg(useEquip.equipmentId)

		if useEquip.level == StarEquipmentConfig.instance.MaxStarEquipmentLv then
			if equipCfg.quality ~= GameEnum.StarEquipmentQua.Golden then
				btnText = "已满级"

				function btnCall()
					FloatWordMgr.instance:show("已达最高等级！")
				end
			else
				btnText = "突破"

				function btnCall()
					self:_openEquipBreakthroughView(useEquip, i)
				end
			end
		else
			btnText = "升级"

			function btnCall()
				self:_openEquipLvUpView(useEquip, i)
			end
		end
	else
		local equipId = CharacterConfig.instance:getRecommendEquipId(self._petMo.raceId, self._petMo._starLevel, i)
		local cfg = StarEquipmentConfig.instance:getEquipCfg(equipId)

		data = {
			totalExp = 0,
			level = 0,
			equipmentId = equipId
		}

		local matNum = MaterialFacade.instance:getMatNumber(MatType.StarEquipment, equipId)

		if matNum == 0 then
			btnText = "来源"

			function btnCall()
				MaterialMgr.openGetSource(MatType.StarEquipment, equipId)
			end
		else
			btnText = "装备"

			function btnCall()
				self:_putOnEquip(equipId, i - 1)
			end
		end
	end

	local x, y, z = Framework.TransformUtil.GetPos(self._equipTipsPoint.transform, 0, 0, 0)

	UIStateManager.instance:open(ViewName.CommonEquipTips, data, {
		x,
		y,
		z
	}, btnText, btnCall)
end

function PetStarView:_putOnEquip(equipmentId, index)
	StarEquipmentAgent.instance:sendSE_EquipReq(self._petMo.petId, index, equipmentId, self._onPutOnSuccess, self)
end

function PetStarView:_onPutOnSuccess()
	FloatWordMgr.instance:show("装备成功")
	self:_updateUI()
end

function PetStarView:_onClickOneKey()
	local equipIds = {}
	local isHasEmpty = false
	local isHasEquip = false

	for slotIndex = 1, CharacterConfig.MAX_STAR_SLOT_COUNT do
		local useEquip = self._petMo:getSlotEquip(slotIndex)

		if useEquip == nil then
			isHasEmpty = true

			local equipId = CharacterConfig.instance:getRecommendEquipId(self._petMo.raceId, self._petMo._starLevel, slotIndex)
			local matNum = MaterialFacade.instance:getMatNumber(MatType.StarEquipment, equipId)

			if matNum > 0 then
				isHasEquip = true
				equipIds[slotIndex] = equipId
			end
		end
	end

	if not isHasEquip then
		local content = isHasEmpty and "没有可以装备的星辉" or "精灵槽位已满，不能再装备星辉了"

		FloatWordMgr.instance:show(content)
	else
		UIStateManager.instance:open(ViewName.OneKeyPutonEquip, self._petMo, equipIds)
	end
end

function PetStarView:_onClickUpgrade()
	self._preMo = self._petMo:GetClone()

	StarEquipmentAgent.instance:sendSE_StarLevelUpReq(self._petMo.petId, self._onUpgradeSuccess, self)
end

function PetStarView:_onUpgradeSuccess()
	BagPetsFacade.instance:checkAndOpenPetUp(self._petMo, self._preMo)
end

function PetStarView:_openEquipLvUpView(equip, slotIndex)
	UIStateManager.instance:push(ViewName.EquipLvUp, equip, self._petMo, slotIndex)
end

function PetStarView:_openEquipBreakthroughView(equip, slotIndex)
	goutil.setActive(self.mainGO, false)
	UIStateManager.instance:open(ViewName.EquipBreakthrough, equip, self._petMo, slotIndex, function()
		goutil.setActive(self.mainGO, true)
		self:_updateUI()
	end)
end

function PetStarView:_onClickSwitch(slotIndex)
	goutil.setActive(self.mainGO, false)
	UIStateManager.instance:open(ViewName.PetEquipSwitch, self._petMo, slotIndex, function()
		goutil.setActive(self.mainGO, true)
		self:_updateUI()
	end)
end

function PetStarView:_onClickDetail()
	UIStateManager.instance:open(ViewName.PetStarDetail, self._petMo)
end

return PetStarView
