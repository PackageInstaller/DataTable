-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiGameResultView.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameResultView", package.seeall)

local XugoujiGameResultView = class("XugoujiGameResultView", BaseView)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji

function XugoujiGameResultView:onInitView()
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_successClick")
	self._btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._btnRestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._goBtns = gohelper.findChild(self.viewGO, "#go_btn")
	self._goTargetRoot = gohelper.findChild(self.viewGO, "targets")
	self._goTargetItem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._goTips = gohelper.findChild(self.viewGO, "content/Layout/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "Tips/#txt_Tips")
	self._scrollItem = gohelper.findChild(self.viewGO, "#scroll_List/Viewport/Content/#go_Item")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#scroll_List/Viewport/Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XugoujiGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnExit:AddClickListener(self._btncloseOnClick, self)
	self._btnRestart:AddClickListener(self._btnRestartOnClick, self)
end

function XugoujiGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._btnRestart:RemoveClickListener()
end

function XugoujiGameResultView:_btncloseOnClick()
	if self:isLockOp() then
		return
	end

	XugoujiController.instance:gameResultOver()
end

function XugoujiGameResultView:_btnRestartOnClick()
	if self:isLockOp() then
		return
	end

	self:closeThis()
	XugoujiController.instance:restartEpisode()
end

function XugoujiGameResultView:_editableInitView()
	return
end

function XugoujiGameResultView:onUpdateParam()
	return
end

function XugoujiGameResultView:onOpen()
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.ExitGame, self.onExitGame, self)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btncloseOnClick, self)
	end

	self:_setLockOpTime(1)
	self:refreshUI()
end

function XugoujiGameResultView:onExitGame()
	local act188StatMo = XugoujiController.instance:getStatMo()

	act188StatMo:sendDungeonFinishStatData()
	self:closeThis()
end

function XugoujiGameResultView:onClose()
	return
end

function XugoujiGameResultView:onDestroyView()
	return
end

function XugoujiGameResultView:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function XugoujiGameResultView:refreshUI()
	local curEpisodeId = Activity188Model.instance:getCurEpisodeId()
	local resultreason = self.viewParam.reason

	self._star = self.viewParam.star

	local completed = resultreason == XugoujiEnum.ResultEnum.Completed
	local powerUsedUp = resultreason == XugoujiEnum.ResultEnum.PowerUseup
	local quit = resultreason == XugoujiEnum.ResultEnum.Quit
	local isFail = powerUsedUp or quit

	gohelper.setActive(self._gosuccess, completed)
	gohelper.setActive(self._gofail, isFail)
	gohelper.setActive(self._goBtns, isFail)
	gohelper.setActive(self._btnclose.gameObject, completed)
	AudioMgr.instance:trigger((isFail or nil) and (AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_challenge_fail or AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_endpoint_arriva))
	self:_createTargetList()
end

function XugoujiGameResultView:_createTargetList()
	self._targetDataList = {}

	local curGameId = Activity188Model.instance:getCurGameId()
	local gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	local targetParams = string.split(gameCfg.passRound, "#")

	for _, targetParam in ipairs(targetParams) do
		local targetRound = targetParam

		table.insert(self._targetDataList, targetRound)
	end

	gohelper.CreateObjList(self, self._createTargetItem, self._targetDataList, self._goTargetRoot, self._goTargetItem)
end

function XugoujiGameResultView:_createTargetItem(itemGo, targetRound, index)
	local msg = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("xugouji_round_target"), targetRound)

	gohelper.setActive(itemGo, true)

	local textComp = gohelper.findChildText(itemGo, "#txt_taskdesc")

	textComp.text = msg

	local gofinish = gohelper.findChild(itemGo, "result/#go_finish")
	local goUnfinish = gohelper.findChild(itemGo, "result/#go_unfinish")

	gohelper.setActive(gofinish, index <= self._star)
	gohelper.setActive(goUnfinish, index > self._star)
end

function XugoujiGameResultView:_setLockOpTime(lockTime)
	self._lockTime = Time.time + lockTime
end

function XugoujiGameResultView:isLockOp()
	if self._lockTime and Time.time < self._lockTime then
		return true
	end

	return false
end

return XugoujiGameResultView
