-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/controller/DivineSKLieXinClgController.lua

module("logic.extensions.divineskliexinclg.controller.DivineSKLieXinClgController", package.seeall)

local DivineSKLieXinClgController = class("DivineSKLieXinClgController", BaseController)

function DivineSKLieXinClgController:ctor()
	return
end

function DivineSKLieXinClgController:onInit()
	self:onReset()
end

function DivineSKLieXinClgController:onReset()
	return
end

function DivineSKLieXinClgController:handlePM_DivineSKLieXinClgGetInfoRes(msg)
	DivineSKLieXinClgModel.instance:savaInfo(msg)
end

function DivineSKLieXinClgController:handlePM_Notify_DivineSKLieXinClgChallengeRes(msg)
	if msg.pass then
		DivineSKLieXinClgModel.instance:savaChallengeInfo(msg)

		local params = {
			title = "目 标",
			content = langPara("浴火重生次数：%d次", msg.reliveCount)
		}

		if msg.changeSetId then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)

			params.hasReward = true
		end

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SimplyDesc, params)
	end
end

function DivineSKLieXinClgController:openMissionView(activityId, stageId)
	local fmtMo = DivineSKLieXinClgModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineSKLieXinClgController:getTotalScore(utScorePlanId, reliveCount, tagCount, baseScore)
	local score = baseScore
	local utScoreCfg = DivineSKLieXinClgConfig.instance:getUtScorePlanCfg(utScorePlanId)

	if utScoreCfg ~= nil then
		local maxIndex = 0

		for k, v in pairs(utScoreCfg[1]) do
			if maxIndex < v.count and reliveCount >= v.count then
				maxIndex = v.count
			end
		end

		if maxIndex ~= 0 then
			score = score + utScoreCfg[1][maxIndex].score
		end

		maxIndex = 0

		for k, v in pairs(utScoreCfg[2]) do
			if maxIndex < v.count and tagCount >= v.count then
				maxIndex = v.count
			end
		end

		if maxIndex ~= 0 then
			score = score + utScoreCfg[2][maxIndex].score
		end
	end

	return score
end

function DivineSKLieXinClgController:getCollectPetCount(activityId)
	local collectCount = 0
	local activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(activityId)

	if activityCfg.collectRaceIds and #activityCfg.collectRaceIds > 0 then
		for i, v in ipairs(activityCfg.collectRaceIds) do
			if BagModel.instance:getPetIdByRaceId(v) ~= nil then
				collectCount = collectCount + 1
			end
		end
	end

	return collectCount
end

DivineSKLieXinClgController.instance = DivineSKLieXinClgController.New()

return DivineSKLieXinClgController
