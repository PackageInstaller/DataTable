-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeTipsView.lua

module("logic.extensions.holystripe.view.HolyStripeTipsView", package.seeall)

local HolyStripeTipsView = class("HolyStripeTipsView", ViewComponent)
local subGroupOffset = -32
local subGroupOriginalY = 68

function HolyStripeTipsView:ctor()
	HolyStripeTipsView.super.ctor(self)

	self._holyStripId = nil
	self._isequip = nil
	self._clearGo = {}
	self._pendingDiscardTips = nil
end

function HolyStripeTipsView:buildUI()
	HolyStripeTipsView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)
	self._topAttr = self:getGo("content/top/attr")
	self._topIcon = self:getGo("content/top/item")
	self._itemName = self:getTxt("content/top/txtName")
	self._itemPos = self:getTxt("content/top/txtPos")
	self._isEquip = self:getGo("content/top/showSignGo")
	self._isAutoSmelt = self:getGo("content/top/tag")
	self._btnDiscard = self:getBtn("content/top/btnDiscard")
	self._btnLock = self:getBtn("content/top/btnLock")
	self._discardBtnGroup = self:getGo("content/top/btnDiscard"):GetComponent("UIChangeGroup")
	self._lockBtnGroup = self:getGo("content/top/btnLock"):GetComponent("UIChangeGroup")
	self._mainAttrGroup = self:getGo("content/info/attrs/Viewport/content/mainAttrsGroup")
	self._mainAttrItem = self:getGo("content/info/attrs/Viewport/content/mainAttrsGroup/cuilingItem")
	self._subAttrGroupGo = self:getGo("content/info/attrs/Viewport/content/subGroup")
	self._subAttrGroup = self:getGo("content/info/attrs/Viewport/content/subGroup/cuilingGroup")
	self._subAttrItem = self:getGo("content/info/attrs/Viewport/content/subGroup/cuilingGroup/cuilingItem")
	self._suitDesc = self:getTxt("content/info/suitDesc/Viewport/txt")
	self._suitView = self:getGo("content/info/suitDesc/Viewport/suitview")
	self._suitCell = self:getGo("content/info/suitDesc/Viewport/suitview/suititem")
	self.btnsGo = self:getGo("content/btns")
	self._equipBtnGo = self:getGo("content/btns/btnUnload")
	self._equipBtn = self:getBtn("content/btns/btnUnload")
	self._equipTxt = self:getTxt("content/btns/btnUnload/txt")
	self._strengthenBtnGo = self:getGo("content/btns/btnStrengthen")
	self._strengthenBtn = self:getBtn("content/btns/btnStrengthen")
	self._quenchingBtnGo = self:getGo("content/btns/btnCuiling")
	self._quenchingBtn = self:getBtn("content/btns/btnCuiling")
end

