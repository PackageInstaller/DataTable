-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6GameResult.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameResult", package.seeall)

local LengZhou6GameResult = class("LengZhou6GameResult", BaseView)

function LengZhou6GameResult:onInitView()
	self._gotop = gohelper.findChild(self.viewGO, "#go_top")
	self._txtstage = gohelper.findChildText(self.viewGO, "#go_top/#txt_stage")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_top/#txt_name")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_finish")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")
	self._btnsuccessClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_successClick")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6GameResult:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnsuccessClick:AddClickListener(self._btnsuccessClickOnClick, self)
end

function LengZhou6GameResult:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnsuccessClick:RemoveClickListener()
end

function LengZhou6GameResult:_btnquitgameOnClick()
	self:close()
end

function LengZhou6GameResult:_btnrestartOnClick()
	self._isCloseGameView = false

	self:close()
	LengZhou6Controller.instance:restartGame()
end

function LengZhou6GameResult:_btnsuccessClickOnClick()
	self:close()
end

function LengZhou6GameResult:close()
	self:closeThis()
end

function LengZhou6GameResult:_editableInitView()
	return
end

function LengZhou6GameResult:onUpdateParam()
	return
end

function LengZhou6GameResult:onOpen()
	self._isCloseGameView = true

	self:initInfo()
	self:initResult()
	LengZhou6StatHelper.instance:sendGameExit()
end

function LengZhou6GameResult:initInfo()
	local config = LengZhou6GameModel.instance:getEpisodeConfig()

	self._txtname.text = config.name
	self._txtstage.text = string.format("STAGE %s", config.episodeId - 1270200)
end

function LengZhou6GameResult:initResult()
	local isWin = LengZhou6GameModel.instance:playerIsWin()

	gohelper.setActive(self._gofail, not isWin)
	gohelper.setActive(self._gosuccess, isWin)
	gohelper.setActive(self._gobtn, not isWin)

	if isWin then
		if not AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_success then
			local audioId = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_fail

			AudioMgr.instance:trigger(audioId)

			if isWin then
				if not LengZhou6Enum.GameResult.win then
					local result = LengZhou6Enum.GameResult.lose

					LengZhou6StatHelper.instance:setGameResult(result)
				end
			end
		end
	end
end

function LengZhou6GameResult:onClose()
	LengZhou6GameController.instance:levelGame(self._isCloseGameView)
end

return LengZhou6GameResult
