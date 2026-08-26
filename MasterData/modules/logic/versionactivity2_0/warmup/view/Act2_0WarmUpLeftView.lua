-- chunkname: @modules/logic/versionactivity2_0/warmup/view/Act2_0WarmUpLeftView.lua

module("modules.logic.versionactivity2_0.warmup.view.Act2_0WarmUpLeftView", package.seeall)

local Act2_0WarmUpLeftView = class("Act2_0WarmUpLeftView", BaseView)

function Act2_0WarmUpLeftView:onInitView()
	self._simagefullbglight = gohelper.findChildSingleImage(self.viewGO, "Middle/eye/#simage_fullbg_light")
	self._godrag = gohelper.findChild(self.viewGO, "Middle/eye/eye0/#go_drag")
	self._goClickArea = gohelper.findChild(self.viewGO, "Middle/eye/eye1/#go_ClickArea")
	self._simageday = gohelper.findChildSingleImage(self.viewGO, "Middle/eye_detail/#simage_day")
	self._simagedaybg = gohelper.findChildSingleImage(self.viewGO, "Middle/eye_detail/#simage_daybg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act2_0WarmUpLeftView:addEvents()
	return
end

function Act2_0WarmUpLeftView:removeEvents()
	return
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

function Act2_0WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animSelf = self._animatorPlayer.animator
	self._guideGo = gohelper.findChild(self.viewGO, "Middle/guide")
	self._animatorPlayer_guide = csAnimatorPlayer.Get(self._guideGo)
	self._eye0Go = gohelper.findChild(self.viewGO, "Middle/eye/eye0")
	self._itemClick1 = gohelper.getClickWithAudio(self._godrag, AudioEnum.UI.play_ui_common_click_20200111)
	self._itemClick2 = gohelper.getClickWithAudio(self._goClickArea, AudioEnum.UI.play_ui_common_click_20200111)

	self._itemClick1:AddClickListener(self._onItemClick, self)
	self._itemClick2:AddClickListener(self._onItemClick, self)

	self._drag = UIDragListenerHelper.New()
end

function Act2_0WarmUpLeftView:_onItemClick()
	if not self.viewContainer:checkLidIsOpened() then
		return
	end

	self:playAnim_Eye(true)
end

function Act2_0WarmUpLeftView:onDataUpdateFirst()
	if not self.viewContainer:checkLidIsOpened() then
		self._drag:create(self._godrag)
		self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
		self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
	end
end

function Act2_0WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function Act2_0WarmUpLeftView:onSwitchEpisode()
	self:_refresh()
end

function Act2_0WarmUpLeftView:onOpen()
	return
end

function Act2_0WarmUpLeftView:onClose()
	return
end

function Act2_0WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
	GameUtil.onDestroyViewMember_ClickListener(self, "_itemClick1")
	GameUtil.onDestroyViewMember_ClickListener(self, "_itemClick2")
	self._simagefullbglight:UnLoadImage()
	self._simageday:UnLoadImage()
	self._simagedaybg:UnLoadImage()
end

function Act2_0WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function Act2_0WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function Act2_0WarmUpLeftView:_refresh()
	local episodeId = self:_episodeId()
	local lidIsOpened = self.viewContainer:checkLidIsOpened()
	local eyeIsClicked = self.viewContainer:checkEyeIsClicked(episodeId)
	local resUrl = self.viewContainer:getImgResUrl(self.viewContainer:episode2Index(episodeId))

	self._simageday:LoadImage(resUrl)
	self:_setActive_drag(not lidIsOpened)

	if eyeIsClicked then
		self:_zoomed_Eye()
	elseif lidIsOpened then
		self:_opened_Eye()
	else
		self:_closed_Lid()
	end
end

function Act2_0WarmUpLeftView:openGuide(cb, cbObj)
	self._animatorPlayer_guide:Play("guide_warmup1_loop", cb, cbObj)
end

function Act2_0WarmUpLeftView:_onDragBegin()
	gohelper.setActive(self._guideGo, false)
end

function Act2_0WarmUpLeftView:_onDragEnd()
	if self.viewContainer:checkLidIsOpened() then
		return
	end

	if self._drag:isMoveVerticalMajor() and self._drag:isSwipeUp() then
		self:playAnim_Lid(true)
	end
end

function Act2_0WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb, cbObj)
end

function Act2_0WarmUpLeftView:_playAnimRaw(name, ...)
	self._animSelf.enabled = true

	self._animSelf:Play(name, ...)
end

local kBlock_Lid = "Act2_0WarmUpLeftView:playAnim_Lid"
local kTimeout = 9.99

function Act2_0WarmUpLeftView:playAnim_Lid(isOpen)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_dooreye_20200112)

	if isOpen == self.viewContainer:checkLidIsOpened() then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Lid, kTimeout, self.viewName)

	self._animSelf.speed = isOpen and 1 or -1

	self:_playAnim("eye1", function()
		self.viewContainer:saveLidState(isOpen)
		UIBlockHelper.instance:endBlock(kBlock_Lid)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

local kBlock_Eye = "Act2_0WarmUpLeftView:playAnim_Eye"

function Act2_0WarmUpLeftView:playAnim_Eye(isBig)
	local episodeId = self:_episodeId()

	if isBig == self.viewContainer:checkEyeIsClicked(episodeId) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_zoom_20200113)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Eye, kTimeout, self.viewName)

	self._animSelf.speed = isBig and 1 or -1

	self:_playAnim("eyedetail", function()
		self.viewContainer:saveEyeState(episodeId, isBig)
		self.viewContainer:openDesc()
		UIBlockHelper.instance:endBlock(kBlock_Eye)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

function Act2_0WarmUpLeftView:_opened_Eye()
	self:_playAnimRaw("eye1", 0, 1)
end

function Act2_0WarmUpLeftView:_closed_Lid()
	self:_playAnimRaw("eye0", 0, 1)
end

function Act2_0WarmUpLeftView:_zoomed_Eye()
	self:_playAnimRaw("eyedetail", 0, 1)
end

return Act2_0WarmUpLeftView
