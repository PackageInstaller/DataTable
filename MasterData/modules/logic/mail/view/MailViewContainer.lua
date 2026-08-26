-- chunkname: @modules/logic/mail/view/MailViewContainer.lua

module("modules.logic.mail.view.MailViewContainer", package.seeall)

local MailViewContainer = class("MailViewContainer", BaseViewContainer)

function MailViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "mailtipview/#go_left/#scroll_mail"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = MailCategoryListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 523.3303
	scrollParam.cellHeight = 113.2241
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 2.48
	scrollParam.startSpace = 8

	local AnimationDelayTimes = {}

	for i = 1, 6 do
		AnimationDelayTimes[i] = 0
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(MailCategroyModel.instance, scrollParam, AnimationDelayTimes))
	table.insert(views, MailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function MailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

function MailViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mail_close)
end

return MailViewContainer
