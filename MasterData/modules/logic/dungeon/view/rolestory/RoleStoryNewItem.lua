-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryNewItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryNewItem", package.seeall)

local RoleStoryNewItem = class("RoleStoryNewItem", ListScrollCellExtend)

function RoleStoryNewItem:onInitView()
	self.root = gohelper.findChild(self.viewGO, "Root")
	self.mainAnim = self.root:GetComponent(typeof(UnityEngine.Animator))
	self.btnClick = gohelper.findButtonWithAudio(self.root)
	self.simagePhoto = gohelper.findChildSingleImage(self.root, "#simage_Photo")
	self.goNewTag = gohelper.findChild(self.root, "#image_NewTag")
	self.simageSignature = gohelper.findChildSingleImage(self.root, "Name/#simage_signature")
	self.txtName = gohelper.findChildTextMesh(self.root, "Name/image_NameBG/#txt_Name")
	self.txtScheduleNum = gohelper.findChildTextMesh(self.root, "Info/#txt_ScheduleNum")
	self.btnReward = gohelper.findChildButtonWithAudio(self.root, "Info/btnReward")
	self.goRewardNormal = gohelper.findChild(self.root, "Info/btnReward/go_normal")
	self.goRewardCanget = gohelper.findChild(self.root, "Info/btnReward/go_canget")
	self.goRewardHasget = gohelper.findChild(self.root, "Info/btnReward/go_hasget")
	self.goCanGet = gohelper.findChild(self.root, "#go_CanGet")
	self.goCompleted = gohelper.findChild(self.root, "#go_Completed")
	self.completedAnim = self.goCompleted:GetComponent(typeof(UnityEngine.Animator))
	self.goLock = gohelper.findChild(self.root, "#go_Locked")
	self.imgPropItem = gohelper.findChildImage(self.root, "#go_Locked/image_LockedTextBG/#image_PropItem")
	self.txtPropNum = gohelper.findChildTextMesh(self.root, "#go_Locked/image_LockedTextBG/#txt_PropNum")
	self.goRedDot = gohelper.findChild(self.root, "Info/#go_Reddot")
	self.txtLocked = gohelper.findChildTextMesh(self.root, "#go_Locked/image_LockedBG/txt_Locked")
	self.txtLockedEn = gohelper.findChildTextMesh(self.root, "#go_Locked/image_LockedBG/txt_LockedEn")
	self.goRewardPanel = gohelper.findChild(self.root, "Info/#go_RewardPanel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryNewItem:addEvents()
	self.btnReward:AddClickListener(self.onClickReward, self)
	self.btnClick:AddClickListener(self.onClickItem, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.updateTask, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.UnlockStory, self._onUnlockStory, self)
end

function RoleStoryNewItem:removeEvents()
	self.btnReward:RemoveClickListener()
	self.btnClick:RemoveClickListener()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.updateTask, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.UnlockStory, self._onUnlockStory, self)
end

function RoleStoryNewItem:_editableInitView()
	return
end

function RoleStoryNewItem:_onUnlockStory(storyId)
	if not self._mo or self._mo.id ~= storyId then
		return
	end

	self:refreshItem()
end

function RoleStoryNewItem:updateTask()
	self:refreshItem()
end

function RoleStoryNewItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshItem()
	RoleStoryModel.instance:setStoryNewTag(mo.id, false)
end

function RoleStoryNewItem:refreshItem()
	if not self._mo then
		return
	end

	self.state = 1

	local list = NecrologistStoryTaskListModel.instance:getTaskList(self._mo.id)
	local maxProgress = #list
	local progress = 0

	for _, v in ipairs(list) do
		if v:isClaimed() then
			progress = progress + 1
		end

		if v:isClaimable() then
			self.state = 2
		end
	end

	if maxProgress <= progress then
		self.state = 3
	end

	self.progress = progress
	self.maxProgress = maxProgress

	gohelper.setActive(self.goNewTag, RoleStoryModel.instance:isNewStory(self._mo.id))
	self:refreshPhoto()
	self:refreshName()
	self:refreshProgress()
	self:refreshState()
	self:refreshRedDot()
end

function RoleStoryNewItem:refreshPhoto()
	local photo = self._mo.cfg.photo

	self.simagePhoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(photo))
end

