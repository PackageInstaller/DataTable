-- chunkname: @modules/logic/playercard/view/PlayerCardAchievementSelectViewContainer.lua

module("modules.logic.playercard.view.PlayerCardAchievementSelectViewContainer", package.seeall)

local PlayerCardAchievementSelectViewContainer = class("PlayerCardAchievementSelectViewContainer", BaseViewContainer)

function PlayerCardAchievementSelectViewContainer:buildViews()
	self._scrollView = LuaMixScrollView.New(PlayerCardAchievementSelectListModel.instance, self:getMixContentParam())
	self._nameplatescrollView = LuaMixScrollView.New(PlayerCardAchievementSelectListModel.instance, self:getMixNamePlateContentParam())

	return {
		PlayerCardAchievementSelectView.New(),
		TabViewGroup.New(1, "#go_btns"),
		self._scrollView,
		self._nameplatescrollView
	}
end

function PlayerCardAchievementSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function PlayerCardAchievementSelectViewContainer:getMixContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/#scroll_content"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = PlayerCardAchievementSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.endSpace = 50

	return scrollParam
end

function PlayerCardAchievementSelectViewContainer:getMixNamePlateContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/#scroll_content_misihai"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[3]
	scrollParam.cellClass = PlayerCardAchievementNamePlateSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.endSpace = 50

	return scrollParam
end

function PlayerCardAchievementSelectViewContainer:overrideCloseFunc()
	PlayerCardAchievementSelectController.instance:popUpMessageBoxIfNeedSave(self.yesCallBackFunc, nil, self.closeThis, self, nil, self)
end

function PlayerCardAchievementSelectViewContainer:yesCallBackFunc()
	PlayerCardAchievementSelectController.instance:resumeToOriginSelect()
	self:closeThis()
end

return PlayerCardAchievementSelectViewContainer
