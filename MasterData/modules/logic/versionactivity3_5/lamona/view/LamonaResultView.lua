-- chunkname: @modules/logic/versionactivity3_5/lamona/view/LamonaResultView.lua

module("modules.logic.versionactivity3_5.lamona.view.LamonaResultView", package.seeall)

local LamonaResultView = class("LamonaResultView", BaseView)

function LamonaResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gowin = gohelper.findChild(self.viewGO, "#go_success")
	self._gofailed = gohelper.findChild(self.viewGO, "#go_fail")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/txt_taskdesc")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_finish")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_unfinish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LamonaResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function LamonaResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function LamonaResultView:_btncloseOnClick()
	self:closeThis()
end

function LamonaResultView:_editableInitView()
	return
end

function LamonaResultView:onUpdateParam()
	self._caughtCount = 0
	self._targetCount = 0
	self._isWin = false

	if not self.viewParam then
		return
	end

	self._episodeId = self.viewParam.episodeId
	self._gameId = self.viewParam.gameId
	self._caughtCount = self.viewParam.caughtCount
	self._targetCount = self.viewParam.targetCount
	self._isWin = self._caughtCount >= self._targetCount
end

function LamonaResultView:onOpen()
	self:onUpdateParam()
	self:refresh()

	if self._isWin then
		AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_yuanzheng_mrs_win)
	else
		AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_yuanzheng_mrs_fail)
	end
end

function LamonaResultView:refresh()
	local targetDesc = LamonaConfig.instance:getLamonaTargetDesc(self._gameId)

	self._txttaskdesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(targetDesc, self._caughtCount, self._targetCount)

	gohelper.setActive(self._gowin, self._isWin)
	gohelper.setActive(self._gofailed, not self._isWin)
	gohelper.setActive(self._gofinish, self._isWin)
	gohelper.setActive(self._gounfinish, not self._isWin)
end

function LamonaResultView:onClose()
	if self._isWin then
		if not LamonaStatHelper.OperationType.gameSuccess then
			local operationType = LamonaStatHelper.OperationType.failExit

			LamonaStatHelper.instance:sendOperationInfo(operationType)
			ViewMgr.instance:closeView(ViewName.LamonaGameView)

			if self._isWin and self._episodeId then
				LamonaController.instance:finishEpisodeLevel(self._episodeId)
			end
		end
	end
end

function LamonaResultView:onDestroyView()
	return
end

return LamonaResultView
