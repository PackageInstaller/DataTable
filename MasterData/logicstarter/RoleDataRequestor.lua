-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicstarter/starter/roledata/RoleDataRequestor.lua

module("logicstarter.starter.roledata.RoleDataRequestor", package.seeall)

local RoleDataRequestor = class("RoleDataRequestor")

function RoleDataRequestor:ctor()
	self._requestList = {
		self._loadPetBag,
		self._loadFormations,
		self._loadChallengeInfos,
		self._loadRequestPetAssist,
		self._loadRequestShareTask,
		self._loadRequestPlayerReturn,
		self._loadFriends,
		self._loadOfflineChatMsg,
		self._loadOnlinegift,
		self._loadMsgBox,
		self._loadPetTrialData,
		self._loadTitleData,
		self._loadMyCardData,
		self._loadStrenghData,
		self._loadQilinData,
		self._loadFamilySimpleData,
		self._loadRequestHalloweenGuest,
		self._loadRequestFireWorksInfo,
		self._loadAllPetEquips,
		self._loadAllPetDecorations,
		self._loadRequestEscortInfo,
		self._loadCutePetInfo,
		self._loadRequestHirePets,
		self._loadPowerCrystalData,
		self._loadNewHandCardInfo,
		self._loadPetCollegeInfo,
		self._loadThroneInfo,
		self._loadRequestWorldBossInfo,
		self._loadQuestionnaireInfo,
		self._loadStarGodPlusInfo,
		self._invitationCardInfo,
		self._loadPayShopInfo,
		self._loadSeniorRankZone,
		self._loadWarriorTowerProgress,
		self._loadHandBookInfo,
		self._loadMangTowerInfo,
		self._loadMountInfo,
		self._loadNinePlaceInfo,
		self._loadPayTempInfo,
		self._loadPetSkinInfo,
		self._loadTitleInfo,
		self._loadScenariocopyInfo,
		self._loadYearCardInfo,
		self._loadHeartMoneyCatInfo,
		self._loadTwinDragonChallenge,
		self._loadMaterialChallenge,
		self._loadAthenaBlessInfo,
		self._loadGatherTaskInfo,
		self._loadActivitySummaryInfo,
		self._loadTimeGate,
		self._loadHolyStripeInfo,
		self._loadPetTitle,
		self._loadKingdDragonChallenge,
		self._loadTutorSystem,
		self._loadSeasonMainCamp,
		self._loadNsop,
		self._loadEnergy,
		self._loadNuoYaChallenge,
		self._loadPeakTournament,
		self._loadHonourTowerRedPoint,
		self._loadAnniversaryKoi,
		self._loadEmoticonGroupInfo,
		self._loadMonthCardPacks,
		self._loadGroupRechargeInfo,
		self._loadMMTeamPassportInfo,
		self._loadTabFrameWork,
		self._loadSaintKnightTask,
		self._loadStarGodChallenge,
		self._loadRequestPotluckDinnerInfo,
		self._loadPetCardLottery,
		self._loadPackDiscountInfo,
		self._loadDiscountDressCollectRd,
		self._loadFanRuiLotteryInfo,
		self._loadThreeEliminationInfo,
		self._loadBadgeInfo,
		self._loadDivineasheslessDragonRedPoint,
		self._loadSummonMasterJiRedPoint,
		self._loadEternalFarmRedPoint,
		self._loadShareTaskTriggerInfo,
		self._loadOrimatGame,
		self._loadLanternFestival,
		self._loadRichmanXplanInfo,
		self._loadMiracleFindTreasureInfo,
		self._loadTeenChampionKingScheduleRedpoint,
		self._loadYoungChampionKingScheduleRedpoint,
		self._loadYouthArenaThirdScheduleRedpoint,
		self._loadSurvivalKingSignUpRedPoint,
		self._loadDomainAdventure,
		self._loadDragonAwakenInfo,
		self._loadHeadItem,
		self._loadDressInfo,
		self._loadMagicSchoolInfo,
		self._loadStoryPrizeTotalInfo,
		self._loadAngelInvestorGetInfo,
		self._loadRedPointInfo
	}
	self._curIndex = 0
	self._totalCount = #self._requestList
end

function RoleDataRequestor:_loadScenariocopyInfo()
	forcePrint("=====RoleDataRequestor:_loadScenariocopyInfo===")
	ScenariocopyController.instance:loadScenariocopyInfo()
