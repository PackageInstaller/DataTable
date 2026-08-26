-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyMatchView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyMatchView", package.seeall)

local PartyGameLobbyMatchView = class("PartyGameLobbyMatchView", BaseView)

function PartyGameLobbyMatchView:onInitView()
	self._gomatching = gohelper.findChild(self.viewGO, "root/go_match/#go_matching")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/go_match/#go_matching/#txt_num")
	self._txttime = gohelper.findChildText(self.viewGO, "root/go_match/#go_matching/#txt_time")
	self._gosuccess = gohelper.findChild(self.viewGO, "root/go_match/#go_success")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_match/#btn_cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyMatchView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function PartyGameLobbyMatchView:removeEvents()
	self._btncancel:RemoveClickListener()
end

function PartyGameLobbyMatchView:_btncancelOnClick()
	PartyMatchRpc.instance:sendCancelPartyMatchRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
end

function PartyGameLobbyMatchView:_onEscape()
	local status = PartyGameRoomModel.instance:getMatchStatus()

	if status == PartyGameLobbyEnum.MatchStatus.StartMatch and PartyGameRoomModel.instance:isRoomOwner() then
		self:_btncancelOnClick()
	end
end

function PartyGameLobbyMatchView:_editableInitView()
	self._animator = self.viewGO:GetComponent("Animator")

	NavigateMgr.instance:addEscape(self.viewName, self._onEscape, self)
end

function PartyGameLobbyMatchView:onUpdateParam()
	return
end

function PartyGameLobbyMatchView:onOpen()
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.MatchStatusChange, self._onMatchStatusChange, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.MatchInfoPush, self._onMatchInfoPush, self)
	self:_updateStatus()

	self._txtnum.text = string.format("%s/%s", PartyGameRoomModel.instance:getPlayerNum(), PartyGameLobbyEnum.MaxPlayerCount)

	local matchTime = PartyGameRoomModel.instance:getMatchTime() or ServerTime.now()

	self._matchSecond = math.floor(math.max(0, math.floor(ServerTime.now() - matchTime)))

	TaskDispatcher.cancelTask(self._updateMatchTime, self)
	TaskDispatcher.runRepeat(self._updateMatchTime, self, 1)
	self:_updateMatchTime()
end

function PartyGameLobbyMatchView:_updateMatchTime()
	self._txttime.text = self._matchSecond
	self._matchSecond = self._matchSecond + 1
end

function PartyGameLobbyMatchView:_onMatchInfoPush()
	self._animator:Play("success")
end

function PartyGameLobbyMatchView:_onMatchStatusChange()
	self:_updateStatus()
end

function PartyGameLobbyMatchView:_updateStatus()
	local status = PartyGameRoomModel.instance:getMatchStatus()
	local matchSuccess = status == PartyGameLobbyEnum.MatchStatus.MatchSuccess

	gohelper.setActive(self._gomatching, not matchSuccess)
	gohelper.setActive(self._gosuccess, matchSuccess)
	gohelper.setActive(self._btncancel, status == PartyGameLobbyEnum.MatchStatus.StartMatch and PartyGameRoomModel.instance:isRoomOwner())
end

function PartyGameLobbyMatchView:onClose()
	TaskDispatcher.cancelTask(self._updateMatchTime, self)
end

function PartyGameLobbyMatchView:onDestroyView()
	return
end

return PartyGameLobbyMatchView
