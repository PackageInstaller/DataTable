-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSmeltView.lua

module("logic.extensions.holystripe.view.HolyStripeSmeltView", package.seeall)

local HolyStripeSmeltView = class("HolyStripeSmeltView", HolyStripeBagView)

function HolyStripeSmeltView:ctor()
	HolyStripeSmeltView.super.ctor(self)
end

function HolyStripeSmeltView:buildUI()
	HolyStripeSmeltView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._titleNameTxt = self:getTxt("leftTop/titleNameTxt")
	self._leftItemGo = self:getGo("smelting/leftInfo/item")
	self._btnMark = self:getBtn("smelting/leftInfo/btnMake")
	self._txtCost1 = self:getTxt("smelting/leftInfo/txtCost1")
	self._conCost1 = self:getGo("smelting/leftInfo/txtCost1/costIcon")
	self._txtCost2 = self:getTxt("smelting/leftInfo/txtCost2")
	self._conCost2 = self:getGo("smelting/leftInfo/txtCost2/costIcon")
	self._btnSure = self:getBtn("smelting/btnSure")
	self._btnAllSelect = self:getToggle("smelting/allCheck")
	self._emptyGo = self:getGo("empty")
	self._emptyTxt = self:getTxt("empty/txtEmpty")
	self._itemGo = self:getGo("smelting/cost/item")
	self._itemconGo = self:getGo("smelting/cost/itemcon")
	self._costMatItems = ItemGroup.New(self._itemconGo, self._itemGo, nil, nil, true)
	self._smeltingGo = self:getGo("smelting")
	self._cuilingGo = self:getGo("cuiling")
	self._strengthenGo = self:getGo("strengthen")
end

function HolyStripeSmeltView:bindEvents()
	HolyStripeSmeltView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickBtnSmelt, self)
	self._btnMark:AddClickListener(self._onClickbtnMark, self)
	self._btnAllSelect:AddOnValueChanged(self._onValueChangedSelectAll, self)
end

function HolyStripeSmeltView:unbindEvents()
	HolyStripeSmeltView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnMark:RemoveClickListener()
	self._btnAllSelect:RemoveOnValueChanged()
end

function HolyStripeSmeltView:onEnter()
	self._totalSelect = {}

	HolyStripeSmeltView.super.onEnter(self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeSmeltRes, self._PM_HolyStripeSmeltRes, self)
	GlobalDispatcher:addListener(HolyStripeController.PM_HolyStripeSetSmeltInfoRes, self._PM_HolyStripeSetSmeltInfoRes, self)

	self._smeltRefundExpRate = HolyStripeConfig.instance:getSmeltRefundExpRate()
	self._smeltMatLimit = HolyStripeConfig.instance:getMaxSmeltLimit()
	self._smeltMatSelectNum = 0

	self:_setViewType()
	self:_refreshLeftInfo()

	self._btnAllSelect.isOn = false

	if self._emptyTxt then
		self._emptyTxt.text = lang("当前无可消耗的灵纹")
	end
end

function HolyStripeSmeltView:onExit()
	self._totalSelect = {}

	HolyStripeSmeltView.super.onExit(self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeSmeltRes, self._PM_HolyStripeSmeltRes, self)
	GlobalDispatcher:removeListener(HolyStripeController.PM_HolyStripeSetSmeltInfoRes, self._PM_HolyStripeSetSmeltInfoRes, self)
	MaterialMgr.resetAll(self._leftItemGo)
	self._costMatItems:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

function HolyStripeSmeltView:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "smelting/scrollView"
	}
end

function HolyStripeSmeltView:_setViewType()
	goutil.setActive(self._smeltingGo, true)
	goutil.setActive(self._cuilingGo, false)
	goutil.setActive(self._strengthenGo, false)

	self._titleNameTxt.text = lang("遂愿之池")
end

