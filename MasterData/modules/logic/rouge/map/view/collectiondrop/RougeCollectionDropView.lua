-- chunkname: @modules/logic/rouge/map/view/collectiondrop/RougeCollectionDropView.lua

module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropView", package.seeall)

local RougeCollectionDropView = class("RougeCollectionDropView", BaseView)

function RougeCollectionDropView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "#simage_maskbg")
	self._gotitletip = gohelper.findChild(self.viewGO, "Title/txt_Tips")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_refresh")
	self._gorefreshactivebg = gohelper.findChild(self.viewGO, "layout/#btn_refresh/#go_activebg")
	self._gorefreshdisablebg = gohelper.findChild(self.viewGO, "layout/#btn_refresh/#go_disablebg")
	self._gorougefunctionitem2 = gohelper.findChild(self.viewGO, "#go_rougefunctionitem2")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txtselectnum = gohelper.findChildText(self.viewGO, "#go_topright/#txt_num")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionDropView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
end

function RougeCollectionDropView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btnrefresh:RemoveClickListener()
end

function RougeCollectionDropView:_btnconfirmOnClick()
	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		self:closeThis()

		return
	end

	if #self.selectPosList < 1 then
		return
	end

	self:clearSelectCallback()

	self.selectCallbackId = RougeRpc.instance:sendRougeSelectDropRequest(self.selectPosList, self.onReceiveSelect, self)
end

function RougeCollectionDropView:onReceiveSelect()
	self.refreshCallbackId = nil

	self:delayCloseView()
end

function RougeCollectionDropView:delayCloseView()
	UIBlockMgr.instance:startBlock(self.viewName)
	TaskDispatcher.cancelTask(self._closeView, self)
	TaskDispatcher.runDelay(self._closeView, self, RougeMapEnum.CollectionChangeAnimDuration)
end

function RougeCollectionDropView:_closeView()
	UIBlockMgr.instance:endBlock(self.viewName)
	self:closeThis()
end

function RougeCollectionDropView:_btnrefreshOnClick()
	if not self.canClickRefresh then
		GameFacade.showToast(ToastEnum.RougeNotRefreshCollection)

		return
	end

	self:clearRefreshCallback()

	self.refreshCallbackId = RougeRpc.instance:sendRougeRandomDropRequest(self.onReceiveRefresh, self)
end

function RougeCollectionDropView:onReceiveRefresh()
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)

	self.refreshCallbackId = nil

	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()

	self.collectionList = curInteractive.dropCollectList
	self.canSelectCount = curInteractive.dropSelectNum
	self.dropRandomNum = curInteractive.dropRandomNum

	self:refreshUI()
	tabletool.clear(self.selectPosList)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
end

function RougeCollectionDropView:onClickBg()
	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		return
	end

	self:closeThis()
end

function RougeCollectionDropView:_editableInitView()
	self.bgClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#simage_maskbg")

	self.bgClick:AddClickListener(self.onClickBg, self)

	self.viewPortClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "scroll_view/Viewport")

	self.viewPortClick:AddClickListener(self.onClickBg, self)
	self._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")

	self.txtTips = gohelper.findChildText(self.viewGO, "Title/txt_Tips")
	self.txtTitle = gohelper.findChildText(self.viewGO, "Title/txt_Title")
	self.goRefreshBtn = self._btnrefresh.gameObject
	self.goConfirmBtn = self._btnconfirm.gameObject

	gohelper.setActive(self._gocollectionitem, false)

	self.selectPosList = {}
	self.collectionItemList = {}

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectDropChange, self.onSelectDropChange, self)

	self.goCollection = self.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, self._gorougefunctionitem2)
	self.collectionComp = RougeCollectionComp.Get(self.goCollection)

	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.blockEsc)
end

function RougeCollectionDropView:onSelectDropChange()
	self:refreshConfirmBtn()
	self:refreshTopRight()
end

function RougeCollectionDropView:onUpdateParam()
	self:onOpen()
end

function RougeCollectionDropView:initData()
	self.viewEnum = self.viewParam.viewEnum
	self.collectionList = self.viewParam.collectionList

	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		self.canSelectCount = self.viewParam.canSelectCount
		self.dropRandomNum = self.viewParam.dropRandomNum
	end
end

function RougeCollectionDropView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)
	self:initData()
	self:refreshUI()
	self.collectionComp:onOpen()
end

function RougeCollectionDropView:refreshUI()
	self:refreshTitle()
	self:refreshCollection()
	self:refreshConfirmBtn()
	self:refreshRefreshBtn()
	self:refreshTopRight()
