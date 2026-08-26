-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyInRoomPlayerItem.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyInRoomPlayerItem", package.seeall)

local PartyGameLobbyInRoomPlayerItem = class("PartyGameLobbyInRoomPlayerItem", ListScrollCellExtend)

function PartyGameLobbyInRoomPlayerItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._goheadicon = gohelper.findChild(self.viewGO, "#go_has/#go_headicon")
	self._gofangzhu = gohelper.findChild(self.viewGO, "#go_has/player/#go_fangzhu")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_has/player/#txt_name")
	self._goalready = gohelper.findChild(self.viewGO, "#go_has/state/#go_already")
	self._txtstate = gohelper.findChildText(self.viewGO, "#go_has/state/#txt_state")
	self._btnleave = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/#btn_leave")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyInRoomPlayerItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnleave:AddClickListener(self._btnleaveOnClick, self)
end

function PartyGameLobbyInRoomPlayerItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnleave:RemoveClickListener()
end

function PartyGameLobbyInRoomPlayerItem:_btnleaveOnClick()
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.PartyGameLobbyTips6, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, self._onKickOutPartyRoom, nil, nil, self)
end

function PartyGameLobbyInRoomPlayerItem:_onKickOutPartyRoom()
	PartyRoomRpc.instance:sendKickOutPlayerRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId(), self._mo.id)
end

function PartyGameLobbyInRoomPlayerItem:_btnclickOnClick()
	if self._showPlayerInfo then
		return
	end

	PartyRoomRpc.instance:sendGetInviteListRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
end

function PartyGameLobbyInRoomPlayerItem:_editableInitView()
	self._animator = self.viewGO:GetComponent("Animator")
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goheadicon)

	self._playericon:setPlayerInfoViewName(ViewName.PartyGameLobbyPlayerInfoView)
	self._playericon:setShowLevel(false)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ChangePartyRoomStatus, self._onChangePartyRoomStatus, self)
end

function PartyGameLobbyInRoomPlayerItem:_onChangePartyRoomStatus()
	self:_updateState()
end

function PartyGameLobbyInRoomPlayerItem:_editableAddEvents()
	return
end

function PartyGameLobbyInRoomPlayerItem:_editableRemoveEvents()
	return
end

function PartyGameLobbyInRoomPlayerItem:onUpdateMO(mo)
	local prevShowPlayerInfo = self._showPlayerInfo

	self._mo = mo

	local showPlayerInfo = tonumber(self._mo.id) > 0

	gohelper.setActive(self._gohas, showPlayerInfo)
	gohelper.setActive(self._goempty, not showPlayerInfo)

	self._showPlayerInfo = showPlayerInfo

	local updateTime = PartyGameRoomModel.instance:getPlayerInfoUpdateTime()

	if updateTime and Time.time - updateTime < 0.1 then
		if not prevShowPlayerInfo and showPlayerInfo then
			self._animator:Play("in")
		elseif prevShowPlayerInfo and not showPlayerInfo then
			self._animator:Play("out")
		else
			self._animator:Play(showPlayerInfo and "idle2" or "idle1")
		end
	else
		self._animator:Play(showPlayerInfo and "idle2" or "idle1")
	end

	if not showPlayerInfo then
		return
	end

	gohelper.setActive(self._gofangzhu, self._mo.isRoomOwner)
	gohelper.setActive(self._btnleave, PartyGameRoomModel.instance:isRoomOwner() and not self._mo.isRoomOwner)
	self._playericon:onUpdateMO(self._mo)
	self._playericon:setEnableClick(self._mo.id ~= PlayerModel.instance:getMyUserId())

	self._txtname.text = self._mo.name

	self:_updateState()
end

function PartyGameLobbyInRoomPlayerItem:_updateState()
	if not self._showPlayerInfo then
		return
	end

	local isReady = self._mo.status == PartyGameLobbyEnum.RoomOperateState.Ready

	gohelper.setActive(self._goalready, isReady)

	local str1 = "<color=#407049>%s</color>"

	if self._mo.isRoomOwner then
		local value = luaLang("partygame_owner")

		self._txtstate.text = string.format(str1, value)

		return
	end

	if isReady then
		local value = luaLang("partygame_ready")

		self._txtstate.text = string.format(str1, value)
	else
		local str2 = "<color=#7c6300>%s</color>"
		local value = luaLang("partygame_notready")

		self._txtstate.text = string.format(str2, value)
	end
end

function PartyGameLobbyInRoomPlayerItem:onSelect(isSelect)
	return
end

function PartyGameLobbyInRoomPlayerItem:onDestroyView()
	return
end

return PartyGameLobbyInRoomPlayerItem
