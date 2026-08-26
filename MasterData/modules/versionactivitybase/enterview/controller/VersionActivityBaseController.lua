-- chunkname: @modules/versionactivitybase/enterview/controller/VersionActivityBaseController.lua

module("modules.versionactivitybase.enterview.controller.VersionActivityBaseController", package.seeall)

local VersionActivityBaseController = class("VersionActivityBaseController", BaseController)

function VersionActivityBaseController:isPlayedActivityVideo(actId)
	local actCo = ActivityConfig.instance:getActivityCo(actId)

	if not actCo then
		return true
	end

	if string.nilorempty(actCo.storyId) or actCo.storyId == 0 then
		return true
	end

	return StoryModel.instance:isStoryFinished(actCo.storyId)
end

function VersionActivityBaseController:_initPlayedActUnlockAnimationList()
	local unlockStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	if string.nilorempty(unlockStr) then
		self.playedActUnlockAnimationList = {}

		return
	end

	self.playedActUnlockAnimationList = string.splitToNumber(unlockStr, "#")
end

function VersionActivityBaseController:playedActivityUnlockAnimation(actId)
	if not actId then
		return
	end

	if not self.playedActUnlockAnimationList then
		self:_initPlayedActUnlockAnimationList()
	end

	if tabletool.indexOf(self.playedActUnlockAnimationList, actId) then
		return
	end

	table.insert(self.playedActUnlockAnimationList, actId)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey), table.concat(self.playedActUnlockAnimationList, "#"))
end

function VersionActivityBaseController:isPlayedUnlockAnimation(actId)
	if not self.playedActUnlockAnimationList then
		self:_initPlayedActUnlockAnimationList()
	end

	return tabletool.indexOf(self.playedActUnlockAnimationList, actId)
end

function VersionActivityBaseController:clear()
	self.playedActUnlockAnimationList = nil
	self.playedVideosActivityIdList = nil
end

function VersionActivityBaseController:enterVersionActivityView(viewName, actId, callback, callbackObj)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId)

		return
	end

	ViewMgr.instance:openView(viewName)
end

VersionActivityBaseController.instance = VersionActivityBaseController.New()

LuaEventSystem.addEventMechanism(VersionActivityBaseController.instance)

return VersionActivityBaseController
