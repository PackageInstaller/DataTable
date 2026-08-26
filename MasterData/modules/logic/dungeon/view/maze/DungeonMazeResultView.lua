-- chunkname: @modules/logic/dungeon/view/maze/DungeonMazeResultView.lua

module("modules.logic.dungeon.view.maze.DungeonMazeResultView", package.seeall)

local DungeonMazeResultView = class("DungeonMazeResultView", BaseViewExtended)
local ctrl = DungeonMazeController.instance

function DungeonMazeResultView:onInitView()
	self._closeBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_successClick")
	self._exitBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._restartBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._goFail = gohelper.findChild(self.viewGO, "#go_fail")
	self._goBtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._goClose = gohelper.findChild(self.viewGO, "#btn_successClick")
	self._txtStage = gohelper.findChildText(self.viewGO, "#go_top/#txt_stage")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_top/#txt_name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMazeResultView:addEvents()
	self._closeBtn:AddClickListener(self._onClickCloseBtn, self)
	self._restartBtn:AddClickListener(self._onClickRestartBtn, self)
	self._exitBtn:AddClickListener(self._onClickExitBtn, self)
end

function DungeonMazeResultView:removeEvents()
	self._closeBtn:RemoveClickListener()
	self._restartBtn:RemoveClickListener()
	self._exitBtn:RemoveClickListener()
end

function DungeonMazeResultView:_onClickCloseBtn()
	ctrl:dispatchEvent(DungeonMazeEvent.DungeonMazeCompleted)
	self:closeThis()
end

function DungeonMazeResultView:_onClickExitBtn()
	ctrl:dispatchEvent(DungeonMazeEvent.DungeonMazeExit)
	self:closeThis()
end

function DungeonMazeResultView:_onClickRestartBtn()
	ctrl:dispatchEvent(DungeonMazeEvent.DungeonMazeReStart)
	self:closeThis()
end

function DungeonMazeResultView:_editableInitView()
	return
end

function DungeonMazeResultView:onUpdateParam()
	return
end

function DungeonMazeResultView:onOpen()
	local viewParams = self.viewParam
	local win = viewParams.isWin
	local curEpisodeId = viewParams.episodeId

	gohelper.setActive(self._goSuccess, win)
	gohelper.setActive(self._goFail, not win)
	gohelper.setActive(self._goBtn, not win)
	gohelper.setActive(self._goClose, win)

	local curEpisode = DungeonConfig.instance:getEpisodeCO(curEpisodeId)

	self._txtName.text = string.format("%s", curEpisode.name)
end

function DungeonMazeResultView:onClose()
	return
end

function DungeonMazeResultView:onDestroyView()
	return
end

return DungeonMazeResultView
