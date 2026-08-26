-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyRoomTipsItem.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyRoomTipsItem", package.seeall)

local PartyGameLobbyRoomTipsItem = class("PartyGameLobbyRoomTipsItem", ListScrollCellExtend)

function PartyGameLobbyRoomTipsItem:onInitView()
	self._goheadicon = gohelper.findChild(self.viewGO, "root/go_tips/#go_headicon")
	self._txtname = gohelper.findChildText(self.viewGO, "root/go_tips/#txt_name")
	self._txtstate = gohelper.findChildText(self.viewGO, "root/go_tips/#txt_state")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyRoomTipsItem:addEvents()
	return
end

function PartyGameLobbyRoomTipsItem:removeEvents()
	return
end

function PartyGameLobbyRoomTipsItem:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goheadicon)

	self._playericon:setEnableClick(false)
	self._playericon:setShowLevel(false)
end

function PartyGameLobbyRoomTipsItem:_editableAddEvents()
	return
end

function PartyGameLobbyRoomTipsItem:_editableRemoveEvents()
	return
end

function PartyGameLobbyRoomTipsItem:onUpdateMO(mo)
	local socialFriendModel = SocialListModel.instance:getModel(SocialEnum.Type.Friend)
	local friendMo = socialFriendModel:getById(mo.id)

	self._txtname.text = friendMo.name

	self._playericon:onUpdateMO(friendMo)
end

function PartyGameLobbyRoomTipsItem:onSelect(isSelect)
	return
end

function PartyGameLobbyRoomTipsItem:onDestroyView()
	return
end

return PartyGameLobbyRoomTipsItem
