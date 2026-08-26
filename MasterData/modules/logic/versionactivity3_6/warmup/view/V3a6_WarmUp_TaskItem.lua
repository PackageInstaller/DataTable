-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp_TaskItem.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp_TaskItem", package.seeall)

local V3a6_WarmUp_TaskItem = class("V3a6_WarmUp_TaskItem", ListScrollCellExtend)

function V3a6_WarmUp_TaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_bg")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_normal/#go_finish")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_normal/#txt_index")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_normal/#txt_desc")
	self._goblackmask = gohelper.findChild(self.viewGO, "#go_normal/#go_blackmask")
	self._gonotget = gohelper.findChild(self.viewGO, "#go_normal/#go_notget")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_get")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6_WarmUp_TaskItem:addEvents()
	self._btnget:AddClickListener(self._btngetOnClick, self)
end

function V3a6_WarmUp_TaskItem:removeEvents()
	self._btnget:RemoveClickListener()
end

local kBlock_Click = "V3a6_WarmUp_TaskItem:_btngetOnClick"
local kTimeout = 9.99

function V3a6_WarmUp_TaskItem:_btngetOnClick()
	if not self._mo.isClaimable then
		return
	end

	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout)
	self.animatorPlayer:Play(UIAnimationName.Finish, self._onFinishAnimDone, self)
end

function V3a6_WarmUp_TaskItem:_onFinishAnimDone()
	UIBlockHelper.instance:endBlock(kBlock_Click)
	self:_viewContainer():sendFinishAct125EpisodeRequest(self:_episodeId())
end

function V3a6_WarmUp_TaskItem:_episodeId()
	local mo = self._mo
	local episodeCO = mo.episodeCO

	return episodeCO.id
end

function V3a6_WarmUp_TaskItem:_viewContainer()
	return self._view.viewContainer
end

function V3a6_WarmUp_TaskItem:_editableInitView()
	self._rewardItemList = {}
	self._scrollrewardsGo = self._scrollrewards.gameObject
	self._scrollrewardsGo = self._scrollrewards.gameObject
	self._btngetGo = self._btnget.gameObject
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function V3a6_WarmUp_TaskItem:initInternal(...)
	V3a6_WarmUp_TaskItem.super.initInternal(self, ...)

	self._scrollReward = self._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	self._scrollReward.parentGameObject = self._view._csListScroll.gameObject
end

function V3a6_WarmUp_TaskItem:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
end

function V3a6_WarmUp_TaskItem:_refreshRewardItems(rewardList)
	local itemCount = #rewardList

	for i = 1, itemCount do
		local item
		local itemCo = string.splitToNumber(rewardList[i], "#")

		if i > #self._rewardItemList then
			item = self:_create_V3a6_WarmUp_rewarditem(i)

			table.insert(self._rewardItemList, item)
		else
			item = self._rewardItemList[i]
		end

		item:onUpdateMO(itemCo)
		item:setActive(true)
	end

	for i = itemCount + 1, #self._rewardItemList do
		local item = self._itemTabList[i]

		item:setActive(false)
	end
end

function V3a6_WarmUp_TaskItem:onUpdateMO(mo)
	self._mo = mo

	local episodeCO = mo.episodeCO
	local episodeId = episodeCO.id
	local rewardList = mo.rewardList
	local isUnfinished = not mo.isClaimable and not mo.isClaimed

	gohelper.setActive(self._gofinish, mo.isClaimed)
	gohelper.setActive(self._btngetGo, mo.isClaimable)
	gohelper.setActive(self._gonotget, isUnfinished)

	self._txtdesc.text = episodeCO.name
	self._txtindex.text = string.format("%02d", episodeId)

	self:_refreshRewardItems(rewardList)
end

function V3a6_WarmUp_TaskItem:_create_V3a6_WarmUp_rewarditem(index)
	local go = gohelper.cloneInPlace(self._gorewarditem)
	local item = V3a6_WarmUp_rewarditem.New({
		parent = self,
		baseViewContainer = self:_viewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a6_WarmUp_TaskItem:getAnimator()
	return self.animator
end

function V3a6_WarmUp_TaskItem:isClaimed(mo)
	local mo = self._mo

	return (mo or nil) and (mo.isClaimed or false)
end

return V3a6_WarmUp_TaskItem
