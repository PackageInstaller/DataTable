-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsTaskItem.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskItem", package.seeall)

local SportsNewsTaskItem = class("SportsNewsTaskItem", LuaCompBase)

function SportsNewsTaskItem:onInitView()
	self._simagenormalbg = gohelper.findChildSingleImage(self.go, "#simage_normalbg")
	self._txtprogress = gohelper.findChildText(self.go, "progress/#txt_num")
	self._txtmaxprogress = gohelper.findChildText(self.go, "progress/#txt_num/#txt_total")
	self._scrolltaskdes = gohelper.findChildScrollRect(self.go, "#scroll_taskdes")
	self._txttaskdes = gohelper.findChildText(self.go, "#scroll_taskdes/Viewport/#txt_taskdes")
	self._scrollrewards = gohelper.findChildScrollRect(self.go, "#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.go, "#scroll_rewards/Viewport/content/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.go, "#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.go, "#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.go, "#go_allfinish")
	self._anim = self.go:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function SportsNewsTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

function SportsNewsTaskItem:initData(index, go, view)
	self._index = index
	self.go = go
	self.view = view

	self:onInitView()
	self:addEvents()
	gohelper.setActive(self.go, false)
end

function SportsNewsTaskItem:onDestroy()
	UIBlockMgr.instance:endBlock(SportsNewsTaskItem.BLOCK_KEY)
	self:removeEvents()
	self:onDestroyView()
end

function SportsNewsTaskItem:onClose()
	TaskDispatcher.cancelTask(self.onFinishAnimCompleted, self)
end

function SportsNewsTaskItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.go)
	self._iconList = {}
end

function SportsNewsTaskItem:onDestroyView()
	for _, v in pairs(self._iconList) do
		gohelper.setActive(v.go, true)
		gohelper.destroy(v.go)
	end

	self._iconList = nil
end

function SportsNewsTaskItem:onUpdateMO(mo)
	self._mo = mo

	self:_playAnim(UIAnimationName.Idle, 0, 0)
	self:refreshInfo()
	self:refreshAllRewardIcons()
end

function SportsNewsTaskItem:refreshInfo()
	local cfg = self._mo.config

	self._txttaskdes.text = cfg.desc
	self._txtprogress.text = tostring(self._mo:getProgress())
	self._txtmaxprogress.text = tostring(cfg.maxProgress)

	if self._mo:isLock() then
		gohelper.setActive(self._btnnotfinishbg.gameObject, true)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._goallfinish, false)
	else
		self:refreshButtonRunning()
	end

	self._scrolltaskdes.horizontalNormalizedPosition = 0
end

function SportsNewsTaskItem:refreshButtonRunning()
	if self._mo:alreadyGotReward() then
		self:refreshWhenFinished()
	else
		local _isFinished = self._mo:isFinished()

		gohelper.setActive(self._btnnotfinishbg.gameObject, not _isFinished)
		gohelper.setActive(self._btnfinishbg.gameObject, _isFinished)
		gohelper.setActive(self._goallfinish, false)
	end
end

function SportsNewsTaskItem:refreshWhenFinished()
	gohelper.setActive(self._btnnotfinishbg.gameObject, false)
	gohelper.setActive(self._btnfinishbg.gameObject, false)
	gohelper.setActive(self._goallfinish, true)
end

function SportsNewsTaskItem:refreshAllRewardIcons()
	self:hideAllRewardIcon()

	local bonusList = string.split(self._mo.config.bonus, "|")

	for i = 1, #bonusList do
		local item = self:getOrCreateIcon(i)

		gohelper.setActive(item.go, true)

		local bonusArr = string.splitToNumber(bonusList[i], "#")

		item.itemIcon:setMOValue(bonusArr[1], bonusArr[2], bonusArr[3], nil, true)
		item.itemIcon:isShowCount(bonusArr[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)

		if bonusArr[1] == 9 and item.itemIcon and item.itemIcon._equipIcon and item.itemIcon._equipIcon.viewGO then
			local bg = gohelper.findChildImage(item.itemIcon._equipIcon.viewGO, "bg")

			if bg then
				UISpriteSetMgr.instance:setCommonSprite(bg, "bgequip3")
			end
		end
	end

	self._scrollrewards.horizontalNormalizedPosition = 0
end

function SportsNewsTaskItem:getOrCreateIcon(index)
	local item = self._iconList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(item.go, true)

		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.go)
		self._iconList[index] = item
	end

	return item
end

function SportsNewsTaskItem:hideAllRewardIcon()
	for _, iconItem in pairs(self._iconList) do
		gohelper.setActive(iconItem.go, false)
	end
end

function SportsNewsTaskItem:_btnnotfinishbgOnClick()
	local order = ActivityWarmUpModel.instance:getOrderMo(self._mo.config.orderid)

	if order and order.cfg.jumpId ~= 0 then
		SportsNewsController.instance:jumpToFinishTask(order, self.jumpCallback, self)
	else
		local day = self._mo.config.openDay

		ActivityWarmUpController.instance:switchTab(day)
		ActivityWarmUpTaskController.instance:dispatchEvent(ActivityWarmUpEvent.TaskListNeedClose)
	end
end

function SportsNewsTaskItem:jumpCallback()
	return
end

SportsNewsTaskItem.BLOCK_KEY = "ActivityWarmUpTaskItemBlock"

function SportsNewsTaskItem:_btnfinishbgOnClick()
	self:refreshWhenFinished()
	self:_playAnim(UIAnimationName.Finish, 0, 0)
	UIBlockMgr.instance:startBlock(SportsNewsTaskItem.BLOCK_KEY)
	TaskDispatcher.runDelay(self.onFinishAnimCompleted, self, 0.4)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function SportsNewsTaskItem:onFinishAnimCompleted()
	UIBlockMgr.instance:endBlock(SportsNewsTaskItem.BLOCK_KEY)
	gohelper.setActive(self._goclick, true)
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function SportsNewsTaskItem:getOrderCo(id)
	return (Activity106Config.instance:getActivityWarmUpOrderCo(VersionActivity1_5Enum.ActivityId.SportsNews, id))
end

function SportsNewsTaskItem:_playOpenInner()
	gohelper.setActive(self.go, true)
	self:_playAnim(UIAnimationName.Open, 0, 0)
end

function SportsNewsTaskItem:_playAnim(animName, ...)
	if self._anim then
		self._anim:Play(animName, ...)
	end
end

return SportsNewsTaskItem
