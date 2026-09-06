-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemrecycleView.lua

module("logic.extensions.itembag.view.ItemrecycleView", package.seeall)

local ItemrecycleView = class("ItemrecycleView", ViewComponent)
local LIMIT = 300
local LIMIT_5000 = 50000
local read_only_list = {}

function ItemrecycleView:ctor()
	ItemrecycleView.super.ctor(self)
end

function ItemrecycleView:unbindEvents()
	ItemrecycleView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnOk)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSetting)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function ItemrecycleView:bindEvents()
	ItemrecycleView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOk, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnSetting, self._onClickSetting, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function ItemrecycleView:buildUI()
	ItemrecycleView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self._btnRule = self:getBtn("btnRule")
	self._btnFilter = self:getBtn("btnFilter")
	self._btnSetting = self:getBtn("btnSetting")
	self._redBtnSetting = self:getGo("btnSetting/redPoint")
	self.container = self:getGo("container")
	self._imgEmpty = self:getGo("imgEmpty")
	self._tabCon = self:getGo("tabCon")
	self._btnOk = self:getGo("rightInfoGo/btnOk")
	self._btnOneKey = self:getGo("rightInfoGo/btnOneKey")
	self._btnHelp = self:getGo("rightInfoGo/btnHelp")
	self._bubble = self:getGo("rightInfoGo/bubble")
	self._txtBubble = self:getTxt("rightInfoGo/bubble/txt")
	self._leftTitleTxt1 = self:getTxt("rightInfoGo/leftTitleTxt1")
	self._leftTitleTxt2 = self:getTxt("rightInfoGo/leftTitleTxt2")
	self._leftViewport = self:getGo("BagList/top/TweensNode/ImgBg")
	self.scroll = self:getGo("BagList/top/TweensNode/ScrollView")
	self.cell = self:getGo("Cell")
	self._tableview = ScrollerList.create(self.scroll, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.disposeCell, self))

	local topScroll = self:getGo("rightInfoGo/topTableview")
	local cell_1 = self:getGo("rightInfoGo/cell")

	self._topScrollList = ScrollerList.create(topScroll, cell_1, GameUtil.handler(self._updateTopCell, self), GameUtil.handler(self.clearTopCell, self))

	local downScroll = self:getGo("rightInfoGo/matItemsGo/downTableView")
	local cell_2 = self:getGo("rightInfoGo/cell2")

	self._downScrollList = ScrollerList.create(downScroll, cell_2, GameUtil.handler(self._updateDownCell, self), GameUtil.handler(self.clearDownCell, self))
	self._tabCell = self:getGo("Btn")
	self._markGo = self:getGo("Marks")

	GameUtil.SetActive(self._tabCell, false)
	GameUtil.SetActive(self._btnSetting, true)
end

function ItemrecycleView:onExit()
	ItemrecycleView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnSetting)

	self._selectList = {}

	self._tableview:dispose()
	self._topScrollList:dispose()
	self._downScrollList:dispose()
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
end

function ItemrecycleView:onEnter()
	ItemrecycleView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._redBtnSetting, RedPointModel.ID_EQUIPRECYCLE)

	self._curSelectIdx = 1

	local index = checknumber(self:getFirstParam())

	if index > 0 then
		self._curSelectIdx = index
	end

	self._curCount = 0
	self._selectCountMap = {}
	self._selectMap = {}

	self:_initFilter()
	self:_refreshUI(true)
	self.addGEvent(self, GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterType, self._updateSelectHolyStripe, self)
	self.addGEvent(self, HolyStripeAgent.PM_HolyStripeChangeRes, self._updateHolyStripeLockState, self)
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.ITEM_RECYCLE_INFO_UPDATE, self._refreshUI, self)
	ItemRecycleController.instance:sendGetInfo()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
end

function ItemrecycleView:_checkRefreshTime()
	ItemRecycleController.instance:sendGetInfo()