function HolyStripeTipsView:bindEvents()
	HolyStripeTipsView.super.bindEvents(self)
	self._equipBtn:AddClickListener(self._onClickEquipBtn, self)
	self._strengthenBtn:AddClickListener(self._onClickStrengthenBtn, self)
	self._quenchingBtn:AddClickListener(self._onClickQuenchingBtn, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnDiscard:AddClickListener(self._onClickDiscardBtn, self)
	self._btnLock:AddClickListener(self._onClickLockBtn, self)
end

function HolyStripeTipsView:unbindEvents()
	HolyStripeTipsView.super.unbindEvents(self)
	self._equipBtn:RemoveClickListener()
	self._strengthenBtn:RemoveClickListener()
	self._quenchingBtn:RemoveClickListener()
	self._customInput:RemoveListener()
	self._btnDiscard:RemoveClickListener()
	self._btnLock:RemoveClickListener()
end

function HolyStripeTipsView:onEnter()
	GlobalDispatcher:addListener(HolyStripeController.Confirm_To_Replace, self._sureRepace, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, self._onDiscardChangeReadyRes, self)

	self._holyStripId = checknumber(self:getFirstParam())

	local params = self:getOpenParam()

	if type(params[1]) == "number" then
		self._holyStripId = checknumber(params[1])
		self._holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(self._holyStripId)
	elseif type(params[1]) == "table" then
		self._holyStripeMo = params[1]
		self._holyStripId = self._holyStripeMo:getId()
	end

	self._isFromCuiling = params[2]

	local pos = params[3]

	if not params[4] then
		local sizeDelta = {
			0,
			0
		}

		self._hideBtns = params[5]
		self._isBagMo = self._holyStripeMo:isBagMo()

		if not self._isBagMo then
			self._hideBtns = true
		end

		GameUtil.SetActive(self._btnLock, self._isBagMo)
		GameUtil.SetActive(self._btnDiscard, self._isBagMo)

		local holyStripeMo = self._holyStripeMo
		local cfg

		if holyStripeMo then
			cfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeMo:getDefineId())
		end

		if cfg == nil then
			return
		end

		local mainAttrCfg = HolyStripeConfig.instance:getMainPropertyType(cfg.positionType, holyStripeMo:getPropertyId())
		local subAttrCfgs = HolyStripeConfig.instance:getSubPropertyType(cfg.positionType, cfg.quality, holyStripeMo:getQuenchingIds())
		local isLock = holyStripeMo:getIsLock()
		local _, color
		local var_5_1, var_5_2 = PetEquipController.instance:GetQualityStrByNum(holyStripeMo:getQuality())

		_ = var_5_1
		self._itemName.text = langPara("<color=%s>%s</color>%s", var_5_2, cfg.name, (holyStripeMo:getLv() and holyStripeMo:getLv() > 0 or nil) and "+" .. holyStripeMo:getLv())
		self._itemPos.text = langPara("部位：%s号位", cfg.positionType)

		MaterialMgr.resetAll(self._topIcon)

		local proxy = MaterialMgr.setCellByMo(holyStripeMo, self._topIcon)

		if proxy then
			proxy.binder:setNumStr("")
			proxy.binder:setAutoTips(false)
		end

		local petId = HolyStripeModel.instance:getCurrShowPetId()

		if holyStripeMo:getEquipPetId() > 0 then
			goutil.setActive(self._isEquip, true)
		else
			goutil.setActive(self._isEquip, false)
		end

		if self._lockBtnGroup then
			self._lockBtnGroup:SetState(isLock and 1 or 0)
		end

		if self._discardBtnGroup then
			self._discardBtnGroup:SetState(holyStripeMo:getIsReadyToDiscard() and 1 or 0)
		end

		if self._isBagMo then
			self._autoSmeltDays = HolyStripeModel.instance:getAutoSmeltDays() or 0
			self._autoSmeltQuality = HolyStripeModel.instance:getAutoSmeltQualityList() or {}
		else
			self._autoSmeltDays = 0
			self._autoSmeltQuality = {}
		end

		self._autoSmelt = false

		if self._autoSmeltDays > 0 then
			for i, v in ipairs(self._autoSmeltQuality) do
				if checknumber(cfg.quality) == v then
					self._autoSmelt = true

					break
				end
			end
		end

		if isLock then
			goutil.setActive(self._isAutoSmelt, false)
		else
			goutil.setActive(self._isAutoSmelt, self._autoSmelt)
		end

		local propertyBaseParam = HolyStripeConfig.instance:getMainPropertyByLv(mainAttrCfg.propertyType, cfg.quality, 0).propertyParam
		local propertyCurParam = HolyStripeConfig.instance:getMainPropertyByLv(mainAttrCfg.propertyType, cfg.quality, holyStripeMo:getLv()).propertyParam
		local propertyBase = string.split(propertyBaseParam, "#")
		local propertyCur = string.split(propertyCurParam, "#")

		goutil.setActive(self._mainAttrItem, false)

		for i = 1, #propertyBase do
			local propertyGo = goutil.cloneAndSetParent(self._mainAttrItem, self._mainAttrGroup.transform)

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

			propertyIcon:SetState(propertyType - 1)
		end

		local subAttrGroupGoRect = self._subAttrGroupGo:GetComponent(goutil.Type_RectTransform)

		GameUtil.setAnchoredPos(self._subAttrGroupGo, subAttrGroupGoRect.anchoredPosition.x, subAttrGroupGoRect.anchoredPosition.y + subGroupOffset * (#propertyBase - 1))

		local locklist = HolyStripeConfig.instance:getUnlockLvs()

		goutil.setActive(self._subAttrItem, false)

		for i = 1, #subAttrCfgs do
			if holyStripeMo:getLv() >= checknumber(locklist[i]) then
				local propertyGo = goutil.cloneAndSetParent(self._subAttrItem, self._subAttrGroup.transform)

				table.insert(self._clearGo, propertyGo)
				goutil.setActive(propertyGo, true)

				local propertyNameTxt = goutil.findChildTextComponent(propertyGo, "txtName")
				local propertyVal = goutil.findChildTextComponent(propertyGo, "txtNum")
				local propertyIcon = goutil.findChildComponent(propertyGo, "attr", "UIImageSpriteChange")
				local propertyIconGo = goutil.findChild(propertyGo, "attr")
				local lock = goutil.findChild(propertyGo, "lock")
				local lockTxt = goutil.findChildTextComponent(propertyGo, "lock/txtDesc")
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
					propertyIcon:SetState(propertyType - 1)
				else
					goutil.setActive(propertyIconGo, false)
				end
			end
		end

		for i = 1, #locklist do
			if holyStripeMo:getLv() < checknumber(locklist[i]) and holyStripeMo:getMaxLv() >= checknumber(locklist[i]) then
				local propertyGo = goutil.cloneAndSetParent(self._subAttrItem, self._subAttrGroup.transform)

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
			for j, suit in ipairs((not self._isBagMo or nil) and {}) do
				if suit.suitType == v.suitType and suit.id == v.id then
					activeSuitCount = i

					break
				end
			end
		end

		goutil.setActive(self._suitCell, false)

		local suitItemGo, suitDocTxt, suitNumTxt

		for i = 1, activeSuitCount do
			suitItemGo = goutil.cloneAndSetParent(self._suitCell, self._suitView.transform)

			table.insert(self._clearGo, suitItemGo)
			goutil.setActive(suitItemGo, true)

			suitDocTxt = goutil.findChildTextComponent(suitItemGo, "doc")
			suitNumTxt = goutil.findChildTextComponent(suitItemGo, "suitType")
			suitNumTxt.text = langPara("%s件：", suitCfg[i].num)
			suitDocTxt.text = langPara("%s", suitCfg[i].doc)
		end

		for i = activeSuitCount, #suitCfg - 1 do
			suitItemGo = goutil.cloneAndSetParent(self._suitCell, self._suitView.transform)

			table.insert(self._clearGo, suitItemGo)
			goutil.setActive(suitItemGo, true)

			suitDocTxt = goutil.findChildTextComponent(suitItemGo, "doc")
			suitNumTxt = goutil.findChildTextComponent(suitItemGo, "suitType")
			suitNumTxt.text = langPara("<color=#8c8c8c>%s件：</color>", suitCfg[i + 1].num)
			suitDocTxt.text = langPara("<color=#8c8c8c>%s</color>", suitCfg[i + 1].doc)
		end

		self:_setBtns()
		GameUtil.SetActive(self.btnsGo, not self._hideBtns)

		if pos then
			self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
		else
			Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
		end
	end
end

function HolyStripeTipsView:onExit()
	HolyStripeTipsView.super.onExit()
	GlobalDispatcher:removeListener(HolyStripeController.Confirm_To_Replace, self._sureRepace, self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, self._onDiscardChangeReadyRes, self)

	local subAttrGroupGoRect = self._subAttrGroupGo:GetComponent(goutil.Type_RectTransform)

	GameUtil.setAnchoredPos(self._subAttrGroupGo, subAttrGroupGoRect.anchoredPosition.x, subGroupOriginalY)
	MaterialMgr.resetAll(self._topIcon)

	for i, v in ipairs(self._clearGo) do
		goutil.destroy(v)
	end

	self._clearGo = {}
end

function HolyStripeTipsView:_setLock(isBag, isLock)
	return
end

function HolyStripeTipsView:_refreshDiscardState()
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(self._holyStripId)

	self._holyStripeMo = holyStripeMo or self._holyStripeMo

	if self._discardBtnGroup then
		self._discardBtnGroup:SetState(holyStripeMo and holyStripeMo:getIsReadyToDiscard() and 1 or 0)
	end

	if self._pendingDiscardTips then
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(self._pendingDiscardTips)
		FloatWordMgr.instance:resetParent()

		self._pendingDiscardTips = nil
	end
end

function HolyStripeTipsView:_onDiscardChangeReadyRes()
	self:_refreshDiscardState()
end

function HolyStripeTipsView:_setBtns()
	if self._hideBtns then
		return
	end

	local holyStripeMo = self._holyStripeMo
	local petId = HolyStripeModel.instance:getCurrShowPetId()

	if petId then
		goutil.setActive(self._equipBtnGo, true)

		if holyStripeMo:getEquipPetId() == petId then
			self._equipTxt.text = lang("卸下")
			self._isequip = true
		else
			self._equipTxt.text = lang("装备")
			self._isequip = false
		end
	else
		goutil.setActive(self._equipBtnGo, false)
	end

	if holyStripeMo:getExp() < holyStripeMo:getMaxStrengthExp() then
		goutil.setActive(self._strengthenBtnGo, not self._isFromCuiling)
	else
		goutil.setActive(self._strengthenBtnGo, false)
	end

	goutil.setActive(self._equipBtnGo, not self._isFromCuiling)
end

function HolyStripeTipsView:_onClickLockBtn()
	local holyStripeMo = self._holyStripeMo

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
	local isLock = holyStripeMo:getIsLock()

	HolyStripeAgent.instance:sendPM_HolyStripeLockOperationReq(ids, isLock and 0 or 1)
	holyStripeMo:setLocked(not isLock)

	if self._lockBtnGroup then
		self._lockBtnGroup:SetState(isLock and 0 or 1)
	end

	if isLock then
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(lang("已解锁"))
		FloatWordMgr.instance:resetParent()
	else
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(lang("已锁定"))
		FloatWordMgr.instance:resetParent()
	end
end

function HolyStripeTipsView:_onClickDiscardBtn()
	local holyStripeMo = self._holyStripeMo

	if not holyStripeMo or not self._isBagMo then
		return
	end

	if holyStripeMo:getIsLock() then
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(lang("请先解除锁定标记"))
		FloatWordMgr.instance:resetParent()

		return
	end

	local isDiscard = not holyStripeMo:getIsReadyToDiscard()

	self._pendingDiscardTips = isDiscard and lang("已标记弃置") or lang("已取消弃置")

	HolyStripeController.instance:sendPM_HolyStripeChangeReadyToDiscardReq(holyStripeMo, isDiscard)
end

function HolyStripeTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function HolyStripeTipsView:_onClickStrengthenBtn()
	self:close()
	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.HolystripestrengthView, self._holyStripId)
end

function HolyStripeTipsView:_onClickQuenchingBtn()
	GlobalDispatcher:dispatch(HolyStripeController.ForceUpdateCuiling, self._holyStripId)
	UIStateManager.instance:push(ViewName.HolystripecuilingView, self._holyStripId)
	self:close()
end

function HolyStripeTipsView:_onClickEquipBtn()
	local petId = HolyStripeModel.instance:getCurrShowPetId()
	local holyStripeMo = self._holyStripeMo

	if self._isequip then
		HolyStripeAgent.instance:sendPM_HolyStripeUnloadReq(petId, self._holyStripId)
	elseif holyStripeMo:getEquipPetId() > 0 then
		local petName = BagPetsController.instance:getExistPet(petId).name
		local holyStripePetName = BagPetsController.instance:getExistPet(holyStripeMo:getEquipPetId()).name
		local content = langPara("是否把%s的【%s】替换给%s？", holyStripePetName, holyStripeMo:getName(), petName)

		local function func1()
			self:_sureRepace()
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), content, func1, nil, nil, nil)

		return
	else
		HolyStripeAgent.instance:sendPM_HolyStripeEquipReq(petId, self._holyStripId)
	end

	self:close()
end

function HolyStripeTipsView:_sureRepace()
	local petId = HolyStripeModel.instance:getCurrShowPetId()

	HolyStripeAgent.instance:sendPM_HolyStripeEquipReq(petId, self._holyStripId)
	self:close()
end

return HolyStripeTipsView
