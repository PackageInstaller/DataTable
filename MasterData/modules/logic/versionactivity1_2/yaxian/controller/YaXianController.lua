-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/YaXianController.lua

module("modules.logic.versionactivity1_2.yaxian.controller.YaXianController", package.seeall)

local YaXianController = class("YaXianController", BaseController)

function YaXianController:onInit()
	return
end

function YaXianController:reInit()
	return
end

function YaXianController:openYaXianMapView(chapterId)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(YaXianEnum.ActivityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParamList)
		end

		return
	end

	if not VersionActivityBaseController.instance:isPlayedActivityVideo(YaXianEnum.ActivityId) then
		local activityCo = ActivityConfig.instance:getActivityCo(YaXianEnum.ActivityId)
		local storyId = activityCo and activityCo.storyId

		if storyId and storyId ~= 0 then
			self.enterChapterId = chapterId

			StoryController.instance:playStory(storyId, nil, self._onFinishStory, self)

			return
		end
	end

	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, function()
		ViewMgr.instance:openView(ViewName.YaXianMapView, {
			chapterId = chapterId
		})
	end)
end

function YaXianController:_onFinishStory()
	self:openYaXianMapView(self.enterChapterId)

	self.enterChapterId = nil
end

function YaXianController:getChapterStatus(chapterId)
	local chapterConfig = YaXianConfig.instance:getChapterConfig(chapterId)
	local openId = chapterConfig and chapterConfig.openId

	if openId and openId ~= 0 and not OpenModel.instance:isFunctionUnlock(openId) then
		return YaXianEnum.ChapterStatus.notOpen
	end

	if not YaXianModel.instance:chapterIsUnlock(chapterId) then
		return YaXianEnum.ChapterStatus.Lock
	end

	return YaXianEnum.ChapterStatus.Normal
end

function YaXianController:checkChapterIsUnlock(chapterId)
	return self:getChapterStatus(chapterId) == YaXianEnum.ChapterStatus.Normal
end

YaXianController.instance = YaXianController.New()

return YaXianController