function RoleStoryNewItem:refreshName()
	self.txtName.text = self._mo.cfg.heroName

	self.simageSignature:LoadImage(ResUrl.getSignature(self._mo.cfg.signature))
end

function RoleStoryNewItem:refreshImageReward(state)
	gohelper.setActive(self.goCanGet, state ~= 1)
	gohelper.setActive(self.goCompleted, state ~= 1)

	if state ~= 1 then
		if state == 2 and RoleStoryModel.instance:isFinishTweenUnplay(self._mo.id) then
			self.completedAnim:Play("open", 0, 0)
		else
			self.completedAnim:Play("idle")
		end
	end

	gohelper.setActive(self.goRewardNormal, state == 1)
	gohelper.setActive(self.goRewardCanget, state == 2)
	gohelper.setActive(self.goRewardHasget, state == 3)
end

function RoleStoryNewItem:refreshProgress()
	local progress = self.progress
	local maxProgress = self.maxProgress

	self.txtScheduleNum.text = maxProgress <= progress and string.format("<color=#cc5b17>%s/%s</color>", progress, maxProgress) or string.format("%s<color=#cc5b17>/%s</color>", progress, maxProgress)
end

function RoleStoryNewItem:refreshState()
	if not self._mo.hasUnlock then
		self:refreshImageReward(1)
		self:refreshUnlock(false)

		return
	end

	self:refreshUnlock(true)
	self:refreshImageReward(self.state)
end

function RoleStoryNewItem:refreshUnlock(isUnlock)
	gohelper.setActive(self.goLock, not isUnlock)

	if not isUnlock then
		local costType, costId, costCount = self._mo:getCost()
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(costId)
		local currencyname = string.format("%s_1", currencyCo and currencyCo.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imgPropItem, currencyname)

		local quantity = ItemModel.instance:getItemQuantity(costType, costId)
		local count = costCount
		local countStr = count == 0 and string.format("<color=#65b96f>%s</color>", count) or tostring(count)

		self.txtPropNum.text = quantity < count and string.format(string.format("<color=#d97373>%s</color>/%s", quantity, countStr)) or string.format(string.format("%s/%s", quantity, countStr))
		self.txtLocked.text = count == 0 and luaLang("first_time_free") or luaLang("unlock")
		self.txtLockedEn.text = count == 0 and "1st Time Free" or "UNLOCK"
	end

	if isUnlock and RoleStoryModel.instance:isUnlockingStory(self._mo.id) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		self.mainAnim:Play("unlock")
	elseif self._view.isFirst then
		self.mainAnim:Play("open")
	else
		self.mainAnim:Play("idle")
	end
end

function RoleStoryNewItem:onClickReward()
	if not self._mo then
		return
	end

	NecrologistStoryController.instance:openTaskView(self._mo.id)
end

function RoleStoryNewItem:onClickItem()
	if not self._mo then
		return
	end

	if self._mo.hasUnlock then
		NecrologistStoryController.instance:openGameView(self._mo.id)
	else
		local costType, costId, costCount = self._mo:getCost()

		if costCount > 0 then
			local name = self._mo.cfg.heroName
			local itemCo = ItemModel.instance:getItemConfig(costType, costId)
			local itemName = itemCo and itemCo.name

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryUnlockTips, MsgBoxEnum.BoxType.Yes_No, self._unlockCallback, nil, nil, self, nil, nil, costCount, itemName, name)
		else
			self:_unlockCallback()
		end
	end
end

function RoleStoryNewItem:_unlockCallback()
	if not self._mo or self._mo.hasUnlock then
		return
	end

	local costType, costId, costCount = self._mo:getCost()
	local items = {}

	table.insert(items, {
		type = costType,
		id = costId,
		quantity = costCount
	})

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

		return
	end

	HeroStoryRpc.instance:sendUnlocHeroStoryRequest(self._mo.id)
end

function RoleStoryNewItem:refreshRedDot()
	gohelper.setActive(self.goRedDot, (self._mo and not self._mo.getReward and self._mo.progress >= self._mo.maxProgress or nil) and true)
end

function RoleStoryNewItem:onDestroyView()
	self.simageSignature:UnLoadImage()

	if self.simagePhoto then
		self.simagePhoto:UnLoadImage()

		self.simagePhoto = nil
	end
end

return RoleStoryNewItem
