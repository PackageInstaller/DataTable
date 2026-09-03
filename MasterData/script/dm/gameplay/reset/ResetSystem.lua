-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/reset/ResetSystem.lua

EVT_RESET_DONE = "EVT_RESET_DONE"
ResetSystem = class("ResetSystem", Facade, _M)

ResetSystem:has("_service", {
	is = "r"
}):injectWith("ResetService")

function ResetSystem:initialize()
	super.initialize(self)
end

function ResetSystem:requestResetPushSucc(resetIds, callback)
	local params = {
		resetIds = resetIds
	}

	self:getService():requestResetPushSucc(params, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end, true)
end

function ResetSystem:listenResetPush(callback)
	self:getService():listenResetPush(function(response)
		if response and #response > 0 then
			local resetList = response
			local delay = math.random(1, 15) * 1000

			delayCallByTime(delay, function()
				self:requestResetPushSucc(response, function(resetResponse)
					self:_doReset(resetList, resetResponse)
				end)
				self:getInjector():getInstance(PetRaceSystem):reset()
				self:getInjector():getInstance(StageSystem):reset()
			end)

			local settingSystem = self:getInjector():getInstance(SettingSystem)

			settingSystem:requestActivityHeadFrameInfo()
		end

		if callback then
			callback()
		end
	end)
end

ResetId = {
	kBlockSp_Equipment = "BlockSp_Equipment",
	kRecruitEquipFree = "DrawCard_EquipFree",
	kRecruitClubFree = "DrawCard_Club_Free",
	kActivity = "Activity_Reset",
	kShopBuyRefreshTimes = "Shop_BuyRefreshTime",
	kRecruitDiamondTimes = "DrawCard_DiamondTimesReward",
	kArenaScoreReward = "Arena_ScoreReward",
	kArenaChallengeTimes = "Arena_ChallengeTimes",
	kBlockSp_Skill_1 = "BlockSp_Skill_1",
	kArenaBuyChallengeTimes = "Arena_BuyChallengeTimes",
	kEliteStageCostTimes = "EliteStage_CostTimes",
	kRecruitPvpFree = "DrawCard_Pvp_Free",
	kGalleryDateTimes = "GalleryDateTimes",
	kRecruitPveFree = "DrawCard_Pve_Free",
	kBlockSp_Skill_2 = "BlockSp_Skill_2",
	kGoldStageReset = "BlockSp_Gold",
	kBattlePass_ClubTask = "BattlePass_ClubTask",
	kMapPointReset = "MapPointReset",
	kEightDayLogin = "EightDaysCheckIn_Reset",
	kRTPKReset = "PTPK_Reset",
	kBlockSp_Skill_3 = "BlockSp_Skill_3",
	kChessArenaReset = "ChessArena_ResetTime",
	kDailyTaskActivity = "DailyTask_Activity",
	kArenaChangeEnemyTimes = "Arena_ChangeEnemyTimes",
	kPowerBuyTimes = "Power_BuyTime",
	kShopReset = "Shop_Reset",
	kBattlePass_DailyTask = "BattlePass_DailyTask",
	kMapDailyRewardReset = "MapDailyRewardReset",
	kCrystalStageReset = "BlockSp_Crystal",
	kRecruitGoldFree = "DrawCard_GoldFree",
	kClubDonationTimes = "Club_Donation_Times",
	kMonthCard = "MonthCardReset",
	kClubBlockReset = "ClubBlock_Reset",
	kMonthSignIn = "CheckIn_Reset",
	kClubBlockTimesReset = "ClubBlock_Times",
	kEliteStageFreeTimes = "EliteStage_FreeTimes",
	kRecruitDiamondFree = "DrawCard_DiamondFree",
	kGoldBuyTimes = "BuyGold_BuyTime",
	kExpStageReset = "BlockSp_Exp"
}

local DoResetMap = {
	[ResetId.kRecruitGoldFree] = "RecruitSystem",
	[ResetId.kRecruitDiamondFree] = "RecruitSystem",
	[ResetId.kRecruitEquipFree] = "RecruitSystem",
	[ResetId.kRecruitPvpFree] = "RecruitSystem",
	[ResetId.kRecruitPveFree] = "RecruitSystem",
	[ResetId.kRecruitClubFree] = "RecruitSystem",
	[ResetId.kRecruitDiamondTimes] = "RecruitSystem",
	[ResetId.kEliteStageFreeTimes] = "StageSystem",
	[ResetId.kEliteStageCostTimes] = "StageSystem",
	[ResetId.kArenaChallengeTimes] = "ArenaSystem",
	[ResetId.kArenaScoreReward] = "ArenaSystem",
	[ResetId.kArenaChangeEnemyTimes] = "ArenaSystem",
	[ResetId.kArenaBuyChallengeTimes] = "ArenaSystem",
	[ResetId.kShopReset] = "ShopSystem",
	[ResetId.kGoldStageReset] = "SpStageSystem",
	[ResetId.kExpStageReset] = "SpStageSystem",
	[ResetId.kCrystalStageReset] = "SpStageSystem",
	[ResetId.kBlockSp_Equipment] = "SpStageSystem",
	[ResetId.kBlockSp_Skill_1] = "SpStageSystem",
	[ResetId.kBlockSp_Skill_2] = "SpStageSystem",
	[ResetId.kBlockSp_Skill_3] = "SpStageSystem",
	[ResetId.kDailyTaskActivity] = "TaskSystem",
	[ResetId.kActivity] = "ActivitySystem",
	[ResetId.kEightDayLogin] = "ActivitySystem",
	[ResetId.kMonthSignIn] = "MonthSignInSystem",
	[ResetId.kMonthCard] = "RechargeAndVipSystem",
	[ResetId.kGalleryDateTimes] = "GallerySystem",
	[ResetId.kMapDailyRewardReset] = "ExploreSystem",
	[ResetId.kMapPointReset] = "ExploreSystem",
	[ResetId.kClubBlockTimesReset] = "ClubSystem",
	[ResetId.kClubBlockReset] = "ClubSystem",
	[ResetId.kBattlePass_ClubTask] = "ActivitySystem",
	[ResetId.kBattlePass_DailyTask] = "ActivitySystem",
	[ResetId.kRTPKReset] = "RTPKSystem",
	[ResetId.kClubDonationTimes] = "ClubSystem",
	[ResetId.kChessArenaReset] = "ArenaNewSystem"
}

function ResetSystem:_doReset(resetIdList, response)
	if resetIdList == nil then
		return
	end

	if response then
		if not response.data then
			local responseData = {}
			local dData = response and response.d

			if dData then
				self._developSystem:syncPlayer(dData)
			end

			local resetIdsMap = {}

			for _, resetId in pairs(resetIdList) do
				resetIdsMap[resetId] = true

				local className = DoResetMap[resetId]

				if className then
					local doResetSystem = self:getInjector():getInstance(className)

					if doResetSystem and doResetSystem.doReset then
						local resetValue
						local config = ConfigReader:getRecordById("Reset", resetId)

						if config then
							local resetData = config.ResetSystem

							resetValue = resetData and resetData.setValue
						end

						if responseData then
							if not responseData[resetId] then
								local data

								doResetSystem:doReset(resetId, resetValue, data)
							end
						end
					end
				end
			end

			self:dispatch(Event:new(EVT_RESET_DONE, resetIdsMap))
			self:dispatch(Event:new(EVT_REDPOINT_REFRESH, resetIdsMap))
			self:dispatch(Event:new(EVT_RESOURCEDOUBLE_REFRESH, resetIdsMap))
		end
	end
end