end

function RoleDataRequestor:_loadAnimalInfo()
	forcePrint("=====RoleDataRequestor:_loadAnimalInfo===")
	ZooController.instance:loadAnimalInfo()
end

function RoleDataRequestor:_loadTitleInfo()
	TitleModel.instance:_loadLocalRed()
end

function RoleDataRequestor:_loadAthenaBlessInfo()
	return
end

function RoleDataRequestor:_loadRedPointInfo()
	forcePrint("=====RoleDataRequestor:_loadRedPointInfo===")
	RedPointController.instance:sendGetInfo()
end

function RoleDataRequestor:_loadPetSkinInfo()
	forcePrint("=====RoleDataRequestor:_loadPetSkinInfo===")
	PetskinController.instance:sendGetInfo()
end

function RoleDataRequestor:_loadPayTempInfo()
	forcePrint("=====RoleDataRequestor:_loadPayTempInfo===")
	PaytemptController.instance:sendGetInfo()
end

function RoleDataRequestor:_loadNinePlaceInfo()
	forcePrint("=====RoleDataRequestor:_loadNinePlaceInfo===")
	NinePlaceController.instance:sendPM_GetNinePlaceProcessInfoReq()
end

function RoleDataRequestor:_loadMountInfo()
	forcePrint("=====RoleDataRequestor:_loadMountInfo===")
	MountController.instance:getMountInfo()
end

function RoleDataRequestor:_loadMangTowerInfo()
	MangTowerController.instance:loadMangTowerInfo()
end

function RoleDataRequestor:_loadHandBookInfo()
	forcePrint("=====RoleDataRequestor:_loadHandBookInfo===")
	HandbookController.instance:checkDataAndCall()
end

function RoleDataRequestor:_loadWarriorTowerProgress()
	forcePrint("=====RoleDataRequestor:_loadWarriorTowerProgress===")
	WTowerController.instance:reqGetMainProgress()
end

function RoleDataRequestor:_loadSeniorRankZone()
	forcePrint("=====RoleDataRequestor:_loadSeniorRankZone===")
	SeniorArenaController.instance:getCurZoneInfo()
end

function RoleDataRequestor:_loadPayShopInfo()
	forcePrint("=====RoleDataRequestor:_loadPayShopInfo===")
	PayShopController.instance:sendGetAllPayShopBuyTimesReq()
end

function RoleDataRequestor:_loadEmoticonGroupInfo()
	forcePrint("=====RoleDataRequestor:_loadEmoticonGroupInfo===")
	PayShopController.instance:sendGetEmoticonGroupInfoReq()
end

function RoleDataRequestor:_loadQuestionnaireInfo()
	forcePrint("=====RoleDataRequestor:_loadQuestionnaireInfo===")
	SurveyAgent.instance:sendPM_GetAllSurveyStatesReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadQuestionnaireInfo===back")
		QuestionnaireModel.instance:onServerMsg(msg)
	end)
end

function RoleDataRequestor:_loadChallengeInfos()
	forcePrint("=====RoleDataRequestor:_loadChallengeInfos===")
	UnlockFacade.instance:loadAllChallengeInfos()
end

function RoleDataRequestor:_loadTask()
	forcePrint("=====RoleDataRequestor:_loadTask===")
	TaskFacade.instance:loadUserTasks()
end

function RoleDataRequestor:_loadMaterials()
	forcePrint("=====RoleDataRequestor:_loadMaterials===")
	MaterialFacade.instance:loadMaterialInfos()
end

function RoleDataRequestor:_loadPetBag()
	forcePrint("=====RoleDataRequestor:_loadPetBag===")
	BagPetsFacade.instance:loadBagInfo()
end

function RoleDataRequestor:_loadFormations()
	forcePrint("=====RoleDataRequestor:_loadFormations===")
	FormationFacade.instance:loadFormations()
	forcePrint("=====RoleDataRequestor:_loadFormations+sendGetInfoOnce===")
	FormationGroupController.instance:sendGetInfoOnce()
end

function RoleDataRequestor:_loadFriends()
	forcePrint("=====RoleDataRequestor:_loadFriends===")
	FriendController.instance:LoadFriendsInfo()
end

function RoleDataRequestor:_loadOfflineChatMsg()
	forcePrint("=====RoleDataRequestor:_loadOfflineChatMsg===")
	NewChatFacade.instance:LoadOfflineMsg()