end

function ItemrecycleView:_initFilter()
	self._sifterParams = {}

	local str = self._viewPresentor.viewName .. "#3:属性:属性筛选:115,240#4:职业:职业筛选:245,240#6:品质:品质筛选:400,1#5:部位:部位筛选:400,2"
	local aa = PetEquipModel.instance:getFactorySifterCfgs(str, self._viewPresentor.viewName)

	if aa and #aa > 0 then
		self._sifterParams = aa
	end
end

function ItemrecycleView:_updataSelectSifter(viewName, ayType, planId, attrs, isReset)
	if self.selectType == MatType.Equipment then
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

		self:_refreshList()
	end
end

function ItemrecycleView:_updateSelectHolyStripe(selectList, isReset)
	if self.selectType ~= MatType.HolyStripe then
		return
	end

	self._selectList = self._selectList or {}
	self._selectList = isReset and {} or selectList

	self:_refreshList()
end

function ItemrecycleView:_updateHolyStripeLockState(status, msg)
	if self.selectType ~= MatType.HolyStripe then
		return
	end

	local mo

	if msg.changedInfos then
		mo = msg.changedInfos[1]
	end

	local list = self._tableview:getData()

	if list and mo and mo.lock then
		for i, v in ipairs(list) do
			if v.item:getId() == mo.id then
				self:_onClickReduce(v)
				self:_refreshList()

				return
			end
		end
	end

	self:_refreshList()
end

function ItemrecycleView:_refreshUI(boo)
	GameUtil.SetActive(self._btnSetting, PetEquipModel.instance.equipRecycleQua ~= nil and PetEquipModel.instance.equipRecycleQua ~= -1)

	local list = ItemRecycleConfig.instance:getTabList()

	goutil.clearChildren(self._markGo)
	GameUtil.SetActive(self._btnHelp, false)
	GameUtil.SetActive(self._bubble, false)

	self._tabDataList = {}
	self._tabCellList = {}

	for i, v in ipairs(list) do
		if checknumber(v.funId) == 0 or FuncOpenModel.instance:getFuncIsOpen(checknumber(v.funId)) then
			table.insert(self._tabDataList, v)

			local cell = goutil.clone(self._tabCell, "btn_" .. i)

			goutil.addChildToParent(cell, self._markGo)
			table.insert(self._tabCellList, cell)
			GameUtil.SetActive(cell, true)

			local redPoint = goutil.findChild(cell, "redPoint")
			local txt1 = goutil.findChildTextComponent(cell, "Txt")
			local txt2 = goutil.findChildTextComponent(cell, "Txt2")

			txt1.text = v.tabName
			txt2.text = v.tabName

			GameUtil.SetActive(redPoint, false)
			GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTab, self, i))
			self:_setTabSelect(cell, i == self._curSelectIdx)
		end
	end

	self:_onClickTab(self._curSelectIdx, boo)
end

function ItemrecycleView:_onClickRule()
	TipsFacade.instance:openRulesView("ItemrecycleView_rule")
end

function ItemrecycleView:_onClickSetting()
	if not FuncOpenController.instance:checkFuncIdOrShowLockTips(660) then
		return
	end

	RedPointController.instance:saveUserMoonRedPoint(RedPointModel.ID_EQUIPRECYCLE)
	UIStateManager.instance:push(ViewName.EquipRecycleQuality)
end

function ItemrecycleView:_onClickFilter()
	local data = {}

	if self.selectType == MatType.Equipment then
		data.alchemyType = PetEquipModel.AlchemyType.Equip
		data.btnTabInfo = self._sifterParams
		data.choList = self._sifterList or {}
		data.itemGo = self._btnFilter

		UIStateManager.instance:open(ViewName.EquipFilterView, data)
	elseif self.selectType == MatType.HolyStripe then
		data.selectList = self._selectList or {}
		data.itemGo = self._btnFilter

		self:showTabAt(self._tabCon, ViewName.HolyStripeFilterView, data)
	end
