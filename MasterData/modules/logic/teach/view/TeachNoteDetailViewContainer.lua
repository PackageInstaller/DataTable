-- chunkname: @modules/logic/teach/view/TeachNoteDetailViewContainer.lua

module("modules.logic.teach.view.TeachNoteDetailViewContainer", package.seeall)

local TeachNoteDetailViewContainer = class("TeachNoteDetailViewContainer", BaseViewContainer)

function TeachNoteDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TeachNoteDetailView.New())

	return views
end

function TeachNoteDetailViewContainer:buildTabViews(tabContainerId)
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

function TeachNoteDetailViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mission_close)
end

return TeachNoteDetailViewContainer
