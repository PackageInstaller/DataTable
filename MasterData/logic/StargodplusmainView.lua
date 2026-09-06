-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusmainView.lua

module("logic.extensions.stargodplus.view.StargodplusmainView", package.seeall)

local StargodplusmainView = class("StargodplusmainView", TableViewComponent)
local TriggerTime = 1
local EquipItemPos = {
	{
		x = 0,
		y = 130
	},
	{
		x = 142,
		y = 0
	},
	{
		x = -142,
		y = 0
	},
	{
		x = 0,
		y = -130
	}
}

function StargodplusmainView:ctor()
	StargodplusmainView.super.ctor(self)
end

function StargodplusmainView:buildUI()
	StargodplusmainView.super.buildUI(self)

	self._equipRootGo = self:getGo("equipRoot")
	self._equipcellGo = self:getGo("equipRoot/cell")
	self._equipGroup = ItemGroup.New(self._equipRootGo, self._equipcellGo, nil, nil, true)
	self._lineGo = self:getGo("tableview/Nego_Viewport/Nego_Content/lines/line")
	self._lineConGo = self:getGo("tableview/Nego_Viewport/Nego_Content/lines")
	self._lineGoList = {}
	self._point_fxGo = self:getGo("point_fx")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "power/txtPower")
	self._onekeyBtn = self:getBtn("onekeyBtn")
	self._onekeyBtnDot = self:getGo("onekeyBtn/dot")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnOneDown = self:getGo("oneDown/btn")
	self._imgProgress = goutil.findChildImageComponent(self.mainGO, "oneDown/progress")
	self._btnLongPressHelper = BtnLongPressHelper.create(self._btnOneDown)

	GameUtil.SetActive(self._imgProgress, false)
end

function StargodplusmainView:bindEvents()
	StargodplusmainView.super.bindEvents(self)
	self._onekeyBtn:AddClickListener(self._onClickOnekeyBtn, self)
	self._btnExchange:AddClickListener(self._exchange, self)
	self._btnLongPressHelper:addClickHandler(GameUtil.handler(self._onBtnClickInTakeOff, self))
	self._btnLongPressHelper:addPressStartHandler(GameUtil.handler(self._onBtnPressStartInTakeOff, self))
	self._btnLongPressHelper:addPressEndHandler(GameUtil.handler(self._onBtnPressEndInTakeOff, self))
	self._btnLongPressHelper:addPressUpdateHandler(GameUtil.handler(self._onBtnPressUpdateInTakeOff, self))
	self._btnLongPressHelper:onPressTimeHandler(TriggerTime + 0.3, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self))
end

function StargodplusmainView:unbindEvents()
	StargodplusmainView.super.unbindEvents(self)
	self._onekeyBtn:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnLongPressHelper:clearAllHandlers()
end

function StargodplusmainView:destroyUI()
	StargodplusmainView.super.destroyUI(self)
end

function StargodplusmainView:onEnter()
	StargodplusmainView.super.onEnter(self)

	self._slotEffectHandler = {}

	GlobalDispatcher:addListener(StargodplusController.PM_EquipFillerRes, self._updateView, self)
	GlobalDispatcher:addListener(StargodplusController.PM_LoadAllFillerRes, self._updateView, self)
	GlobalDispatcher:addListener(StargodplusController.PM_OneKeyEquipFillersRes, self._updateView, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_OneKeyUnloadRes, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._updateView, self)
	self:_updateView()
	self:_setQuanEffect()
end

function StargodplusmainView:onEnterFinished()
	StargodplusmainView.super.onEnterFinished(self)
end

function StargodplusmainView:onExit()
	StargodplusmainView.super.onExit(self)
	GlobalDispatcher:removeListener(StargodplusController.PM_EquipFillerRes, self._updateView, self)
	GlobalDispatcher:removeListener(StargodplusController.PM_LoadAllFillerRes, self._updateView, self)
	GlobalDispatcher:removeListener(StargodplusController.PM_OneKeyEquipFillersRes, self._updateView, self)
	GlobalDispatcher:removeListener(StarGodPlusAgent.PM_OneKeyUnloadRes, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._updateView, self)
	self._equipGroup:dispose(function(item)
		local icon = goutil.findChild(item.mainGO, "icon")

		MaterialMgr.resetAll(icon)
	end)
	UIEffectManager.instance:stopEffect(self._quanEffectHandler)

	for k, handler in pairs(self._slotEffectHandler) do
		if handler then
			UIEffectManager.instance:stopEffect(handler)
		end
	end

	self._slotEffectHandler = nil
