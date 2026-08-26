-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/graffiti/VersionActivity2_0DungeonGraffitiDrawViewContainer.lua

module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiDrawViewContainer", package.seeall)

local VersionActivity2_0DungeonGraffitiDrawViewContainer = class("VersionActivity2_0DungeonGraffitiDrawViewContainer", BaseViewContainer)

function VersionActivity2_0DungeonGraffitiDrawViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_0DungeonGraffitiDrawView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity2_0DungeonGraffitiDrawViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_0DungeonGraffitiDrawViewContainer:_overrideCloseFunc()
	local mo = Activity161Model.instance.graffitiInfoMap[self.viewParam.graffitiMO.id]

	if mo.state ~= Activity161Enum.graffitiState.IsFinished and self._isBeginDraw then
		GameFacade.showMessageBox(MessageBoxIdDefine.GraffitiUnFinishConfirm, MsgBoxEnum.BoxType.Yes_No, self.closeThis, nil, nil, self)
	else
		self:closeThis()
	end
end

function VersionActivity2_0DungeonGraffitiDrawViewContainer:setIsBeginDrawState(state)
	self._isBeginDraw = state
end

return VersionActivity2_0DungeonGraffitiDrawViewContainer
