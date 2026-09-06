-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeCompareTipsView.lua

module("logic.extensions.holystripe.view.HolyStripeCompareTipsView", package.seeall)

local HolyStripeCompareTipsView = class("HolyStripeCompareTipsView", ViewComponent)
local subGroupOffset = -32
local subGroupOriginalY = 68

function HolyStripeCompareTipsView:ctor()
	HolyStripeCompareTipsView.super.ctor(self)

	self._holyStripId = nil
	self._isequip = nil
	self._clearGo = {}
	self._pendingDiscardTips = nil
end

function HolyStripeCompareTipsView:buildUI()
	HolyStripeCompareTipsView.super.buildUI(self)

	self._groupEquip = self:_buildUIGroup("contentequip")
	self._groupBag = self:_buildUIGroup("contentbag")
end

function HolyStripeCompareTipsView:bindEvents()
	HolyStripeCompareTipsView.super.bindEvents(self)
	self._groupEquip._equipBtn:AddClickListener(function()
		self:_onClickEquipBtn(self._holyStripeEquipId)
	end, self)
	self._groupEquip._strengthenBtn:AddClickListener(function()
		self:_onClickStrengthenBtn(self._holyStripeEquipId)
	end, self)
	self._groupEquip._quenchingBtn:AddClickListener(function()
		self:_onClickQuenchingBtn(self._holyStripeEquipId)
	end, self)
	self._groupEquip._isLockBtn:AddClickListener(function()
		self:_onClickLockBtn(self._holyStripeEquipId, self._groupEquip)
	end, self)
	self._groupEquip._btnAutoSmelt:AddClickListener(function()
		self:_onClickLockBtn(self._holyStripeEquipId, self._groupEquip)
	end)
	self._groupEquip._discardBtn:AddClickListener(function()
		self:_onClickDiscardBtn(self._holyStripeEquipId, self._groupEquip)
	end)
	self._groupBag._equipBtn:AddClickListener(function()
		self:_onClickEquipBtn(self._holyStripeBagId)
	end, self)
	self._groupBag._strengthenBtn:AddClickListener(function()
		self:_onClickStrengthenBtn(self._holyStripeBagId)
	end, self)
	self._groupBag._quenchingBtn:AddClickListener(function()
		self:_onClickQuenchingBtn(self._holyStripeBagId)
	end, self)
	self._groupBag._isLockBtn:AddClickListener(function()
		self:_onClickLockBtn(self._holyStripeBagId, self._groupBag)
	end, self)
	self._groupBag._btnAutoSmelt:AddClickListener(function()
		self:_onClickLockBtn(self._holyStripeBagId, self._groupBag)
	end)
	self._groupBag._discardBtn:AddClickListener(function()
		self:_onClickDiscardBtn(self._holyStripeBagId, self._groupBag)
	end)
end

function HolyStripeCompareTipsView:unbindEvents()
	HolyStripeCompareTipsView.super.unbindEvents(self)
	self._groupEquip._equipBtn:RemoveClickListener()
	self._groupEquip._strengthenBtn:RemoveClickListener()
	self._groupEquip._quenchingBtn:RemoveClickListener()
	self._groupEquip._isLockBtn:RemoveClickListener()
	self._groupEquip._btnAutoSmelt:RemoveClickListener()
	self._groupEquip._discardBtn:RemoveClickListener()
	self._groupBag._equipBtn:RemoveClickListener()
	self._groupBag._strengthenBtn:RemoveClickListener()
	self._groupBag._quenchingBtn:RemoveClickListener()
	self._groupBag._isLockBtn:RemoveClickListener()
	self._groupBag._btnAutoSmelt:RemoveClickListener()
	self._groupBag._discardBtn:RemoveClickListener()
end

