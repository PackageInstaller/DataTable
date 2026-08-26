-- chunkname: @modules/logic/prototest/view/ProtoTestViewContainer.lua

module("modules.logic.prototest.view.ProtoTestViewContainer", package.seeall)

local ProtoTestViewContainer = class("ProtoTestViewContainer", BaseViewContainer)

function ProtoTestViewContainer:buildViews()
	local views = {}
	local testCaseListParam = MixScrollParam.New()

	testCaseListParam.scrollGOPath = "Panel_testcase/protolist"
	testCaseListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	testCaseListParam.prefabUrl = "Panel_testcase/protolist/Viewport/item"
	testCaseListParam.cellClass = ProtoTestCaseItem
	testCaseListParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(ProtoTestCaseModel.instance, testCaseListParam))

	local testFileListParam = ListScrollParam.New()

	testFileListParam.scrollGOPath = "Panel_storage/testcaserepo"
	testFileListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	testFileListParam.prefabUrl = "Panel_storage/testcaserepo/Viewport/repo"
	testFileListParam.cellClass = ProtoTestFileItem
	testFileListParam.scrollDir = ScrollEnum.ScrollDirV
	testFileListParam.lineCount = 1
	testFileListParam.cellWidth = 520
	testFileListParam.cellHeight = 85
	testFileListParam.cellSpaceH = 0
	testFileListParam.cellSpaceV = 0

	table.insert(views, LuaListScrollView.New(ProtoTestFileModel.instance, testFileListParam))

	local testReqListParam = ListScrollParam.New()

	testReqListParam.scrollGOPath = "Panel_testcase/Panel_new/bg/scroll"
	testReqListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	testReqListParam.prefabUrl = "Panel_testcase/Panel_new/bg/scroll/Viewport/item"
	testReqListParam.cellClass = ProtoReqListItem
	testReqListParam.scrollDir = ScrollEnum.ScrollDirV
	testReqListParam.lineCount = 1
	testReqListParam.cellWidth = 350
	testReqListParam.cellHeight = 60
	testReqListParam.cellSpaceH = 0
	testReqListParam.cellSpaceV = 0

	table.insert(views, LuaListScrollView.New(ProtoReqListModel.instance, testReqListParam))
	table.insert(views, ProtoTestView.New())
	table.insert(views, ProtoTestCaseView.New())
	table.insert(views, ProtoTestFileView.New())
	table.insert(views, ProtoTestReqView.New())

	return views
end

function ProtoTestViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

return ProtoTestViewContainer