end

function RoleDataRequestor:_loadGodRace()
	return
end

function RoleDataRequestor:_loadPetStair()
	forcePrint("=====RoleDataRequestor:_loadPetStair===")
	SpriteLadderFacade.instance:loadPetStairInfo()
end

function RoleDataRequestor:_loadArena()
	forcePrint("=====RoleDataRequestor:_loadArena===")
	ArenaController.instance:getArenaInfos()
end

function RoleDataRequestor:_loadOnlinegift()
	return
end

function RoleDataRequestor:_loadMsgBox()
	return
end

function RoleDataRequestor:_loadHeartMoneyCatInfo()
	forcePrint("=====RoleDataRequestor:_loadHeartMoneyCatInfo===")

	local activityInfo = HeartMoneyCatController.instance:getActivityInfo()

	if activityInfo then
		TreasureBasinAgent.instance:sendPM_TreasureBasinGetInfoReq(activityInfo.activityId)
	end
end

function RoleDataRequestor:_loadTwinDragonChallenge()
	forcePrint("=====RoleDataRequestor:_loadTwinDragonChallenge===")
	IntegrationChallengeAgent.instance:sendPM_ICGetMainBoardInfoReq(IntegrationChallengeModel.TwinDragon)
end

function RoleDataRequestor:_loadLocalDate()
	local l = LocalUserDataController.instance:start()
end

function RoleDataRequestor:_loadPetTrialData()
	return
end

function RoleDataRequestor:_loadTitleData()
	forcePrint("=====RoleDataRequestor:_loadTitleData===")
	TitleAgent.instance:sendPM_LoadAllTitleReq()
end

function RoleDataRequestor:_loadMyCardData()
	return
end

function RoleDataRequestor:_loadStrenghData()
	forcePrint("=====RoleDataRequestor:_loadStrenghData===")
	SupplyController.instance:getSupplyInfo()
end

function RoleDataRequestor:_loadRequestPlayerReturn()
	forcePrint("=====RoleDataRequestor:_loadRequestPlayerReturn===")
	PlayerReturnController.instance:csRegressGetActInfoReq()
end

function RoleDataRequestor:_loadAllPetEquips()
	PetEquipController.instance:CSLoadAllEquipmentsReq()
	forcePrint("=====RoleDataRequestor:_loadAllPetEquips===")
end

function RoleDataRequestor:_loadAllPetDecorations()
	PetEquipController.instance:CSLoadAllDecorationReq()
	forcePrint("=====RoleDataRequestor:_loadAllPetDecorations===")
end

function RoleDataRequestor:_loadRequestEscortInfo()
	EscortController.instance:CSRequestEscortInfo()
	forcePrint("=====RoleDataRequestor:_loadRequestEscortInfo===")
end

function RoleDataRequestor:_loadRequestPetAssist()
	PetAssistController.instance:CSLoadAssistInfoReq()
	forcePrint("=====RoleDataRequestor:_loadRequestPetAssist===")
end

function RoleDataRequestor:_loadRequestShareTask()
	ShareTaskController.instance:CSShareTaskInfoReq()
	forcePrint("=====RoleDataRequestor:_loadRequestShareTask===")
end

function RoleDataRequestor:_loadRequestHirePets()
	PetLeaseController.instance:CSRequestHirePetsInfo()
	PetHireController.instance:getAllHirePetInfo()
	forcePrint("=====RoleDataRequestor:_loadRequestHirePets===")
end

function RoleDataRequestor:_loadRequestRecallShop()
	RecallTaskController.instance:scGetAllShopItemInfoReq()
	forcePrint("=====RoleDataRequestor:_loadRequestRecallShop===")
end

function RoleDataRequestor:_loadRequestHalloweenGuest()
	HalloweenGuestController.instance:csGetHalloweenSceneMonsterGetInfoReq()
	forcePrint("=====RoleDataRequestor:_loadRequestHalloweenGuest===")
end

function RoleDataRequestor:_loadRequestPotluckDinnerInfo()
	PartySummaryController.instance:csGetPotluckDinnerInfoReq()
	forcePrint("=====RoleDataRequestor:_loadRequestPotluckDinnerInfo===")
end

function RoleDataRequestor:_loadFamilySimpleData()
	FamilyController.instance:getMyFamilySimpleInfoReq()
	forcePrint("=====RoleDataRequestor:_loadFamilySimpleData===")
