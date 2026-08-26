-- chunkname: @modules/logic/dungeonmazev3a7/view/DungeonMazeV3a7ResultView.lua

module("modules.logic.dungeonmazev3a7.view.DungeonMazeV3a7ResultView", package.seeall)

local DungeonMazeV3a7ResultView = class("DungeonMazeV3a7ResultView", BaseViewExtended)
local ctrl = DungeonMazeV3a7Controller.instance

function DungeonMazeV3a7ResultView:onInitView()
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

function DungeonMazeV3a7ResultView:addEvents()
	self._closeBtn:AddClickListener(self._onClickCloseBtn, self)
	self._restartBtn:AddClickListener(self._onClickRestartBtn, self)
	self._exitBtn:AddClickListener(self._onClickExitBtn, self)
end

function DungeonMazeV3a7ResultView:removeEvents()
	self._closeBtn:RemoveClickListener()
	self._restartBtn:RemoveClickListener()
	self._exitBtn:RemoveClickListener()
end

function DungeonMazeV3a7ResultView:_onClickCloseBtn()
	ctrl:dispatchEvent(DungeonMazeV3a7Event.DungeonMazeV3a7Completed)
	self:closeThis()
end

function DungeonMazeV3a7ResultView:_onClickExitBtn()
	ctrl:dispatchEvent(DungeonMazeV3a7Event.DungeonMazeV3a7Exit)
	self:closeThis()
end

function DungeonMazeV3a7ResultView:_onClickRestartBtn()
	ctrl:dispatchEvent(DungeonMazeV3a7Event.DungeonMazeV3a7ReStart)
	self:closeThis()
end

function DungeonMazeV3a7ResultView:_editableInitView()
	return
end

function DungeonMazeV3a7ResultView:onUpdateParam()
	return
end

function DungeonMazeV3a7ResultView:onOpen()
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

function DungeonMazeV3a7ResultView:onClose()
	return
end

function DungeonMazeV3a7ResultView:onDestroyView()
	return
end

return DungeonMazeV3a7ResultView
