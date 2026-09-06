-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeMainView.lua

module("logic.extensions.holystripe.view.HolyStripeMainView", package.seeall)

local HolyStripeMainView = class("HolyStripeMainView", ViewComponent)
local TriggerTime = 1

HolyStripeMainView.HolyStripePosition = {
	{
		rotate = 90,
		x = -42.2,
		y = -203.9
	},
	{
		rotate = 45,
		x = 6.7,
		y = -75.7
	},
	{
		rotate = 0,
		x = 137.1,
		y = -27.9
	},
	{
		rotate = -45,
		x = 266.7,
		y = -76.8
	},
	{
		rotate = -90,
		x = 316.4,
		y = -204.1
	}
}

function HolyStripeMainView:ctor()
	HolyStripeMainView.super.ctor(self)
end

function HolyStripeMainView:buildUI()
	HolyStripeMainView.super.buildUI(self)

	self._tableView = self:getGo("rightRoot/attrRoot/tableview")
	self._tableCell = self:getGo("rightRoot/attrRoot/tablecell")
	self._suitIcon = self:getGo("rightRoot/attrRoot/attrIcon")
	self._suitDesc = self:getTxt("rightRoot/attrRoot/txtDesc")
	self._changeBtnGo = self:getGo("rightRoot/changeBtn")
	self._changeBtn = self:getBtn("rightRoot/changeBtn")
	self._changeBtnIcon = self:getImg("rightRoot/changeBtn")
	self._suitPreviewBtn = self:getBtn("rightRoot/suitPreviewBtn")
	self._recommenItemCon = self:getGo("rightRoot/txtRecommen")
	self._txtRecommen = self:getTxt("rightRoot/txtRecommen")
	self._backEffectGo = self:getGo("rightRoot/bgEffect")
	self._effectBgGo = self:getGo("rightRoot")
	self._effectBgRt = self:getGo("rightRoot"):GetComponent(goutil.Type_RectTransform)
	self._btnOneDown = self:getGo("rightRoot/oneKeyTakeoffBtn/btn")
	self._imgProgress = goutil.findChildImageComponent(self.mainGO, "rightRoot/oneKeyTakeoffBtn/progress")

	if self._btnOneDown then
		self._btnLongPressHelper = BtnLongPressHelper.create(self._btnOneDown)
	end

	GameUtil.SetActive(self._imgProgress, false)

	self._oneKeyTakeOnBtn = self:getBtn("rightRoot/oneKeyTakeOnBtn")

	self:_buildEquipItems()

	self._attrScrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updataCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSuitSet = self:getGo("rightRoot/btnSuitSet")
	self._btnCalculate = self:getGo("rightRoot/btnCalculate")
end

function HolyStripeMainView:_buildEquipItems()
	local equipCell = self:getGo("rightRoot/equipRoot/cell1")
	local equipRoot = self:getGo("rightRoot/equipRoot")

	self._equipItems = {}

	local goList = {
		equipCell
	}

	for i = 2, 5 do
		goList[i] = goutil.cloneAndSetParent(equipCell, equipRoot.transform, "cell" .. i)
	end

	for i, go in ipairs(goList) do
		local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
		local icon = goutil.findChild(go, "icon")
		local lvText = goutil.findChildTextComponent(go, "lvText")
		local nameText = goutil.findChildTextComponent(go, "nameText")
		local effect = goutil.findChild(go, "effect")
		local redpoint = goutil.findChild(go, "redpoint")
		local select = goutil.findChild(go, "select")
		local quality = goutil.findChild(go, "quality")
		local qualityUIChange = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			lvText = lvText,
			effect = effect,
			nameText = nameText,
			redPoint = redpoint,
			select = select,
			quality = quality,
			qualityUIChange = qualityUIChange
		}

		local pos = HolyStripeMainView.HolyStripePosition[i]

		GameUtil.setAnchoredPos(go, pos.x, pos.y)

		if select then
			Framework.TransformUtil.SetLocalRotation(select.transform, 0, 0, pos.rotate)
		end

		if quality then
			Framework.TransformUtil.SetLocalRotation(quality.transform, 0, 0, pos.rotate)
		end
	end
end

function HolyStripeMainView:bindEvents()
	HolyStripeMainView.super.bindEvents(self)
	self._changeBtn:AddClickListener(self._onChangeBtnClick, self)
	self._oneKeyTakeOnBtn:AddClickListener(self._onOneKeyTakeOnBtnClick, self)
	self._suitPreviewBtn:AddClickListener(self._onClickSmeltBtnClick, self)
	GameUtil.addClickHandler(self._btnCalculate, self._onClickCalculate, self)
	GameUtil.addClickHandler(self._btnSuitSet, self._onClickSuitSet, self)

	if self._btnLongPressHelper then
		self._btnLongPressHelper:addClickHandler(GameUtil.handler(self._onBtnClickInTakeOff, self))
		self._btnLongPressHelper:addPressStartHandler(GameUtil.handler(self._onBtnPressStartInTakeOff, self))
		self._btnLongPressHelper:addPressEndHandler(GameUtil.handler(self._onBtnPressEndInTakeOff, self))
		self._btnLongPressHelper:addPressUpdateHandler(GameUtil.handler(self._onBtnPressUpdateInTakeOff, self))
		self._btnLongPressHelper:onPressTimeHandler(TriggerTime + 0.3, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self))
	end
