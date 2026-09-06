-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipSelectListView.lua

module("logic.extensions.equipment.view.EquipSelectListView", package.seeall)

local EquipSelectListView = class("EquipSelectListView", TableViewComponent)

function EquipSelectListView:ctor()
	EquipSelectListView.super.ctor(self)

	self._sifterItems = nil
	self._sifterList = nil
	self._filterItems = nil
end

function EquipSelectListView:bindEvents()
	EquipSelectListView.super.bindEvents(self)
	GameUtil.asBtn(self._clickGo):AddClickListener(self.close, self)
end

function EquipSelectListView:unbindEvents()
	EquipSelectListView.super.unbindEvents(self)
	GameUtil.asBtn(self._clickGo):RemoveClickListener()

	for _, item in pairs(self._filterItems or {}) do
		if item and item.itemTog then
			item.itemTog:RemoveOnValueChanged()
		end
	end

	GameUtil.asBtn(self._sifterItem):RemoveClickListener()
end

function EquipSelectListView:onExit()
	EquipSelectListView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)

	self._funCfg = nil
	self._curParams = nil
	self._curInfoMo = nil
end

function EquipSelectListView:destroyUI()
	EquipSelectListView.super.destroyUI(self)
end

function EquipSelectListView:buildUI()
	EquipSelectListView.super.buildUI(self)

	self._clickGo = self:getGo("clickGo")

	local infoGo = self:getGo("infoGo")

	self._filterInfoGo = goutil.findChild(infoGo, "filterInfoGo")
	self._filterItems = {}

	local var_6_0 = {
		itemTog = Framework.ToggleAdapter.GetFrom(self._filterInfoGo, "filterItem_1/itemTog")
	}

	var_6_0.itemTcc = goutil.findChild(self._filterInfoGo, "filterItem_1/itemTxt"):GetComponent("UITextColorChange")
	self._filterItems[1] = var_6_0

	local var_6_1 = {
		itemTog = Framework.ToggleAdapter.GetFrom(self._filterInfoGo, "filterItem_2/itemTog")
	}

	var_6_1.itemTcc = goutil.findChild(self._filterInfoGo, "filterItem_2/itemTxt"):GetComponent("UITextColorChange")
	self._filterItems[2] = var_6_1

	local var_6_2 = {
		itemTog = Framework.ToggleAdapter.GetFrom(self._filterInfoGo, "filterItem_3/itemTog")
	}

	var_6_2.itemTcc = goutil.findChild(self._filterInfoGo, "filterItem_3/itemTxt"):GetComponent("UITextColorChange")
	self._filterItems[3] = var_6_2
	self._sifterItemTran = goutil.findChild(infoGo, "sifterItemTran").transform
	self._sifterItem = goutil.findChild(infoGo, "sifterItem")
	self._noListTxt = goutil.findChildTextComponent(infoGo, "noListTxt")
	self._noListTxt.text = ""
end