function HolyStripeSmeltView:refreshView()
	local list = HolyStripeModel.instance:getAllHolyStripeMo()
	local newList = {}

	for i, mo in ipairs(list) do
		if mo:getEquipPetId() < 0 then
			table.insert(newList, {
				totalNum = 1,
				selectNum = 0,
				mo = mo
			})
		end
	end

	self._oriViewDatas = newList

	local tempList = {}

	for i, v in ipairs(self._oriViewDatas) do
		table.insert(tempList, v.mo)
	end

	self:_refreshBag(tempList)
	self:_refreshFilter()
	self:_refreshLeftInfo()
	goutil.setActive(self._emptyGo, not self._curViewDatas or #self._curViewDatas <= 0)
end

function HolyStripeSmeltView:_dataPretreatment(moList)
	local tempList = {}

	for i, mo in ipairs(moList) do
		for j, oridata in ipairs(self._oriViewDatas) do
			oridata.mo:getId()

			if mo and oridata.mo and mo:getId() == oridata.mo:getId() then
				table.insert(tempList, oridata)

				break
			end
		end
	end

	return tempList
end

function HolyStripeSmeltView:_updataCell(view, cell, data, tag)
	local mo = data.mo
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "item")
	local lock = goutil.findChild(go, "lock")
	local nameTextGo = goutil.findChild(go, "nameText")
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local btnReduce = Framework.ButtonAdapter.Get(goutil.findChild(go, "btnReduce"))
	local autoDestroyTagGo = goutil.findChild(go, "autoDestroyTag")

	MaterialMgr.resetAll(itemCon)

	if mo:getIsLock() then
		goutil.setActive(lock, true)
	else
		goutil.setActive(lock, false)
	end

	local autoSmelt = false

	if not mo.isMat and self._autoSmeltDays > 0 and not mo:getIsLock() and mo:getEquipPetId() < 0 then
		for i, v in ipairs(self._autoSmeltQuality) do
			if checknumber(mo:getQuality()) == v then
				autoSmelt = true

				break
			end
		end
	end

	goutil.setActive(autoDestroyTagGo, autoSmelt)

	local proxy = MaterialMgr.setCellByMo(mo, itemCon)

	proxy.binder:setNumStr("")

	local isSelect = false

	if self._totalSelect[mo:getId()] then
		isSelect = self._totalSelect[mo:getId()] > 0
	end

	goutil.setActive(btnReduce.gameObject, isSelect)

	nameText.text = mo:getName()

	proxy.binder:setAutoTips(false)
	proxy.binder:setSelected(isSelect)
	proxy.binder:setCallBack(function()
		self:_onClickMat(data, true)
	end)
	btnReduce:AddClickListener(function()
		self:_onClickMat(data, false)
	end)
end

function HolyStripeSmeltView:_clearCell(cell)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "item")
	local btnReduce = Framework.ButtonAdapter.Get(goutil.findChild(go, "btnReduce"))

	btnReduce:RemoveClickListener()
	MaterialMgr.resetAll(itemCon)
end

function HolyStripeSmeltView:_refreshTotalExp()
	local mats = HolyStripeConfig.instance:getStrengthMats()
	local totalExp = 0

	for i = #mats, 1, -1 do
		local hasNum = MaterialFacade.instance:getMatNumber(MatType.Item, mats[i].matId)

		totalExp = totalExp + mats[i].exp * hasNum
	end

	self._addExp = 0

	for i, v in ipairs(self._oriViewDatas) do
		-- block empty
	end
end

function HolyStripeSmeltView:_onClickMat(data, isAdd)
	if data.mo:getIsLock() then
		FloatWordMgr.instance:show("已被上锁保护中，请解除锁定状态")

		return
	end

	if isAdd then
		if self._totalSelect[data.mo:getId()] and self._totalSelect[data.mo:getId()] > 0 then
			FloatWordMgr.instance:show("达到当前材料可选数量限制")

			return
		end

		if self._smeltMatSelectNum >= self._smeltMatLimit then
			FloatWordMgr.instance:show("达到材料可选数量限制")

			return
		end

		self._totalSelect[data.mo:getId()] = 1
		self._smeltMatSelectNum = self._smeltMatSelectNum + 1
		data.selectNum = data.selectNum + 1
	else
		self._totalSelect[data.mo:getId()] = 0
		self._smeltMatSelectNum = self._smeltMatSelectNum - 1
		data.selectNum = data.selectNum - 1
	end

	self._itemList:reloadData(self._curViewDatas)
	self:_refreshLeftInfo()
end

function HolyStripeSmeltView:_refreshLeftInfo()
	self:_refreshTotalExp()

	local mats = HolyStripeConfig.instance:getStrengthMats()

	MaterialMgr.resetAll(self._leftItemGo)
	self:_setCostMats()
end

