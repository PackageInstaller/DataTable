-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen1_8.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen1_8", package.seeall)

local StoryActivityChapterOpen1_8 = class("StoryActivityChapterOpen1_8", StoryActivityChapterBase)

function StoryActivityChapterOpen1_8:onCtor()
	self.assetPath = "ui/viewres/story/v1a8/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen1_8:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goMaskBg = gohelper.findChild(self.viewGO, "#maskBg")
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageSection = gohelper.findChildSingleImage(self._goBg, "#simage_Section")
	self._simageTitle = gohelper.findChildSingleImage(self._goBg, "#simage_Title")
	self._simageTitleen = gohelper.findChildSingleImage(self._goBg, "#simage_Titleen")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._simageBg = gohelper.findChildSingleImage(self._goBg, "image_BG")
end

function StoryActivityChapterOpen1_8:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen1_8:play()
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
			local section = string.format("section_%s", config.labelRes)
			local titleen = string.format("titleen_%s", part)
			local title = string.format("title_%s", part)

			self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)
			self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
			self._simageTitleen:LoadImage(self:getLangResBg(titleen), self.onTitleenLoaded, self)
			self._simageBg:LoadImage(config.storyBg, self.onBgLoaded, self)

			if part == 1 then
				self._anim:Play("open", 0, 0)
			else
				self._anim:Play("open1", 0, 0)
			end
		end
	end
end

function StoryActivityChapterOpen1_8:onSectionLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Section")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_8:onTitleLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Title")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_8:onTitleenLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Titleen")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_8:onBgLoaded()
	local image = gohelper.findChildImage(self._goBg, "image_BG")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_8:getLangResBg(name)
	return string.format("singlebg_lang/txt_v1a8_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen1_8:getVideoName(part)
	return part == 1 and "1_8_kaimu"
end

function StoryActivityChapterOpen1_8:getAudioId(part)
	return (part == 1 or nil) and (AudioEnum.Story.play_activitysfx_shiji_chapter_open or AudioEnum.Story.play_activitysfx_shiji_subsection_open)
end

function StoryActivityChapterOpen1_8:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen1_8:onDestory()
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
	StoryActivityChapterOpen1_8.super.onDestory(self)
end

return StoryActivityChapterOpen1_8
