-- chunkname: @modules/logic/character/view/CharacterBackpackViewContainer.lua

module("modules.logic.character.view.CharacterBackpackViewContainer", package.seeall)

local CharacterBackpackViewContainer = class("CharacterBackpackViewContainer", BaseViewContainer)

function CharacterBackpackViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_container"),
		CharacterBackpackView.New(),
		CommonRainEffectView.New("bg/#go_glowcontainer")
	}
end

function CharacterBackpackViewContainer:playCardOpenAnimation()
	if self._cardScrollView then
		self._cardScrollView:playOpenAnimation()
	end
end

function CharacterBackpackViewContainer:playEquipOpenAnimation()
	if self._equipScrollView then
		self._equipScrollView:playOpenAnimation()
	end
end

function CharacterBackpackViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "#scroll_card"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		scrollParam.prefabUrl = self._viewSetting.otherRes[1]
		scrollParam.cellClass = CharacterBackpackCardListItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 6
		scrollParam.cellWidth = 250
		scrollParam.cellHeight = 555
		scrollParam.cellSpaceH = 18
		scrollParam.cellSpaceV = 20
		scrollParam.startSpace = 9
		scrollParam.frameUpdateMs = 100

		local cardAnimationDelayTimes = {}

		for i = 1, 12 do
			cardAnimationDelayTimes[i] = math.ceil((i - 1) % 6) * 0.06
		end

		self._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, scrollParam, cardAnimationDelayTimes)

		return {
			MultiView.New({
				self._cardScrollView,
				CharacterBackpackHeroView.New()
			})
		}
	end
end

function CharacterBackpackViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

function CharacterBackpackViewContainer:_closeCallback()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function CharacterBackpackViewContainer:onContainerOpen()
	self.notPlayAnimation = true
end

function CharacterBackpackViewContainer:onContainerClose()
	self.notPlayAnimation = false
end

function CharacterBackpackViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesclose)
	self._navigateButtonView:resetHomeBtnAudioId(AudioEnum.UI.UI_Rolesclose)
end

return CharacterBackpackViewContainer
