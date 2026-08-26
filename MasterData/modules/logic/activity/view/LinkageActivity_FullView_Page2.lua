-- chunkname: @modules/logic/activity/view/LinkageActivity_FullView_Page2.lua

module("modules.logic.activity.view.LinkageActivity_FullView_Page2", package.seeall)

local LinkageActivity_FullView_Page2 = class("LinkageActivity_FullView_Page2", LinkageActivity_Page2)

function LinkageActivity_FullView_Page2:onInitView()
	self._txtDescr = gohelper.findChildText(self.viewGO, "#txt_Descr")
	self._btnArrow = gohelper.findChildButtonWithAudio(self.viewGO, "Video/#btn_Arrow")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "Video/#simage_Icon")
	self._btnChange = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Change")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LinkageActivity_FullView_Page2:addEvents()
	self._btnArrow:AddClickListener(self._btnArrowOnClick, self)
	self._btnChange:AddClickListener(self._btnChangeOnClick, self)
end

function LinkageActivity_FullView_Page2:removeEvents()
	self._btnArrow:RemoveClickListener()
	self._btnChange:RemoveClickListener()
end

local kDefaultIndex = 2
local kAnimEvt = "switch"

function LinkageActivity_FullView_Page2:ctor(...)
	LinkageActivity_FullView_Page2.super.ctor(self, ...)
end

function LinkageActivity_FullView_Page2:onDestroyView()
	GameUtil.onDestroyViewMember_SImage(self, "_simageIcon")
	LinkageActivity_FullView_Page2.super.onDestroyView(self)
end

function LinkageActivity_FullView_Page2:_editableAddEvents()
	self._animEvent_video:AddEventListener(kAnimEvt, self._onSwitch, self)
	self._clickIcon:AddClickListener(self._onClickIcon, self)
end

function LinkageActivity_FullView_Page2:_editableRemoveEvents()
	self._clickIcon:RemoveClickListener()
	self._animEvent_video:RemoveEventListener(kAnimEvt)
end

function LinkageActivity_FullView_Page2:_editableInitView()
	LinkageActivity_FullView_Page2.super._editableInitView(self)

	local dataList = self:getDataList()

	for i, mo in ipairs(dataList) do
		self:addReward(i, gohelper.findChild(self.viewGO, "Reward/" .. i), LinkageActivity_Page2Reward)
	end

	local videoGo = gohelper.findChild(self.viewGO, "Video")

	self._txtTips = gohelper.findChildText(videoGo, "image_TipsBG/txt_Tips")

	self:addVideo(1, gohelper.findChild(videoGo, "av/1"), LinkageActivity_Page2Video)
	self:addVideo(2, gohelper.findChild(videoGo, "av/2"), LinkageActivity_Page2Video)

	self._clickIcon = gohelper.getClick(self._simageIcon.gameObject)
	self._anim_video = videoGo:GetComponent(gohelper.Type_Animator)
	self._animEvent_video = gohelper.onceAddComponent(videoGo, gohelper.Type_AnimationEventWrap)
	self._s_isReceiveGetian = ActivityType101Model.instance:isType101RewardGet(self:actId(), 1)

	self:setActive(false)
end

function LinkageActivity_FullView_Page2:_btnArrowOnClick()
	local curIndex = self:_currentVideoIndex()
	local nextIndex = 3 - curIndex

	self:selectedVideo(nextIndex)
end

function LinkageActivity_FullView_Page2:_btnChangeOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_switch_20220009)
	self:selectedPage(1)
end

function LinkageActivity_FullView_Page2:onUpdateMO(mo)
	LinkageActivity_FullView_Page2.super.onUpdateMO(self, mo)
	self:selectedVideo(self:_currentVideoIndex())
end

function LinkageActivity_FullView_Page2:onSelectedVideo(index, lastIndex, isFirst)
	if isFirst then
		self._anim_video:Play(UIAnimationName.Idle, 0, 1)
		self:_refreshByIndex(index)
		self:_onSwitch()

		return
	end

	self:_playAnim_switchTo(index)
end

function LinkageActivity_FullView_Page2:_currentVideoIndex()
	return self:curVideoIndex() or kDefaultIndex
end

function LinkageActivity_FullView_Page2:_onClickIcon()
	local index = self:_getCurConfigIndex()
	local type_, id_ = self:itemCo2TIQ(index)

	MaterialTipController.instance:showMaterialInfo(type_, id_)
end

function LinkageActivity_FullView_Page2:_playAnim_switchTo(index)
	local animName = "switch" .. tostring(index)

	self._anim_video:Play(animName, 0, 0)
end

function LinkageActivity_FullView_Page2:_onSwitch()
	local index = self:_currentVideoIndex()
	local curVideoItem = self:getVideo(index)

	curVideoItem:setAsLastSibling()
	self:_refreshByIndex(index)
end

function LinkageActivity_FullView_Page2:_refreshByIndex(index)
	index = self:_getCurConfigIndex(index)

	local resUrl = self:getItemIconResUrl(index)

	GameUtil.loadSImage(self._simageIcon, resUrl)

	self._txtTips.text = self:getLinkageActivityCO_desc(index)
end

function LinkageActivity_FullView_Page2:_onUpdateMO_videoList()
	local isReceiveGetian = self:_isReceiveGetian()

	assert(#self._videoItemList == 2)

	for i, item in ipairs(self._videoItemList) do
		local videoName = self:getLinkageActivityCO_res_video(isReceiveGetian and i or 3 - i)
		local data = {
			videoName = videoName
		}

		item:onUpdateMO(data)
	end
end

function LinkageActivity_FullView_Page2:_isReceiveGetian()
	return self._s_isReceiveGetian
end

function LinkageActivity_FullView_Page2:_selectedVideo_slient(index)
	self._curVideoIndex = index

	self:_onSwitch()
end

function LinkageActivity_FullView_Page2:onPostSelectedPage(curPage, lastPage)
	if self ~= curPage then
		if self._s_isReceiveGetian then
			local isType101RewardGet = ActivityType101Model.instance:isType101RewardGet(self:actId(), 1)

			if self._s_isReceiveGetian ~= isType101RewardGet then
				self._s_isReceiveGetian = isType101RewardGet
			end
		end

		self:_selectedVideo_slient(kDefaultIndex)
	end

	LinkageActivity_FullView_Page2.super.onPostSelectedPage(self, curPage, lastPage)
end

function LinkageActivity_FullView_Page2:_getCurConfigIndex(index)
	index = index or self:_currentVideoIndex()

	local isReceiveGetian = self:_isReceiveGetian()

	return isReceiveGetian and index or 3 - index
end

return LinkageActivity_FullView_Page2
