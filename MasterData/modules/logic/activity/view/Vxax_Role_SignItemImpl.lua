-- chunkname: @modules/logic/activity/view/Vxax_Role_SignItemImpl.lua

module("modules.logic.activity.view.Vxax_Role_SignItemImpl", package.seeall)

local Vxax_Role_SignItemImpl = class("Vxax_Role_SignItemImpl", Activity101SignViewItemBase)

function Vxax_Role_SignItemImpl:onInitView()
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/#go_NormalBG")
	self._goSelectedBG = gohelper.findChild(self.viewGO, "Root/#go_SelectedBG")
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Vxax_Role_SignItemImpl:addEvents()
	return
end

function Vxax_Role_SignItemImpl:removeEvents()
	return
end

local sf = string.format
local splitToNumber = string.splitToNumber
local split = string.split

function Vxax_Role_SignItemImpl:_editableInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._itemClick = gohelper.getClickWithAudio(self._goSelectedBG)
	self._itemClick2 = gohelper.getClickWithAudio(self._goNormalBG)
	self._itemList = {}
	self._item = IconMgr.instance:getCommonPropItemIcon(self._goitem1)
end

function Vxax_Role_SignItemImpl:_editableAddEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
	self._itemClick2:AddClickListener(self._onItemClick, self)
end

function Vxax_Role_SignItemImpl:_editableRemoveEvents()
	self._itemClick:RemoveClickListener()
	self._itemClick2:RemoveClickListener()
end

function Vxax_Role_SignItemImpl:onRefresh()
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
	gohelper.setActive(self._goitem2, not isShowOneReward)
	gohelper.setActive(self._goTick2, not isShowOneReward)

	self._txtName.text = ""

	for i = 1, rewardCount do
		local itemCo = splitToNumber(rewards[i], "#")
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

	if index < 10 then
		self._txtDay.text = "0" .. index or index
	end

	self._txtDayEn.text = sf("DAY\n%s", GameUtil.getEnglishNumber(index))

	gohelper.setActive(self._goSelectedBG, couldGet)
	gohelper.setActive(self._goTomorrowTag, index == totalday + 1)
	gohelper.setActive(self._goFinishedBG, rewardGet)
end

return Vxax_Role_SignItemImpl