end

function ItemrecycleView:_onClickHelp()
	self:_showBubble(2)
end

function ItemrecycleView:_showBubble(time)
	local list = {}

	for key, nowCount in pairs(self._selectCountMap) do
		local cfg = self._itemConverMap[self.selectType][key]
		local timeLimit = checknumber(cfg.timeLimit)

		if nowCount > 0 and timeLimit > 0 then
			local topStr = ""

			if not cfg.periodType then
				if cfg.periodType == "weekly" then
					topStr = "每周限额："
				elseif cfg.periodType == "daily" then
					topStr = "每日限额："
				elseif cfg.periodType == "monthly" then
					topStr = "每月限额："
				end

				if not cfg.desc then
					local desc = ""

					desc = topStr .. desc

					local todayTime = ItemRecycleModel.instance:getTotalTimes(self.selectType, key)

					if timeLimit <= todayTime + nowCount then
						local str = langPara(desc .. "<color=#eb4642>(%s/%s)</color>", todayTime + nowCount, timeLimit)

						table.insert(list, str)
					else
						local str = langPara(desc .. "(%s/%s)", todayTime + nowCount, timeLimit)

						table.insert(list, str)
					end
				end
			end
		end
	end

	if #list > 0 then
		self._txtBubble.text = table.concat(list, "\n")

		GameUtil.SetActive(self._btnHelp, true)
		GameUtil.SetActive(self._bubble, true)

		local cgruop = self._bubble:GetComponent(typeof(UnityEngine.CanvasGroup))

		cgruop.alpha = 1

		UnityTweens.UITweenFade.StopTween(self._bubble)
		UnityTweens.UITweenFade.StartTween(self._bubble, 1, 0, time or 1, UnityTweens.EaseType.easeInQuad)
	else
		GameUtil.SetActive(self._btnHelp, false)
		GameUtil.SetActive(self._bubble, false)
	end
end

function ItemrecycleView:_onClickOk()
	local list = self.selectType == MatType.Item and self:_getDefineList() or self:_getQualiytList()

	if list and #list > 0 then
		if not self:_checkPasswordLockPass(list) then
			return
		end

		local content = lang("资源回收物品不能恢复！确定要回收选中的物品吗？")

		if self.selectType == MatType.Equipment then
			local qualityList = {}
			local throneList = {}

			for i, v in ipairs(list) do
				for j, id in ipairs(v.itemIds) do
					local info = PetEquipModel.instance:GetEquipInfo(id)

					if info then
						local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(info.baseId)

						if cfg.throneRelatedSkinId > 0 then
							throneList[info.baseId] = (throneList[info.baseId] or 0) + 1
						elseif cfg.quality == 9 or cfg.quality == 10 then
							qualityList[cfg.quality] = ((not qualityList[cfg.quality] or nil) and 0) + 1
						end
					end
				end
			end

			local strList = {
				content
			}

			for id, num in pairs(throneList) do
				local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(id)
				local skinName = PetSkinConfig.instance:getPetSkinName(cfg.throneRelatedSkinId)

				table.insert(strList, string.format("%s*%s(%s神器)", cfg.name, num, skinName))
			end

			for quality, num in pairs(qualityList) do
				if quality == 9 then
					table.insert(strList, string.format("橙+1装备*%s", num))
				elseif quality == 10 then
					table.insert(strList, string.format("橙+2装备*%s", num))
				end
			end

			content = table.concat(strList, "\n")
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
			if self.selectType == MatType.Item then
				ItemRecycleController.instance:sendDefineList(list)
			else
				ItemRecycleController.instance:sendQualiytList(list)
			end
		end)
	else
		TipsFacade.instance:openCommonTips("请先选择物品")
	end
end

