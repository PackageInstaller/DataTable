-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryItem", package.seeall)

local RoleStoryItem = class("RoleStoryItem", ListScrollCellExtend)

function RoleStoryItem:onInitView()
	self.root = gohelper.findChild(self.viewGO, "Root")
	self.mainAnim = self.root:GetComponent(typeof(UnityEngine.Animator))
	self.btnClick = gohelper.findButtonWithAudio(self.root)
	self.simagePhoto = gohelper.findChildSingleImage(self.root, "#simage_Photo")
	self.goNewTag = gohelper.findChild(self.root, "#image_NewTag")
	self.txtName = gohelper.findChildTextMesh(self.root, "Name/image_NameBG/#txt_Name")
	self.slider = gohelper.findChildSlider(self.root, "Info/Slider")
	self.txtScheduleNum = gohelper.findChildTextMesh(self.root, "Info/#txt_ScheduleNum")
	self.btnReward = gohelper.findChildButtonWithAudio(self.root, "Info/btnReward")
	self.imgReward = gohelper.findChildImage(self.root, "Info/btnReward/#image_Reward")
	self.aniReward = self.imgReward.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self.goCanGet = gohelper.findChild(self.root, "#go_CanGet")
	self.goCompleted = gohelper.findChild(self.root, "#go_Completed")
	self.completedAnim = self.goCompleted:GetComponent(typeof(UnityEngine.Animator))
	self.txtState = gohelper.findChildTextMesh(self.root, "Info/#txt_State")
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

function RoleStoryItem:addEvents()
	self.btnReward:AddClickListener(self.onClickReward, self)
	self.btnClick:AddClickListener(self.onClickItem, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.UnlockStory, self._onUnlockStory, self)
end

function RoleStoryItem:removeEvents()
	self.btnReward:RemoveClickListener()
	self.btnClick:RemoveClickListener()
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.UnlockStory, self._onUnlockStory, self)
end

function RoleStoryItem:_editableInitView()
	return
end

function RoleStoryItem:_onUnlockStory(storyId)
	if not self._mo or self._mo.id ~= storyId then
		return
	end

	self:refreshItem()
end

function RoleStoryItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshItem()
	RoleStoryModel.instance:setStoryNewTag(mo.id, false)
end

function RoleStoryItem:refreshItem()
	if not self._mo then
		return
	end

	gohelper.setActive(self.goNewTag, RoleStoryModel.instance:isNewStory(self._mo.id))
	self:refreshPhoto()
	self:refreshName()
	self:refreshProgress()
	self:refreshState()
	self:refreshRedDot()
end

function RoleStoryItem:refreshPhoto()
	local photo = self._mo.cfg.photo

	self.simagePhoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(photo))
end

function RoleStoryItem:refreshName()
	self.txtName.text = self._mo.cfg.heroName
end

function RoleStoryItem:refreshImageReward(state)
	gohelper.setActive(self.goCanGet, state ~= 1)
	gohelper.setActive(self.goCompleted, state ~= 1)

	if state ~= 1 then
		if state == 2 and RoleStoryModel.instance:isFinishTweenUnplay(self._mo.id) then
			self.completedAnim:Play("open", 0, 0)
		else
			self.completedAnim:Play("idle")
		end
	end

	UISpriteSetMgr.instance:setUiFBSprite(self.imgReward, string.format("rolestory_rewardbtn%s", state), true)

	if state == 2 then
		self.aniReward:Play("loop")
	else
		self.aniReward:Play("idle")
	end
end

function RoleStoryItem:refreshTxtState(state)
	self.txtState.text = luaLang(string.format("rolestoryrewardstate_%s", state))
end

function RoleStoryItem:refreshProgress()
	self.txtScheduleNum.text = self._mo.progress >= self._mo.maxProgress and string.format("<color=#cc5b17>%s/%s</color>", self._mo.progress, self._mo.maxProgress) or string.format("%s/<color=#cc5b17>%s</color>", self._mo.progress, self._mo.maxProgress)

	local max = math.max(self._mo.maxProgress, 1)

	self.slider:SetValue(self._mo.progress / max)
end

function RoleStoryItem:refreshState()
	if not self._mo.hasUnlock then
		self:refreshImageReward(1)
		self:refreshTxtState(1)
		self:refreshUnlock(false)

		return
	end

	self:refreshUnlock(true)

	if self._mo.getReward then
		self:refreshImageReward(3)
		self:refreshTxtState(3)

		return
	end

	self:refreshTxtState(2)

	if self._mo.progress >= self._mo.maxProgress then
		self:refreshImageReward(2)

		return
	end

	self:refreshImageReward(1)
end

function RoleStoryItem:refreshUnlock(isUnlock)
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

function RoleStoryItem:onClickReward()
	if not self._mo then
		return
	end

	if self._mo.progress < self._mo.maxProgress or self._mo.getReward then
		self:showReward()

		return
	end

	HeroStoryRpc.instance:sendGetHeroStoryBonusRequest(self._mo.id)
end

function RoleStoryItem:onClickItem()
	if not self._mo then
		return
	end

	if self._mo.hasUnlock then
		RoleStoryController.instance:enterRoleStoryChapter(self._mo.id)
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

function RoleStoryItem:_unlockCallback()
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

function RoleStoryItem:refreshRedDot()
	gohelper.setActive(self.goRedDot, (self._mo and not self._mo.getReward and self._mo.progress >= self._mo.maxProgress or nil) and true)
end

function RoleStoryItem:showReward()
	local x, y, z = transformhelper.getPos(self.goRewardPanel.transform)

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.OnClickRoleStoryReward, self._mo, x, y, z)
end

function RoleStoryItem:onDestroyView()
	if self.simagePhoto then
		self.simagePhoto:UnLoadImage()

		self.simagePhoto = nil
	end
end

return RoleStoryItem
