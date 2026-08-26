-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionChangeView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionChangeView", package.seeall)

local Act191CollectionChangeView = class("Act191CollectionChangeView", BaseView)

function Act191CollectionChangeView:onInitView()
	self._btnQuickAdd = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#btn_QuickAdd")
	self._goQuickGray = gohelper.findChild(self.viewGO, "left_container/#btn_QuickAdd/#go_QuickGray")
	self._goContent = gohelper.findChild(self.viewGO, "left_container/scroll_collection/Viewport/#go_Content")
	self._goEmpty = gohelper.findChild(self.viewGO, "right_container/#go_Empty")
	self._goHas = gohelper.findChild(self.viewGO, "right_container/#go_Has")
	self._goChangeItem = gohelper.findChild(self.viewGO, "right_container/#go_Has/#go_ChangeItem")
	self._goLayout = gohelper.findChild(self.viewGO, "right_container/#go_Has/#go_Layout")
	self._txtTitle = gohelper.findChildText(self.viewGO, "right_container/title/#txt_Title")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "right_container/#btn_Next")
	self._txtRemainTimes = gohelper.findChildText(self.viewGO, "right_container/#txt_RemainTimes")
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "right_container/#btn_Exchange")
	self._btnUpgrade = gohelper.findChildButtonWithAudio(self.viewGO, "right_container/#btn_Upgrade")
	self._goCollectionInfo = gohelper.findChild(self.viewGO, "right_container/#go_CollectionInfo")
	self._simageCIcon = gohelper.findChildSingleImage(self.viewGO, "right_container/#go_CollectionInfo/#simage_CIcon")
	self._txtCName = gohelper.findChildText(self.viewGO, "right_container/#go_CollectionInfo/#txt_CName")
	self._txtCDesc = gohelper.findChildText(self.viewGO, "right_container/#go_CollectionInfo/scroll_desc/Viewport/go_desccontent/#txt_CDesc")
	self._goCTag1 = gohelper.findChild(self.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag1")
	self._txtCTag1 = gohelper.findChildText(self.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag1/#txt_CTag1")
	self._goCTag2 = gohelper.findChild(self.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag2")
	self._txtCTag2 = gohelper.findChildText(self.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag2/#txt_CTag2")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "right_container/#go_CollectionInfo/#btn_Add")
	self._txtAdd = gohelper.findChildText(self.viewGO, "right_container/#go_CollectionInfo/#btn_Add/#txt_Add")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CollectionChangeView:addEvents()
	self._btnQuickAdd:AddClickListener(self._btnQuickAddOnClick, self)
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
	self._btnExchange:AddClickListener(self._btnExchangeOnClick, self)
	self._btnUpgrade:AddClickListener(self._btnUpgradeOnClick, self)
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
end

function Act191CollectionChangeView:removeEvents()
	self._btnQuickAdd:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
end

function Act191CollectionChangeView:_btnAddOnClick()
	if self.showItemUid then
		self:onClickCollectionAdd()
	end
end

function Act191CollectionChangeView:_btnExchangeOnClick()
	local uidList = {}

	for i = 1, #self.selectItemUidList do
		uidList[i] = self.selectItemUidList[i]
	end

	Activity191Rpc.instance:sendSelect191ReplaceEventRequest(self.actId, uidList, self.replaceReply, self)
end

function Act191CollectionChangeView:_btnUpgradeOnClick()
	local uidList = {}

	for i = 1, #self.selectItemUidList do
		uidList[i] = self.selectItemUidList[i]
	end

	Activity191Rpc.instance:sendSelect191UpgradeEventRequest(self.actId, uidList, self.upgradeReply, self)
end

function Act191CollectionChangeView:_btnQuickAddOnClick()
	self.quickAdd = not self.quickAdd

	if self.quickAdd then
		self.showItemUid = nil
		self.showItemId = nil

		self:refreshCollectionFrame()
		self:refreshCollectionInfo()
	end

	gohelper.setActive(self._goQuickGray, not self.quickAdd)
end

function Act191CollectionChangeView:_btnNextOnClick()
	Activity191Rpc.instance:sendEnd191ReplaceEventRequest(self.actId)
	self:closeThis()
end

function Act191CollectionChangeView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._txtCDesc)

	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.actId = Activity191Model.instance:getCurActId()
	self.quickAdd = false
	self.selectItemUidList = {}
	self.selectItemIdList = {}
	self.collectionItemList = {}

	self:initAddItem()
end

function Act191CollectionChangeView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseGetView, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.ClickCollectionItem, self.onClickCollectionItem, self)

	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.nodeDetailMo = self.gameInfo:getNodeDetailMo()

	local maxCntStr

	if self.nodeDetailMo.type == Activity191Enum.NodeType.ReplaceEvent then
		self._txtTitle.text = luaLang("191collectionchangeview_title1")
		maxCntStr = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceMaxCnt].value

		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31502)

		self._txtAdd.text = luaLang("191collectiontipview_addchange")
	else
		self._txtTitle.text = luaLang("191collectionchangeview_title2")
		maxCntStr = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeMaxCnt].value

		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31501)

		self._txtAdd.text = luaLang("191collectiontipview_addupgrade")
	end

	self.maxCntParams = GameUtil.splitString2(maxCntStr, true)

	self:refreshUI()
