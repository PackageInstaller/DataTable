-- chunkname: @modules/logic/versionactivity1_2/jiexika/controller/Activity114Controller.lua

module("modules.logic.versionactivity1_2.jiexika.controller.Activity114Controller", package.seeall)

local Activity114Controller = class("Activity114Controller", BaseController)

function Activity114Controller:onInit()
	return
end

function Activity114Controller:onInitFinish()
	return
end

function Activity114Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self.onFightSceneEnter, self)
end

function Activity114Controller:reInit()
	self:markStoryFinish()
end

function Activity114Controller:_checkActivityInfo(activityId)
	local updateActInfo

	if activityId then
		updateActInfo = ActivityModel.instance:getActMO(activityId)
	else
		for id in pairs(Activity114Config.instance:getAllActivityIds()) do
			if ActivityModel.instance:isActOnLine(id) then
				updateActInfo = ActivityModel.instance:getActMO(id)

				break
			end
		end
	end

	if not updateActInfo then
		return
	end

	if updateActInfo.actType ~= ActivityEnum.ActivityTypeID.JieXiKa then
		return
	end

	if not updateActInfo.online and updateActInfo.id == Activity114Model.instance.id then
		Activity114Model.instance:setEnd()
	end
end

function Activity114Controller:onFightSceneEnter(sceneType)
	if sceneType ~= SceneType.Fight then
		return
	end

	local fightParam = FightModel.instance:getFightParam()

	if not fightParam or fightParam.episodeId ~= Activity114Enum.episodeId then
		return
	end

	local eventCo = Activity114Helper.getEventCoByBattleId(fightParam.battleId)

	if eventCo then
		local context = {
			type = eventCo.config.eventType,
			eventId = eventCo.config.id
		}

		Activity114Model.instance:buildFlowAndSkipWork(context)
	end
end

function Activity114Controller:alertActivityEndMsgBox()
	if not Activity114Model.instance:isEnd() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, function()
		if GameSceneMgr.instance:isFightScene() then
			self:dispatchEvent(Activity114Event.OnEventProcessEnd)
		else
			NavigateButtonsView.homeClick()
		end
	end)
end

function Activity114Controller:openAct114View()
	local updateActInfo

	for id in pairs(Activity114Config.instance:getAllActivityIds()) do
		if ActivityModel.instance:isActOnLine(id) then
			updateActInfo = ActivityModel.instance:getActMO(id)

			break
		end
	end

	if not updateActInfo then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	Activity114Rpc.instance:sendGet114InfosRequest(updateActInfo.id, self._openAct114View, self)
end

function Activity114Controller:_openAct114View()
	if Activity114Model.instance:isEnd() then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	if Activity114Model.instance.serverData.battleEventId > 0 then
		local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId)

		self:enterActivityFight(eventCo.config.battleId)

		return
	end

	ViewMgr.instance:openView(ViewName.Activity114View)
end

function Activity114Controller:enterActivityFight(battleId)
	if not battleId or battleId <= 0 then
		error("battleId : " .. tostring(battleId))

		return
	end

	Activity114Rpc.instance:beforeBattle(Activity114Model.instance.id)

	local episodeId = Activity114Enum.episodeId
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, battleId)
end

function Activity114Controller:markStoryWillFinish()
	Activity114Model.instance.waitStoryFinish = true

	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, self._onCloseViewFinish, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self.markStoryFinish, self)
end

function Activity114Controller:_onCloseViewFinish(viewName)
	if viewName == ViewName.StoryView then
		self:markStoryFinish()
	end
end

function Activity114Controller:markStoryFinish()
	Activity114Model.instance.waitStoryFinish = false

	ViewMgr.instance:unregisterCallback(ViewEvent.DestroyViewFinish, self._onCloseViewFinish, self)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, self.markStoryFinish, self)
	self:dispatchEvent(Activity114Event.StoryFinish)
end

Activity114Controller.instance = Activity114Controller.New()

return Activity114Controller
