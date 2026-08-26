-- chunkname: @modules/logic/abyss/view/AbyssTaskItem.lua

module("modules.logic.abyss.view.AbyssTaskItem", package.seeall)

local AbyssTaskItem = class("AbyssTaskItem", ListScrollCellExtend)

function AbyssTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_bg")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_normal/#txt_index")
	self._scrollrewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._rewardscontent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._gonotget = gohelper.findChild(self.viewGO, "#go_normal/#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	self._goblackmask = gohelper.findChild(self.viewGO, "#go_normal/#go_blackmask")
	self._goget = gohelper.findChild(self.viewGO, "#go_normal/#go_get")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_normal/info/#txt_desc")
	self._imagestar = gohelper.findChildImage(self.viewGO, "#go_normal/info/progress/#image_star")
	self._gofullprogress = gohelper.findChild(self.viewGO, "#go_normal/progressbar/#go_fullprogress")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "#go_normal/progressbar/#image_progress")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btncollectall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/go_getall/#btn_collectall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btncollectall:AddClickListener(self._btncollectallOnClick, self)
end

function AbyssTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btncollectall:RemoveClickListener()
end

function AbyssTaskItem:_btncollectallOnClick()
	AbyssController.instance:dispatchEvent(AbyssEvent.OnGetTaskReward, self)

	local list = AbyssTaskListModel.instance:getCanGetList()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Abyss, nil, list)
end

function AbyssTaskItem:_btnnotfinishbgOnClick()
	return
end

function AbyssTaskItem:_btnfinishbgOnClick()
	AbyssController.instance:dispatchEvent(AbyssEvent.OnGetTaskReward, self)
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function AbyssTaskItem:_getAllTaskReward()
	AbyssController.instance:dispatchEvent(AbyssEvent.OnGetTaskReward, self)

	local _, _, list = AbyssTaskListModel.instance:getAllDeepTaskInfo()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Abyss, nil, list)
end

function AbyssTaskItem:playOutAnim()
	gohelper.setActive(self._goblackmask, true)
	self._animator:Play("out", 0, 0)
end

function AbyssTaskItem:_editableInitView()
	gohelper.setActive(self._imagestar.gameObject, false)

	self._rewardItems = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function AbyssTaskItem:getAnimator()
	return self._animator
end

function AbyssTaskItem:_editableAddEvents()
	gohelper.addUIClickAudio(self._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(self._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(self._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function AbyssTaskItem:_editableRemoveEvents()
	return
end

function AbyssTaskItem:onUpdateMO(mo)
	if mo.isDirtyData then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self._mo = mo

	gohelper.setActive(self._gonormal, not mo.isGetAll)
	gohelper.setActive(self._gogetall, mo.isGetAll)

	if mo.isGetAll then
		return
	end

	self._config = AbyssConfig.instance:getTaskConfig(mo.id)

	local index = AbyssConfig.instance:getTaskIndexById(self._config.activityId, self._config.id)

	gohelper.setActive(self._txtindex, index ~= nil)

	if index then
		self._txtindex.text = index < 10 and "0" .. tostring(index) or tostring(index)
	end

	self:_addRewards()
	self:_updateStatus()
	gohelper.setActive(self._txtdesc.gameObject, true)

	self._txtdesc.text = self._config.desc

	self:_initStars()
	self:_updateStars()

	self._scrollrewards.parentGameObject = self._view._csListScroll.gameObject
end

function AbyssTaskItem:_initStars()
	self._starList = self._starList or self:getUserDataTb_()

	local go = self._imagestar.gameObject
	local showStarCount = 1

	for i = #self._starList, showStarCount do
		local child = gohelper.cloneInPlace(go)

		gohelper.setActive(child, true)
		table.insert(self._starList, child:GetComponent(gohelper.Type_Image))
	end
end

function AbyssTaskItem:_updateStars()
	if not self._starList then
		return
	end

	local showStarCount = 1

	for i, v in ipairs(self._starList) do
		gohelper.setActive(v.gameObject, i <= showStarCount)
		UISpriteSetMgr.instance:setWeekWalkSprite(v, self._taskMo and self._taskMo.progress >= self._config.maxProgress and "star_highlight4" or "star_null4")
	end
end

function AbyssTaskItem:_updateStatus()
	self._taskMo = TaskModel.instance:getTaskById(self._mo.id)

	if self._taskMo then
		local isGet = self._taskMo.finishCount >= self._config.maxFinishCount

		gohelper.setActive(self._gonotget, not isGet)
		gohelper.setActive(self._goget, isGet)
		gohelper.setActive(self._goblackmask, isGet)

		if not isGet then
			if self._taskMo then
				local isFinish = self._taskMo.hasFinished

				gohelper.setActive(self._btnnotfinishbg.gameObject, not isFinish)
				gohelper.setActive(self._btnfinishbg.gameObject, isFinish)
			end
		end

		gohelper.setActive(self._gofullprogress, self._taskMo and self._taskMo.progress >= self._config.maxProgress)

		if self._taskMo then
			self._imageprogress.fillAmount = self._taskMo.progress / self._config.maxProgress or 0
		end

		local itemBgName = not isGet and self._taskMo and self._taskMo.hasFinished and "img_bg_claim_hl2.png" or "img_bg_claim_nor2.png"

		self._simagebg:LoadImage(ResUrl.getWeekWalkBg(itemBgName))
	end
end

function AbyssTaskItem:_addRewards()
	self._scrollrewards.horizontalNormalizedPosition = 0

	local rewards = string.split(self._mo.bonus, "|")

	for i = 1, #rewards do
		local item = self:_getItem(i)
		local itemCo = string.splitToNumber(rewards[i], "#")

		gohelper.setActive(item.parentGo, true)
		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._rewardItems do
		local item = self._rewardItems[i]

		if item then
			gohelper.setActive(item.parentGo, false)
		end
	end

	local itemwidth = recthelper.getWidth(self._gorewarditem.transform)
	local space = -13
	local contentwidth = (itemwidth + space) * #rewards

	recthelper.setWidth(self._rewardscontent.transform, contentwidth)
end

function AbyssTaskItem:_getItem(index)
	local item = self._rewardItems[index]

	if item then
		return item
	end

	item = self:getUserDataTb_()
	item.parentGo = gohelper.clone(self._gorewarditem, self._rewardscontent)
	item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.parentGo)
	self._rewardItems[index] = item

	return item
end

function AbyssTaskItem:onSelect(isSelect)
	return
end

function AbyssTaskItem:onDestroyView()
	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = nil

	self._simagebg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

return AbyssTaskItem