function ItemrecycleView:_getDefineList()
	local map = {}

	for k, data in pairs(self._selectMap) do
		if #data.itemList > 0 then
			for i, mo in ipairs(data.itemList) do
				if self._itemConverMap then
					local id = data.key
					local cfg = self._itemConverMap[self.selectType][id]
					local periodId = checknumber(cfg.periodId)

					map[periodId] = map[periodId] or {}
					map[periodId][id] = checknumber(map[periodId][id]) + 1
				end
			end
		end
	end

	local res = {}

	for periodId, temp in pairs(map) do
		for id, num in pairs(temp) do
			local pb = {}

			pb.materialType = self.selectType
			pb.periodId = periodId
			pb.defineId = id
			pb.num = num

			table.insert(res, pb)
		end
	end

	return res
end

function ItemrecycleView:_getQualiytList()
	local map = {}

	for k, data in pairs(self._selectMap) do
		for i, mo in ipairs(data.itemList or {}) do
			local key = data.key

			if key then
				local cfg = self._itemConverMap[self.selectType][key]
				local periodId = checknumber(cfg.periodId)

				map[periodId] = map[periodId] or {}

				table.insert(map[periodId], mo:getId())
			end
		end
	end

	local res = {}

	for pid, arr in pairs(map) do
		local pb = {}

		pb.materialType = self.selectType
		pb.periodId = pid
		pb.itemIds = arr

		table.insert(res, pb)
	end

	return res
end

function ItemrecycleView:_onClickTab(idx, isForce)
	self._curSelectIdx = idx

	for i, cell in ipairs(self._tabCellList) do
		self:_setTabSelect(cell, i == idx)
	end

	local cfg = self._tabDataList[idx]

	self.selectType = cfg.matType
	self._leftTitleTxt2.text = cfg.desc or ""
	self._selectMap = {}
	self._selectCountMap = {}

	self:_refreshList()
	self:_updateRightList()
end

