-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen1_6.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen1_6", package.seeall)

local StoryActivityChapterOpen1_6 = class("StoryActivityChapterOpen1_6", StoryActivityChapterBase)

function StoryActivityChapterOpen1_6:onCtor()
	self.assetPath = "ui/viewres/story/v1a6/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen1_6:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goMaskBg = gohelper.findChild(self.viewGO, "#maskBg")
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageTitle = gohelper.findChildSingleImage(self._goBg, "#simage_Title")
	self._simageName = gohelper.findChildSingleImage(self._goBg, "#simage_Name")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "bg")
end

function StoryActivityChapterOpen1_6:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen1_6:play()
	gohelper.setActive(self.viewGO, true)

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local part = 1
			local videoName = self:getVideoName(part)

			self._videoItem = self._videoItem or StoryActivityVideoItem.New(self._goVideo)

			local audioId = self:getAudioId(part)
			local videoCo = {
				loop = false,
				audioNoStopByFinish = true,
				audioId = audioId
			}

			self._videoItem:playVideo(videoName, videoCo)
			gohelper.setActive(self._goMaskBg, true)

			local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)

			if config then
				local sectionNum = tonumber(config.labelRes or 1)
				local titleen = string.format("titleen_%s", sectionNum)
				local title = string.format("title_%s", part)

				self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
				self._simageName:LoadImage(self:getLangResBg(titleen), self.onNameLoaded, self)
				self._simageBg:LoadImage(config.storyBg, self.onBgLoaded, self)

				if part == 1 then
					self._anim:Play("open", 0, 0)
				else
					self._anim:Play("open1", 0, 0)
				end
			end
		end
	end
end

function StoryActivityChapterOpen1_6:onTitleLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Title")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_6:onNameLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Name")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_6:onBgLoaded()
	local image = gohelper.findChildImage(self.viewGO, "bg")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_6:getLangResBg(name)
	return string.format("singlebg_lang/txt_v1a6_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen1_6:getVideoName(part)
	local isOverseas = SettingsModel.instance:isOverseas()

	if isOverseas then
		return part == 1 and "1_6_opening_1"
	else
		return part == 1 and "1_6_kaimu"
	end
end

function StoryActivityChapterOpen1_6:getAudioId(part)
	return (part == 1 or nil) and (AudioEnum.Story.play_activitysfx_shuori_chapter_open or AudioEnum.Story.play_activitysfx_shuori_subsection_open)
end

function StoryActivityChapterOpen1_6:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen1_6:onDestory()
	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end

	if self._simageTitle then
		self._simageTitle:UnLoadImage()
	end

	if self._simageName then
		self._simageName:UnLoadImage()
	end

	if self._simageBg then
		self._simageBg:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self.play, self)
	StoryActivityChapterOpen1_6.super.onDestory(self)
end

return StoryActivityChapterOpen1_6
