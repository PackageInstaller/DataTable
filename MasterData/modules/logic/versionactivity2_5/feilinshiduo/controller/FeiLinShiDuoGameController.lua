-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/controller/FeiLinShiDuoGameController.lua

module("modules.logic.versionactivity2_5.feilinshiduo.controller.FeiLinShiDuoGameController", package.seeall)

local FeiLinShiDuoGameController = class("FeiLinShiDuoGameController", BaseController)

function FeiLinShiDuoGameController:onInit()
	return
end

function FeiLinShiDuoGameController:reInit()
	return
end

function FeiLinShiDuoGameController:openTaskView(viewParam)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoTaskView, viewParam)
end

function FeiLinShiDuoGameController:openGameView(viewParam)
	FeiLinShiDuoGameModel.instance:setCurMapId(viewParam.mapId)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoGameView, viewParam)
end

function FeiLinShiDuoGameController:enterEpisodeLevelView(actId)
	Activity185Rpc.instance:sendGetAct185InfoRequest(actId, self._onReceiveInfo, self)
end

function FeiLinShiDuoGameController:_onReceiveInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		local activityId = msg.activityId
		local activityMo = ActivityModel.instance:getActMO(activityId)

		if activityMo then
			::label_6_0::

			local var_6_0 = activityMo.config

			if activityMo.config then
				local storyId = activityMo.config.storyId

				if storyId and not StoryModel.instance:isStoryFinished(storyId) then
					local storyParam = {}

					storyParam.mark = true

					StoryController.instance:playStory(storyId, storyParam, self.openEpisodeLevelView, self)
				else
					ViewMgr.instance:openView(ViewName.FeiLinShiDuoEpisodeLevelView)
				end
			end
		end
	end
end

function FeiLinShiDuoGameController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoEpisodeLevelView)
end

function FeiLinShiDuoGameController:finishEpisode(activityId, episodeId)
	Activity185Rpc.instance:sendAct185FinishEpisodeRequest(activityId, episodeId)
end

function FeiLinShiDuoGameController:openGameResultView(viewParam)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoResultView, viewParam)
end

FeiLinShiDuoGameController.instance = FeiLinShiDuoGameController.New()

return FeiLinShiDuoGameController
