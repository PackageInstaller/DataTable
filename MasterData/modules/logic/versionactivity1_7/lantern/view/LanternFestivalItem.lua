-- chunkname: @modules/logic/versionactivity1_7/lantern/view/LanternFestivalItem.lua

module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalItem", package.seeall)

local LanternFestivalItem = class("LanternFestivalItem", ListScrollCell)

function LanternFestivalItem:init(go, index, puzzleId)
	self.viewGO = go
	self._index = index
	self._puzzleId = puzzleId
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/#go_NormalBG")
	self._goSelectedBG = gohelper.findChild(self.viewGO, "Root/#go_SelectedBG")
	self._txtDay = gohelper.findChildText(self.viewGO, "Root/#txt_Day")
	self._txtDayEn = gohelper.findChildText(self.viewGO, "Root/#txt_DayEn")
	self._goFinishedImg = gohelper.findChild(self.viewGO, "Root/#go_FinishedImg")
	self._goTomorrowTag = gohelper.findChild(self.viewGO, "Root/#go_TomorrowTag")
	self._goitem1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2")
	self._goIcon1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon1")
	self._goIcon2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon2")
	self._txtName = gohelper.findChildText(self.viewGO, "Root/#txt_Name")
	self._goFinishedBG = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG")
	self._goTick1 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	self._goTick2 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._itemClick = gohelper.getClickWithAudio(self._goSelectedBG)
	self._itemClick1 = gohelper.getClickWithAudio(self._goFinishedImg)
	self._itemClick2 = gohelper.getClickWithAudio(self._goNormalBG)
	self._itemAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self._playOpen, self, 0.03 * self._index)

	self._itemList = {}
	self._item = IconMgr.instance:getCommonPropItemIcon(self._goitem1)

	self:_editableAddEvents()
	self:refresh(index, puzzleId)
end

function LanternFestivalItem:_playOpen()
	gohelper.setActive(self.viewGO, true)
	self._itemAnimator:Play("open", 0, 0)
end

function LanternFestivalItem:_editableAddEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
	self._itemClick1:AddClickListener(self._onItemClick, self)
	self._itemClick2:AddClickListener(self._onItemClick, self)
end

function LanternFestivalItem:_editableRemoveEvents()
	self._itemClick:RemoveClickListener()
	self._itemClick1:RemoveClickListener()
	self._itemClick2:RemoveClickListener()
end

function LanternFestivalItem:_onItemClick()
	local isLock = not LanternFestivalModel.instance:isPuzzleUnlock(self._puzzleId)

	if isLock then
		return
	end

	local data = {}

	data.puzzleId = self._puzzleId
	data.day = self._index

	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.SelectPuzzleItem)
	LanternFestivalController.instance:openQuestionTipView(data)
end

function LanternFestivalItem:refresh(index, puzzleId)
	self._index = index
	self._puzzleId = puzzleId

	local rewardGet = LanternFestivalModel.instance:isPuzzleGiftGet(self._puzzleId)

	gohelper.setActive(self._goFinishedImg, rewardGet)

	local couldGet = not rewardGet and LanternFestivalModel.instance:isPuzzleUnlock(self._puzzleId)
	local totalday = LanternFestivalModel.instance:getLoginCount()
	local actId = ActivityEnum.Activity.LanternFestival
	local co = LanternFestivalConfig.instance:getAct154Co(actId, index)
	local rewards = string.split(co.bonus, "|")
	local rewardCount = #rewards
	local isShowOneReward = rewardCount == 1

	gohelper.setActive(self._goitem1, isShowOneReward)
	gohelper.setActive(self._goTick1, isShowOneReward)
	gohelper.setActive(self._goitem2, not isShowOneReward)
	gohelper.setActive(self._goTick2, not isShowOneReward)

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

	self._txtDay.text = string.format("%02d", index)
	self._txtDayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(index))

	gohelper.setActive(self._goSelectedBG, couldGet)
	gohelper.setActive(self._goTomorrowTag, index == totalday + 1)
	gohelper.setActive(self._goFinishedBG, rewardGet)
end

function LanternFestivalItem:_refreshRewardItem(item, itemCo)
	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setCountFontSize(46)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:customOnClickCallback(function()
		local rewardGet = LanternFestivalModel.instance:isPuzzleGiftGet(self._puzzleId)
		local couldGet = not rewardGet and LanternFestivalModel.instance:isPuzzleUnlock(self._puzzleId)

		if couldGet then
			self:_onItemClick()

			return
		end

		MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
	end)
end

function LanternFestivalItem:destroy()
	TaskDispatcher.cancelTask(self._playOpen, self)
	self:_editableRemoveEvents()
end

return LanternFestivalItem
