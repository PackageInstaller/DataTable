-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyInviteFriendView.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyInviteFriendView", package.seeall)

local MiniPartyInviteFriendView = class("MiniPartyInviteFriendView", BaseView)

function MiniPartyInviteFriendView:onInitView()
	self._gofriend = gohelper.findChild(self.viewGO, "Panel/Content/#go_friend")
	self._gofrienditem = gohelper.findChild(self.viewGO, "Panel/Content/#go_friend/scrollview/viewport/content/#go_frienditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MiniPartyInviteFriendView:addEvents()
	return
end

function MiniPartyInviteFriendView:removeEvents()
	return
end

function MiniPartyInviteFriendView:_editableInitView()
	gohelper.setActive(self._gofrienditem, false)

	self._friendItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function MiniPartyInviteFriendView:_addSelfEvents()
	MiniPartyController.instance:registerCallback(MiniPartyEvent.InviteTypeSelectChanged, self._onSelectTab, self)
end

function MiniPartyInviteFriendView:_removeSelfEvents()
	MiniPartyController.instance:unregisterCallback(MiniPartyEvent.InviteTypeSelectChanged, self._onSelectTab, self)
end

function MiniPartyInviteFriendView:onOpen()
	self:_refreshFriends()
end

function MiniPartyInviteFriendView:_onSelectTab(type)
	if type ~= MiniPartyEnum.InviteType.Friend then
		return
	end

	self:_refreshFriends()

	local friendMos = MiniPartyModel.instance:getFriendTeams()

	for index, _ in ipairs(friendMos) do
		if self._friendItems[index] then
			self._friendItems[index]:showSwitch()
		end
	end
end

function MiniPartyInviteFriendView:_refreshFriends()
	local friendMos = MiniPartyModel.instance:getFriendTeams()

	if #friendMos < #self._friendItems then
		for i = #friendMos + 1, #self._friendItems do
			gohelper.setActive(self._friendItems[i].go, false)
		end
	end

	for index, friendMo in ipairs(friendMos) do
		if not self._friendItems[index] then
			self._friendItems[index] = MiniPartyInviteFriendItem.New()

			local go = gohelper.cloneInPlace(self._gofrienditem)

			self._friendItems[index]:init(go)
		end

		gohelper.setActive(self._friendItems[index].go, true)
		self._friendItems[index]:refresh(friendMo, index)
	end
end

function MiniPartyInviteFriendView:onClose()
	return
end

function MiniPartyInviteFriendView:onDestroyView()
	self:_removeSelfEvents()

	if self._friendItems then
		for _, friendItem in pairs(self._friendItems) do
			friendItem:destroy()
		end

		self._friendItems = nil
	end
end

return MiniPartyInviteFriendView
