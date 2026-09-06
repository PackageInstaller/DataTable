-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/exchange/ExchangeSelectView.lua

module("logic.extensions.firstannualwelfare.exchange.view.ExchangeSelectView", package.seeall)

local ExchangeSelectView = class("ExchangeSelectView", ViewComponent)

function ExchangeSelectView:ctor()
	ExchangeSelectView.super.ctor(self)
end

function ExchangeSelectView:buildUI()
	ExchangeSelectView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtExchangeTips = goutil.findChildTextComponent(self.mainGO, "txtExchangeTips")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._matScrollerview = goutil.findChild(self.mainGO, "matCol/matScrollerview")
	self._matScrollercell = goutil.findChild(self.mainGO, "matCol/matScrollercell")
	self._txtAttrName = goutil.findChildTextComponent(self.mainGO, "txtAttrName")
	self._attrCol = goutil.findChild(self.mainGO, "attrCol")
	self._attrCell = goutil.findChild(self.mainGO, "attrCol/attrCell")
	self._matScrollList = ScrollerList.create(self._matScrollerview, self._matScrollercell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))
	self._selectEff = nil
	self._sifterItem = self:getGo("sifterItem")
	self._filtercon = self:getGo("filtercon")

	goutil.setActive(self._sifterItem, false)

	self._sifterList = {}
end

function ExchangeSelectView:bindEvents()
	ExchangeSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function ExchangeSelectView:unbindEvents()
	ExchangeSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ExchangeSelectView:destroyUI()
	ExchangeSelectView.super.destroyUI(self)
end

function ExchangeSelectView:onEnter()
	ExchangeSelectView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)

	self._sifterList = {}

	local params = self:getOpenParam() or {}

	self._exchangeId = checknumber(params[1])
	self._selectIndex = checknumber(params[2])
	self._poolType = checknumber(params[3])

	local isPoolCCostType = self._poolType == 3

	if self._exchangeId == 0 then
		FloatWordMgr.instance:show("缺少传入参数")
		self:close()

		return
	end

	self._exchangeData = FirstAnnualWelfareConfig.instance:getExchangeData(self._exchangeId)
	self._cPoolCfg = FirstAnnualWelfareConfig.instance:getCPoolCfg(self._exchangeData.poolId)

	if isPoolCCostType then
		self._cPoolCfg = FirstAnnualWelfareConfig.instance:getCCostPoolCfg(self._exchangeData.poolId)
	end

	self._poolId = self._exchangeData.poolId
	self._matType = self._exchangeData.matType

	self:_onSetUI()
	self:_onUpdate()
end

function ExchangeSelectView:onExit()
	ExchangeSelectView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._selectEff)

	self._selectEff = nil

	self:_clearAttrCol()
	GlobalDispatcher:removeListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)
end

function ExchangeSelectView:_onSetUI()
	local matType = self._matType
	local titleStr = ""

	if matType == MatType.Equipment then
		titleStr = "选择装备"
	elseif matType == MatType.StarGodPlus then
		titleStr = "选择星神"
	end

	self._txtTitle.text = titleStr

	local isNeedTips = not string.nilorempty(self._exchangeData.exchangeTips)

	GameUtil.SetActive(self._txtExchangeTips.gameObject, isNeedTips)

	self._txtExchangeTips.text = self._exchangeData.exchangeTips

	self:_setSifterItems()
end

function ExchangeSelectView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ExchangeSelectView:_onUpdateData()
	self:_onUpdateMatData()
end

function ExchangeSelectView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_updateMatScrollerList()
	self:_onUpdateAttrCol()
end

