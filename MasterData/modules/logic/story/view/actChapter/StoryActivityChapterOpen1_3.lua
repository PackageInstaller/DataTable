-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen1_3.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen1_3", package.seeall)

local StoryActivityChapterOpen1_3 = class("StoryActivityChapterOpen1_3", StoryActivityChapterBase)

function StoryActivityChapterOpen1_3:onCtor()
	self.assetPath = "ui/viewres/story/v1a3/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen1_3:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goMaskBg = gohelper.findChild(self.viewGO, "#maskBg")
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageFullBg = gohelper.findChildSingleImage(self._goBg, "#simage_FullBG")
	self._simageFullBg1 = gohelper.findChildSingleImage(self._goBg, "#simage_FullBG/simage_FullBG1")
	self._simageSection = gohelper.findChildSingleImage(self._goBg, "#simage_Section")
	self._simageTitle = gohelper.findChildSingleImage(self._goBg, "#simage_Title")
	self._simageName = gohelper.findChildSingleImage(self._goBg, "#simage_Name")
	self._simagePart = gohelper.findChildSingleImage(self._goBg, "#simage_Chapter")

	self._simageFullBg:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_xiaojie_bg.png")
	self._simageFullBg1:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_xiaojie_bg.png")

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterOpen1_3:onUpdateView()
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
			local titleen = string.format("v1a3_title_en_%s", part)
			local title = string.format("v1a3_title_%s", part)
			local section = string.format("v1a3_section_%s", config and config.labelRes)
			local partRes = string.format("v1a3_part_%s", config and config.labelRes)

			self._simageTitle:LoadImage(self:getLangResBg(titleen))
			self._simageName:LoadImage(self:getLangResBg(title))
			self._simageSection:LoadImage(self:getLangResBg(section))
			self._simagePart:LoadImage(self:getLangResBg(partRes))

			if part == 1 then
				self._anim:Play("open", 0, 0)
			else
				self._anim:Play("open1", 0, 0)
			end
		end
	end
end

function StoryActivityChapterOpen1_3:getLangResBg(name)
	return string.format("singlebg_lang/txt_v1a3_opening_singlebg/%s.png", name)
end

function StoryActivityChapterOpen1_3:getVideoName(part)
	return part == 1 and "1_3molupangka"
end

function StoryActivityChapterOpen1_3:getAudioId(part)
	return (part == 1 or nil) and (AudioEnum.Story.Activity1_3_Chapter_Start or AudioEnum.Story.Activity1_3_Part_Start)
end

function StoryActivityChapterOpen1_3:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end
end

function StoryActivityChapterOpen1_3:onDestory()
	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end

	if self._simageFullBg then
		self._simageFullBg:UnLoadImage()
	end

	if self._simageFullBg1 then
		self._simageFullBg1:UnLoadImage()
	end

	if self._simageSection then
		self._simageSection:UnLoadImage()
	end

	if self._simageTitle then
		self._simageTitle:UnLoadImage()
	end

	if self._simageName then
		self._simageName:UnLoadImage()
	end

	if self._simagePart then
		self._simagePart:UnLoadImage()
	end

	StoryActivityChapterOpen1_3.super.onDestory(self)
end

return StoryActivityChapterOpen1_3
