-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/controller/GoodFeelController.lua

module("logic.extensions.goodfeel.controller.GoodFeelController", package.seeall)

local GoodFeelController = class("GoodFeelController", BaseController)

GoodFeelController.PM_GFGetChatInfoRes = "GoodFeelController.PM_GFGetChatInfoRes"
GoodFeelController.PM_GFGetRaceBookInfoRes = "GoodFeelController.PM_GFGetRaceBookInfoRes"
GoodFeelController.PM_GFGetEventInfoRes = "GoodFeelController.PM_GFGetEventInfoRes"
GoodFeelController.PM_GFNotifyAfterHandleEventRes = "GoodFeelController.PM_GFNotifyAfterHandleEventRes"
GoodFeelController.RealUseGift = "GoodFeelController.RealUseGift"
GoodFeelController.PM_GFGainPrizeRes = "GoodFeelController.PM_GFGainPrizeRes"
GoodFeelController.PM_GFViewStoryRes = "GoodFeelController.PM_GFViewStoryRes"
GoodFeelController.UpdateSendGifeUpLvDot = "GoodFeelController.UpdateSendGifeUpLvDot"
GoodFeelController.UseGiftError = "GoodFeelController.UseGiftError"
GoodFeelController.UpdateUnlockStory = "GoodFeelController.UpdateUnlockStory"
GoodFeelController.PM_GFSelfChatRes = "GoodFeelController.PM_GFSelfChatRes"
GoodFeelController.PlayLvUpEffect = "GoodFeelController.PlayLvUpEffect"
GoodFeelController.PlayVoiceCv = "GoodFeelController.PlayVoiceCv"

function GoodFeelController:ctor()
	return
end

function GoodFeelController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFGetChatInfoRes, self._handlePM_GFGetChatInfoRes, self)
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFSelfChatRes, self._handlePM_GFSelfChatRes, self)
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFGetRaceBookInfoRes, self._handlePM_GFGetRaceBookInfoRes, self)
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFViewStoryRes, self._handlePM_GFViewStoryRes, self)
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFGetEventInfoRes, self._handlePM_GFGetEventInfoRes, self)
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFHandleEventRes, self._handlePM_GFHandleEventRes, self)
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFGainPrizeRes, self._handlePM_GFGainPrizeRes, self)
	GlobalDispatcher:addListener(GoodFeelingAgent.PM_GFNotifyAfterHandleEventRes, self._handlePM_GFNotifyAfterHandleEventRes, self)
end

function GoodFeelController:onReset()
	return
end

function GoodFeelController:_handlePM_GFGetChatInfoRes(status, msg)
	if status == 0 then
		GoodFeelModel.instance:setChatInfo(msg)
		GlobalDispatcher:dispatch(GoodFeelController.PM_GFGetChatInfoRes)
	end
end

function GoodFeelController:_handlePM_GFSelfChatRes(status, msg)
	if status == 0 then
		GoodFeelModel.instance:onSelfChatRes(msg)
		GlobalDispatcher:dispatch(GoodFeelController.PM_GFSelfChatRes)
	end
end

function GoodFeelController:_handlePM_GFGetRaceBookInfoRes(status, msg)
	if status == 0 then
		GoodFeelModel.instance:setRaceBookInfo(msg)
		GlobalDispatcher:dispatch(GoodFeelController.PM_GFGetRaceBookInfoRes)
	end
end

function GoodFeelController:_handlePM_GFViewStoryRes(status, msg)
	if status == 0 then
		GoodFeelModel.instance:setViewStoryRes(msg)
		GlobalDispatcher:dispatch(GoodFeelController.PM_GFViewStoryRes)
	end
end

function GoodFeelController:_handlePM_GFGetEventInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GoodFeelController.PM_GFGetEventInfoRes, msg)
	end
end

function GoodFeelController:_handlePM_GFHandleEventRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GoodFeelController:_handlePM_GFGainPrizeRes(status, msg)
	if status == 0 then
		GoodFeelModel.instance:setGainPrizeRes(msg.raceId, msg.newPrizeGainBit)
		GlobalDispatcher:dispatch(GoodFeelController.PM_GFGainPrizeRes)
	end
