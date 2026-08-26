-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryActivityItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryActivityItem", package.seeall)

local RoleStoryActivityItem = class("RoleStoryActivityItem", ListScrollCellExtend)

function RoleStoryActivityItem:onInitView()
	self.root = gohelper.findChild(self.viewGO, "Root")
	self.mainAnim = self.root:GetComponent(typeof(UnityEngine.Animator))
	self.btnClick = gohelper.findButtonWithAudio(self.root)
	self.simagePhoto = gohelper.findChildSingleImage(self.root, "mask/#simage_Photo")
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
	self.goRewardPanel = gohelper.findChild(self.root, "Info/#go_RewardPanel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryActivityItem:addEvents()
	self.btnReward:AddClickListener(self.onClickReward, self)
	self.btnClick:AddClickListener(self.onClickItem, self)
end

function RoleStoryActivityItem:removeEvents()
	self.btnReward:RemoveClickListener()
	self.btnClick:RemoveClickListener()
end

function RoleStoryActivityItem:_editableInitView()
	return
end

function RoleStoryActivityItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self.goNewTag, RoleStoryModel.instance:isNewStory(mo.id))
	self:refreshPhoto()
	self:refreshName()
	self:refreshProgress()
	self:refreshState()
	self:refreshRedDot()
	RoleStoryModel.instance:setStoryNewTag(mo.id, false)
end

function RoleStoryActivityItem:refreshPhoto()
	local photo = self._mo.cfg.photo

	self.simagePhoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(photo))
end

function RoleStoryActivityItem:refreshName()
	local name = self._mo.cfg.heroName

	self.txtName.text = GameUtil.setFirstStrSize(name, 70)
end

function RoleStoryActivityItem:refreshImageReward(state)
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

function RoleStoryActivityItem:refreshTxtState(state)
	self.txtState.text = luaLang(string.format("rolestoryrewardstate_%s", state))
end

function RoleStoryActivityItem:refreshProgress()
	self.txtScheduleNum.text = self._mo.progress >= self._mo.maxProgress and string.format("<color=#cc5b17>%s/%s</color>", self._mo.progress, self._mo.maxProgress) or string.format("%s/<color=#cc5b17>%s</color>", self._mo.progress, self._mo.maxProgress)

	local max = math.max(self._mo.maxProgress, 1)

	self.slider:SetValue(self._mo.progress / max)
end

function RoleStoryActivityItem:refreshState()
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

function RoleStoryActivityItem:refreshUnlock(isUnlock)
	gohelper.setActive(self.goLock, not isUnlock)

	if not isUnlock then
		local type = self._mo.costItemType
		local id = self._mo.costItemId
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(id)
		local currencyname = string.format("%s_1", currencyCo and currencyCo.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imgPropItem, currencyname)

		local quantity = ItemModel.instance:getItemQuantity(type, id)
		local count = self._mo.costItemCount

		self.txtPropNum.text = quantity < count and string.format(string.format("<color=#d97373>%s</color>/%s", quantity, count)) or string.format(string.format("%s/%s", quantity, count))
	end

	if isUnlock and RoleStoryModel.instance:isUnlockingStory(self._mo.id) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		self.mainAnim:Play("unlock")
	elseif not self._isOpen then
		self._isOpen = true

		self.mainAnim:Play("open")
	else
		self.mainAnim:Play("idle")
	end
end

function RoleStoryActivityItem:onClickReward()
	if not self._mo then
		return
	end

	if self._mo.progress < self._mo.maxProgress or self._mo.getReward then
		self:showReward()

		return
	end

	HeroStoryRpc.instance:sendGetHeroStoryBonusRequest(self._mo.id)
end

function RoleStoryActivityItem:onClickItem()
	if not self._mo then
		return
	end

	if self._mo.hasUnlock then
		RoleStoryController.instance:enterRoleStoryChapter(self._mo.id)
	else
		local count = self._mo.costItemCount
		local name = self._mo.cfg.heroName
		local itemCo = ItemModel.instance:getItemConfig(self._mo.costItemType, self._mo.costItemId)
		local itemName = itemCo and itemCo.name

		GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryUnlockTips, MsgBoxEnum.BoxType.Yes_No, self._unlockCallback, nil, nil, self, nil, nil, count, itemName, name)
	end
end

function RoleStoryActivityItem:_unlockCallback()
	if not self._mo or self._mo.hasUnlock then
		return
	end

	local items = {}

	table.insert(items, {
		type = self._mo.costItemType,
		id = self._mo.costItemId,
		quantity = self._mo.costItemCount
	})

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

		return
	end

	HeroStoryRpc.instance:sendUnlocHeroStoryRequest(self._mo.id)
end

function RoleStoryActivityItem:refreshRedDot()
	gohelper.setActive(self.goRedDot, (self._mo and not self._mo.getReward and self._mo.progress >= self._mo.maxProgress or nil) and true)
end

function RoleStoryActivityItem:showReward()
	local x, y, z = transformhelper.getPos(self.goRewardPanel.transform)

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.OnClickRoleStoryReward, self._mo, x, y, z)
end

function RoleStoryActivityItem:onDestroyView()
	if self.simagePhoto then
		self.simagePhoto:UnLoadImage()

		self.simagePhoto = nil
	end
end

return RoleStoryActivityItem
