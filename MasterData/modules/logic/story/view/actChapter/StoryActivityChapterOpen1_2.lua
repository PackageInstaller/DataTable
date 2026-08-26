-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen1_2.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen1_2", package.seeall)

local StoryActivityChapterOpen1_2 = class("StoryActivityChapterOpen1_2", StoryActivityChapterBase)

function StoryActivityChapterOpen1_2:onCtor()
	self.assetPath = "ui/viewres/story/v1a2/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen1_2:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goMaskBg = gohelper.findChild(self.viewGO, "#maskBg")
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._singleBgTitle = gohelper.findChildSingleImage(self._goBg, "#simage_bgtitle")
end

function StoryActivityChapterOpen1_2:onUpdateView()
	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		if not vals[2] then
			local part = 1
			local videoName = self:getVideoName(part)

			if videoName then
				self._videoItem = self._videoItem or StoryActivityVideoItem.New(self._goVideo)

				local audioId = self:getAudioId(part)
				local videoCo = {
					loop = false,
					outCallback = self.playStartVideoOut,
					outCallbackObj = self,
					audioId = audioId
				}

				self._videoItem:playVideo(videoName, videoCo)
			end

			gohelper.setActive(self._goMaskBg, true)

			local res = string.format("bg_xiaobiaoti_%s", part)

			if not string.nilorempty(res) then
				self._singleBgTitle:LoadImage(ResUrl.getActivityChapterLangPath(res))
			end

			local delayTime = self:getDelayTime(part)

			if delayTime and delayTime > 0 then
				TaskDispatcher.runDelay(self._playChapter2Anim, self, delayTime)
			else
				self:_playChapter2Anim()
			end
		end
	end
end

function StoryActivityChapterOpen1_2:getVideoName(part)
	if part == 0 then
		return "1_2lvhuemeng"
	end

	if part < 18 or part > 26 then
		return "1_2lvhuemeng_1"
	end
end

function StoryActivityChapterOpen1_2:getDelayTime(part)
	if part == 0 then
		return 9.8
	end

	if part < 18 or part > 26 then
		return 6.96
	end

	return 0
end

function StoryActivityChapterOpen1_2:getAudioId(part)
	if part == 0 then
		return AudioEnum.Story.Activity1_2_Chapter_Start
	end

	if part < 18 or part > 26 then
		return AudioEnum.Story.Activity1_2_Part_Start
	end
end

function StoryActivityChapterOpen1_2:playStartVideoOut()
	return
end

function StoryActivityChapterOpen1_2:_playChapter2Anim()
	gohelper.setActive(self._goBg, true)
end

function StoryActivityChapterOpen1_2:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self._playChapter2Anim, self)
end

function StoryActivityChapterOpen1_2:onDestory()
	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end

	if self._singleBgTitle then
		self._singleBgTitle:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self._playChapter2Anim, self)
	StoryActivityChapterOpen1_2.super.onDestory(self)
end

return StoryActivityChapterOpen1_2
