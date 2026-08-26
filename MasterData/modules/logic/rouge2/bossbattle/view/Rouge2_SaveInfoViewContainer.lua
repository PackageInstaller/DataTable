-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoViewContainer.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoViewContainer", package.seeall)

local Rouge2_SaveInfoViewContainer = class("Rouge2_SaveInfoViewContainer", BaseViewContainer)

function Rouge2_SaveInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_SaveInfoView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_SaveInfoList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = Rouge2_Enum.ResPath.SaveInfoListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellClass = Rouge2_SaveInfoListItem
	scrollParam.cellWidth = 1892
	scrollParam.cellHeight = 324
	scrollParam.startSpace = 50
	scrollParam.cellSpaceV = 0

	local animTime = {}

	for i = 1, 4 do
		animTime[i] = i * 0.03
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(Rouge2_SaveInfoListModel.instance, scrollParam, animTime))

	return views
end

function Rouge2_SaveInfoViewContainer:buildTabViews(tabContainerId)
	return
end

function Rouge2_SaveInfoViewContainer:_onBtnCloseCallback()
	local viewType = Rouge2_SaveInfoListModel.instance:getViewType()

	if viewType == Rouge2_OutsideEnum.SaveInfoViewType.Edit then
		GameFacade.showMessageBox(MessageBoxIdDefine.Rouge2AbandonRecord, MsgBoxEnum.BoxType.Yes_No, self._abandonRecord, nil, nil, self)

		return
	end

	self:closeThis()
end

function Rouge2_SaveInfoViewContainer:_abandonRecord()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSaveRecordDone)
	self:closeThis()
end

return Rouge2_SaveInfoViewContainer
