-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyGroupView.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyGroupView", package.seeall)

local MiniPartyGroupView = class("MiniPartyGroupView", BaseView)

function MiniPartyGroupView:onInitView()
	self._btngroup = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_group")
	self._gogrouped = gohelper.findChild(self.viewGO, "Left/#btn_group/grouped")
	self._goungroup = gohelper.findChild(self.viewGO, "Left/#btn_group/ungroup")
	self._gogroupreddot = gohelper.findChild(self.viewGO, "Left/#btn_group/#go_groupreddot")
	self._txtgroupnum = gohelper.findChildText(self.viewGO, "Left/#btn_group/#go_groupreddot/#txt_groupnum")
	self._gofrienditem = gohelper.findChild(self.viewGO, "Left/scroll_FriendList/Viewport/Content/#go_frienditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MiniPartyGroupView:addEvents()
	self._btngroup:AddClickListener(self._btngroupOnClick, self)
end

function MiniPartyGroupView:removeEvents()
	self._btngroup:RemoveClickListener()
end

function MiniPartyGroupView:_btngroupOnClick()
	local hasGrouped = MiniPartyModel.instance:hasGrouped()

	if hasGrouped then
		return
	end

	LaplaceForumController.instance:openLaplaceMiniPartyInviteView()
end

function MiniPartyGroupView:_editableInitView()
	self._groupItems = self:getUserDataTb_()

	gohelper.setActive(self._gofrienditem, false)
	self:_addSelfEvents()
end

function MiniPartyGroupView:_addSelfEvents()
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteTypeSelectChanged, self._refreshUI, self)
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInviteSend, self._refresh, self)
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteFriendAgreeBack, self._refresh, self)
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInfoChange, self._refresh, self)
end

function MiniPartyGroupView:_removeSelfEvents()
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteTypeSelectChanged, self._refreshUI, self)
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInviteSend, self._refresh, self)
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteFriendAgreeBack, self._refresh, self)
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.OnInfoChange, self._refresh, self)
end

function MiniPartyGroupView:onUpdateParam()
	return
end

function MiniPartyGroupView:onOpen()
	self:_refresh()
end

function MiniPartyGroupView:_refresh()
	self:_refreshUI()
	self:_refreshGroups()
end

function MiniPartyGroupView:_refreshUI()
	local hasGrouped = MiniPartyModel.instance:hasGrouped()

	gohelper.setActive(self._gogrouped, hasGrouped)
	gohelper.setActive(self._goungroup, not hasGrouped)

	local uncheckCount = MiniPartyModel.instance:getAllUncheckInviteCount()

	gohelper.setActive(self._gogroupreddot, uncheckCount > 0)

	if uncheckCount > 0 then
		self._txtgroupnum.text = uncheckCount
	end
end

function MiniPartyGroupView:_refreshGroups()
	for i = 1, 2 do
		if not self._groupItems[i] then
			self._groupItems[i] = MiniPartyGroupItem.New()

			local go = gohelper.cloneInPlace(self._gofrienditem)

			self._groupItems[i]:init(go)
		end

		self._groupItems[i]:refresh(i)
	end
end

function MiniPartyGroupView:onClose()
	return
end

function MiniPartyGroupView:onDestroyView()
	self:_removeSelfEvents()

	if self._groupItems then
		for _, groupItem in pairs(self._groupItems) do
			groupItem:destroy()
		end

		self._groupItems = nil
	end
end

return MiniPartyGroupView