function HolyStripeCompareTipsView:onEnter()
	local prams = self:getOpenParam()

	self._holyStripeEquipId = checknumber(prams[1])
	self._holyStripeBagId = checknumber(prams[2])
	self._autoSmeltDays = HolyStripeModel.instance:getAutoSmeltDays() or 0
	self._autoSmeltQuality = HolyStripeModel.instance:getAutoSmeltQualityList() or {}
	self._autoSmelt = {}

	self:_buildTipsByUIGroup(self._holyStripeEquipId, self._groupEquip)
	self:_buildTipsByUIGroup(self._holyStripeBagId, self._groupBag)
	GlobalDispatcher:addListener(HolyStripeController.Confirm_To_Replace, self._sureRepace, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, self._onDiscardChangeReadyRes, self)
end

function HolyStripeCompareTipsView:onExit()
	HolyStripeCompareTipsView.super.onExit()
	GlobalDispatcher:removeListener(HolyStripeController.Confirm_To_Replace, self._sureRepace, self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, self._onDiscardChangeReadyRes, self)
	self:_resetTip(self._groupEquip)
	self:_resetTip(self._groupBag)

	for i, v in ipairs(self._clearGo) do
		goutil.destroy(v)
	end

	self._clearGo = {}
end

function HolyStripeCompareTipsView:_buildTipsByUIGroup(holyStripId, UIGroup)
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)
	local cfg

	if holyStripeMo then
		cfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeMo:getDefineId())
	end

	if cfg == nil then
		return
	end

	local _, color = PetEquipController.instance:GetQualityStrByNum(holyStripeMo:getQuality())

	UIGroup._itemName.text = langPara("<color=%s>%s</color>%s", color, cfg.name, (holyStripeMo:getLv() and holyStripeMo:getLv() > 0 or nil) and "+" .. holyStripeMo:getLv())
	UIGroup._itemPos.text = langPara("部位：%s号位", cfg.positionType)

	MaterialMgr.resetAll(UIGroup._topIcon)

	local proxy = MaterialMgr.setCellByMo(holyStripeMo, UIGroup._topIcon)

	if proxy then
		proxy.binder:setNumStr("")
		proxy.binder:setAutoTips(false)
	end

	local petId = HolyStripeModel.instance:getCurrShowPetId()

	if holyStripeMo:getEquipPetId() > 0 then
		goutil.setActive(UIGroup._isEquip, true)
	else
		goutil.setActive(UIGroup._isEquip, false)
	end

	if UIGroup._isLock then
		if holyStripeMo:getIsLock() then
			UIGroup._isLock:SetState(0)
		else
			UIGroup._isLock:SetState(1)
		end
	end

	self._autoSmelt[holyStripId] = false

	if self._autoSmeltDays > 0 then
		for i, v in ipairs(self._autoSmeltQuality) do
			if checknumber(cfg.quality) == v then
				self._autoSmelt[holyStripId] = true

				break
			end
		end
	end

	if holyStripeMo:getIsLock() then
		goutil.setActive(UIGroup._isAutoSmelt, false)
	else
		goutil.setActive(UIGroup._isAutoSmelt, self._autoSmelt[holyStripId])
	end

	goutil.setActive(UIGroup._discardGo, holyStripeMo:isBagMo())

	if holyStripeMo:isBagMo() and UIGroup._discard then
		if holyStripeMo:getIsReadyToDiscard() then
			UIGroup._discard:SetState(0)
		else
			UIGroup._discard:SetState(1)
		end
	end

	local mainAttrCfg = HolyStripeConfig.instance:getMainPropertyType(cfg.positionType, holyStripeMo:getPropertyId())
	local propertyBaseParam = HolyStripeConfig.instance:getMainPropertyByLv(mainAttrCfg.propertyType, cfg.quality, 0).propertyParam
	local propertyCurParam = HolyStripeConfig.instance:getMainPropertyByLv(mainAttrCfg.propertyType, cfg.quality, holyStripeMo:getLv()).propertyParam
	local propertyBase = string.split(propertyBaseParam, "#")
	local propertyCur = string.split(propertyCurParam, "#")

	goutil.setActive(UIGroup._mainAttrItem, false)

	for i = 1, #propertyBase do
		local propertyGo = goutil.cloneAndSetParent(UIGroup._mainAttrItem, UIGroup._mainAttrGroup.transform)

		table.insert(self._clearGo, propertyGo)
		goutil.setActive(propertyGo, true)

		local propertyNameTxt = goutil.findChildTextComponent(propertyGo, "txtName")
		local propertyVal = goutil.findChildTextComponent(propertyGo, "txtNum")
		local propertyIcon = goutil.findChildComponent(propertyGo, "attr", "UIImageSpriteChange")
		local colorChange = propertyGo:GetComponent("UIImageColorChange")

		if colorChange then
			colorChange:SetState((i - 1) % 2)
		end

		local propertyName, baseVal

		propertyName, baseVal = HolyStripeController.instance:getAttrNameValue(propertyBase[i])

		local _, curVal = HolyStripeController.instance:getAttrNameValue(propertyCur[i])
		local propertyType = HolyStripeController.instance:getAttrTypeByName(propertyName)

		propertyNameTxt.text = ConstString.HolyStripeAttr[propertyType]
		propertyVal.text = curVal == baseVal and (baseVal > 0 and baseVal < 1 and string.format("%s%%", baseVal * 100) or string.format("%s", baseVal)) or baseVal > 0 and baseVal < 1 and string.format("%s%%<color=#33B56FFF>(+%s%%)</color>", baseVal * 100, (curVal - baseVal) * 100) or string.format("%s<color=#33B56FFF>(+%s)</color>", baseVal, curVal - baseVal)

		propertyIcon:ChangeStateNow(propertyType - 1)
	end

	local subAttrGroupGoRect = UIGroup._subAttrGroupGo:GetComponent(goutil.Type_RectTransform)

	GameUtil.setAnchoredPos(UIGroup._subAttrGroupGo, subAttrGroupGoRect.anchoredPosition.x, subAttrGroupGoRect.anchoredPosition.y + subGroupOffset * (#propertyBase - 1))

	local subAttrCfgs = HolyStripeConfig.instance:getSubPropertyType(cfg.positionType, cfg.quality, holyStripeMo:getQuenchingIds())
	local locklist = HolyStripeConfig.instance:getUnlockLvs()

	goutil.setActive(UIGroup._subAttrItem, false)

	for i = 1, #subAttrCfgs do
		if holyStripeMo:getLv() >= checknumber(locklist[i]) then
			local propertyGo = goutil.cloneAndSetParent(UIGroup._subAttrItem, UIGroup._subAttrGroup.transform)

			table.insert(self._clearGo, propertyGo)
			goutil.setActive(propertyGo, true)

			local propertyNameTxt = goutil.findChildTextComponent(propertyGo, "txtName")
			local propertyVal = goutil.findChildTextComponent(propertyGo, "txtNum")
			local propertyIcon = goutil.findChildComponent(propertyGo, "attr", "UIImageSpriteChange")
			local propertyIconGo = goutil.findChild(propertyGo, "attr")
			local lock = goutil.findChild(propertyGo, "lock")
			local lockTxt = goutil.findChildTextComponent(propertyGo, "txtDesc")
			local colorChange = propertyGo:GetComponent("UIImageColorChange")

			goutil.setActive(lock, false)

			propertyIcon.enabled = true

			if colorChange then
				colorChange:SetState((i - 1) % 2)
			end

			local propertyName, curVal = HolyStripeController.instance:getAttrNameValue(subAttrCfgs[i].doc)
			local propertyType = HolyStripeController.instance:getAttrTypeByName(propertyName)

			propertyNameTxt.text = ConstString.HolyStripeAttr[propertyType]
			propertyVal.text = curVal > 0 and curVal < 1 and string.format("+%s%%", curVal * 100) or string.format("+%s", curVal)

			if propertyType then
				propertyIcon:ChangeStateNow(propertyType - 1)
			else
				goutil.setActive(propertyIconGo, false)
			end
		end
	end

	for i = 1, #locklist do
		if holyStripeMo:getLv() < checknumber(locklist[i]) and holyStripeMo:getMaxLv() >= checknumber(locklist[i]) then
			local propertyGo = goutil.cloneAndSetParent(UIGroup._subAttrItem, UIGroup._subAttrGroup.transform)

			table.insert(self._clearGo, propertyGo)
			goutil.setActive(propertyGo, true)

			local colorChange = propertyGo:GetComponent("UIImageColorChange")

			if colorChange then
				colorChange:SetState((i - 1) % 2)
			end

			local propertyNameTxt = goutil.findChild(propertyGo, "txtName")
			local propertyVal = goutil.findChild(propertyGo, "txtNum")
			local propertyIcon = goutil.findChild(propertyGo, "attr")
			local lock = goutil.findChild(propertyGo, "lock")
			local lockTxt = goutil.findChildTextComponent(propertyGo, "lock/txtDesc")

			goutil.setActive(propertyNameTxt, false)
			goutil.setActive(propertyVal, false)
			goutil.setActive(propertyIcon, false)
			goutil.setActive(lock, true)

			lockTxt.text = langPara("强化+%s解锁", locklist[i])
		end
	end

	local suitCfg = HolyStripeConfig.instance:getSuitCfgBySuitType(cfg.suitType)
	local suitList = HolyStripeModel.instance:getCurSuitList()
	local activeSuitCount = 0

	for i, v in ipairs(suitCfg) do
		for j, suit in ipairs(suitList) do
			if suit.suitType == v.suitType and suit.id == v.id then
				activeSuitCount = i

				break
			end
		end
	end

	goutil.setActive(UIGroup._suitCell, false)

	local suitItemGo, suitDocTxt, suitNumTxt

	for i = 1, activeSuitCount do
		suitItemGo = goutil.cloneAndSetParent(UIGroup._suitCell, UIGroup._suitView.transform)

		table.insert(self._clearGo, suitItemGo)
		goutil.setActive(suitItemGo, true)

		suitDocTxt = goutil.findChildTextComponent(suitItemGo, "doc")
		suitNumTxt = goutil.findChildTextComponent(suitItemGo, "suitType")
		suitNumTxt.text = langPara("%s件：", suitCfg[i].num)
		suitDocTxt.text = langPara("%s", suitCfg[i].doc)
	end

	for i = activeSuitCount, #suitCfg - 1 do
		suitItemGo = goutil.cloneAndSetParent(UIGroup._suitCell, UIGroup._suitView.transform)

		table.insert(self._clearGo, suitItemGo)
		goutil.setActive(suitItemGo, true)

		suitDocTxt = goutil.findChildTextComponent(suitItemGo, "doc")
		suitNumTxt = goutil.findChildTextComponent(suitItemGo, "suitType")
		suitNumTxt.text = langPara("<color=#8c8c8c>%s件：</color>", suitCfg[i + 1].num)
		suitDocTxt.text = langPara("<color=#8c8c8c>%s</color>", suitCfg[i + 1].doc)
	end

	self:_setBtns(holyStripId, UIGroup)
end

function HolyStripeCompareTipsView:_resetTip(UIGroup)
	local subAttrGroupGoRect = UIGroup._subAttrGroupGo:GetComponent(goutil.Type_RectTransform)

	GameUtil.setAnchoredPos(UIGroup._subAttrGroupGo, subAttrGroupGoRect.anchoredPosition.x, subGroupOriginalY)
	MaterialMgr.resetAll(UIGroup._topIcon)
end

function HolyStripeCompareTipsView:_refreshDiscardState(holyStripId, UIGroup)
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)
	local isBagMo = holyStripeMo and holyStripeMo:isBagMo()

	goutil.setActive(UIGroup._discardGo, isBagMo == true)

	if isBagMo and UIGroup._discard then
		if holyStripeMo:getIsReadyToDiscard() then
			UIGroup._discard:SetState(0)
		else
			UIGroup._discard:SetState(1)
		end
	end

	if self._pendingDiscardTips then
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(self._pendingDiscardTips)
		FloatWordMgr.instance:resetParent()

		self._pendingDiscardTips = nil
	end
end

function HolyStripeCompareTipsView:_onDiscardChangeReadyRes()
	self:_refreshDiscardState(self._holyStripeEquipId, self._groupEquip)
	self:_refreshDiscardState(self._holyStripeBagId, self._groupBag)
end

function HolyStripeCompareTipsView:_buildUIGroup(parentPath)
	if string.nilorempty(parentPath) then
		return {}
	end

	return {
		_topAttr = self:getGo(parentPath .. "/top/attr"),
		_topIcon = self:getGo(parentPath .. "/top/item"),
		_itemName = self:getTxt(parentPath .. "/top/txtName"),
		_itemPos = self:getTxt(parentPath .. "/top/txtPos"),
		_isLockBtn = self:getBtn(parentPath .. "/top/btnLock"),
		_isLock = goutil.findChildComponent(self.mainGO, parentPath .. "/top/btnLock/img", "UIImageSpriteChange"),
		_isEquip = self:getGo(parentPath .. "/top/showSignGo"),
		_isAutoSmelt = self:getGo(parentPath .. "/top/tag"),
		_btnAutoSmelt = GameUtil.asBtn(goutil.findChild(self.mainGO, parentPath .. "/top/tag")),
		_discardGo = self:getGo(parentPath .. "/top/btnDiscard"),
		_discardBtn = self:getBtn(parentPath .. "/top/btnDiscard"),
		_discard = goutil.findChildComponent(self.mainGO, parentPath .. "/top/btnDiscard/img", "UIImageSpriteChange"),
		_mainAttrGroup = self:getGo(parentPath .. "/info/attrs/Viewport/content/mainAttrsGroup"),
		_mainAttrItem = self:getGo(parentPath .. "/info/attrs/Viewport/content/mainAttrsGroup/cuilingItem"),
		_subAttrGroupGo = self:getGo(parentPath .. "/info/attrs/Viewport/content/subGroup"),
		_subAttrGroup = self:getGo(parentPath .. "/info/attrs/Viewport/content/subGroup/cuilingGroup"),
		_subAttrItem = self:getGo(parentPath .. "/info/attrs/Viewport/content/subGroup/cuilingGroup/cuilingItem"),
		_suitDesc = self:getTxt(parentPath .. "/info/suitDesc/Viewport/txt"),
		_suitView = self:getGo(parentPath .. "/info/suitDesc/Viewport/suitview"),
		_suitCell = self:getGo(parentPath .. "/info/suitDesc/Viewport/suitview/suititem"),
		_equipBtnGo = self:getGo(parentPath .. "/btns/btnUnload"),
		_equipBtn = self:getBtn(parentPath .. "/btns/btnUnload"),
		_equipTxt = self:getTxt(parentPath .. "/btns/btnUnload/txt"),
		_strengthenBtnGo = self:getGo(parentPath .. "/btns/btnStrengthen"),
		_strengthenBtn = self:getBtn(parentPath .. "/btns/btnStrengthen"),
		_quenchingBtnGo = self:getGo(parentPath .. "/btns/btnCuiling"),
		_quenchingBtn = self:getBtn(parentPath .. "/btns/btnCuiling")
	}
end

function HolyStripeCompareTipsView:_setBtns(holyStripId, UIGroup)
	local petId = HolyStripeModel.instance:getCurrShowPetId()
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)

	if petId then
		goutil.setActive(UIGroup._equipBtnGo, true)

		UIGroup._equipTxt.text = holyStripeMo:getEquipPetId() == petId and lang("卸下") or lang("替换")
	else
		goutil.setActive(UIGroup._equipBtnGo, false)
	end

	if holyStripeMo:getExp() < holyStripeMo:getMaxStrengthExp() then
		goutil.setActive(UIGroup._strengthenBtnGo, true)
	else
		goutil.setActive(UIGroup._strengthenBtnGo, false)
	end
