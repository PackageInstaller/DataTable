-- chunkname: @modules/logic/rouge/dlc/103/view/RougeBossCollectionDropView.lua

module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropView", package.seeall)

local RougeBossCollectionDropView = class("RougeBossCollectionDropView", BaseViewExtended)

function RougeBossCollectionDropView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "#simage_maskbg")
	self._gotitletip = gohelper.findChild(self.viewGO, "Title/txt_Tips")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._gorefresh = gohelper.findChild(self.viewGO, "#go_refresh")
	self._txtrefresh = gohelper.findChildText(self.viewGO, "#go_refresh/#txt_refresh")
	self._gorefreshactivebg = gohelper.findChild(self.viewGO, "#go_refresh/#go_activebg")
	self._gorefreshdisablebg = gohelper.findChild(self.viewGO, "#go_refresh/#go_disablebg")
	self._gorougefunctionitem2 = gohelper.findChild(self.viewGO, "#go_rougefunctionitem2")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txtselectnum = gohelper.findChildText(self.viewGO, "#go_topright/#txt_num")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._btninherit = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#go_rougemapbaseinherit/#btn_inherit")
	self._godistortrule = gohelper.findChild(self.viewGO, "Left/#go_distortrule")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeBossCollectionDropView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btninherit:AddClickListener(self._btninheritOnClick, self)
end

function RougeBossCollectionDropView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btninherit:RemoveClickListener()
end

function RougeBossCollectionDropView:_btnconfirmOnClick()
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

function RougeBossCollectionDropView:onReceiveSelect()
	self.refreshCallbackId = nil

	self:delayCloseView()
end

function RougeBossCollectionDropView:delayCloseView()
	UIBlockMgr.instance:startBlock(self.viewName)
	TaskDispatcher.cancelTask(self._closeView, self)
	TaskDispatcher.runDelay(self._closeView, self, RougeMapEnum.CollectionChangeAnimDuration)
end

function RougeBossCollectionDropView:_closeView()
	UIBlockMgr.instance:endBlock(self.viewName)
	self:closeThis()
end

function RougeBossCollectionDropView:onClickBg()
	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		return
	end

	self:closeThis()
end

function RougeBossCollectionDropView:_btninheritOnClick()
	self._isShowMonsterRule = not self._isShowMonsterRule

	self:refreshInheritBtn()
	RougeController.instance:dispatchEvent(RougeEvent.ShowMonsterRuleDesc, self._isShowMonsterRule)
end

function RougeBossCollectionDropView:_editableInitView()
	self.bgClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#simage_maskbg")

	self.bgClick:AddClickListener(self.onClickBg, self)

	self.viewPortClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "scroll_view/Viewport")

	self.viewPortClick:AddClickListener(self.onClickBg, self)
	self._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")

	self.txtTips = gohelper.findChildText(self.viewGO, "Title/txt_Tips")
	self.txtTitle = gohelper.findChildText(self.viewGO, "Title/txt_Title")
	self.goConfirmBtn = self._btnconfirm.gameObject

	gohelper.setActive(self._gocollectionitem, false)

	self.selectPosList = {}
	self.collectionItemList = {}

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectDropChange, self.onSelectDropChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)

	self.goCollection = self.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, self._gorougefunctionitem2)
	self.collectionComp = RougeCollectionComp.Get(self.goCollection)

	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.blockEsc)
	self:openSubView(RougeMapAttributeComp, nil, self._godistortrule)

	self._goselectinherit = gohelper.findChild(self.viewGO, "layout/#go_rougemapbaseinherit/#btn_inherit/circle/select")
	self._isShowMonsterRule = true
end

function RougeBossCollectionDropView:onSelectDropChange()
	self:refreshConfirmBtn()
	self:refreshTopRight()
end

function RougeBossCollectionDropView:onUpdateParam()
	self:onOpen()
end

function RougeBossCollectionDropView:initData()
	self.viewEnum = self.viewParam.viewEnum
	self.collectionList = self.viewParam.collectionList
	self.monsterRuleList = self.viewParam.monsterRuleList

	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		self.canSelectCount = self.viewParam.canSelectCount
		self.dropRandomNum = self.viewParam.dropRandomNum
	end
end

function RougeBossCollectionDropView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)
	self:initData()
	self:refreshUI()
	self.collectionComp:onOpen()
end

