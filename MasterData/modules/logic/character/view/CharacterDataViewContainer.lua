-- chunkname: @modules/logic/character/view/CharacterDataViewContainer.lua

module("modules.logic.character.view.CharacterDataViewContainer", package.seeall)

local CharacterDataViewContainer = class("CharacterDataViewContainer", BaseViewContainer)

function CharacterDataViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterDataView.New())
	table.insert(views, TabViewGroup.New(1, "topleft"))
	table.insert(views, TabViewGroup.New(2, "content"))

	return views
end

function CharacterDataViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	elseif tabContainerId == 2 then
		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "content/#scroll_vioce"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		scrollParam.prefabUrl = self._viewSetting.otherRes[1]
		scrollParam.cellClass = CharacterVoiceItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 1
		scrollParam.cellWidth = 693.3164
		scrollParam.cellHeight = 90
		scrollParam.cellSpaceH = 0
		scrollParam.cellSpaceV = 2
		scrollParam.startSpace = 0
		scrollParam.endSpace = 0

		return {
			CharacterDataTitleView.New(),
			MultiView.New({
				CharacterDataVoiceView.New(),
				LuaListScrollView.New(CharacterVoiceModel.instance, scrollParam)
			}),
			CharacterDataItemView.New(),
			CharacterDataCultureView.New()
		}
	end
end

function CharacterDataViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

function CharacterDataViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_role_introduce_close)
end

return CharacterDataViewContainer
