-- chunkname: @modules/logic/character/view/CharacterTalentStyleViewContainer.lua

module("modules.logic.character.view.CharacterTalentStyleViewContainer", package.seeall)

local CharacterTalentStyleViewContainer = class("CharacterTalentStyleViewContainer", BaseViewContainer)

function CharacterTalentStyleViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "go_style/#scroll_style"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "go_style/#item_style"
	scrollParam.cellClass = CharacterTalentStyleItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 212
	scrollParam.cellHeight = 212
	scrollParam.cellSpaceV = -45

	local scrollView = LuaListScrollView.New(TalentStyleListModel.instance, scrollParam)

	self._view = CharacterTalentStyleView.New()

	return {
		scrollView,
		self._view,
		TabViewGroup.New(1, "#go_leftbtns"),
		TabViewGroup.New(2, "#go_rightbtns")
	}
end

function CharacterTalentStyleViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = CharacterTalentStyleNavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TalentStyleViewHelp)

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		local currencyParam = CurrencyEnum.CurrencyType.Gold
		local _currencyView = CurrencyView.New({
			currencyParam
		})

		_currencyView.foreHideBtn = true

		return {
			_currencyView
		}
	end
end

function CharacterTalentStyleViewContainer:overrideCloseFunc()
	if self._view then
		self._view:playCloseAnim()
	else
		self:closeThis()
	end
end

function CharacterTalentStyleViewContainer:getNavigateView()
	return self.navigateView
end

return CharacterTalentStyleViewContainer
