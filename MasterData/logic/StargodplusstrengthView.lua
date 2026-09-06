-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusstrengthView.lua

module("logic.extensions.stargodplus.view.StargodplusstrengthView", package.seeall)

local StargodplusstrengthView = class("StargodplusstrengthView", TableViewComponent)

function StargodplusstrengthView:ctor()
	StargodplusstrengthView.super.ctor(self)
end

function StargodplusstrengthView:buildUI()
	StargodplusstrengthView.super.buildUI(self)

	self._putInBtn = self:getBtn("container/rightInfo/putInBtn")
	self._strengthenBtn = self:getBtn("container/rightInfo/strengthenBtn")
	self._backClickBtn = self:getBtn("container/upInfo/backClickBtn")
	self._slideLeftBtn = self:getBtn("container/leftInfo/slideLeftBtn")
	self._slideRightBtn = self:getBtn("container/leftInfo/slideRightBtn")
	self._equipItemGo = self:getGo("container/leftInfo/equipItemGo")
	self._equipNameTxt = goutil.findChildTextComponent(self.mainGO, "container/leftInfo/equipNameTxt")
	self._qhNowTxt = goutil.findChildTextComponent(self.mainGO, "container/leftInfo/lvCompareCon/qhNowTxt")
	self._qhNextTxt = goutil.findChildTextComponent(self.mainGO, "container/leftInfo/lvCompareCon/qhNextTxt")
	self._petNameTxt = goutil.findChildTextComponent(self.mainGO, "container/leftInfo/petNameTxt")
	self._qhNumTxt = goutil.findChildTextComponent(self.mainGO, "container/leftInfo/qhNumTxt")
	self._moneyCountTxt = goutil.findChildTextComponent(self.mainGO, "container/rightInfo/moneyCountTxt_1")
	self._qhBarSlider = self:getGo("container/leftInfo/qhBarSli"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._qhItemGo = self:getGo("container/leftInfo/qhItem")
	self._qhShowTranGo = self:getGo("container/leftInfo/qhShowTran")
	self._attrGroup = ItemGroup.New(self._qhShowTranGo, self._qhItemGo, nil, nil, true)
	self._lvCompareConGo = self:getGo("container/leftInfo/lvCompareCon")
	self._maxLvText = goutil.findChildTextComponent(self.mainGO, "container/leftInfo/maxLvText")
	self._emptyTipGo = self:getGo("container/rightInfo/emptyTip")
	self._btnGotoStar = self:getBtn("container/rightInfo/emptyTip/btnGotoStar")
	self._txNow = self:getTxt("container/rightInfo/levelUp/txNow")
	self._txNext = self:getTxt("container/rightInfo/levelUp/txNext")
	self._levelSlider = self:getGo("container/rightInfo/levelUp/levelSlider")
	self._sliderAdapter = Framework.SliderAdapter.Get(self._levelSlider)
	self._btnAdd = self:getBtn("container/rightInfo/levelUp/btnAdd")
	self._btnMinus = self:getBtn("container/rightInfo/levelUp/btnMinus")
	self.radioItems = {}

	for i = 2, 4 do
		local item = self:getGo("container/filterItemTran/item_" .. i)

		if item then
			self.radioItems[i] = item

			local itemTog = Framework.ToggleAdapter.GetFrom(item, "itemTog")
			local itemTxt = goutil.findChildTextComponent(item, "itemTxt")

			itemTog:AddOnValueChanged(function(go, isOn)
				self:OnToggleValueChanged(i, isOn)
			end)
		end
	end

	local redItem = self:getGo("container/filterItemTran/item_6")

	if redItem then
		self.radioItems[6] = redItem

		local itemTog = Framework.ToggleAdapter.GetFrom(redItem, "itemTog")

		itemTog:AddOnValueChanged(function(go, isOn)
			self:OnToggleValueChanged(6, isOn)
		end)
	end

	EndDragHandler.Get(self._levelSlider):AddLuaHandler(function(go, eventData)
		self:_onEndDrag(go, eventData)
	end)

	self._limit = self:getGo("container/limit")
	self._txtNum = self:getTxt("container/limit/txtNum")
	self._tipBtn = self:getGo("container/limit/tipBtn")
	self._goldBarCon = self:getGo("container/goldBarCon")
end

function StargodplusstrengthView:bindEvents()
	StargodplusstrengthView.super.bindEvents(self)
	self._strengthenBtn:AddClickListener(self._onClickstrengthenBtn, self)
	self._backClickBtn:AddClickListener(self._onClickbackClickBtn, self)
	self._slideLeftBtn:AddClickListener(self._onClickslideLeftBtn, self)
	self._slideRightBtn:AddClickListener(self._onClickslideRightBtn, self)
	self._btnGotoStar:AddClickListener(self._onClickGotoStarBtn, self)
	self._sliderAdapter:AddOnValueChanged(self._setSliderValue, self)
	self._btnAdd:AddClickListener(self._onClickAddBtn, self)
	self._btnMinus:AddClickListener(self._onClickSubtractBtn, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickTips, self)
end

function StargodplusstrengthView:unbindEvents()
	StargodplusstrengthView.super.unbindEvents(self)
	self._strengthenBtn:RemoveClickListener()
	self._backClickBtn:RemoveClickListener()
	self._slideLeftBtn:RemoveClickListener()
	self._slideRightBtn:RemoveClickListener()
	self._btnGotoStar:RemoveClickListener()
	self._sliderAdapter:RemoveOnValueChanged()
	self._btnAdd:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	GameUtil.rmClickHandler(self._tipBtn)
end

function StargodplusstrengthView:destroyUI()
	StargodplusstrengthView.super.destroyUI(self)
end

function StargodplusstrengthView:onEnter()
	StargodplusstrengthView.super.onEnter(self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_UpgradeSlotRes, self._upgradeRes, self)

	self._slotId = self:getFirstParam()

	self:_loadData()
	self:_updateView()
	self:_initSlider()
	self:_setTopGoldBar()
end

function StargodplusstrengthView:_setTopGoldBar()
	if not self._isSetGold then
		self._isSetGold = true

		local btn_list = {
			{
				showAdd = false,
				id = GameEnum.GoldType.Coin
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
	end
end

function StargodplusstrengthView:_onClickTips()
	local type = MatType.StarGodPlus

	ItemBagController.instance:showLimitTipsWithType(type)
end

function StargodplusstrengthView:_showCurrLiitWithType()
	local type = MatType.StarGodPlus
	local cur, total = ItemBagController.instance:getCurrLiitWithType(type)

	self._txtNum.text = cur > total * 0.9 and langPara("<color=#eb4642>%s</color>/%s", cur, total) or langPara("%s/%s", cur, total)
end

function StargodplusstrengthView:onEnterFinished()
	StargodplusstrengthView.super.onEnterFinished(self)
end

function StargodplusstrengthView:onExit()
	StargodplusstrengthView.super.onExit(self)
	GlobalDispatcher:removeListener(StarGodPlusAgent.PM_UpgradeSlotRes, self._upgradeRes, self)
	MaterialMgr.resetAll(self._equipItemGo)
end

function StargodplusstrengthView:onExitFinished()
	StargodplusstrengthView.super.onExitFinished(self)
end

function StargodplusstrengthView:OnToggleValueChanged(key, isOn, idx)
	self:_updateView()
end

function StargodplusstrengthView:_onClickputInBtn(targetSlotLv)
	if not self._curViewDatas or #self._curViewDatas <= 0 then
		FloatWordMgr.instance:show("暂无可消耗星神")

		return
	end

	if not self._strenCfgs[targetSlotLv] then
		return
	end

	local currExp = self:_calNextExp()
	local currLv = self:_exp2lv(currExp)

	if targetSlotLv >= self._slotMaxLv and currExp >= self._slotMaxExp then
		FloatWordMgr.instance:show("当前强化已上限")

		return
	end

	local isOk = self:_checkUseNumIsOk()

	if not isOk then
		FloatWordMgr.instance:show("已达到单次强化消耗上限，无法放入更多材料！")

		return
	end

	local needBreak = false
	local lastTargetSlotLv = targetSlotLv

	if targetSlotLv < currLv then
		local targetExp = 0

		if targetSlotLv < self._currSlotLv then
			local targetCfg = self._strenCfgs[self._currSlotLv]

			targetExp = targetCfg.exp
		else
			local targetCfg = self._strenCfgs[targetSlotLv + 1]

			targetExp = targetCfg.exp - 1
		end

		local needReduceExp = currExp - targetExp

		for idx, num in pairs(self._index2num) do
			local data = self._curViewDatas[idx]

			for i = 1, num do
				needReduceExp = needReduceExp - data.exp
				self._index2num[idx] = self._index2num[idx] - 1

				if needReduceExp <= 0 then
					break
				end
			end

			if needReduceExp <= 0 then
				break
			end
		end

		self:_calNextAttr()
		self:reloadData()

		self._notSliderOp = true

		local currExp1 = self:_calNextExp()
		local currLv1 = self:_exp2lv(currExp1)

		self._sliderAdapter:SetValue(currLv1)

		self._notSliderOp = false

		return
	end

	local hasCal = false
	local hasChengse = false
	local resetTargetLv = false
	local ignorIndexs = {}

	for index, data in ipairs(self._curViewDatas) do
		self._index2num[index] = self._index2num[index] or 0

		local data = self._curViewDatas[index]

		hasChengse = hasChengse or self._index2num[index] <= 0 and data.isEquip and data.mo:getQuality() >= 4

		if (not data.isEquip or self._index2num[index] > 0 or data.mo:getQuality() < 4) and not ignorIndexs[index] then
			for i = self._index2num[index] + 1, data.num do
				local canAdd = self:_preCalCanAdd(index, ignorIndexs)

				if canAdd then
					if not resetTargetLv then
						self._targetSlotLv = 0
						resetTargetLv = true
					end

					self._index2num[index] = (self._index2num[index] or 0) + 1
				else
					if self._index2num[index] > 0 then
						self._index2num[index] = self._index2num[index] - 1
					end

					ignorIndexs[index] = true

					self:_calNextAttr()

					break
				end

				self:_onAddSelectTotalNum(true, index)
				self:_calNextAttr()

				needBreak = lastTargetSlotLv < self._targetSlotLv or self._isMaxLv or not self:_checkUseNumIsOk()
				hasCal = true

				if needBreak then
					break
				end
			end
		end

		if needBreak then
			break
		end
	end

	if not hasCal and hasChengse then
		FloatWordMgr.instance:show("已放入全部可用材料，橙色及以上的星神无法一键放入")

		return
	elseif not hasCal then
		FloatWordMgr.instance:show("已放入全部可消耗材料")

		return
	end

	self:reloadData()
end

function StargodplusstrengthView:_onClickstrengthenBtn()
	local usedFillerIds_i32_Ary = {}
	local usedMaterials_pb_Ary = {}
	local hightQualityDataList = {}

	for index, num in pairs(self._index2num) do
		if num > 0 then
			local data = self._curViewDatas[index]

			if data.matType == MatType.Item then
				local mo = MaterialExtension_pb.MaterialItemNO()

				mo.id = data.matId
				mo.num = num

				table.insert(usedMaterials_pb_Ary, mo)
			else
				if data.mo:getQuality() >= StargodplusConfig.instance:getDecomposeTipsQuality() then
					table.insert(hightQualityDataList, data)
				end

				table.insert(usedFillerIds_i32_Ary, data.mo:getId())
			end
		end
	end

	if next(usedFillerIds_i32_Ary) or next(usedMaterials_pb_Ary) then
		local hasNum = MaterialFacade.instance:getMatNumber(8, 1)

		if hasNum < self._needCostCoinNum then
			FloatWordMgr.instance:show("金币不足")

			return
		end

		local petId = StargodplusModel.instance:getCurrShowPetId()

		local function okFunc()
			StarGodPlusAgent.instance:sendPM_UpgradeSlotReq(petId, self._slotData.slot, usedFillerIds_i32_Ary, usedMaterials_pb_Ary)
		end

		if #hightQualityDataList > 0 then
			if PasswordLockController.instance:checkNeedOpenVerifyView() then
				return
			end

			UIStateManager.instance:push(ViewName.StargodplussurestrentipsView, hightQualityDataList, okFunc)
		else
			okFunc()
		end
	else
		FloatWordMgr.instance:show("请选择消耗材料")
	end
end

function StargodplusstrengthView:_onClickbackClickBtn()
	self:close()
end

function StargodplusstrengthView:_onClickslideLeftBtn()
	self._notSliderOp = true

	local len = #self._slotDatas

	self._currIndex = (self._currIndex + len - 1) % len

	if self._currIndex == 0 then
		self._currIndex = len
	end

	self._slotId = self._slotDatas[self._currIndex].slot

	self:_loadData()
	self:_updateView()
	self:_initSlider()
end

function StargodplusstrengthView:_onClickslideRightBtn()
	self._notSliderOp = true

	local len = #self._slotDatas

	self._currIndex = (self._currIndex + 1) % len

	if self._currIndex == 0 then
		self._currIndex = len
	end

	self._slotId = self._slotDatas[self._currIndex].slot

	self:_loadData()
	self:_updateView()
	self:_initSlider()
end

function StargodplusstrengthView:_onClickGotoStarBtn()
	StargodplusModel.instance:jumpStarGod(self)
end

function StargodplusstrengthView:_getPath()
	return {
		cellPath = "container/rightInfo/itemGridGo",
		viewPath = "container/rightInfo/equipListSR"
	}
end

function StargodplusstrengthView:_cellSize(view, index)
	return 100, 100
end

function StargodplusstrengthView:_updateCell(view, cell, data)
	local itemCon = goutil.findChild(cell.gameObject, "itemCon")
	local reduceBtnGo = goutil.findChild(cell.gameObject, "reduceBtn")
	local reduceBtn = GameUtil.asBtn(reduceBtnGo)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local nameTextChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)

	if data.isEquip then
		nameText.text = data.mo:getName() or ""

		nameTextChange:SetState(data.mo:getQuality())
	else
		nameText.text = ""
	end

	local proxy = MaterialMgr.setCellByCfg(data.cfgStr, itemCon)

	proxy.binder:setCallBack(function()
		self:_onSelectItem(cell.data, true)
	end)
	proxy.binder:setAutoTips(false)

	if self._index2num[cell.data] then
		if not self._index2num[cell.data] then
			local selectNum = 0

			if data.num > 1 then
				local str = selectNum .. "/" .. data.num

				proxy.binder:setNumStr(str)
			else
				proxy.binder:setNum(0)
			end

			goutil.setActive(reduceBtnGo, selectNum > 0)
			reduceBtn:RemoveClickListener()
			reduceBtn:AddClickListener(function()
				self:_onSelectItem(cell.data, false)
			end)
		end
	end
end

function StargodplusstrengthView:_clearTableview(cell)
	local itemCon = goutil.findChild(cell.gameObject, "itemCon")

	MaterialMgr.resetAll(itemCon)
end

function StargodplusstrengthView:_updateView()
	self._curViewDatas = {}
	self._index2num = {}
	self._index2CfgStr = {}
	self._selectTotalNum = 0
	self._targetSlotLv = self._currSlotLv

	local cfgMatList = StargodplusConfig.instance:getCommonStrenMatDatas()
	local pool = {}
	local nums = 0

	for k, item in pairs(self.radioItems) do
		local itemTog = Framework.ToggleAdapter.GetFrom(item, "itemTog")

		if itemTog.isOn then
			pool[k] = itemTog.isOn
			nums = nums + 1
		end
	end

	local matList = {}

	for i, v in ipairs(cfgMatList) do
		local hasNum = MaterialFacade.instance:getMatNumber(v.matType, v.matId)

		if hasNum > 0 then
			local cfgStr = string.format("%s:%s", v.matType, v.matId)

			table.insert(matList, {
				isEquip = false,
				matType = v.matType,
				matId = v.matId,
				num = hasNum,
				cfgStr = cfgStr,
				exp = v.exp
			})
		end
	end

	table.sort(matList, function(a, b)
		return a.exp < b.exp
	end)

	local list = StargodplusModel.instance:getFillerMoList()

	for k, mo in pairs(list) do
		if mo:getQuality() <= self._quality and mo:getUsePetId() <= 0 then
			if nums == 0 then
				table.insert(self._curViewDatas, {
					num = 1,
					isEquip = true,
					matType = MatType.StarGodPlus,
					matId = mo:getDefineId(),
					mo = mo,
					cfgStr = MatType.StarGodPlus .. ":" .. mo:getDefineId(),
					exp = mo:getToStrenExp()
				})
			else
				local qlty = mo:getQuality()

				if pool[qlty] then
					table.insert(self._curViewDatas, {
						num = 1,
						isEquip = true,
						matType = MatType.StarGodPlus,
						matId = mo:getDefineId(),
						mo = mo,
						cfgStr = MatType.StarGodPlus .. ":" .. mo:getDefineId(),
						exp = mo:getToStrenExp()
					})
				end
			end
		end
	end

	table.sort(self._curViewDatas, function(a, b)
		return a.exp < b.exp
	end)

	for i = #matList, 1, -1 do
		if nums == 0 then
			table.insert(self._curViewDatas, 1, matList[i])
		end
	end

	self:reloadData()
	self:_setExp(self._slotData.exp)
	goutil.setActive(self._emptyTipGo, not self._curViewDatas or #self._curViewDatas <= 0)
	self:_showCurrLiitWithType()
end

function StargodplusstrengthView:_onSelectItem(index, isAdd)
	if isAdd then
		if self._isMaxLv then
			FloatWordMgr.instance:show("当前强化已上限")

			return
		end

		if not self:_checkUseNumIsOk() then
			FloatWordMgr.instance:show("已达到单次强化消耗上限，无法放入更多材料！")

			return
		end

		if not self._index2num[index] then
			do
				local hasSelectNum = 0
				local data = self._curViewDatas[index]

				if hasSelectNum >= data.num then
					FloatWordMgr.instance:show("已全部选中该星神")

					return
				end
			end

			local addNum = isAdd and 1 or -1

			self._index2num[index] = ((not self._index2num[index] or nil) and 0) + addNum

			self:_onAddSelectTotalNum(isAdd, index)
			self:_calNextAttr()
			self:reloadData()

			self._notSliderOp = true

			self._sliderAdapter:SetValue((self._isMaxLv or nil) and (self._targetSlotLv or math.max(self._targetSlotLv - 1, 1)))

			self._notSliderOp = false
		end
	end
end

function StargodplusstrengthView:_setEquipItemData()
	return
end

function StargodplusstrengthView:_calCurrAddExp()
	local allExp = 0

	for index, num in pairs(self._index2num) do
		if num > 0 then
			local data = self._curViewDatas[index]

			allExp = allExp + data.exp * num
		end
	end

	return allExp
end

function StargodplusstrengthView:_calNextAttr()
	local allExp = self:_calNextExp()

	self:_setExp(allExp)
end

function StargodplusstrengthView:_calNextExp()
	local allExp = self:_calCurrAddExp()

	return self._slotData.exp + allExp
end

function StargodplusstrengthView:_exp2lv(exp)
	local lv = self._strenCfgs[#self._strenCfgs].lv

	for i = #self._strenCfgs, 1, -1 do
		if exp >= self._strenCfgs[i].exp then
			lv = self._strenCfgs[i].lv

			break
		end
	end

	return lv
end

function StargodplusstrengthView:_preCalCanAdd(cindex)
	local currAddExp = self:_calCurrAddExp()
	local scfg = StargodplusConfig.instance:getSlotCfg(self._slotId)
	local slpCfg = StargodplusConfig.instance:getSlotLvPlan(scfg.slotLvPlan)
	local lastSlpCfg = slpCfg[#slpCfg]
	local data = self._curViewDatas[cindex]

	if data.exp + currAddExp > lastSlpCfg.exp then
		for index, cdata in ipairs(self._curViewDatas) do
			self._index2num[index] = self._index2num[index] or 0

			if cindex ~= index and (not cdata.isEquip or cdata.mo:getQuality() < 4) and self._index2num[index] < cdata.num and cdata.exp < data.exp and cdata.exp <= lastSlpCfg.exp - currAddExp and cdata.exp * cdata.num + currAddExp >= lastSlpCfg.exp then
				return false
			end
		end
	end

	return true
end

function StargodplusstrengthView:_setExp(exp)
	local isMax = true
	local currExp = 0
	local baseExp = 1
	local len = #self._strenCfgs
	local maxExp = self._strenCfgs[len].exp
	local maxCostCoin = maxExp * StargodplusConfig.instance:getExp2CoinRatio()

	for i, v in ipairs(self._strenCfgs) do
		self._targetSlotLv = v.lv

		if exp < v.exp then
			if self._strenCfgs[i - 1] then
				if not self._strenCfgs[i - 1].exp then
					local preExp = 0

					isMax = false
					currExp = exp - preExp
					baseExp = v.exp - preExp
					self._targetSlotLv = v.lv

					break
				end
			end
		end
	end

	self._isMaxLv = isMax

	if isMax then
		self._qhBarSlider.value = 1
		baseExp = maxExp - self._strenCfgs[len - 1].exp
		currExp = exp - self._strenCfgs[len - 1].exp
	else
		self._qhBarSlider.value = currExp / baseExp
	end

	self._qhNumTxt.text = isMax and "最大等级MAX" or string.format("%s/%s", currExp, baseExp)
	self._qhNowTxt.text = "Lv." .. math.max(self._targetSlotLv - 1, 1)
	self._qhNextTxt.text = "Lv." .. self._targetSlotLv

	if isMax then
		self._txNow.text = "Lv." .. self._slotMaxLv or "Lv." .. math.max(self._targetSlotLv - 1, 1)
	end

	goutil.setActive(self._lvCompareConGo, not isMax)

	if isMax then
		self._maxLvText.text = "Lv" .. self._targetSlotLv .. "(MAX)" or ""
	end

	self._needCostCoinNum = (exp - self._slotData.exp) * StargodplusConfig.instance:getExp2CoinRatio()
	self._needCostCoinNum = math.min(maxCostCoin, self._needCostCoinNum)

	local hasNum = MaterialFacade.instance:getMatNumber(MatType.Coin, MatType.Coin_Gold)

	self._moneyCountTxt.text = string.format("<color=%s>%s</color>", hasNum < self._needCostCoinNum and "#c83c49" or "#4eae1a", self._needCostCoinNum)

	self:_setAttr(math.max(self._targetSlotLv - 1, 1), self._targetSlotLv)
end

function StargodplusstrengthView:_setAttr(oldLv, newLv)
	local resList = StargodplusModel.instance:getSlotCompareList(self._slotData.fillerDefineId, oldLv, newLv)

	self._attrGroup:updateWithMoArray(resList, function(item, data)
		local iconChange = goutil.findChild(item.mainGO, "attrIconSpt"):GetComponent(ComponentType.UIImageSpriteChange)
		local lvcon = goutil.findChild(item.mainGO, "lvcon")
		local nameText = goutil.findChildTextComponent(item.mainGO, "qhNameTxt")
		local nowText = goutil.findChildTextComponent(item.mainGO, "lvcon/qhNowCountTxt")
		local nextText = goutil.findChildTextComponent(item.mainGO, "lvcon/qhNextCountTxt")
		local maxNumText = goutil.findChildTextComponent(item.mainGO, "maxNumText")

		goutil.setActive(lvcon, not self._isMaxLv)

		if self._isMaxLv then
			maxNumText.text = data.lastValue or ""
		end

		nameText.text = data.name
		nowText.text = data.preValue
		nextText.text = data.lastValue

		local id = data.id

		if id ~= false then
			iconChange:SetState(id - 1)
		end
	end)
end

function StargodplusstrengthView:_loadData()
	self._cacheSelectItems = {}
	self._petId = StargodplusModel.instance:getCurrShowPetId()

	local petMo = BagPetsController.instance:getPet(self._petId)
	local tempslotDatas = petMo:getStarGodPlusSlots()

	self._slotDatas = {}

	for i, v in ipairs(tempslotDatas) do
		if v.fillerDefineId > 0 then
			table.insert(self._slotDatas, v)
		end
	end

	table.sort(self._slotDatas, function(a, b)
		return a.slot < b.slot
	end)

	for i, v in ipairs(self._slotDatas) do
		if v.slot == self._slotId then
			self._currIndex = i
			self._slotData = v

			break
		end
	end

	local tmpCfg = StargodplusConfig.instance:getFillerCfg(self._slotData.fillerDefineId)

	self._quality = tmpCfg and tmpCfg.quality
	self._currSlotLv = StargodplusModel.instance:getSlotLv(self._slotData.slot, self._slotData.exp)

	local cfg = StargodplusConfig.instance:getSlotCfg(self._slotData.slot)

	self._strenCfgs = StargodplusConfig.instance:getSlotLvPlan(cfg.slotLvPlan)
	self._slotMaxExp = self._strenCfgs[#self._strenCfgs].exp
	self._slotMaxLv = self._strenCfgs[#self._strenCfgs].lv

	local proxy = MaterialMgr.setCell(MatType.StarGodPlus, self._slotData.fillerDefineId, self._equipItemGo)

	if proxy then
		proxy.binder:setNum(0)
	end

	self._equipNameTxt.text = tmpCfg.name
end

function StargodplusstrengthView:_upgradeRes()
	self:_loadData()
	self:_updateView()
	self:_initSlider()
end

function StargodplusstrengthView:_checkUseNumIsOk()
	return self._selectTotalNum < StargodplusConfig.instance:getMaxSelectStrenNum()
end

function StargodplusstrengthView:_onAddSelectTotalNum(isAdd, index)
	local addNum = isAdd and 1 or -1
	local data = self._curViewDatas[index]

	if data.matType == MatType.Item then
		local matId = data.matId

		if isAdd then
			if self._cacheSelectItems[matId] and self._cacheSelectItems[matId] > 0 then
				self._cacheSelectItems[matId] = self._cacheSelectItems[matId] + 1
			else
				self._cacheSelectItems[matId] = 1
				self._selectTotalNum = self._selectTotalNum + addNum
			end
		else
			self._cacheSelectItems[matId] = self._cacheSelectItems[matId] - 1

			if self._cacheSelectItems[matId] <= 0 then
				self._selectTotalNum = self._selectTotalNum + addNum
			end
		end
	else
		self._selectTotalNum = self._selectTotalNum + addNum
	end
end

function StargodplusstrengthView:_initSlider()
	self._notSliderOp = true
	self._sliderAdapter.slider.minValue = self._currSlotLv
	self._sliderAdapter.slider.maxValue = #self._strenCfgs
	self._txNow.text = "Lv." .. self._currSlotLv
	self._txNext.text = "Lv." .. #self._strenCfgs

	self._sliderAdapter:SetValue(self._currSlotLv)

	self._notSliderOp = false
end

function StargodplusstrengthView:_setSliderValue(value)
	if self._notSliderOp then
		self._notSliderOp = false

		return
	end

	local num = math.ceil(value)

	self:_onClickputInBtn(num)
	self:_setExp(self:_calNextExp())
end

function StargodplusstrengthView:_onEndDrag(go, eventData)
	local targetSlotLv = math.ceil(self._sliderAdapter:GetValue())

	self:_onClickputInBtn(targetSlotLv)
	self:_setExp(self:_calNextExp())
	self._sliderAdapter:SetValue((self._isMaxLv or nil) and (self._targetSlotLv or math.max(self._targetSlotLv - 1, 1)))
end

function StargodplusstrengthView:_onClickAddBtn()
	local nextExp = self:_calNextExp()
	local nextLv = self:_exp2lv(nextExp)
	local isMax = nextLv >= self._slotMaxLv

	if isMax then
		if not self._slotMaxLv then
			local targetSlotLv = nextLv + 1

			self:_onClickputInBtn(targetSlotLv)

			self._notSliderOp = true
			nextExp = self:_calNextExp()
			nextLv = self:_exp2lv(nextExp)

			self._sliderAdapter:SetValue(nextLv)

			self._notSliderOp = false
		end
	end
end

function StargodplusstrengthView:_onClickSubtractBtn()
	local add = self:_calCurrAddExp()

	if add <= 0 then
		return
	end

	local nextExp = self:_calNextExp()
	local nextLv = self:_exp2lv(nextExp)
	local targetSlotLv = nextLv - 1

	self:_onClickputInBtn(targetSlotLv)

	nextExp = self:_calNextExp()
	nextLv = self:_exp2lv(nextExp)
	self._notSliderOp = true

	self._sliderAdapter:SetValue(nextLv)

	self._notSliderOp = false
end

return StargodplusstrengthView