function ItemrecycleView:_refreshList()
	self._itemConverMap = {}

	local list = {}

	self._currLimit = LIMIT

	GameUtil.SetActive(self._btnFilter, false)

	if self.selectType == MatType.Equipment then
		GameUtil.SetActive(self._btnFilter, true)

		list, self._itemConverMap = ItemRecycleModel.instance:GetRecycleEquipList(self._sifterList)
	elseif self.selectType == MatType.Throne then
		list, self._itemConverMap = ItemRecycleModel.instance:GetRecycleThroneList()
	elseif self.selectType == MatType.Item then
		self._currLimit = LIMIT_5000
		list, self._itemConverMap = ItemRecycleModel.instance:GetRecycleItemsList()
	elseif self.selectType == MatType.HolyStripe then
		GameUtil.SetActive(self._btnFilter, true)

		list, self._itemConverMap = ItemRecycleModel.instance:GetRecycleHolyStripeList(self._selectList)

		table.sort(list, function(a, b)
			if a.item.getIsReadyToDiscard then
				local aDiscard = a.item:getIsReadyToDiscard()

				if b.item.getIsReadyToDiscard then
					local bDiscard = b.item:getIsReadyToDiscard()

					return a.item.getIsReadyToDiscard and not bDiscard
				end
			end
		end)
	end

	self._tableview:reloadData(list)
	GameUtil.SetActive(self._imgEmpty, list == nil or #list == 0)
end

function ItemrecycleView:disposeCell(cell, data)
	local con = goutil.findChild(cell, "con")
	local btn = goutil.findChild(cell, "btn")
	local redPoint = goutil.findChild(cell, "redPoint")
	local lock = goutil.findChild(cell, "lock")
	local discard = goutil.findChild(cell, "discard")

	goutil.setActive(lock, false)
	goutil.setActive(discard, false)
	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(con)
end

function ItemrecycleView:_updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local btn = goutil.findChild(cell, "btn")
	local btnReduce = goutil.findChild(cell, "btnReduce")
	local countGo = goutil.findChild(cell, "countGo")
	local txtCount = goutil.findChildTextComponent(cell, "countGo/txt")
	local select = goutil.findChild(cell, "select")
	local redPoint = goutil.findChild(cell, "redPoint")
	local lock = goutil.findChild(cell, "lock")
	local discard = goutil.findChild(cell, "discard")

	goutil.setActive(lock, false)
	goutil.setActive(discard, false)
	goutil.setActive(redPoint, false)
	goutil.setActive(select, false)
	goutil.setActive(countGo, false)
	goutil.setActive(btnReduce, false)
	GameUtil.rmClickHandler(btn)
	GameUtil.rmClickHandler(btnReduce)
	MaterialMgr.resetAll(con)

	if data then
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickItem, self, data, cell))
		GameUtil.addClickHandler(btnReduce, GameUtil.handler(self._onClickReduce, self, data, cell))

		local temp = self._selectMap[data.index]
		local itemList = read_only_list

		if temp then
			itemList = temp.itemList or read_only_list
		end

		if self.selectType == MatType.HolyStripe then
			if data.item:getIsLock() then
				goutil.setActive(lock, true)
			end

			if data.item:getIsReadyToDiscard() then
				goutil.setActive(discard, true)
			end
		end

		GameUtil.SetActive(select, #itemList > 0)
		GameUtil.SetActive(btnReduce, #itemList > 0)
		GameUtil.SetActive(countGo, true)

		txtCount.text = #itemList .. "/" .. data.totalCount

		local item = data.item
		local proxy = MaterialMgr.setCellByMo(item, con)

		if proxy then
			proxy.binder:setNum(0)
			proxy:setAutoTips(false)
		end
	end
end

function ItemrecycleView:_updateTopCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local img = goutil.findChild(cell, "img")
	local btn = goutil.findChild(cell, "btnReduce")
	local countGo = goutil.findChild(cell, "countGo")
	local txtCount = goutil.findChildTextComponent(cell, "countGo/txt")

	goutil.setActive(countGo, false)
	goutil.setActive(btn, false)
	goutil.setActive(img, false)
	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(con)

	if data and data.itemList then
		goutil.setActive(btn, true)
		goutil.setActive(img, true)
		GameUtil.SetActive(countGo, #data.itemList > 1)

		txtCount.text = #data.itemList

		local proxy = MaterialMgr.setCellByMo(data.item, con)

		if proxy then
			proxy.binder:setNum(0)
			proxy:setAutoTips(false)
		end

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickReduce, self, data))
	end
end

function ItemrecycleView:clearTopCell(cell)
	local con = goutil.findChild(cell, "con")
	local btn = goutil.findChild(cell, "btnReduce")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(con)
end

function ItemrecycleView:_updateDownCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCellByCfg(data, cell)

	if proxy then
		-- block empty
	end
end

function ItemrecycleView:clearDownCell(cell)
	MaterialMgr.resetAll(cell)
end

function ItemrecycleView:_onClickReduce(data)
	local id = data.index
	local temp = self._selectMap[id]

	if temp and #temp.itemList > 0 then
		temp.itemList[#temp.itemList] = nil
		self._selectCountMap[data.key] = math.max(0, checknumber(self._selectCountMap[data.key]) - 1)

		self:_showBubble()
	end

	local list = self._tableview:getData()

	if list then
		for i, v in ipairs(list) do
			if v.index == data.index then
				self._tableview:updateCellInViewByIndex(i - 1)

				break
			end
		end
	end

	self:_updateRightList()
end

function ItemrecycleView:_onClickOneKey()
	local left = self._currLimit - checknumber(self._curCount)

	if left > 0 then
		local count = 0
		local list = self._tableview:getData() or {}

		for i, data in ipairs(list) do
			for j = 1, data.totalCount do
				if self:_addOneItem(data, false) then
					count = count + 1

					if left <= count then
						self._tableview:refresh()
						self:_updateRightList()

						return
					end
				elseif self.selectType == MatType.Throne or self.selectType == MatType.Item then
					break
				end
			end
		end

		self._tableview:refresh()
		self:_updateRightList()
	end
end

function ItemrecycleView:_addOneItem(data, isShowBubble)
	local key = data.key
	local cfg = self._itemConverMap[self.selectType][key]

	if checknumber(cfg.timeLimit) > 0 then
		local todayTime = ItemRecycleModel.instance:getTotalTimes(self.selectType, key)
		local nowCount = checknumber(self._selectCountMap[data.key])

		if todayTime + nowCount >= checknumber(cfg.timeLimit) then
			if isShowBubble then
				TipsFacade.instance:openCommonTips(langPara("%s回收上限%s个，不能再添加了", cfg.desc, cfg.timeLimit))
				self:_showBubble()
			end

			return false
		end
	end

	if self.selectType == MatType.HolyStripe and data.item:getIsLock() then
		return false
	end

	local id = data.index
	local temp = self._selectMap[id]

	if temp then
		if #temp.itemList < data.totalCount then
			local item = data.itemList[#temp.itemList + 1]

			if item == nil then
				item = data.itemList[1]
			end

			table.insert(temp.itemList, item)

			self._selectCountMap[data.key] = checknumber(self._selectCountMap[data.key]) + 1

			if isShowBubble then
				self:_showBubble()
			end

			return true
		end
	else
		if table.nums(self._selectMap) >= LIMIT then
			if isShowBubble then
				TipsFacade.instance:openCommonTips("当前放入道具类型过多，请分解后再操作")
			end

			return false
		end

		temp = {
			key = data.key,
			index = data.index,
			item = data.item,
			itemList = {}
		}

		local item = data.itemList[1]

		table.insert(temp.itemList, item)

		self._selectCountMap[data.key] = checknumber(self._selectCountMap[data.key]) + 1

		if isShowBubble then
			self:_showBubble()
		end

		self._selectMap[id] = temp

		return true
	end

	return false
end

function ItemrecycleView:_onClickItem(data)
	if self._curCount >= self._currLimit then
		TipsFacade.instance:openCommonTips(langPara("数量已达到%s，不能再添加了", self._currLimit))

		return
	end

	if self.selectType == MatType.HolyStripe then
		CommonTipsMgr.instance:openMaterialTips(self._leftViewport, MatType.HolyStripe, data.item:getDefineId(), data.item)
	end

	if self:_addOneItem(data, true) then
		local list = self._tableview:getData()

		if list then
			for i, v in ipairs(list) do
				if v.index == data.index then
					self._tableview:updateCellInViewByIndex(i - 1)

					break
				end
			end
		end

		self:_updateRightList()
	end
end

function ItemrecycleView:_updateRightList()
	self._curCount = 0

	local list = {}

	for k, data in pairs(self._selectMap) do
		if #data.itemList > 0 then
			table.insert(list, data)

			self._curCount = self._curCount + #data.itemList
		end
	end

	ArraySort.sortOn(list, {
		function(data)
			return data.item.quality
		end,
		function(data)
			return data.item:getId()
		end
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})

	while #list < 12 do
		table.insert(list, {})
	end

	self._topScrollList:reloadData(list)
	self:_updateDownList()

	local limit = self._currLimit
	local map = self._itemConverMap[self.selectType]
	local count = table.nums(map or {})

	if count == 1 then
		for k, cfg in pairs(map) do
			limit = checknumber(cfg.timeLimit)

			local todayTime = ItemRecycleModel.instance:getTotalTimes(self.selectType, cfg.realCostQuality)

			limit = math.max(0, limit - todayTime)

			break
		end
	end

	self._leftTitleTxt1.text = langPara("已选分解道具(%s/%s)", self._curCount, limit)
end

function ItemrecycleView:_updateDownList()
	local list = {}

	if self.selectType == MatType.Equipment then
		local totalExp = 0
		local exclNumList = {}

		for k, data in pairs(self._selectMap) do
			if #data.itemList > 0 then
				for i, mo in ipairs(data.itemList) do
					if self._itemConverMap then
						totalExp = totalExp + mo.equalExp + mo.haveAllExp

						local cfg = self._itemConverMap[self.selectType][data.key]

						table.insert(list, cfg.returnMp)

						if mo:isEquipArtifact() then
							local temp = EquipmentConfig.instance:getThroneRefundCfg(mo.baseId) or {}

							table.insertto(list, temp)
						end

						if mo:isAttrOrExclEquip() then
							if checknumber(mo.exclRaceId) > 0 then
								exclNumList[mo.wearPos] = checknumber(exclNumList[mo.wearPos]) + mo.exclMatNum
							elseif not string.nilorempty(mo.attrType) and mo.attrType ~= "无" then
								exclNumList[mo.wearPos] = checknumber(exclNumList[mo.wearPos]) + mo.attrMatNum
							end
						end
					end
				end
			end
		end

		for pos, v in pairs(exclNumList) do
			local cfg = EquipmentConfig.instance:GetExclusiveMaterial(pos)

			if v > 0 and cfg then
				local id = cfg.id
				local str = MaterialMgr.createSerName(MatType.Item, id, v)

				table.insert(list, str)
			end
		end

		local arr = ItemRecycleModel.instance.equipExpArr
		local equipItems = ItemRecycleModel.instance.equipItems

		for i = #arr, 1, -1 do
			local count = math.floor(totalExp / arr[i])

			totalExp = totalExp - count * arr[i]

			if count > 0 then
				local str = MaterialMgr.createSerName(MatType.Item, equipItems[i], count)

				table.insert(list, str)
			end

			if i == 1 and totalExp > 0 then
				local str = MaterialMgr.createSerName(MatType.Item, equipItems[i], count)

				table.insert(list, str)
			end
		end
	else
		for k, data in pairs(self._selectMap) do
			if #data.itemList > 0 then
				for i, mo in ipairs(data.itemList) do
					if self._itemConverMap then
						local cfg = self._itemConverMap[self.selectType][data.key]

						table.insert(list, cfg.returnMp)
					end
				end
			end
		end
	end

	list = MaterialMgr.combineItemsToList(list)

	self._downScrollList:reloadData(list)
end

function ItemrecycleView:_setTabSelect(cell, select)
	local group = cell.gameObject:GetComponent("UIChangeGroup")
	local txt1 = goutil.findChild(cell, "Txt")
	local txt2 = goutil.findChild(cell, "Txt2")

	GameUtil.SetActive(txt1, select)
	GameUtil.SetActive(txt2, not select)

	if select == true then
		group:SetState(0)
	else
		group:SetState(1)
	end
end

function ItemrecycleView:_checkPasswordLockPass(list)
	if not PasswordLockModel.instance:checkClientPasswordUnlock() then
		local info
		local hasHighQualityEquip = false

		for i, v in ipairs(list) do
			if v.materialType == MatType.Equipment then
				for j, id in ipairs(v.itemIds) do
					info = PetEquipModel.instance:GetEquipInfo(id)

					if info then
						local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(info.baseId)

						if cfg.qualityBase >= 4 then
							hasHighQualityEquip = true

							break
						end
					end
				end
			elseif v.materialType == MatType.HolyStripe then
				for j, id in ipairs(v.itemIds) do
					info = HolyStripeModel.instance:getHolyStripeMo(id)

					if info and info:getQuality() >= 5 then
						hasHighQualityEquip = true

						break
					end
				end
			end

			if hasHighQualityEquip then
				break
			end
		end

		if hasHighQualityEquip and PasswordLockController.instance:checkNeedOpenVerifyView() then
			return false
		end
	end

	return true
end

return ItemrecycleView
