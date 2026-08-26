-- chunkname: @modules/logic/seasonver/act166/view/Season166TeachViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166TeachViewContainer", package.seeall)

local Season166TeachViewContainer = class("Season166TeachViewContainer", BaseViewContainer)

function Season166TeachViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166TeachView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166TeachViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self.overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function Season166TeachViewContainer:overrideClose()
	local isAllTeachFinish = Season166TeachModel.instance:checkIsAllTeachFinish(self.viewParam.actId)

	if isAllTeachFinish then
		self:closeThis()
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.Season166CloseTeachTip, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, self.onYesClick, nil, nil, self)
	end
end

function Season166TeachViewContainer:onYesClick()
	self:closeThis()
end

return Season166TeachViewContainer