function RougeBossCollectionDropView:refreshUI()
	self:refreshTitle()
	self:refreshCollection()
	self:refreshConfirmBtn()
	self:refreshRefreshBtn()
	self:refreshInheritBtn()
	self:refreshTopRight()
end

function RougeBossCollectionDropView:refreshTitle()
	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		self.txtTitle.text = luaLang("rougebosscollectionselectview_txt_title")
		self.txtTips.text = string.gsub(luaLang("rougebosscollectionselectview_txt_tips"), "▩1%%s", self.canSelectCount)

		gohelper.setActive(self._gotitletip, true)
	else
		self.txtTips.text = luaLang("rougecollectionselectview_txt_get_Tips")
		self.txtTitle.text = luaLang("rougebosscollectionselectview_txt_title")

		gohelper.setActive(self._gotitletip, false)
	end
end

function RougeBossCollectionDropView:refreshCollection()
	if not self.collectionList then
		if not self.monsterRuleList then
			local monsterRuleIdList = {}

			for index, collectionId in ipairs(self.collectionList) do
				local collectionItem = self.collectionItemList[index]

				if not collectionItem then
					collectionItem = RougeBossCollectionDropItem.New()

					local go = gohelper.cloneInPlace(self._gocollectionitem)

					collectionItem:init(go, self)
					collectionItem:setParentScroll(self._scrollView.gameObject)
					table.insert(self.collectionItemList, collectionItem)
				end

				collectionItem:show()
				collectionItem:update(index, collectionId, monsterRuleIdList[index], self._isShowMonsterRule)
			end

			for i = #self.collectionList + 1, #self.collectionItemList do
				self.collectionItemList[i]:hide()
			end

			self._scrollView.horizontalNormalizedPosition = 0
		end
	end
end

function RougeBossCollectionDropView:refreshConfirmBtn()
	if self.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		gohelper.setActive(self.goConfirmBtn, false)
		gohelper.setActive(self._gotips, true)

		return
	end

	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self.goConfirmBtn, #self.selectPosList >= self.canSelectCount)
end

function RougeBossCollectionDropView:refreshRefreshBtn()
	self.canClickRefresh = false

	if self.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(self._gorefresh, false)

		return
	end

	local remainCanFreshNum = RougeMapModel.instance:getMonsterRuleRemainCanFreshNum()

	self.canClickRefresh = remainCanFreshNum and remainCanFreshNum > 0

	gohelper.setActive(self._gorefresh, true)
	gohelper.setActive(self._gorefreshactivebg, self.canClickRefresh)
	gohelper.setActive(self._gorefreshdisablebg, not self.canClickRefresh)

	self._txtrefresh.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougebosscollectionselectview_refresh"), remainCanFreshNum)
end

function RougeBossCollectionDropView:refreshInheritBtn()
	gohelper.setActive(self._goselectinherit, self._isShowMonsterRule)
end

function RougeBossCollectionDropView:refreshTopRight()
	if self.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(self._gotopright, false)

		return
	end

	gohelper.setActive(self._gotopright, true)

	self._txtselectnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge_drop_select"), #self.selectPosList, self.canSelectCount)
end

function RougeBossCollectionDropView:selectPos(pos)
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

function RougeBossCollectionDropView:isSelect(pos)
	return tabletool.indexOf(self.selectPosList, pos)
end

function RougeBossCollectionDropView:onUpdateMapInfo()
	local curInteractive = RougeMapModel.instance:getCurInteractiveJson()

	if not curInteractive then
		return
	end

	self.collectionList = curInteractive and curInteractive.dropCollectList
	self.monsterRuleList = curInteractive and curInteractive.dropCollectMonsterRuleList
	self.selectPosList = {}

	self:refreshUI()
end

function RougeBossCollectionDropView:clearSelectCallback()
	if self.selectCallbackId then
		RougeRpc.instance:removeCallbackById(self.selectCallbackId)

		self.selectCallbackId = nil
	end
end

function RougeBossCollectionDropView:clearRefreshCallback()
	if self.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(self.refreshCallbackId)

		self.refreshCallbackId = nil
	end
end

function RougeBossCollectionDropView:onClose()
	self:clearSelectCallback()
	self:clearRefreshCallback()
	self.collectionComp:onClose()

	for _, collectionItem in ipairs(self.collectionItemList) do
		collectionItem:onClose()
	end

	tabletool.clear(self.selectPosList)
end

function RougeBossCollectionDropView:onDestroyView()
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

return RougeBossCollectionDropView