end

function Act191CollectionChangeView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayAddItem, self)
	TaskDispatcher.cancelTask(self.delayRpcRefresh, self)
end

function Act191CollectionChangeView:initAddItem()
	self.addItemList = {}
	self.curAddItemList = {}

	for i = 1, 15 do
		local addItem = self:getUserDataTb_()
		local pos = gohelper.findChild(self._goLayout, "pos" .. i)
		local cloneGo = gohelper.clone(self._goChangeItem, pos)

		addItem.go = cloneGo
		addItem.anim = cloneGo:GetComponent(gohelper.Type_Animator)
		addItem.imageIndex = gohelper.findChildImage(cloneGo, "image_Index")
		addItem.imageRare = gohelper.findChildImage(cloneGo, "image_Rare")
		addItem.simageIcon = gohelper.findChildSingleImage(cloneGo, "simage_Icon")

		local btnClose = gohelper.findChildButtonWithAudio(cloneGo, "btn_Close")

		self.addClickCb(self, btnClose, self.onClickCloseAddItem, self, i)

		self.addItemList[i] = addItem
	end
end

function Act191CollectionChangeView:refreshUI()
	local stageCo = Activity191Config.instance:getStageCfg(self.actId, self.gameInfo.curStage)

	if stageCo then
		local stageIndex = tonumber(stageCo.name)

		self.maxAddCnt = self.maxCntParams[stageIndex][2] - self.nodeDetailMo.replaceNum
	end

	self:refreshCollectionItem()
	self:refreshLeftTimes()
	self:refreshAddItem()
	self:refreshCollectionInfo()
end

