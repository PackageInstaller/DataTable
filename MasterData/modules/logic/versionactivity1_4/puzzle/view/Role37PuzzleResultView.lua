-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/Role37PuzzleResultView.lua

module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleResultView", package.seeall)

local Role37PuzzleResultView = class("Role37PuzzleResultView", BaseView)

function Role37PuzzleResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_return")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Role37PuzzleResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
end

function Role37PuzzleResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnreturn:RemoveClickListener()
end

function Role37PuzzleResultView:_btncloseOnClick()
	self:_btnquitgameOnClick()
end

function Role37PuzzleResultView:_btnquitgameOnClick()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.Role37PuzzleView)
end

function Role37PuzzleResultView:_btnrestartOnClick()
	StatActivity130Controller.instance:statStart()
	Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
	self:closeThis()
	Role37PuzzleModel.instance:reset()
end

function Role37PuzzleResultView:_btnreturnOnClick()
	self:closeThis()
end

function Role37PuzzleResultView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	self._taskItems = {}

	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
end

function Role37PuzzleResultView:onUpdateParam()
	return
end

function Role37PuzzleResultView:onOpen()
	self:refreshUI()
end

function Role37PuzzleResultView:onClose()
	return
end

function Role37PuzzleResultView:refreshUI()
	local isSucess = Role37PuzzleModel.instance:getResult()
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local episodeCfg = Activity130Config.instance:getActivity130EpisodeCo(Activity130Enum.ActivityId.Act130, episodeId)

	if episodeCfg then
		self._txtclassnum.text = episodeCfg.episodetag
		self._txtclassname.text = episodeCfg.name

		local item = self:getOrCreateTaskItem(1)

		item.txtTaskDesc.text = episodeCfg.conditionStr

		gohelper.setActive(item.goFinish, isSucess)
		gohelper.setActive(item.goUnFinish, not isSucess)
	end

	if isSucess then
		self:refreshWin()
	else
		self:refreshLose()
	end
end

function Role37PuzzleResultView:refreshWin()
	gohelper.setActive(self._gosuccess, true)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_role_cover_open_1)
	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._btnquitgame, false)
	gohelper.setActive(self._btnrestart, false)
	gohelper.setActive(self._btnreturn, false)
end

function Role37PuzzleResultView:refreshLose()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, true)
	gohelper.setActive(self._btnclose, false)
	gohelper.setActive(self._btnreturn, false)
end

function Role37PuzzleResultView:getOrCreateTaskItem(index)
	local item = self._taskItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gotargetitem, "taskitem_" .. tostring(index))
		item.txtTaskDesc = gohelper.findChildText(item.go, "txt_taskdesc")
		item.goFinish = gohelper.findChild(item.go, "result/go_finish")
		item.goUnFinish = gohelper.findChild(item.go, "result/go_unfinish")
		item.goResult = gohelper.findChild(item.go, "result")

		gohelper.setActive(item.go, true)

		self._taskItems[index] = item
	end

	return item
end

function Role37PuzzleResultView:onDestroyView()
	self._simagebg1:UnLoadImage()
end

return Role37PuzzleResultView
