-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/StarGodSelectView.lua

module("logic.extensions.petequip.view.StarGodSelectView", package.seeall)

local StarGodSelectView = class("StarGodSelectView", ViewComponent)

function StarGodSelectView:ctor()
	StarGodSelectView.super.ctor(self)

	self._choId = nil
end

function StarGodSelectView:buildUI()
	StarGodSelectView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._sureBtn = goutil.findChild(self.mainGO, "sureBtn")
	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "titleTxt")
	self._tipsTxt = goutil.findChildTextComponent(self.mainGO, "tipsTxt")
	self._attrNameTxt = goutil.findChildTextComponent(self.mainGO, "attrNameTxt")
	self._stargodListSR = goutil.findChild(self.mainGO, "stargodListSR")
	self._stargodCell = goutil.findChild(self.mainGO, "stargodCell")
	self._attrCol = goutil.findChild(self.mainGO, "attrCol")
	self._attrCell = goutil.findChild(self.mainGO, "attrCol/attrCell")
	self._sifterItem = self:getGo("sifterItem")

	GameUtil.SetActive(self._sifterItem, false)

	self._matScrollList = ScrollerList.create(self._stargodListSR, self._stargodCell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))
end

function StarGodSelectView:bindEvents()
	StarGodSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
	GameUtil.addClickHandler(self._sureBtn, function()
		if checknumber(self._choId) <= 0 then
			if self._params.alchemyType == PetEquipModel.AlchemyType.StarGod then
				FloatWordMgr.instance:show("请选择要兑换的星神")
			elseif self._params.alchemyType == PetEquipModel.AlchemyType.Equip then
				FloatWordMgr.instance:show("请选择要兑换的装备")
			elseif self._params.alchemyType == PetEquipModel.AlchemyType.Artifact then
				FloatWordMgr.instance:show("请选择要兑换的收藏品")
			end

			return
		end

		GlobalDispatcher:dispatch(GlobalNotify.Factory_UpdataShowSelectMat, self._choId)
		self:close()
	end, self)
end

function StarGodSelectView:unbindEvents()
	StarGodSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
	GameUtil.rmClickHandler(self._sureBtn)

	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function StarGodSelectView:onExit()
	StarGodSelectView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._selectEff)
	GlobalDispatcher:removeListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)

	self._selectEff = nil
	self._choId = nil

	self:_clearAttrCol()
	self:clearAllEffect()
end

function StarGodSelectView:clearAllEffect()
	if self.effectList then
		for i, v in ipairs(self.effectList) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self.effectList = nil
end

function StarGodSelectView:destroyUI()
	StarGodSelectView.super.destroyUI(self)

	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._sifterItems = nil
end

function StarGodSelectView:onEnter()
	StarGodSelectView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.cfg == nil then
		FloatWordMgr.instance:show("缺少传入参数")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)

	if self._params.alchemyType == PetEquipModel.AlchemyType.Equip then
		self._titleTxt.text = lang("text_equip_desc_98")
	elseif self._params.alchemyType == PetEquipModel.AlchemyType.Artifact then
		self._titleTxt.text = lang("text_equip_desc_99")
	elseif self._params.alchemyType == PetEquipModel.AlchemyType.StarGod then
		self._titleTxt.text = lang("text_equip_desc_100")
	end

	self._tipsTxt.text = self._params.cfg.selectDesc
	self._choId = checknumber(self._params.sifterId)
	self._sifterList = {}

	self:_onUpdateUI()
end

