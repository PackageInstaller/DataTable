-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/controller/RankRaceResultController.lua

module("logic.extensions.rankrace.controller.RankRaceResultController", package.seeall)

local RankRaceResultController = class("RankRaceResultController", BaseController)

function RankRaceResultController:onInit()
	RankRaceResultController.super.onInit(self)

	self._isInRankRace = nil
end

function RankRaceResultController:onReset()
	RankRaceResultController.super.onReset(self)
	self:clearInRankRaceTag()
end

function RankRaceResultController:notifyGameResult(msg)
	self._isInRankRace = true

	RankRaceResultModel.instance:notifyGameResult(msg)
	self:notify(GlobalNotify.RankRaceResult)
end

function RankRaceResultController:checkResult()
	if RankRaceResultModel.instance:hasGameResult() then
		local state = RankRaceResultModel.instance:getRankRaceState()

		if state and state == RankRaceResultModel.State_Normal then
			local stage = RankRaceResultModel.instance:getBattleResultStage()

			if stage == RankRaceResultModel.ResStage_Mine or stage == RankRaceResultModel.ResStage_Enermy then
				local _videoBack = RankRaceController.instance:getClickVideo()

				if _videoBack == nil then
					ViewMgr.instance:open(ViewName.RankRaceBattleResultView)
				elseif _videoBack == true or _videoBack == false then
					RankRaceController.instance:setClickVideo(nil)
					RankRaceController.instance:openClassicsView()
				end
			elseif stage == RankRaceResultModel.ResStage_Result then
				ViewMgr.instance:open(ViewName.RankRaceResultView)
			end
		end
	end
end

function RankRaceResultController:isInRankRace()
	return self._isInRankRace
end

function RankRaceResultController:clearInRankRaceTag()
	self._isInRankRace = nil
end

RankRaceResultController.instance = RankRaceResultController.New()

return RankRaceResultController