end

function RoleDataRequestor:_loadRequestFireWorksInfo()
	FireworkController.instance:getInfo()
	forcePrint("=====RoleDataRequestor:_loadRequestFireWorksInfo===")
end

function RoleDataRequestor:_loadGatherTaskInfo()
	GatherTaskController.instance:getInfo()
	forcePrint("=====RoleDataRequestor:_loadGatherTaskInfo===")
end

function RoleDataRequestor:_loadRequestWorldBossInfo()
	WorldBossController.instance:loginRequestWorldBossInfo()
	forcePrint("=====RoleDataRequestor:_loadRequestWorldBossInfo===")
end

function RoleDataRequestor:_loadStarGodPlusInfo()
	StargodplusController.instance:sendPM_LoadAllFillerReq()
	forcePrint("=====RoleDataRequestor:_loadStarGodPlusInfo===")
end

function RoleDataRequestor:_loadQilinData()
	forcePrint("=====RoleDataRequestor:_loadQilinData===")
	NewHandAgent.instance:sendGetKirinInfoReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadQilinData===back")

		local isReceived = msg ~= nil and checknumber(msg.kirinGainTime) == -2

		RoleModel.instance:setQilinReceived(isReceived)
		GlobalDispatcher:dispatch(GlobalNotify.GetQilinData)
	end)
end

function RoleDataRequestor:_loadPowerCrystalData()
	return
end

function RoleDataRequestor:_loadRefreshLuckyDrawId()
	LuckyDrawController.instance:refreshActivtyId()
end

function RoleDataRequestor:_loadNewHandCardInfo()
	forcePrint("=====RoleDataRequestor:_loadNewHandCardInfo===")
	NewHandCardAgent.instance:sendPM_NewHandCardInfoReq()
end

function RoleDataRequestor:_loadPetCollegeInfo()
	forcePrint("=====RoleDataRequestor:_loadPetCollegeInfo===")
	PetCollegeController.instance:requireProcessInfo()
end

function RoleDataRequestor:_loadThroneInfo()
	forcePrint("=====RoleDataRequestor:_loadThroneInfo===")
	ThroneController.instance:sendPM_LoadAllThronesReq()
end

function RoleDataRequestor:_loadHoshigamiInfo()
	forcePrint("=====RoleDataRequestor:_loadHoshigamiInfo===")
	HoshigamiController.instance:sendPM_LoadAllHoshigamiReq()
end

function RoleDataRequestor:_invitationCardInfo()
	forcePrint("=====RoleDataRequestor:_invitationCardInfo===")
	OpSummaryController.instance:reqOpenInvitationData()
end

function RoleDataRequestor:_loadYearCardInfo()
	forcePrint("=====RoleDataRequestor:_loadYearCardInfo===")
	YearCardController.instance:getUserAnnuityInfo()
end

function RoleDataRequestor:_loadMaterialChallenge()
	forcePrint("=====RoleDataRequestor:_loadMaterialChallenge===")
	MaterialChallengeController.instance:sendMCLG_GetRewardMultiplyTimesReq()
end

function RoleDataRequestor:_loadMonthCardPacks()
	MonthCardPackController.instance:loadActivityInfo()
end

function RoleDataRequestor:_loadActivitySummaryInfo()
	ActivitySummaryController.instance:sendGetInfoReq()
end

function RoleDataRequestor:_loadHolyStripeInfo()
	HolyStripeController.instance:sendPM_HolyStripeLoadAllReq()
end

function RoleDataRequestor:_loadGroupRechargeInfo()
	forcePrint("=====RoleDataRequestor:_loadGroupRechargeInfo===")
	GroupRechargeController.instance:loadInfo()
end

function RoleDataRequestor:_loadMMTeamPassportInfo()
	forcePrint("=====RoleDataRequestor:_loadMMTeamPassportInfo===")

	local activityId = checknumber(MMTeamPassportController.instance:getActivityId())

	if activityId > 0 and ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		MMTeamPassportController.instance:sendPM_MMTeamPassportGetInfoReq(activityId)
	end
end

function RoleDataRequestor:_loadPetTitle()
	forcePrint("=====RoleDataRequestor:_loadPetTitle===")
	PetTitleController.instance:reqServerData()
end

function RoleDataRequestor:_loadTabFrameWork()
	TabFrameWorkController.instance:loadTabFrameWork()
