-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_TaskViewContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_TaskViewContainer", package.seeall)

local V3a1_GaoSiNiao_TaskViewContainer = class("V3a1_GaoSiNiao_TaskViewContainer", CorvusTaskViewContainer)

function V3a1_GaoSiNiao_TaskViewContainer:onCreateMainView()
	return V3a1_GaoSiNiao_TaskView.New()
end

function V3a1_GaoSiNiao_TaskViewContainer:onCreateListScrollParam()
	local listScrollParam = ListScrollParam.New()

	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	listScrollParam.sortMode = ScrollEnum.ScrollSortDown
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 1160
	listScrollParam.cellHeight = 165
	listScrollParam.cellSpaceV = 0
	listScrollParam.startSpace = 0
	listScrollParam.scrollGOPath = "#scroll_TaskList"
	listScrollParam.cellClass = V3a1_GaoSiNiao_TaskViewItem
	listScrollParam.rectMaskSoftness = {
		0,
		0
	}

	return listScrollParam
end

return V3a1_GaoSiNiao_TaskViewContainer
