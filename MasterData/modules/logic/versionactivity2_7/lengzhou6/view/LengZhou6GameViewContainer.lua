-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6GameViewContainer.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameViewContainer", package.seeall)

local LengZhou6GameViewContainer = class("LengZhou6GameViewContainer", BaseViewContainer)

function LengZhou6GameViewContainer:buildViews()
	return {
		LengZhou6GameView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LengZhou6EliminateView.New()
	}
end

function LengZhou6GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:_getHelpId()

		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			helpId ~= nil
		}, helpId)

		self.navigationView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigationView
		}
	end
end

function LengZhou6GameViewContainer:_overrideClose()
	local episodeId = LengZhou6Model.instance:getCurEpisodeId()
	local info = LengZhou6Model.instance:getEpisodeInfoMo(episodeId)

	if info then
		if info:isEndlessEpisode() then
			if not LengZhou6Enum.GameResult.infiniteCancel then
				local result = LengZhou6Enum.GameResult.normalCancel

				LengZhou6StatHelper.instance:setGameResult(result)
			end
		end
	end

	LengZhou6GameController.instance:levelGame(true)
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.OnClickCloseGameView)
	LengZhou6StatHelper.instance:sendGameExit()
end

function LengZhou6GameViewContainer:refreshHelpId()
	local helpId = self:_getHelpId()

	if helpId ~= nil and self.navigationView ~= nil then
		self.navigationView:setHelpId(helpId)
	end
end

function LengZhou6GameViewContainer:_getHelpId()
	return 2500200
end

function LengZhou6GameViewContainer:onContainerInit()
	self.addEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.refreshHelpId, self)
end

return LengZhou6GameViewContainer
