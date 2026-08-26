-- chunkname: @modules/logic/versionactivity2_4/act181/view/Activity181RewardView.lua

module("modules.logic.versionactivity2_4.act181.view.Activity181RewardView", package.seeall)

local Activity181RewardView = class("Activity181RewardView", BaseView)

Activity181RewardView.DISPLAY_TYPE = {
	Reward = 2,
	Effect = 1
}

function Activity181RewardView:onInitView()
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity181RewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Activity181RewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity181RewardView:_btncloseOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)
	self:closeThis()
end

function Activity181RewardView:_editableInitView()
	self._rewardItemList = {}
end

function Activity181RewardView:onUpdateParam()
	return
end

function Activity181RewardView:onOpen()
	self._actId = self.viewParam.actId

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
end

function Activity181RewardView:refreshUI()
	self:_refreshReward()
end

function Activity181RewardView:_refreshReward()
	local actId = self._actId
	local tempSortList = Activity181Config.instance:getBoxListByActivityId(actId)

	if not tempSortList then
		return
	end

	local rewardBoxIdList = {}
	local rewardBoxGetDic = {}
	local activityMo = Activity181Model.instance:getActivityInfo(actId)

	for _, id in ipairs(tempSortList) do
		table.insert(rewardBoxIdList, id)

		rewardBoxGetDic[id] = activityMo:getBonusStateById(id) == Activity181Enum.BonusState.HaveGet
	end

	table.sort(rewardBoxIdList, function(a, b)
		if rewardBoxGetDic[a] == rewardBoxGetDic[b] then
			return a < b
		end

		return rewardBoxGetDic[b]
	end)

	local rewardCount = #rewardBoxIdList
	local itemCount = #self._rewardItemList

	for i = 1, rewardCount do
		local rewardItem

		if i <= itemCount then
			rewardItem = self._rewardItemList[i]
		else
			local itemObj = gohelper.clone(self._gorewarditem, self._gocontent)

			rewardItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemObj, Activity181RewardItem)

			table.insert(self._rewardItemList, rewardItem)
		end

		local boxId = rewardBoxIdList[i]
		local boxConfig = Activity181Config.instance:getBoxListConfig(actId, boxId)
		local reward = string.splitToNumber(boxConfig.bonus, "#")

		rewardItem:setEnable(true)

		local haveGet = rewardBoxGetDic[boxId]

		rewardItem:onUpdateMO(reward[1], reward[2], reward[3], haveGet)
	end

	if rewardCount < itemCount then
		for i = rewardCount + 1, itemCount do
			local item = self._rewardItemList[i]

			item:setEnable(true)
		end
	end
end

function Activity181RewardView:onClose()
	return
end

function Activity181RewardView:onDestroyView()
	return
end

return Activity181RewardView