end

function StargodplusmainView:onExitFinished()
	StargodplusmainView.super.onExitFinished(self)
end

function StargodplusmainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function StargodplusmainView:_cellSize(view, index)
	return 100, 100
end

function StargodplusmainView:_updateCell(view, cell, data)
	return
end

function StargodplusmainView:_clearTableview(cell)
	return
end

function StargodplusmainView:_updateView()
	self._petId = StargodplusModel.instance:getCurrShowPetId()

	local petMo = BagPetsController.instance:getPet(self._petId)

	if not petMo then
		return
	end

	self:_updateEquip()
	self:_updateAttr()
	self:_checkRedDot()
end

function StargodplusmainView:_updateEquip()
	local slotDatasKV = StargodplusModel.instance:getSlotDatasKV(self._petId)
	local slotCfgs = StargodplusConfig.instance:getSlotCfgs()
	local petId = self._petId
	local petMo = BagPetsController.instance:getPet(petId)

	self:_updateAttr()

	local petLv = petMo:getPetLv()

	self._equipGroup:updateWithMoArray(slotCfgs, function(item, cfg, idx)
		item.mainGO.name = "cell_" .. idx

		local iconGo = goutil.findChild(item.mainGO, "icon")
		local effectGo = goutil.findChild(item.mainGO, "effect")
		local raycast = goutil.findChild(item.mainGO, "raycast")
		local btn = GameUtil.asBtn(item.mainGO)
		local lockGo = goutil.findChild(item.mainGO, "lock")
		local addGo = goutil.findChild(item.mainGO, "add")
		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local lvText = goutil.findChildTextComponent(item.mainGO, "lvText")
		local lockTip = goutil.findChildTextComponent(lockGo, "lockTip")
		local nameTextColorChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
		local redDotGo = goutil.findChild(item.mainGO, "red_point")
		local exclSptGo = goutil.findChild(item.mainGO, "exclSptGo")
		local exclIcon = goutil.findChild(item.mainGO, "exclSptGo/exclIcon")
		local slotData = slotDatasKV[cfg.slot]
		local isLock = petLv < cfg.unlockPetLv
		local isEquip = slotData and slotData.fillerDefineId > 0

		goutil.setActive(lockGo, isLock)
		goutil.setActive(addGo, not isEquip and not isLock)
		goutil.setActive(iconGo, isEquip)

		if slotData and slotData.fillerId > 0 then
			local starGodMo = StargodplusModel.instance:getStarGodMo(slotData.fillerId)

			if starGodMo and starGodMo:getBindPetId() > 0 then
				GameUtil.SetActive(exclSptGo, true)
				MaterialMgr.setIcon(exclIcon, MatType.Pet, starGodMo:getBindPetId(), nil, nil)
			else
				GameUtil.SetActive(exclSptGo, false)
				MaterialMgr.clearIcon(exclIcon)
			end
		else
			GameUtil.SetActive(exclSptGo, false)
			MaterialMgr.clearIcon(exclIcon)
		end

		lockTip.text = isLock and string.format("%s级解锁", cfg.unlockPetLv) or ""

		goutil.setActive(effectGo, false)

		if not isLock then
			local redDotState = true
			local redDotState

			if isEquip then
				::label_17_0::

				redDotState = StargodplusModel.instance:checkPetCanUpgradeEquipById(petId, cfg.slot)
			end

			goutil.setActive(redDotGo, redDotState)

			lvText.text = ""
			nameText.text = ""

			if slotData and slotData.fillerDefineId > 0 then
				local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)
				local name = ""
				local tmpCfg = StargodplusConfig.instance:getFillerCfg(slotData.fillerDefineId)
				local quality = tmpCfg and tmpCfg.quality

				if not isLock then
					name = tmpCfg and tmpCfg.name
				end

				nameTextColorChange:SetState(quality)
				MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slotData.fillerDefineId)
				goutil.setActive(effectGo, quality >= 3)

				local handler = self._slotEffectHandler[cfg.slot]

				if handler then
					UIEffectManager.instance:stopEffect(handler)
				end

				if quality == 3 then
					local effName = "fx_ui_xingshentihuan/fx_ui_xingshentihuan_zi.prefab"

					handler = UIEffectManager.instance:playEffect(self, effName, effectGo, 0, 0, true)
				elseif quality == 4 then
					local effName = "fx_ui_xingshentihuan/fx_ui_xingshentihuan_cheng.prefab"

					handler = UIEffectManager.instance:playEffect(self, effName, effectGo, 0, 0, true)
				elseif quality == 5 then
					local effName = "fx_ui_xingshentihuan/fx_ui_xingshentihuan_hong.prefab"

					handler = UIEffectManager.instance:playEffect(self, effName, effectGo, 0, 0, true)
				elseif quality == 6 then
					local effName = "fx_ui_xingshentihuan/fx_ui_xingshentihuan_hong.prefab"

					handler = UIEffectManager.instance:playEffect(self, effName, effectGo, 0, 0, true)
				end

				if handler then
					handler:setParent(effectGo.transform)
					handler:setScale(1)
					handler:setLocalPos(0, 0, 0)
				end

				self._slotEffectHandler[cfg.slot] = handler
				lvText.text = "Lv." .. lv
				nameText.text = name
			end

			btn:RemoveClickListener()
			btn:AddClickListener(function()
				self:_onClickEquip(cfg.slot, isLock, slotData, cfg.unlockPetLv)
			end)
			GameUtil.setAnchoredPos(item.mainGO, EquipItemPos[cfg.slot].x, EquipItemPos[cfg.slot].y)
		end
	end)
