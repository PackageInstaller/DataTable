-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryReviewView.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryReviewView", package.seeall)

local Activity165StoryReviewView = class("Activity165StoryReviewView", BaseView)

function Activity165StoryReviewView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._goendingnode = gohelper.findChild(self.viewGO, "#go_endingnode")
	self._goend1 = gohelper.findChild(self.viewGO, "#go_endingnode/#go_end1")
	self._goend2 = gohelper.findChild(self.viewGO, "#go_endingnode/#go_end2")
	self._goend3 = gohelper.findChild(self.viewGO, "#go_endingnode/#go_end3")
	self._goend4 = gohelper.findChild(self.viewGO, "#go_endingnode/#go_end4")
	self._goend5 = gohelper.findChild(self.viewGO, "#go_endingnode/#go_end5")
	self._goend6 = gohelper.findChild(self.viewGO, "#go_endingnode/#go_end6")
	self._btnstory1 = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_story1")
	self._btnstory2 = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_story2")
	self._btnstory3 = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_story3")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity165StoryReviewView:addEvents()
	self._btnstory1:AddClickListener(self._btnstory1OnClick, self)
	self._btnstory2:AddClickListener(self._btnstory2OnClick, self)
	self._btnstory3:AddClickListener(self._btnstory3OnClick, self)
	self._animationEvent:AddEventListener(Activity165Enum.ReviewViewAnim.Switch, self.switchAnimCB, self)
end

function Activity165StoryReviewView:removeEvents()
	self._btnstory1:RemoveClickListener()
	self._btnstory2:RemoveClickListener()
	self._btnstory3:RemoveClickListener()
	self._animationEvent:RemoveEventListener(Activity165Enum.ReviewViewAnim.Switch)

	for _, item in pairs(self._endingItem) do
		item.btn:RemoveClickListener()
	end
end

function Activity165StoryReviewView:_btnstory1OnClick()
	self:_switchAnim(1)
end

function Activity165StoryReviewView:_btnstory2OnClick()
	self:_switchAnim(2)
end

function Activity165StoryReviewView:_btnstory3OnClick()
	self:_switchAnim(3)
end

function Activity165StoryReviewView:_editableInitView()
	self._btnState = self:getUserDataTb_()

	local storyMos = Activity165Model.instance:getAllActStory()

	for i, mo in pairs(storyMos) do
		local select = gohelper.findChild(self.viewGO, "Btn/#btn_story" .. i .. "/selectbg")
		local normal = gohelper.findChild(self.viewGO, "Btn/#btn_story" .. i .. "/normalbg")
		local txt1 = gohelper.findChildText(select, "txt_story")
		local txt2 = gohelper.findChildText(normal, "txt_story")

		self._btnState[i] = {
			select = select,
			normal = normal
		}
		txt1.text = mo:getStoryName()
		txt2.text = mo:getStoryName()
	end

	self._endingItem = self:getUserDataTb_()

	for i = 1, 6 do
		local icon = gohelper.findChildImage(self.viewGO, "#go_endingnode/#go_end" .. i)
		local unlock = gohelper.findChild(icon.gameObject, "#unlock")
		local btn = gohelper.findChildButtonWithAudio(icon.gameObject, "btn")

		self._endingItem[i] = {
			icon = icon,
			unlock = unlock,
			btn = btn
		}
	end

	self._viewAnim = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animationEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
end

function Activity165StoryReviewView:onUpdateParam()
	return
end

function Activity165StoryReviewView:onOpen()
	self._actId = Activity165Model.instance:getActivityId()

	local index = self.viewParam.storyId

	self._enterView = self.viewParam.view

	self:_onShowEnding(index)
	self:_activeTagBtn()
end

function Activity165StoryReviewView:onClose()
	return
end

function Activity165StoryReviewView:onDestroyView()
	return
end

function Activity165StoryReviewView:_onShowEnding(storyId)
	self._pageIndex = storyId

	for i, item in pairs(self._btnState) do
		gohelper.setActive(item.select, i == storyId)
		gohelper.setActive(item.normal, i ~= storyId)
	end

	self._mo = Activity165Model.instance:getStoryMo(self._actId, storyId)

	local index = 1

	for ending, _ in pairs(self._mo.unlockEndings) do
		local item = self._endingItem[index]

		index = index + 1

		local co = Activity165Config.instance:getEndingCo(self._actId, ending)
		local icon = co.pic

		if not string.nilorempty(icon) then
			UISpriteSetMgr.instance:setV2a1Act165_2Sprite(item.icon, icon)
		end

		local function cb()
			Activity165Controller.instance:openActivity165EditView(storyId, ending)
		end

		item.btn:RemoveClickListener()
		item.btn:AddClickListener(cb, self)
		gohelper.setActive(item.icon.gameObject, true)

		local isPlay = self:_isCanPlayUnlockAnim(ending)

		gohelper.setActive(item.unlock.gameObject, isPlay)

		if isPlay then
			AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_review)
		end
	end

	local endings = Activity165Config.instance:getEndingCosByStoryId(self._actId, storyId)
	local endingCount = tabletool.len(endings)

	for i = index, endingCount do
		local item = self._endingItem[i]
		local icon = "v2a1_strangetale_ending_locked"

		if not string.nilorempty(icon) then
			UISpriteSetMgr.instance:setV2a1Act165_2Sprite(item.icon, icon)
		end

		gohelper.setActive(item.icon.gameObject, true)
		item.btn:RemoveClickListener()

		local function cb()
			GameFacade.showToast(ToastEnum.Act165EndingLock)
		end

		item.btn:AddClickListener(cb, self)
	end

	for i = endingCount + 1, #self._endingItem do
		local item = self._endingItem[i]

		gohelper.setActive(item.icon.gameObject, false)
	end

	Activity165Model.instance:setEndingRedDot(storyId)

	if self._enterView then
		self._enterView:_checkRedDot()
	end
end

function Activity165StoryReviewView:_isCanPlayUnlockAnim(ending)
	if not self._mo or not ending then
		return false
	end

	local isCanPlay = GameUtil.playerPrefsGetNumberByUserId(self:_playUnlockKey(ending), 0) == 0

	if isCanPlay then
		GameUtil.playerPrefsSetNumberByUserId(self:_playUnlockKey(ending), 1)

		return true
	end
end

function Activity165StoryReviewView:_activeTagBtn()
	for i = 1, Activity165Model.instance:getStoryCount() do
		local mo = Activity165Model.instance:getStoryMo(self._actId, i)
		local isUnlock = mo and mo.isUnlock
		local gobtn = self["_btnstory" .. i]

		if gobtn then
			gohelper.setActive(gobtn.gameObject, isUnlock)
		end
	end
end

function Activity165StoryReviewView:_playUnlockKey(ending)
	return string.format("Activity165EndingItem_isUnlock_%s_%s_%s", self._actId, self._mo.storyId, ending)
end

function Activity165StoryReviewView:_switchAnim(index)
	if self._pageIndex == index then
		return
	end

	self._pageIndex = index

	self._viewAnim:Play(Activity165Enum.ReviewViewAnim.Switch, nil, self)
end

function Activity165StoryReviewView:switchAnimCB()
	self:_onShowEnding(self._pageIndex)
end

return Activity165StoryReviewView
