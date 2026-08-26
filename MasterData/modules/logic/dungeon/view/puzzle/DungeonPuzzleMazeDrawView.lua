-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleMazeDrawView.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDrawView", package.seeall)

local DungeonPuzzleMazeDrawView = class("DungeonPuzzleMazeDrawView", BaseView)

function DungeonPuzzleMazeDrawView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._simagemap = gohelper.findChildSingleImage(self.viewGO, "#simage_map")
	self._simagedecorate = gohelper.findChildSingleImage(self.viewGO, "forbidentips/#simage_decorate")
	self._simagetipsbg = gohelper.findChildSingleImage(self.viewGO, "tips/#simage_tipsbg")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._goconnect = gohelper.findChild(self.viewGO, "#go_connect")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzleMazeDrawView:addEvents()
	return
end

function DungeonPuzzleMazeDrawView:removeEvents()
	return
end

function DungeonPuzzleMazeDrawView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_jiemi_beijigntu"))
	self._simagemap:LoadImage(ResUrl.getDungeonPuzzleBg("bg_ditubeijing"))
	self._simagedecorate:LoadImage(ResUrl.getDungeonPuzzleBg("bg_tishiyemian"))
	self._simagetipsbg:LoadImage(ResUrl.getDungeonPuzzleBg("bg_tishiyemian_1"))
end

function DungeonPuzzleMazeDrawView:onUpdateParam()
	return
end

function DungeonPuzzleMazeDrawView:onOpen()
	self.addEventCb(self, DungeonPuzzleMazeDrawController.instance, DungeonPuzzleEvent.MazeDrawGameClear, self.onGameClear, self)
end

function DungeonPuzzleMazeDrawView:onGameClear()
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(self._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)

	local elementCo = DungeonPuzzleMazeDrawModel.instance:getElementCo()

	DungeonRpc.instance:sendPuzzleFinishRequest(elementCo.id)
end

function DungeonPuzzleMazeDrawView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local elementCo = DungeonPuzzleMazeDrawModel.instance:getElementCo()

	if elementCo and DungeonMapModel.instance:hasMapPuzzleStatus(elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, elementCo.id)
	end

	DungeonPuzzleMazeDrawController.instance:release()
	DungeonPuzzleMazeDrawModel.instance:release()
end

function DungeonPuzzleMazeDrawView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagemap:UnLoadImage()
	self._simagedecorate:UnLoadImage()
	self._simagetipsbg:UnLoadImage()
end

return DungeonPuzzleMazeDrawView
