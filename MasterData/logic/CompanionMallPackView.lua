-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallPackView.lua

module("logic.extensions.companionmall.view.CompanionMallPackView", package.seeall)

local CompanionMallPackView = class("CompanionMallPackView", ViewComponent)
local CompanionState = {
	HasBuy = 2,
	NotBuy = 4,
	HasReceive = 3,
	SoldOut = 1,
	None = 0
}

function CompanionMallPackView:ctor()
	CompanionMallPackView.super.ctor(self)
end

function CompanionMallPackView:unbindEvents()
	CompanionMallPackView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHelp)
end

function CompanionMallPackView:bindEvents()
	CompanionMallPackView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
end

function CompanionMallPackView:buildUI()
	CompanionMallPackView.super.buildUI(self)

	self._showInfoCell = self:getGo("showInfoCell")
	self._btnHelp = self:getGo("btnHelp")
	self._showPosList = {}

	for i = 1, 7 do
		self._showPosList[i] = self:getGo("showPosList/pos" .. i)
	end

	self._showInfoCon = self:getGo("showInfoCon")
	self._showPosListCon = self:getGo("showPosList")
	self._itemcell = self:getGo("giftinfo/itemcell")

	local goCell = self:getGo("giftinfo/tableview/tablecell")
	local goTab = self:getGo("giftinfo/tableview")

	self._tableviewGiftInfo = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateGiftInfoCell, self), GameUtil.handler(self._clearGiftInfoCell, self))
	self._subTabDic = {}
end

function CompanionMallPackView:onExit()
	CompanionMallPackView.super.onExit(self)
	GameUtil.clearCells(self._showInfoCon, self._clearShowInfoCell, self)
	self._tableviewGiftInfo:dispose()
end