function StarGodSelectView:_onUpdateUI()
	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self._sifterParams = PetEquipModel.instance:getFactorySifterCfgs(self._params.cfg.targetSifter, self._viewPresentor.viewName)
	self._sifterItems = self._sifterItems or {}

	if self._sifterParams and #self._sifterParams > 0 then
		for i = 1, #self._sifterParams do
			local index = i

			if self._sifterItems[index] == nil or self._sifterItems[index].itemGo == nil then
				self._sifterItems[index] = {}

				local go = UnityEngine.GameObject.Instantiate(self._sifterItem, self.mainGO.transform)

				go.name = "sifterItem_" .. index
				self._sifterItems[index].itemGo = go
				self._sifterItems[index].itemGrg = go:GetComponent("UIImageSpriteChange")
				self._sifterItems[index].nameTxt = goutil.findChildTextComponent(go, "sifterTxt")
			end

			GameUtil.SetActive(self._sifterItems[index].itemGo, true)

			self._sifterItems[index].nameTxt.text = self._sifterParams[index].btnName

			Framework.TransformUtil.SetLocalPos(self._sifterItems[index].itemGo.transform, checknumber(self._sifterParams[index].btnPos[1]), checknumber(self._sifterParams[index].btnPos[2]), 0)
			GameUtil.asBtn(self._sifterItems[index].itemGo):AddClickListener(function()
				self:_onClickSifterItemBtn(index)
			end, self)
		end
	end

	self:_showSelectMatInfo()
end

function StarGodSelectView:_updataSelectSifter(viewName, ayType, planId, attrs, isReset)
	if viewName == nil or viewName ~= self._viewPresentor.viewName or ayType == nil or self._params.alchemyType ~= ayType then
		return
	end

	self._sifterList = self._sifterList or {}

	if isReset then
		self._sifterList = {}
	else
		planId = checknumber(planId)
		self._sifterList[planId] = attrs
	end

	self:_showSelectMatInfo()
end

function StarGodSelectView:_onClickSifterItemBtn(index)
	if self._sifterParams == nil or self._sifterParams[index] == nil then
		return
	end

	local info = self._sifterParams[index]

	if info.planId <= 0 or info.subList == nil or info.subList[1] and info.subList[1].showType <= 0 then
		self._sifterList = {}

		self:_showSelectMatInfo()

		return
	end

	ViewMgr.instance:open(ViewName.EquipFactorySifter, {
		alchemyType = self._params.alchemyType,
		btnTabInfo = info,
		choList = (self._sifterList and self._sifterList[info.planId] or nil) and self._sifterList[info.planId],
		itemGo = self._sifterItems[index].itemGo
	})
end

function StarGodSelectView:_showSelectMatInfo(onlyRefresh)
	if checkbool(onlyRefresh) == true then
		self._matScrollList:refresh()
	else
		self:clearAllEffect()

		self._matDataList = PetEquipModel.instance:getConformEquipSifterPool(self._params.alchemyType, self._params.cfg, self._sifterList)

		if self._params.alchemyType == PetEquipModel.AlchemyType.Equip then
			for i, v in ipairs(self._matDataList) do
				local equipCfg = EquipmentConfig.instance:GetEquipDefineInfoById(v)

				if equipCfg and string.nilorempty(equipCfg.additionRaceType) then
					table.remove(self._matDataList, i)
				end
			end
		end

		self._matScrollList:reloadData(self._matDataList)
	end

	local childList = GameUtil.getChildren(self._attrCol)

	for _, go in ipairs(childList) do
		GameUtil.SetActive(go, false)
	end

	self._attrNameTxt.text = ""

	local attrList = {}

	if self._choId > 0 then
		self._attrNameTxt.text = MaterialMgr.getMaterialsName(self._params.cfg.matType, self._choId)

		if self._params.alchemyType == PetEquipModel.AlchemyType.Equip then
			local baseCfg = EquipmentConfig.instance:GetEquipDefineInfoById(self._choId)

			if baseCfg and baseCfg.equipmentLvStrategy > 0 then
				local lvCfg = EquipmentConfig.instance:GetEquipInfoByLvl(baseCfg.equipmentLvStrategy)

				if lvCfg and not string.nilorempty(lvCfg.propertyApp) then
					attrList = self:_parseAttr(lvCfg.propertyApp)
				end
			end
		elseif self._params.alchemyType == PetEquipModel.AlchemyType.Artifact then
			local lvCfgs = ThroneConfig.instance:getLvStrategyCfg(self._choId)

			if lvCfgs and lvCfgs[0] and not string.nilorempty(lvCfgs[0].mainProps) then
				attrList = self:_parseAttr(lvCfgs[0].mainProps)
			end
		elseif self._params.alchemyType == PetEquipModel.AlchemyType.StarGod then
			local lvCfg = StargodplusConfig.instance:getPropCfg(self._choId, 1)

			if lvCfg and not string.nilorempty(lvCfg.propertyApp) then
				attrList = self:_parseAttr(lvCfg.propertyApp)
			end
		end
	end

	self._attrCellList = {}

	for idx, data in ipairs(attrList or {}) do
		local cell = {}

		cell.mainGo = childList[idx] or goutil.cloneAndSetParent(self._attrCell, self._attrCol.transform)
		cell.iconGo = goutil.findChild(cell.mainGo, "icon")
		cell.attrTxt = goutil.findChildTextComponent(cell.mainGo, "txtAttr")
		cell.iconChg = cell.iconGo:GetComponent(ComponentType.UIImageSpriteChange)

		table.insert(self._attrCellList, cell)
		GameUtil.SetActive(cell.mainGo, true)

		cell.mainGo.name = string.format("attrCell_%d", idx)
		cell.attrTxt.text = data.attrName .. " +" .. data.attrValue

		cell.iconChg:SetState(data.attrIconState)
	end
