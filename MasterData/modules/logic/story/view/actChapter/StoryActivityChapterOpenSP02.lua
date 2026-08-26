-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpenSP02.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpenSP02", package.seeall)

local StoryActivityChapterOpenSP02 = class("StoryActivityChapterOpenSP02", StoryActivityChapterBase)

function StoryActivityChapterOpenSP02:onCtor()
	self.assetPath = "ui/viewres/story/sp02/storyactivitychapteropen.prefab"
	self.effectPath = "effects/prefabs/story/s01_ziti2.prefab"
end

function StoryActivityChapterOpenSP02:loadPrefab()
	if not self.assetPath then
		return
	end

	if self._resLoader then
		return
	end

	self._resLoader = MultiAbLoader.New()

	self._resLoader:addPath(self.assetPath)
	self._resLoader:addPath(self.effectPath)
	self._resLoader:startLoad(self.onLoaded, self)
end

function StoryActivityChapterOpenSP02:onLoaded()
	local resPath = self.assetPath
	local assetItem = self._resLoader:getAssetItem(resPath)
	local prefab = assetItem:GetResource(resPath)

	self.viewGO = gohelper.clone(prefab, self.rootGO)

	local effectResPath = self.effectPath
	local effectAssetItem = self._resLoader:getAssetItem(effectResPath)
	local effect = effectAssetItem:GetResource(effectResPath)

	self.effectGO = gohelper.clone(effect, self.rootGO)

	self:onInitView()
	self:onUpdateView()
end

function StoryActivityChapterOpenSP02:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goChapter = gohelper.findChild(self.viewGO, "#go_chapter")
	self._simageSection = gohelper.findChildSingleImage(self._goChapter, "simageChapter")
	self._goSection = gohelper.findChild(self._goChapter, "simageChapter")
	self._simageTitle = gohelper.findChildSingleImage(self._goChapter, "simageTitle")
	self._goTitle = gohelper.findChild(self._goChapter, "simageTitle")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goMaskBg = gohelper.findChild(self.viewGO, "#gomask")
end

function StoryActivityChapterOpenSP02:onUpdateView()
	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[2] then
		local part = 1
		local isStart = part == -1

		if not isStart then
			self:onEffectFinish()

			return
		end

		self._audioId = AudioEnum.Story.play_activitysfx_langchao_chapter_open

		if self._audioId then
			AudioEffectMgr.instance:playAudio(self._audioId)
		end

		gohelper.setActive(self.viewGO, false)
		gohelper.setActive(self.effectGO, true)
		TaskDispatcher.runDelay(self.onEffectFinish, self, 15)
	end
end

function StoryActivityChapterOpenSP02:onEffectFinish()
	self:play()
end

function StoryActivityChapterOpenSP02:play()
	gohelper.setActive(self.effectGO, false)
	gohelper.setActive(self.viewGO, true)

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local part = 1

			gohelper.setActive(self._goMaskBg, true)

			if part ~= -1 then
				local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)
				local section = string.format("s02_chapter_%s", config and config.labelRes)
				local title = string.format("s02_title_%s", part)

				self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
				self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)
			end

			self._anim.speed = 0

			self:playVideo()
		end
	end
end

function StoryActivityChapterOpenSP02:playVideo()
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

function StoryActivityChapterOpenSP02:onVideoStart()
	gohelper.setActive(self._goMaskBg, false)

	self._anim.speed = 1

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		if not vals[2] then
			local part = 1

			if part == -1 then
				self._anim:Play("open", 0, 0)
			else
				self._anim:Play("open1", 0, 0)
			end
		end
	end
end

function StoryActivityChapterOpenSP02:onSectionLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageChapter")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpenSP02:onTitleLoaded()
	local image = gohelper.findChildImage(self._goChapter, "#simageTitle")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpenSP02:getVideoName(part)
	if part == -1 then
		return "sp02_opening_1"
	end

	if part == 0 or part == 15 then
		return "sp02_opening_3"
	end

	return "sp02_opening_2"
end

function StoryActivityChapterOpenSP02:getLangResBg(name)
	return string.format("singlebg_lang/txt_sp02_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpenSP02:getAudioId(part)
	if part == -1 then
		return
	end

	if part == 0 or part == 15 then
		return AudioEnum.Story.play_activitysfx_langchao_prologue_open
	end

	return AudioEnum.Story.play_activitysfx_langchao_subsection_open
end

function StoryActivityChapterOpenSP02:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterOpenSP02:onDestory()
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

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	TaskDispatcher.cancelTask(self.onEffectFinish, self)
	StoryActivityChapterOpenSP02.super.onDestory(self)
end

return StoryActivityChapterOpenSP02
