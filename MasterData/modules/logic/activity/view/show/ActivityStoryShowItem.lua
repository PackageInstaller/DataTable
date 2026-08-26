-- chunkname: @modules/logic/activity/view/show/ActivityStoryShowItem.lua

module("modules.logic.activity.view.show.ActivityStoryShowItem", package.seeall)

local ActivityStoryShowItem = class("ActivityStoryShowItem", LuaCompBase)

function ActivityStoryShowItem:init(go, index, co)
	self.go = go
	self._index = index
	self._config = co
	self._txtdesc = gohelper.findChildText(self.go, "txt_taskdesc")
	self._goRewardContent = gohelper.findChild(self.go, "scroll_reward/Viewport/go_rewardContent")
	self._goRewardItem = gohelper.findChild(self.go, "scroll_reward/Viewport/go_rewardContent/go_rewarditem")
	self._goItemPos = gohelper.findChild(self.go, "scroll_reward/Viewport/go_rewardContent/go_rewarditem/itempos")
	self._goline = gohelper.findChild(self.go, "go_line")

	self:addEvents()
	self:_refreshItem()
end

ActivityStoryShowItem.ShowCount = 1

function ActivityStoryShowItem:addEvents()
	return
end

function ActivityStoryShowItem:removeEvents()
	return
end

function ActivityStoryShowItem:_refreshItem()
	self._txtdesc.text = self._config.taskDesc
	self._rewardItems = self:getUserDataTb_()

	local rewards = string.split(self._config.showBonus, "|")

	self._goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewards > 2

	for i = 1, #rewards do
		local item = self._rewardItems[i]

		if not item then
			item = self:getUserDataTb_()
			item.parentGo = gohelper.cloneInPlace(self._goRewardItem)
			item.itemPos = gohelper.findChild(item.parentGo, "itempos")
			item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.itemPos)

			table.insert(self._rewardItems, item)
		end

		gohelper.setActive(self._rewardItems[i].parentGo, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i].itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		self._rewardItems[i].itemIcon:isShowCount(itemCo[4] == ActivityStoryShowItem.ShowCount)
		self._rewardItems[i].itemIcon:setCountFontSize(56)
		self._rewardItems[i].itemIcon:setHideLvAndBreakFlag(true)
		self._rewardItems[i].itemIcon:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._rewardItems do
		gohelper.setActive(self._rewardItems[i].parentGo, false)
	end

	gohelper.setActive(self._goline, self._index ~= GameUtil.getTabLen(ActivityConfig.instance:getActivityShowTaskCount(ActivityEnum.Activity.StoryShow)))
end

function ActivityStoryShowItem:destroy()
	self:removeEvents()

	self._rewardItems = nil
end

return ActivityStoryShowItem