end

function HolyStripeCompareTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function HolyStripeCompareTipsView:_onClickStrengthenBtn(holyStripId)
	self:close()
	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.HolystripestrengthView, holyStripId)
end

function HolyStripeCompareTipsView:_onClickQuenchingBtn(holyStripId)
	UIStateManager.instance:push(ViewName.HolystripecuilingView, holyStripId)
	self:close()
end

function HolyStripeCompareTipsView:_onClickEquipBtn(holyStripId)
	local petId = HolyStripeModel.instance:getCurrShowPetId()
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)

	if holyStripeMo:getEquipPetId() == petId then
		HolyStripeAgent.instance:sendPM_HolyStripeUnloadReq(petId, holyStripId)
	elseif holyStripeMo:getEquipPetId() > 0 then
		local petName = BagPetsController.instance:getExistPet(petId).name
		local holyStripePetName = BagPetsController.instance:getExistPet(holyStripeMo:getEquipPetId()).name
		local content = langPara("是否把%s的【%s】替换给%s？", holyStripePetName, holyStripeMo:getName(), petName)

		local function func1()
			GlobalDispatcher:dispatch(HolyStripeController.Confirm_To_Replace, holyStripeMo:getId())
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), content, func1, nil, nil, nil)

		return
	else
		HolyStripeAgent.instance:sendPM_HolyStripeEquipReq(petId, holyStripId)
	end

	self:close()
