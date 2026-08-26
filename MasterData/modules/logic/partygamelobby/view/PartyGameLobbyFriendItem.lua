-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyFriendItem.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyFriendItem", package.seeall)

local PartyGameLobbyFriendItem = class("PartyGameLobbyFriendItem", ListScrollCellExtend)

function PartyGameLobbyFriendItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goheadicon = gohelper.findChild(self.viewGO, "#go_headicon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtstate = gohelper.findChildText(self.viewGO, "#txt_state")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_invite")
	self._goinvitenormal = gohelper.findChild(self.viewGO, "#btn_invite/#go_invitenormal")
	self._goinvitegrey = gohelper.findChild(self.viewGO, "#btn_invite/#go_invitegrey")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyFriendItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
end

function PartyGameLobbyFriendItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btninvite:RemoveClickListener()
end

function PartyGameLobbyFriendItem:_btnclickOnClick()
	return
end

function PartyGameLobbyFriendItem:_btninviteOnClick()
	if self:_canInvite() then
		PartyGameRoomModel.instance:setInviteCD(self._mo.id)
		self:_updateInviteStatus()
		PartyRoomRpc.instance:sendInviteFriendRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId(), self._mo.id)
	end
end

function PartyGameLobbyFriendItem:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goheadicon)

	self._playericon:setPlayerInfoViewName(ViewName.PartyGameLobbyPlayerInfoView)

	self._cdTime = tonumber(lua_party_const.configDict[2].value) + 2
	self._maxRefuseNum = tonumber(lua_party_const.configDict[3].value)
end

function PartyGameLobbyFriendItem:_editableAddEvents()
	return
end

function PartyGameLobbyFriendItem:_editableRemoveEvents()
	return
end

function PartyGameLobbyFriendItem:onUpdateMO(mo)
	self._mo = mo
	self._txtname.text = mo.name

	self._playericon:onUpdateMO(self._mo)
	self._playericon:setShowLevel(true)

	local friendInfo = PartyGameRoomModel.instance:getFriendInfo(self._mo.id)

	if friendInfo.state == PartyGameLobbyEnum.FriendState.Normal then
		self._txtstate.text = luaLang("social_online")
	elseif friendInfo.state == PartyGameLobbyEnum.FriendState.Matching then
		self._txtstate.text = luaLang("partygame_inroom")
	elseif friendInfo.state == PartyGameLobbyEnum.FriendState.InGame then
		self._txtstate.text = luaLang("partygame_ingame")
	end

	self:_updateInviteStatus()
end

function PartyGameLobbyFriendItem:_updateInviteStatus()
	local canInvite = self:_canInvite()

	gohelper.setActive(self._goinvitenormal, canInvite)
	gohelper.setActive(self._goinvitegray, not canInvite)

	local friendInfo = PartyGameRoomModel.instance:getFriendInfo(self._mo.id)

	gohelper.setActive(self._btninvite, friendInfo and friendInfo.state == PartyGameLobbyEnum.FriendState.Normal)
end

function PartyGameLobbyFriendItem:_canInvite()
	local time = PartyGameRoomModel.instance:getInviteCD(self._mo.id)
	local inCD = ServerTime.now() < time + self._cdTime

	if inCD then
		return false
	end

	if PartyGameRoomModel.instance:getPlayerInfo(self._mo.id) then
		return false
	end

	local refuseInfo = PartyGameRoomModel.instance:getRefuseInfo(PartyGameRoomModel.instance:getRoomId(), self._mo.id)

	if not refuseInfo then
		return true
	end

	if refuseInfo.refuseType == PartyGameLobbyEnum.RefuseType.Passive and refuseInfo.refuseNum < self._maxRefuseNum then
		return true
	end

	return false
end

function PartyGameLobbyFriendItem:onSelect(isSelect)
	return
end

function PartyGameLobbyFriendItem:onDestroyView()
	TaskDispatcher.cancelTask(self._updateInviteStatus, self)
end

return PartyGameLobbyFriendItem
