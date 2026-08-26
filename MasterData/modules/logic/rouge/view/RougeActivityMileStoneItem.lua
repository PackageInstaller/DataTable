-- chunkname: @modules/logic/rouge/view/RougeActivityMileStoneItem.lua

module("modules.logic.rouge.view.RougeActivityMileStoneItem", package.seeall)

local RougeActivityMileStoneItem = class("RougeActivityMileStoneItem", ListScrollCellExtend)

function RougeActivityMileStoneItem:onInitView()
	self.transform = self.viewGO.transform
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_rewards/#go_rewarditem")
	self._imagestatushasget = gohelper.findChildImage(self.viewGO, "#image_status_hasget")
	self._imagestatusgrey = gohelper.findChildImage(self.viewGO, "#image_status_grey")
	self._imagestatuscanget = gohelper.findChildImage(self.viewGO, "#image_status_canget")
	self.isOpen = false
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.canvasGroup = self.viewGO:GetComponent(gohelper.Type_CanvasGroup)
	self.txtValue = gohelper.findChildTextMesh(self.viewGO, "txt_pointvalue")
end

function RougeActivityMileStoneItem:addEvents()
	return
end

function RougeActivityMileStoneItem:removeEvents()
	return
end

function RougeActivityMileStoneItem:_editableAddEvents()
	return
end

function RougeActivityMileStoneItem:_editableRemoveEvents()
	return
end

function RougeActivityMileStoneItem:getAnimator()
	return self.anim
end

function RougeActivityMileStoneItem:onUpdateMO(mo)
	self.isOpen = true
	self._mo = mo
	self._actMo = Activity186Model.instance:getById(self._mo.activityId)

	self:refreshValue()
	self:refreshReward()
end

function RougeActivityMileStoneItem:refreshValue()
	local isLoop = self._mo.isLoopBonus
	local status = self._actMo:getMilestoneRewardStatus(self._mo.rewardId)

	self.txtValue.text = isLoop and "∞" or self._actMo:getMilestoneValue(self._mo.rewardId)

	gohelper.setActive(self._imagestatuscanget, status == Activity186Enum.RewardStatus.Canget)
	gohelper.setActive(self._imagestatushasget, status == Activity186Enum.RewardStatus.Hasget)
	gohelper.setActive(self._imagestatusgrey, status == Activity186Enum.RewardStatus.None)
end

function RougeActivityMileStoneItem:refreshReward()
	local rewards = GameUtil.splitString2(self._mo.bonus, true)
	local rewardCount = #rewards

	self._status = self._actMo:getMilestoneRewardStatus(self._mo.rewardId)

	gohelper.CreateObjList(self, self._refreshRewardItem, rewards, self._gorewards, self._gorewarditem, RougeActivityMileStoneRewardItem)

	self.itemWidth = rewardCount * 210 + (rewardCount - 1) * 10

	recthelper.setWidth(self.transform, self.itemWidth)
end

function RougeActivityMileStoneItem:_refreshRewardItem(item, rewardCo, index)
	item:onUpdateMO(self._mo.activityId, self._status, rewardCo)
end

function RougeActivityMileStoneItem:getItemWidth()
	return self.itemWidth
end

function RougeActivityMileStoneItem:onDestroyView()
	return
end

return RougeActivityMileStoneItem
