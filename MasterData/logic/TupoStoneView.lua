-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/TupoStoneView.lua

module("logic.extensions.equipment.view.TupoStoneView", package.seeall)

local TupoStoneView = class("TupoStoneView", ViewComponent)

function TupoStoneView:ctor()
	TupoStoneView.super.ctor(self)

	self._stoneItemList = nil
	self._rateItemList = nil
	self._rateCountList = nil
	self._stoneInfoList = nil
end

function TupoStoneView:bindEvents()
	TupoStoneView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.sureBtn:AddClickListener(self.OnClickSureBtn, self)

	if self._stoneItemList and #self._stoneItemList > 0 then
		for i = 1, #self._stoneItemList do
			if self._stoneItemList[i] then
				if self._stoneItemList[i].clickBtnGo then
					GameUtil.asBtn(self._stoneItemList[i].clickBtnGo):AddClickListener(function()
						self:OnClickStoneBtn(i, true)
					end, self)
				end

				if self._stoneItemList[i].reduceBtn then
					self._stoneItemList[i].reduceBtn:AddClickListener(function()
						self:OnClickStoneBtn(i, false)
					end, self)
				end
			end
		end
	end
end

function TupoStoneView:unbindEvents()
	TupoStoneView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.sureBtn:RemoveClickListener()

	for _, item in pairs(self._stoneItemList or {}) do
		if item then
			if item.clickBtnGo then
				GameUtil.asBtn(item.clickBtnGo):RemoveClickListener()
			end

			if item.reduceBtn then
				item.reduceBtn:RemoveClickListener()
			end
		end
	end
end

function TupoStoneView:onExit()
	TupoStoneView.super.onExit(self)
	removetimer(self._onUpdateUI, self)

	if not self._clickSure and self._saveAttrStoneId then
		PetEquipModel.instance:SetAttrStoneIndex(self._saveAttrStoneId)
	end

	self._saveAttrStoneId = nil

	self:_onClearMatCol()
end

function TupoStoneView:destroyUI()
	TupoStoneView.super.destroyUI(self)

	self._stoneItemList = nil
	self._rateItemList = nil
	self._rateCountList = nil
end

