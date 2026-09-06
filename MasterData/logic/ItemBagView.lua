-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemBagView.lua

module("logic.extensions.itembag.view.ItemBagView", package.seeall)

local ItemBagView = class("ItemBagView", ViewComponent)

ItemBagView.TAB_DATAS = {
	{
		name = lang("道具"),
		type = MatType.Item,
		tabViewName = ViewName.ItemstackView,
		redIds = {
			RedPointModel.ID_BAG_PIECE
		}
	},
	{
		name = lang("精灵碎片"),
		type = MatType.PetPiece,
		tabViewName = ViewName.ItempetpiecestackView,
		redIds = {
			RedPointModel.ID_BAG
		}
	},
	{
		offLine = 1,
		name = lang("饰品"),
		type = MatType.Decoration,
		tabViewName = ViewName.ItemequipstackView,
		redIds = {}
	},
	{
		name = lang("装备"),
		type = MatType.Equipment,
		tabViewName = ViewName.ItemequipstackView,
		redIds = {}
	},
	{
		name = lang("星神"),
		type = MatType.StarGodPlus,
		tabViewName = ViewName.ItemStarGodPlusStackView,
		redIds = {}
	},
	{
		name = lang("好感度"),
		type = MatType.Item,
		tabViewName = ViewName.ItemstackView,
		redIds = {}
	},
	{
		name = lang("皮肤"),
		type = MatType.PET_SKIN,
		tabViewName = ViewName.ItemstackView,
		redIds = {}
	},
	{
		name = lang("租借精灵"),
		type = MatType.HIRE_PET,
		tabViewName = ViewName.ItemstackView,
		redIds = {}
	},
	{
		name = lang("限时道具"),
		type = MatType.ExpirableItem,
		tabViewName = ViewName.ItemstackView,
		redIds = {}
	}
}

function ItemBagView:ctor()
	ItemBagView.super.ctor(self)
end

function ItemBagView:destroyUI()
	ItemBagView.super.destroyUI(self)
end

function ItemBagView:onExitFinished()
	ItemBagView.super.onExitFinished(self)
end

function ItemBagView:onEnterFinished()
	ItemBagView.super.onEnterFinished(self)
end

function ItemBagView:unbindEvents()
	ItemBagView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClearInput)
	GameUtil.rmClickHandler(self._btnRecycle)
	GameUtil.rmClickHandler(self._tipBtn)
	self.SearchInputField:RemoveOnValueChanged()
end

function ItemBagView:bindEvents()
	ItemBagView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self._btnClearInput, self._onClickClearInput, self)
	GameUtil.addClickHandler(self._btnRecycle, self._onClickShowRecycle, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickTips, self)
	self.SearchInputField:AddOnValueChanged(self._onSearchValueChanged, self)
	self._tableview:regValueChanged(GameUtil.handler(self._onValueChanged, self))
end

function ItemBagView:onExit()
	ItemBagView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redRecycle)
	MaterialController.instance:unregisterLocalNotify("ItemSold", self._refreshList, self)
	MaterialController.instance:unregisterLocalNotify("ItemUsedBegin", self._onItemUsedBegin, self)
	MaterialController.instance:unregisterLocalNotify("ItemUsed", self._onItemUsedOver, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialGet, self._refreshList, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointSetCommandChange, self._handleRedPointSetCommandChange, self)
	self._tableview:dispose()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BAG_BOX, false)
end

function ItemBagView:buildUI()
	ItemBagView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self.container = self:getGo("container")
	self.imgEmpty = self:getGo("imgEmpty")
	self._btnRecycle = self:getGo("btnRecycle")
	self._redRecycle = self:getGo("btnRecycle/redPoint")
	self.txtEmpty = self:getTxt("imgEmpty/Text")
	self.scroll = self:getGo("BagList/top/TweensNode/ScrollView")
	self.cell = self:getGo("Cell")
	self._tableview = ScrollerList.create(self.scroll, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.disposeCell, self))
	self._markGo = self:getGo("Marks")
	self._tabCell = self:getGo("Marks/Btn")

	GameUtil.SetActive(self._tabCell, false)

	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateExtCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setTabDataFilterCallBack(GameUtil.handler(self._onTabFilter, self))
	self._commonTab:clearAllData()

	for i, data in ipairs(ItemBagView.TAB_DATAS) do
		local obj = self._commonTab:addTabData(data.name, data)
	end

	self.SearchInputField = self:getInput("InputC_Search")
	self._btnClearInput = self:getGo("InputC_Search/BtnClear")
	self._goldBarCon = self:getGo("goldBarCon")
	self._limit = self:getGo("limit")
	self._tipBtn = self:getGo("limit/tipBtn")
	self._txtNum = self:getTxt("limit/txtNum")
end

