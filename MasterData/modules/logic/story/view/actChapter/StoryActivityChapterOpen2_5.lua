-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen2_5.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen2_5", package.seeall)

local StoryActivityChapterOpen2_5 = class("StoryActivityChapterOpen2_5", StoryActivityChapterBase)

function StoryActivityChapterOpen2_5:onCtor()
	self.assetPath = "ui/viewres/story/v2a5/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen2_5:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goChapter = gohelper.findChild(self.viewGO, "#go_chapter")
	self._simageSection = gohelper.findChildSingleImage(self._goChapter, "simageChapter")
	self._goSection = gohelper.findChild(self._goChapter, "simageChapter")
	self._simageTitle = gohelper.findChildSingleImage(self._goChapter, "simageTitle")
	self._simageTitle22 = gohelper.findChildSingleImage(self._goChapter, "simageTitle22")
	self._goTitle = gohelper.findChild(self._goChapter, "simageTitle")
	self._goTitle22 = gohelper.findChild(self._goChapter, "simageTitle22")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goMaskBg = gohelper.findChild(self.viewGO, "#gomask")
end

function StoryActivityChapterOpen2_5:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen2_5:play()
	gohelper.setActive(self.viewGO, true)

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local part = 1

			gohelper.setActive(self._goMaskBg, true)

			local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)
			local section = string.format("2_5_chapter_%s", config and config.labelRes)
			local title = string.format("2_5_title_%s", part)
			local isTitle22 = part == 22

			gohelper.setActive(self._goTitle22, isTitle22)
			gohelper.setActive(self._goTitle, not isTitle22)
			gohelper.setActive(self._goSection, not isTitle22)

			if isTitle22 then
				self._simageTitle22:LoadImage(self:getLangResBg(title), self.onTitle22Loaded, self)
			else
				self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
				self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)
			end

			self._anim.speed = 0

			self:playVideo()
		end
	end
end

function StoryActivityChapterOpen2_5:playVideo()
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

function StoryActivityChapterOpen2_5:onVideoStart()
	gohelper.setActive(self._goMaskBg, false)

	self._anim.speed = 1

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		if not vals[2] then
			local part = 1

			if part == 1 then
				self._anim:Play("open", 0, 0)
			elseif part == 22 then
				self._anim:Play("open2", 0, 0)
			else
				self._anim:Play("open1", 0, 0)
			end
		end
	end
end

function StoryActivityChapterOpen2_5:onSectionLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageChapter")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_5:onTitleLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageTitle")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_5:onTitle22Loaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageTitle22")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_5:getVideoName(part)
	return part == 1 and "2_5_opening_1"
end

function StoryActivityChapterOpen2_5:getLangResBg(name)
	return string.format("singlebg_lang/txt_v2a5_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen2_5:getAudioId(part)
	if part == 1 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_big_open
	end

	if part == 22 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_special_open
	end

	return AudioEnum.Story.play_activitysfx_tangren_chapter_small_open
end

function StoryActivityChapterOpen2_5:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen2_5:onDestory()
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
	StoryActivityChapterOpen2_5.super.onDestory(self)
end

return StoryActivityChapterOpen2_5
