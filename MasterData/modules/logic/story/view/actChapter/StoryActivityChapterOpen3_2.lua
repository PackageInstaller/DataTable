-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen3_2.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen3_2", package.seeall)

local StoryActivityChapterOpen3_2 = class("StoryActivityChapterOpen3_2", StoryActivityChapterBase)

function StoryActivityChapterOpen3_2:onCtor()
	self.assetPath = "ui/viewres/story/v3a2/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen3_2:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goChapter = gohelper.findChild(self.viewGO, "#go_chapter")
	self._simageSection = gohelper.findChildSingleImage(self._goChapter, "simageChapter")
	self._goSection = gohelper.findChild(self._goChapter, "simageChapter")
	self._simageTitle = gohelper.findChildSingleImage(self._goChapter, "simageTitle")
	self._goTitle = gohelper.findChild(self._goChapter, "simageTitle")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goMaskBg = gohelper.findChild(self.viewGO, "#gomask")
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "#go_bg/bg")
	self._simageBgMask = gohelper.findChildSingleImage(self.viewGO, "#go_bg/bgmask")
end

function StoryActivityChapterOpen3_2:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen3_2:play()
	gohelper.setActive(self.viewGO, true)

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local part = 1

			gohelper.setActive(self._goMaskBg, true)

			local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)
			local section = string.format("chapter_%s", config and config.labelRes)
			local title = string.format("title_%s", part)

			self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
			self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)
			self._simageBg:LoadImage(config.storyBg, self.onBgLoaded, self)

			local bgMask = string.gsub(config.storyBg, ".jpg", "mask.png", 1)

			self._simageBgMask:LoadImage(bgMask, self.onBgMaskLoaded, self)

			self._anim.speed = 0

			self:playVideo()
		end
	end
end

function StoryActivityChapterOpen3_2:playVideo()
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

function StoryActivityChapterOpen3_2:onVideoStart()
	gohelper.setActive(self._goMaskBg, false)

	self._anim.speed = 1

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		if not vals[2] then
			local part = 1

			if part == 1 then
				self._anim:Play("open", 0, 0)
			else
				self._anim:Play("open1", 0, 0)
			end
		end
	end
end

function StoryActivityChapterOpen3_2:onSectionLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageChapter")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen3_2:onTitleLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageTitle")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen3_2:onBgLoaded()
	ZProj.UGUIHelper.SetImageSize(self._simageBg.gameObject)
end

function StoryActivityChapterOpen3_2:onBgMaskLoaded()
	ZProj.UGUIHelper.SetImageSize(self._simageBgMask.gameObject)
end

function StoryActivityChapterOpen3_2:getVideoName(part)
	return part == 1 and "3_2_opening_1"
end

function StoryActivityChapterOpen3_2:getLangResBg(name)
	return string.format("singlebg_lang/txt_v3a2_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen3_2:getAudioId(part)
	if part == 1 then
		return AudioEnum.Story.play_activitysfx_shengyan_chapter_open
	end

	return AudioEnum.Story.play_activitysfx_shengyan_subsection_open
end

function StoryActivityChapterOpen3_2:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen3_2:onDestory()
	if self._simageTitle then
		self._simageTitle:UnLoadImage()
	end

	if self._simageSection then
		self._simageSection:UnLoadImage()
	end

	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end

	TaskDispatcher.cancelTask(self.play, self)
	StoryActivityChapterOpen3_2.super.onDestory(self)
end

return StoryActivityChapterOpen3_2
