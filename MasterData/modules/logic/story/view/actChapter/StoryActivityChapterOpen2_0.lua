-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen2_0.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen2_0", package.seeall)

local StoryActivityChapterOpen2_0 = class("StoryActivityChapterOpen2_0", StoryActivityChapterBase)

function StoryActivityChapterOpen2_0:onCtor()
	self.assetPath = "ui/viewres/story/v2a0/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen2_0:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goMaskBg = gohelper.findChild(self.viewGO, "#maskBg")
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageSection = gohelper.findChildSingleImage(self._goBg, "#simage_Section")
	self._simageTitle = gohelper.findChildSingleImage(self._goBg, "#simage_Title")
	self._simageTitleBg = gohelper.findChildSingleImage(self._goBg, "#simage_titleBg")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._simageBg = gohelper.findChildSingleImage(self._goBg, "image_BG")
end

function StoryActivityChapterOpen2_0:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen2_0:play()
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
			local title = string.format("title_%s", part)

			self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)
			self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
			self._simageBg:LoadImage(config.storyBg, self.onBgLoaded, self)

			local titleLen = GameUtil.utf8len(config.title)
			local titleBgRes = titleLen > 3 and "xj_0d" or "xj_0d2"

			self._simageTitleBg:LoadImage(self:getLangResBg(titleBgRes))

			if part == 1 then
				self._anim:Play("open", 0, 0)
			else
				self._anim:Play("open1", 0, 0)
			end
		end
	end
end

function StoryActivityChapterOpen2_0:onSectionLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Section")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_0:onTitleLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Title")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_0:onBgLoaded()
	local image = gohelper.findChildImage(self._goBg, "image_BG")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_0:getLangResBg(name)
	return string.format("singlebg_lang/txt_v2a0_opening_singlebg/%s.png", name)
end

function StoryActivityChapterOpen2_0:getVideoName(part)
	return part == 1 and "2_0_opening_1"
end

function StoryActivityChapterOpen2_0:getAudioId(part)
	return (part == 1 or nil) and (AudioEnum.Story.play_ui_feichi_open_plot or AudioEnum.Story.play_ui_feichi_stanzas)
end

function StoryActivityChapterOpen2_0:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen2_0:onDestory()
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

	TaskDispatcher.cancelTask(self.play, self)
	StoryActivityChapterOpen2_0.super.onDestory(self)
end

return StoryActivityChapterOpen2_0
