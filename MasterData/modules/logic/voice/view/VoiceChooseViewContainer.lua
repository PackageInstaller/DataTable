-- chunkname: @modules/logic/voice/view/VoiceChooseViewContainer.lua

module("modules.logic.voice.view.VoiceChooseViewContainer", package.seeall)

local VoiceChooseViewContainer = class("VoiceChooseViewContainer", BaseViewContainer)

function VoiceChooseViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "view/#scroll_content"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VoiceChooseItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1400
	scrollParam.cellHeight = 124
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 0

	local views = {}

	table.insert(views, LuaListScrollView.New(VoiceChooseModel.instance, scrollParam))
	table.insert(views, VoiceChooseView.New())

	return views
end

return VoiceChooseViewContainer
