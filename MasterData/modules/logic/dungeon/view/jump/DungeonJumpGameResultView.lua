-- chunkname: @modules/logic/dungeon/view/jump/DungeonJumpGameResultView.lua

module("modules.logic.dungeon.view.jump.DungeonJumpGameResultView", package.seeall)

local DungeonJumpGameResultView = class("DungeonJumpGameResultView", BaseViewExtended)
local ctrl = DungeonJumpGameController.instance

function DungeonJumpGameResultView:onInitView()
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

function DungeonJumpGameResultView:addEvents()
	self._closeBtn:AddClickListener(self._onClickCloseBtn, self)
	self._restartBtn:AddClickListener(self._onClickRestartBtn, self)
	self._exitBtn:AddClickListener(self._onClickExitBtn, self)
end

function DungeonJumpGameResultView:removeEvents()
	self._closeBtn:RemoveClickListener()
	self._restartBtn:RemoveClickListener()
	self._exitBtn:RemoveClickListener()
end

function DungeonJumpGameResultView:_onClickCloseBtn()
	DungeonJumpGameController.instance:ClearProgress()
	ctrl:dispatchEvent(DungeonJumpGameEvent.JumpGameCompleted)
	self:closeThis()
end

function DungeonJumpGameResultView:_onClickExitBtn()
	DungeonJumpGameController.instance:ClearProgress()
	ctrl:dispatchEvent(DungeonJumpGameEvent.JumpGameExit)
	self:closeThis()
end

function DungeonJumpGameResultView:_onClickRestartBtn()
	ctrl:dispatchEvent(DungeonJumpGameEvent.JumpGameReStart)
	self:closeThis()
end

function DungeonJumpGameResultView:_editableInitView()
	return
end

function DungeonJumpGameResultView:onUpdateParam()
	return
end

function DungeonJumpGameResultView:onOpen()
	local viewParams = self.viewParam
	local win = viewParams.isWin
	local elementId = viewParams.elementId
	local episodeId = DungeonConfig.instance:getEpisodeByElement(elementId)
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)

	gohelper.setActive(self._goSuccess, win)
	gohelper.setActive(self._goFail, not win)
	gohelper.setActive(self._goBtn, not win)
	gohelper.setActive(self._goClose, win)

	self._txtName.text = string.format("%s", episodeCfg.name)

	if not win then
		AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_fail)
	end
end

function DungeonJumpGameResultView:onClose()
	return
end

function DungeonJumpGameResultView:onDestroyView()
	return
end

return DungeonJumpGameResultView
