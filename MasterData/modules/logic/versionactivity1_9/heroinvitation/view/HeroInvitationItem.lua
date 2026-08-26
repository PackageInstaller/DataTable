-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationItem.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationItem", package.seeall)

local HeroInvitationItem = class("HeroInvitationItem", ListScrollCellExtend)

function HeroInvitationItem:onInitView()
	self.goLocked = gohelper.findChild(self.viewGO, "Locked")
	self.txtLocked = gohelper.findChildTextMesh(self.viewGO, "Locked/txt_locked")
	self.goNormal = gohelper.findChild(self.viewGO, "Normal")
	self.goNormalBg = gohelper.findChild(self.goNormal, "NormalBg")
	self.goSelectedBg = gohelper.findChild(self.goNormal, "SelectedBg")
	self.simageNormalRoleHead = gohelper.findChildSingleImage(self.goNormalBg, "#simage_rolehead")
	self.simageSelectRoleHead = gohelper.findChildSingleImage(self.goSelectedBg, "#simage_rolehead")
	self.btnGoto = gohelper.findChildButtonWithAudio(self.viewGO, "Normal/#btn_goto")
	self.goIcon = gohelper.findChild(self.viewGO, "Normal/#go_reward/#go_rewarditem/go_icon")
	self.goCanGet = gohelper.findChild(self.viewGO, "Normal/#go_reward/#go_rewarditem/go_canget")
	self.goHasGet = gohelper.findChild(self.viewGO, "Normal/#go_reward/#go_rewarditem/go_receive")
	self.btnCanGet = gohelper.findChildButtonWithAudio(self.viewGO, "Normal/#go_reward/#go_rewarditem/go_canget")
	self.goBg = gohelper.findChild(self.viewGO, "Normal/bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroInvitationItem:addEvents()
	self.addClickCb(self, self.btnGoto, self.onClickBtnGoto, self)
	self.addClickCb(self, self.btnCanGet, self.onClickBtnCanGet, self)
end

function HeroInvitationItem:removeEvents()
	return
end

function HeroInvitationItem:_editableInitView()
	return
end

function HeroInvitationItem:onClickBtnCanGet()
	if not self._mo then
		return
	end

	local state = HeroInvitationModel.instance:getInvitationState(self._mo.id)

	if state == HeroInvitationEnum.InvitationState.CanGet then
		HeroInvitationRpc.instance:sendGainInviteRewardRequest(self._mo.id)
	end
end

function HeroInvitationItem:onClickBtnGoto()
	if not self._mo then
		return
	end

	ViewMgr.instance:closeView(ViewName.HeroInvitationView)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, self._mo.elementId)
end

function HeroInvitationItem:onUpdateMO(mo)
	self._mo = mo

	self:refresHead()
	self:refreshState()
end

function HeroInvitationItem:refresHead()
	self.simageNormalRoleHead:LoadImage(ResUrl.getHeadIconSmall(self._mo.head))
	self.simageSelectRoleHead:LoadImage(ResUrl.getHeadIconSmall(self._mo.head))
end

function HeroInvitationItem:refreshState()
	TaskDispatcher.cancelTask(self.refreshFrameTime, self)

	local state = HeroInvitationModel.instance:getInvitationState(self._mo.id)
	local isLock = state == HeroInvitationEnum.InvitationState.TimeLocked or state == HeroInvitationEnum.InvitationState.ElementLocked

	gohelper.setActive(self.goLocked, isLock)
	gohelper.setActive(self.goNormal, not isLock)
	gohelper.setActive(self.goBg, state == HeroInvitationEnum.InvitationState.Normal)
	gohelper.setActive(self.goSelectedBg, state == HeroInvitationEnum.InvitationState.Normal)
	gohelper.setActive(self.goNormalBg, not isLock and state ~= HeroInvitationEnum.InvitationState.Normal)

	if state == HeroInvitationEnum.InvitationState.ElementLocked then
		self.txtLocked.text = luaLang("p_v1a9_invitationview_txt_dec2")
	elseif state == HeroInvitationEnum.InvitationState.TimeLocked then
		self:refreshFrameTime()
		TaskDispatcher.runRepeat(self.refreshFrameTime, self, 1)
	else
		local rewardList = GameUtil.splitString2(self._mo.rewardDisplayList, true)
		local reward1 = rewardList[1]

		self.itemIcon = self.itemIcon or IconMgr.instance:getCommonPropItemIcon(self.goIcon)

		self.itemIcon:setMOValue(reward1[1], reward1[2], reward1[3], nil, true)
		self.itemIcon:setScale(0.6)
		self.itemIcon:setCountTxtSize(36)
		gohelper.setActive(self.goHasGet, state == HeroInvitationEnum.InvitationState.Finish)
		gohelper.setActive(self.goCanGet, state == HeroInvitationEnum.InvitationState.CanGet)
	end
end

function HeroInvitationItem:refreshFrameTime()
	if not self._mo then
		return
	end

	local openTime = HeroInvitationMo.stringToTimestamp(self._mo.openTime)
	local leftTime = openTime - ServerTime.now()

	if leftTime < 0 then
		self:refreshState()

		return
	end

	local time = string.format("%s%s", TimeUtil.secondToRoughTime2(leftTime))

	self.txtLocked.text = formatLuaLang("test_task_unlock_time", time)
end

function HeroInvitationItem:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshFrameTime, self)

	if self.simageNormalRoleHead then
		self.simageNormalRoleHead:UnLoadImage()
	end

	if self.simageSelectRoleHead then
		self.simageSelectRoleHead:UnLoadImage()
	end
end

return HeroInvitationItem
