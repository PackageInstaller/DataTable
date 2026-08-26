-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyInviteCheckView.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyInviteCheckView", package.seeall)

local MiniPartyInviteCheckView = class("MiniPartyInviteCheckView", BaseView)

function MiniPartyInviteCheckView:onInitView()
	self._gocheck = gohelper.findChild(self.viewGO, "Panel/Content/#go_check")
	self._gocheckitem = gohelper.findChild(self.viewGO, "Panel/Content/#go_check/scrollview/viewport/content/#go_checkitem")
	self._goempty = gohelper.findChild(self.viewGO, "Panel/Content/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MiniPartyInviteCheckView:addEvents()
	return
end

function MiniPartyInviteCheckView:removeEvents()
	return
end

function MiniPartyInviteCheckView:_editableInitView()
	gohelper.setActive(self._gocheckitem, false)

	self._inviteItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function MiniPartyInviteCheckView:_addSelfEvents()
	MiniPartyController.instance:registerCallback(MiniPartyEvent.InviteTypeSelectChanged, self._onSelectTab, self)
end

function MiniPartyInviteCheckView:_removeSelfEvents()
	MiniPartyController.instance:unregisterCallback(MiniPartyEvent.InviteTypeSelectChanged, self._onSelectTab, self)
end

function MiniPartyInviteCheckView:onOpen()
	self:_refreshInvites()
end

function MiniPartyInviteCheckView:_onSelectTab(type)
	if type ~= MiniPartyEnum.InviteType.Check then
		return
	end

	self:_refreshInvites()

	local inviteInfos = MiniPartyModel.instance:getInviteInfos()

	for index, inviteInfo in ipairs(inviteInfos) do
		if self._inviteItems[index] then
			self._inviteItems[index]:showSwitch()
		end
	end
end

function MiniPartyInviteCheckView:_refreshInvites()
	local inviteInfos = MiniPartyModel.instance:getInviteInfos()

	if #inviteInfos < #self._inviteItems then
		for i = #inviteInfos + 1, #self._inviteItems do
			gohelper.setActive(self._inviteItems[i].go, false)
		end
	end

	for index, inviteInfo in ipairs(inviteInfos) do
		if not self._inviteItems[index] then
			self._inviteItems[index] = MiniPartyInviteCheckItem.New()

			local go = gohelper.cloneInPlace(self._gocheckitem)

			self._inviteItems[index]:init(go)
		end

		gohelper.setActive(self._inviteItems[index].go, false)
		self._inviteItems[index]:refresh(inviteInfo, index)
	end
end

function MiniPartyInviteCheckView:onClose()
	return
end

function MiniPartyInviteCheckView:onDestroyView()
	self:_removeSelfEvents()

	if self._inviteItems then
		for _, friendItem in pairs(self._inviteItems) do
			friendItem:destroy()
		end

		self._inviteItems = nil
	end
end

return MiniPartyInviteCheckView