function TupoStoneView:buildUI()
	TupoStoneView.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")

	local attrStoneGo = self:getGo("attrStoneGo/itemView")

	self._itemView = attrStoneGo
	self._stoneItemList = {}
	self._stoneItemList[1] = {
		itemGo = goutil.findChild(attrStoneGo, "item_1"),
		goodsPos = goutil.findChild(attrStoneGo, "item_1/goodsPos"),
		clickBtnGo = goutil.findChild(attrStoneGo, "item_1/clickBtnGo"),
		reduceBtn = Framework.ButtonAdapter.GetFrom(attrStoneGo, "item_1/reduceBtn")
	}
	self._stoneItemList[2] = {
		itemGo = goutil.findChild(attrStoneGo, "item_2"),
		goodsPos = goutil.findChild(attrStoneGo, "item_2/goodsPos"),
		clickBtnGo = goutil.findChild(attrStoneGo, "item_2/clickBtnGo"),
		reduceBtn = Framework.ButtonAdapter.GetFrom(attrStoneGo, "item_2/reduceBtn")
	}
	self._stoneItemList[3] = {
		itemGo = goutil.findChild(attrStoneGo, "item_3"),
		goodsPos = goutil.findChild(attrStoneGo, "item_3/goodsPos"),
		clickBtnGo = goutil.findChild(attrStoneGo, "item_3/clickBtnGo"),
		reduceBtn = Framework.ButtonAdapter.GetFrom(attrStoneGo, "item_3/reduceBtn")
	}
	self._stoneItemList[4] = {
		itemGo = goutil.findChild(attrStoneGo, "item_4"),
		goodsPos = goutil.findChild(attrStoneGo, "item_4/goodsPos"),
		clickBtnGo = goutil.findChild(attrStoneGo, "item_4/clickBtnGo"),
		reduceBtn = Framework.ButtonAdapter.GetFrom(attrStoneGo, "item_4/reduceBtn")
	}
	self._stoneItemList[5] = {
		itemGo = goutil.findChild(attrStoneGo, "item_5"),
		goodsPos = goutil.findChild(attrStoneGo, "item_5/goodsPos"),
		clickBtnGo = goutil.findChild(attrStoneGo, "item_5/clickBtnGo"),
		reduceBtn = Framework.ButtonAdapter.GetFrom(attrStoneGo, "item_5/reduceBtn")
	}
	self._stoneItemList[6] = {
		itemGo = goutil.findChild(attrStoneGo, "item_6"),
		goodsPos = goutil.findChild(attrStoneGo, "item_6/goodsPos"),
		clickBtnGo = goutil.findChild(attrStoneGo, "item_6/clickBtnGo"),
		reduceBtn = Framework.ButtonAdapter.GetFrom(attrStoneGo, "item_6/reduceBtn")
	}
	self._stoneItemList[7] = {
		itemGo = goutil.findChild(attrStoneGo, "item_7"),
		goodsPos = goutil.findChild(attrStoneGo, "item_7/goodsPos"),
		clickBtnGo = goutil.findChild(attrStoneGo, "item_7/clickBtnGo"),
		reduceBtn = Framework.ButtonAdapter.GetFrom(attrStoneGo, "item_7/reduceBtn")
	}
	self.countTxt = self:getTxt("attrStoneGo/countTxt")
	self._rateItemList = {}

	local emptyGo = self:getGo("attrRateGo/emptyGo")

	self._rateItemList[0] = {
		itemSld = goutil.findChildComponent(emptyGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(emptyGo, "itemTxt")
	}

	local grassGo = self:getGo("attrRateGo/grassGo")

	self._rateItemList[1] = {
		itemSld = goutil.findChildComponent(grassGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(grassGo, "itemTxt")
	}

	local waterGo = self:getGo("attrRateGo/waterGo")

	self._rateItemList[2] = {
		itemSld = goutil.findChildComponent(waterGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(waterGo, "itemTxt")
	}

	local fireGo = self:getGo("attrRateGo/fireGo")

	self._rateItemList[3] = {
		itemSld = goutil.findChildComponent(fireGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(fireGo, "itemTxt")
	}

	local lightGo = self:getGo("attrRateGo/lightGo")

	self._rateItemList[4] = {
		itemSld = goutil.findChildComponent(lightGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(lightGo, "itemTxt")
	}

	local darkGo = self:getGo("attrRateGo/darkGo")

	self._rateItemList[5] = {
		itemSld = goutil.findChildComponent(darkGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(darkGo, "itemTxt")
	}

	local kongGo = self:getGo("attrRateGo/kongGo")

	self._rateItemList[6] = {
		itemSld = goutil.findChildComponent(kongGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(kongGo, "itemTxt")
	}

	local chuangGo = self:getGo("attrRateGo/chuangGo")

	self._rateItemList[7] = {
		itemSld = goutil.findChildComponent(chuangGo, "itemSld", "Slider"),
		itemTxt = goutil.findChildTextComponent(chuangGo, "itemTxt")
	}
	self.sureBtn = self:getBtn("sureBtn")
	self._matCol = self:getGo("attrStoneGo/matCol")

	local matScrView = self:getGo("attrStoneGo/matCol/scrView")
	local matScrCell = self:getGo("attrStoneGo/matCol/scrCell")

	self._matScrollerList = ScrollerList.create(matScrView, matScrCell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))
end

function TupoStoneView:onEnter()
	TupoStoneView.super.onEnter(self)

	self._planId = self:getFirstParam()

	if checknumber(self._planId) <= 0 then
		self._planId = 1
	end

	self:_onUpdateUI()
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self._onMaterialGet, self)
end

function TupoStoneView:_onMaterialGet()
	settimer(0, self._onUpdateUI, self, false)
end

function TupoStoneView:_onUpdateUI()
	self._maxStoneCount = EquipmentConfig.instance:GetMaxAttrStone()
	self._choStoneCount = 0
	self._rateCountList = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		100
	}
	self._clickSure = false
	self._saveAttrStoneId = PetEquipModel.instance:GetAttrStoneIndex()

	self:_UpdataAttrRateShow()

	self._stoneInfoList = PetEquipModel.instance:GetAllAttrStones(self._planId) or {}

	local stoneHave = 0

	for i = 1, #self._stoneItemList do
		local info = self._stoneInfoList[i]

		if info then
			self._choStoneCount = self._choStoneCount + info.matUse
			stoneHave = stoneHave + info.matHave
		end

		MaterialMgr.resetAll(self._stoneItemList[i].goodsPos)
		self:UpdataAttrStoneShow(i)
	end

	self.countTxt.text = langPara("text_equip_desc_88", self._choStoneCount, self._maxStoneCount)

	self:_onUpdateMatColUI()
	GameUtil.SetActive(self._itemView, stoneHave > 0)
	GameUtil.SetActive(self._matCol, stoneHave <= 0)
end

function TupoStoneView:UpdataAttrStoneShow(index)
	if self._stoneItemList == nil or self._stoneItemList[index] == nil then
		return
	end

	if self._stoneInfoList == nil or self._stoneInfoList[index] == nil or self._stoneInfoList[index].matHave <= 0 then
		GameUtil.SetActive(self._stoneItemList[index].reduceBtn, false)
		GameUtil.SetActive(self._stoneItemList[index].itemGo, false)

		return
	end

	local info = self._stoneInfoList[index]

	GameUtil.SetActive(self._stoneItemList[index].itemGo, true)

	local subLua = MaterialMgr.setCell(info.matType, info.matId, self._stoneItemList[index].goodsPos)

	subLua.binder:setAutoTips(false)
	GameUtil.SetActive(self._stoneItemList[index].reduceBtn, info.matUse > 0)
	subLua.binder:setNum(info.matHave, info.matUse)
end

function TupoStoneView:OnClickStoneBtn(index, isAdd)
	if self._stoneInfoList == nil or self._stoneInfoList[index] == nil then
		return
	end

	local count = 1

	if isAdd then
		local info = self._stoneInfoList[index]

		if self._choStoneCount >= self._maxStoneCount then
			FloatWordMgr.instance:show(lang("text_equip_desc_89"))

			return
		end

		if info.matUse >= info.matHave then
			FloatWordMgr.instance:show(lang("text_equip_desc_14"))

			return
		end

		if self._rateCountList and self._rateCountList[info.index] >= 100 then
			FloatWordMgr.instance:show(lang("text_equip_desc_90"))

			return
		end
	else
		if self._stoneInfoList[index].matUse <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_91"))

			return
		end

		count = -1
	end

	self._stoneInfoList[index].matUse = self._stoneInfoList[index].matUse + count
	self._choStoneCount = self._choStoneCount + count

	self:_checkSelEmpty()
	self:UpdataAttrStoneShow(index)

	self.countTxt.text = langPara("text_equip_desc_88", self._choStoneCount, self._maxStoneCount)

	self:_UpdataAttrRateShow(isAdd, self._stoneInfoList[index].index)
end

function TupoStoneView:_checkSelEmpty()
	local isSelEmpty = true

	if self._stoneInfoList then
		for k, v in pairs(self._stoneInfoList) do
			if checknumber(v.matUse) > 0 then
				isSelEmpty = false

				break
			end
		end
	end

	if isSelEmpty then
		PetEquipModel.instance:ResetAttrStoneIndex()
	end
end

function TupoStoneView:OnClickSureBtn()
	if self._stoneInfoList and #self._stoneInfoList > 0 then
		for i = 1, #self._stoneInfoList do
			if self._stoneInfoList[i] and checknumber(self._stoneInfoList[i].matUse) > 0 then
				PetEquipModel.instance:SetAttrStoneIndex(self._stoneInfoList[i].index)

				break
			end
		end
	end

	self._clickSure = true

	GlobalDispatcher:dispatch("UpdataEquipAttrShow")
	self:close()
end

function TupoStoneView:_UpdataAttrRateShow(isAdd, index)
	if isAdd then
		self._rateCountList = {}

		for k, v in pairs(self._rateItemList) do
			if self._rateCountList then
				self._rateCountList[k] = index == k and 100 or 0
			end

			if index == k then
				v.itemSld.value = 1
				v.itemTxt.text = "100%"
			else
				v.itemSld.value = 0
				v.itemTxt.text = "0%"
			end
		end
	else
		local rateList = PetEquipModel.instance:GetAttrRateList() or {}

		for k, v in pairs(self._rateItemList) do
			local count = checknumber(rateList[k])

			if self._rateCountList then
				self._rateCountList[k] = count
			end

			v.itemSld.value = count / 100
			v.itemTxt.text = count .. "%"
		end
	end
end

function TupoStoneView:_onUpdateMatColUI()
	local stoneMatSet = {}
	local stoneDataList = EquipmentConfig.instance:GetAttrStoneDataList()

	for _, data in ipairs(stoneDataList) do
		local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)

		if matType and matId then
			local key = string.format("%s:%s", matType, matId)

			stoneMatSet[key] = true
		end
	end

	local matList = MaterialModel.instance:getMaterialsByTypeExceptSub(MatType.Item_GoodFeel) or {}
	local filteredList = {}

	for i, v in ipairs(matList) do
		local matType, matId = v:getMatType(), v:getDefineId()
		local matCfg = MaterialMgr.getMatCfg(matType, matId)
		local isPass = false

		if matCfg and (matCfg.useType == 1 or matCfg.useType == 2) then
			local useCfg = MaterialConfig.instance:getCfgByMatAndId(matType, matId)

			if useCfg and ItemBagController.instance:checkCanUseNotWithTips(useCfg) then
				local useType = useCfg.materialUseType

				if useType == MatUseType.PACK or useType == MatUseType.EXCHANGE or useType == MatUseType.WEIGHT_PACK or useType == MatUseType.MIX_SELECT or useType == MatUseType.MIX_SELECT_ONCE then
					if self:_checkContentHasStone(matType, matId, stoneMatSet) then
						isPass = true
					elseif self:_checkUseContentMatch(useCfg.content, MatType.DROP_ITEM) then
						local matStr = MaterialMgr.changeIfDrop(useCfg.content)
						local mType, mId = MaterialMgr.getMatParams(matStr)

						if self:_checkContentHasStone(mType, mId, stoneMatSet) then
							isPass = true
						end
					end
				end
			end
		end

		if isPass then
			table.insert(filteredList, v)
		end
	end

	table.sort(filteredList, function(a, b)
		local numA = MaterialFacade.instance:getMatNumber(a:getMatType(), a:getDefineId())
		local numB = MaterialFacade.instance:getMatNumber(b:getMatType(), b:getDefineId())

		return numB < numA
	end)
	self._matScrollerList:reloadData(filteredList)
end

function TupoStoneView:_onClearMatCol()
	self._matScrollerList:dispose()
end

function TupoStoneView:_updateMatCell(view, cell, data, tag)
	local matType = data:getMatType()
	local matId = data:getDefineId()
	local matNum = MaterialFacade.instance:getMatNumber(matType, matId)
	local mainGo = cell.gameObject
	local btnUse = goutil.findChild(mainGo, "btnUse")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	txtDesc.text = string.format("背包-%s\n(库存：%s)", matName, matNum)

	GameUtil.addClickHandler(btnUse, function()
		ItemBagController.instance:openUsePanel(data)
	end)
end

function TupoStoneView:_clearMatCell(cell)
	local mainGo = cell.gameObject
	local btnUse = goutil.findChild(mainGo, "btnUse")

	GameUtil.rmClickHandler(btnUse)
end

function TupoStoneView:_checkUseContentMatch(content, type)
	local match = string.match(content, string.format("^%s:%%d+:%%d+", type))

	match = match or string.match(content, string.format("[%%D]%s:%%d+:%%d+", type))

	return match
end

function TupoStoneView:_checkContentHasStone(matType, matId, stoneMatSet)
	local result = false

	stoneMatSet = stoneMatSet or {}

	local itemList = MaterialFacade.instance:getItemsInUseCfg(matType, matId)

	for _, matStr in ipairs(itemList) do
		if stoneMatSet[matStr] then
			result = true

			break
		end
	end

	return result
end

return TupoStoneView