end

function StargodplusmainView:_onClickEquip(slot, isLock, slotData, unlockPetLv)
	if isLock then
		FloatWordMgr.instance:show(string.format("达到%s级后解锁", unlockPetLv))
	elseif slotData and (slotData.fillerId > 0 or slotData.fillerDefineId > 0) then
		UIStateManager.instance:push(ViewName.StargodplusequiptipView, slotData)
	else
		UIStateManager.instance:push(ViewName.StargodplusbagView, slot, slotData)
	end
end

function StargodplusmainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function StargodplusmainView:_cellSize(view, index)
	return 100, 100
end

function StargodplusmainView:_updateCell(view, cell, data)
	local iconChange = goutil.findChild(cell.gameObject, "attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local valueText = goutil.findChildTextComponent(cell.gameObject, "valueText")
	local name, value = GameUtil.getPropertyInfo(data.id, data.value)

	iconChange:SetState(data.id - 1)

	valueText.text = value
	nameText.text = name .. (data.id == GameEnum.AttrType.OriginalVigour and "增加" or "")
end

function StargodplusmainView:_clearTableview(cell)
	return
end

function StargodplusmainView:_updateAttr()
	self._curViewDatas = StargodplusModel.instance:getPetAttrs(self._petId) or {}

	local linesLen = math.ceil(#self._curViewDatas / 2)

	for i = 1, linesLen do
		local go = self._lineGoList[i]

		if not go then
			go = goutil.cloneAndSetParent(self._lineGo, self._lineConGo.transform)
			self._lineGoList[i] = go
		end

		goutil.setActive(go, true)
		GameUtil.setAnchoredPos(go, 0, -i * 40)
	end

	for i = linesLen + 1, #self._lineGoList do
		goutil.setActive(self._lineGoList[i], false)
	end

	local tempList = {}

	for i, v in ipairs(self._curViewDatas) do
		tempList[v.id] = v.value
	end

	self._txtPower.text = AttrMo.calcFightPowerByAttrs(tempList)

	self:reloadData()
end

function StargodplusmainView:_setQuanEffect()
	local effName = "fx_ui_zhihuijitan/fx_ui_zhihuijitan_quan.prefab"

	self._quanEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._quanEffectHandler:setParent(self._point_fxGo.transform)
	self._quanEffectHandler:setScale(1)
	self._quanEffectHandler:setLocalPos(0, 0, 0)
end

function StargodplusmainView:_onClickOnekeyBtn()
	local petMo = BagPetsController.instance:getPet(self._petId)
	local petLv = petMo:getPetLv()
	local scfg = StargodplusConfig.instance:getSlotCfg(1)
	local isUnlock = petLv >= scfg.unlockPetLv

	if not isUnlock then
		FloatWordMgr.instance:show("星神栏位未解锁，请解锁后再试 ")

		return
	end

	local finalList, needDestroyList = StargodplusModel.instance:getOnekeyBestFillerIds(self._petId)

	if #finalList <= 0 then
		FloatWordMgr.instance:show("当前没有闲置的星神可穿戴")
	else
		local pbList = {}
		local needDestroyList = {}

		for i, v in ipairs(finalList) do
			local pb = StarGodPlusExtension_pb.PM_SlotAndFiller()

			pb.slot = v.slot
			pb.usedFillerId = v.usedFillerId

			table.insert(pbList, pb)

			local mo = StargodplusModel.instance:getStarGodMo(v.usedFillerId)

			if mo then
				local cfg = StargodplusConfig.instance:getFillerCfg(mo:getDefineId())

				if cfg and checkbool(cfg.needDestroy) then
					table.insert(needDestroyList, mo)
				end
			end
		end

		if #needDestroyList > 0 then
			local nameStr = ""

			for i, sgmo in ipairs(needDestroyList) do
				nameStr = nameStr .. "【" .. sgmo:getName() .. "】"
			end

			local content = langPara("装上%s后若被其他星神替换会被<color=#ff0000>销毁</color>，是否确认继续此操作？", nameStr)

			TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
				StarGodPlusAgent.instance:sendPM_OneKeyEquipFillersReq(self._petId, pbList)
			end)
		else
			StarGodPlusAgent.instance:sendPM_OneKeyEquipFillersReq(self._petId, pbList)
		end
	end
end

function StargodplusmainView:_onClickoneDownBtn()
	local slotDatasKV = StargodplusModel.instance:getSlotDatasKV(self._petId)
	local hasStargod = false
	local hasRedStargod = false
	local hasZhuanshuStargod = false

	for k, v in pairs(slotDatasKV) do
		if v.fillerDefineId > 0 then
			local cfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)

			if cfg.quality == 5 then
				hasRedStargod = true
			elseif v.fillerId > 0 then
				hasStargod = true

				break
			else
				hasZhuanshuStargod = true
			end
		end
	end

	if hasStargod then
		StarGodPlusAgent.instance:sendPM_OneKeyUnloadReq({
			self._petId
		})
	elseif hasZhuanshuStargod or hasRedStargod then
		FloatWordMgr.instance:show("该精灵的星神不能卸下哦")
	else
		FloatWordMgr.instance:show("当前没有可卸下的星神")
	end