function ExchangeSelectView:_onUpdateMatData()
	self._matDataList = {}

	local matType = self._matType

	if matType == MatType.Equipment then
		for matIdx, v in ipairs(self._cPoolCfg) do
			local matId = v.defineId
			local eqData = EquipmentConfig.instance:GetEquipDefineInfoById(matId)
			local eqLevelData = EquipmentConfig.instance:GetEquipInfoByLvl(eqData.equipmentLvStrategy, 0)

			self._matDataList[matIdx] = {
				matType = matType,
				matId = matId,
				matName = eqData.name,
				attrList = self:_parseAttr(eqLevelData.propertyApp)
			}
		end
	elseif matType == MatType.StarGodPlus then
		for matIdx, v in ipairs(self._cPoolCfg) do
			local matId = v.defineId
			local sgData = StargodplusConfig.instance:getFillerCfg(matId)
			local sgPropData = StargodplusConfig.instance:getPropCfg(matId, 1)

			self._matDataList[matIdx] = {
				matType = matType,
				matId = matId,
				matName = sgData.name,
				attrList = self:_parseAttr(sgPropData.propertyApp)
			}
		end
	end
end

function ExchangeSelectView:_parseAttr(attrStr)
	local attrList = {}
	local attrArray = string.split(attrStr, "#")

	for _, v in ipairs(attrArray) do
		local arr = string.split(v, "+")
		local t = {
			attrName = arr[1],
			attrValue = arr[2],
			attrIconState = self:_getAttrIconState(arr[1])
		}

		table.insert(attrList, t)
	end

	return attrList
end

function ExchangeSelectView:_getAttrIconState(attrName)
	for state, name in ipairs(GameEnum.AttrTypeName) do
		if name == attrName then
			return state - 1
		end
	end
end

function ExchangeSelectView:_getMatData(matIdx)
	return self._matDataList[matIdx]
end

function ExchangeSelectView:_getMatName(matIdx)
	local matData = self:_getMatData(matIdx) or {}

	return matData.matName
end

function ExchangeSelectView:_getMatAttrList(matIdx)
	local matData = self:_getMatData(matIdx) or {}

	return matData.attrList
end

function ExchangeSelectView:_onUpdatePlaneUI()
	return
end

function ExchangeSelectView:_updateMatScrollerList()
	goutil.setActive(self._filtercon, self._matType == MatType.Equipment)

	local dataList = self:_getCurDataList()

	self._matScrollList:reloadData(dataList)
	self._matScrollList:MoveCellInView(self._selectIndex - 1, false)
end

function ExchangeSelectView:_updateMatCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local change = goutil.findChildComponent(mainGo, "txtName", "UITextColorChange")
	local isSelected = self._selectIndex == data.index

	if item then
		local matStr = string.format("%s:%s:%s", self._matType, data.defineId, 0)
		local proxy = MaterialMgr.setCellByCfg(matStr, item)

		proxy.binder:setAutoTips(false)
		proxy.binder:setSelected(isSelected)
		proxy.binder:setLvl(0)

		if self._matType == MatType.StarGodPlus then
			txtName.text = MaterialMgr.getMaterialsName(self._matType, data.defineId)

			local cfg = MaterialMgr.getMatCfg(self._matType, data.defineId)

			change:SetState(cfg.quality)
		else
			txtName.text = ""
		end
	end

	if isSelected then
		local effGo = item
		local path = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei"

		UIEffectManager.instance:stopEffect(self._selectEff)

		if effGo and not string.nilorempty(path) then
			local pathName = path .. ".prefab"

			local function func(_, eff)
				eff:setParent(effGo.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)
			end

			self._selectEff = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
		end
	end

	local function handler()
		self._selectIndex = self._selectIndex == data.index and 0 or data.index

		self:_onUpdateUI()
	end

	GameUtil.addClickHandler(btnSelect, handler)
end

function ExchangeSelectView:_clearMatCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(mainGo)
end