end

function HolyStripeMainView:unbindEvents()
	HolyStripeMainView.super.unbindEvents(self)
	self._changeBtn:RemoveClickListener()
	self._oneKeyTakeOnBtn:RemoveClickListener()
	self._suitPreviewBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnCalculate)
	GameUtil.rmClickHandler(self._btnSuitSet)

	if self._btnLongPressHelper then
		self._btnLongPressHelper:clearAllHandlers()
	end
end

function HolyStripeMainView:onEnter()
	HolyStripeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._updataView, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeLoadAllRes, self._PM_HolyStripeLoadAllRes, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeEquipRes, self._PM_HolyStripeEquipRes, self)
	HolyStripeAgent.instance:sendPM_HolyStripeLoadAllReq()

	self._backEffectPath = "20220701/zhihuijitan/fx_ui_zhjt_lwth.prefab"
	self._backEffectHandler = UIEffectManager.instance:playEffect(self, self._backEffectPath, nil, 0, 0, true, nil, nil, function()
		self._backEffectHandler:setClipping(self._effectBgRt)
	end)

	self._backEffectHandler:setParent(self._backEffectGo.transform)
	self._backEffectHandler:setLocalPos(0, 0, 0)
	self._backEffectHandler:setScale(1)

	local curFaceId = HolyStripeModel.instance:getCurShowFaceId()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	self._txtRecommen.text = langPara("推荐灵纹：%s", (cfg or nil) and cfg.recmdHolystripeId)

	self._tableCell:SetActive(false)
	self:_updataView()
end

function HolyStripeMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._updataView, self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeLoadAllRes, self._PM_HolyStripeLoadAllRes, self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeEquipRes, self._PM_HolyStripeEquipRes, self)
	self:_resetEquipItems()
	UIEffectManager.instance:stopEffect(self._backEffectHandler)
	MaterialMgr.resetAll(self._suitIcon)
end

function HolyStripeMainView:_updataView()
	if HolyStripeController.instance:getIsEquipHolyStripes() == true then
		return
	end

	self:_parseData()
	self:_setEquipItems()
	self:_showSuit()
	self:_refreshAllAttr()
	self:_refreshRecommeds()
end

function HolyStripeMainView:_parseData()
	self._curPetId = HolyStripeModel.instance:getCurrShowPetId()
	self._equipList = HolyStripeModel.instance:getEquippedByPetId(self._curPetId) or {}
	self._id2posList = self._id2posList or {}
	self._posDataList = {}

	for i, v in ipairs(self._equipList) do
		local defineId = v:getDefineId()
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(defineId)

		self._id2posList[defineId] = cfg.positionType
		self._posDataList[cfg.positionType] = v
	end
end

function HolyStripeMainView:_setEquipItems()
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""
		v.nameText.text = ""

		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			self:_onItemBtnClick(i, false)
		end)
		goutil.setActive(v.icon, false)
		goutil.setActive(v.quality, false)
		MaterialMgr:clearIcon(v.icon)

		if v.select then
			goutil.setActive(v.select, false)
		end

		if FormationGroupModel.instance:checkIsInTeam(HolyStripeModel.instance:getCurrShowPetId()) then
			if HolyStripeModel.instance:getIsPickHolyStripeSlot(HolyStripeModel.instance:getCurrShowPetId()) then
				goutil.setActive(v.redPoint, false)
			else
				goutil.setActive(v.redPoint, true)
			end
		else
			goutil.setActive(v.redPoint, false)
		end
	end

	for posType, v in pairs(self._posDataList) do
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(v:getDefineId())
		local iconGo = self._equipItems[posType].icon
		local quality = self._equipItems[posType].quality
		local qualityUIChange = self._equipItems[posType].qualityUIChange

		self._equipItems[posType].lvText.text = v:getLv() > 0 and "Lv." .. v:getLv() or ""

		local _, color
		local var_11_0, var_11_1 = PetEquipController:GetQualityStrByNum(v:getQuality())

		_ = var_11_0
		self._equipItems[posType].nameText.text = langPara("<color=%s>%s</color>", var_11_1, cfg.name)

		goutil.setActive(quality, true)
		qualityUIChange:SetState(cfg.quality)
		MaterialMgr.setIcon(iconGo, MatType.HolyStripe, v:getDefineId())
		goutil.setActive(iconGo, true)
		self._equipItems[posType].btn:RemoveClickListener()
		goutil.setActive(self._equipItems[posType].redPoint, false)
		self._equipItems[posType].btn:AddClickListener(function()
			self:_onItemBtnClick(posType, true, v:getId())
		end)
	end
end

function HolyStripeMainView:_resetEquipItems()
	for i, item in ipairs(self._equipItems) do
		item.btn:RemoveClickListener()
		MaterialMgr:clearIcon(item.icon)
		MaterialMgr.resetAll(item.icon)
	end
end