end

function RoleDataRequestor:_loadSaintKnightTask()
	SaintKnightTaskController.instance:loadSaintKnightTask()
end

function RoleDataRequestor:_loadStarGodChallenge()
	StarGodChallengeController.instance:sendGetInfoReq()
end

function RoleDataRequestor:_loadKingdDragonChallenge()
	forcePrint("=====RoleDataRequestor:_loadKingdDragonChallenge===")
	KdChallengeController.instance:loadKingdDragonChallenge()
end

function RoleDataRequestor:_loadTutorSystem()
	forcePrint("=====RoleDataRequestor:_loadTutorSystem===")
	TutorSystemController.instance:loadTutorSystem()
end

function RoleDataRequestor:_loadSeasonMainCamp()
	forcePrint("=====RoleDataRequestor:_loadSeasonMainCamp===")
	SeasonMainCampController.instance:sendGetSeasonMainCampInfo()
end

function RoleDataRequestor:_loadNsop()
	forcePrint("=====RoleDataRequestor:_loadNsop===")
	NewSummonPetObtainController.instance:loadNsop()
end

function RoleDataRequestor:_loadEnergy()
	forcePrint("=====RoleDataRequestor:_loadEnergy===")
	EnergyController.instance:loadEnergy()
end

function RoleDataRequestor:_loadNuoYaChallenge()
	forcePrint("=====RoleDataRequestor:_loadNuoYaChallenge===")
	KdChallengeController.instance:loadNuoYaChallenge()
end

function RoleDataRequestor:_loadYoungChampionKingScheduleRedpoint()
	forcePrint("=====RoleDataRequestor:_loadYoungChampionKingScheduleRedpoint===")
	YoungChampionKingController.instance:loadKnockoutInfo()
end

function RoleDataRequestor:_loadTeenChampionKingScheduleRedpoint()
	forcePrint("=====RoleDataRequestor:_loadTeenChampionKingScheduleRedpoint===")
	TeenChampionKingController.instance:loadKnockoutInfo()
end

function RoleDataRequestor:_loadYouthArenaThirdScheduleRedpoint()
	forcePrint("=====RoleDataRequestor:_loadYouthArenaThirdScheduleRedpoint===")
	YouthArenaThirdController.instance:loadMyScheduleRedPoint()
end

function RoleDataRequestor:_loadSurvivalKingSignUpRedPoint()
	forcePrint("=====RoleDataRequestor:_loadSurvivalKingSignUpRedPoint===")
	SurvivalKingController.instance:loadSignUpRedPoint()
end

function RoleDataRequestor:_loadDomainAdventure()
	forcePrint("=====RoleDataRequestor:_loadDomainAdventure===")
	DomainAdventureController.instance:loadDomainAdventure()
end

function RoleDataRequestor:_loadPeakTournament()
	forcePrint("=====RoleDataRequestor:_loadPeakTournament===")
	PeakTournamentController.instance:loadPeakTournament()
end

function RoleDataRequestor:_loadHonourTowerRedPoint()
	forcePrint("=====RoleDataRequestor:_loadHonourTowerRedPoint===")
	HonourTowerController.instance:loadHonourTowerRedPoint()
end

function RoleDataRequestor:_loadAnniversaryKoi()
	forcePrint("=====RoleDataRequestor:_loadAnniversaryKoi===")
	AnniversaryKoiController.instance:setRdInfo()
end

function RoleDataRequestor:_loadPetCardLottery()
	forcePrint("=====RoleDataRequestor:_loadPetCardLottery===")
	PetCardLotteryController.instance:setRdInfo()
end

function RoleDataRequestor:_loadCutePetInfo()
	forcePrint("=====RoleDataRequestor:_loadCutePetInfo===")
	CutePetController.instance:sendPM_EnterGameLoadInfoReq()
end

function RoleDataRequestor:_loadPackDiscountInfo()
	forcePrint("=====RoleDataRequestor:_loadPackDuscountInfo===")
	PackDiscountController.instance:showHudInMain()
end

function RoleDataRequestor:_loadDiscountDressCollectRd()
	forcePrint("=====RoleDataRequestor:_loadDiscountDressCollectRd===")
	DressSellController.instance:refreshCollectRedPoint()
end

function RoleDataRequestor:_loadFanRuiLotteryInfo()
	forcePrint("=====RoleDataRequestor:_loadFanRuiLotteryInfo===")
	FanRuiLotteryController.instance:getInfo()
