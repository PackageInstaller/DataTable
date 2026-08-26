-- chunkname: @modules/logic/versionactivity3_9/bird/view/game/V3a9BirdPauseView.lua

module("modules.logic.versionactivity3_9.bird.view.game.V3a9BirdPauseView", package.seeall)

local V3a9BirdPauseView = class("V3a9BirdPauseView", BaseView)

function V3a9BirdPauseView:onInitView()
	self._goquitshowview = gohelper.findChild(self.viewGO, "#go_quitshowview")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_restart")
	self._btnhome = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_home")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_cancel")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_quitshowview/#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9BirdPauseView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnhome:AddClickListener(self._btnhomeOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function V3a9BirdPauseView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnhome:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function V3a9BirdPauseView:_btnquitgameOnClick()
	if self.viewParam and self.viewParam.yesCallback then
		self.viewParam.yesCallback(self.viewParam.yesCbobj)
	end

	self:closeThis()
end

function V3a9BirdPauseView:_btnrestartOnClick()
	return
end

function V3a9BirdPauseView:_btnhomeOnClick()
	return
end

function V3a9BirdPauseView:_btncancelOnClick()
	if self.viewParam and self.viewParam.closeCallback then
		self.viewParam.closeCallback(self.viewParam.closeCbobj)
	end

	self:closeThis()
end

function V3a9BirdPauseView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self._btncancelOnClick, self)
end

function V3a9BirdPauseView:onUpdateParam()
	return
end

function V3a9BirdPauseView:onOpen()
	return
end

function V3a9BirdPauseView:onClose()
	return
end

function V3a9BirdPauseView:onDestroyView()
	return
end

return V3a9BirdPauseView
