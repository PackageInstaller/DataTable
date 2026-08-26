-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen1_1.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen1_1", package.seeall)

local StoryActivityChapterOpen1_1 = class("StoryActivityChapterOpen1_1", StoryActivityChapterBase)

function StoryActivityChapterOpen1_1:onCtor()
	self.assetPath = "ui/viewres/story/v1a1/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen1_1:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goContent = gohelper.findChild(self.viewGO, "#go_content")
	self._singleBg = gohelper.findChildSingleImage(self._goContent, "#single_bg")
	self._singleMask = gohelper.findChildSingleImage(self._goContent, "#single_mask")
	self._singleTitle = gohelper.findChildSingleImage(self._goContent, "#simage_title")
	self._singleSignaturebg = gohelper.findChildSingleImage(self._goContent, "#simage_title/#simage_signaturebg")
	self._singleSignature = gohelper.findChildSingleImage(self._goContent, "#simage_title/#simage_signaturebg/#simage_signature")
	self._singleWenli = gohelper.findChildSingleImage(self._goContent, "#simage_title/#simage_wenli")
	self._txtTitlecn = gohelper.findChildText(self._goContent, "#simage_title/#txt_titlecn")
	self._txtTitleen = gohelper.findChildText(self._goContent, "#simage_title/#txt_titleen")
end

function StoryActivityChapterOpen1_1:onUpdateView()
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
				outCallback = self.playStartVideoOut,
				outCallbackObj = self,
				audioId = audioId
			}

			self._videoItem:playVideo(videoName, videoCo)

			local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)

			if config then
				self._txtTitlecn.text = config.title or ""
			end

			if config then
				self._txtTitleen.text = config.titleEn or ""
			end

			local labelRes = config and config.labelRes

			if string.nilorempty(labelRes) then
				gohelper.setActive(self._singleSignature.gameObject, false)
			else
				gohelper.setActive(self._singleSignature.gameObject, true)
				self._singleSignature:LoadImage(ResUrl.getVersionActivityOpenPath(labelRes), self.onTitileLoaded, self)
			end

			self._singleBg:LoadImage(ResUrl.getVersionActivityOpenPath("full/bg_h"))
			self._singleMask:LoadImage(ResUrl.getVersionActivityOpenPath("full/mask"))
			self._singleWenli:LoadImage(ResUrl.getVersionActivityOpenPath("2wenli"))
			self._singleSignaturebg:LoadImage(ResUrl.getVersionActivityOpenPath("1img_zhuangshi"))
			self._singleTitle:LoadImage(ResUrl.getVersionActivityOpenPath("4img_green"))
		end
	end
end

function StoryActivityChapterOpen1_1:getVideoName(part)
	local isOverseas = SettingsModel.instance:isOverseas()

	if isOverseas then
		return part % 100 == 1 and "1_1_opening_0" or "1_1_opening_1"
	else
		return part % 100 == 1 and "dajiekaimu1" or "xiaojiekaimu1"
	end
end

function StoryActivityChapterOpen1_1:getAudioId(part)
	return (part % 100 == 1 or nil) and (AudioEnum.Story.Activity_Chapter_Start or AudioEnum.Story.Activity_Part_Start)
end

function StoryActivityChapterOpen1_1:playStartVideoOut()
	gohelper.setActive(self._goContent, true)
end

function StoryActivityChapterOpen1_1:onTitileLoaded()
	self._singleSignature.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function StoryActivityChapterOpen1_1:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end
end

function StoryActivityChapterOpen1_1:onDestory()
	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end

	if self._singleTitle then
		self._singleTitle:UnLoadImage()
	end

	if self._singleBg then
		self._singleBg:UnLoadImage()
	end

	if self._singleMask then
		self._singleMask:UnLoadImage()
	end

	if self._singleWenli then
		self._singleWenli:UnLoadImage()
	end

	if self._singleSignaturebg then
		self._singleSignaturebg:UnLoadImage()
	end

	StoryActivityChapterOpen1_1.super.onDestory(self)
end

return StoryActivityChapterOpen1_1
