-- chunkname: @modules/logic/equip/view/EquipTeamViewContainer.lua

module("modules.logic.equip.view.EquipTeamViewContainer", package.seeall)

local EquipTeamViewContainer = class("EquipTeamViewContainer", BaseViewContainer)

function EquipTeamViewContainer:buildViews()
	local equipScrollParam = ListScrollParam.New()

	equipScrollParam.scrollGOPath = "#go_equipcontainer/#scroll_equip"
	equipScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	equipScrollParam.cellClass = EquipTeamItem
	equipScrollParam.scrollDir = ScrollEnum.ScrollDirV
	equipScrollParam.lineCount = 3
	equipScrollParam.cellWidth = 200
	equipScrollParam.cellHeight = 210
	equipScrollParam.cellSpaceH = 28
	equipScrollParam.cellSpaceV = 10
	equipScrollParam.startSpace = 13

	return {
		EquipTeamView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LuaListScrollView.New(EquipTeamListModel.instance, equipScrollParam)
	}
end

function EquipTeamViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self._overrideClose)

		return {
			self._navigateButtonView
		}
	end
end

function EquipTeamViewContainer:_overrideClose()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCloseEquipTeamShowView)
end

function EquipTeamViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

return EquipTeamViewContainer
