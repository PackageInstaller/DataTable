-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryItem.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryItem", package.seeall)

local Activity165StoryItem = class("Activity165StoryItem", LuaCompBase)

function Activity165StoryItem:onInitView()
	self._simagepic = gohelper.findChildImage(self.viewGO, "#simage_pic")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._gostoryname = gohelper.findChild(self.viewGO, "#go_storyname")
	self._txtstoryname = gohelper.findChildText(self.viewGO, "#go_storyname/#txt_storyname")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goreward = gohelper.findChild(self.viewGO, "#go_reward")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_reward/#txt_num")
	self._btnreword = gohelper.findChildButtonWithAudio(self.viewGO, "#go_reward/#btn_reword")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity165StoryItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnreword:AddClickListener(self._btnrewordOnClick, self)
end

function Activity165StoryItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnreword:RemoveClickListener()
end

function Activity165StoryItem:_btnrewordOnClick()
	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickOpenStoryRewardBtn, self._mo.storyId)
end

function Activity165StoryItem:addEventListeners()
	self:addEvents()
end

function Activity165StoryItem:removeEventListeners()
	self:removeEvents()
end

function Activity165StoryItem:_btnclickOnClick()
	if self._mo then
		if self._mo then
			Activity165Controller.instance:openActivity165EditView(self._mo.storyId)
		else
			GameFacade.showToast(ToastEnum.Act165StoryLock)
		end
	end
end

function Activity165StoryItem:_editableInitView()
	self._rewardCanClaim = gohelper.findChild(self.viewGO, "#go_reward/claim")
	self._rewardfinish = gohelper.findChild(self.viewGO, "#go_reward/finish")
	self._rewardReddot = gohelper.findChild(self.viewGO, "#go_reward/claim/go_reddot")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Activity165StoryItem:init(go)
	self.viewGO = go
	self.actId = Activity165Model.instance:getActivityId()

	self:onInitView()
end

function Activity165StoryItem:onUpdateMO(mo, storyId)
	self._mo = mo

	local endingCount = mo and mo:getUnlockEndingCount() or 0
	local allRewordCo = mo and mo:getAllEndingRewardCo()

	self.allRewordCount = allRewordCo and tabletool.len(allRewordCo) or 0

	local format = luaLang("act126_story_reword_count")

	endingCount = math.min(endingCount, self.allRewordCount)
	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(format, endingCount, self.allRewordCount)

	local isUnlock = mo and mo.isUnlock
	local isFinish = mo and mo:isFinish()

	if mo and mo.storyCo then
		if not mo.storyCo.pic then
			local icon = "v2a1_strangetale_pic" .. storyId

			if not isUnlock then
				icon = icon .. "_locked"
			end

			UISpriteSetMgr.instance:setV2a1Act165_2Sprite(self._simagepic, icon, true)
			gohelper.setActive(self._gofinish.gameObject, false)
			self:refreshRewardState()

			self._txtstoryname.text = mo and mo:getStoryName(63) or 0

			self:_playUnlock()
			RedDotController.instance:addRedDot(self._rewardReddot, RedDotEnum.DotNode.Act165HasReward, storyId)
		end
	end
end

function Activity165StoryItem:refreshRewardState()
	local endingCount = self._mo and self._mo:getUnlockEndingCount() or 0
	local claimCount = self._mo and self._mo:getclaimRewardCount() or 0
	local isAllClaim = claimCount >= self.allRewordCount

	gohelper.setActive(self._rewardCanClaim.gameObject, claimCount < endingCount and not isAllClaim)
	gohelper.setActive(self._rewardfinish.gameObject, isAllClaim)
end

function Activity165StoryItem:onOpen()
	return
end

function Activity165StoryItem:onClose()
	return
end

function Activity165StoryItem:onDestroyView()
	return
end

function Activity165StoryItem:_playUnlock()
	if not self._mo then
		return
	end

	local isUnlock = self._mo.isUnlock
	local isCanPlay = self._mo:isNewUnlock()

	if isUnlock and isCanPlay then
		self._viewAnim:Play(Activity165Enum.StoryItemAnim.Unlock, 0, 0)
		self._mo:cancelNewUnlockStory()
	end
end

function Activity165StoryItem:_checkUnlock()
	if self._mo then
		gohelper.setActive(self._goreward.gameObject, self._mo)
		gohelper.setActive(self._gostoryname.gameObject, self._mo)
	end
end

return Activity165StoryItem
