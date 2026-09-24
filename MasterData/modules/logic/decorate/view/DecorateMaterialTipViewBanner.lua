-- chunkname: @modules/logic/decorate/view/DecorateMaterialTipViewBanner.lua

module("modules.logic.decorate.view.DecorateMaterialTipViewBanner", package.seeall)

local DecorateMaterialTipViewBanner = class("DecorateMaterialTipViewBanner", BaseView)

function DecorateMaterialTipViewBanner:onInitView()
	self._gobannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._goslider = gohelper.findChild(self.viewGO, "left/banner/#go_slider")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "left/banner/#go_bannerscroll")
	self._gobannerSelectItem = gohelper.findChild(self.viewGO, "left/banner/#go_slider/go_bannerSelectItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateMaterialTipViewBanner:addEvents()
	self._bannerscroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._bannerscroll:AddDragEndListener(self._onScrollDragEnd, self)
end

function DecorateMaterialTipViewBanner:removeEvents()
	self._bannerscroll:RemoveDragBeginListener()
	self._bannerscroll:RemoveDragEndListener()
end

function DecorateMaterialTipViewBanner:_editableInitView()
	gohelper.setActive(self._gojumpItem, false)

	self._bannerscroll = SLFramework.UGUI.UIDragListener.Get(self._gobannerscroll)
	self._infoItemTbList = self:getUserDataTb_()
	self._infoItemDataList = self:getUserDataTb_()
	self._pageItemTbList = self:getUserDataTb_()

	self:_createInfoItemUserDataTb_(self._goroominfoItem)
	self:_createPageItemUserDataTb_(self._gobannerSelectItem)
	transformhelper.setLocalPosXY(self._gobannerContent.transform, -1, 0)
end

function DecorateMaterialTipViewBanner:_getMaxPage()
	return (self._infoItemDataList or nil) and (#self._infoItemDataList or 0)
end

function DecorateMaterialTipViewBanner:_checkCurPage()
	local maxPage = self:_getMaxPage()

	if not self._curPage or maxPage < self._curPage then
		self._curPage = 1
	end

	if self._curPage < 1 then
		self._curPage = maxPage
	end

	return self._curPage
end

function DecorateMaterialTipViewBanner:_isFirstPage()
	return self:_checkCurPage() <= 1
end

function DecorateMaterialTipViewBanner:_isLastPage()
	return self:_checkCurPage() >= self:_getMaxPage()
end

function DecorateMaterialTipViewBanner:_getItemDataList()
	local list = {}
	local data = {
		itemId = self.viewParam.id,
		itemType = self.viewParam.type
	}

	table.insert(list, data)

	return list
end

function DecorateMaterialTipViewBanner:_onScrollDragBegin(param, eventData)
	self._scrollStartPosX = GamepadController.instance:getMousePosition().x
end

function DecorateMaterialTipViewBanner:_onScrollDragEnd(param, eventData)
	local scrollEndPos = GamepadController.instance:getMousePosition()
	local deltaX = scrollEndPos.x - self._scrollStartPosX

	if deltaX > 80 then
		self:_runSwithPage(true)
	elseif deltaX < -80 then
		self:_runSwithPage(false)
	end
end

function DecorateMaterialTipViewBanner:_startAutoSwitch()
	TaskDispatcher.cancelTask(self._onSwitch, self)

	if self:_getMaxPage() > 1 then
		TaskDispatcher.runRepeat(self._onSwitch, self, 3)
	end
end

function DecorateMaterialTipViewBanner:_onSwitch()
	if self:_getMaxPage() <= 1 then
		TaskDispatcher.cancelTask(self._onSwitch, self)

		return
	end

	if not self._nextRunSwitchTime or self._nextRunSwitchTime <= Time.time then
		self:_runSwithPage(false)
	end
end

function DecorateMaterialTipViewBanner:_runSwithPage(isforward)
	self._nextRunSwitchTime = Time.time + 2

	local curPage = self:_checkCurPage()
	local isJomp = false

	if isforward then
		isJomp = self:_isFirstPage()
		self._curPage = curPage - 1
	else
		isJomp = self:_isLastPage()
		self._curPage = curPage + 1
	end

	if isJomp and self:_getMaxPage() > 2 then
		local jompPage = isforward and self:_getMaxPage() - 1 or 2
		local anchorX = self:_getPosXByPage(jompPage)

		recthelper.setAnchorX(self._gobannerContent.transform, -anchorX)
	end

	if curPage == self:_checkCurPage() then
		return
	end

	self:_refreshUI()
end

function DecorateMaterialTipViewBanner:_refreshUI()
	self:_refreshPageUI()
	self:_refreshInfoUI()
end

function DecorateMaterialTipViewBanner:_refreshPageUI()
	local maxPage = self:_getMaxPage()
	local curPage = self:_checkCurPage()

	gohelper.setActive(self._goslider, maxPage > 1)

	for i = 1, maxPage do
		local tb = self._pageItemTbList[i]

		if not tb then
			local cloneGo = gohelper.clone(self._gobannerSelectItem, self._goslider, "go_bannerSelectItem" .. i)

			tb = self:_createPageItemUserDataTb_(cloneGo)
		end

		self:_updatePageItemUI(tb, i == curPage)
		gohelper.setActive(tb._go, true)
	end

	for i = maxPage + 1, #self._pageItemTbList do
		local tb = self._pageItemTbList[i]

		gohelper.setActive(tb._go, false)
	end
end

function DecorateMaterialTipViewBanner:_refreshInfoUI()
	local maxPage = self:_getMaxPage()
	local curPage = self:_checkCurPage()
	local count = math.min(3, maxPage)

	for i = #self._infoItemTbList + 1, count do
		local cloneGo = gohelper.clone(self._goroominfoItem, self._gobannerContent, "go_bannerSelectItem" .. i)

		self:_createInfoItemUserDataTb_(cloneGo)
	end

	local offPage = 0

	offPage = (maxPage < #self._infoItemTbList or self:_isFirstPage()) and 0 or self:_isLastPage() and maxPage - 3 or curPage - 2

	for i = 1, #self._infoItemTbList do
		self:_refreshInfoItem(i, offPage + i)
	end

	if maxPage > 0 then
		local posX = self:_getPosXByPage(curPage)

		ZProj.TweenHelper.DOAnchorPosX(self._gobannerContent.transform, -posX, 0.75)
	end
end

function DecorateMaterialTipViewBanner:_refreshInfoItem(tbIndex, page)
	local data = self._infoItemDataList[page]
	local tb = self._infoItemTbList[tbIndex]

	if data then
		self:_updateInfoItemUI(tb, data.itemId, data.itemType)

		local posX = self:_getPosXByPage(page)

		transformhelper.setLocalPosXY(tb._go.transform, posX, 0)
	end

	if tb then
		gohelper.setActive(tb._go, data and true or false)
		self:_refreshLogo(tb, data.itemId, data.itemType)
	end
end

function DecorateMaterialTipViewBanner:_getPosXByPage(page)
	return (page - 1) * 1030
end

function DecorateMaterialTipViewBanner:_createPageItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gonomalstar = gohelper.findChild(goItem, "go_nomalstar")
	tb._golightstar = gohelper.findChild(goItem, "go_lightstar")

	table.insert(self._pageItemTbList, tb)

	return tb
end

function DecorateMaterialTipViewBanner:_updatePageItemUI(pageItemTb, isSelect)
	local tb = pageItemTb

	gohelper.setActive(tb._gonomalstar, not isSelect)
	gohelper.setActive(tb._golightstar, isSelect)
end

function DecorateMaterialTipViewBanner:_onClickCheck(goItem)
	if not goItem or not self._config then
		return
	end

	DecorateController.instance:openPreviewView(self._config)
end

function DecorateMaterialTipViewBanner:_createInfoItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gotag = gohelper.findChild(goItem, "#go_tag")
	tb._txttag = gohelper.findChildText(goItem, "#go_tag/txt_name")
	tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	tb._txtname = gohelper.findChildText(goItem, "txt_desc/txt_name")
	tb._simageinfobg = gohelper.findChildSingleImage(goItem, "#simage_pic")
	tb._gobannerContent = gohelper.findChild(goItem, "left/banner/#go_bannerContent")
	tb._goSceneLogo = gohelper.findChild(goItem, "image_frame/#go_SceneLogo")
	tb._txtSceneLogo = gohelper.findChildText(goItem, "image_frame/#go_SceneLogo/titlebg/#txt_SceneLogo")
	tb._imageSceneLogo = gohelper.findChildImage(goItem, "image_frame/#go_SceneLogo")
	tb._goheadiconbg = gohelper.findChild(goItem, "#go_headiconbg")
	tb._btn = gohelper.findChildButtonWithAudio(goItem, "txt_desc/txt_name/#btn_Info")

	tb._btn:AddClickListener(self._onClickCheck, self, tb)

	self._infoItemTbList = self._infoItemTbList or {}

	table.insert(self._infoItemTbList, tb)

	return tb
end

function DecorateMaterialTipViewBanner:_updateInfoItemUI(itemUserDataTb, itemId, itemType)
	local tb = itemUserDataTb
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	self._config = config
	tb._txtdesc.text = config.desc
	tb._txtname.text = config.name

	if tb._simageinfobg then
		local icon = DecorateModel.instance:getItemIcon(config)

		tb._simageinfobg:LoadImage(icon)
	end
end

function DecorateMaterialTipViewBanner:_refreshLogo(tb, itemId, itemType)
	if not tb then
		return
	end

	local isShowHeadBg
	local info = DecorateEnum.DecorateUIParams[self._config.subType]

	if info then
		local title = info.Title

		if not string.nilorempty(title) then
			local config = ItemModel.instance:getItemConfig(itemType, itemId)
			local decorateCo, classify = DecorateModel.instance:getItemDecorateCo(config)

			if classify and classify == MainSwitchClassifyEnum.Classify.Click then
				title = "main_switch_classify_title_3"
			end

			tb._txtSceneLogo.text = luaLang(title)
		end

		gohelper.setActive(tb._goSceneLogo, not string.nilorempty(title))

		if not string.nilorempty(info.Tag) then
			tb._txttag.text = luaLang(info.Tag)
		end

		gohelper.setActive(tb._gotag, not string.nilorempty(info.Tag))

		isShowHeadBg = info.IsShowHeadBg
	end

	gohelper.setActive(tb._goheadiconbg, isShowHeadBg)
end

function DecorateMaterialTipViewBanner:onUpdateParam()
	self._infoItemDataList = {}

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
end

function DecorateMaterialTipViewBanner:onOpen()
	self._infoItemDataList = {}

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
end

function DecorateMaterialTipViewBanner:onClose()
	return
end

function DecorateMaterialTipViewBanner:onDestroyView()
	TaskDispatcher.cancelTask(self._onSwitch, self)

	for i, v in ipairs(self._infoItemTbList) do
		v._simageinfobg:UnLoadImage()
		v._btn:RemoveClickListener()
	end
end

return DecorateMaterialTipViewBanner
