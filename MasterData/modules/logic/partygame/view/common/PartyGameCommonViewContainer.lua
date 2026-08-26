-- chunkname: @modules/logic/partygame/view/common/PartyGameCommonViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameCommonViewContainer", package.seeall)

local PartyGameCommonViewContainer = class("PartyGameCommonViewContainer", BaseViewContainer)

function PartyGameCommonViewContainer:buildViews()
	local views = self:getGameView()

	table.insert(views, TabViewGroup.New(1, self:getTabViewRootName()))

	return views
end

function PartyGameCommonViewContainer:getTabViewRootName()
	return "#go_lefttop"
end

function PartyGameCommonViewContainer:getGameView()
	return {}
end

function PartyGameCommonViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:getHelpId()

		self.navigateButtonView = NavigateButtonsView.New({
			self:_showBackBtn(),
			false,
			helpId > 0
		}, helpId)

		self.navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			self.navigateButtonView
		}
	end
end

function PartyGameCommonViewContainer:_showBackBtn()
	if GuideController.instance:isForbidGuides() then
		return true
	end

	local game = PartyGameController.instance:getCurPartyGame()

	return game and (not game:getIsLocal() or game:getIsTrial())
end

function PartyGameCommonViewContainer:getHelpId()
	local game = PartyGameController.instance:getCurPartyGame()
	local co = game and game:getGameConfig()

	if co then
		if not co.helpId then
			return 0
		end
	end
end

function PartyGameCommonViewContainer:closeCallback()
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.PartyGameExitGame, MsgBoxEnum.BoxType.Yes_No, function()
		PartyGameStatHelper.instance:partyGameExit()
		PartyGameTrialController.instance:clearTrialData()
		PartyGameController.instance:exitGame()
	end, nil)
end

return PartyGameCommonViewContainer