function ItemBagView:onEnter()
	ItemBagView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._redRecycle, RedPointModel.ID_EQUIPRECYCLE)
	MaterialController.instance:registerLocalNotify("ItemSold", self._refreshList, self)
	MaterialController.instance:registerLocalNotify("ItemUsedBegin", self._onItemUsedBegin, self)
	MaterialController.instance:registerLocalNotify("ItemUsed", self._onItemUsedOver, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self._refreshList, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointSetCommandChange, self._handleRedPointSetCommandChange, self)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)

	local idx = ItemBagModel.instance:getCurrTabIdx()

	if idx ~= nil then
		self._commonTab:setSelectTab(idx)
	else
		self._commonTab:jumpTabByData()
	end
end

function ItemBagView:_onTabFilter(tabData)
	local data = tabData.data

	if checknumber(data.offLine) == 1 then
		return true
	end
end

function ItemBagView:_onUpdateExtCell(view, cell, tabData, tag)
	local redpoint = goutil.findChild(cell, "redpoint")
	local isOn = RedPointSetController.instance:isOnOfBagRed()
	local data = tabData.data

	GameUtil.SetActive(redpoint, false)

	if not data.redIds then
		if #data.redIds > 0 and not isOn then
			RedPointController.instance:regRedPoint(redpoint, unpack(data.redIds))
		else
			RedPointController.instance:unregRedPoint(redpoint)
		end
	end
end

function ItemBagView:_handleRedPointSetCommandChange(commandId)
	local commandData = RedPointSetConfig.instance:getRdsCommandData(commandId)

	if commandData.commandType == RedPointSetEnum.CommandTypes_BagRed then
		self:_updateTabRed()
		self:_refreshList()
	end
end

function ItemBagView:_onItemUsedBegin()
	self._curSaveOffset = checknumber(self._recordOffset)
	self._curSaveData = ItemBagModel.instance:getCurrItem()
	self._curSaveIdx = 0

	local list = self._tableview:getData()

	if list then
		self._curSaveIdx = table.indexof(list, self._curSaveData)
	end
end

function ItemBagView:_onItemUsedOver()
	self._isNotChange = true

	local temY = checknumber(self._curSaveOffset)

	self:resetData()

	local list = self._tableview:getData()

	if list then
		ItemBagModel.instance:setCurrItem(list[0])

		if self._curSaveData then
			local idx = table.indexof(list, self._curSaveData)

			if idx == false and self._curSaveIdx <= #list then
				ItemBagModel.instance:setCurrItem(list[self._curSaveIdx])
			end
		end

		self._tableview:refresh()
		self._tableview:SetOffset(temY, false)
	end

	self._isNotChange = false
end

function ItemBagView:_onValueChanged()
	local go = self._tableview:GetContent()

	if go and not self._isNotChange then
		local x, y, z = Framework.TransformUtil.GetAnchoredPos(go.transform, 0, 0)

		self._recordOffset = y
	end
end

function ItemBagView:_updateTabRed()
	return
end

function ItemBagView:_onClickClose()
	ItemBagModel.instance:setCurrTabIdx(nil)
	ItemBagModel.instance:setCurrItem(nil, false)
	self:close()
end

function ItemBagView:_onClickClearInput()
	self.SearchInputField:SetText("")
	self:_refreshList()
end

function ItemBagView:_onClickShowRecycle()
	UIStateManager.instance:push(ViewName.ItemrecycleView)
end

function ItemBagView:_refreshList()
	self:resetData()

	local list = self._tableview:getData()

	if list then
		local data = ItemBagModel.instance:getCurrItem()
		local idx = table.indexof(list, data)

		if data ~= nil and idx ~= false then
			ItemBagModel.instance:setCurrItem(data)
			self._tableview:MoveCellInView(idx - 1)
		else
			ItemBagModel.instance:setCurrItem(list[1])
			self._tableview:refresh()
			self._tableview:MoveCellInView(0)
		end
	end
end