end

function StargodplusmainView:_onBtnClickInTakeOff()
	self:_onClickoneDownBtn()
end

function StargodplusmainView:_onBtnPressStartInTakeOff()
	self._imgProgress.fillAmount = 0

	GameUtil.SetActive(self._imgProgress, true)
end

function StargodplusmainView:_onBtnPressEndInTakeOff(pressTime)
	GameUtil.SetActive(self._imgProgress, false)
end

function StargodplusmainView:_onBtnPressUpdateTimeOverOnce(pressTime)
	UIStateManager.instance:push(ViewName.OneKeyUnloadPetView)
end

function StargodplusmainView:_onBtnPressUpdateInTakeOff(deltaTime, pressTime)
	self._imgProgress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function StargodplusmainView:_getRandomBestFillerId(ignorTypeList)
	local currMoList = {}
	local moList = StargodplusModel.instance:getFillerMoList()

	for i, mo in pairs(moList) do
		local equipType = mo:getEquipType()

		if mo:getUsePetId() <= 0 and not ignorTypeList[equipType] then
			table.insert(currMoList, mo)
		end
	end

	table.sort(currMoList, function(a, b)
		return a:getQuality() > b:getQuality()
	end)

	local currMo = currMoList[1]

	if currMo then
		ignorTypeList[currMo:getEquipType()] = true

		return currMo:getId()
	end
end

function StargodplusmainView:_checkRedDot()
	local flag = StargodplusModel.instance:checkPetCanEquipById(self._petId)

	goutil.setActive(self._onekeyBtnDot, flag)
end

function StargodplusmainView:_exchange()
	UIStateManager.instance:push(ViewName.StarGodPlusExchangView)
end

return StargodplusmainView
