-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneRewardItem.lua

module("modules.logic.college.view.milestone.CollegeMilestoneRewardItem", package.seeall)

local CollegeMilestoneRewardItem = class("CollegeMilestoneRewardItem", SimpleListItem)

function CollegeMilestoneRewardItem:onInit(viewGO)
	self.viewGO = viewGO
	self._goRewardList = gohelper.findChild(self.viewGO, "go_RewardList")
	self._goRewardItem = gohelper.findChild(self.viewGO, "go_RewardList/go_Item")
	self._goLightPoint = gohelper.findChild(self.viewGO, "point/light")
	self._goGreyPoint = gohelper.findChild(self.viewGO, "point/grey")
	self._txtPoint = gohelper.findChildText(self.viewGO, "point/#txt_point")
	self._goImportant = gohelper.findChild(self.viewGO, "go_Important")
	self._milestoneBox = CollegeModel.instance:getSceneMo().milestoneBox
end

function CollegeMilestoneRewardItem:onAddListeners()
	return
end

function CollegeMilestoneRewardItem:onRemoveListeners()
	return
end

function CollegeMilestoneRewardItem:onItemShow(rewardCo)
	self._rewardCo = rewardCo
	self._rewardId = rewardCo.id
	self._score = rewardCo.score
	self._isGain = self._milestoneBox:isGainReward(self._rewardId)
	self._canGet = not self._isGain and self._milestoneBox.score >= self._score

	self:refreshUI()
end

function CollegeMilestoneRewardItem:refreshUI()
	self._txtPoint.text = self._rewardCo and self._rewardCo.score

	gohelper.setActive(self._goImportant, self._rewardCo and self._rewardCo.special == 1)
	gohelper.setActive(self._goLightPoint, self._score <= self._milestoneBox.score)
	gohelper.setActive(self._goGreyPoint, self._score > self._milestoneBox.score)
	self:refreshItemList()
end

function CollegeMilestoneRewardItem:refreshItemList()
	local rewardList = DungeonConfig.instance:getRewardItems(self._rewardCo.reward) or {}

	gohelper.CreateObjList(self, self._refreshRewardSubItem, rewardList, self._goRewardList, self._goRewardItem, CollegeMilestoneRewardSubItem)
end

function CollegeMilestoneRewardItem:_refreshRewardSubItem(rewardItem, rewardInfo, index)
	rewardItem:onUpdateMO(rewardInfo[1], rewardInfo[2], rewardInfo[3], self._canGet, self._isGain)
end

return CollegeMilestoneRewardItem