function HolyStripeMainView:_showSuit()
	local suitList = HolyStripeModel.instance:getCurSuitList()

	self._suitDesc.text = ""

	goutil.setActive(self._suitIcon, true)
	MaterialMgr.resetAll(self._suitIcon)

	for i, v in ipairs(suitList) do
		if v.num >= 4 then
			local iconCfg = HolyStripeConfig.instance:getSuitInfo(v.suitType)

			MaterialMgr.setIcon(self._suitIcon, MatType.HolyStripe, iconCfg.cfg.id)

			self._suitDesc.text = v.doc

			return
		end
	end

	goutil.setActive(self._suitIcon, false)

	self._suitDesc.text = lang("未激活套装4件套效果")
end

function HolyStripeMainView:_refreshAllAttr()
	local attrs = HolyStripeModel.instance:getCurWearAttrList()

	if #attrs == 0 then
		for i, v in ipairs(HolyStripeModel.DefaultAttr) do
			table.insert(attrs, {
				value = 0,
				type = v,
				name = ConstString.HolyStripeAttr[v]
			})
		end
	end

	self._attrScrollList:reloadData(attrs)
end

function HolyStripeMainView:_refreshRecommeds()
	local curFaceId = HolyStripeModel.instance:getCurShowFaceId()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	self._txtRecommen.text = langPara("推荐灵纹：%s", (cfg or nil) and cfg.recmdHolystripeId)
end

function HolyStripeMainView:_onItemBtnClick(posType, equip, id)
	if equip and id then
		UIStateManager.instance:push(ViewName.HolyStripeTipsView, id)
	else
		if HolyStripeModel.instance:getIsPickHolyStripeSlot(HolyStripeModel.instance:getCurrShowPetId()) == nil then
			HolyStripeModel.instance:setIsPickHolyStripeSlot(HolyStripeModel.instance:getCurrShowPetId())
		end

		UIStateManager.instance:push(ViewName.HolyStripeBagView, 0, posType)
	end
end

function HolyStripeMainView:_onChangeBtnClick()
	if HolyStripeModel.instance:getIsPickHolyStripeSlot(HolyStripeModel.instance:getCurrShowPetId()) == nil then
		HolyStripeModel.instance:setIsPickHolyStripeSlot(HolyStripeModel.instance:getCurrShowPetId())
	end

	UIStateManager.instance:push(ViewName.HolyStripeBagView)
end

function HolyStripeMainView:_onOneKeyTakeOffBtnClick()
	local petId = BagPetsController.instance:GetCurPetId()

	HolyStripeAgent.instance:sendPM_HolyStripeUnloadAllReq({
		petId
	})
end

function HolyStripeMainView:_onBtnClickInTakeOff()
	self:_onOneKeyTakeOffBtnClick()
end

function HolyStripeMainView:_onBtnPressStartInTakeOff()
	self._imgProgress.fillAmount = 0

	GameUtil.SetActive(self._imgProgress, true)
end

function HolyStripeMainView:_onBtnPressEndInTakeOff(pressTime)
	GameUtil.SetActive(self._imgProgress, false)
end

function HolyStripeMainView:_onBtnPressUpdateTimeOverOnce(pressTime)
	UIStateManager.instance:push(ViewName.OneKeyUnloadPetView)
end

function HolyStripeMainView:_onBtnPressUpdateInTakeOff(deltaTime, pressTime)
	self._imgProgress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function HolyStripeMainView:_onOneKeyTakeOnBtnClick()
	local petId = BagPetsController.instance:GetCurPetId()
	local result = HolyStripeController.instance:_calculateOneKeyEquip(petId, false)
	local list = {}

	for i, v in pairs(result) do
		table.insert(list, v:getId())
	end

	if #list > 0 then
		HolyStripeController.instance:equipHolyStripes(petId, list)
	end
end

function HolyStripeMainView:_onClickSmeltBtnClick()
	UIStateManager.instance:push(ViewName.HolyStripeSmeltView)
end

function HolyStripeMainView:_onClickSuitSet()
	UIStateManager.instance:push(ViewName.HolyStripeSuitGroupView)
end

function HolyStripeMainView:_onClickCalculate()
	UIStateManager.instance:push(ViewName.HolyStripeRecommendCalcView)
end

function HolyStripeMainView:_updataCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt = goutil.findChildTextComponent(go, "nameText")
	local valueTxt = goutil.findChildTextComponent(go, "valueText")
	local iconGo = goutil.findChild(go, "attr")
	local icon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")

	if data.type then
		goutil.setActive(iconGo, true)
		icon:SetState(data.type - 1)
	else
		goutil.setActive(iconGo, false)
	end

	valueTxt.text = data.value > 0 and data.value < 1 and string.format("%s%%", data.value * 100) or data.value
	nameTxt.text = data.name
end

function HolyStripeMainView:_clearCell(cell)
	return
end

function HolyStripeMainView:_PM_HolyStripeLoadAllRes()
	self:_updataView()
end

function HolyStripeMainView:_PM_HolyStripeEquipRes()
	if not ViewMgr.instance:isOpen(ViewName.HolyStripeMainView) then
		return
	end

	self:_updataView()
end

return HolyStripeMainView
