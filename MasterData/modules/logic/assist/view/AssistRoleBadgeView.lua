-- chunkname: @modules/logic/assist/view/AssistRoleBadgeView.lua

module("modules.logic.assist.view.AssistRoleBadgeView", package.seeall)

local AssistRoleBadgeView = class("AssistRoleBadgeView", BaseView)

function AssistRoleBadgeView:onInitView()
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/#btn_Left")
	self._goHeroNode = gohelper.findChild(self.viewGO, "root/Left/#go_HeroNode")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/#btn_Right")
	self._txtWearCnt = gohelper.findChildText(self.viewGO, "root/Right/layout/#txt_WearCnt")
	self._goBadgeItem = gohelper.findChild(self.viewGO, "root/Right/ScrollView/Viewport/Content/#go_BadgeItem")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssistRoleBadgeView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function AssistRoleBadgeView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function AssistRoleBadgeView:_btnLeftOnClick()
	if self.curIndex > 1 then
		self.curIndex = self.curIndex - 1

		self.anim:Play("switch", 0, 0)
		ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)
		TaskDispatcher.runDelay(self.delaySwitch, self, 0.16)
	end
end

function AssistRoleBadgeView:_btnRightOnClick()
	if self.curIndex < self.maxCount then
		self.curIndex = self.curIndex + 1

		self.anim:Play("switch", 0, 0)
		ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)
		TaskDispatcher.runDelay(self.delaySwitch, self, 0.16)
	end
end

function AssistRoleBadgeView:delaySwitch()
	self:clearNewTag()

	self.curMo = CharacterBackpackCardListModel.instance:getByIndex(self.curIndex)

	self:refreshBntStatus()
	self:refreshInfo()
end

function AssistRoleBadgeView:_editableInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.maxCount = CharacterBackpackCardListModel.instance:getCount()
	self.badgeItemList = {}

	gohelper.setActive(self._goBadgeItem, false)

	self.groupCfgList = lua_role_badge_group.configList

	local goHero = self:getResInst(ShowCharacterCardItem.prefabPath, self._goHeroNode)

	self.showComp = MonoHelper.addNoUpdateLuaComOnceToGo(goHero, ShowCharacterCardItem)

	self.showComp:setShowParam(true, true)
	self.showComp:setActiveAnimator(false)
end

function AssistRoleBadgeView:onOpen()
	self.addEventCb(self, AssistController.instance, AssistEvent.UpdateBadgeInfo, self.onBadgeInfoUpdate, self)
	self.addEventCb(self, AssistController.instance, AssistEvent.UpdateWearBadges, self.refreshWear, self)

	self.curMo = self.viewParam
	self.curIndex = CharacterBackpackCardListModel.instance:getIndex(self.curMo)

	self:refreshBntStatus()
	self:refreshInfo()
end

function AssistRoleBadgeView:onDestroyView()
	TaskDispatcher.cancelTask(self.delaySwitch, self)
	self:clearNewTag()
end

function AssistRoleBadgeView:refreshBntStatus()
	gohelper.setActive(self._btnLeft, self.curIndex > 1)
	gohelper.setActive(self._btnRight, self.curIndex < self.maxCount)
end

function AssistRoleBadgeView:refreshInfo()
	self.showComp:onUpdateMO(self.curMo)

	for k, groupCfg in pairs(self.groupCfgList) do
		local badgeItem = self.badgeItemList[k]

		if not badgeItem then
			local go = gohelper.cloneInPlace(self._goBadgeItem)

			badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AssistRoleBadgeItem)
			self.badgeItemList[k] = badgeItem
		end

		badgeItem:setData(self.curMo.uid, groupCfg.id)
		gohelper.setActive(badgeItem.go, true)
	end

	for i = #self.groupCfgList + 1, #self.badgeItemList do
		gohelper.setActive(self.badgeItemList[i].go, false)
	end

	local roleBadgeInfoMo = RoleBadgeModel.instance:getBadgeInfo()

	self.recordMo = roleBadgeInfoMo and roleBadgeInfoMo:getRecordMo(self.curMo.uid)

	self:refreshWear()
end

function AssistRoleBadgeView:refreshWear()
	self._txtWearCnt.text = self.recordMo and self.recordMo:getWearCnt() or 0
end

function AssistRoleBadgeView:onBadgeInfoUpdate()
	self:refreshInfo()
end

function AssistRoleBadgeView:clearNewTag()
	if self.recordMo then
		self.recordMo:clearNewTag()
	end
end

return AssistRoleBadgeView
