-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzlePipeView.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzlePipeView", package.seeall)

local DungeonPuzzlePipeView = class("DungeonPuzzlePipeView", BaseView)

function DungeonPuzzlePipeView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._simagemap = gohelper.findChildSingleImage(self.viewGO, "#simage_map")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._gocell1 = gohelper.findChild(self.viewGO, "#go_map/#go_cell_1")
	self._gocell2 = gohelper.findChild(self.viewGO, "#go_map/#go_cell_2")
	self._gocell3 = gohelper.findChild(self.viewGO, "#go_map/#go_cell_3")
	self._goflag = gohelper.findChild(self.viewGO, "#go_map/#go_flag")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzlePipeView:addEvents()
	return
end

function DungeonPuzzlePipeView:removeEvents()
	return
end

function DungeonPuzzlePipeView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_jiemi_beijigntu"))
	self._simagemap:LoadImage(ResUrl.getDungeonPuzzleBg("bg_jiemi_zhizhang_2"))
end

function DungeonPuzzlePipeView:onUpdateParam()
	return
end

function DungeonPuzzlePipeView:onOpen()
	self.addEventCb(self, DungeonPuzzlePipeController.instance, DungeonPuzzleEvent.PipeGameClear, self._onGameClear, self)
end

function DungeonPuzzlePipeView:_onGameClear()
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(self._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)

	local elementCo = DungeonPuzzlePipeModel.instance:getElementCo()

	DungeonRpc.instance:sendPuzzleFinishRequest(elementCo.id)
end

function DungeonPuzzlePipeView:onCloseFinish()
	local elementCo = DungeonPuzzlePipeModel.instance:getElementCo()

	if elementCo and DungeonMapModel.instance:hasMapPuzzleStatus(elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, elementCo.id)
	end

	DungeonPuzzlePipeModel.instance:release()
	DungeonPuzzlePipeController.instance:release()
end

function DungeonPuzzlePipeView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagemap:UnLoadImage()
end

return DungeonPuzzlePipeView
