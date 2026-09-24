-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterViewContainer.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterViewContainer", package.seeall)

local MatchGameCharacterViewContainer = class("MatchGameCharacterViewContainer", BaseViewContainer)

MatchGameCharacterViewContainer.ContainerTabId = 2

function MatchGameCharacterViewContainer:buildViews()
	self._containerTabView = TabViewGroup.New(MatchGameCharacterViewContainer.ContainerTabId, "#go_Container")
	self._currencyView = MatchGameCurrencyView.New("#go_Currency", MatchGameEnum.ConstId.Currency)

	return {
		self._containerTabView,
		self._currencyView,
		MatchGameCharacterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function MatchGameCharacterViewContainer:onContainerInit()
	self.addEventCb(self, self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)

	if self.viewParam then
		local defaultTabIds = self.viewParam.defaultTabIds
		local contentTabId = defaultTabIds and defaultTabIds[MatchGameCharacterViewContainer.ContainerTabId]

		self:refreshCurrency(contentTabId)
	end
end

function MatchGameCharacterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == MatchGameCharacterViewContainer.ContainerTabId then
		return {
			MatchGameDevelopView.New(),
			MatchGameTalentView.New()
		}
	end
end

function MatchGameCharacterViewContainer:getCurTabId()
	return self._containerTabView:getCurTabId()
end

function MatchGameCharacterViewContainer:updateCurrency()
	self._currencyView:updateInfo()
end

function MatchGameCharacterViewContainer:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId ~= MatchGameCharacterViewContainer.ContainerTabId then
		return
	end

	self:refreshCurrency(tabId)
end

function MatchGameCharacterViewContainer:refreshCurrency(tabId)
	self._currencyView:updateInfo((tabId == MatchGameEnum.CharacterTabType.Talent or nil) and MatchGameEnum.ConstId.TalentCurrency)
end

return MatchGameCharacterViewContainer
