-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen1_5.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen1_5", package.seeall)

local StoryActivityChapterOpen1_5 = class("StoryActivityChapterOpen1_5", StoryActivityChapterBase)

function StoryActivityChapterOpen1_5:onCtor()
	self.assetPath = "ui/viewres/story/v1a5/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen1_5:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goMaskBg = gohelper.findChild(self.viewGO, "#maskBg")
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._txtTitle = gohelper.findChildTextMesh(self._goBg, "#txt_Title")
	self._simageTitle = gohelper.findChildSingleImage(self._goBg, "#simage_Title")
	self._simageName = gohelper.findChildSingleImage(self._goBg, "#simage_Name")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterOpen1_5:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen1_5:play()
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
			local titleen = string.format("titleen_%s", part)
			local title = string.format("title_%s", part)

			self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
			self._simageName:LoadImage(self:getLangResBg(titleen), self.onNameLoaded, self)

			if config then
				local sectionNum = tonumber(config.labelRes or 1)

				self._txtTitle.text = sectionNum == 0 and luaLang("prelude") or formatLuaLang("storyactivitysection", GameUtil.getNum2Chinese(sectionNum))

				if part == 1 then
					self._anim:Play("open", 0, 0)
				else
					self._anim:Play("open1", 0, 0)
				end
			end
		end
	end
end

function StoryActivityChapterOpen1_5:onTitleLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Title")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_5:onNameLoaded()
	local image = gohelper.findChildImage(self._goBg, "#simage_Name")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen1_5:getLangResBg(name)
	return string.format("singlebg_lang/txt_v1a5_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen1_5:getVideoName(part)
	local isOverseas = SettingsModel.instance:isOverseas()

	if isOverseas then
		return part == 1 and "1_5_opening_1"
	else
		return part == 1 and "1_5_kaimu"
	end
end

function StoryActivityChapterOpen1_5:getAudioId(part)
	return (part == 1 or nil) and (AudioEnum.Story.play_activitysfx_wulu_chapter_open or AudioEnum.Story.play_activitysfx_wulu_subsection_open)
end

function StoryActivityChapterOpen1_5:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen1_5:onDestory()
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

	TaskDispatcher.cancelTask(self.play, self)
	StoryActivityChapterOpen1_5.super.onDestory(self)
end

return StoryActivityChapterOpen1_5
