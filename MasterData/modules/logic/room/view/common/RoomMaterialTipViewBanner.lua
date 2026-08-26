-- chunkname: @modules/logic/room/view/common/RoomMaterialTipViewBanner.lua

module("modules.logic.room.view.common.RoomMaterialTipViewBanner", package.seeall)

local RoomMaterialTipViewBanner = class("RoomMaterialTipViewBanner", BaseView)

function RoomMaterialTipViewBanner:onInitView()
	self._gobannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._goslider = gohelper.findChild(self.viewGO, "left/banner/#go_slider")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "left/banner/#go_bannerscroll")
	self._gobannerSelectItem = gohelper.findChild(self.viewGO, "left/banner/#go_slider/go_bannerSelectItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomMaterialTipViewBanner:addEvents()
	self._bannerscroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._bannerscroll:AddDragEndListener(self._onScrollDragEnd, self)
end

function RoomMaterialTipViewBanner:removeEvents()
	self._bannerscroll:RemoveDragBeginListener()
	self._bannerscroll:RemoveDragEndListener()
end

function RoomMaterialTipViewBanner:_editableInitView()
	gohelper.setActive(self._gojumpItem, false)

	self._bannerscroll = SLFramework.UGUI.UIDragListener.Get(self._gobannerscroll)
	self._infoItemTbList = {}
	self._infoItemDataList = {}
	self._pageItemTbList = {}

	self:_createInfoItemUserDataTb_(self._goroominfoItem)
	self:_createPageItemUserDataTb_(self._gobannerSelectItem)
	transformhelper.setLocalPosXY(self._gobannerContent.transform, -1, 0)
end

function RoomMaterialTipViewBanner:_getMaxPage()
	return (self._infoItemDataList or nil) and (#self._infoItemDataList or 0)
end

function RoomMaterialTipViewBanner:_checkCurPage()
	local maxPage = self:_getMaxPage()

	if not self._curPage or maxPage < self._curPage then
		self._curPage = 1
	end

	if self._curPage < 1 then
		self._curPage = maxPage
	end

	return self._curPage
end

function RoomMaterialTipViewBanner:_isFirstPage()
	return self:_checkCurPage() <= 1
end

function RoomMaterialTipViewBanner:_isLastPage()
	return self:_checkCurPage() >= self:_getMaxPage()
end

function RoomMaterialTipViewBanner:_getItemDataList()
	local list = {}
	local data = {
		itemId = self.viewParam.id,
		itemType = self.viewParam.type,
		roomBuildingLevel = self.viewParam.roomBuildingLevel,
		roomSkinId = self.viewParam.roomSkinId
	}

	table.insert(list, data)

	return list
end

function RoomMaterialTipViewBanner:_onScrollDragBegin(param, eventData)
	self._scrollStartPosX = GamepadController.instance:getMousePosition().x
end

function RoomMaterialTipViewBanner:_onScrollDragEnd(param, eventData)
	local scrollEndPos = GamepadController.instance:getMousePosition()
	local deltaX = scrollEndPos.x - self._scrollStartPosX

	if deltaX > 80 then
		self:_runSwithPage(true)
	elseif deltaX < -80 then
		self:_runSwithPage(false)
	end
end

function RoomMaterialTipViewBanner:_startAutoSwitch()
	TaskDispatcher.cancelTask(self._onSwitch, self)

	if self:_getMaxPage() > 1 then
		TaskDispatcher.runRepeat(self._onSwitch, self, 3)
	end
end

function RoomMaterialTipViewBanner:_onSwitch()
	if self:_getMaxPage() <= 1 then
		TaskDispatcher.cancelTask(self._onSwitch, self)

		return
	end

	if not self._nextRunSwitchTime or self._nextRunSwitchTime <= Time.time then
		self:_runSwithPage(false)
	end
end

function RoomMaterialTipViewBanner:_runSwithPage(isforward)
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

function RoomMaterialTipViewBanner:_refreshUI()
	self:_refreshPageUI()
	self:_refreshInfoUI()
end

function RoomMaterialTipViewBanner:_refreshPageUI()
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

function RoomMaterialTipViewBanner:_refreshInfoUI()
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

function RoomMaterialTipViewBanner:_refreshInfoItem(tbIndex, page)
	local data = self._infoItemDataList[page]
	local tb = self._infoItemTbList[tbIndex]

	if data then
		if data.roomSkinId then
			self:_updateInfoRoomSkinUI(tb, data.roomSkinId)
		else
			self:_updateInfoItemUI(tb, data.itemId, data.itemType, data.roomBuildingLevel)
		end

		local posX = self:_getPosXByPage(page)

		transformhelper.setLocalPosXY(tb._go.transform, posX, 0)
	end

	if tb then
		gohelper.setActive(tb._go, data and true or false)
	end
end

function RoomMaterialTipViewBanner:_getPosXByPage(page)
	return (page - 1) * 1030
end

function RoomMaterialTipViewBanner:_createPageItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gonomalstar = gohelper.findChild(goItem, "go_nomalstar")
	tb._golightstar = gohelper.findChild(goItem, "go_lightstar")

	table.insert(self._pageItemTbList, tb)

	return tb
end

function RoomMaterialTipViewBanner:_updatePageItemUI(pageItemTb, isSelect)
	local tb = pageItemTb

	gohelper.setActive(tb._gonomalstar, not isSelect)
	gohelper.setActive(tb._golightstar, isSelect)
end

function RoomMaterialTipViewBanner:_createInfoItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._simagetheme = gohelper.findChildSingleImage(goItem, "iconmask/simage_theme")
	tb._gotag = gohelper.findChild(goItem, "#go_tag")
	tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	tb._txtname = gohelper.findChildText(goItem, "txt_desc/txt_name")
	tb._goitemContent = gohelper.findChild(goItem, "go_itemContent")
	tb._goitemEnergy = gohelper.findChild(goItem, "go_itemContent/bg/go_itemEnergy")
	tb._goitemBlock = gohelper.findChild(goItem, "go_itemContent/bg/go_itemBlock")
	tb._txtenergynum = gohelper.findChildText(goItem, "go_itemContent/bg/go_itemEnergy/txt_energynum")
	tb._txtblocknum = gohelper.findChildText(goItem, "go_itemContent/bg/go_itemBlock/txt_blocknum")
	tb._simageinfobg = gohelper.findChildSingleImage(goItem, "simage_infobg")
	self._infoItemTbList = self._infoItemTbList or {}

	table.insert(self._infoItemTbList, tb)

	return tb
end

function RoomMaterialTipViewBanner:_updateInfoItemUI(itemUserDataTb, itemId, itemType, roomBuildingLevel)
	local tb = itemUserDataTb
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	tb._txtdesc.text = config.desc
	tb._txtname.text = config.name

	local showItemBlock = itemType == MaterialEnum.MaterialType.BlockPackage
	local showItemEnergy = itemType == MaterialEnum.MaterialType.BlockPackage or itemType == MaterialEnum.MaterialType.Building

	if showItemEnergy and itemType == MaterialEnum.MaterialType.Building and config.buildDegree <= 0 then
		showItemEnergy = false
	end

	gohelper.setActive(tb._goitemContent, showItemBlock or showItemEnergy)
	gohelper.setActive(tb._goitemBlock, showItemBlock)
	gohelper.setActive(tb._goitemEnergy, showItemEnergy)
	gohelper.setActive(tb._gotag, false)
	tb._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))

	if itemType == MaterialEnum.MaterialType.Building then
		tb._txtenergynum.text = config.buildDegree

		local rewardIcon

		if roomBuildingLevel and roomBuildingLevel >= 0 then
			local levelConfig = RoomConfig.instance:getLevelGroupConfig(itemId, roomBuildingLevel)

			rewardIcon = levelConfig and levelConfig.rewardIcon
		end

		if string.nilorempty(rewardIcon) then
			rewardIcon = config.rewardIcon
		end

		tb._simagetheme:LoadImage(ResUrl.getRoomBuildingRewardIcon(rewardIcon))
	elseif itemType == MaterialEnum.MaterialType.BlockPackage then
		tb._simagetheme:LoadImage(ResUrl.getRoomBlockPackageRewardIcon(config.rewardIcon))

		local blockNum = 0
		local blockList = RoomConfig.instance:getBlockListByPackageId(itemId) or {}

		for i = 1, #blockList do
			local blockCfg = blockList[i]

			if blockCfg.ownType ~= RoomBlockEnum.OwnType.Special or RoomModel.instance:isHasBlockById(blockCfg.blockId) then
				blockNum = blockNum + 1
			end
		end

		if blockNum < 1 and #blockList >= 1 then
			blockNum = 1
		end

		tb._txtenergynum.text = config.blockBuildDegree * blockNum
		tb._txtblocknum.text = blockNum
	elseif itemType == MaterialEnum.MaterialType.RoomTheme then
		tb._simagetheme:LoadImage(ResUrl.getRoomThemeRewardIcon(config.rewardIcon))
	elseif itemType == MaterialEnum.MaterialType.SpecialBlock then
		local packageCfg = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.BlockPackage, RoomBlockPackageEnum.ID.RoleBirthday)

		if packageCfg then
			tb._simagetheme:LoadImage(ResUrl.getRoomBlockPackageRewardIcon(packageCfg.rewardIcon))
		end
	end
