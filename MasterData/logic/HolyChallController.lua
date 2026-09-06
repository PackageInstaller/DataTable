-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/controller/HolyChallController.lua

module("logic.extensions.kingway.controller.HolyChallController", package.seeall)

local HolyChallController = class("HolyChallController", BaseController)

function HolyChallController:onInit()
	self.isFirstRequest = true

	HolyChallengeAgent.instance:addHandler(HolyChallengeAgent.PM_HCSaveFormRes, self.CSReceiveSaveForm, self)
	HolyChallengeAgent.instance:addHandler(HolyChallengeAgent.PM_HCGainFinalPrizeRes, self.SCReceiveGainFinalPrize, self)
	HolyChallengeAgent.instance:addHandler(HolyChallengeAgent.PM_HCChallengeEndRes, self.SCReceiveChallengeEnd, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.TickDailyRefreshData, self)
end

function HolyChallController:onReset()
	self.isFirstRequest = true
end

function HolyChallController:TickDailyRefreshData()
	self.isFirstRequest = true

	self:CSRequestGetInfoReq()
end

function HolyChallController:CSRequestGetInfoReq()
	if not self.isFirstRequest then
		return
	end

	self.isFirstRequest = false

	HolyChallengeAgent.instance:sendPM_HCGetInfoReq(function(msg)
		HolyChallModel.instance:SetFeilongData(msg)
	end)
end

function HolyChallController:CSRequestFirstOpenFuncReq()
	HolyChallengeAgent.instance:sendPM_HCFirstOpenFuncReq()
end

function HolyChallController:CSRequestFirstOpenGuardReq(challId)
	HolyChallengeAgent.instance:sendPM_HCFirstOpenGuardReq(challId)
end

function HolyChallController:CSRequestGainDailyEnergyReq()
	HolyChallengeAgent.instance:sendPM_HCGainDailyEnergyReq(function(msg)
		HolyChallModel.instance:SetReceiveTodayEnergy(msg.newTotalEnergy)
	end)
end

function HolyChallController:CSRequestSaveFormReq(challId, form)
	HolyChallengeAgent.instance:sendPM_HCSaveFormReq(challId, form)
end

function HolyChallController:CSReceiveSaveForm(msg, status)
	if status ~= 0 or msg == nil or checknumber(msg.challengeId) <= 0 then
		return
	end

	HolyChallModel.instance:_saveAsSvrFometion(msg.form, msg.challengeId)
	HolyChallModel.instance:refreshForm(msg.form, msg.challengeId)
	GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
end

function HolyChallController:CSRequestChallengeGuardReq(battleId, stageId)
	HolyChallengeAgent.instance:sendPM_HCChallengeGuardReq(battleId, stageId, nil, nil, function()
		if ViewMgr.instance:isOpen(ViewName.HCGuardMission) or ViewMgr.instance:isOpen(ViewName.HCDragonMission) then
			UIStateManager.instance:clear(true)
			UIStateManager.instance:push(ViewName.HolyChall)
		end
	end)
end

function HolyChallController:CSRequestFeilongTrialReq(num)
	HolyChallengeAgent.instance:sendPM_HCTrialReq(num, nil, nil, function()
		if ViewMgr.instance:isOpen(ViewName.HCGuardMission) or ViewMgr.instance:isOpen(ViewName.HCDragonMission) then
			UIStateManager.instance:clear(true)
			UIStateManager.instance:push(ViewName.HolyChall)
		end
	end)
end

function HolyChallController:SCReceiveChallengeEnd(msg, status)
	if msg == nil or checknumber(msg.challengeId) <= 0 then
		return
	end

	HolyChallModel.instance:SetChallengePopupData()

	local stage = HolyChallModel.instance:GetCurrentFunctionStage()

	if stage == 1 then
		if msg.isWin then
			local cfg = HolyChallConfig.instance:GetChallStageCfg(msg.challengeId, msg.stageIdOrTimes)

			if cfg and checknumber(cfg.energyPrize) > 0 then
				local data = {
					isTrial = false,
					petName = cfg.name,
					energyPrize = cfg.energyPrize
				}

				HolyChallModel.instance:SetChallengePopupData(data)
			end
		end
	elseif stage == 2 then
		local info = HolyChallModel.instance:GetFeilongData()

		if info then
			if not info.accDamage then
				local nowCount = 0
				local newCount = msg.newAccDamage

				if nowCount < newCount then
					local energy = HolyChallModel.instance:GetTrialIntervalEnergy(nowCount, newCount)

					if energy > 0 then
						local data = {
							isTrial = true,
							currHit = newCount - nowCount,
							allHit = newCount,
							energyPrize = energy
						}

						HolyChallModel.instance:SetChallengePopupData(data)
					end
				end

				local allStr = HolyChallModel.instance:GetChallengeAllDamage()
				local haveStr = tostring(msg.newAccDamage)

				BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.HolyChall, {
					haveStr = (msg.newAccDamage > 9999 or nil) and string.format("%.1f", math.floor(msg.newAccDamage / 1000) / 10) .. "万",
					allStr = allStr
				})
			end
		end
	end

	HolyChallModel.instance:UpdataChallengeData(msg)
end

function HolyChallController:CSRequestGainFinalPrizeReq()
	HolyChallengeAgent.instance:sendPM_HCGainFinalPrizeReq()
end

function HolyChallController:SCReceiveGainFinalPrize(msg, status)
	local changeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	self:showThirdMv(function()
		if msg.rank > 0 then
			TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("恭喜！你是第%s名获得圣光飞龙玩家！", msg.rank), function()
				MaterialController.instance:showChangeSetInTemp(changeSetId)
			end)
		else
			MaterialController.instance:showChangeSetInTemp(changeSetId)
		end
	end)
end

function HolyChallController:showThirdMv(callBack)
	ViewBlockMgr.instance:blockClick(true, HolyChallController.instance)
	AnimationPlayer.play("storyconfig/animations/story_shengguangfeilong_donghua01.txt", function()
		ViewBlockMgr.instance:blockClick(false, HolyChallController.instance)
		GameUtil.callBack(callBack)
	end, function()
		PetCvController.instance:_playPetCvByIndex(10127, 1, false, null)
	end)
end

function HolyChallController:showRingBaoGo(baseInfo, ringGo, baoList, callBack)
	GameUtil.SetActive(ringGo, false)

	for i, go in ipairs(baoList) do
		GameUtil.SetActive(go, false)
	end

	local challList = baseInfo.challList

	if challList then
		for k, info in pairs(challList) do
			local challId = checknumber(k)

			if info.passedStageId >= 1 then
				GameUtil.callBack(callBack, challId)
			else
				GameUtil.SetActive(baoList[challId], true)
				GameUtil.SetActive(ringGo, true)
			end
		end
	end
end

function HolyChallController:playBao(obj)
	return
end

HolyChallController.instance = HolyChallController.New()

return HolyChallController
