-- chunkname: @modules/logic/equip/view/EquipInfoTeamShowViewContainer.lua

module("modules.logic.equip.view.EquipInfoTeamShowViewContainer", package.seeall)

local EquipInfoTeamShowViewContainer = class("EquipInfoTeamShowViewContainer", BaseViewContainer)

function EquipInfoTeamShowViewContainer:buildViews()
	local equipScrollParam = ListScrollParam.New()

	equipScrollParam.scrollGOPath = "#go_equipcontainer/#scroll_equip"
	equipScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	equipScrollParam.scrollDir = ScrollEnum.ScrollDirV
	equipScrollParam.lineCount = 3
	equipScrollParam.cellWidth = 170
	equipScrollParam.cellHeight = 157.5
	equipScrollParam.cellSpaceH = 22
	equipScrollParam.cellSpaceV = 31
	equipScrollParam.startSpace = 13
	equipScrollParam.minUpdateCountInFrame = 15

	if self.viewParam.heroMo then
		local isTrial = self.viewParam.heroMo:isTrial()

		if self.viewParam.heroMo then
			local isOtherPlayerHero = self.viewParam.heroMo:isOtherPlayerHero()

			if self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView or self.viewParam.heroMo or isOtherPlayerHero then
				self.listModel = EquipInfoTeamListModel.instance
				equipScrollParam.cellClass = EquipInfoTeamItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
				self.listModel = CharacterEquipSettingListModel.instance
				equipScrollParam.cellClass = CharacterEquipSettingItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView or self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView or self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView or self.viewParam.fromView == EquipEnum.FromViewEnum.V3a9_BossRush_HeroGroupListView then
				self.listModel = EquipInfoTeamListModel.instance
				equipScrollParam.cellClass = EquipInfoTeamItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
				self.listModel = EquipInfoTeamListModel.instance
				equipScrollParam.cellClass = EquipInfoTeamItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromPresetPreviewView then
				self.listModel = EquipInfoTeamListModel.instance
				equipScrollParam.cellClass = EquipInfoTeamItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
				self.listModel = V1a6_CachotEquipInfoTeamListModel.instance
				equipScrollParam.cellClass = V1a6_CachotEquipInfoTeamItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView then
				self.listModel = OdysseyEquipInfoTeamListModel.instance
				equipScrollParam.cellClass = OdysseyEquipInfoTeamItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromTowerComposeHeroGroupView then
				self.listModel = EquipInfoTeamListModel.instance
				equipScrollParam.cellClass = TowerComposeEquipInfoTeamItem
			elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromTwinssychubeEquipInfoView then
				self.listModel = CharacterEquipSettingListModel.instance
				equipScrollParam.cellClass = CharacterEquipSettingItem
			else
				logError("not found from view ...")

				self.listModel = EquipInfoTeamListModel.instance
				equipScrollParam.cellClass = EquipInfoTeamItem
			end

			return {
				EquipInfoTeamShowView.New(),
				TabViewGroup.New(1, "#go_btns"),
				LuaListScrollView.New(self.listModel, equipScrollParam)
			}
		end
	end
end

function EquipInfoTeamShowViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.EquipInfo)

		return {
			self._navigateButtonView
		}
	end
end

function EquipInfoTeamShowViewContainer:getBalanceEquipLv()
	local balanceEquipLv = self.viewParam.balanceEquipLv

	if balanceEquipLv then
		return balanceEquipLv
	end

	local _, _, equipLv = HeroGroupBalanceHelper.getBalanceLv()

	return equipLv
end

function EquipInfoTeamShowViewContainer:getListModel()
	return self.listModel
end

return EquipInfoTeamShowViewContainer