function CompanionMallPackView:onEnter()
	CompanionMallPackView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GET_INFO, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_SELECT_ITEM_FINISH, self._handleSelectFinish, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GAIN_OK, self._handleGainOk, self)
	self.addGEvent(self, GlobalNotify.PM_CompanionMallSelectAddressRes, self._handleSelectAddressRes, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GET_INFO, self._handleChangeAddressInfo, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_ADRESS_INFO, self._handleChangeAddressInfo, self)
	self.addGEvent(self, GlobalNotify.PM_CompanionMallDeleteAddressRes, self._handleChangeAddressInfo, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = CompanionMallController.instance:getDefaultActId()
	end

	self._packGroupId = checknumber(params[2])

	if self._packGroupId == 0 then
		self._packGroupId = 1
	end

	self._activityId = 492003
	self._packGroupId = 1

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	CompanionMallController.instance:sendGetInfo(self._activityId)
	CompanionMallController.instance:sendGetAddressInfo(self._activityId)
end

function CompanionMallPackView:_handleGetInfo()
	self._curSelectIdMap = self._curSelectIdMap or {}

	for sortId, _ in pairs(self._curSelectIdMap) do
		self._curSelectIdMap[sortId] = {}
	end

	self:_updateUIByInfo()
end

function CompanionMallPackView:_handleSelectFinish(sortId, selectIdList)
	self._curSelectIdMap[sortId] = selectIdList or {}

	self:_updateGiftInfos()
end

function CompanionMallPackView:_handleGainOk()
	self:_updateState()
	TipsFacade.instance:openCommonTips("成功领取周边")
	self:_updateShowInfos()
	self:_gainNext()
end

function CompanionMallPackView:_handleSelectAddressRes()
	self:_updateShowInfos()
end

function CompanionMallPackView:_handleChangeAddressInfo()
	self._addressIdList = {}

	local infos = CompanionMallModel.instance:getAddressInfo(self._activityId) or {}

	for i, info in pairs(infos) do
		table.insert(self._addressIdList, info.addressId)
	end

	self:_updateShowInfos()
end

function CompanionMallPackView:_updateUIByCfg()
	self._curItemCfgs = CompanionMallConfig.instance:getItemGroupCfgs(self._activityId, self._packGroupId) or {}
	self._showCfgs = CompanionMallConfig.instance:getPackShowCfgsByGroupId(self._activityId, self._packGroupId) or {}

	self:_correctShowPos()

	self._ruleKey = ""
	self._defaultPrizeStr = ""
	self._defaultGoodsId = -1

	local firstCfg = self._curItemCfgs[1]

	if firstCfg then
		self._ruleKey = firstCfg.ruleKey or ""
		self._defaultPrizeStr = firstCfg.content or ""
		self._defaultGoodsId = firstCfg.goodsId or -1
	end

	self._curSelectIdMap = {}

	for _, cfg in ipairs(self._showCfgs) do
		if not cfg.sortId then
			self._curSelectIdMap[cfg.sortId] = {}
		end
	end
end

function CompanionMallPackView:_getSubDataListByCfg(showCfg)
	local subDataList = {}
	local dealType = showCfg.dealType
	local sortId = showCfg.sortId

	if not self._curSelectIdMap[sortId] then
		local curSelectIdList = {}

		if dealType == "single" then
			local content = ""
			local isSelect = curSelectIdList[1] ~= nil

			if isSelect then
				local selectId = curSelectIdList[1]
				local itemCfg = self._curItemCfgs[selectId]

				content = itemCfg and itemCfg.content or ""

				local data = {}

				data.itemStr = itemCfg.showItem
				data.sortId = sortId
				data.isCanSelect = true

				table.insert(subDataList, data)
			else
				content = self._defaultPrizeStr

				local data = {}

				data.itemStr = ""
				data.sortId = sortId
				data.isCanSelect = true

				table.insert(subDataList, data)
			end

			local prizeAttrs = string.split(content, "#") or {}

			for _, attrStr in ipairs(prizeAttrs) do
				local contentData = {}

				contentData.itemStr = attrStr
				contentData.sortId = sortId
				contentData.isCanSelect = false

				table.insert(subDataList, contentData)
			end
		elseif dealType == "pack" then
			local packCfg = CompanionMallConfig.instance:getSelectPackCfg(self._activityId, showCfg.selectPackId) or {}

			if not packCfg.selectCount then
				local insertNum = 0

				for i = 1, insertNum do
					if not curSelectIdList[i] then
						if not self._curItemCfgs[curSelectIdList[i]] then
							local itemCfg = {}
							local data = {}

							data.itemStr = ""
							data.sortId = sortId

							if itemCfg and itemCfg.showItem then
								data.itemStr = itemCfg.showItem
							end

							data.isCanSelect = true

							table.insert(subDataList, data)
						end
					end
				end

				if not packCfg.content then
					local content = ""
					local prizeAttrs = string.split(content, "#") or {}

					for _, attrStr in ipairs(prizeAttrs) do
						local contentData = {}

						contentData.sortId = sortId
						contentData.itemStr = attrStr
						contentData.isCanSelect = false

						table.insert(subDataList, contentData)
					end
				end
			end
		elseif dealType == "all" then
			for _, itemCfg in ipairs(self._curItemCfgs) do
				local data = {}

				data.itemStr = itemCfg.showItem
				data.sortId = sortId
				data.isCanSelect = false

				table.insert(subDataList, data)
			end

			local packCfg = CompanionMallConfig.instance:getSelectPackCfg(self._activityId, showCfg.selectPackId) or {}

			if not packCfg.content then
				local content = ""
				local prizeAttrs = string.split(content, "#") or {}

				for _, attrStr in ipairs(prizeAttrs) do
					local contentData = {}

					contentData.itemStr = attrStr
					contentData.sortId = sortId
					contentData.isCanSelect = false

					table.insert(subDataList, contentData)
				end
			end
		end

		return subDataList
	end
end

function CompanionMallPackView:_updateState()
	self._companionStateMap = {}

	local info = CompanionMallModel.instance:getInfo(self._activityId) or {}

	if not info.companionInfo then
		local companionInfoList = {}

		for _, companionInfo in ipairs(companionInfoList) do
			local itemCfg = CompanionMallConfig.instance:getItemCfgById(self._activityId, companionInfo.companionId)
			local state = CompanionState.None

			if itemCfg then
				if companionInfo.hasGainCompanion then
					state = CompanionState.HasReceive
				elseif companionInfo.hasBuyCompanion then
					state = CompanionState.HasBuy
				elseif not companionInfo.curGlobalGainCount then
					local curGlobalGainCount = 0

					state = curGlobalGainCount == -1 and CompanionState.None or curGlobalGainCount >= itemCfg.limitTimes and CompanionState.SoldOut or CompanionState.NotBuy
				end
			end

			self._companionStateMap[companionInfo.companionId] = state
		end
	end
end

function CompanionMallPackView:_updateUIByInfo()
	self._hasBuyCount = 0
	self._companionMap = {}

	local info = CompanionMallModel.instance:getInfo(self._activityId) or {}

	if not info.companionInfo then
		local companionInfoList = {}

		for _, companionInfo in ipairs(companionInfoList) do
			self._companionMap[companionInfo.companionId] = companionInfo
		end

		for _, itemcfg in ipairs(self._curItemCfgs) do
			if not itemcfg.companionId then
				if not self._companionMap[itemcfg.companionId] then
					local info = {}

					if info.hasBuyCompanion then
						self._hasBuyCount = self._hasBuyCount + 1
					end
				end
			end
		end

		self:_updateState()
		self:_updateShowInfos()
		self:_updateGiftInfos()
	end
end

function CompanionMallPackView:_correctShowPos()
	goutil.setActive(self._showInfoCell, false)
	goutil.setActive(self._showPosListCon, false)
	goutil.setActive(self._showInfoCon, true)

	local pos = GameUtil.getAnchoredPos(self._showPosListCon)

	if pos then
		GameUtil.setAnchoredPos(self._showInfoCon, pos.x, pos.y)
	end
end

function CompanionMallPackView:_updateShowInfos()
	GameUtil.updateCellsList(self._showInfoCon, self._showInfoCell, self._curItemCfgs, self._updateShowInfoCell, self)
end

function CompanionMallPackView:_updateShowInfoCell(cellGo, data)
	local txt = goutil.findChildTextComponent(cellGo, "txt")
	local txtCount = goutil.findChildTextComponent(cellGo, "count/txt")
	local btnGain = goutil.findChild(cellGo, "btnGain")
	local btnAddress = goutil.findChild(cellGo, "btnAddress")
	local txtBtnAddress = goutil.findChildTextComponent(btnAddress, "txt")

	if not data.companionId then
		GameUtil.rmClickHandler(btnGain)
		GameUtil.rmClickHandler(btnAddress)
		GameUtil.addClickHandler(btnGain, GameUtil.handler(self._onClickBtnGain, self, data.companionId), self)
		GameUtil.addClickHandler(btnAddress, GameUtil.handler(self._onClickBtnAddress, self, data.companionId), self)
		self:_playCellEffect(btnGain)

		if not data.companionId then
			local compainonId = 0
			local posGo = self._showPosList[compainonId]

			if posGo then
				local pos = GameUtil.getAnchoredPos(posGo)

				if pos then
					GameUtil.setAnchoredPos(cellGo, pos.x, pos.y)
				else
					GameUtil.setAnchoredPos(cellGo, 0, 0)
				end
			else
				GameUtil.setAnchoredPos(cellGo, 0, 0)
				printError("未找到对应的显示位置，compainonId = ", compainonId)
			end

			if not self._companionStateMap[compainonId] then
				local state = CompanionState.None

				goutil.setActive(btnGain, state == CompanionState.HasBuy)
				goutil.setActive(btnAddress, state == CompanionState.HasReceive)

				if not self._companionMap[compainonId] then
					if not self._companionMap[compainonId].curGlobalGainCount then
						local curGlobalGainCount = 0

						if not data.limitTimes then
							local limitTimes = 0

							txtCount.text = string.format("%s/<color=#ff6c32>%s</color>", math.max(0, limitTimes - curGlobalGainCount), limitTimes)

							if not self._companionMap[compainonId].addressId then
								txtBtnAddress.text = self._companionMap[compainonId].addressId > 0 and self:_getAddressshow(self._companionMap[compainonId].addressId) or lang("填写地址")
								txt.text = langPara("周边%s", compainonId)
							end
						end
					end
				end
			end
		end
	end
end

function CompanionMallPackView:_clearShowInfoCell(cellGo)
	local btnGain = goutil.findChild(cellGo, "btnGain")
	local btnAddress = goutil.findChild(cellGo, "btnAddress")

	GameUtil.rmClickHandler(btnGain)
	GameUtil.rmClickHandler(btnAddress)
	self:_clearCellEffect(btnGain)
end

function CompanionMallPackView:_getAddressshow(addressId)
	self._addressIdList = self._addressIdList or {}

	table.sort(self._addressIdList, function(a, b)
		return a < b
	end)

	local sortId = 0

	for i, id in ipairs(self._addressIdList) do
		if id == addressId then
			sortId = i

			break
		end
	end

	local str = langPara("地址%s", addressId)

	return (sortId ~= 0 or nil) and langPara("地址%s", sortId)
end

function CompanionMallPackView:_onClickBtnGain(compainonId)
	local idlist = CompanionMallModel.instance:getCurBatchCompanionIdList(self._activityId, compainonId)
	local sendIds = {}

	for i, id in ipairs(idlist) do
		if not self._companionStateMap[id] then
			if self._companionStateMap[id] == CompanionState.HasBuy then
				table.insert(sendIds, id)
			end
		end
	end

	self._gainIdList = sendIds

	self:_gainNext()
end

function CompanionMallPackView:_gainNext()
	self._gainIdList = self._gainIdList or {}

	local nextId

	if #self._gainIdList > 0 then
		nextId = table.remove(self._gainIdList, #self._gainIdList)
	end

	if checknumber(nextId) > 0 then
		CompanionMallController.instance:sendGainCompanion(self._activityId, nextId)
	end
end

function CompanionMallPackView:_onClickBtnAddress(compainonId)
	UIStateManager.instance:push(ViewName.CompanionMallAddressBookPopView, self._activityId, compainonId)
end

function CompanionMallPackView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(effGo.transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function CompanionMallPackView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function CompanionMallPackView:_onClickHelp()
	TipsFacade.instance:openRulesView(self._ruleKey)
end

function CompanionMallPackView:_updateGiftInfos()
	self._tableviewGiftInfo:reloadData(self._showCfgs)
end

function CompanionMallPackView:_updateGiftInfoCell(view, cell, data)
	local go = cell.gameObject
	local subTabview = self._subTabDic[go]

	if not subTabview then
		local goCell = self._itemcell
		local goTab = goutil.findChild(go, "itemlist")

		subTabview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateGiftInfoSubCell, self), GameUtil.handler(self._clearGiftInfoSubCell, self))
		self._subTabDic[go] = subTabview
	end

	if not data.sortId then
		local sortId = 0
		local subDataList = self:_getSubDataListByCfg(data) or {}

		subTabview:reloadData(subDataList)
		subTabview:dragNotifyParent()

		local btnGet = goutil.findChild(go, "btnGet")
		local txtBtnGet = goutil.findChildTextComponent(btnGet, "txt")
		local mark = goutil.findChild(go, "mark")

		GameUtil.rmClickHandler(btnGet)

		local needSeletCount = 0

		if not data.dealType then
			local isMatchCount = false
			local isMatchState = true
			local goodsId = ""

			if not self._curSelectIdMap[sortId] then
				local curSelectIdList = {}
				local addParam = ""

				if not curSelectIdList[1] then
					local cpnId = 0

					for _, selectId in ipairs(curSelectIdList) do
						if not self._companionStateMap[selectId] then
							local state = CompanionState.None

							if state ~= CompanionState.NotBuy then
								isMatchState = false

								break
							end
						end
					end

					if data.dealType == "single" then
						needSeletCount = 1
						isMatchCount = #curSelectIdList == 1
						goodsId = self._defaultGoodsId
						addParam = ""
					elseif data.dealType == "pack" then
						local packCfg = CompanionMallConfig.instance:getSelectPackCfg(self._activityId, data.selectPackId) or {}

						needSeletCount = packCfg.selectCount or 0
						isMatchCount = #curSelectIdList == needSeletCount
						goodsId = packCfg.goodsId or ""

						for _, selectId in ipairs(curSelectIdList) do
							addParam = addParam == "" and selectId or addParam .. "," .. selectId
						end

						cpnId = packCfg.selectPackId or 0
					elseif data.dealType == "all" then
						isMatchCount = true
						needSeletCount = #self._curItemCfgs

						local packCfg = CompanionMallConfig.instance:getSelectPackCfg(self._activityId, data.selectPackId) or {}

						goodsId = packCfg.goodsId or ""

						for _, itemCfg in ipairs(self._curItemCfgs) do
							if not self._companionStateMap[itemCfg.companionId] then
								if self._companionStateMap[itemCfg.companionId] ~= CompanionState.NotBuy then
									isMatchState = false
								end

								addParam = addParam == "" and (itemCfg.companionId or "") or addParam .. "," .. ((not itemCfg.companionId or nil) and "")
							end
						end

						cpnId = packCfg.selectPackId or 0
					end

					txtBtnGet.text = lang("未配置价格")

					local payCfg = PayConfig.instance:getPayGoodsCfg(goodsId)

					if payCfg then
						local cost = payCfg.payMoney / 100

						txtBtnGet.text = "￥" .. cost
					end

					local canSelectCount = #self._curItemCfgs - self._hasBuyCount

					if canSelectCount < needSeletCount then
						goutil.setActive(btnGet, false)
						goutil.setActive(mark, true)
					else
						goutil.setActive(btnGet, true)
						goutil.setActive(mark, false)
						GameUtil.addClickHandler(btnGet, function()
							if not isMatchCount then
								FloatWordMgr.instance:show(lang("请先选择周边"))

								return
							end

							if not isMatchState then
								FloatWordMgr.instance:show(lang("所选周边中包含已购买或已售罄的周边，请重新选择"))

								return
							end

							if goodsId == "" then
								FloatWordMgr.instance:show(lang("未配置购买信息"))

								return
							end

							local subGoodsType = GameEnum.PaySubGoodsType.COMPANION_MALL
							local subGoodsId = self._activityId
							local para = {}

							para.cpnId = cpnId

							if addParam ~= "" then
								para.scs = addParam
							end

							local extParams = GameUtil.jsonToString(para)

							PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
						end, self)
					end
				end
			end
		end
	end
end

function CompanionMallPackView:_clearGiftInfoCell(cell)
	local go = cell.gameObject
	local subTabview = self._subTabDic[go]

	if subTabview then
		subTabview:dispose()
		subTabview:removeDragNotifyParent()

		self._subTabDic[go] = nil
	end

	local btnGet = goutil.findChild(go, "btnGet")

	GameUtil.rmClickHandler(btnGet)
end

function CompanionMallPackView:_updateGiftInfoSubCell(view, cell, data)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local btnReSelect = goutil.findChild(go, "btnReSelect")
	local reselectBg = goutil.findChild(go, "reselectBg")

	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnReSelect)

	local item = goutil.findChild(go, "item")

	if not data.itemStr then
		local itemStr = ""

		if GameUtil.isEmptyString(itemStr) then
			MaterialMgr.resetAll(item)
		else
			MaterialMgr.setCellByCfg(itemStr, item)
		end

		goutil.setActive(btnSelect, data.isCanSelect == true and itemStr == "")
		goutil.setActive(btnReSelect, data.isCanSelect == true and itemStr ~= "")
		goutil.setActive(reselectBg, data.isCanSelect == true and itemStr ~= "")
		GameUtil.addClickHandler(btnSelect, function()
			if not data.sortId then
				UIStateManager.instance:push(ViewName.CompanionMallSelectView, self._activityId, self._packGroupId, data.sortId, self._curSelectIdMap[data.sortId] or {})
			end
		end)
		GameUtil.addClickHandler(btnReSelect, function()
			if not data.sortId then
				UIStateManager.instance:push(ViewName.CompanionMallSelectView, self._activityId, self._packGroupId, data.sortId, self._curSelectIdMap[data.sortId] or {})
			end
		end)
	end
end

function CompanionMallPackView:_clearGiftInfoSubCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)

	local btnReSelect = goutil.findChild(go, "btnReSelect")

	GameUtil.rmClickHandler(btnReSelect)

	local item = goutil.findChild(go, "item")

	MaterialMgr.resetAll(item)
end

return CompanionMallPackView