function ItemBagView:resetData()
	self.selectType = MatType.Item

	local tabData = self._commonTab:getCurrTabData() or {}
	local value = tabData.data

	if value ~= nil then
		self.selectType = value.type
	end

	local type = self.selectType
	local list = MaterialMgr.getModelList(type)

	if value == ItemBagView.TAB_DATAS[1] then
		list = MaterialModel.instance:getMaterialsByTypeExceptSub(MatType.Item_GoodFeel)
	elseif value == ItemBagView.TAB_DATAS[6] then
		list = MaterialModel.instance:getMaterialsByTypeAndSub(MatType.Item_GoodFeel)
	end

	if list then
		if type == MatType.Item then
			ArraySort.sortOn(list, {
				function(mo)
					local cfg = MaterialMgr.getMatCfg(mo.type, mo.id)

					if cfg then
						return cfg.order
					end

					return 0
				end,
				"id"
			})
		else
			ArraySort.sortOn(list, function(mo)
				return mo:getId()
			end)
		end
	end

	local searchStr = self.SearchInputField:GetText()

	if not string.nilorempty(searchStr) then
		local result = {}

		for i, v in ipairs(list) do
			local cfg, matName

			if type == MatType.Item then
				cfg = MaterialMgr.getMatCfg(type, v.id)
				matName = MaterialMgr.getMaterialsName(type, v.id)
			else
				cfg = MaterialMgr.getMatCfg(type, v:getDefineId())
				matName = MaterialMgr.getMaterialsName(type, v:getDefineId())
			end

			if not cfg then
				-- block empty
			elseif string.find(matName, searchStr) or not string.nilorempty(cfg.searchKey) and string.find(cfg.searchKey, searchStr) then
				table.insert(result, v)
			end
		end

		list = result
		self.txtEmpty.text = lang("背包里搜索不到此道具哦")
	else
		self.txtEmpty.text = lang("背包里面没有此类型的物品哦")
	end

	self._tableview:reloadData(list)
	GameUtil.SetActive(self.imgEmpty, list == nil or #list == 0)
	GameUtil.SetActive(self.container, list ~= nil and #list ~= 0)
end

function ItemBagView:_updateCell(view, cell, data)
	local v
	local con = goutil.findChild(cell, "con")
	local btn = goutil.findChild(cell, "btn")
	local redPoint = goutil.findChild(cell, "redPoint")

	goutil.setActive(redPoint, false)
	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(con)
	RedPointController.instance:unregRedPoint(redPoint)

	local redIdList = {}

	if data then
		if data.id ~= -1 then
			GameUtil.addClickHandler(btn, GameUtil.handler(self._clickItem, self, data))
		end

		local proxy = MaterialMgr.setCellByMo(data, con)

		if proxy then
			local _curData = ItemBagModel.instance:getCurrItem()
			local type = MaterialMgr.getMoType(data)
			local ctype = MaterialMgr.getMoType(_curData)

			proxy.binder:setSelected(_curData and _curData:getId() ~= -1 and _curData:getId() == data:getId() and type == ctype)
			proxy:setAutoTips(false)

			if data.type == MatType.PetPiece then
				local redKey = RedPointModel.ID_HANDBOOK_PRE .. data.id

				table.insert(redIdList, redKey)
			elseif data.type == MatType.PET_SKIN then
				proxy.binder:updateTimes()
			elseif data.type == MatType.HIRE_PET then
				proxy.binder:showHireInfo()
			elseif data.type == MatType.Item then
				local redKey = RedPointModel.ID_BAG_PIECE_PRE .. data.id
				local redKey2 = RedPointModel.ID_BAG_BOX_PRE .. data.id

				table.insert(redIdList, redKey)
				table.insert(redIdList, redKey2)
			end
		end
	end

	local isOn = RedPointSetController.instance:isOnOfBagRed()

	if #redIdList > 0 and not isOn then
		RedPointController.instance:regRedPoint(redPoint, unpack(redIdList))
	end
end

function ItemBagView:disposeCell(cell, data)
	local con = goutil.findChild(cell, "con")
	local btn = goutil.findChild(cell, "btn")
	local redPoint = goutil.findChild(cell, "redPoint")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(con)
	RedPointController.instance:unregRedPoint(redPoint)
end

function ItemBagView:_selectTab(idx, force)
	return
end

function ItemBagView:_onUpdateRight(tabData)
	if tabData == nil then
		return
	end

	ItemBagModel.instance:setCurrTabIdx(tabData.root)
	self:_refreshList()

	local data = tabData.data

	GameUtil.SetActive(self._goldBarCon, false)
	GameUtil.SetActive(self._limit, false)

	if data.type == MatType.Equipment or data.type == MatType.StarGodPlus then
		GameUtil.SetActive(self._limit, true)
		self:_showCurrLiitWithType(data.type)
	else
		GameUtil.SetActive(self._goldBarCon, true)
	end

	self:showTabAt(self.container, data.tabViewName)
end

function ItemBagView:_onClickTips()
	local type = self.selectType

	ItemBagController.instance:showLimitTipsWithType(type)
end

function ItemBagView:_showCurrLiitWithType(type)
	local cur, total = ItemBagController.instance:getCurrLiitWithType(type)

	self._txtNum.text = cur > total * 0.9 and langPara("<color=#eb4642>%s</color>/%s", cur, total) or langPara("%s/%s", cur, total)
end

function ItemBagView:setTabSelect(cell, select)
	return
end

function ItemBagView:_clickItem(data)
	ItemBagModel.instance:setCurrItem(data)
	self._tableview:refresh()
end

function ItemBagView:_onSearchValueChanged(searchStr)
	self:_refreshList()
end

return ItemBagView
