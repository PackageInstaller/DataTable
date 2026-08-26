-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130GameViewContainer.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130GameViewContainer", package.seeall)

local Activity130GameViewContainer = class("Activity130GameViewContainer", BaseViewContainer)

function Activity130GameViewContainer:buildViews()
	self._act130GameView = Activity130GameView.New()
	self._act130MapView = Activity130Map.New()

	local views = {}

	table.insert(views, self._act130GameView)
	table.insert(views, self._act130MapView)
	table.insert(views, TabViewGroup.New(1, "#go_topbtns"))

	return views
end

function Activity130GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonView
		}
	end
end

function Activity130GameViewContainer:onContainerInit()
	StatActivity130Controller.instance:statStart()
end

function Activity130GameViewContainer:_overrideCloseFunc()
	self._act130GameView._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doClose, self, 0.167)
end

function Activity130GameViewContainer:_doClose()
	self:closeThis()
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)
end

function Activity130GameViewContainer:onContainerClose()
	StatActivity130Controller.instance:statAbort()
	Role37PuzzleModel.instance:clear()
	PuzzleRecordListModel.instance:clearRecord()
end

return Activity130GameViewContainer
