-- chunkname: @modules/logic/assist/view/AssistRoleBadgeItem.lua

module("modules.logic.assist.view.AssistRoleBadgeItem", package.seeall)

local AssistRoleBadgeItem = class("AssistRoleBadgeItem", LuaCompBase)

function AssistRoleBadgeItem:init(go)
	self.go = go
	self.simageBadge = gohelper.findChildSingleImage(go, "simage_Badge")
	self.txtName = gohelper.findChildText(go, "txt_Name")
	self.txtTarget = gohelper.findChildText(go, "txt_Target")
	self.goWear = gohelper.findChild(go, "go_Wear")
	self.goNew = gohelper.findChild(go, "go_New")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.isUnlock = false
end

function AssistRoleBadgeItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
	self.addEventCb(self, AssistController.instance, AssistEvent.UpdateWearBadges, self.refreshWearStatus, self)
end

function AssistRoleBadgeItem:onClick()
	if not self.isUnlock then
		GameFacade.showToast(ToastEnum.RoleBadgeNotUnlock)

		return
	end

	if self.goNew.activeInHierarchy then
		gohelper.setActive(self.goNew, false)
		RoleBadgeModel.instance:setRoleBadgeOld(self.heroUid, {
			self.config.id
		})
	end

	if self.wearIndex then
		RoleBadgeRpc.instance:sendRoleBadgeWearRequest(self.heroUid, self.wearIndex, 0)
	elseif self.wearCount < AssistEnum.MaxWearCount then
		local emptyPos = self.recordMo:getFirstEmptyWearPos()

		RoleBadgeRpc.instance:sendRoleBadgeWearRequest(self.heroUid, emptyPos, self.config.id)
	end
end

function AssistRoleBadgeItem:setData(heroUid, groupId)
	self.heroUid = heroUid

	local roleBadgeInfoMo = RoleBadgeModel.instance:getBadgeInfo()

	self.recordMo = roleBadgeInfoMo and roleBadgeInfoMo:getRecordMo(self.heroUid)
	self.badgeMo = self.recordMo and self.recordMo:getShowBadgeMo(groupId)

	local progress = 0

	if self.badgeMo then
		self.config = self.badgeMo.config
		self.isUnlock = self.badgeMo.status == AssistEnum.BadgeStatus.Finish
		progress = self.badgeMo.progress
	else
		self.config = RoleBadgeConfig.instance:getBadgeCoByLevel(groupId, 1)
		self.isUnlock = false
	end

	UIColorHelper.setGray(self.simageBadge.gameObject, not self.isUnlock)

	self.txtName.text = self.config.badgeTitle
	self.txtTarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(self.config.desc, progress)

	self.simageBadge:LoadImage(ResUrl.getRoleBadgeSingleBg(self.config.icon))
	self:refreshWearStatus(heroUid)

	if self.isUnlock then
		local isNew = RoleBadgeModel.instance:isRoleBadgeNew(self.heroUid, {
			self.config.id
		})

		gohelper.setActive(self.goNew, isNew)
	else
		gohelper.setActive(self.goNew, false)
	end
end

function AssistRoleBadgeItem:refreshWearStatus(heroUid)
	if self.heroUid ~= heroUid then
		return
	end

	self.wearIndex = self.recordMo and self.recordMo:getWearPos(self.config.id)
	self.wearCount = self.recordMo and self.recordMo:getWearCnt() or 0

	gohelper.setActive(self.goWear, self.wearIndex)
end

return AssistRoleBadgeItem
