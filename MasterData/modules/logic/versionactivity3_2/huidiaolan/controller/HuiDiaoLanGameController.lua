-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/controller/HuiDiaoLanGameController.lua

module("modules.logic.versionactivity3_2.huidiaolan.controller.HuiDiaoLanGameController", package.seeall)

local HuiDiaoLanGameController = class("HuiDiaoLanGameController", BaseController)

function HuiDiaoLanGameController:onInit()
	return
end

function HuiDiaoLanGameController:reInit()
	return
end

function HuiDiaoLanGameController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.getAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.getAct220EpisodePush, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.FinishEpisodeReply, self)
end

function HuiDiaoLanGameController:getAct220InfoReply(msg)
	if msg.activityId == VersionActivity3_2Enum.ActivityId.HuiDiaoLan then
		HuiDiaoLanModel.instance:initEpisodeInfo(msg.episodes)
	end
end

function HuiDiaoLanGameController:getAct220EpisodePush(msg)
	if msg.activityId == VersionActivity3_2Enum.ActivityId.HuiDiaoLan then
		HuiDiaoLanModel.instance:setNewUnlockEpisodeInfoList(msg.episodes)
	end
end

function HuiDiaoLanGameController:FinishEpisodeReply(msg)
	if msg.activityId == VersionActivity3_2Enum.ActivityId.HuiDiaoLan then
		HuiDiaoLanModel.instance:updateEpisodeFinishState(msg.episodeId)
	end
end

function HuiDiaoLanGameController:openGameView(viewParam)
	ViewMgr.instance:openView(ViewName.HuiDiaoLanGameView, viewParam)
end

function HuiDiaoLanGameController:openGameResultView(viewParam)
	self:dispatchEvent(HuiDiaoLanEvent.GameFinish)
	ViewMgr.instance:openView(ViewName.HuiDiaoLanResultView, viewParam)
end

function HuiDiaoLanGameController:enterEpisodeLevelView(actId, episodeId)
	self.openEpisodeId = episodeId

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, self._onReceiveInfo, self)
end

function HuiDiaoLanGameController:_onReceiveInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		local activityId = msg.activityId
		local activityMo = ActivityModel.instance:getActMO(activityId)

		if activityMo then
			::label_10_0::

			local var_10_0 = activityMo.config

			if activityMo.config then
				local storyId = activityMo.config.storyId

				if storyId and storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
					local storyParam = {}

					storyParam.mark = true

					StoryController.instance:playStory(storyId, storyParam, self.openEpisodeLevelView, self)
				else
					ViewMgr.instance:openView(ViewName.HuiDiaoLanEpisodeLevelView, {
						episodeId = self.openEpisodeId
					})
				end
			end
		end
	end

	self.openEpisodeId = nil
end

function HuiDiaoLanGameController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.HuiDiaoLanEpisodeLevelView, {
		episodeId = self.openEpisodeId
	})
end

function HuiDiaoLanGameController:openTaskView(viewParam)
	ViewMgr.instance:openView(ViewName.HuiDiaoLanTaskView, viewParam)
end

HuiDiaoLanGameController.instance = HuiDiaoLanGameController.New()

return HuiDiaoLanGameController
