-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateEffectViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateEffectViewContainer", package.seeall)

local EliminateEffectViewContainer = class("EliminateEffectViewContainer", BaseViewContainer)

function EliminateEffectViewContainer:buildViews()
	local views = {}

	table.insert(views, EliminateEffectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function EliminateEffectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function EliminateEffectViewContainer:_overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.EliminateLevelClose, MsgBoxEnum.BoxType.Yes_No, self._closeLevel, nil, nil, self, nil, nil)
end

function EliminateEffectViewContainer:_closeLevel()
	EliminateLevelModel.instance:sendStatData(EliminateLevelEnum.resultStatUse.draw)
	EliminateLevelController.instance:closeLevel()
end

return EliminateEffectViewContainer