function Act191CollectionChangeView:refreshLeftTimes()
	local canClick = #self.selectItemUidList ~= 0
	local remainCnt = self.maxAddCnt - #self.selectItemUidList

	if self.nodeDetailMo.type == Activity191Enum.NodeType.ReplaceEvent then
		local txt = luaLang("191collectionchangeview_addtip1")

		self._txtRemainTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, remainCnt)

		gohelper.setActive(self._btnExchange, canClick)
		gohelper.setActive(self._btnNext, true)
	else
		local txt = luaLang("191collectionchangeview_addtip2")

		self._txtRemainTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(txt, #self.selectItemUidList, self.maxAddCnt)

		gohelper.setActive(self._btnUpgrade, canClick)
		gohelper.setActive(self._btnNext, false)
	end
end

function Act191CollectionChangeView:refreshCollectionItem()
	local itemInfoList = {}

	if self.nodeDetailMo.type == Activity191Enum.NodeType.ReplaceEvent then
		for _, itemInfo in ipairs(self.gameInfo.warehouseInfo.item) do
			local hasExit = tabletool.indexOf(self.selectItemUidList, itemInfo.uid)

			if not hasExit then
				itemInfoList[#itemInfoList + 1] = itemInfo
			end
		end
	elseif self.nodeDetailMo.type == Activity191Enum.NodeType.UpgradeEvent then
		for _, itemInfo in ipairs(self.gameInfo.warehouseInfo.item) do
			local config = Activity191Config.instance:getCollectionCo(itemInfo.itemId)

			if config.rare < Activity191Enum.MaxItemLevel then
				local hasExit = tabletool.indexOf(self.selectItemUidList, itemInfo.uid)

				if not hasExit then
					itemInfoList[#itemInfoList + 1] = itemInfo
				end
			end
		end
	end

	table.sort(itemInfoList, function(a, b)
		local aCfg = Activity191Config.instance:getCollectionCo(a.itemId)
		local bCfg = Activity191Config.instance:getCollectionCo(b.itemId)

		return aCfg.rare > bCfg.rare
	end)

	for i = 1, #itemInfoList do
		local itemInfo = itemInfoList[i]
		local collectionItem = self.collectionItemList[i]

		if not collectionItem then
			local go = self:getResInst(Activity191Enum.PrefabPath.CollectionItem, self._goContent)

			collectionItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191CollectionItem)
			self.collectionItemList[i] = collectionItem
		end

		collectionItem:setData(itemInfo)
		self.collectionItemList[i]:setActive(true)

		if self.removeItemUid and self.removeItemUid == itemInfo.uid then
			collectionItem:playAnim("open")

			self.removeItemUid = nil
		end
	end

	for k = #itemInfoList + 1, #self.collectionItemList do
		self.collectionItemList[k]:setActive(false)
	end
end

function Act191CollectionChangeView:onClickCloseAddItem(index)
	local logicIndex = index - self.startIndex + 1

	self.removeItemUid = self.selectItemUidList[logicIndex]

	table.remove(self.selectItemUidList, logicIndex)
	table.remove(self.selectItemIdList, logicIndex)
	self:refreshCollectionItem()
	self:refreshAddItem()
	self:refreshLeftTimes()
end

function Act191CollectionChangeView:refreshAddItem()
	tabletool.clear(self.curAddItemList)

	local len = #self.selectItemUidList

	gohelper.setActive(self._goEmpty, len == 0)
	gohelper.setActive(self._goHas, len ~= 0)

	self.startIndex = 1

	for i = 1, len - 1 do
		self.startIndex = self.startIndex + i
	end

	local endIndex = self.startIndex + len - 1

	for k, addItem in ipairs(self.addItemList) do
		if k >= self.startIndex and k <= endIndex then
			local logicIndex = k - self.startIndex + 1
			local itemId = self.selectItemIdList[logicIndex]
			local config = Activity191Config.instance:getCollectionCo(itemId)

			if config then
				UISpriteSetMgr.instance:setAct174Sprite(addItem.imageIndex, "act174_stage_num_0" .. logicIndex)
				UISpriteSetMgr.instance:setAct174Sprite(addItem.imageRare, "act174_propitembg_" .. config.rare)
				addItem.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))
			end

			gohelper.setActive(addItem.go, true)
			addItem.anim:Play("open", 0, 0)

			self.curAddItemList[logicIndex] = addItem
		else
			gohelper.setActive(addItem.go, false)
		end
	end
end

function Act191CollectionChangeView:onClickCollectionAdd()
	if #self.selectItemUidList >= self.maxAddCnt then
		GameFacade.showToast(ToastEnum.DouQuQu3CntNotEnough)

		return
	end

	for i = 1, #self.collectionItemList do
		local item = self.collectionItemList[i]

		if item.itemInfo.uid == self.showItemUid then
			item:playAnim("close")

			self.removeCollectionItem = item

			break
		end
	end

	table.insert(self.selectItemUidList, self.showItemUid)
	table.insert(self.selectItemIdList, self.showItemId)
	TaskDispatcher.runDelay(self.delayAddItem, self, 0.16)
end

function Act191CollectionChangeView:delayAddItem()
	self.showItemUid = nil
	self.showItemId = nil

	self:refreshCollectionFrame()

	if self.removeCollectionItem then
		self.removeCollectionItem:playAnim("idle", true)
	end

	self:refreshCollectionItem()
	self:refreshAddItem()
	self:refreshLeftTimes()
	self:refreshCollectionInfo()
end

