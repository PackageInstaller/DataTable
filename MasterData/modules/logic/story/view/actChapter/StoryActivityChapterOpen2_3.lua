-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen2_3.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen2_3", package.seeall)

local StoryActivityChapterOpen2_3 = class("StoryActivityChapterOpen2_3", StoryActivityChapterBase)

function StoryActivityChapterOpen2_3:onCtor()
	self.assetPath = "ui/viewres/story/v2a3/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen2_3:onInitView()
	self._goChapter = gohelper.findChild(self.viewGO, "#go_chapter")
	self._simageSection = gohelper.findChildSingleImage(self._goChapter, "simageChapter")
	self._simageTitle = gohelper.findChildSingleImage(self._goChapter, "simageTitle")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterOpen2_3:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self.play, self, 2)
end

function StoryActivityChapterOpen2_3:play()
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

			self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)
			self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)

			self._anim.speed = 0

			self:onVideoStart()
		end
	end
end

function StoryActivityChapterOpen2_3:onVideoStart()
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

			self._audioId = self:getAudioId(part)

			self:_playAudio()
		end
	end
end

function StoryActivityChapterOpen2_3:onSectionLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageChapter")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_3:onTitleLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageTitle")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen2_3:getLangResBg(name)
	return string.format("singlebg_lang/txt_v2a3_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen2_3:getAudioId(part)
	return (part == 1 or nil) and (AudioEnum.Story.play_activitysfx_shenghuo_chapter_open or AudioEnum.Story.play_activitysfx_shenghuo_subsection_open)
end

function StoryActivityChapterOpen2_3:onHide()
	TaskDispatcher.cancelTask(self.play, self)
	self:_stopAudio()
end

function StoryActivityChapterOpen2_3:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterOpen2_3:_stopAudio()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterOpen2_3:onDestory()
	if self._simageTitle then
		self._simageTitle:UnLoadImage()
	end

	if self._simageSection then
		self._simageSection:UnLoadImage()
	end

	self:_stopAudio()
	TaskDispatcher.cancelTask(self.play, self)
	StoryActivityChapterOpen2_3.super.onDestory(self)
end

return StoryActivityChapterOpen2_3
