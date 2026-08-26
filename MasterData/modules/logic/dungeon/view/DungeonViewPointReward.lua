-- chunkname: @modules/logic/dungeon/view/DungeonViewPointReward.lua

module("modules.logic.dungeon.view.DungeonViewPointReward", package.seeall)

local DungeonViewPointReward = class("DungeonViewPointReward", BaseView)

function DungeonViewPointReward:onInitView()
	self._btntipreward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_story/layout/#btn_tipreward")
	self._txtrewardprogress = gohelper.findChildText(self.viewGO, "#go_story/layout/#btn_tipreward/#txt_rewardprogress")
	self._gorewardredpoint = gohelper.findChild(self.viewGO, "#go_story/layout/#btn_tipreward/#go_rewardredpoint")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonViewPointReward:addEvents()
	self._btntipreward:AddClickListener(self._btntiprewardOnClick, self)
end

function DungeonViewPointReward:removeEvents()
	self._btntipreward:RemoveClickListener()
end

function DungeonViewPointReward:_btntiprewardOnClick()
	DungeonController.instance:openDungeonCumulativeRewardsView()
end

function DungeonViewPointReward:_editableInitView()
	self._animTipsReward = self._btntipreward.gameObject:GetComponent(typeof(UnityEngine.Animation))

	self:_updateMapTip()
end

function DungeonViewPointReward:onUpdateParam()
	return
end

function DungeonViewPointReward:onOpen()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnGetPointReward, self._updateMapTip, self)
end

function DungeonViewPointReward:onOpenFinish()
	return
end

function DungeonViewPointReward:onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGetPointReward, self._updateMapTip, self)
	TaskDispatcher.cancelTask(self._refreshProgress, self)
end

function DungeonViewPointReward:_onCloseViewFinish(viewName, viewParam)
	if viewName == ViewName.DungeonMapView then
		self:_updateMapTip()
	end
end

function DungeonViewPointReward:_isShowBtnGift()
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward)
end

function DungeonViewPointReward:_updateMapTip()
	TaskDispatcher.cancelTask(self._refreshProgress, self)
	TaskDispatcher.runDelay(self._refreshProgress, self, 0)
end

function DungeonViewPointReward:_refreshProgress()
	local showBtn = self:_isShowBtnGift()

	gohelper.setActive(self._btntipreward.gameObject, showBtn)

	if not showBtn then
		return
	end

	local lastConfig = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList]

	self._maxChapterId = lastConfig.chapterId

	local rewards = DungeonMapModel.instance:canGetRewardsList(self._maxChapterId)
	local canGetRewards = rewards and #rewards > 0

	if canGetRewards then
		self._animTipsReward:Play("btn_tipreward_loop")
		gohelper.setActive(self._gorewardredpoint, true)
	else
		self._animTipsReward:Play("btn_tipreward")
		gohelper.setActive(self._gorewardredpoint, false)
	end

	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo()
	local targetReward = DungeonMapModel.instance:getUnfinishedTargetReward()

	self._txtrewardprogress.text = string.format("%s/%s", pointRewardInfo.rewardPoint, targetReward.rewardPointNum)
end

function DungeonViewPointReward:onDestroyView()
	return
end

return DungeonViewPointReward
