-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEquipInfoTeamShowViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEquipInfoTeamShowViewContainer", package.seeall)

local V1a6_CachotEquipInfoTeamShowViewContainer = class("V1a6_CachotEquipInfoTeamShowViewContainer", BaseViewContainer)

function V1a6_CachotEquipInfoTeamShowViewContainer:buildViews()
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

		if self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView or self.viewParam.heroMo then
			self.listModel = EquipInfoTeamListModel.instance
			equipScrollParam.cellClass = EquipInfoTeamItem
		elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
			self.listModel = CharacterEquipSettingListModel.instance
			equipScrollParam.cellClass = CharacterEquipSettingItem
		elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
			self.listModel = EquipInfoTeamListModel.instance
			equipScrollParam.cellClass = EquipInfoTeamItem
		elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
			self.listModel = V1a6_CachotEquipInfoTeamListModel.instance
			equipScrollParam.cellClass = V1a6_CachotEquipInfoTeamItem
		elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
			self.listModel = V1a6_CachotEquipInfoTeamListModel.instance
			equipScrollParam.cellClass = V1a6_CachotEquipInfoTeamItem
		else
			logError("not found from view ...")

			self.listModel = EquipInfoTeamListModel.instance
			equipScrollParam.cellClass = EquipInfoTeamItem
		end

		return {
			V1a6_CachotEquipInfoTeamShowView.New(),
			TabViewGroup.New(1, "#go_btns"),
			LuaListScrollView.New(self.listModel, equipScrollParam)
		}
	end
end

function V1a6_CachotEquipInfoTeamShowViewContainer:buildTabViews(tabContainerId)
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

function V1a6_CachotEquipInfoTeamShowViewContainer:getListModel()
	return self.listModel
end

return V1a6_CachotEquipInfoTeamShowViewContainer