end

function GoodFeelController:_handlePM_GFNotifyAfterHandleEventRes(status, msg)
	if status == 0 then
		if not self._isXiaoNuoAssistant then
			if msg.settleResultCode == 0 then
				GoodFeelModel.instance:afterHandleEventRes(msg)
				GlobalDispatcher:dispatch(GoodFeelModel.ChangePetShow)
			else
				local str = MsgFlowMgr.instance:getResultCodeStr(msg.settleResultCode)

				FloatWordMgr.instance:show(str)
			end
		elseif msg.settleResultCode == 0 then
			GoodFeelModel.instance:afterHandleEventResByXiaoNuoAssistant(msg)
		end
	end

	self._isXiaoNuoAssistant = nil
end

function GoodFeelController:addUseItemListener()
	GlobalDispatcher:addListener(MaterialAgent.BatchUseMaterialRes, self._useGiftRes, self)
end

function GoodFeelController:removeUseItemListener()
	GlobalDispatcher:removeListener(MaterialAgent.BatchUseMaterialRes, self._useGiftRes, self)
end

function GoodFeelController:_useGiftRes(status, msg)
	if status == 0 then
		local list = GoodFeelModel.instance:getCachePetInfo()
		local lastLv = GoodFeelModel.instance:getPetGoodFeelLv(list.raceId)

		GoodFeelModel.instance:fixSetAddExp(list.raceId, list.addExp)

		local currLv = GoodFeelModel.instance:getPetGoodFeelLv(list.raceId)

		print("lbc=========", list.raceId, lastLv, currLv, list.addExp)
		self:_playStory(list.raceId, lastLv, currLv)
		GlobalDispatcher:dispatch(GoodFeelController.RealUseGift)
		GlobalDispatcher:dispatch(GoodFeelController.UpdateSendGifeUpLvDot)
	else
		GlobalDispatcher:dispatch(GoodFeelController.UseGiftError)
		GoodFeelModel.instance:setUnlockData()
	end
end

function GoodFeelController:_playStory(raceId, lastLv, currLv)
	if lastLv < currLv then
		local unlockData = GoodFeelModel.instance:getUnlockData()

		if not unlockData then
			return
		end

		GlobalDispatcher:dispatch(GoodFeelController.PlayLvUpEffect)

		local goodFeelLv = currLv
		local cfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)
		local vCfg = GoodFeelConfig.instance:getUnlockVoiceCfgs(raceId)
		local sCfg = GoodFeelConfig.instance:getStroyCfgsByPlantId(cfg.storyPlan)
		local cvCfg = CharacterConfig.instance:getPetCvCfg(raceId)
		local unlockStoryStr = ""
		local unlockVoiceStr = ""

		for k, v in ipairs(vCfg) do
			if goodFeelLv >= v.goodfeelUnlockLv and lastLv < v.goodfeelUnlockLv and cvCfg[k] then
				unlockVoiceStr = cvCfg[k].usageScenarios

				break
			end
		end

		if sCfg then
			for k, v in pairs(sCfg) do
				if goodFeelLv >= v.unlockLv and lastLv < v.unlockLv then
					unlockStoryStr = v.name

					break
				end
			end
		end

		local hasVoic = not string.nilorempty(unlockVoiceStr)

		if hasVoic or (not string.nilorempty(unlockStoryStr) or nil) and true then
			UIStateManager.instance:push(ViewName.GoodfeelunlockView, unlockData)
		end

		local list = GoodFeelModel.instance:getRandomLvupList(raceId, unlockData.skinId)

		if #list > 0 then
			local index = math.random(1, #list)
			local cfg = list[index]

			PetCvController.instance:_playPetCvByCfg(cfg)
		end
	end
end

function GoodFeelController:sendPM_GFHandleEventReq(raceId, win, isXiaoNuoAssistant, handler, handlerObj, errHandler)
	GoodFeelingAgent.instance:sendPM_GFHandleEventReq(raceId, win, handler, handlerObj, errHandler)

	self._isXiaoNuoAssistant = isXiaoNuoAssistant
end

GoodFeelController.instance = GoodFeelController.New()

return GoodFeelController