end

function RougeCollectionDropView:refreshTitle()
	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		self.txtTitle.text = luaLang("rougecollectionselectview_txt_Title")
		self.txtTips.text = string.gsub(luaLang("rougecollectionselectview_txt_Tips"), "▩1%%s", self.canSelectCount)

		gohelper.setActive(self._gotitletip, true)
	else
		self.txtTips.text = luaLang("rougecollectionselectview_txt_get_Tips")
		self.txtTitle.text = luaLang("rougecollectionselectview_txt_get_Title")

		gohelper.setActive(self._gotitletip, false)
	end
end

function RougeCollectionDropView:refreshCollection()
	if not self.collectionList then
		for index, collectionId in ipairs(self.collectionList) do
			local collectionItem = self.collectionItemList[index]

			if not collectionItem then
				collectionItem = RougeCollectionDropItem.New()

				local go = gohelper.cloneInPlace(self._gocollectionitem)

				collectionItem:init(go, self)
				collectionItem:setParentScroll(self._scrollView.gameObject)
				table.insert(self.collectionItemList, collectionItem)
			end

			collectionItem:show()
			collectionItem:update(index, collectionId)
		end

		for i = #self.collectionList + 1, #self.collectionItemList do
			self.collectionItemList[i]:hide()
		end

		self._scrollView.horizontalNormalizedPosition = 0
	end
end

function RougeCollectionDropView:refreshConfirmBtn()
	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		gohelper.setActive(self.goConfirmBtn, false)
		gohelper.setActive(self._gotips, true)

		return
	end

	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self.goConfirmBtn, #self.selectPosList >= self.canSelectCount)
end

function RougeCollectionDropView:refreshRefreshBtn()
	self.canClickRefresh = false

	if self.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(self.goRefreshBtn, false)

		return
	end

	local curNode = RougeMapModel.instance:getCurNode()
	local eventCo = curNode and curNode:getEventCo()
	local eventType = eventCo and eventCo.type

	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockFightDropRefresh, eventType) then
		gohelper.setActive(self.goRefreshBtn, false)

		return
	end

	local maxRefreshCount = RougeMapConfig.instance:getFightDropMaxRefreshNum(eventType)
	local remainRefreshCount = maxRefreshCount - self.dropRandomNum

	self.canClickRefresh = remainRefreshCount > 0

	gohelper.setActive(self.goRefreshBtn, true)
	gohelper.setActive(self._gorefreshactivebg, self.canClickRefresh)
	gohelper.setActive(self._gorefreshdisablebg, not self.canClickRefresh)
end

function RougeCollectionDropView:refreshTopRight()
	if self.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(self._gotopright, false)

		return
	end

	gohelper.setActive(self._gotopright, true)

	self._txtselectnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge_drop_select"), #self.selectPosList, self.canSelectCount)
end

function RougeCollectionDropView:selectPos(pos)
	if self.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		return false
	end

	local index = tabletool.indexOf(self.selectPosList, pos)

	if index then
		table.remove(self.selectPosList, index)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)

		return
	end

	if self.canSelectCount > 1 then
		if #self.selectPosList >= self.canSelectCount then
			return
		end

		table.insert(self.selectPosList, pos)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
	end

	table.remove(self.selectPosList)
	table.insert(self.selectPosList, pos)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
end

function RougeCollectionDropView:isSelect(pos)
	return tabletool.indexOf(self.selectPosList, pos)
end

function RougeCollectionDropView:clearSelectCallback()
	if self.selectCallbackId then
		RougeRpc.instance:removeCallbackById(self.selectCallbackId)

		self.selectCallbackId = nil
	end
end

function RougeCollectionDropView:clearRefreshCallback()
	if self.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(self.refreshCallbackId)

		self.refreshCallbackId = nil
	end
end

function RougeCollectionDropView:onClose()
	self:clearSelectCallback()
	self:clearRefreshCallback()
	self.collectionComp:onClose()

	for _, collectionItem in ipairs(self.collectionItemList) do
		collectionItem:onClose()
	end

	tabletool.clear(self.selectPosList)
end

function RougeCollectionDropView:onDestroyView()
	for _, collectionItem in ipairs(self.collectionItemList) do
		collectionItem:destroy()
	end

	self.collectionItemList = nil

	self._simagemaskbg:UnLoadImage()
	self.collectionComp:destroy()
	self.bgClick:RemoveClickListener()
	self.viewPortClick:RemoveClickListener()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return RougeCollectionDropView