function EquipSelectListView:onEnter()
	EquipSelectListView.super.onEnter(self)

	local openParams = self:getOpenParam()

	if openParams then
		self._funcType = openParams[1] or nil
	end

	if openParams then
		self._selectList = openParams[2] or nil
	end

	if self._funcType == nil or self._selectList == nil or #self._selectList == 0 then
		printError("sr---EquipSelectListView:onEnter()    请正确传入参数！！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)

	if openParams then
		self._curInfoMo = openParams[3] or nil
	end

	if openParams then
		if not openParams[4] then
			local sifters

			if openParams then
				if not openParams[5] then
					local isShowTog = false

					self:_initFilterSifterItems(isShowTog, sifters)
					self:_updataShowSelectListSR()
				end
			end
		end
	end
end

function EquipSelectListView:_initFilterSifterItems(isShowTog, sifters)
	self._showTog = PetEquipModel.FilterType.AllTogType

	if isShowTog then
		GameUtil.SetActive(self._filterInfoGo, true)

		for i = 1, #self._filterItems do
			self._filterItems[i].itemTog:AddOnValueChanged(function(go, isOn)
				self:_onToggleValueChanged(i - 1, isOn)
			end)
		end

		for i = 1, #self._filterItems do
			if self._filterItems[i] and self._filterItems[i].itemTcc then
				self._filterItems[i].itemTcc:SetState(i == self._showTog + 1 and 1 or 0)
			end
		end
	else
		GameUtil.SetActive(self._filterInfoGo, false)
	end

	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self._sifterParams = {}

	if not string.nilorempty(sifters) then
		local list = string.split(sifters, "|")

		for _, v in pairs(list or {}) do
			if v and not string.nilorempty(v) then
				local aa = PetEquipModel.instance:getFactorySifterCfgs(v, self._viewPresentor.viewName)

				if aa and #aa > 0 then
					self._sifterParams = aa

					break
				end
			end
		end
	end

	GameUtil.asBtn(self._sifterItem):AddClickListener(function()
		self:_onClickSifterItemBtn()
	end, self)
end

function EquipSelectListView:_updataShowSelectListSR()
	self._curViewDatas = {}

	if self._funcType == PetEquipModel.FunctionType.SttnType or self._funcType == PetEquipModel.FunctionType.TupoType then
		local list_1 = PetEquipModel.instance:getStrengthenEquipSelectList(self._sifterList, self._showTog)
		local list_2 = PetEquipModel.instance:getTupoEquipSelectList(self._sifterList, self._showTog)
		local result = {}

		for i, v in ipairs(list_2) do
			table.insert(result, v)
		end

		for i, v in ipairs(list_1) do
			table.insert(result, v)
		end

		self._curViewDatas = result
	elseif self._funcType == PetEquipModel.FunctionType.ReyeType then
		-- block empty
	end

	self._noListTxt.text = (self._curViewDatas == nil or #self._curViewDatas == 0) and lang("text_equip_desc_77") or ""

	self:reloadData()
end

function EquipSelectListView:_onToggleValueChanged(index, isOn)
	if not isOn then
		return
	end

	self._showTog = index

	for i = 1, #self._filterItems do
		if self._filterItems[i] and self._filterItems[i].itemTcc then
			self._filterItems[i].itemTcc:SetState(i == self._showTog + 1 and 1 or 0)
		end
	end

	self:_updataShowSelectListSR()
end

function EquipSelectListView:_onClickSifterItemBtn()
	local var_13_0 = {
		alchemyType = PetEquipModel.AlchemyType.Equip,
		btnTabInfo = self._sifterParams
	}

	var_13_0.choList = self._sifterList or {}
	var_13_0.itemGo = self._sifterItem

	UIStateManager.instance:open(ViewName.EquipFilterView, var_13_0)
end

function EquipSelectListView:_updataSelectSifter(viewName, ayType, planId, attrs, isReset)
	if viewName ~= self._viewPresentor.viewName or ayType ~= PetEquipModel.AlchemyType.Equip then
		return
	end

	self._sifterList = self._sifterList or {}

	if isReset then
		self._sifterList = {}
	else
		planId = checknumber(planId)
		self._sifterList[planId] = attrs
	end

	self:_updataShowSelectListSR()
end

function EquipSelectListView:_getPath()
	return {
		cellPath = "infoGo/itemCell",
		viewPath = "infoGo/itemListSR"
	}
end

function EquipSelectListView:_cellSize()
	return 100, 100
end

function EquipSelectListView:_updateCell(view, cell, data)
	local equipPos = goutil.findChild(cell, "equipPos")
	local petIconGo = goutil.findChild(cell, "petIconGo")
	local petIcon = goutil.findChild(petIconGo, "icon")
	local clickBtnGo = goutil.findChild(cell, "clickBtnGo")
	local choiseGo = goutil.findChild(cell, "choiseGo")

	GameUtil.asBtn(clickBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(equipPos)
	MaterialMgr.resetAll(petIcon)

	local isSelect = table.indexof(self._selectList, data.onlyId) ~= false

	choiseGo:SetActive(isSelect)

	local subLua = MaterialMgr.setCellByData(data.matType, data, equipPos)

	subLua.binder:setNum(1)
	subLua.binder:setAutoTips(false)
	subLua.binder:setSelected(isSelect)

	if data:isWearEquip() then
		GameUtil.SetActive(petIconGo, true)

		local petInfo = BagPetsController.instance:getPet(data.equipPetId)

		MaterialMgr.setIcon(petIcon, MatType.Pet, petInfo.raceId)
	else
		GameUtil.SetActive(petIconGo, false)
	end

	GameUtil.asBtn(clickBtnGo):AddClickListener(function()
		if isSelect then
			FloatWordMgr.instance:show("已选择了当前装备")

			return
		end

		if self:_isSelectItemFull(data.onlyId) then
			FloatWordMgr.instance:show("已经达到最大可以选择装备数")
		else
			GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_SELECT, data.onlyId)
			self:reloadData()
		end
	end)
end

function EquipSelectListView:_isSelectItemFull(onlyId)
	if self._selectList == nil or #self._selectList == 0 then
		return true
	end

	if #self._selectList == 1 then
		self._selectList[1] = onlyId

		return false
	end

	for i = 1, #self._selectList do
		if self._selectList[i] <= 0 then
			self._selectList[i] = onlyId

			return false
		end
	end

	return true
end

return EquipSelectListView
