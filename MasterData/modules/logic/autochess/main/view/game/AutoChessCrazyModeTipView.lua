-- chunkname: @modules/logic/autochess/main/view/game/AutoChessCrazyModeTipView.lua

module("modules.logic.autochess.main.view.game.AutoChessCrazyModeTipView", package.seeall)

local AutoChessCrazyModeTipView = class("AutoChessCrazyModeTipView", BaseView)

function AutoChessCrazyModeTipView:onInitView()
	self._scrolldec = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_dec")
	self._txtModeTip = gohelper.findChildText(self.viewGO, "root/#scroll_dec/viewport/#txt_ModeTip")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCrazyModeTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function AutoChessCrazyModeTipView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function AutoChessCrazyModeTipView:_btnCloseOnClick()
	self:closeThis()
end

function AutoChessCrazyModeTipView:_editableInitView()
	return
end

function AutoChessCrazyModeTipView:onOpen()
	local actId = AutoChessModel.instance.actId
	local config = ActivityConfig.instance:getActivityCo(actId)

	self._txtModeTip.text = config.actDesc
end

function AutoChessCrazyModeTipView:onClose()
	AutoChessController.instance:dispatchEvent(AutoChessEvent.ZTrigger28302)
end

return AutoChessCrazyModeTipView
