-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen2_1.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen2_1", package.seeall)

local StoryActivityChapterOpen2_1 = class("StoryActivityChapterOpen2_1", StoryActivityChapterBase)

function StoryActivityChapterOpen2_1:onCtor()
	self.assetPath = "ui/viewres/story/v2a1/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen2_1:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goMaskBg = gohelper.findChild(self.viewGO, "#maskBg")
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageSection = gohelper.findChildSingleImage(self._goBg, "#simage_Section")
	self._simageTitle = gohelper.findChildSingleImage(self._goBg, "#simage_Title")
	self._simageTitleen = gohelper.findChildSingleImage(self._goBg, "#simage_Titleen")
	self._simageTitleBg = gohelper.findChildSingleImage(self._goBg, "#simage_titleBg")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._simageBg = gohelper.findChildSingleImage(self._goBg, "image_BG")
end

function StoryActivityChapterOpen2_1:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen2_1:play()
	gohelper.setActive(self.viewGO, true)

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local part = 1

			gohelper.setActive(self._goMaskBg, true)

			local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)
			local section = string.format("section_%s", config.labelRes)
			local title = string.format("title_%s", part)
			local titleen = string.format("titleen_%s", part)

			self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)
			self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
			self._simageTitleen:LoadImage(self:getLangResBg(titleen), self.onTitleenLoaded, self)

			local titleLen = GameUtil.utf8len(config.title)
			local titleBgRes = "arttext_4"

			if titleLen < 3 then
				titleBgRes = "arttext_1"
			elseif titleLen < 5 then
				titleBgRes = "arttext_2"
			elseif titleLen < 7 then
				titleBgRes = "arttext_3"
			end

			self._simageTitleBg:LoadImage(string.format("singlebg/v2a1_opening_singlebg/%s.png", titleBgRes))

			self._anim.speed = 0

			gohelper.setActive(self._simageBg.gameObject, false)
			self:playVideo()
		end
	end
end

function StoryActivityChapterOpen2_1:playVideo()
	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		if not vals[2] then
			local part = 1
			local videoName = self:getVideoName(part)

			self._videoItem = self._videoItem or StoryActivityVideoItem.New(self._goVideo)

			local audioId = self:getAudioId(part)
			local videoCo = {
				loop = false,
				audioNoStopByFinish = true,
				audioId = audioId,
				startCallback = self.onVideoStart,
				startCallbackObj = self
			}

			self._videoItem:playVideo(videoName, videoCo)
		end
	end
end

function StoryActivityChapterOpen2_1:onVideoStart()
	self._anim.speed = 1

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local part = 1

			if part == 1 then
				self._anim:Play("open", 0, 0)
			else
				self._anim:Play("open1", 0, 0)
			end

			local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)

			gohelper.setActive(self._simageBg.gameObject, true)
			self._simageBg:LoadImage(config.storyBg, self.onBgLoaded, self)
		end
	end
end

function StoryActivityChapterOpen2_1:onSectionLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Section")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_1:onTitleLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Title")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_1:onTitleenLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Titleen")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_1:onBgLoaded()
	local image = gohelper.findChildImage(self._goBg, "image_BG")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_1:getLangResBg(name)
	return string.format("singlebg_lang/txt_v2a1_opening_singlebg/%s.png", name)
end

function StoryActivityChapterOpen2_1:getVideoName(part)
	return part == 1 and "2_1_opening_1"
end

function StoryActivityChapterOpen2_1:getAudioId(part)
	return (part == 1 or nil) and (AudioEnum.Story.play_activitysfx_wangshi_chapter_open or AudioEnum.Story.play_activitysfx_wangshi_subsection_open)
end

function StoryActivityChapterOpen2_1:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen2_1:onDestory()
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

	if self._simageTitleBg then
		self._simageTitleBg:UnLoadImage()
	end

	if self._simageBg then
		self._simageBg:UnLoadImage()
	end

	if self._simageTitleen then
		self._simageTitleen:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self.play, self)
	StoryActivityChapterOpen2_1.super.onDestory(self)
end

return StoryActivityChapterOpen2_1
