-- chunkname: @modules/logic/toughbattle/controller/ToughBattleController.lua

module("modules.logic.toughbattle.controller.ToughBattleController", package.seeall)

local ToughBattleController = class("ToughBattleController", BaseController)

function ToughBattleController:reInit()
	self._delayOpenViewAndParam = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)
end

function ToughBattleController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._getAct158Info, self)
end

function ToughBattleController:_getAct158Info(activityId)
	if not activityId or activityId == VersionActivity1_9Enum.ActivityId.ToughBattle then
		if ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle) == ActivityEnum.ActivityStatus.Normal then
			Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, self._onGetActInfo, self)
		else
			ToughBattleModel.instance:setActOffLine()
			self:dispatchEvent(ToughBattleEvent.ToughBattleActChange)
		end
	end
end

function ToughBattleController:_onGetActInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ToughBattleController:checkIsToughBattle()
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterCo or chapterCo.type ~= DungeonEnum.ChapterType.ToughBattle then
		return false
	end

	return true
end

function ToughBattleController:onRecvToughInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		self:_enterToughBattle()
	else
		MainController.instance:enterMainScene(self._isFromGroupView, false)
	end
end

function ToughBattleController:enterToughBattle(isFromGroupView)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local co = ToughBattleConfig.instance:getCoByEpisodeId(episodeId)

	if not co then
		logError("攻坚战配置不存在" .. tostring(episodeId))
		MainController.instance:enterMainScene(isFromGroupView, false)

		return
	end

	self._isFromGroupView = isFromGroupView
	self._preEpisodeId = episodeId
	self._isFightSuccess = nil

	if not isFromGroupView then
		local recordMo = FightModel.instance:getRecordMO()

		if recordMo and recordMo.fightResult == FightEnum.FightResult.Succ then
			self._isFightSuccess = true
		end
	end

	DungeonModel.instance:resetSendChapterEpisodeId()

	local isAct = ToughBattleConfig.instance:isActEpisodeId(episodeId)

	if isAct then
		Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, self.onRecvToughInfo, self)
	else
		SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(self.onRecvToughInfo, self)
	end
end

function ToughBattleController:_enterToughBattle()
	local episodeId = self._preEpisodeId
	local isBattleSuccess = self._isFightSuccess
	local co = ToughBattleConfig.instance:getCoByEpisodeId(episodeId)
	local isAct = ToughBattleConfig.instance:isActEpisodeId(episodeId)
	local info = isAct and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()

	MainController.instance:enterMainScene(self._isFromGroupView, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local var_9_0 = {}

		if isAct then
			var_9_0.mode = ToughBattleEnum.Mode.Act or ToughBattleEnum.Mode.Story
		end

		var_9_0.lastFightSuccIndex = isBattleSuccess and co.sort

		local param = var_9_0

		if isAct then
			if not ViewName.ToughBattleActEnterView then
				local enterView = ViewName.ToughBattleEnterView

				if isAct then
					if not ViewName.ToughBattleActMapView then
						local mapView = ViewName.ToughBattleMapView

						if isAct then
							JumpController.instance:jumpByParam("4#10728#1")
						else
							JumpController.instance:jumpByParam("3#107")
						end

						self._delayOpenViewAndParam = nil

						if #info.passChallengeIds == 4 and isBattleSuccess or not info.openChallenge then
							if isAct then
								GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, enterView)

								if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
									ViewMgr.instance:openView(enterView, param)
								else
									self._delayOpenViewAndParam = {
										enterView,
										param
									}
								end
							end
						else
							GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapView)

							if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
								ViewMgr.instance:openView(mapView, param)
							else
								self._delayOpenViewAndParam = {
									mapView,
									param
								}
							end
						end

						if self._delayOpenViewAndParam then
							ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)
						end
					end
				end
			end
		end
	end)
end

function ToughBattleController:jumpToActView()
	local info = ToughBattleModel.instance:getActInfo()

	if not info then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		if not info.openChallenge then
			ViewMgr.instance:openView(ViewName.ToughBattleActEnterView, {
				mode = ToughBattleEnum.Mode.Act
			})
		else
			ViewMgr.instance:openView(ViewName.ToughBattleActMapView, {
				mode = ToughBattleEnum.Mode.Act
			})
		end
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)

		self._delayOpenViewAndParam = not info.openChallenge and {
			ViewName.ToughBattleActEnterView,
			{
				mode = ToughBattleEnum.Mode.Act
			}
		} or {
			ViewName.ToughBattleActMapView,
			{
				mode = ToughBattleEnum.Mode.Act
			}
		}
	end
end

function ToughBattleController:onOpenDungeonMapView(viewName)
	if viewName == ViewName.DungeonMapView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)

		if self._delayOpenViewAndParam then
			ViewMgr.instance:openView(unpack(self._delayOpenViewAndParam))

			self._delayOpenViewAndParam = nil
		end
	end
end

ToughBattleController.instance = ToughBattleController.New()

return ToughBattleController
