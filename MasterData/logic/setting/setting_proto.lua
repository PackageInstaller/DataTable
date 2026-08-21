-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/setting/setting_proto.lua

local setting_proto = {}

setting_proto = {
	{
		{
			"LogoutRequest",
			"LogoutReply"
		},
		{
			"GetServerTimeRequest",
			"GetServerTimeReply"
		},
		[255] = "UserExtension",
		[5] = {
			"SendDeviceInfoRequest",
			"SendDeviceInfoReply"
		},
		[6] = {
			"OnImportantInstantPush"
		},
		[7] = {
			"UploadStatsRequest",
			"UploadStatsReply"
		},
		[8] = {
			"RealNameNotifyPush"
		},
		[9] = {
			"ServerGitVersionPush"
		},
		[10] = {
			"SendDevicePerformanceMetricRequest",
			"SendDevicePerformanceMetricReply"
		}
	},
	{
		{
			"LoadBagRequest",
			"LoadBagReply"
		},
		{
			"ItemChangedPush"
		},
		{
			"UseItemRequest",
			"UseItemReply",
			block = true
		},
		{
			"ExchangeCurrencyRequest",
			"ExchangeCurrencyReply",
			block = true
		},
		{
			"ExchangeRemainedTimesRequest",
			"ExchangeRemainedTimesReply"
		},
		{
			"GetPrefabItemInfoRequest",
			"GetPrefabItemInfoReply"
		},
		{
			"removeRedPointRequest",
			"removeRedPointReply"
		},
		{
			"ComposeRequest",
			"ComposeReply"
		},
		[255] = "BackpackExtension"
	},
	{
		[255] = "BattleExtension",
		[2] = {
			"OnEventTriggeredPush"
		},
		[3] = {
			"PostEventAnimationRequest",
			"PostEventAnimationReply"
		},
		[4] = {
			"StepRequest",
			"StepReply",
			block = true
		},
		[5] = {
			"EndStageRequest",
			"EndStageReply",
			block = true
		},
		[6] = {
			"SurrenderRequest",
			"SurrenderReply",
			block = true
		},
		[7] = {
			"PlaceEntityRequest",
			"PlaceEntityReply",
			block = true
		},
		[8] = {
			"RemoveEntityRequest",
			"RemoveEntityReply",
			block = true
		},
		[9] = {
			"MoveEntityRequest",
			"MoveEntityReply",
			block = true
		},
		[10] = {
			"EndReadyRequest",
			"EndReadyReply",
			block = true
		},
		[11] = {
			"LogBattleLogPush"
		},
		[12] = {
			"SetAiControlledRequest",
			"SetAiControlledReply",
			block = true
		},
		[13] = {
			"ForecastRequest",
			"ForecastReply"
		},
		[15] = {
			"ResultForecastPush"
		},
		[16] = {
			"AnimationPostedPush"
		},
		[17] = {
			"ConnectStateChangePush"
		},
		[18] = {
			"ReadyStartPush"
		},
		[19] = {
			"BattleStartPush"
		},
		[20] = {
			"ConnectRequest",
			"ConnectReply",
			block = true
		},
		[21] = {
			"ConnectCompleteRequest",
			"ConnectCompleteReply",
			block = true
		},
		[22] = {
			"DisconnectRequest",
			"DisconnectReply",
			block = true
		},
		[23] = {
			"CancelReadyRequest",
			"CancelReadyReply",
			block = true
		},
		[24] = {
			"ForecastAiRequest",
			"ForecastAiReply"
		},
		[25] = {
			"ResultForecastAiPush"
		},
		[26] = {
			"BackToRequest",
			"BackToReply"
		},
		[27] = {
			"UnfinishedBattlePush"
		},
		[28] = {
			"DeleteUnfinishedBattleRequest",
			"DeleteUnfinishedBattleReply"
		},
		[29] = {
			"ReconnectBattleRequest",
			"ReconnectBattleReply"
		},
		[30] = {
			"UnfinishedBattleExpiredPush"
		},
		[31] = {
			"GetBackInfoRequest",
			"GetBackInfoReply"
		}
	},
	{
		{
			"LoadTeamsRequest",
			"TeamsInfoReply"
		},
		{
			"EditTeamNameRequest",
			"TeamsInfoReply"
		},
		{
			"DeleteTeamRequest",
			"DeleteTeamReply"
		},
		{
			"SaveTeamRoleRequest",
			"TeamsInfoReply"
		},
		[255] = "TeamEditExtension"
	},
	{
		{
			"GetDungeonInfoRequest",
			"GetDungeonInfoReply"
		},
		{
			"StartDungeonRequest",
			"StartDungeonReply",
			block = true
		},
		[255] = "DungeonExtension",
		[4] = {
			"TakeMainlineStarRewardRequest",
			"TakeMainlineStarRewardReply"
		},
		[5] = {
			"EndDungeonWithStarsPush"
		},
		[6] = {
			"ChangeLastBattleTeamPush"
		},
		[7] = {
			"TakeTrainingRewardRequest",
			"TakeTrainingRewardReply"
		},
		[8] = {
			"PassPlotDungeonRequest",
			"PassPlotDungeonReply",
			block = true
		},
		[9] = {
			"FinishPostwarPlotRequest",
			"FinishPostwarPlotReply"
		},
		[10] = {
			"SaveLastRecordRequest",
			"SaveLastRecordReply"
		},
		[11] = {
			"ViewVideoRequest",
			"ViewVideoReply"
		},
		[12] = {
			"GetConsecutiveInfoRequest",
			"GetConsecutiveInfoReply"
		}
	},
	{
		{
			"GmRequest",
			"GmReply"
		},
		{
			"ServerExceptionPush"
		},
		{
			"DummyBattlePush"
		},
		{
			"DummyLottery1Push"
		},
		{
			"DummyLottery2Push"
		},
		{
			"DummyLottery3Push"
		},
		{
			"DelayShutdownPush"
		},
		{
			"CancelDelayShutdownRequest",
			"CancelDelayShutdownReply"
		},
		{
			"GetBattleHackableInfoRequest",
			"GetBattleHackableInfoReply"
		},
		{
			"HackBattleInfoRequest",
			"HackBattleInfoReply"
		},
		[255] = "GmExtension",
		[20] = {
			"RoguelikeRoomPush"
		}
	},
	{
		{
			"LoadHerosRequest",
			"LoadHerosReply"
		},
		{
			"HeroInfoPush"
		},
		{
			"AddHeroExpRequest",
			"AddHeroExpReply",
			block = true
		},
		{
			"HeroSkillEnhanceRequest",
			"HeroSkillEnhanceReply"
		},
		{
			"HeroSkillEnhanceUpdatePush"
		},
		{
			"LoadHeroWeightRequest",
			"LoadHeroWeightReply"
		},
		[255] = "HeroExtension"
	},
	{
		{
			"LoadPlayerRequest",
			"LoadPlayerReply"
		},
		[255] = "PlayerExtension",
		[3] = {
			"PlayerInfoPush"
		},
		[4] = {
			"EnergyInfoPush"
		},
		[5] = {
			"LevelInfoPush"
		},
		[6] = {
			"PrologueFinishStageRequest",
			"PrologueFinishStageReply"
		},
		[7] = {
			"UseEnergyItemsRequest",
			"UseEnergyItemsReply",
			block = true
		},
		[8] = {
			"ChangeNicknameRequest",
			"ChangeNicknameReply"
		},
		[9] = {
			"GetPlayerCardInfoRequest",
			"GetPlayerCardInfoReply",
			block = true
		},
		[10] = {
			"ChangePortraitRequest",
			"ChangePortraitReply"
		},
		[11] = {
			"ChangeDisplayCardRequest",
			"ChangeDisplayCardReply"
		},
		[13] = {
			"ChangeDisplayHeroRequest",
			"ChangeDisplayHeroReply",
			block = true
		},
		[14] = {
			"ChangeDisplayHeroSkinRequest",
			"ChangeDisplayHeroSkinReply",
			block = true
		},
		[15] = {
			"ChangeBirthdayRequest",
			"ChangeBirthdayReply"
		},
		[16] = {
			"ChangeSignRequest",
			"ChangeSignReply"
		},
		[17] = {
			"UpgradePlayerCardAttributeRequest",
			"UpgradePlayerCardAttributeReply"
		},
		[18] = {
			"GetUnlockInfoRequest",
			"GetUnlockInfoReply",
			block = true
		},
		[19] = {
			"UnlockPush"
		},
		[20] = {
			"GetPlayerDisplayInfoRequest",
			"GetPlayerDisplayInfoReply",
			block = true
		},
		[21] = {
			"GetHeroDetailInfoRequest",
			"GetHeroDetailInfoReply"
		},
		[22] = {
			"SetDisplayContentRequest",
			"SetDisplayContentReply"
		},
		[23] = {
			"SetDisplayTargetRequest",
			"SetDisplayTargetReply"
		},
		[24] = {
			"FinishCreatePlayerRequest",
			"FinishCreatePlayerReply"
		}
	},
	{
		{
			"GetTaskInfoRequest",
			"GetTaskInfoReply",
			block = true
		},
		{
			"TakeTaskRewardRequest",
			"TakeTaskRewardReply",
			block = true
		},
		{
			"MarkPrimaryTaskRequest",
			"MarkPrimaryTaskReply",
			block = true
		},
		{
			"GetPrimaryTaskInfoRequest",
			"GetPrimaryTaskInfoReply",
			block = true
		},
		{
			"NotifyTaskProgressPush"
		},
		{
			"WakeupRequest",
			"WakeupReply",
			block = true
		},
		[255] = "TacitExtension"
	},
	{
		{
			"HeroComposeRequest",
			"HeroComposeReply"
		},
		{
			"HeroBreakUpRequest",
			"HeroBreakUpReply"
		},
		[255] = "HeroBreakExtension"
	},
	{
		{
			"HeroPowerInfoRequest",
			"HeroPowerInfoReply",
			block = true
		},
		{
			"HeroNodeActRequest",
			"HeroNodeActReply",
			block = true
		},
		{
			"HeroExtNodeActRequest",
			"HeroExtNodeActReply",
			block = true
		},
		{
			"HeroPowerInfoPush"
		},
		[255] = "HeroPowerExtension"
	},
	[13] = {
		{
			"HeroSkinInfoRequest",
			"HeroSkinInfoReply",
			block = true
		},
		[255] = "HeroSkinExtension",
		[3] = {
			"HeroSkinSetRequest",
			"HeroSkinSetReply"
		},
		[4] = {
			"GetAllHeroSkinInfoRequest",
			"GetAllHeroSkinInfoReply",
			block = true
		}
	},
	[14] = {
		{
			"LoadInfoRequest",
			"LoadInfoReply"
		},
		{
			"LoadScriptRequest",
			"LoadScriptReply"
		},
		{
			"StartRequest",
			"StartReply"
		},
		{
			"SortRequest",
			"SortReply",
			block = true
		},
		{
			"NextLayerRequest",
			"NextLayerReply",
			block = true
		},
		{
			"MoveRequest",
			"MoveReply",
			block = true
		},
		{
			"StartEventRequest",
			"StartEventReply",
			block = true
		},
		{
			"StartJudgeRequest",
			"StartJudgeReply"
		},
		{
			"EndJudgeRequest",
			"EndJudgeReply"
		},
		{
			"TakeEffectRequest",
			"TakeEffectReply"
		},
		[255] = "RoguelikeExtension",
		[12] = {
			"JudgeArchiveRequest",
			"JudgeArchiveReply"
		},
		[13] = {
			"QuitRequest",
			"QuitReply"
		},
		[14] = {
			"AddPropsRequest",
			"AddPropsReply",
			block = true
		},
		[15] = {
			"DropPropsRequest",
			"DropPropsReply"
		},
		[16] = {
			"LoadAllRoomPrizesRequest",
			"LoadAllRoomPrizesReply"
		},
		[17] = {
			"MallBuyRequest",
			"MallBuyReply"
		},
		[18] = {
			"GetGuessNumRequest",
			"GetGuessNumReply"
		},
		[19] = {
			"GuessDiceRequest",
			"GuessDiceReply"
		},
		[20] = {
			"GuessDiceResultRequest",
			"GuessDiceResultReply"
		},
		[21] = {
			"GuessDiceGetRewardRequest",
			"GuessDiceGetRewardReply"
		},
		[22] = {
			"LuckyDiceRequest",
			"LuckyDiceReply",
			block = true
		},
		[23] = {
			"GetAllEquipRequest",
			"GetAllEquipReply"
		},
		[25] = {
			"UpgradeEquipRequest",
			"UpgradeEquipReply"
		},
		[26] = {
			"UseSkillRequest",
			"UseSkillReply"
		},
		[27] = {
			"RoguelikeListTaskRequest",
			"RoguelikeListTaskReply"
		},
		[28] = {
			"RoguelikeTaskRewardRequest",
			"RoguelikeTaskRewardReply"
		},
		[29] = {
			"TouchRequest",
			"TouchReply"
		},
		[30] = {
			"LoadLogsRequest",
			"LoadLogsReply"
		},
		[31] = {
			"EndRoundRequest",
			"EndRoundReply"
		},
		[32] = {
			"SetCardCdRequest",
			"SetCardCdReply"
		},
		[33] = {
			"EndSelectRequest",
			"EndSelectReply"
		},
		[34] = {
			"EndSelectCardRequest",
			"EndSelectCardReply"
		},
		[35] = {
			"StartCardSelectHeroRequest",
			"StartCardSelectHeroReply"
		},
		[41] = {
			"GoldUpdatePush"
		},
		[42] = {
			"PlayerInfoUpdatePush"
		},
		[43] = {
			"SelectPropsPush"
		},
		[44] = {
			"MonsterPush"
		},
		[45] = {
			"EventPush"
		},
		[46] = {
			"MapUpdatePush"
		},
		[47] = {
			"EffectPush"
		},
		[48] = {
			"RoomPrizesUpdatePush"
		},
		[49] = {
			"StoryPush"
		},
		[50] = {
			"GameOverPush"
		},
		[51] = {
			"EquipPush"
		},
		[52] = {
			"RoguelikeRefreshTaskPush"
		},
		[53] = {
			"MapConfigPush"
		},
		[54] = {
			"GetCluePush"
		},
		[55] = {
			"SeedPush"
		},
		[56] = {
			"ScriptPush"
		}
	},
	[15] = {
		{
			"GetSelfHouseInfoRequest",
			"GetSelfHouseInfoReply"
		},
		{
			"SetJobScheduleRequest",
			"SetJobScheduleReply"
		},
		{
			"GetTradePostInfoRequest",
			"GetTradePostInfoReply"
		},
		{
			"RefreshDailyOrderRequest",
			"RefreshDailyOrderReply",
			block = true
		},
		{
			"AcceptOrderRequest",
			"AcceptOrderReply",
			block = true
		},
		{
			"GainOrderPush"
		},
		{
			"OrderSpeedUpRequest",
			"OrderSpeedUpReply",
			block = true
		},
		{
			"GetGoodsPriceRequest",
			"GetGoodsPriceReply"
		},
		{
			"SaleTradeGoodsRequest",
			"SaleTradeGoodsReply",
			block = true
		},
		{
			"TradePostLevelUpRequest",
			"TradePostLevelUpReply"
		},
		{
			"GetSingleHoldRoomInfoRequest",
			"GetSingleHoldRoomInfoReply"
		},
		{
			"GetHoldRoomInfoRequest",
			"GetHoldRoomInfoReply"
		},
		[255] = "HouseExtension",
		[14] = {
			"StopHoldProtomerRequest",
			"StopHoldProtomerReply",
			block = true
		},
		[15] = {
			"UpgradeProtomerModuleRequest",
			"UpgradeProtomerModuleReply",
			block = true
		},
		[16] = {
			"GetProtomerInfoRequest",
			"GetProtomerInfoReply"
		},
		[17] = {
			"ChangeProtomerRequest",
			"ChangeProtomerReply",
			block = true
		},
		[18] = {
			"GetReportsRequest",
			"GetReportsReply"
		},
		[19] = {
			"ReceiveReportRequest",
			"ReceiveReportReply",
			block = true
		},
		[20] = {
			"ReceiveAllReportRequest",
			"ReceiveAllReportReply",
			block = true
		},
		[21] = {
			"HoldSpeedUpRequest",
			"HoldSpeedUpReply",
			block = true
		},
		[22] = {
			"ChangeBillboardRequest",
			"ChangeBillboardReply",
			block = true
		},
		[23] = {
			"GainReportPush"
		},
		[24] = {
			"GainProtomerPush"
		},
		[25] = {
			"GetSingleHeroFeatureRequest",
			"GetSingleHeroFeatureReply"
		},
		[26] = {
			"GetHeroFeatureRequest",
			"GetHeroFeatureReply"
		},
		[27] = {
			"GetHouseInfoRequest",
			"GetHouseInfoReply"
		},
		[28] = {
			"ActiveZoneRequest",
			"ActiveZoneReply"
		},
		[29] = {
			"GetLiveZoneInfoRequest",
			"GetLiveZoneInfoReply"
		},
		[30] = {
			"SetZoneNameRequest",
			"SetZoneNameReply"
		},
		[31] = {
			"GetBunkInfoRequest",
			"GetBunkInfoReply"
		},
		[32] = {
			"SetScheduleRequest",
			"SetScheduleReply",
			block = true
		},
		[33] = {
			"ChangeZoneTypeRequest",
			"ChangeZoneTypeReply"
		},
		[34] = {
			"SetBunkRequest",
			"SetBunkReply",
			block = true
		},
		[35] = {
			"GetFurnituresRequest",
			"GetFurnituresReply"
		},
		[36] = {
			"SaveFurnituresRequest",
			"SaveFurnituresReply",
			block = true
		},
		[37] = {
			"GetFurnitureTemplateRequest",
			"GetFurnitureTemplateReply"
		},
		[38] = {
			"SaveFurnitureTemplateRequest",
			"SaveFurnitureTemplateReply",
			block = true
		},
		[39] = {
			"SetReportsReadRequest",
			"SetReportsReadReply"
		},
		[40] = {
			"JobHeroChangeRequest",
			"JobHeroChangeReply"
		},
		[41] = {
			"SetWorkScheduleRequest",
			"SetWorkScheduleReply",
			block = true
		},
		[42] = {
			"SetHolidayRequest",
			"SetHolidayReply"
		},
		[43] = {
			"GetAllBunkInfoRequest",
			"GetAllBunkInfoReply"
		},
		[44] = {
			"GetManagerInfoRequest",
			"GetManagerInfoReply"
		},
		[45] = {
			"ManagerLevelUpRequest",
			"ManagerLevelUpReply"
		},
		[46] = {
			"ManagerStoreAddPush"
		},
		[47] = {
			"ReceiveManagerStoreRequest",
			"ReceiveManagerStoreReply",
			block = true
		},
		[48] = {
			"GetManufactureInfoRequest",
			"GetManufactureInfoReply"
		},
		[49] = {
			"ManufactureLevelUpRequest",
			"ManufactureLevelUpReply"
		},
		[50] = {
			"ChangeManufactureSchemaRequest",
			"ChangeManufactureSchemaReply",
			block = true
		},
		[51] = {
			"ManufactureSpeedUpRequest",
			"ManufactureSpeedUpReply",
			block = true
		},
		[52] = {
			"PlantStoreAddPush"
		},
		[53] = {
			"ReceivePlantStoreRequest",
			"ReceivePlantStoreReply",
			block = true
		},
		[54] = {
			"ReceiveHouseRewardsRequest",
			"ReceiveHouseRewardsReply",
			block = true
		},
		[55] = {
			"DecomposeFurnituresRequest",
			"DecomposeFurnituresReply",
			block = true
		},
		[56] = {
			"GoodsPricePush"
		},
		[57] = {
			"SetRestScheduleRequest",
			"SetRestScheduleReply",
			block = true
		},
		[58] = {
			"HouseListTaskRequest",
			"HouseListTaskReply"
		},
		[59] = {
			"HouseRewardRequest",
			"HouseRewardReply",
			block = true
		},
		[60] = {
			"HouseRefreshTaskPush"
		},
		[61] = {
			"ReceiveLevelRewardRequest",
			"ReceiveLevelRewardReply",
			block = true
		},
		[62] = {
			"HouseExpChangePush"
		},
		[63] = {
			"FurnitureChangePush"
		},
		[64] = {
			"AddGoodsStoreRequest",
			"AddGoodsStoreReply"
		},
		[65] = {
			"HeroThoughtEduRequest",
			"HeroThoughtEduReply",
			block = true
		},
		[66] = {
			"MakeFurnitureRequest",
			"MakeFurnitureReply",
			block = true
		},
		[67] = {
			"SpRoomStoreAddPush"
		},
		[68] = {
			"ReceiveSpRoomStoreRequest",
			"ReceiveSpRoomStoreReply",
			block = true
		},
		[69] = {
			"DeleteFurnitureTemplateRequest",
			"DeleteFurnitureTemplateReply",
			block = true
		},
		[70] = {
			"GoodsIntelligencePush"
		},
		[71] = {
			"ManufactureSchemaChangePush"
		}
	},
	[16] = {
		{
			"GetGuideInfoRequest",
			"GetGuideInfoReply"
		},
		[255] = "NewbieExtension",
		[3] = {
			"FinishGuideRequest",
			"FinishGuideReply"
		},
		[4] = {
			"GetTaskListRequest",
			"GetTaskListReply",
			block = true
		},
		[5] = {
			"FinishTaskRequest",
			"FinishTaskReply",
			block = true
		},
		[6] = {
			"TakeStepRewardRequest",
			"TakeStepRewardReply",
			block = true
		},
		[7] = {
			"GetPlotAnswersRequest",
			"GetPlotAnswersReply",
			block = true
		},
		[8] = {
			"SetPlotAnswersRequest",
			"SetPlotAnswersReply",
			block = true
		},
		[9] = {
			"JumpPlotRequest",
			"JumpPlotReply",
			block = true
		}
	},
	[17] = {
		[255] = "EquipmentExtension",
		[3] = {
			"EquipWearRequest",
			"EquipWearReply"
		},
		[4] = {
			"EquipTakeOffRequest",
			"EquipTakeOffReply"
		},
		[5] = {
			"EquipStrengthenRequest",
			"EquipStrengthenReply"
		},
		[6] = {
			"EquipDecomposeRequest",
			"EquipDecomposeReply"
		},
		[7] = {
			"DiceDecomposeRequest",
			"DiceDecomposeReply"
		},
		[10] = {
			"EquipLockToggleRequest",
			"EquipLockToggleReply"
		},
		[11] = {
			"DiceLockToggleRequest",
			"DiceLockToggleReply"
		},
		[12] = {
			"EquipChangePush"
		},
		[13] = {
			"DiceChangePush"
		},
		[14] = {
			"EquipDiscardToggleRequest",
			"EquipDiscardToggleReply"
		},
		[15] = {
			"DiceDiscardToggleRequest",
			"DiceDiscardToggleReply"
		}
	},
	[18] = {
		{
			"GetEchoItemInfoRequest",
			"GetEchoItemInfoReply"
		},
		{
			"WearEchoItemRequest",
			"WearEchoItemReply",
			block = true
		},
		{
			"LockEchoItemRequest",
			"LockEchoItemReply"
		},
		{
			"UpgradeEchoItemRequest",
			"UpgradeEchoItemReply",
			block = true
		},
		{
			"DecomposeEchoItemRequest",
			"DecomposeEchoItemReply",
			block = true
		},
		[255] = "EchoItemExtension",
		[10] = {
			"ChangeEchoItemPush"
		}
	},
	[19] = {
		{
			"GetPoolInfoRequest",
			"GetPoolInfoReply",
			block = true
		},
		{
			"LotteryRequest",
			"LotteryReply",
			block = true
		},
		{
			"GetLotteryLogRequest",
			"GetLotteryLogReply",
			block = true
		},
		{
			"PickLotteryItemRequest",
			"PickLotteryItemReply",
			block = true
		},
		{
			"LotteryEchoRequest",
			"LotteryEchoReply",
			block = true
		},
		[255] = "LotteryExtension"
	},
	[20] = {
		{
			"GetActivityInfoRequest",
			"GetActivityInfoReply"
		},
		{
			"ChangeActivityPush"
		},
		{
			"GetSignInInfoRequest",
			"GetSignInInfoReply"
		},
		{
			"TakeSignInRewardRequest",
			"TakeSignInRewardReply"
		},
		{
			"GetScoreActivityInfoRequest",
			"GetScoreActivityInfoReply"
		},
		{
			"GainScoreActivityRewardRequest",
			"GainScoreActivityRewardReply"
		},
		{
			"GetHeroEarlyAccessRewardRequest",
			"GetHeroEarlyAccessRewardReply"
		},
		{
			"TakeWeekendSuppliesRequest",
			"TakeWeekendSuppliesReply"
		},
		{
			"DungeonRewardUpCountPush"
		},
		{
			"UseGiftCodeRequest",
			"UseGiftCodeReply"
		},
		[255] = "ActivityExtension"
	},
	[21] = {
		{
			"GetMailInfoRequest",
			"GetMailInfoReply",
			block = true
		},
		{
			"MarkMailReadRequest",
			"MarkMailReadReply"
		},
		{
			"TakeMailAttachmentRequest",
			"TakeMailAttachmentReply",
			block = true
		},
		{
			"TakeAllMailAttachmentRequest",
			"TakeAllMailAttachmentReply",
			block = true
		},
		{
			"RemoveAllReadMailRequest",
			"RemoveAllReadMailReply",
			block = true
		},
		{
			"UnlockSecretMailRequest",
			"UnlockSecretMailReply",
			block = true
		},
		{
			"GetHistoryMailInfoRequest",
			"GetHistoryMailInfoReply",
			block = true
		},
		{
			"NotifyNewMailPush"
		},
		[255] = "MailExtension"
	},
	[22] = {
		{
			"GetSystemOpenInfoRequest",
			"GetSystemOpenInfoReply"
		},
		{
			"ConditionUnlockedPush"
		},
		{
			"CloseSystemEntryPush"
		},
		{
			"ClientOpenSystemRequest",
			"ClientOpenSystemReply"
		},
		[255] = "SystemOpenExtension"
	},
	[23] = {
		{
			"GetMallListRequest",
			"GetMallListReply"
		},
		{
			"GetGoodsListRequest",
			"GetGoodsListReply"
		},
		{
			"BuyGoodsRequest",
			"BuyGoodsReply",
			block = true
		},
		{
			"ManualRefreshGoodsRequest",
			"ManualRefreshGoodsReply"
		},
		{
			"MonthlyCardRewardPush"
		},
		{
			"OrderSuccessPush"
		},
		{
			"TryTakeMonthlyCardRewardRequest",
			"TryTakeMonthlyCardRewardReply"
		},
		[255] = "MallExtension"
	},
	[24] = {
		{
			"GetAllThinkingRequest",
			"GetAllThinkingReply"
		},
		{
			"GetHeroThinkingRequest",
			"GetHeroThinkingReply"
		},
		{
			"UnlockThinkingRequest",
			"UnlockThinkingReply",
			block = true
		},
		{
			"WearThinkingRequest",
			"WearThinkingReply",
			block = true
		},
		[255] = "ThinkingExtension",
		[6] = {
			"ThinkingSkillUpgradeRequest",
			"ThinkingSkillUpgradeReply",
			block = true
		},
		[7] = {
			"ChangeThinkingPush"
		},
		[8] = {
			"ChangeThinkingWearInfoPush"
		}
	},
	[25] = {
		[255] = "TextDetectExtension",
		[2] = {
			"CheckDescriptionRequest",
			"CheckDescriptionReply"
		},
		[3] = {
			"GenerateImageUploadingTokenRequest",
			"GenerateImageUploadingTokenReply"
		}
	},
	[26] = {
		{
			"RefreshPush"
		},
		{
			"OnTaskSchedulePush"
		},
		{
			"ListTaskRequest",
			"ListTaskReply"
		},
		{
			"RewardRequest",
			"RewardReply",
			block = true
		},
		{
			"RefreshTaskPush"
		},
		{
			"HomeTaskPush"
		},
		[255] = "TaskExtension"
	},
	[27] = {
		{
			"GetAllAchievementRequest",
			"GetAllAchievementReply",
			block = true
		},
		{
			"GetAllCupRequest",
			"GetAllCupReply",
			block = true
		},
		{
			"TakeRewardRequest",
			"TakeRewardReply",
			block = true
		},
		{
			"FinishPush"
		},
		{
			"TakeAchievementSkillLevelRewardRequest",
			"TakeAchievementSkillLevelRewardReply",
			block = true
		},
		[255] = "AchievementExtension"
	},
	[28] = {
		{
			"LoadAllRedPointRequest",
			"LoadAllRedPointReply"
		},
		{
			"RemoveRedPointRequest",
			"RemoveRedPointReply"
		},
		{
			"ChangeRedPointPush"
		},
		[255] = "RedPointExtension"
	},
	[29] = {
		{
			"GetUserListRequest",
			"GetUserListReply"
		},
		{
			"UserListUpdatePush"
		},
		{
			"ApplyFriendRequest",
			"ApplyFriendReply"
		},
		{
			"AgreeApplyRequest",
			"AgreeApplyReply"
		},
		{
			"RefuseApplyRequest",
			"RefuseApplyReply"
		},
		{
			"RemoveFriendRequest",
			"RemoveFriendReply"
		},
		{
			"ChangeAliasRequest",
			"ChangeAliasReply"
		},
		{
			"BlockUserRequest",
			"BlockUserReply"
		},
		{
			"UnBlockUserRequest",
			"UnBlockUserReply"
		},
		{
			"ReportUserRequest",
			"ReportUserReply"
		},
		{
			"SearchUserRequest",
			"SearchUserReply"
		},
		{
			"FeedbackRequest",
			"FeedbackReply"
		},
		[255] = "FriendExtension"
	},
	[30] = {
		{
			"SendMessageRequest",
			"SendMessageReply"
		},
		{
			"NewMessagePush"
		},
		{
			"BroadcastPush"
		},
		[255] = "ChatExtension"
	},
	[31] = {
		{
			"UnlockPlotMemoryRequest",
			"UnlockPlotMemoryReply"
		},
		{
			"GetMonsterCommentRequest",
			"GetMonsterCommentReply"
		},
		{
			"CommitMonsterCommentRequest",
			"CommitMonsterCommentReply"
		},
		[255] = "GalleryExtension"
	},
	[32] = {
		{
			"GetMyInfoRequest",
			"GetMyInfoReply"
		},
		{
			"StartMatchRequest",
			"StartMatchReply"
		},
		{
			"StopMatchRequest",
			"StopMatchReply"
		},
		{
			"MatchCompletePush"
		},
		{
			"GroupInfoPush"
		},
		[255] = "GroupExtension"
	},
	[33] = {
		{
			"GetRankListRequest",
			"GetRankListReply"
		},
		{
			"GetRankInfoRequest",
			"GetRankInfoReply"
		},
		{
			"GetDungeonTeamRequest",
			"GetDungeonTeamReply"
		},
		[255] = "RankExtension"
	},
	[34] = {
		{
			"GetRecordListRequest",
			"GetRecordListReply"
		},
		{
			"SettleResultPush"
		},
		{
			"BingoPush"
		},
		{
			"ResetPush"
		},
		[255] = "FootballExtension"
	},
	[35] = {
		{
			"RodeoInfoRequest",
			"RodeoInfoReply"
		},
		{
			"PlayRecordRequest",
			"PlayRecordReply"
		},
		{
			"RodeoMatchRequest",
			"RodeoMatchReply",
			block = true
		},
		{
			"RodeoStartRequest",
			"RodeoStartReply",
			block = true
		},
		{
			"RodeoGiveUpRequest",
			"RodeoGiveUpReply",
			block = true
		},
		{
			"FreeSelectRequest",
			"FreeSelectReply",
			block = true
		},
		{
			"FreeMatchRequest",
			"FreeMatchReply",
			block = true
		},
		{
			"FreeStartRequest",
			"FreeStartReply",
			block = true
		},
		{
			"EndlessMatchRequest",
			"EndlessMatchReply",
			block = true
		},
		{
			"EndlessStartRequest",
			"EndlessStartReply",
			block = true
		},
		{
			"EndlessGiveUpRequest",
			"EndlessGiveUpReply",
			block = true
		},
		{
			"FreeEndlessInfoRequest",
			"FreeEndlessInfoReply"
		},
		[255] = "AirAtkExtension",
		[14] = {
			"LikeRequest",
			"LikeReply",
			block = true
		},
		[15] = {
			"TagRequest",
			"TagReply",
			block = true
		},
		[16] = {
			"SettleWeekRequest",
			"SettleWeekReply",
			block = true
		},
		[17] = {
			"GetHotMapRequest",
			"GetHotMapReply",
			block = true
		},
		[18] = {
			"GetAirPageRequest",
			"GetAirPageReply",
			block = true
		},
		[19] = {
			"GetAirCupPageRequest",
			"GetAirCupPageReply",
			block = true
		},
		[20] = {
			"GetCreatedMapPageRequest",
			"GetCreatedMapPageReply",
			block = true
		},
		[21] = {
			"GetLikedMapPageRequest",
			"GetLikedMapPageReply",
			block = true
		},
		[22] = {
			"GetHistoryPageRequest",
			"GetHistoryPageReply",
			block = true
		},
		[23] = {
			"ExchangeRequest",
			"ExchangeReply",
			block = true
		},
		[24] = {
			"GetRodeoRankRequest",
			"GetRodeoRankReply"
		},
		[30] = {
			"ChallengeNumChange"
		},
		[31] = {
			"WeekSettlePush"
		},
		[32] = {
			"BattleSettlePush"
		},
		[33] = {
			"RodeoFinishPush"
		}
	},
	[36] = {
		{
			"GetAirMapListRequest",
			"GetAirMapListReply"
		},
		{
			"CreateAirMapRequest",
			"CreateAirMapReply"
		},
		{
			"ModifyAirMapRequest",
			"ModifyAirMapReply"
		},
		{
			"DeleteAirMapRequest",
			"DeleteAirMapReply"
		},
		{
			"TestAirMapRequest",
			"TestAirMapReply"
		},
		{
			"TestAirMapResultPush"
		},
		{
			"ModifyAirMapOnlineStateRequest",
			"ModifyAirMapOnlineStateReply"
		},
		{
			"GetAirMapCellKillRequest",
			"GetAirMapCellKillReply"
		},
		{
			"GetAirMapStatisticsRequest",
			"GetAirMapStatisticsReply"
		},
		[255] = "AirStudioDefExtension",
		[11] = {
			"GetHotMapByTagRequest",
			"GetHotMapByTagReply",
			block = true
		},
		[12] = {
			"GetAirInfoRequest",
			"GetAirInfoReply"
		},
		[13] = {
			"GetAirTaskListRequest",
			"GetAirTaskListReply"
		},
		[14] = {
			"FinishAirTaskRequest",
			"FinishAirTaskReply",
			block = true
		},
		[16] = {
			"CommentRequest",
			"CommentReply",
			block = true
		},
		[17] = {
			"GetCommentsRequest",
			"GetCommentsReply",
			block = true
		},
		[18] = {
			"GetAirMapTemplatesRequest",
			"GetAirMapTemplatesReply"
		},
		[19] = {
			"GetAirMapNewsRequest",
			"GetAirMapNewsReply",
			block = true
		},
		[20] = {
			"ReadMapCommentsRequest",
			"ReadMapCommentsReply",
			block = true
		},
		[21] = {
			"ReadMapNewsRequest",
			"ReadMapNewsReply",
			block = true
		},
		[22] = {
			"ReadAgreementRequest",
			"ReadAgreementReply",
			block = true
		}
	},
	[37] = {
		{
			"CommitSurveyRequest",
			"CommitSurveyReply"
		},
		{
			"AvailableSurveyPush"
		},
		[255] = "SurveyExtension"
	},
	[38] = {
		{
			"SeasonInfoRequest",
			"SeasonInfoReply"
		},
		{
			"ReportRequest",
			"ReportReply"
		},
		{
			"SeasonListTaskRequest",
			"SeasonListTaskReply"
		},
		{
			"UpgradeRequest",
			"UpgradeReply"
		},
		{
			"UnlockVipRequest",
			"UnlockVipReply"
		},
		{
			"TakeTaskPointRequest",
			"TakeTaskPointReply"
		},
		{
			"TakeLvRewardRequest",
			"TakeLvRewardReply"
		},
		[255] = "SeasonExtension",
		[10] = {
			"PointPush"
		},
		[11] = {
			"SeasonSettle"
		},
		[12] = {
			"ReceiveScheduleRewardRequest",
			"ReceiveScheduleRewardReply"
		}
	},
	[39] = {
		{
			"GetAirtightRoomInfoRequest",
			"GetAirtightRoomInfoReply"
		},
		{
			"EnterAirtightRoomRequest",
			"EnterAirtightRoomReply"
		},
		{
			"AirtightRoomStatusChangePush"
		},
		{
			"ExperienceAirtightRoomRequest",
			"ExperienceAirtightRoomReply"
		},
		[255] = "AirtightRoomExtension"
	},
	[40] = {
		{
			"GetBattleRecordListRequest",
			"GetBattleRecordListReply"
		},
		{
			"GetBattleRecordRequest",
			"GetBattleRecordReply"
		},
		[255] = "BattleRecordExtension"
	},
	[41] = {
		{
			"UploadCidRequest",
			"UploadCidReply"
		},
		{
			"NotifyPush"
		},
		[255] = "NotifyExtension"
	},
	[43] = {
		{
			"GetControlActionsRequest",
			"GetControlActionsReply"
		},
		{
			"GetPostListRequest",
			"GetPostListReply"
		},
		{
			"GetPostRequest",
			"GetPostReply"
		},
		{
			"LikePostRequest",
			"LikePostReply"
		},
		{
			"CancelLikePostRequest",
			"CancelLikePostReply"
		},
		{
			"GetUnlockedProtomersRequest",
			"GetUnlockedProtomersReply"
		},
		{
			"HoldProtomerRequest",
			"HoldProtomerReply"
		},
		{
			"GetTaskRewardRequest",
			"GetTaskRewardReply"
		},
		[255] = "ControlActionExtension"
	},
	[44] = {
		{
			"GrowthPlanRequest",
			"GrowthPlanReply"
		},
		{
			"PlanStartPush"
		},
		{
			"GrowthStageRewardRequest",
			"GrowthStageRewardReply"
		},
		{
			"GrowthTasksRequest",
			"GrowthTasksReply"
		},
		{
			"GrowthTaskRewardRequest",
			"GrowthTaskRewardReply"
		},
		[255] = "GrowthPlanExtension"
	},
	[45] = {
		{
			"SavePresetRequest",
			"SavePresetReply"
		},
		{
			"DeletePresetRequest",
			"DeletePresetReply"
		},
		{
			"PresetsChangedPush"
		},
		{
			"ApplyPresetRequest",
			"ApplyPresetReply"
		},
		[255] = "PresetExtension"
	},
	[46] = {
		{
			"GetClipDollInfoRequest",
			"GetClipDollInfoReply"
		},
		{
			"ClipDollRequest",
			"ClipDollReply"
		},
		{
			"DollsChangePush"
		},
		{
			"RedeemPrizeRequest",
			"RedeemPrizeReply"
		},
		[255] = "ClipDollExtension"
	},
	[47] = {
		{
			"GetRechargeInfoRequest",
			"GetRechargeInfoReply"
		},
		{
			"ReceiveAccumulateRequest",
			"ReceiveAccumulateReply"
		},
		{
			"ReceiveFirstRequest",
			"ReceiveFirstReply"
		},
		[255] = "RechargeExtension"
	},
	[48] = {
		{
			"GetMonthSignInInfoRequest",
			"GetMonthSignInInfoReply"
		},
		{
			"SignInRequest",
			"SignInReply"
		},
		[255] = "MonthSignInExtension"
	}
}

setglobal("setting_proto", setting_proto)

return setting_proto
