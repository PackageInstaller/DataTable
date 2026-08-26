-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen3_6.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen3_6", package.seeall)

local StoryActivityChapterOpen3_6 = class("StoryActivityChapterOpen3_6", StoryActivityChapterBase)

function StoryActivityChapterOpen3_6:onCtor()
	self.assetPath = "ui/viewres/story/v3a6/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen3_6:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goChapter = gohelper.findChild(self.viewGO, "#go_chapter")
	self._goSection = gohelper.findChild(self._goChapter, "simageChapter")
	self._simageTitle = gohelper.findChildSingleImage(self._goChapter, "simageTitle")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goMaskBg = gohelper.findChild(self.viewGO, "#gomask")
end

function StoryActivityChapterOpen3_6:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	self:play()
end

function StoryActivityChapterOpen3_6:play()
	gohelper.setActive(self.viewGO, true)

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local part = 1

			gohelper.setActive(self._goMaskBg, true)

			local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)
			local section = string.format("3_5_chapter_%s", config and config.labelRes)
			local title = string.format("title_%s", part)

			self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)

			self._anim.speed = 0

			self:playVideo()
		end
	end
end

function StoryActivityChapterOpen3_6:playVideo()
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

function StoryActivityChapterOpen3_6:onVideoStart()
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

function StoryActivityChapterOpen3_6:onSectionLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageChapter")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen3_6:onTitleLoaded()
	local image = gohelper.findChildImage(self._goChapter, "simageTitle")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen3_6:onBgLoaded()
	ZProj.UGUIHelper.SetImageSize(self._simageBg.gameObject)
end

function StoryActivityChapterOpen3_6:getVideoName(part)
	return part == 1 and "3_6_opening_1"
end

function StoryActivityChapterOpen3_6:getLangResBg(name)
	return string.format("singlebg_lang/txt_v3a6_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen3_6:getAudioId(part)
	if part == 1 then
		return AudioEnum.Story.play_activitysfx_renmen_avg_open
	end

	return AudioEnum.Story.play_activitysfx_renmen_avg_open2
end

function StoryActivityChapterOpen3_6:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen3_6:onDestory()
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
	StoryActivityChapterOpen3_6.super.onDestory(self)
end

return StoryActivityChapterOpen3_6