end

function RoomMaterialTipViewBanner:_updateInfoRoomSkinUI(itemUserDataTb, skinId)
	local tb = itemUserDataTb

	gohelper.setActive(tb._gotag, true)
	gohelper.setActive(tb._goitemContent, false)
	tb._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))

	tb._txtname.text = RoomConfig.instance:getRoomSkinName(skinId)
	tb._txtdesc.text = RoomConfig.instance:getRoomSkinDesc(skinId)

	local bannerIcon = RoomConfig.instance:getRoomSkinBannerIcon(skinId)
	local bannerIconPath = ResUrl.getRoomBuildingRewardIcon(bannerIcon)

	tb._simagetheme:LoadImage(bannerIconPath)
end

function RoomMaterialTipViewBanner:onUpdateParam()
	self._infoItemDataList = {}

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
end

function RoomMaterialTipViewBanner:onOpen()
	self._infoItemDataList = {}

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
end

function RoomMaterialTipViewBanner:onClose()
	return
end

function RoomMaterialTipViewBanner:onDestroyView()
	TaskDispatcher.cancelTask(self._onSwitch, self)

	for i = 1, #self._infoItemTbList do
		self._infoItemTbList[i]._simagetheme:UnLoadImage()
		self._infoItemTbList[i]._simageinfobg:UnLoadImage()
	end
end

return RoomMaterialTipViewBanner
