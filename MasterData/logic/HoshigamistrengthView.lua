-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamistrengthView.lua

module("logic.extensions.hoshigami.view.HoshigamistrengthView", package.seeall)

local HoshigamistrengthView = class("HoshigamistrengthView", TableViewComponent)

function HoshigamistrengthView:ctor()
	HoshigamistrengthView.super.ctor(self)
end

function HoshigamistrengthView:buildUI()
	HoshigamistrengthView.super.buildUI(self)

	self._strengthGo = self:getGo("strength")
	self._addBtn = self:getBtn("strength/addBtn")
	self._reduceBtn = self:getBtn("strength/reduceBtn")
	self._strengthBtn = self:getBtn("rightInfo/strengthenBtn")
	self._targetLvText = goutil.findChildTextComponent(self.mainGO, "strength/targetLvText")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "leftInfo/equipNameTxt")
	self._currLvText = goutil.findChildTextComponent(self.mainGO, "leftInfo/lvCompareCon/qhNowTxt")
	self._nextLvText = goutil.findChildTextComponent(self.mainGO, "leftInfo/lvCompareCon/qhNextTxt")
	self._maxLvText = goutil.findChildTextComponent(self.mainGO, "leftInfo/maxLvText")
	self._nextLvBgGo = self:getGo("leftInfo/lvCompareCon")
	self._costCoinText = goutil.findChildTextComponent(self.mainGO, "rightInfo/costText")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "strength/tipText")
	self._equipItemGo = self:getGo("leftInfo/equipItemGo")
	self._costIconGo = self:getGo("rightInfo/costIcon")
	self._costCellGo = self:getGo("strength/costCon/cell")
	self._costConGo = self:getGo("strength/costCon")
	self._costItemGroup = ItemGroup.New(self._costConGo, self._costCellGo, nil, nil, true)
	self._activeCellGo = self:getGo("leftInfo/attr/activeCon/tableview")
	self._activeConGo = self:getGo("leftInfo/attr/activeCon/tablecell")
	self._activeScrollList = ScrollerList.create(self._activeCellGo, self._activeConGo, GameUtil.handler(self._updateActiveCell, self), GameUtil.handler(self._clearActiveCell, self))

	self._activeScrollList:regGetCellSize(GameUtil.handler(self._getActiveCellSize, self))

	self._attrUpConGo = self:getGo("leftInfo/attr/attrUpCon/tableview")
	self._attrUpCellGo = self:getGo("leftInfo/attr/attrUpCon/tablecell")
	self._attrScrollList = ScrollerList.create(self._attrUpConGo, self._attrUpCellGo, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	self._attrScrollList:regGetCellSize(GameUtil.handler(self._getAttrCellSize, self))

	self._imgQualityChange = self:getGo("leftInfo/quaChangeSpt"):GetComponent(ComponentType.UIImageSpriteChange)
	self._backClickBtn = self:getBtn("upInfo/backClickBtn")
	self._slideLeftBtn = self:getBtn("leftInfo/slideLeftBtn")
	self._slideRightBtn = self:getBtn("leftInfo/slideRightBtn")
end

function HoshigamistrengthView:bindEvents()
	HoshigamistrengthView.super.bindEvents(self)
	self._addBtn:AddClickListener(self._onClickaddBtn, self)
	self._reduceBtn:AddClickListener(self._onClickreduceBtn, self)
	self._strengthBtn:AddClickListener(self._onClickstrengthBtn, self)
	self._backClickBtn:AddClickListener(self._onClickbackClickBtn, self)
	self._slideLeftBtn:AddClickListener(self._onClickslideLeftBtn, self)
	self._slideRightBtn:AddClickListener(self._onClickslideRightBtn, self)
end

function HoshigamistrengthView:unbindEvents()
	HoshigamistrengthView.super.unbindEvents(self)
	self._addBtn:RemoveClickListener()
	self._reduceBtn:RemoveClickListener()
	self._strengthBtn:RemoveClickListener()
	self._backClickBtn:RemoveClickListener()
	self._slideLeftBtn:RemoveClickListener()
	self._slideRightBtn:RemoveClickListener()
end

function HoshigamistrengthView:destroyUI()
	HoshigamistrengthView.super.destroyUI(self)
end

function HoshigamistrengthView:onEnter()
	HoshigamistrengthView.super.onEnter(self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UpgradeHoshigamiRes, self._upgradeRes, self)
	self:_initData()
	self:_updateView()
	self:_updateNeedRoleLv()
end

function HoshigamistrengthView:onEnterFinished()
	HoshigamistrengthView.super.onEnterFinished(self)
end

function HoshigamistrengthView:onExit()
	HoshigamistrengthView.super.onExit(self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UpgradeHoshigamiRes, self._upgradeRes, self)
	self._costItemGroup:dispose(function(item)
		local con = goutil.findChild(item.mainGO, "itemcon")

		MaterialMgr.resetAll(con)
	end)
	self._activeScrollList:dispose()
	self._attrScrollList:dispose()
	MaterialMgr.resetAll(self._costIconGo)
	MaterialMgr.resetAll(self._equipItemGo)
end

function HoshigamistrengthView:onExitFinished()
	HoshigamistrengthView.super.onExitFinished(self)
end

function HoshigamistrengthView:_initData()
	local params = self:getOpenParam()

	self._hoshigamiId = params[1]
	self._petId = params[2]

	self:_initSlotData()
	self:_checkShowChangeItemBtn()
end

function HoshigamistrengthView:_initSlotData()
	self._slotDatas = {}
	self._currIndex = 1
	self._currSlotData = false
	self._showClickChangeBtn = false

	if self._petId then
		local petMo = BagPetsController.instance:getPet(self._petId)

		if petMo then
			for i, v in ipairs(petMo.hoshigamis) do
				if v.id > 0 then
					table.insert(self._slotDatas, v)
				end
			end

			for i, v in ipairs(self._slotDatas) do
				if v.id == self._hoshigamiId then
					self._currIndex = i
					self._currSlotData = v

					break
				end
			end
		end
	end

	self._showClickChangeBtn = #self._slotDatas > 1
end

function HoshigamistrengthView:_setCurrInfo()
	self:_initCurrInfo()
	self:_setCurrPower()
	self:_initCurrActiveData()
	self:_setShowHoshigami()
end

function HoshigamistrengthView:_checkShowChangeItemBtn()
	goutil.setActive(self._slideLeftBtn.gameObject, self._showClickChangeBtn)
	goutil.setActive(self._slideRightBtn.gameObject, self._showClickChangeBtn)
end

function HoshigamistrengthView:_initCurrInfo()
	self._hoshigamiInfo = HoshigamiModel.instance:getHoshigamisInfo(self._hoshigamiId)
	self._hoshigamiCfg = HoshigamiConfig.instance:getHoshigamiCfg(self._hoshigamiInfo.defineId)

	local planCfgs = HoshigamiConfig.instance:getMainPropPlan(self._hoshigamiCfg.mainPropPlan)
	local planCfg = planCfgs[self._hoshigamiInfo.mainPropId]

	self._strengthCfgs = HoshigamiConfig.instance:getLvStrenCfg(planCfg.lvPlan)
	self._nameText.text = self._hoshigamiCfg.name
	self._currStrenLv = self._hoshigamiInfo.lv
	self._currStrenLvSubPropertyApps = {}

	if self._hoshigamiInfo.subPropertyApps then
		for i, v in ipairs(self._hoshigamiInfo.subPropertyApps) do
			table.insert(self._currStrenLvSubPropertyApps, v)
		end
	end
end

function HoshigamistrengthView:_setCurrPower()
	return
end

function HoshigamistrengthView:_setShowHoshigami()
	local cfgStr = string.format("%s:%s", MatType.Hoshigami, self._hoshigamiCfg.id)

	MaterialMgr.setCellByCfg(cfgStr, self._equipItemGo)
end

function HoshigamistrengthView:_initCurrActiveData()
	self._activePropDatas = {}

	if self._hoshigamiInfo.subPropertyApps then
		for i, v in ipairs(self._hoshigamiInfo.subPropertyApps) do
			table.insert(self._activePropDatas, {
				isActive = true,
				data = v
			})
		end
	end

	local activeNum = #self._activePropDatas
	local needLvActiveList = {}

	for i = 0, #self._strengthCfgs do
		if self._strengthCfgs[i].subPropPlan > 0 then
			if activeNum <= 0 then
				table.insert(needLvActiveList, self._strengthCfgs[i].level)
			else
				activeNum = activeNum - 1
			end
		end
	end

	table.sort(needLvActiveList, function(a, b)
		return a < b
	end)

	for i, v in ipairs(needLvActiveList) do
		table.insert(self._activePropDatas, {
			isActive = false,
			needLv = v
		})
	end
end

function HoshigamistrengthView:_updateView()
	self:_setCurrInfo()

	local isMaxLv = not self._strengthCfgs[self._hoshigamiInfo.lv + 1]

	self._isMaxLv = isMaxLv

	goutil.setActive(self._strengthGo, not isMaxLv)
	goutil.setActive(self._nextLvBgGo, not isMaxLv)

	if isMaxLv then
		self._maxLvText.text = "Lv." .. self._hoshigamiInfo.lv or ""
	end

	if not isMaxLv then
		self._canStrenMaxLv = HoshigamiModel.instance:getCanStrenMax(self._hoshigamiId)
		self._targetLv = self._hoshigamiInfo.lv + 1
		self._targetLvText.text = string.format("+%s", self._targetLv)
	else
		self._canStrenMaxLv = self._hoshigamiInfo.lv
		self._targetLv = self._hoshigamiInfo.lv
	end

	self:_updateTop()
end

function HoshigamistrengthView:_onClickaddBtn()
	self:_setTargetStrenNum(true)
end

function HoshigamistrengthView:_onClickreduceBtn()
	self:_setTargetStrenNum(false)
end

function HoshigamistrengthView:_onClickstrengthBtn()
	if self._targetLv > self._canStrenMaxLv then
		FloatWordMgr.instance:show("需要提升角色等级")

		return
	end

	local function okFunc()
		HoshigamiAgent.instance:sendPM_UpgradeHoshigamiReq(self._hoshigamiId, self._targetLv)
	end

	if self._costCoinCount then
		local hasNum = MaterialFacade.instance:getMatNumber(MatType.Coin, MatType.Coin_Gold)

		if hasNum < self._costCoinCount then
			FloatWordMgr.instance:show("当前金币不足")

			return
		end
	end

	if self._costList then
		for i, v in ipairs(self._costList) do
			local hasNum = MaterialFacade.instance:getMatNumber(v.matType, v.matId)

			if hasNum < v.needNum then
				FloatWordMgr.instance:show("当前升级材料不足")

				return
			end
		end

		okFunc()
	else
		okFunc()
	end
end

function HoshigamistrengthView:_onClickbackClickBtn()
	self:close()
end

function HoshigamistrengthView:_onClickslideLeftBtn()
	local len = #self._slotDatas

	self._currIndex = (self._currIndex + len - 1) % len

	if self._currIndex == 0 then
		self._currIndex = len
	end

	self._hoshigamiId = self._slotDatas[self._currIndex].id

	self:_setCurrInfo()
end

function HoshigamistrengthView:_onClickslideRightBtn()
	local len = #self._slotDatas

	self._currIndex = (self._currIndex + 1) % len

	if self._currIndex == 0 then
		self._currIndex = len
	end

	self._hoshigamiId = self._slotDatas[self._currIndex].id

	self:_setCurrInfo()
end

function HoshigamistrengthView:_setTargetStrenNum(isAdd)
	local targetNum = self._targetLv + (isAdd and 1 or -1)

	if targetNum > self._canStrenMaxLv then
		FloatWordMgr.instance:show("已达可强化最大等级")

		return
	end

	if targetNum <= self._hoshigamiInfo.lv then
		FloatWordMgr.instance:show("不能再小了哦")

		return
	end

	self._targetLv = targetNum
	self._targetLvText.text = string.format("+%s", targetNum)

	self:_updateTop()
end

function HoshigamistrengthView:_updateTop()
	self:_updateStrenLv()
	self:_updateAttr()
	self:_updateActiveDatas()
	self:_updateCost()
	self:_setCurrPower()
end

function HoshigamistrengthView:_updateStrenLv()
	self._currLvText.text = self._hoshigamiInfo.lv
	self._nextLvText.text = self._targetLv
end

function HoshigamistrengthView:_updateAttr()
	local currCfg = self._strengthCfgs[self._hoshigamiInfo.lv]
	local nextCfg = self._strengthCfgs[self._targetLv]
	local nextMainProps = {}
	local currMainProps = {}
	local tempList1 = string.split(currCfg.mainPropertyApp, "#")

	for i, v in ipairs(tempList1) do
		local tempList2 = string.split(v, "+")

		currMainProps[tempList2[1]] = checknumber(tempList2[2])
	end

	tempList1 = string.split(nextCfg.mainPropertyApp, "#")

	for i, v in ipairs(tempList1) do
		local tempList2 = string.split(v, "+")

		nextMainProps[tempList2[1]] = checknumber(tempList2[2])
	end

	for k, v in pairs(nextMainProps) do
		currMainProps[k] = currMainProps[k] or 0
	end

	local list = {}

	for k, v in pairs(currMainProps) do
		local id = table.indexof(GameEnum.AttrTypeName, k)
		local currValue = GameUtil.GetPropertyValue(id, v)
		local nextValue = GameUtil.GetPropertyValue(id, nextMainProps[k])

		table.insert(list, {
			name = k,
			currValue = currValue,
			nextValue = nextValue
		})
	end

	self._attrScrollList:reloadData(list)
end

function HoshigamistrengthView:_updateActiveDatas()
	self._activeScrollList:reloadData(self._activePropDatas)
end

function HoshigamistrengthView:_updateCost()
	local currCfg = self._strengthCfgs[self._hoshigamiInfo.lv]
	local nextCfg = self._strengthCfgs[self._targetLv]
	local raito = HoshigamiConfig.instance:getRefundRatio()
	local costItemCount = (nextCfg.costItemCount - currCfg.costItemCount) * raito
	local costCoinCount = (nextCfg.costCoinCount - currCfg.costCoinCount) * raito
	local list = {}
	local matId = HoshigamiConfig.instance:getUpgradeCostMatId()

	table.insert(list, {
		matStr = string.format("%s:%s:%s", MatType.Item, matId, costItemCount),
		matType = MatType.Item,
		matId = matId,
		needNum = costItemCount
	})
	MaterialMgr.setIcon(self._costIconGo, MatType.Coin, MatType.Coin_Gold)

	self._costCoinText.text = costCoinCount
	self._costList = list
	self._costCoinCount = costCoinCount

	self._costItemGroup:updateWithMoArray(list, function(item, data)
		local con = goutil.findChild(item.mainGO, "itemcon")
		local txtNum = goutil.findChildTextComponent(item.mainGO, "txtNum")
		local proxy = MaterialMgr.setCellByCfg(data.matStr, con)
		local hasNum = MaterialFacade.instance:getMatNumber(data.matType, data.matId)
		local numStr = string.format("<color=%s>%s</color>/%s", hasNum < data.needNum and "red" or "#4eae1a", hasNum, data.needNum)

		proxy.binder:setNumStr("")

		txtNum.text = numStr
	end)
end

function HoshigamistrengthView:_updateNeedRoleLv()
	local addLv = 1
	local nextCfg = self._strengthCfgs[self._canStrenMaxLv + addLv]
	local roleLv = MofangModel.instance:getCurLv()
	local nextNeedLv

	while nextCfg do
		if roleLv < nextCfg.playerLevelReq then
			nextNeedLv = nextCfg.playerLevelReq

			break
		end

		addLv = addLv + 1
		nextCfg = self._strengthCfgs[self._canStrenMaxLv + addLv]
	end

	self._tipText.text = nextNeedLv and string.format("玩家等级到达%s级后增加强化上限", nextNeedLv) or ""
end

function HoshigamistrengthView:_updateActiveCell(view, cell, data)
	local bgChange = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local txt = goutil.findChildTextComponent(cell.gameObject, "text")

	bgChange:SetState((data.isActive or data.needLv <= self._targetLv) and 1 or 0)

	if data.isActive then
		local name, value = GameUtil.getPropertyInfo(data.data.proertyType, checknumber(string.format("%.4f", data.data.value)))

		txt.text = string.format("%s +%s", name, value)
	else
		txt.text = string.format("强化+%s 激活", data.needLv)
	end
end

function HoshigamistrengthView:_clearActiveCell(cell)
	return
end

function HoshigamistrengthView:_getActiveCellSize(view, index)
	return 100, 100
end

function HoshigamistrengthView:_updateAttrCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local currText = goutil.findChildTextComponent(cell.gameObject, "lvCon/currText")
	local nextText = goutil.findChildTextComponent(cell.gameObject, "lvCon/nextText")
	local maxNumText = goutil.findChildTextComponent(cell.gameObject, "maxNumText")
	local lvCon = goutil.findChild(cell.gameObject, "lvCon")

	goutil.setActive(lvCon, not self._isMaxLv)

	if self._isMaxLv then
		maxNumText.text = data.nextValue or ""
	end

	nameText.text = data.name
	currText.text = data.currValue
	nextText.text = data.nextValue
end

function HoshigamistrengthView:_clearAttrCell(cell)
	return
end

function HoshigamistrengthView:_getAttrCellSize(view, index)
	return 100, 30
end

function HoshigamistrengthView:_upgradeRes()
	self._hoshigamiInfo = HoshigamiModel.instance:getHoshigamisInfo(self._hoshigamiId)

	if self._targetLv > self._currStrenLv then
		UIStateManager.instance:push(ViewName.HoshigamilvupView, self._hoshigamiId, self._currStrenLv, self._currStrenLvSubPropertyApps, self._targetLv, self._hoshigamiInfo.subPropertyApps)

		self._currStrenLv = self._targetLv
	end

	self:_initCurrActiveData()
	self:_updateView()
end

function HoshigamistrengthView:_getPath()
	return {
		cellPath = "rightInfo/itemCell",
		viewPath = "rightInfo/ScrollView"
	}
end

function HoshigamistrengthView:_cellSize(view, index)
	return 100, 100
end

function HoshigamistrengthView:_updateCell(view, cell, data)
	return
end

function HoshigamistrengthView:_clearTableview(cell)
	return
end

return HoshigamistrengthView
