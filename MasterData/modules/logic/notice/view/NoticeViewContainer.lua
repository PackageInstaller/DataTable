-- chunkname: @modules/logic/notice/view/NoticeViewContainer.lua

module("modules.logic.notice.view.NoticeViewContainer", package.seeall)

local NoticeViewContainer = class("NoticeViewContainer", BaseViewContainer)

function NoticeViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/#scroll_notice"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "left/#scroll_notice/Viewport/Content/noticeItem"
	scrollParam.cellClass = NoticeTitleItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 420
	scrollParam.cellHeight = 120
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 8
	scrollParam.startSpace = 0
	scrollParam.endSpace = 20

	local scrollParam2 = MixScrollParam.New()

	scrollParam2.scrollGOPath = "right/#scroll_content"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "right/#scroll_content/Viewport/Content/cell/noticeContentItem"
	scrollParam2.cellClass = NoticeContentItemWrap
	scrollParam2.scrollDir = ScrollEnum.ScrollDirV
	self._titleListView = LuaListScrollView.New(NoticeModel.instance, scrollParam)
	self._contentListView = LuaMixScrollView.New(NoticeContentListModel.instance, scrollParam2)
	self._noticeView = NoticeView.New()

	table.insert(views, self._titleListView)
	table.insert(views, self._contentListView)
	table.insert(views, self._noticeView)

	local toggleView = ToggleListView.New(1, "right/#toggleGroup")

	toggleView.onOpen = NoticeViewContainer.customToggleViewOpen

	table.insert(views, toggleView)

	return views
end

function NoticeViewContainer.customToggleViewOpen(toggleView)
	local originAllowSwitchOff = toggleView._toggleGroup.allowSwitchOff

	toggleView._toggleGroup.allowSwitchOff = true

	local firstType = toggleView.viewContainer:getFirstShowNoticeType()
	local index = NoticeType.getTypeIndex(firstType)

	for toggleId, toggleWrap in pairs(toggleView._toggleDict) do
		toggleWrap.isOn = toggleId == index

		toggleWrap:AddOnValueChanged(toggleView._onToggleValueChanged, toggleView, toggleId)
	end

	toggleView._toggleGroup.allowSwitchOff = originAllowSwitchOff
end

function NoticeViewContainer:onContainerInit()
	self.registerCallback(self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function NoticeViewContainer:onContainerDestroy()
	self.unregisterCallback(self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function NoticeViewContainer:_toSwitchTab(tabContainerId, toggleId)
	if toggleId == NoticeModel.instance:getSelectType() then
		return
	end

	NoticeModel.instance:switchNoticeTypeByToggleId(toggleId)
	self:selectFirstNotice()
end

function NoticeViewContainer:selectFirstNotice()
	local noticeCount = NoticeModel.instance:getCount()

	if noticeCount > 0 then
		self._titleListView:getCsListScroll().VerticalScrollPixel = 0

		self._titleListView:selectCell(1, true)
	else
		NoticeContentListModel.instance:setNoticeMO(nil)
	end
end

function NoticeViewContainer:getFirstShowNoticeType()
	local isAuto = NoticeController.instance.autoOpen
	local autoSelectType = NoticeModel.instance.autoSelectType
	local firstType

	for _, type in ipairs(NoticeType.NoticeList) do
		local len = #NoticeModel.instance:getNoticesByType(type)

		if len > 0 then
			firstType = firstType or type

			if not isAuto then
				return type
			elseif type == autoSelectType then
				return type
			end
		end
	end

	return firstType
end

return NoticeViewContainer