function Act191CollectionChangeView:onClickCollectionItem(uid, id)
	if ViewMgr.instance:isOpen(ViewName.Act191CollectionGetView) then
		return
	end

	if self.quickAdd then
		if #self.selectItemUidList >= self.maxAddCnt then
			GameFacade.showToast(ToastEnum.DouQuQu3CntNotEnough)

			return
		end

		self.showItemUid = uid
		self.showItemId = id

		TaskDispatcher.runDelay(self.onClickCollectionAdd, self, 0.16)
	else
		if self.showItemUid == uid then
			self.showItemUid = nil
			self.showItemId = nil

			self:refreshCollectionInfo()
		else
			self.showItemUid = uid
			self.showItemId = id

			self:refreshCollectionInfo()
		end

		self:refreshCollectionFrame()
	end
end

function Act191CollectionChangeView:refreshCollectionFrame()
	for i = 1, #self.collectionItemList do
		local item = self.collectionItemList[i]

		item:setSelect(item.itemInfo.uid == self.showItemUid)
	end
end

function Act191CollectionChangeView:resetSelect()
	tabletool.clear(self.selectItemUidList)
	tabletool.clear(self.selectItemIdList)
end

function Act191CollectionChangeView:replaceReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_1.DouQuQu3.ui_mingdi_aperture_shrink)
	self.anim:Play("change", 0, 0)

	for _, addItem in pairs(self.curAddItemList) do
		addItem.anim:Play("change", 0, 0)
	end

	local list = tabletool.copy(self.selectItemIdList)
	local param = {
		oldIdList = list,
		newIdList = msg.resItemId
	}

	ViewMgr.instance:openView(ViewName.Act191CollectionGetView, param)
	TaskDispatcher.runDelay(self.delayRpcRefresh, self, 2)
end

function Act191CollectionChangeView:upgradeReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_1.DouQuQu3.ui_mingdi_aperture_shrink)
	self.anim:Play("change", 0, 0)

	for _, addItem in pairs(self.curAddItemList) do
		addItem.anim:Play("change", 0, 0)
	end

	local list = tabletool.copy(self.selectItemIdList)
	local param = {
		oldIdList = list,
		newIdList = msg.resItemId
	}

	ViewMgr.instance:openView(ViewName.Act191CollectionGetView, param)
	TaskDispatcher.runDelay(self.delayRpcRefresh, self, 2)
end

function Act191CollectionChangeView:delayRpcRefresh()
	self:resetSelect()

	self.nodeDetailMo = self.nodeDetailMo.type == Activity191Enum.NodeType.UpgradeEvent and self.gameInfo:getNodeDetailMo(self.gameInfo.curNode - 1) or self.gameInfo:getNodeDetailMo()

	self:refreshUI()
	gohelper.setActive(self._goEmpty, false)
end

function Act191CollectionChangeView:onCloseGetView(viewName)
	if viewName == ViewName.Act191CollectionGetView then
		if self.nodeDetailMo.type == Activity191Enum.NodeType.UpgradeEvent then
			self:closeThis()
			Activity191Controller.instance:nextStep()
		else
			self.anim:Play("open", 0, 1)

			for _, addItem in ipairs(self.addItemList) do
				addItem.anim:Play("idle", 0, 1)
			end

			gohelper.setActive(self._goEmpty, true)
		end
	end
end

function Act191CollectionChangeView:refreshCollectionInfo()
	if self.showItemId then
		local config = Activity191Config.instance:getCollectionCo(self.showItemId)

		self._simageCIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))

		local rareColor = Activity191Enum.CollectionColor[config.rare]

		self._txtCName.text = string.format("<#%s>%s</color>", rareColor, config.title)
		self._txtCDesc.text = SkillHelper.buildDesc(config.desc)

		if string.nilorempty(config.label) then
			gohelper.setActive(self._goCTag1, false)
			gohelper.setActive(self._goCTag2, false)
		else
			local labelList = string.split(config.label, "#")

			for i = 1, 2 do
				local str = labelList[i]

				self["_txtCTag" .. i].text = str

				gohelper.setActive(self["_goCTag" .. i], str)
			end
		end
	end

	gohelper.setActive(self._goCollectionInfo, self.showItemUid)
end

return Act191CollectionChangeView
