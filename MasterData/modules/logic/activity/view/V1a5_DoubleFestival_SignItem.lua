-- chunkname: @modules/logic/activity/view/V1a5_DoubleFestival_SignItem.lua

module("modules.logic.activity.view.V1a5_DoubleFestival_SignItem", package.seeall)

local V1a5_DoubleFestival_SignItem = class("V1a5_DoubleFestival_SignItem", Activity101SignViewItemBase)

function V1a5_DoubleFestival_SignItem:onInitView()
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/#go_NormalBG")
	self._goSelectedBG = gohelper.findChild(self.viewGO, "Root/#go_SelectedBG")
	self._goFinishedImg = gohelper.findChild(self.viewGO, "Root/#go_FinishedImg")
	self._txtDay = gohelper.findChildText(self.viewGO, "Root/#txt_Day")
	self._txtDayEn = gohelper.findChildText(self.viewGO, "Root/#txt_DayEn")
	self._goTomorrowTag = gohelper.findChild(self.viewGO, "Root/#go_TomorrowTag")
	self._goitem1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2")
	self._goIcon1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon1")
	self._goIcon2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon2")
	self._txtName = gohelper.findChildText(self.viewGO, "Root/#txt_Name")
	self._goFinishedBG = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG")
	self._goTick1 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	self._goTick2 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	self._txtWish = gohelper.findChildText(self.viewGO, "Root/#go_FinishedBG/#txt_Wish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a5_DoubleFestival_SignItem:addEvents()
	return
end

function V1a5_DoubleFestival_SignItem:removeEvents()
	return
end

local sf = string.format
local splitToNumber = string.splitToNumber
local split = string.split

function V1a5_DoubleFestival_SignItem:_editableInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._itemClick = gohelper.getClickWithAudio(self._goSelectedBG)
	self._itemClick2 = gohelper.getClickWithAudio(self._goNormalBG)
	self._itemClickBless = gohelper.getClickWithAudio(self._txtWish.gameObject)
	self._itemList = {}
	self._item = IconMgr.instance:getCommonPropItemIcon(self._goitem1)
	self._kelinqu = gohelper.findChild(self.viewGO, "Root/#go_SelectedBG/kelinqu")
	self._txtWish.text = ""
end

function V1a5_DoubleFestival_SignItem:_editableAddEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
	self._itemClick2:AddClickListener(self._onItemClick, self)
	self._itemClickBless:AddClickListener(self._onClickBless, self)
end

function V1a5_DoubleFestival_SignItem:_editableRemoveEvents()
	self._itemClick:RemoveClickListener()
	self._itemClick2:RemoveClickListener()
	self._itemClickBless:RemoveClickListener()
end

function V1a5_DoubleFestival_SignItem:onRefresh()
	local actId = self._mo.data[1]
	local index = self._index
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(actId, index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)
	local co = ActivityConfig.instance:getNorSignActivityCo(actId, index)
	local rewards = split(co.bonus, "|")
	local rewardCount = #rewards
	local isShowOneReward = rewardCount == 1

	gohelper.setActive(self._goitem1, isShowOneReward)
	gohelper.setActive(self._goTick1, isShowOneReward)
	gohelper.setActive(self._kelinqu, isShowOneReward)
	gohelper.setActive(self._goitem2, not isShowOneReward)
	gohelper.setActive(self._goTick2, not isShowOneReward)

	self._txtName.text = ""

	if isShowOneReward then
		local itemCo = splitToNumber(rewards[1], "#")

		self:_refreshRewardItem(self._item, itemCo)

		local itemConfig = ItemModel.instance:getItemConfig(itemCo[1], itemCo[2])

		self._txtName.text = itemConfig.name
	else
		for i = 1, rewardCount do
			local itemCo = splitToNumber(rewards[i], "#")
			local item = self._itemList[i]

			if not item then
				item = IconMgr.instance:getCommonPropItemIcon(self["_goIcon" .. i])

				table.insert(self._itemList, item)
			end

			self:_refreshRewardItem(item, itemCo)
		end
	end

	if index < 10 then
		self._txtDay.text = "0" .. index or index
	end

	self._txtDayEn.text = sf("DAY\n%s", GameUtil.getEnglishNumber(index))

	gohelper.setActive(self._goSelectedBG, couldGet)
	gohelper.setActive(self._goTomorrowTag, index == totalday + 1)
	gohelper.setActive(self._goFinishedBG, rewardGet)
	gohelper.setActive(self._goFinishedImg, rewardGet)

	local doubleFestivalCO = ActivityType101Config.instance:getDoubleFestivalCOByDay(actId, index)

	if doubleFestivalCO then
		self._txtWish.text = doubleFestivalCO.btnDesc
	end
end

function V1a5_DoubleFestival_SignItem:_refreshRewardItem(item, itemCo)
	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setCountFontSize(46)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:customOnClickCallback(function()
		local actId = self._mo.data[1]
		local index = self._index
		local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

		if couldGet then
			ActivityType101Model.instance:setCurIndex(index)
			Activity101Rpc.instance:sendGet101BonusRequest(actId, index)

			return
		end

		MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
	end)
end

function V1a5_DoubleFestival_SignItem:_onClickBless()
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_feedback_open)

	local index = self._index

	ViewMgr.instance:openView(ViewName.V1a5_DoubleFestival_WishPanel, {
		day = index
	})
end

function V1a5_DoubleFestival_SignItem:_onItemClick()
	local actId = self._mo.data[1]
	local index = self._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)

	if couldGet then
		ActivityType101Model.instance:setCurIndex(index)
		Activity101Rpc.instance:sendGet101BonusRequest(actId, index)
	end

	if totalday < index then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

return V1a5_DoubleFestival_SignItem
