-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyFriendListView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyFriendListView", package.seeall)

local PartyGameLobbyFriendListView = class("PartyGameLobbyFriendListView", BaseView)

function PartyGameLobbyFriendListView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goFriend = gohelper.findChild(self.viewGO, "root/friendList/friendInfo/#go_Friend")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "root/friendList/friendInfo/#btn_exit")
	self._goheadicon = gohelper.findChild(self.viewGO, "root/friendList/friendInfo/#go_headicon")
	self._txtroom = gohelper.findChildText(self.viewGO, "root/friendList/friendInfo/#txt_room")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "root/friendList/friendInfo/layout/#txt_currency")
	self._txttotal = gohelper.findChildText(self.viewGO, "root/friendList/friendInfo/layout/#txt_total")
	self._gohas = gohelper.findChild(self.viewGO, "root/friendList/#go_has")
	self._goempty = gohelper.findChild(self.viewGO, "root/friendList/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyFriendListView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
end

function PartyGameLobbyFriendListView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnexit:RemoveClickListener()
end

function PartyGameLobbyFriendListView:_btncloseOnClick()
	self:closeThis()
end

function PartyGameLobbyFriendListView:_btnexitOnClick()
	self:closeThis()
end

function PartyGameLobbyFriendListView:_editableInitView()
	return
end

function PartyGameLobbyFriendListView:onUpdateParam()
	return
end

function PartyGameLobbyFriendListView:onOpen()
	local friendModel = SocialListModel.instance:getModel(SocialEnum.Type.Friend)
	local onlineFriendModel = PartyGameRoomModel.instance:getFriendModel()
	local num = onlineFriendModel:getCount()

	gohelper.setActive(self._gohas, num > 0)
	gohelper.setActive(self._goempty, num <= 0)

	self._txttotal.text = friendModel:getCount()
	self._txtcurrency.text = onlineFriendModel:getCount()
end

function PartyGameLobbyFriendListView:onClose()
	return
end

function PartyGameLobbyFriendListView:onDestroyView()
	return
end

return PartyGameLobbyFriendListView