function HolyStripeSmeltView:_setCostMats()
	local mats = ""
	local str = ""
	local totalExp = 0
	local totalHolyStripeExp = 0

	if self._oriViewDatas then
		for i, v in ipairs(self._oriViewDatas) do
			if self._totalSelect[v.mo:getId()] and self._totalSelect[v.mo:getId()] > 0 then
				str = v.mo:getRefundMaterials()
				totalExp = totalExp + v.mo:getRefundExp()
				totalHolyStripeExp = totalHolyStripeExp + v.mo:getExp()

				if not string.nilorempty(str) then
					mats = MaterialMgr.combineStrs(mats, str)
				end
			end
		end
	end

	if self._smeltRefundExpRate then
		totalHolyStripeExp = totalHolyStripeExp * self._smeltRefundExpRate
	end

	totalExp = totalExp + totalHolyStripeExp
	str = ""

	local matCfg = HolyStripeConfig.instance:getStrengthMats()

	for i = #matCfg, 1, -1 do
		local exp = matCfg[i].exp
		local count = 0

		if totalExp > 0 then
			count = math.floor(totalExp / exp)
		end

		totalExp = totalExp - count * exp

		if count > 0 then
			str = string.format("4:%s:%d", matCfg[i].matId, count)
			mats = MaterialMgr.combineStrs(mats, str)
		end
	end

	if totalExp > 0 then
		str = string.format("4:%s:%d", matCfg[1].matId, 1)
		mats = MaterialMgr.combineStrs(mats, str)
	end

	local arr

	self._costMatItems:updateWithMoArray((not string.nilorempty(mats) or nil) and string.split(mats, "#"), function(item, cfgStr)
		MaterialMgr.resetAll(item.mainGO)

		local proxy = MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
		local arr = string.split(cfgStr, ":")
		local useNum = checknumber(arr[#arr])
		local matType = checknumber(arr[1])
		local id = checknumber(arr[2])

		proxy.binder:setNumStr(useNum)
	end)
end

function HolyStripeSmeltView:_onValueChangedSelectAll(go, status)
	for i, data in ipairs(self._curViewDatas) do
		if data.mo:getIsLock() == false then
			if status then
				if (not self._totalSelect[data.mo:getId()] or self._totalSelect[data.mo:getId()] < 1) and self._smeltMatSelectNum < self._smeltMatLimit then
					self._totalSelect[data.mo:getId()] = 1
					data.selectNum = data.selectNum + 1
					self._smeltMatSelectNum = self._smeltMatSelectNum + 1
				end
			elseif self._totalSelect[data.mo:getId()] and self._totalSelect[data.mo:getId()] > 0 then
				self._totalSelect[data.mo:getId()] = 0
				data.selectNum = data.selectNum - 1
				self._smeltMatSelectNum = self._smeltMatSelectNum - 1
			end
		end
	end

	self._itemList:reloadData(self._curViewDatas)
	self:_refreshLeftInfo()
end

function HolyStripeSmeltView:_onClickBtnSmelt()
	local usingIds = {}

	for k, data in pairs(self._oriViewDatas) do
		if self._totalSelect[data.mo:getId()] and self._totalSelect[data.mo:getId()] > 0 then
			local mo = data.mo

			table.insert(usingIds, mo:getId())
		end
	end

	if #usingIds <= 0 then
		FloatWordMgr.instance:show("请选择灵纹")

		return
	end

	HolyStripeAgent.instance:sendPM_HolyStripeSmeltReq(usingIds)
end

function HolyStripeSmeltView:_PM_HolyStripeSmeltRes()
	self._btnAllSelect.isOn = false
	self._smeltMatSelectNum = 0

	self:refreshView()
	self:_refreshLeftInfo()
end

function HolyStripeSmeltView:_PM_HolyStripeSetSmeltInfoRes()
	self._autoSmeltDays = HolyStripeModel.instance:getAutoSmeltDays()
	self._autoSmeltQuality = HolyStripeModel.instance:getAutoSmeltQualityList()

	self:refreshView()
	self:_refreshLeftInfo()
end

function HolyStripeSmeltView:_onClickbtnClose()
	self:close()
end

function HolyStripeSmeltView:_onClickbtnMark()
	UIStateManager.instance:push(ViewName.HolyStripeSmeltInfoView)
end

function HolyStripeSmeltView:_getSuitFilterGo()
	return self:getGo("tabCon/suitFitlerBtn")
end

function HolyStripeSmeltView:_getSuitFilterBtn()
	return self:getBtn("tabCon/suitFitlerBtn/bg")
end

function HolyStripeSmeltView:_getConditionSortGo()
	return self:getGo("tabCon/conditionSortBtn")
end

function HolyStripeSmeltView:_getConditionSortBtn()
	return self:getBtn("tabCon/conditionSortBtn/bg")
end

function HolyStripeSmeltView:_getPosFilterGo()
	return self:getGo("tabCon/posFilterBtn")
end

function HolyStripeSmeltView:_getPosFilterBtn()
	return self:getBtn("tabCon/posFilterBtn/bg")
end

function HolyStripeSmeltView:_getEmptyGo()
	return self:getGo("bagRoot/empty")
end

function HolyStripeSmeltView:_getSuitFilterName()
	return self:getTxt("tabCon/suitFitlerBtn/bg/text")
end

function HolyStripeSmeltView:_getPosFilterName()
	return self:getTxt("tabCon/posFilterBtn/bg/text")
end

function HolyStripeSmeltView:_getConditionSortName()
	return self:getTxt("tabCon/conditionSortBtn/bg/text")
end

function HolyStripeSmeltView:_getQualityFilterGo()
	return self:getGo("tabCon/qualityFilterBtn")
end

function HolyStripeSmeltView:_getQualityFilterBtn()
	return self:getBtn("tabCon/qualityFilterBtn/bg")
end

function HolyStripeSmeltView:_getQualityFilterName()
	return self:getTxt("tabCon/qualityFilterBtn/bg/text")
end

return HolyStripeSmeltView