end

function HolyStripeCompareTipsView:_onClickLockBtn(holyStripId, UIGroup)
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)

	if not holyStripeMo then
		return
	end

	if not holyStripeMo:getIsLock() and holyStripeMo:getIsReadyToDiscard() then
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(lang("请先解除弃置标记"))
		FloatWordMgr.instance:resetParent()

		return
	end

	local ids = {
		holyStripeMo:getId()
	}

	if holyStripeMo:getIsLock() then
		HolyStripeAgent.instance:sendPM_HolyStripeLockOperationReq(ids, 0)
		holyStripeMo:setLocked(false)
	else
		HolyStripeAgent.instance:sendPM_HolyStripeLockOperationReq(ids, 1)
		holyStripeMo:setLocked(true)
	end

	if UIGroup._isLock then
		if holyStripeMo:getIsLock() then
			UIGroup._isLock:SetState(0)
			goutil.setActive(UIGroup._isAutoSmelt, false)
		else
			UIGroup._isLock:SetState(1)
			goutil.setActive(UIGroup._isAutoSmelt, self._autoSmelt[holyStripId])
		end
	end

	if holyStripeMo:getIsLock() then
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(lang("已锁定"))
		FloatWordMgr.instance:resetParent()
	else
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(lang("已解锁"))
		FloatWordMgr.instance:resetParent()
	end
end

function HolyStripeCompareTipsView:_onClickDiscardBtn(holyStripId, UIGroup)
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)

	if not holyStripeMo or not holyStripeMo:isBagMo() then
		return
	end

	if holyStripeMo:getIsLock() then
		FloatWordMgr.instance:show(lang("请先解除锁定标记"))

		return
	end

	local isDiscard = not holyStripeMo:getIsReadyToDiscard()

	self._pendingDiscardTips = isDiscard and lang("已标记弃置") or lang("已取消弃置")

	HolyStripeController.instance:sendPM_HolyStripeChangeReadyToDiscardReq(holyStripeMo, isDiscard)
end

function HolyStripeCompareTipsView:_sureRepace(holyStripId)
	local petId = HolyStripeModel.instance:getCurrShowPetId()

	HolyStripeAgent.instance:sendPM_HolyStripeEquipReq(petId, holyStripId)
	self:close()
end

return HolyStripeCompareTipsView