end

function StarGodSelectView:_parseAttr(attrStr)
	local attrList = {}
	local attrArray = string.split(attrStr, "#")

	for _, v in ipairs(attrArray) do
		local arr = string.split(v, "+")
		local value = table.indexof(GameEnum.AttrTypeName, arr[1])
		local state = value == false and 0 or checknumber(value) - 1
		local list = {
			"暴击率",
			"防爆率",
			"命中率",
			"闪避率",
			"破击率",
			"格挡率"
		}

		table.insert(attrList, {
			attrName = arr[1],
			attrValue = (table.indexof(list, arr[1]) or nil) and string.format("%s%%", checknumber(arr[2]) * 100),
			attrIconState = state
		})
	end

	return attrList
end

function StarGodSelectView:_updateMatCell(view, cell, data)
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local choiseGo = goutil.findChild(cell, "choiseGo")
	local clickBtnGo = goutil.findChild(cell, "clickBtnGo")
	local isSelected = self._choId == data

	GameUtil.SetActive(choiseGo, isSelected)

	nameTxt.text = MaterialMgr.getMaterialsName(self._params.cfg.matType, data)

	local matStr = string.format("%s:%s:%s", self._params.cfg.matType, data, 0)
	local proxy = MaterialMgr.setCellByCfg(matStr, goodsPos)

	proxy.binder:setAutoTips(false)
	proxy.binder:setSelected(isSelected)
	proxy.binder:setLvl(0)
	GameUtil.addClickHandler(clickBtnGo, function()
		if self._choId == data then
			self._choId = 0
		else
			self._choId = data

			self:clearAllEffect()

			local path = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei.prefab"

			local function func(_, eff)
				eff:setParent(goodsPos.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)
			end

			local effect = UIEffectManager.instance:playEffect(self, path, goodsPos, 0, 0, false, false, nil, func, nil)

			self.effectList = self.effectList or {}

			table.insert(self.effectList, effect)
		end

		self:_showSelectMatInfo(true)
	end)
end

function StarGodSelectView:_clearMatCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell, "goodsPos"))
	GameUtil.rmClickHandler(cell)
end

function StarGodSelectView:_clearAttrCol()
	local childList = GameUtil.getChildren(self._attrCol)

	for _, go in ipairs(childList) do
		uGuiUtil.clearImage(goutil.findChild(go, "icon"))
	end
end

return StarGodSelectView
