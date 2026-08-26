-- chunkname: @modules/logic/room/view/RoomBlockPackageView.lua

module("modules.logic.room.view.RoomBlockPackageView", package.seeall)

local RoomBlockPackageView = class("RoomBlockPackageView", BaseView)

function RoomBlockPackageView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._godetailedItem = gohelper.findChild(self.viewGO, "middle/cloneItem/#go_detailedItem")
	self._gosimpleItem = gohelper.findChild(self.viewGO, "middle/cloneItem/#go_simpleItem")
	self._scrolldetailed = gohelper.findChildScrollRect(self.viewGO, "middle/#scroll_detailed")
	self._scrollsimple = gohelper.findChildScrollRect(self.viewGO, "middle/#scroll_simple")
	self._btnnumber = gohelper.findChildButtonWithAudio(self.viewGO, "top/left/#btn_number")
	self._btnrare = gohelper.findChildButtonWithAudio(self.viewGO, "top/left/#btn_rare")
	self._btntheme = gohelper.findChildButtonWithAudio(self.viewGO, "top/left/#btn_theme")
	self._btndetailed = gohelper.findChildButtonWithAudio(self.viewGO, "top/#btn_detailed")
	self._btnsimple = gohelper.findChildButtonWithAudio(self.viewGO, "top/#btn_simple")
	self._gonavigatebuttonscontainer = gohelper.findChild(self.viewGO, "#go_navigatebuttonscontainer")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBlockPackageView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnumber:AddClickListener(self._btnnumberOnClick, self)
	self._btnrare:AddClickListener(self._btnrareOnClick, self)
	self._btndetailed:AddClickListener(self._btndetailedOnClick, self)
	self._btnsimple:AddClickListener(self._btnsimpleOnClick, self)
	self._btntheme:AddClickListener(self._btnthemeOnClick, self)
end

function RoomBlockPackageView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnnumber:RemoveClickListener()
	self._btnrare:RemoveClickListener()
	self._btndetailed:RemoveClickListener()
	self._btnsimple:RemoveClickListener()
	self._btntheme:RemoveClickListener()
end

function RoomBlockPackageView:_btnthemeOnClick()
	RoomController.instance:openThemeFilterView(false)
end

function RoomBlockPackageView:_btncloseOnClick()
	self:closeThis()
end

function RoomBlockPackageView:_btnrareOnClick()
	self:_setSortRate(true)
end

function RoomBlockPackageView:_btnnumberOnClick()
	self:_setSortRate(false)
end

function RoomBlockPackageView:_btndetailedOnClick()
	if self._isDetailed ~= true then
		self:_toFirsePage(true)
	end
end

function RoomBlockPackageView:_btnsimpleOnClick()
	if self._isDetailed ~= false then
		self:_toFirsePage(false)
	end
end

function RoomBlockPackageView:_editableInitView()
	self._selectPackageId = nil
	self._isDetailed = true

	local stateGos = {
		self._btnrare.gameObject,
		self._btnnumber.gameObject
	}

	self._stateInfoGos = {}

	for i = 1, #stateGos do
		local tempGo = stateGos[i]
		local t = {}

		t.normalGO = gohelper.findChild(tempGo, "go_normal")
		t.selectGO = gohelper.findChild(tempGo, "go_select")
		t.arrowGO = gohelper.findChild(tempGo, "go_select/txt/go_arrow")

		table.insert(self._stateInfoGos, t)
	end

	self._gothemeSelect = gohelper.findChild(self.viewGO, "top/left/#btn_theme/go_select")
	self._gothemeUnSelect = gohelper.findChild(self.viewGO, "top/left/#btn_theme/go_unselect")

	gohelper.setActive(self._gosimpleItem, false)
	gohelper.setActive(self._godetailedItem, false)
	gohelper.setActive(self._gopageItem, false)
	self:_setDetailed(true)
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.UI_Team_close)
end

function RoomBlockPackageView:_setSortRate(isSortRate)
	self._isSortOrder = self._isSortOrder ~= nil and self._isSortRate == isSortRate and self._isSortOrder == false or false
	self._isSortRate = isSortRate

	local selectIndex = self._isSortRate and 1 or 2

	for i = 1, #self._stateInfoGos do
		local isSelect = i == selectIndex
		local item = self._stateInfoGos[i]

		gohelper.setActive(item.selectGO, isSelect == true)
		gohelper.setActive(item.normalGO, isSelect == false)

		if isSelect then
			transformhelper.setLocalScale(item.arrowGO.transform, 1, self._isSortOrder and -1 or 1, 1)
		end
	end

	self:_sortPackageIds()
	self:_toFirsePage()
end

function RoomBlockPackageView:_setDetailed(isDetailed)
	self._isDetailed = not not isDetailed

	gohelper.setActive(self._scrollsimple.gameObject, self._isDetailed == false)
	gohelper.setActive(self._btndetailed.gameObject, self._isDetailed == false)
	gohelper.setActive(self._scrolldetailed.gameObject, self._isDetailed == true)
	gohelper.setActive(self._btnsimple.gameObject, self._isDetailed == true)
end

function RoomBlockPackageView:_toFirsePage(isDetailed)
	if isDetailed ~= nil then
		self:_setDetailed(isDetailed)
	end

	if self._isDetailed then
		self._scrolldetailed.horizontalNormalizedPosition = 0
	else
		self._scrollsimple.verticalNormalizedPosition = 1
	end
end

function RoomBlockPackageView:_sortPackageIds()
	RoomShowBlockPackageListModel.instance:setSortParam(self._isSortRate, self._isSortOrder)
end

function RoomBlockPackageView:_refreshItemListUI()
	return
end

function RoomBlockPackageView:_onSelectBlockPackage(packageId)
	self._selectPackageId = packageId

	RoomShowBlockPackageListModel.instance:setSelect(self._selectPackageId)

	if self._selectPackageId and self._selectPackageId ~= self:_getCurUsePacageId() then
		RoomInventoryBlockModel.instance:setSelectBlockPackageIds({
			self._selectPackageId
		})
		RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmSelectBlockPackage)
	end
end

function RoomBlockPackageView:_onThemeFilterChanged()
	RoomShowBlockPackageListModel.instance:setShowBlockList()
	RoomShowBlockPackageListModel.instance:setSelect(self._selectPackageId)
	self:_refreshFilterState()
end

function RoomBlockPackageView:_refreshFilterState()
	local isOpen = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if self._isLastThemeOpen ~= isOpen then
		self._isLastThemeOpen = isOpen

		gohelper.setActive(self._gothemeUnSelect, not isOpen)
		gohelper.setActive(self._gothemeSelect, isOpen)
	end
end

function RoomBlockPackageView:onUpdateParam()
	return
end

function RoomBlockPackageView:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.SelectBlockPackage, self._onSelectBlockPackage, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, self._onThemeFilterChanged, self)

	self._selectPackageId = self:_getCurUsePacageId()

	RoomShowBlockPackageListModel.instance:initShow(self._selectPackageId)
	RoomShowBlockPackageListModel.instance:setSelect(self._selectPackageId)
	self:_setSortRate(true)
	self:_refreshFilterState()
end

function RoomBlockPackageView:onClickModalMask()
	self:closeThis()
end

function RoomBlockPackageView:_getCurUsePacageId()
	local packageMO = RoomInventoryBlockModel.instance:getCurPackageMO()

	return (packageMO or nil) and (packageMO.id or nil)
end

return RoomBlockPackageView
