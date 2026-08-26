-- chunkname: @modules/logic/room/view/record/RoomRecordViewContainer.lua

module("modules.logic.room.view.record.RoomRecordViewContainer", package.seeall)

local RoomRecordViewContainer = class("RoomRecordViewContainer", BaseViewContainer)

function RoomRecordViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomRecordView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/view"))

	return views
end

function RoomRecordViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		local handbookScrollParam = ListScrollParam.New()

		handbookScrollParam.scrollGOPath = "left/#scroll_view"
		handbookScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		handbookScrollParam.prefabUrl = "left/#scroll_view/Viewport/Content/item"
		handbookScrollParam.cellClass = RoomCritterHandBookItem
		handbookScrollParam.scrollDir = ScrollEnum.ScrollDirV
		handbookScrollParam.cellWidth = 240
		handbookScrollParam.cellHeight = 300
		handbookScrollParam.startSpace = 10
		handbookScrollParam.cellSpaceH = 10
		handbookScrollParam.lineCount = 3

		local handbookbackScrollParam = ListScrollParam.New()

		handbookbackScrollParam.scrollGOPath = "left/#scroll_view"
		handbookbackScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		handbookbackScrollParam.prefabUrl = "bg/#scroll_view/Viewport/Content/item"
		handbookbackScrollParam.cellClass = RoomCritterHandBookBackItem
		handbookbackScrollParam.scrollDir = ScrollEnum.ScrollDirV
		handbookbackScrollParam.cellWidth = 100
		handbookbackScrollParam.cellHeight = 100
		handbookbackScrollParam.cellSpaceV = 20
		handbookbackScrollParam.cellSpaceH = 20
		handbookbackScrollParam.lineCount = 4
		self._taskView = RoomTradeTaskView.New()
		self._handbookScrollView = LuaListScrollView.New(RoomHandBookListModel.instance, handbookScrollParam)
		self._handbookbackScrollView = LuaListScrollView.New(RoomHandBookBackListModel.instance, handbookbackScrollParam)
		self._handbookView = RoomCritterHandBookView.New()
		self._logview = RoomLogView.New()
		self._handbookbackView = RoomCritterHandBookBackView.New()

		return {
			MultiView.New({
				self._taskView
			}),
			MultiView.New({
				self._logview
			}),
			MultiView.New({
				self._handbookView,
				self._handbookScrollView
			}),
			MultiView.New({
				self._handbookbackView,
				self._handbookbackScrollView
			})
		}
	end
end

function RoomRecordViewContainer:getTabView(tab)
	if tab == RoomRecordEnum.View.Task then
		return self._taskView
	elseif tab == RoomRecordEnum.View.Log then
		return self._logview
	elseif tab == RoomRecordEnum.View.HandBook then
		return self._handbookView
	end
end

function RoomRecordViewContainer:selectTabView(selectId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, selectId)
end

function RoomRecordViewContainer:getHandBookScrollView()
	return self._handbookScrollView
end

function RoomRecordViewContainer:playOpenTransition()
	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	if self.viewParam then
		self:selectTabView(self.viewParam)

		if self.viewParam == RoomRecordEnum.View.Log then
			local animName = "to2"

			animatorPlayer:Play(animName, self.afterOpenAnim, self)
		elseif self.viewParam == RoomRecordEnum.View.HandBook then
			local animName = "to3"

			animatorPlayer:Play(animName, self.afterOpenAnim, self)
		end
	end
end

function RoomRecordViewContainer:afterOpenAnim()
	return
end

return RoomRecordViewContainer