function ExchangeSelectView:_onUpdateAttrCol()
	local matName = self:_getMatName(self._selectIndex)

	self._txtAttrName.text = matName or ""

	local childList = GameUtil.getChildren(self._attrCol)

	for _, go in ipairs(childList) do
		GameUtil.SetActive(go, false)
	end

	self._attrCellList = {}

	local attrList = self:_getMatAttrList(self._selectIndex)

	if attrList ~= nil then
		for idx, data in ipairs(attrList) do
			local cell = {}

			cell._mainGo = childList[idx] or goutil.cloneAndSetParent(self._attrCell, self._attrCol.transform)
			cell._icon = goutil.findChild(cell._mainGo, "icon")
			cell._txtAttr = goutil.findChildTextComponent(cell._mainGo, "txtAttr")
			cell._change = cell._icon:GetComponent(ComponentType.UIImageSpriteChange)

			table.insert(self._attrCellList, cell)
			GameUtil.SetActive(cell._mainGo, true)

			cell._mainGo.name = string.format("attrCell_%d", idx)
			cell._txtAttr.text = data.attrName .. " +" .. data.attrValue

			cell._change:SetState(data.attrIconState)
		end
	end
end

function ExchangeSelectView:_clearAttrCol()
	local childList = GameUtil.getChildren(self._attrCol)

	for _, go in ipairs(childList) do
		local icon = goutil.findChild(go, "icon")

		uGuiUtil.clearImage(icon)
	end
end

function ExchangeSelectView:_onClickSure()
	GlobalDispatcher:dispatch(GlobalNotify.FirstAnnualWelfareExchangeTargetMat, self._poolId, self._selectIndex)
	self:close()
end

local FILTERPAMAMSTR = "exchangeselectview#3:属性:属性筛选:212,152#4:职业:职业筛选:310,152"

function ExchangeSelectView:_setSifterItems()
	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self._sifterParams = PetEquipModel.instance:getFactorySifterCfgs(FILTERPAMAMSTR, self._viewPresentor.viewName)
	self._sifterItems = self._sifterItems or {}

	if self._sifterParams and #self._sifterParams > 0 then
		for i = 1, #self._sifterParams do
			local index = i

			if self._sifterItems[index] == nil or self._sifterItems[index].itemGo == nil then
				self._sifterItems[index] = {}

				local go = UnityEngine.GameObject.Instantiate(self._sifterItem, self._filtercon.transform)

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
end

function ExchangeSelectView:_onClickSifterItemBtn(index)
	if self._sifterParams == nil or self._sifterParams[index] == nil then
		return
	end

	local info = self._sifterParams[index]

	if info.planId <= 0 or info.subList == nil or info.subList[1] and info.subList[1].showType <= 0 then
		self._sifterList = {}

		self:_updateMatScrollerList()

		return
	end

	ViewMgr.instance:open(ViewName.EquipFactorySifter, {
		alchemyType = PetEquipModel.AlchemyType.Equip,
		btnTabInfo = info,
		choList = (self._sifterList and self._sifterList[info.planId] or nil) and self._sifterList[info.planId],
		itemGo = self._sifterItems[index].itemGo
	})
end

function ExchangeSelectView:_updataSelectSifter(viewName, ayType, planId, attrs, isReset)
	if viewName == nil or viewName ~= self._viewPresentor.viewName or ayType == nil or PetEquipModel.AlchemyType.Equip ~= ayType then
		return
	end

	self._sifterList = self._sifterList or {}

	if isReset then
		self._sifterList = {}
	else
		planId = checknumber(planId)
		self._sifterList[planId] = attrs
	end

	self:_updateMatScrollerList()
end

function ExchangeSelectView:_getCurDataList()
	if self._matType == MatType.Equipment then
		local dataList = {}

		for i, cfg in ipairs(self._cPoolCfg) do
			if self:_checkIsMatchFilter(cfg) then
				table.insert(dataList, cfg)
			end
		end

		return dataList
	else
		return self._cPoolCfg
	end
end

function ExchangeSelectView:_checkIsMatchFilter(cfg)
	if self._matType ~= MatType.Equipment then
		return fasle
	end

	local mo = PetEquipModel.instance:GetTemporaryEquip(cfg.defineId, 0)

	return PetEquipModel.instance:_isConformEquipSifter(mo, self._sifterList)
end

return ExchangeSelectView
