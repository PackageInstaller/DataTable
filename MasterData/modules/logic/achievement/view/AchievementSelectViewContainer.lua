-- chunkname: @modules/logic/achievement/view/AchievementSelectViewContainer.lua

module("modules.logic.achievement.view.AchievementSelectViewContainer", package.seeall)

local AchievementSelectViewContainer = class("AchievementSelectViewContainer", BaseViewContainer)

function AchievementSelectViewContainer:buildViews()
	self._scrollView = LuaMixScrollView.New(AchievementSelectListModel.instance, self:getMixContentParam())
	self._nameplatescrollView = LuaMixScrollView.New(AchievementSelectListModel.instance, self:getMixNamePlateContentParam())

	return {
		AchievementSelectView.New(),
		TabViewGroup.New(1, "#go_btns"),
		self._scrollView,
		self._nameplatescrollView
	}
end

function AchievementSelectViewContainer:buildTabViews(tabContainerId)
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

function AchievementSelectViewContainer:getMixContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/#scroll_content"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = AchievementSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.endSpace = 50

	return scrollParam
end

function AchievementSelectViewContainer:getMixNamePlateContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/#scroll_content_misihai"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[3]
	scrollParam.cellClass = AchievementNamePlateSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.endSpace = 50

	return scrollParam
end

function AchievementSelectViewContainer:overrideCloseFunc()
	AchievementSelectController.instance:popUpMessageBoxIfNeedSave(self.yesCallBackFunc, nil, self.closeThis, self, nil, self)
end

function AchievementSelectViewContainer:yesCallBackFunc()
	AchievementSelectController.instance:resumeToOriginSelect()
	self:closeThis()
end

return AchievementSelectViewContainer
