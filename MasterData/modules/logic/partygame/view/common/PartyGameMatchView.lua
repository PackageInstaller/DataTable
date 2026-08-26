-- chunkname: @modules/logic/partygame/view/common/PartyGameMatchView.lua

module("modules.logic.partygame.view.common.PartyGameMatchView", package.seeall)

local PartyGameMatchView = class("PartyGameMatchView", BaseView)

function PartyGameMatchView:onInitView()
	self._txttips = gohelper.findChildTextMesh(self.viewGO, "#txt_tips")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancelMatch")
end

function PartyGameMatchView:addEvents()
	self._btncancel:AddClickListener(self.onClickCancel, self)
end

function PartyGameMatchView:removeEvents()
	self._btncancel:RemoveClickListener()
end

function PartyGameMatchView:onOpen()
	self._matchTime = 15

	TaskDispatcher.runRepeat(self._onTick, self, 1, self._matchTime)
	self:_onTick()
end

function PartyGameMatchView:onClickCancel()
	GMRpc.instance:sendGMRequest("cancelMatch")
	self:closeThis()
end

function PartyGameMatchView:_onTick()
	self._txttips.text = "匹配中。。。" .. self._matchTime
	self._matchTime = self._matchTime - 1
end

function PartyGameMatchView:onClose()
	TaskDispatcher.cancelTask(self._onTick, self)
end

return PartyGameMatchView