end

function RoleDataRequestor:_loadThreeEliminationInfo()
	forcePrint("=====RoleDataRequestor:_sendPM_ThreeEliminationGetInfo4RedPointReqOnLoginIn===")
	ThreeEliminationController.instance:sendPM_ThreeEliminationGetInfo4RedPointReqOnLoginIn()
	forcePrint("=====RoleDataRequestor:_loadThreeEliminationGame===")
	ThreeEliminationController.instance:loadThreeEliminationGame()
end

function RoleDataRequestor:_loadBadgeInfo()
	forcePrint("=====RoleDataRequestor:_sendPM_LoadAllBadgeReq===")
	BadgeController.instance:getBadgeInfo()
end

function RoleDataRequestor:_loadShareTaskTriggerInfo()
	forcePrint("=====RoleDataRequestor:_loadShareTaskTriggerInfo===")
	ShareTaskController.instance:sendShareTaskStopTriggerInfoReq()
end

function RoleDataRequestor:_loadOrimatGame()
	forcePrint("=====RoleDataRequestor:_loadOrimatGame===")
	OriMatGameController.instance:loadOrimatGame()
end

function RoleDataRequestor:_loadLanternFestival()
	forcePrint("=====RoleDataRequestor:_loadLanternFestival===")
	LanternFestivalController.instance:loadLanternFestival()
end

function RoleDataRequestor:_loadTimeGate()
	TimeGateController.instance:getInfo()
end

function RoleDataRequestor:_loadDivineasheslessDragonRedPoint()
	DivineasheslessdragonController.instance:loadBaseData()
end

function RoleDataRequestor:_loadSummonMasterJiRedPoint()
	SummonMasterJiController.instance:loadBaseInfo()
end

function RoleDataRequestor:_loadEternalFarmRedPoint()
	forcePrint("=====RoleDataRequestor:_loadEternalFarmRedPoint===")
	EternalFarmController.instance:loadBaseData()
end

function RoleDataRequestor:_loadRichmanXplanInfo()
	RichmanxplanController.instance:loadInfoInStartGame()
end

function RoleDataRequestor:_loadMiracleFindTreasureInfo()
	MiraclefindtreasureController.instance:loadInfoInStartGame()
end

function RoleDataRequestor:_loadDragonAwakenInfo()
	DragonAwakenController.instance:loadRedPointInfo()
end

function RoleDataRequestor:_loadHeadItem()
	forcePrint("=====RoleDataRequestor:_loadHeadItem===")
	HeadItemController.instance:sendGetInfo()
end

function RoleDataRequestor:_loadDressInfo()
	DressController.instance:sendGetNotoutInfoReq()
end

function RoleDataRequestor:_loadMagicSchoolInfo()
	forcePrint("=====RoleDataRequestor:_loadMagicSchoolInfo===")
	MagicSchoolController.instance:sendSartGameMagicSchoolGetInfoReq()
end

function RoleDataRequestor:_loadStoryPrizeTotalInfo()
	StoryPrizeController.instance:sendPM_StoryPrizeTotalInfoReq()
end

function RoleDataRequestor:_loadAngelInvestorGetInfo()
	AngelInvestorController.instance:sendAngelInvestorGetInfoReq()
end

function RoleDataRequestor:start()
	MsgFlowMgr.instance:setCanForcePrintCmd(true)
	self:_loadLocalDate()

	self._curIndex = 0
	self._totalCount = #self._requestList

	settimer(0.2, self._onTick, self, true)
end

function RoleDataRequestor:resume()
	if self._totalCount > 0 and self._curIndex < self._totalCount then
		self:stop()
		settimer(0.2, self._onTick, self, true)
	end
end

function RoleDataRequestor:_onTick()
	self._curIndex = self._curIndex + 1

	if self._curIndex <= self._totalCount then
		local curFun = self._requestList[self._curIndex]

		if not curFun then
			print(self._curIndex .. "   " .. self._totalCount)
		end

		curFun(self)
	end

	if self._curIndex >= self._totalCount then
		self:stop()
	end
end

function RoleDataRequestor:stop()
	MsgFlowMgr.instance:setCanForcePrintCmd(false)
	removetimer(self._onTick, self)
end

RoleDataRequestor.instance = RoleDataRequestor.New()

return RoleDataRequestor
