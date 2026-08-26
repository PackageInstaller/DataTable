-- chunkname: @modules/logic/dragonboat/view/DragonBoatFestivalItem.lua

module("modules.logic.dragonboat.view.DragonBoatFestivalItem", package.seeall)

local DragonBoatFestivalItem = class("DragonBoatFestivalItem", ListScrollCell)

function DragonBoatFestivalItem:init(go, id)
	self.viewGO = go
	self._id = id
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/#go_NormalBG")
	self._goSelectedBG = gohelper.findChild(self.viewGO, "Root/#go_SelectedBG")
	self._txtDay = gohelper.findChildText(self.viewGO, "Root/#txt_Day")
	self._txtDayEn = gohelper.findChildText(self.viewGO, "Root/#txt_DayEn")
	self._goTomorrowTag = gohelper.findChild(self.viewGO, "Root/#go_TomorrowTag")
	self._goitem1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2")
	self._goIcon1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon1")
	self._goIcon2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon2")
	self._goFinishedBG = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG")
	self._goTick1 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	self._goTick2 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	self._goSelected = gohelper.findChild(self.viewGO, "Root/#go_Selected")
	self._txtName = gohelper.findChildText(self.viewGO, "Root/#txt_Name")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._itemClick = gohelper.getClickWithAudio(self._goSelectedBG)
	self._itemClick1 = gohelper.getClickWithAudio(self._goNormalBG)
	self._itemAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.viewGO, false)
	gohelper.setActive(self._goSelected, false)
	TaskDispatcher.runDelay(self._playOpen, self, 0.03 * self._id)

	self._itemList = {}
	self._item = IconMgr.instance:getCommonPropItemIcon(self._goitem1)

	self:_editableAddEvents()
	self:refresh(self._id)
end

function DragonBoatFestivalItem:_playOpen()
	gohelper.setActive(self.viewGO, true)
	self._itemAnimator:Play("open", 0, 0)
end

function DragonBoatFestivalItem:_editableAddEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
	self._itemClick1:AddClickListener(self._onItemClick, self)
	DragonBoatFestivalController.instance:registerCallback(DragonBoatFestivalEvent.SelectItem, self._onSelectItem, self)
	DragonBoatFestivalController.instance:registerCallback(DragonBoatFestivalEvent.ShowMapFinished, self._startGetReward, self)
end

function DragonBoatFestivalItem:_editableRemoveEvents()
	self._itemClick:RemoveClickListener()
	self._itemClick1:RemoveClickListener()
	DragonBoatFestivalController.instance:unregisterCallback(DragonBoatFestivalEvent.SelectItem, self._onSelectItem, self)
	DragonBoatFestivalController.instance:unregisterCallback(DragonBoatFestivalEvent.ShowMapFinished, self._startGetReward, self)
end

function DragonBoatFestivalItem:_onSelectItem()
	local curDay = DragonBoatFestivalModel.instance:getCurDay()

	gohelper.setActive(self._goSelected, curDay == self._id)
end

function DragonBoatFestivalItem:_onItemClick()
	if not DragonBoatFestivalModel.instance:isGiftUnlock(self._id) then
		return
	end

	local curDay = DragonBoatFestivalModel.instance:getCurDay()

	if DragonBoatFestivalModel.instance:isGiftGet(curDay) and curDay == self._id then
		return
	end

	if not DragonBoatFestivalModel.instance:isGiftGet(self._id) then
		DragonBoatFestivalModel.instance:setCurDay(self._id)
		self:_startGetReward()

		return
	end

	gohelper.setActive(self._goSelected, true)
	DragonBoatFestivalModel.instance:setCurDay(self._id)
	UIBlockMgrExtend.setNeedCircleMv(false)
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.SelectItem)
end

function DragonBoatFestivalItem:_startGetReward()
	local rewardGet = DragonBoatFestivalModel.instance:isGiftGet(self._id)
	local unlock = DragonBoatFestivalModel.instance:isGiftUnlock(self._id)

	if not rewardGet and unlock then
		local actId = ActivityEnum.Activity.DragonBoatFestival

		Activity101Rpc.instance:sendGet101BonusRequest(actId, self._id)
	end
end

function DragonBoatFestivalItem:refresh(id)
	self._id = id

	local actId = ActivityEnum.Activity.DragonBoatFestival
	local rewardGet = DragonBoatFestivalModel.instance:isGiftGet(self._id)
	local isUnlock = DragonBoatFestivalModel.instance:isGiftUnlock(self._id)
	local loginCount = DragonBoatFestivalModel.instance:getLoginCount()
	local curDay = DragonBoatFestivalModel.instance:getCurDay()
	local co = ActivityConfig.instance:getNorSignActivityCo(actId, self._id)
	local rewards = string.split(co.bonus, "|")
	local rewardCount = #rewards
	local isShowOneReward = rewardCount == 1

	self._txtName.text = ""

	for i = 1, rewardCount do
		local itemCo = string.splitToNumber(rewards[i], "#")
		local item = self._itemList[i]

		if not item then
			item = IconMgr.instance:getCommonPropItemIcon(self["_goIcon" .. i])

			table.insert(self._itemList, item)
		end

		self:_refreshRewardItem(item, itemCo)

		if i == 1 then
			self:_refreshRewardItem(self._item, itemCo)

			if isShowOneReward then
				local itemConfig = ItemModel.instance:getItemConfig(itemCo[1], itemCo[2])

				self._txtName.text = itemConfig.name
			end
		end
	end

	self._txtDay.text = string.format("%02d", self._id)
	self._txtDayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(self._id))

	gohelper.setActive(self._goitem1, isShowOneReward)
	gohelper.setActive(self._goTick1, isShowOneReward)
	gohelper.setActive(self._goitem2, not isShowOneReward)
	gohelper.setActive(self._goTick2, not isShowOneReward)
	gohelper.setActive(self._goSelectedBG, not rewardGet and isUnlock)
	gohelper.setActive(self._goTomorrowTag, self._id == loginCount + 1)
	gohelper.setActive(self._goFinishedBG, rewardGet)

	local maxUnlockDay = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local maxDayGet = DragonBoatFestivalModel.instance:isGiftGet(maxUnlockDay)

	if self._id == maxUnlockDay and not maxDayGet then
		gohelper.setActive(self._goSelected, self._goSelected.activeSelf)
	else
		gohelper.setActive(self._goSelected, self._id == curDay)
	end
end

function DragonBoatFestivalItem:_refreshRewardItem(item, itemCo)
	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setCountFontSize(46)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:customOnClickCallback(function()
		local rewardGet = DragonBoatFestivalModel.instance:isGiftGet(self._id)
		local couldGet = not rewardGet and DragonBoatFestivalModel.instance:isGiftUnlock(self._id)

		if couldGet then
			self:_onItemClick()

			return
		end

		MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
	end)
end

function DragonBoatFestivalItem:destroy()
	TaskDispatcher.cancelTask(self._playOpen, self)
	self:_editableRemoveEvents()
end

return DragonBoatFestivalItem
