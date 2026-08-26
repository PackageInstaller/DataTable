-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMembersView.lua

module("modules.logic.sp01.odyssey.view.OdysseyMembersView", package.seeall)

local OdysseyMembersView = class("OdysseyMembersView", BaseView)

function OdysseyMembersView:onInitView()
	self._gomembersItem = gohelper.findChild(self.viewGO, "#go_membersItem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyMembersView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, self.createAndRefreshMember, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, self.showExposeEffect, self)
end

function OdysseyMembersView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, self.createAndRefreshMember, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, self.showExposeEffect, self)
end

function OdysseyMembersView:_btnMemberItemOnClick(memberItem)
	if self.curSelectMemberId == memberItem.config.id then
		return
	end

	self.curSelectMemberId = memberItem.config.id

	OdysseyDungeonController.instance:openMembersTipView(memberItem)

	self.hasClickReligionIdMap[memberItem.config.id] = memberItem.config.id

	self:refreshSelectState()
	self:refreshMemberItem(memberItem)
end

function OdysseyMembersView:_editableInitView()
	for i = 1, 13 do
		self["_goMembers" .. i] = gohelper.findChild(self.viewGO, "Members/memberContent/#go_Members_" .. i)
	end

	self.memberItemMap = self:getUserDataTb_()
	self.hasClickReligionIdMap = self:getUserDataTb_()

	gohelper.setActive(self._gomembersItem, false)

	self.curSelectMemberId = 0
end

function OdysseyMembersView:onOpen()
	self:createAndRefreshMember()
	self:refreshSelectState()
	OdysseyStatHelper.instance:initViewStartTime()
end

function OdysseyMembersView:createAndRefreshMember()
	local religionCoList = OdysseyConfig.instance:getReligionConfigList()

	for _, religionCo in ipairs(religionCoList) do
		local memberItem = self.memberItemMap[religionCo.id]

		if not memberItem then
			memberItem = {
				config = religionCo,
				pos = self["_goMembers" .. religionCo.pos]
			}
			memberItem.itemGO = gohelper.clone(self._gomembersItem, memberItem.pos, "memberItem_" .. religionCo.id)
			memberItem.gounExposed = gohelper.findChild(memberItem.itemGO, "#go_unExposed")
			memberItem.gocanExposed = gohelper.findChild(memberItem.itemGO, "#go_unExposed/#go_canExposed")
			memberItem.goUnExposedNormal = gohelper.findChild(memberItem.itemGO, "#go_unExposed/#go_normal")
			memberItem.goUnExposedBoss = gohelper.findChild(memberItem.itemGO, "#go_unExposed/#go_boss")
			memberItem.goExposed = gohelper.findChild(memberItem.itemGO, "#go_Exposed")
			memberItem.gonormal = gohelper.findChild(memberItem.itemGO, "#go_Exposed/#go_normal")
			memberItem.goboss = gohelper.findChild(memberItem.itemGO, "#go_Exposed/#go_boss")
			memberItem.simagenormalIcon = gohelper.findChildSingleImage(memberItem.itemGO, "#go_Exposed/#go_normal/#image_normalIcon")
			memberItem.simagebossIcon = gohelper.findChildSingleImage(memberItem.itemGO, "#go_Exposed/#go_boss/#image_bossIcon")
			memberItem.godead = gohelper.findChild(memberItem.itemGO, "#go_Exposed/#go_dead")
			memberItem.simagedeadIcon = gohelper.findChildSingleImage(memberItem.itemGO, "#go_Exposed/#go_dead/#image_deadIcon")
			memberItem.exposeEffect = gohelper.findChild(memberItem.itemGO, "#go_Exposed/vx_glow")
			memberItem.goselect = gohelper.findChild(memberItem.itemGO, "#go_select")
			memberItem.btnclick = gohelper.findChildButtonWithAudio(memberItem.itemGO, "#btn_click")

			memberItem.btnclick:AddClickListener(self._btnMemberItemOnClick, self, memberItem)

			self.memberItemMap[religionCo.id] = memberItem
		end

		gohelper.setActive(memberItem.itemGO, true)
		self:refreshMemberItem(memberItem)
	end
end

function OdysseyMembersView:refreshMemberItem(memberItem)
	local religionCo = memberItem.config
	local religionMo = OdysseyModel.instance:getReligionInfoData(religionCo.id)
	local canExpose = OdysseyMembersModel.instance:checkReligionMemberCanExpose(religionCo.id)
	local hasClick = OdysseyMembersModel.instance:getHasClickReglionId(religionCo.id) or self.hasClickReligionIdMap[religionCo.id]
	local hasNewClue = OdysseyMembersModel.instance:checkHasNewClue(religionCo.id)

	gohelper.setActive(memberItem.gounExposed, not religionMo)
	gohelper.setActive(memberItem.gocanExposed, not religionMo and (canExpose or hasNewClue and not hasClick))
	gohelper.setActive(memberItem.goUnExposedNormal, religionCo.isBoss ~= 1)
	gohelper.setActive(memberItem.goUnExposedBoss, religionCo.isBoss == 1)
	gohelper.setActive(memberItem.gonormal, religionCo.isBoss ~= 1)
	gohelper.setActive(memberItem.goboss, religionCo.isBoss == 1)
	gohelper.setActive(memberItem.goExposed, religionMo)

	if religionMo then
		gohelper.setActive(memberItem.gonormal, religionCo.isBoss ~= 1 and religionMo.status == OdysseyEnum.MemberStatus.Expose)
		gohelper.setActive(memberItem.goboss, religionCo.isBoss == 1 and religionMo.status == OdysseyEnum.MemberStatus.Expose)
		gohelper.setActive(memberItem.godead, religionMo.status == OdysseyEnum.MemberStatus.Dead)
		memberItem.simagenormalIcon:LoadImage(ResUrl.monsterHeadIcon(religionCo.icon))
		memberItem.simagedeadIcon:LoadImage(ResUrl.monsterHeadIcon(religionCo.icon))
		memberItem.simagebossIcon:LoadImage(ResUrl.monsterHeadIcon(religionCo.icon))
	end
end

function OdysseyMembersView:refreshSelectState()
	for _, memberItem in pairs(self.memberItemMap) do
		gohelper.setActive(memberItem.goselect, memberItem.config.id == self.curSelectMemberId)
	end
end

function OdysseyMembersView:showExposeEffect(religionId)
	local memberItem = self.memberItemMap[religionId]
	local religionMo = OdysseyModel.instance:getReligionInfoData(religionId)

	if memberItem and religionMo then
		gohelper.setActive(memberItem.goExposed, true)
		gohelper.setActive(memberItem.exposeEffect, false)
		gohelper.setActive(memberItem.exposeEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_disclose)
	end
end

function OdysseyMembersView:_onCloseView(viewName)
	if viewName == ViewName.OdysseyMembersTipView then
		self.curSelectMemberId = 0

		self:refreshSelectState()
	end
end

function OdysseyMembersView:onClose()
	for _, memberItem in pairs(self.memberItemMap) do
		memberItem.btnclick:RemoveClickListener()
		memberItem.simagenormalIcon:UnLoadImage()
		memberItem.simagedeadIcon:UnLoadImage()
		memberItem.simagebossIcon:UnLoadImage()
	end

	OdysseyMembersModel.instance:saveLocalNewClueUnlockState()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyMembersView")
end

function OdysseyMembersView:onDestroyView()
	return
end

return OdysseyMembersView
