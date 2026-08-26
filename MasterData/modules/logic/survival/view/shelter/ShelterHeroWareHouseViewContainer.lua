-- chunkname: @modules/logic/survival/view/shelter/ShelterHeroWareHouseViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterHeroWareHouseViewContainer", package.seeall)

local ShelterHeroWareHouseViewContainer = class("ShelterHeroWareHouseViewContainer", BaseViewContainer)

function ShelterHeroWareHouseViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam.cellClass = ShelterHeroWareHouseItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 260
	scrollParam.cellHeight = 600
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 20
	scrollParam.frameUpdateMs = 100

	local cardAnimationDelayTimes = {}

	for i = 1, 12 do
		cardAnimationDelayTimes[i] = math.ceil((i - 1) % 6) * 0.06
	end

	self._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, scrollParam, cardAnimationDelayTimes)

	table.insert(views, self._cardScrollView)
	table.insert(views, ShelterHeroWareHouseView.New())
	table.insert(views, CommonRainEffectView.New("bg/#go_glowcontainer"))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function ShelterHeroWareHouseViewContainer:playCardOpenAnimation()
	if self._cardScrollView then
		self._cardScrollView:playOpenAnimation()
	end
end

function ShelterHeroWareHouseViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

function ShelterHeroWareHouseViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesclose)
	self._navigateButtonView:resetHomeBtnAudioId(AudioEnum.UI.UI_Rolesclose)
end

function ShelterHeroWareHouseViewContainer:onContainerOpen()
	self.notPlayAnimation = true
end

function ShelterHeroWareHouseViewContainer:onContainerClose()
	self.notPlayAnimation = false
end

function ShelterHeroWareHouseViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return ShelterHeroWareHouseViewContainer
