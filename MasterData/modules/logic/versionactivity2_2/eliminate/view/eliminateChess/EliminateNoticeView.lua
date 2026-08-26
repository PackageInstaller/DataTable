-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateNoticeView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateNoticeView", package.seeall)

local EliminateNoticeView = class("EliminateNoticeView", BaseView)

function EliminateNoticeView:onInitView()
	self._goOccupy = gohelper.findChild(self.viewGO, "#go_Occupy")
	self._simageMaskBG = gohelper.findChildSingleImage(self.viewGO, "#go_Occupy/#simage_MaskBG")
	self._simageOccupy = gohelper.findChildSingleImage(self.viewGO, "#go_Occupy/#simage_Occupy")
	self._goStart = gohelper.findChild(self.viewGO, "#go_Start")
	self._simageStart = gohelper.findChildSingleImage(self.viewGO, "#go_Start/#simage_Start")
	self._txtStart = gohelper.findChildText(self.viewGO, "#go_Start/#txt_Start")
	self._goFinish = gohelper.findChild(self.viewGO, "#go_Finish")
	self._simageFinish = gohelper.findChildSingleImage(self.viewGO, "#go_Finish/#simage_Finish")
	self._goAssess1 = gohelper.findChild(self.viewGO, "#go_Assess1")
	self._goAssess2 = gohelper.findChild(self.viewGO, "#go_Assess2")
	self._goAssess3 = gohelper.findChild(self.viewGO, "#go_Assess3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateNoticeView:addEvents()
	return
end

function EliminateNoticeView:removeEvents()
	return
end

function EliminateNoticeView:_editableInitView()
	return
end

function EliminateNoticeView:onOpen()
	local param = self.viewParam

	self._isFinish = param.isFinish or false
	self._isStart = param.isStart or false
	self._isTeamChess = param.isTeamChess or false
	self._closeCallback = param.closeCallback
	self._time = param.closeTime or 1
	self._closeCallbackTarget = param.closeCallbackTarget
	self._isShowEvaluate = param.isShowEvaluate or false
	self._evaluateLevel = param.evaluateLevel or 1

	if self._isFinish then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_succeed)
	end

	if self._isStart then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_clearing)
	end

	if self._isTeamChess then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_clearing)
	end

	if self._isShowEvaluate then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess["play_ui_youyu_appraise_text_" .. self._evaluateLevel])
	end

	gohelper.setActive(self._goFinish, self._isFinish)
	gohelper.setActive(self._goStart, self._isStart)
	gohelper.setActive(self._goOccupy, self._isTeamChess)
	gohelper.setActive(self._goAssess1, self._isShowEvaluate and self._evaluateLevel == 3)
	gohelper.setActive(self._goAssess2, self._isShowEvaluate and self._evaluateLevel == 2)
	gohelper.setActive(self._goAssess3, self._isShowEvaluate and self._evaluateLevel == 1)

	if self._time then
		TaskDispatcher.runDelay(self.close, self, self._time)
	end
end

function EliminateNoticeView:close()
	ViewMgr.instance:closeView(ViewName.EliminateNoticeView)

	if self._closeCallbackTarget and self._closeCallback then
		self._closeCallback(self._closeCallbackTarget)
	end
end

function EliminateNoticeView:onClose()
	TaskDispatcher.cancelTask(self.close, self)
end

function EliminateNoticeView:onDestroyView()
	return
end

return EliminateNoticeView
