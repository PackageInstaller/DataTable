-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/setting/setting_proto.lua

local setting_proto = {}

setting_proto = {
	[-1] = {
		{
			"LoginRequest",
			"LoginResponse"
		},
		[255] = "SystemExtension",
		[3] = {
			"GetLostCmdRespRequest",
			"GetLostCmdRespResponse"
		},
		[4] = {
			"ForceLogoutResponse"
		}
	},
	{
		{
			"HeartBeatReq",
			"HeartBeatRes"
		},
		{
			"PM_ServerMsgNotifyRes"
		},
		{
			"OnDataClearRes"
		},
		[255] = "UserExtension",
		[6] = {
			"ExitGameReq",
			"ExitGameRes",
			block = true
		},
		[9] = {
			"PM_NotifyUserBanInfoChangeRes"
		},
		[10] = {
			"PM_CloseUserReq",
			"PM_CloseUserRes",
			block = true
		}
	},
	{
		{
			"GetAntiInfoReq",
			"GetAntiInfoRes",
			block = true
		},
		{
			"StartRelaxReq",
			"StartRelaxRes",
			block = true
		},
		{
			"StopRelaxReq",
			"StopRelaxRes",
			block = true
		},
		{
			"LoadReadNameInfoReq",
			"LoadReadNameInfoRes",
			block = true
		},
		[255] = "AntiAddictionExtension",
		[101] = {
			"NotifySdkCmd_WebRes"
		},
		[102] = {
			"NotifySdkCmd_HintRes"
		}
	},
	{
		{
			"LoadUserTasksReq",
			"LoadUserTasksRes",
			block = true
		},
		{
			"OpenTaskStarterReq",
			"OpenTaskStarterRes",
			block = true
		},
		{
			"OpenTaskStartersReq",
			"OpenTaskStartersRes",
			block = true
		},
		{
			"RunTaskStepReq",
			"RunTaskStepRes",
			block = true
		},
		{
			"GiveUpTaskReq",
			"GiveUpTaskRes",
			block = true
		},
		{
			"SaveClientDataReq",
			"SaveClientDataRes",
			block = true
		},
		[255] = "TaskExtension",
		[8] = {
			"NotifyUserTaskStateChangedRes"
		},
		[9] = {
			"NotifyTaskHandleFailureRes"
		},
		[10] = {
			"FinishTaskStepReq",
			"FinishTaskStepRes",
			block = true
		},
		[11] = {
			"NotifyTaskAvaliableChangedRes"
		},
		[13] = {
			"TaskFightMonsterReq",
			"TaskFightMonsterRes",
			block = true
		},
		[14] = {
			"TaskEVEMonsterFightReq",
			"TaskEVEMonsterFightRes",
			block = true
		},
		[15] = {
			"NotifyTaskFightEndRes"
		},
		[16] = {
			"BatchNotifyUserTaskStateChangedRes"
		}
	},
	{
		{
			"JoinAndLeaveRoomReq",
			"JoinAndLeaveRoomRes",
			block = true
		},
		{
			"CreateAndJoinRoomReq",
			"CreateAndJoinRoomRes",
			block = true
		},
		{
			"NotifyJoinRoomSucRes"
		},
		{
			"NotifyEnterRoomRes"
		},
		{
			"NotifyLeaveRoomToAllRes"
		},
		{
			"SetUserVariablesReq",
			"SetUserVariablesRes"
		},
		{
			"NotifyUserVariablesUpdateRes"
		},
		{
			"RefreshRoomDataReq",
			"RefreshRoomDataRes",
			block = true
		},
		{
			"MoveReq",
			"MoveRes"
		},
		{
			"NotifyMoveRes"
		},
		{
			"EnterGameReq",
			"EnterGameRes",
			block = true
		},
		{
			"NotifySceneMonsterChangedRes"
		},
		[255] = "RoomExtension"
	},
	{
		{
			"PM_BtlStartRes"
		},
		{
			"PM_NewRoundsGenRes"
		},
		{
			"PM_BtlEndRes"
		},
		{
			"PM_ContinueFightReq",
			"PM_ContinueFightRes"
		},
		{
			"PM_DoUserActionReq",
			"PM_DoUserActionRes",
			block = true
		},
		{
			"PM_SkipReq",
			"PM_SkipRes",
			block = true
		},
		[255] = "BattleExtension",
		[11] = {
			"FightSceneMonsterReq",
			"FightSceneMonsterRes",
			block = true
		}
	},
	{
		[255] = "PetExtension",
		[11] = {
			"PM_LoadUserPetsReq",
			"PM_LoadUserPetsRes",
			block = true
		},
		[12] = {
			"PM_BatchLoadUserPetFullViewOnLoginReq",
			"PM_BatchLoadUserPetFullViewOnLoginRes",
			block = true
		},
		[14] = {
			"PM_OnPetChanged"
		},
		[18] = {
			"PM_CompositePetPiecesReq",
			"PM_CompositePetPiecesRes",
			block = true
		},
		[19] = {
			"PM_PetAwakenReq",
			"PM_PetAwakenRes",
			block = true
		},
		[20] = {
			"PM_BatchPetAwakenReq",
			"PM_BatchPetAwakenRes",
			block = true
		},
		[21] = {
			"PM_GetPetAllContractInfoReq",
			"PM_GetPetAllContractInfoRes",
			block = true
		},
		[22] = {
			"PM_MakeContractReq",
			"PM_MakeContractRes"
		},
		[23] = {
			"PM_CancelContractReq",
			"PM_CancelContractRes"
		},
		[24] = {
			"PM_UpgradeTalentReq",
			"PM_UpgradeTalentRes",
			block = true
		},
		[25] = {
			"PM_ChangeLockStateReq",
			"PM_ChangeLockStateRes",
			block = true
		},
		[26] = {
			"PM_PetRareComposeReq",
			"PM_PetRareComposeRes",
			block = true
		},
		[27] = {
			"PM_UpgradePetSkillReq",
			"PM_UpgradePetSkillRes",
			block = true
		},
		[28] = {
			"PM_EvolvePetReq",
			"PM_EvolvePetRes",
			block = true
		},
		[29] = {
			"PM_ResetContractSkillReq",
			"PM_ResetContractSkillRes",
			block = true
		},
		[30] = {
			"PM_ConfirmContractSkillReq",
			"PM_ConfirmContractSkillRes",
			block = true
		},
		[31] = {
			"PM_PetSingleContractInfo"
		},
		[32] = {
			"PM_DivineEvolveReq",
			"PM_DivineEvolveRes",
			block = true
		},
		[33] = {
			"PM_GetDivineEvolveInfoReq",
			"PM_GetDivineEvolveInfoRes",
			block = true
		},
		[34] = {
			"PM_DivinePlusEvolveReq",
			"PM_DivinePlusEvolveRes",
			block = true
		},
		[35] = {
			"PM_OneKeyPetAwakenReq",
			"PM_OneKeyPetAwakenRes",
			block = true
		},
		[36] = {
			"PM_DivineExchangeReq",
			"PM_DivineExchangeRes",
			block = true
		},
		[37] = {
			"PM_ChangeablePetSelectedRaceTypeInfoReq",
			"PM_ChangeablePetSelectedRaceTypeInfoRes",
			block = true
		},
		[38] = {
			"PM_ChangeablePetSelectedReq",
			"PM_ChangeablePetSelectedRes",
			block = true
		},
		[39] = {
			"PM_CarriedLinkReq",
			"PM_CarriedLinkRes",
			block = true
		},
		[40] = {
			"PM_CancelCariedLinkReq",
			"PM_CancelCariedLinkRes",
			block = true
		},
		[41] = {
			"PM_OracleLinkReq",
			"PM_OracleLinkRes",
			block = true
		},
		[42] = {
			"PM_CancelOracleLinkReq",
			"PM_CancelOracleLinkRes",
			block = true
		},
		[43] = {
			"PM_LevelUpWithTalentLvReq",
			"PM_LevelUpWithTalentLvRes",
			block = true
		},
		[44] = {
			"PM_NewContractInfoReq",
			"PM_NewContractInfoRes",
			block = true
		},
		[45] = {
			"PM_ResetNewContractSkillReq",
			"PM_ResetNewContractSkillRes",
			block = true
		},
		[46] = {
			"PM_ConfirmNewContractSkillReq",
			"PM_ConfirmNewContractSkillRes",
			block = true
		},
		[47] = {
			"PM_ContractSkillSelfSelectReq",
			"PM_ContractSkillSelfSelectRes",
			block = true
		},
		[48] = {
			"PM_BookSpiritLinkReq",
			"PM_BookSpiritLinkRes",
			block = true
		}
	},
	{
		{
			"UseMaterialReq",
			"UseMaterialRes",
			block = true
		},
		{
			"NotifyMaterialChangedRes"
		},
		{
			"LoadAllMaterialsReq",
			"LoadAllMaterialsRes",
			block = true
		},
		{
			"SellMaterialsReq",
			"SellMaterialsRes",
			block = true
		},
		{
			"UseExchangeCodeReq",
			"UseExchangeCodeRes",
			block = true
		},
		{
			"BatchUseMaterialReq",
			"BatchUseMaterialRes",
			block = true
		},
		{
			"GetMixSelectOnceInfoReq",
			"GetMixSelectOnceInfoRes",
			block = true
		},
		[255] = "MaterialExtension",
		[100] = {
			"NotifyTimedItemChangeRes"
		},
		[101] = {
			"NotifyExpirableItemChangeRes"
		}
	},
	{
		{
			"PM_ZooGetAllInfoReq",
			"PM_ZooGetAllInfoRes",
			block = true
		},
		{
			"PM_GetAnimalEggInfoReq",
			"PM_GetAnimalEggInfoRes",
			block = true
		},
		{
			"PM_ZooHatchUseSpeedUpCardReq",
			"PM_ZooHatchUseSpeedUpCardRes",
			block = true
		},
		{
			"PM_PutEggIntoSlotReq",
			"PM_PutEggIntoSlotRes",
			block = true
		},
		{
			"PM_TakeAnimalOutFromSlotReq",
			"PM_TakeAnimalOutFromSlotRes",
			block = true
		},
		{
			"PM_AnimalSetFollowStateReq",
			"PM_AnimalSetFollowStateRes",
			block = true
		},
		{
			"PM_AnimalSetInZooStateReq",
			"PM_AnimalSetInZooStateRes",
			block = true
		},
		{
			"PM_GetZooAnimalInfoReq",
			"PM_GetZooAnimalInfoRes",
			block = true
		},
		{
			"PM_ClearAllInZooStateReq",
			"PM_ClearAllInZooStateRes",
			block = true
		},
		{
			"PM_ZooSetAnimalNameReq",
			"PM_ZooSetAnimalNameRes",
			block = true
		},
		{
			"PM_ZooRecycleAnimalReq",
			"PM_ZooRecycleAnimalRes",
			block = true
		},
		{
			"PM_ZooNotifyGainEggRes"
		},
		{
			"PM_ZooFeedAnimalReq",
			"PM_ZooFeedAnimalRes",
			block = true
		},
		{
			"PM_ZooShareAnimalReq",
			"PM_ZooShareAnimalRes",
			block = true
		},
		{
			"PM_ZooShowSharedAnimalReq",
			"PM_ZooShowSharedAnimalRes",
			block = true
		},
		{
			"PM_ZooGetFaceGeneManualReq",
			"PM_ZooGetFaceGeneManualRes",
			block = true
		},
		{
			"PM_ZooHandleLostAnimalReq",
			"PM_ZooHandleLostAnimalRes",
			block = true
		},
		{
			"PM_ZooGetEggFromTravelManReq",
			"PM_ZooGetEggFromTravelManRes",
			block = true
		},
		{
			"PM_ZooUpgradeMainBuildingReq",
			"PM_ZooUpgradeMainBuildingRes",
			block = true
		},
		{
			"PM_ZooCancelHatchEggReq",
			"PM_ZooCancelHatchEggRes",
			block = true
		},
		{
			"PM_ZooGainBuildingProductionReq",
			"PM_ZooGainBuildingProductionRes",
			block = true
		},
		{
			"PM_ZooUpgradeResourceTreeReq",
			"PM_ZooUpgradeResourceTreeRes",
			block = true
		},
		{
			"PM_ZooUpgradeWorkBuildingReq",
			"PM_ZooUpgradeWorkBuildingRes",
			block = true
		},
		{
			"PM_ZooPutAnimalToWorkReq",
			"PM_ZooPutAnimalToWorkRes",
			block = true
		},
		{
			"PM_ZooUpgradeExchangeShopReq",
			"PM_ZooUpgradeExchangeShopRes",
			block = true
		},
		{
			"PM_ZooExchangeItemReq",
			"PM_ZooExchangeItemRes",
			block = true
		},
		{
			"PM_ZooUnlockBuildingReq",
			"PM_ZooUnlockBuildingRes",
			block = true
		},
		{
			"PM_ZooGainWorkBuildingProductionReq",
			"PM_ZooGainWorkBuildingProductionRes",
			block = true
		},
		{
			"PM_ZooInZooAnimalInteractReq",
			"PM_ZooInZooAnimalInteractRes",
			block = true
		},
		[255] = "ZooExtension",
		[32] = {
			"PM_ZooInviteBuddyMatchReq",
			"PM_ZooInviteBuddyMatchRes",
			block = true
		},
		[33] = {
			"PM_ZooCancelBuddyMatchReq",
			"PM_ZooCancelBuddyMatchRes",
			block = true
		},
		[34] = {
			"PM_ZooHandleBuddyMatchRequestReq",
			"PM_ZooHandleBuddyMatchRequestRes",
			block = true
		},
		[35] = {
			"PM_ZooPutBuddyMatchAnimalReq",
			"PM_ZooPutBuddyMatchAnimalRes",
			block = true
		},
		[36] = {
			"PM_ZooConfirmBuddyMatchReq",
			"PM_ZooConfirmBuddyMatchRes",
			block = true
		},
		[37] = {
			"PM_ZooNotifyBuddyMatchInviteRes"
		},
		[38] = {
			"PM_ZooNotifyBuddyMatchAccpetRes"
		},
		[39] = {
			"PM_ZooNotifyBuddyMatchRejectRes"
		},
		[40] = {
			"PM_ZooNotifyBuddyMatchCancelRes"
		},
		[41] = {
			"PM_ZooNotifyBuddyMatchReadyRes"
		},
		[42] = {
			"PM_ZooNotifyBuddyMatchFinishRes"
		},
		[50] = {
			"PM_ZooGetOtherZooReq",
			"PM_ZooGetOtherZooRes",
			block = true
		},
		[51] = {
			"PM_ZooStealFruitReq",
			"PM_ZooStealFruitRes",
			block = true
		},
		[52] = {
			"PM_ZooGainFruitReq",
			"PM_ZooGainFruitRes",
			block = true
		},
		[53] = {
			"PM_ZooDigTreasureReq",
			"PM_ZooDigTreasureRes",
			block = true
		},
		[54] = {
			"PM_ZooFeedBuddyAnimalReq",
			"PM_ZooFeedBuddyAnimalRes",
			block = true
		},
		[55] = {
			"PM_ZooGetInteractionLogReq",
			"PM_ZooGetInteractionLogRes",
			block = true
		},
		[56] = {
			"PM_ZooSetAbsorbDeviceReq",
			"PM_ZooSetAbsorbDeviceRes",
			block = true
		},
		[57] = {
			"PM_ZooUninstallAbsorbDeviceReq",
			"PM_ZooUninstallAbsorbDeviceRes",
			block = true
		},
		[58] = {
			"PM_ZooGainAbsorbDevicePrizeReq",
			"PM_ZooGainAbsorbDevicePrizeRes",
			block = true
		},
		[59] = {
			"PM_ZooNotifyInstallAbsorbDeviceRes",
			block = true
		},
		[60] = {
			"PM_ZooNotifyUnistallAbsorbDeviceRes",
			block = true
		},
		[61] = {
			"PM_ZooGetBuddyAbsorbStateReq",
			"PM_ZooGetBuddyAbsorbStateRes",
			block = true
		},
		[62] = {
			"PM_ZooNotifyBeStolenFruitRes",
			block = true
		}
	},
	{
		{
			"PM_LoadUserAllFormsReq",
			"PM_LoadUserAllFormsRes",
			block = true
		},
		{
			"PM_UserFormGlobalInfo",
			"PM_UserFormGlobalInfo",
			block = true
		},
		{
			"PM_UpgradeFormStrengthReq",
			"PM_UpgradeFormStrengthRes",
			block = true
		},
		{
			"PM_SetTabNameReq",
			"PM_SetTabNameRes",
			block = true
		},
		[255] = "FormationExtension",
		[10] = {
			"PM_OnGainNewFormationTabsRes"
		},
		[11] = {
			"PM_OnFormationChanged"
		},
		[21] = {
			"PM_LoadPersetsAllFormsReq",
			"PM_LoadPersetsAllFormsRes",
			block = true
		},
		[22] = {
			"PM_SetPresetsFormsReq",
			"PM_SetPresetsFormsRes",
			block = true
		},
		[23] = {
			"PM_SetPresetNameReq",
			"PM_SetPresetNameRes",
			block = true
		},
		[24] = {
			"PM_TopPresetsFormationReq",
			"PM_TopPresetsFormationRes",
			block = true
		},
		[25] = {
			"PM_DeletePresetsFormationReq",
			"PM_DeletePresetsFormationRes",
			block = true
		},
		[26] = {
			"PM_ModifyPresetsGroupReq",
			"PM_ModifyPresetsGroupRes",
			block = true
		},
		[27] = {
			"PM_TopPresetsGroupReq",
			"PM_TopPresetsGroupRes",
			block = true
		},
		[28] = {
			"PM_DeletePresetsGroupReq",
			"PM_DeletePresetsGroupRes",
			block = true
		},
		[29] = {
			"PM_ChangePresetsFormationGroupReq",
			"PM_ChangePresetsFormationGroupRes",
			block = true
		},
		[31] = {
			"PM_OnPresetsFormationChangedRes"
		}
	},
	[11] = {
		{
			"PM_ChallengeGetInfoReq",
			"PM_ChallengeGetInfoRes",
			block = true
		},
		{
			"PM_ChallengeFightTeamReq",
			"PM_ChallengeFightTeamRes",
			block = true
		},
		{
			"PM_ChallengeOneKeyPassTeamReq",
			"PM_ChallengeOneKeyPassTeamRes",
			block = true
		},
		{
			"PM_ChallengeTeamExtOperationReq",
			"PM_ChallengeTeamExtOperationRes",
			block = true
		},
		{
			"PM_ChallengeOneKeyPassBranchReq",
			"PM_ChallengeOneKeyPassBranchRes",
			block = true
		},
		{
			"PM_ChallengeRestartBranchReq",
			"PM_ChallengeRestartBranchRes",
			block = true
		},
		{
			"PM_ChallengeOneKeyPassPhaseReq",
			"PM_ChallengeOneKeyPassPhaseRes",
			block = true
		},
		{
			"PM_ChallengeRestartPhaseReq",
			"PM_ChallengeRestartPhaseRes",
			block = true
		},
		{
			"PM_ChallengeOneKeyFinishReq",
			"PM_ChallengeOneKeyFinishRes",
			block = true
		},
		{
			"PM_ChallengeGainPrizeReq",
			"PM_ChallengeGainPrizeRes",
			block = true
		},
		{
			"PM_ChallengeExtOperationReq",
			"PM_ChallengeExtOperationRes",
			block = true
		},
		{
			"PM_ChallengeBatchGetSimpleInfosReq",
			"PM_ChallengeBatchGetSimpleInfosRes",
			block = true
		},
		[255] = "ChallengeExtension",
		[20] = {
			"PM_OnFightTeamEndRes"
		}
	},
	[12] = {
		{
			"GetUnlockNeedInfoReq",
			"GetUnlockNeedInfoRes",
			block = true
		},
		[255] = "UnlockExtension"
	},
	[13] = {
		{
			"GetUserMailsReq",
			"GetUserMailsRes",
			block = true
		},
		{
			"ReadUserMailsReq",
			"ReadUserMailsRes",
			block = true
		},
		{
			"GainUserMailsReq",
			"GainUserMailsRes",
			block = true
		},
		{
			"DeleteUserMailsReq",
			"DeleteUserMailsRes",
			block = true
		},
		{
			"NotifyNewMailsRes"
		},
		{
			"NotifyWillOutDateMailRes"
		},
		{
			"NotifyNewOfflineMailsRes"
		},
		[255] = "MailBoxExtension"
	},
	[14] = {
		{
			"GetBuddyInfoReq",
			"GetBuddyInfoRes",
			block = true
		},
		[255] = "BuddyExtension",
		[3] = {
			"GetBuddyRequestInfoReq",
			"GetBuddyRequestInfoRes",
			block = true
		},
		[4] = {
			"RefreshRecommendBuddiesReq",
			"RefreshRecommendBuddiesRes",
			block = true
		},
		[5] = {
			"RequestAddBuddyReq",
			"RequestAddBuddyRes",
			block = true
		},
		[6] = {
			"HandleBuddyRequestReq",
			"HandleBuddyRequestRes",
			block = true
		},
		[7] = {
			"BatchHandleBuddyRequestReq",
			"BatchHandleBuddyRequestRes",
			block = true
		},
		[8] = {
			"SearchUserReq",
			"SearchUserRes",
			block = true
		},
		[9] = {
			"RemoveBuddyReq",
			"RemoveBuddyRes",
			block = true
		},
		[10] = {
			"AddBlackListReq",
			"AddBlackListRes",
			block = true
		},
		[11] = {
			"RemoveBlackListReq",
			"RemoveBuddyRes",
			block = true
		},
		[12] = {
			"GainHeartsReq",
			"GainHeartsRes",
			block = true
		},
		[13] = {
			"SendHeartsReq",
			"SendHeartsRes",
			block = true
		},
		[14] = {
			"PopStrangerReq",
			"PopStrangerRes",
			block = true
		},
		[15] = {
			"NotifyNewBuddyReqeustRes"
		},
		[16] = {
			"NotifyNewBuddyRes"
		},
		[17] = {
			"NotifyBeDelBuddyRes"
		},
		[18] = {
			"NotifyBuddyInfoChangedRes"
		},
		[19] = {
			"NotifyNewStrangerRes"
		},
		[20] = {
			"NotifyNewHeartRes"
		},
		[21] = {
			"NotifyBuddyLoginRes"
		},
		[22] = {
			"GetFetterInfoReq",
			"GetFetterInfoRes",
			block = true
		},
		[23] = {
			"NotifyFetter"
		},
		[24] = {
			"GetTeamFetterInfoReq",
			"GetTeamFetterInfoRes",
			block = true
		},
		[25] = {
			"GetBuddyRelationshipReq",
			"GetBuddyRelationshipRes",
			block = true
		}
	},
	[15] = {
		{
			"PM_AnimalsGetStateReq",
			"PM_AnimalsGetStateRes",
			block = true
		},
		{
			"PM_AnimalsProcessFeedBackReq",
			"PM_AnimalsProcessFeedBackRes",
			block = true
		},
		{
			"PM_AnimalsTouchReq",
			"PM_AnimalsTouchRes",
			block = true
		},
		{
			"PM_AnimalsFeedReq",
			"PM_AnimalsFeedRes",
			block = true
		},
		{
			"PM_AnimalsFollowReq",
			"PM_AnimalsFollowRes",
			block = true
		},
		{
			"PM_AnimalsGainIntimacyPrizeReq",
			"PM_AnimalsGainIntimacyPrizeRes",
			block = true
		},
		{
			"PM_AnimalsGetFeedbackEventReq",
			"PM_AnimalsGetFeedbackEventRes",
			block = true
		},
		{
			"PM_AnimalsOneKeyTouchReq",
			"PM_AnimalsTouchRes",
			block = true
		},
		[255] = "AnimalsExtension",
		[10] = {
			"PM_AnimalsGinPigReq",
			"PM_AnimalsGinPigRes",
			block = true
		},
		[11] = {
			"PM_AnimalsPigAdventureInfoReq",
			"PM_AnimalsPigAdventureInfoRes",
			block = true
		},
		[12] = {
			"PM_AnimalsPigAdventurePrizeReq",
			"PM_AnimalsPigAdventurePrizeRes",
			block = true
		},
		[14] = {
			"PM_AnimalsRenameReq",
			"PM_AnimalsRenameRes",
			block = true
		},
		[15] = {
			"PM_AnimalsActivateReq",
			"PM_AnimalsActivateRes",
			block = true
		},
		[16] = {
			"PM_AnimalsTakeReq",
			"PM_AnimalsTakeRes",
			block = true
		}
	},
	[16] = {
		{
			"GetChatSettingsAndOfflineMsgsReq",
			"GetChatSettingsAndOfflineMsgsRes",
			block = true
		},
		{
			"DelOfflineMsgsReq",
			"DelOfflineMsgsRes",
			block = true
		},
		{
			"SendMsgReq",
			"SendMsgRes",
			block = true
		},
		{
			"NotifyNewMsgRes"
		},
		{
			"SetChatSettingsReq",
			"SetChatSettingsRes",
			block = true
		},
		{
			"BatchSendMsgToBuddyReq",
			"BatchSendMsgToBuddyRes",
			block = true
		},
		{
			"PM_GetOtherUserPetReq",
			"PM_GetOtherUserPetRes",
			block = true
		},
		{
			"PM_GetOtherUserFormReq",
			"PM_GetOtherUserFormRes",
			block = true
		},
		{
			"PM_SelectChatBubbleReq",
			"PM_SelectChatBubbleRes",
			block = true
		},
		{
			"PM_GetEmoticonGroupInfoReq",
			"PM_GetEmoticonGroupInfoRes",
			block = true
		},
		{
			"PM_GetCodeWordInfoReq",
			"PM_GetCodeWordInfoRes",
			block = true
		},
		{
			"PM_NotifyCodeWordPrizeRes"
		},
		{
			"PM_NotifyCodeWordChangeRes"
		},
		[255] = "ChatExtension"
	},
	[17] = {
		{
			"SetMyAvatarReq",
			"SetMyAvatarRes",
			block = true
		},
		{
			"NotifyClothesChangedRes"
		},
		{
			"GetOutClothesReq",
			"GetOutClothesRes",
			block = true
		},
		{
			"GetNoOutClothesReq",
			"GetNoOutClothesRes",
			block = true
		},
		{
			"GetClothesPresetReq",
			"GetClothesPresetRes",
			block = true
		},
		{
			"UpdateClothesPresetReq",
			"UpdateClothesPresetRes",
			block = true
		},
		[255] = "ClothesExtension"
	},
	[18] = {
		{
			"UserTowerInfoReq",
			"UserTowerInfoRes",
			block = true
		},
		{
			"FightReq",
			"FightRes",
			block = true
		},
		[255] = "WarriorTowerExtension",
		[7] = {
			"GainProgressPrizeReq",
			"GainProgressPrizeRes",
			block = true
		},
		[9] = {
			"AfterFightRes"
		},
		[10] = {
			"GetWarriorTowerRankInfoReq",
			"GetWarriorTowerRankInfoRes",
			block = true
		},
		[11] = {
			"SetWarriorTowerFormReq",
			"SetWarriorTowerFormRes",
			block = true
		},
		[12] = {
			"GetWarriorTowerFormReq",
			"GetWarriorTowerFormRes",
			block = true
		},
		[13] = {
			"GetWarriorTowerProfitInfoReq",
			"GetWarriorTowerProfitInfoRes",
			block = true
		},
		[14] = {
			"GainWarriorTowerProfitPrizeReq",
			"GainWarriorTowerProfitPrizeRes",
			block = true
		},
		[15] = {
			"TurnTimeWarriorTowerReq",
			"TurnTimeWarriorTowerRes",
			block = true
		},
		[16] = {
			"GetWarriorMainTowerProgressReq",
			"GetWarriorMainTowerProgressRes",
			block = true
		},
		[17] = {
			"WarriorTowerAutoFightReq",
			"WarriorTowerAutoFightRes",
			block = true
		}
	},
	[22] = {
		{
			"UserPetManualInfoReq",
			"UserPetManualInfoRes",
			block = true
		},
		{
			"PreviewBattleReq",
			"PreviewBattleRes",
			block = true
		},
		{
			"GainPetManualPetPrizeReq",
			"GainPetManualPetPrizeRes",
			block = true
		},
		{
			"GainPetManualTeamPrizeReq",
			"GainPetManualTeamPrizeRes",
			block = true
		},
		[255] = "PetManualExtension",
		[6] = {
			"PetBenefitActivateReq",
			"PetBenefitActivateRes",
			block = true
		},
		[7] = {
			"PetBenefitUpgradeReq",
			"PetBenefitUpgradeRes",
			block = true
		},
		[8] = {
			"UserGroupInfoReq",
			"UserGroupInfoRes",
			block = true
		},
		[9] = {
			"GainGroupPrizeReq",
			"GainGroupPrizeRes",
			block = true
		},
		[10] = {
			"CalZdlAndRankReq",
			"CalZdlAndRankRes",
			block = true
		},
		[11] = {
			"GetRaceZdlRankReq",
			"GetRaceZdlRankRes",
			block = true
		},
		[12] = {
			"RaceRankKudosReq",
			"RaceRankKudosRes",
			block = true
		},
		[13] = {
			"GainRankPrizeReq",
			"GainRankPrizeRes",
			block = true
		},
		[14] = {
			"PetBenefitOneKeyActivateReq",
			"PetBenefitOneKeyActivateRes",
			block = true
		},
		[15] = {
			"GetSkinManualInfoReq",
			"GetSkinManualInfoRes",
			block = true
		},
		[16] = {
			"PetSkinActivateReq",
			"PetSkinActivateRes",
			block = true
		},
		[17] = {
			"PetSkinOneKeyActivateReq",
			"PetSkinOneKeyActivateRes",
			block = true
		},
		[18] = {
			"OneKeyPetRankPrizeInfoReq",
			"OneKeyPetRankPrizeInfoRes",
			block = true
		}
	},
	[23] = {
		{
			"AncientFossilSiteGetInfoReq",
			"AncientFossilSiteGetInfoRes",
			block = true
		},
		{
			"StartGameReq",
			"StartGameRes",
			block = true
		},
		{
			"EndGameReq",
			"EndGameRes",
			block = true
		},
		{
			"GainScorePrizeReq",
			"GainScorePrizeRes",
			block = true
		},
		[255] = "AncientFossilSiteExtension"
	},
	[24] = {
		{
			"OpenArenaReq",
			"OpenArenaRes",
			block = true
		},
		[255] = "ArenaExtension",
		[5] = {
			"RefreshChallengeTargetsReq",
			"RefreshChallengeTargetsRes",
			block = true
		},
		[6] = {
			"ArenaChallengeReq",
			"ArenaChallengeRes",
			block = true
		},
		[7] = {
			"BuyChallengeTimesReq",
			"BuyChallengeTimesRes",
			block = true
		},
		[8] = {
			"ClearChallengeCdReq",
			"ClearChallengeCdRes",
			block = true
		},
		[13] = {
			"GetTopDetailReq",
			"GetTopDetailRes",
			block = true
		},
		[14] = {
			"GetDailyTaskInfoReq",
			"GetDailyTaskInfoRes",
			block = true
		},
		[15] = {
			"RefreshDailyTaskInfoReq",
			"RefreshDailyTaskInfoRes",
			block = true
		},
		[16] = {
			"GetAchievePrizeInfoReq",
			"GetAchievePrizeInfoRes",
			block = true
		},
		[17] = {
			"GainAchievePrizeReq",
			"GainAchievePrizeRes",
			block = true
		},
		[18] = {
			"GetMyArenaChallengeRecordsReq",
			"GetMyArenaChallengeRecordsRes",
			block = true
		},
		[19] = {
			"GetMyArenaFormationReq",
			"GetArenaFormationRes",
			block = true
		},
		[20] = {
			"GetOtherArenaFormationReq",
			"GetArenaFormationRes",
			block = true
		},
		[21] = {
			"SetMyArenaFormationReq",
			"SetMyArenaFormationRes",
			block = true
		},
		[22] = {
			"GetVideoReq",
			"GetVideoRes",
			block = true
		},
		[23] = {
			"GainDailyTaskPrizeReq",
			"GainDailyTaskPrizeRes",
			block = true
		},
		[24] = {
			"ArenaSweepReq",
			"ArenaSweepRes",
			block = true
		},
		[25] = {
			"GetMyZoneInReq",
			"GetMyZoneInRes",
			block = true
		}
	},
	[25] = {
		{
			"PM_BreachFormationGetUserInfoReq",
			"PM_BreachFormationGetUserInfoRes",
			block = true
		},
		{
			"PM_BreachFormationGetRankInfoReq",
			"PM_BreachFormationGetRankInfoRes",
			block = true
		},
		{
			"PM_BreachFormationFightReq",
			"PM_BreachFormationFightRes",
			block = true
		},
		{
			"PM_BreachFormationGetLatestRecordsReq",
			"PM_BreachFormationGetLatestRecordsRes",
			block = true
		},
		{
			"PM_BreachFormationGainProgressPrizeReq",
			"PM_BreachFormationGainProgressPrizeRes",
			block = true
		},
		{
			"PM_BreachFormationNotifyScoreRes"
		},
		{
			"PM_BreachFormationWatchBattleVideoReq",
			"PM_BreachFormationWatchBattleVideoRes",
			block = true
		},
		{
			"PM_BreachFormationBuyFirstPassTimesReq",
			"PM_BreachFormationBuyFirstPassTimesRes",
			block = true
		},
		{
			"PM_BreachFormationQuickPassReq",
			"PM_BreachFormationQuickPassRes",
			block = true
		},
		{
			"PM_BreachFormationOneKeyGainProgressPrizeReq",
			"PM_BreachFormationOneKeyGainProgressPrizeRes",
			block = true
		},
		[255] = "BreachFormationExtension"
	},
	[26] = {
		[255] = "PlayerExtension",
		[2] = {
			"CreatePlayerReq",
			"CreatePlayerRes",
			block = true
		},
		[3] = {
			"GetUserInitInfoReq",
			"GetUserInitInfoRes",
			block = true
		},
		[4] = {
			"GetMsgBoxInfoReq",
			"GetMsgBoxInfoRes",
			block = true
		},
		[5] = {
			"GetSomeMsgBoxInfoReq",
			"GetSomeMsgBoxInfoRes",
			block = true
		},
		[6] = {
			"NotifyEverMaxZdlChangedRes"
		},
		[7] = {
			"UpdatePlayerSettingsReq",
			"UpdatePlayerSettingsRes",
			block = true
		},
		[8] = {
			"GetMyDisplayCardInfoReq",
			"GetMyDisplayCardInfoRes",
			block = true
		},
		[9] = {
			"GetOtherDisplayCardInfoReq",
			"GetOtherDisplayCardInfoRes",
			block = true
		},
		[12] = {
			"GetExpGainBitReq",
			"GetExpGainBitRes",
			block = true
		},
		[13] = {
			"GainExpGiftReq",
			"GainExpGiftRes",
			block = true
		},
		[14] = {
			"TransformGenderReq",
			"TransformGenderRes",
			block = true
		},
		[15] = {
			"PM_ChangeUserNameReq",
			"PM_ChangeUserNameRes",
			block = true
		},
		[16] = {
			"PM_GetChangeUserNameCdReq",
			"PM_GetChangeUserNameCdRes",
			block = true
		},
		[17] = {
			"PM_ChangeBadgeReq",
			"PM_ChangeBadgeRes",
			block = true
		},
		[18] = {
			"PM_GetCheckInInfoReq",
			"PM_GetCheckInInfoRes",
			block = true
		},
		[19] = {
			"PM_SubmitCheckInInfoReq",
			"PM_SubmitCheckInInfoRes",
			block = true
		},
		[20] = {
			"PM_GainCheckInPrizeReq",
			"PM_GainCheckInPrizeRes",
			block = true
		},
		[21] = {
			"PM_ChangePetTitleReq",
			"PM_ChangePetTitleRes",
			block = true
		},
		[22] = {
			"PM_ChangePetFavorPetsReq",
			"PM_ChangePetFavorPetsRes",
			block = true
		},
		[23] = {
			"PM_GetSecondaryPwdInfoReq",
			"PM_GetSecondaryPwdInfoRes",
			block = true
		},
		[24] = {
			"PM_SetSecondaryPwdReq",
			"PM_SetSecondaryPwdRes",
			block = true
		},
		[25] = {
			"PM_ClearSecondaryPwdReq",
			"PM_ClearSecondaryPwdRes",
			block = true
		},
		[26] = {
			"PM_ChangeSecondaryPwdReq",
			"PM_ChangeSecondaryPwdRes",
			block = true
		},
		[27] = {
			"PM_ValidInputSecondaryPwdReq",
			"PM_ValidInputSecondaryPwdRes",
			block = true
		},
		[28] = {
			"PM_ReqResetSecondaryPwdReq",
			"PM_ReqResetSecondaryPwdRes",
			block = true
		},
		[29] = {
			"PM_CancelResetSecondaryPwdReq",
			"PM_CancelResetSecondaryPwdRes",
			block = true
		},
		[30] = {
			"PM_SelectGuideModeReq",
			"PM_SelectGuideModeRes",
			block = true
		},
		[100] = {
			"PM_RefreshSecondaryPwdInfoRes"
		},
		[101] = {
			"PM_MustInputValidSecondaryPwdRes"
		}
	},
	[27] = {
		{
			"GainFinalGiftReq",
			"GainFinalGiftRes",
			block = true
		},
		{
			"GetKirinInfoReq",
			"GetKirinInfoRes",
			block = true
		},
		[255] = "NewHandExtension",
		[9] = {
			"GetAllNewHandGuideKVsReq",
			"GetAllNewHandGuideKVsRes",
			block = true
		},
		[10] = {
			"UpdateNewHandGuideKVsReq",
			"UpdateNewHandGuideKVsRes",
			block = true
		},
		[11] = {
			"ClearAllNewHandGuideKVsReq",
			"ClearAllNewHandGuideKVsRes",
			block = true
		}
	},
	[29] = {
		{
			"PM_RecordClientBehaviorReq",
			"PM_RecordClientBehaviorRes"
		},
		{
			"PM_DanMuCheckAndSaveReq",
			"PM_DanMuCheckAndSaveRes",
			block = true
		},
		{
			"PM_GetAllSurveyStatesReq",
			"PM_GetAllSurveyStatesRes",
			block = true
		},
		{
			"PM_SaveSurveyReq",
			"PM_SaveSurveyRes",
			block = true
		},
		{
			"PM_GainSurveyGiftReq",
			"PM_GainSurveyGiftRes",
			block = true
		},
		{
			"PM_BigOrangeTalkCheckAndSaveReq",
			"PM_BigOrangeTalkCheckAndSaveRes",
			block = true
		},
		{
			"PM_CustomCallReq",
			"PM_CustomCallRes",
			block = true
		},
		{
			"PM_SignForSdkSurveyReq",
			"PM_SignForSdkSurveyRes",
			block = true
		},
		[255] = "SurveyExtension",
		[101] = {
			"PM_NotifySdkSurveyFinishRes"
		}
	},
	[30] = {
		{
			"SignInInfoReq",
			"SignInInfoRes",
			block = true
		},
		{
			"SignInGainPrizeReq",
			"SignInGainPrizeRes",
			block = true
		},
		[255] = "SignInExtension"
	},
	[31] = {
		{
			"OnlineTimePrizeInfoReq",
			"OnlineTimePrizeInfoRes",
			block = true
		},
		{
			"OnlineTimePrizeReq",
			"OnlineTimePrizeRes",
			block = true
		},
		[255] = "OnlineTimeExtension"
	},
	[32] = {
		{
			"GetDiamondTaskInfosReq",
			"GetDiamondTaskInfosRes",
			block = true
		},
		{
			"GainTaskGiftReq",
			"GainTaskGiftRes",
			block = true
		},
		{
			"GainActivityScoreGiftReq",
			"GainActivityScoreGiftRes",
			block = true
		},
		{
			"NotifyProgressChangedRes"
		},
		{
			"GainAccumulateScoreGiftReq",
			"GainAccumulateScoreGiftRes",
			block = true
		},
		[255] = "DiamondTaskExtension"
	},
	[34] = {
		{
			"GetFamilyViewsReq",
			"GetFamilyViewsRes",
			block = true
		},
		{
			"SearchFamilyReq",
			"SearchFamilyRes",
			block = true
		},
		{
			"CreateFamilyReq",
			"CreateFamilyRes",
			block = true
		},
		{
			"ModifyFamilyDeclarationReq",
			"ModifyFamilyDeclarationRes",
			block = true
		},
		{
			"ApplyJoinFamilyReq",
			"ApplyJoinFamilyReq",
			block = true
		},
		{
			"OneKeyApplyJoinFamilyReq",
			"OneKeyApplyJoinFamilyRes",
			block = true
		},
		{
			"CancelApplyJoinReq",
			"CancelApplyJoinRes",
			block = true
		},
		{
			"GetMyFamilySimpleInfoReq",
			"GetMyFamilySimpleInfoRes",
			block = true
		},
		[255] = "FamilyExtension",
		[11] = {
			"GetMyFamilyInfoReq",
			"GetMyFamilyInfoRes",
			block = true
		},
		[12] = {
			"GetFamilyApplyListReq",
			"GetFamilyApplyListRes",
			block = true
		},
		[13] = {
			"HandleFamilyApplyReq",
			"HandleFamilyApplyRes",
			block = true
		},
		[14] = {
			"BatchHandleFamilyApplyReq",
			"BatchHandleFamilyApplyRes",
			block = true
		},
		[15] = {
			"GetFamilyMemberListReq",
			"GetFamilyMemberListRes",
			block = true
		},
		[16] = {
			"LeaveFamilyReq",
			"LeaveFamilyRes",
			block = true
		},
		[17] = {
			"KickUserOutFamilyReq",
			"KickUserOutFamilyRes",
			block = true
		},
		[18] = {
			"ChangeFamilyRoleReq",
			"ChangeFamilyRoleRes",
			block = true
		},
		[19] = {
			"GetFamilyEventLogsReq",
			"GetFamilyEventLogsRes",
			block = true
		},
		[20] = {
			"ModifySettingsReq",
			"ModifySettingsRes",
			block = true
		},
		[21] = {
			"NotifyJoinLeaveFamilyRes"
		},
		[22] = {
			"NotifyFamilyLevelUpRes"
		},
		[23] = {
			"GetDonatePoolInfoReq",
			"GetDonatePoolInfoRes",
			block = true
		},
		[24] = {
			"FamilyDonateReq",
			"FamilyDonateRes",
			block = true
		},
		[25] = {
			"GetUnlockedBossInfosReq",
			"GetUnlockedBossInfosRes",
			block = true
		},
		[26] = {
			"OpenBossChallengeReq",
			"OpenBossChallengeRes",
			block = true
		},
		[27] = {
			"ChallengeBossReq",
			"ChallengeBossRes",
			block = true
		},
		[28] = {
			"SweepBossReq",
			"SweepBossRes",
			block = true
		},
		[29] = {
			"BossClgEndRes"
		},
		[30] = {
			"DismissFamilyReq",
			"DismissFamilyRes",
			block = true
		},
		[31] = {
			"SendAllMemberMailReq",
			"SendAllMemberMailRes",
			block = true
		},
		[32] = {
			"GetFamilyActivityPanelInfoReq",
			"GetFamilyActivityPanelInfoRes",
			block = true
		},
		[33] = {
			"GetFamilyManagePanelInfoReq",
			"GetFamilyManagePanelInfoRes",
			block = true
		},
		[34] = {
			"GetSendEnlistMsgReq",
			"GetSendEnlistMsgRes",
			block = true
		},
		[36] = {
			"GetFamilyTotemInfoReq",
			"GetFamilyTotemInfoRes",
			block = true
		},
		[37] = {
			"InvokeFamilyTotemReq",
			"InvokeFamilyTotemRes",
			block = true
		}
	},
	[35] = {
		{
			"PM_HandleLoadFeedbackInfosReq",
			"PM_HandleLoadFeedbackInfosRes",
			block = true
		},
		{
			"PM_HandleSendFeedbackReq",
			"PM_HandleSendFeedbackRes",
			block = true
		},
		{
			"PM_ReportReq",
			"PM_ReportRes",
			block = true
		},
		[255] = "FeedbackExtension",
		[10] = {
			"PM_NewFeedbackPushRes"
		}
	},
	[36] = {
		{
			"PM_OnReceiveLanternMsgRes"
		},
		{
			"PM_DeleteLanternMsgRes"
		},
		[255] = "LanternMsgExtension"
	},
	[37] = {
		{
			"PM_BattleRecordGetLatestRecordsReq",
			"PM_BattleRecordGetLatestRecordsRes",
			block = true
		},
		{
			"PM_BattleRecordGetBattleVideoReq",
			"PM_BattleRecordGetBattleVideoRes",
			block = true
		},
		{
			"PM_SubmitBattleVideoReq",
			"PM_SubmitBattleVideoRes",
			block = true
		},
		[255] = "BattleRecordRankExtension"
	},
	[40] = {
		{
			"PM_XiaoNuoPlaceInfoReq",
			"PM_XiaoNuoPlaceInfoRes",
			block = true
		},
		{
			"PM_XiaoNuoPrizeReq",
			"PM_XiaoNuoPrizeRes",
			block = true
		},
		{
			"PM_XiaoNuoRankReq",
			"PM_XiaoNuoRankRes",
			block = true
		},
		{
			"PM_XiaoNuoBuyReq",
			"PM_XiaoNuoBuyRes",
			block = true
		},
		{
			"PM_XiaoNuoComposeReq",
			"PM_XiaoNuoComposeRes",
			block = true
		},
		{
			"PM_XiaoNuoMoveReq",
			"PM_XiaoNuoMoveRes",
			block = true
		},
		{
			"PM_XiaoNuoDiscardReq",
			"PM_XiaoNuoDiscardRes",
			block = true
		},
		{
			"PM_XiaoNuoCloseReq",
			"PM_XiaoNuoCloseRes",
			block = true
		},
		{
			"PM_XiaoNuoOnPlayerReconnectRes"
		},
		{
			"PM_XiaoNuoOneKeyComposeReq",
			"PM_XiaoNuoOneKeyComposeRes",
			block = true
		},
		{
			"PM_XiaoNuoGainActivityPrizeReq",
			"PM_XiaoNuoGainActivityPrizeRes",
			block = true
		},
		[255] = "XiaoNuoPlaceExtension"
	},
	[41] = {
		{
			"PM_MaxZdlRankGetInfoReq",
			"PM_MaxZdlRankGetInfoRes",
			block = true
		},
		{
			"PM_GetFirstPassRankViewReq",
			"PM_GetFirstPassRankViewRes",
			block = true
		},
		[255] = "CommonRankExtension"
	},
	[42] = {
		{
			"MoneyCatInfoReq",
			"MoneyCatInfoRes",
			block = true
		},
		{
			"MakeMoneyReq",
			"MakeMoneyRes",
			block = true
		},
		[255] = "MoneyCatExtension"
	},
	[43] = {
		{
			"PM_ConvoyGetInfoReq",
			"PM_ConvoyGetInfoRes",
			block = true
		},
		{
			"PM_ConvoyUpgradeBoxReq",
			"PM_ConvoyUpgradeBoxRes",
			block = true
		},
		{
			"PM_AcceptConvoyReq",
			"PM_AcceptConvoyRes",
			block = true
		},
		{
			"PM_ConvoyTalkToNPCReq",
			"PM_ConvoyTalkToNPCRes",
			block = true
		},
		{
			"PM_FinishConvoyReq",
			"PM_FinishConvoyRes",
			block = true
		},
		{
			"PM_ConvoyOverTimeReq",
			"PM_ConvoyOverTimeRes",
			block = true
		},
		{
			"PM_GetConvoyListReq",
			"PM_GetConvoyListRes",
			block = true
		},
		{
			"PM_GetOtherConvoyDetailReq",
			"PM_GetOtherConvoyDetailRes",
			block = true
		},
		{
			"PM_ConvoyChallengeReq",
			"PM_ConvoyChallengeRes",
			block = true
		},
		{
			"PM_ConvoyGetChallengeRecordReq",
			"PM_ConvoyGetChallengeRecordRes",
			block = true
		},
		{
			"PM_ConvoyGetChallengeVideoReq",
			"PM_ConvoyGetChallengeVideoRes",
			block = true
		},
		{
			"PM_NotifyConvoyBeChallengedRes"
		},
		{
			"PM_ConvoyOneKeyFinishReq",
			"PM_ConvoyOneKeyFinishRes",
			block = true
		},
		[255] = "ConvoyExtension"
	},
	[44] = {
		{
			"PM_LoadAllRedPointReq",
			"PM_LoadAllRedPointRes",
			block = true
		},
		{
			"PM_OnRedPointChangeRes"
		},
		[255] = "RedPointExtension"
	},
	[46] = {
		{
			"PM_LoadAllTitleReq",
			"PM_LoadAllTitleRes",
			block = true
		},
		{
			"PM_WearTitleReq",
			"PM_WearTitleRes",
			block = true
		},
		{
			"PM_notifyGainTitleRes"
		},
		[255] = "TitleExtension"
	},
	[47] = {
		{
			"PM_LoadAllAchievementReq",
			"PM_LoadAllAchievementRes",
			block = true
		},
		{
			"PM_GainAchievementPrizeReq",
			"PM_GainAchievementPrizeRes",
			block = true
		},
		{
			"PM_GainAchievementLevelPrizeReq",
			"PM_GainAchievementLevelPrizeRes",
			block = true
		},
		{
			"PM_notifyGetAchievementRes"
		},
		{
			"PM_OneKeyGainAchievementPrizeReq",
			"PM_OneKeyGainAchievementPrizeRes",
			block = true
		},
		{
			"PM_AchievementGetRankReq",
			"PM_AchievementGetRankRes",
			block = true
		},
		[255] = "AchievementExtension"
	},
	[50] = {
		{
			"LotteryDrawReq",
			"LotteryDrawRes",
			block = true
		},
		{
			"LotteryInfoReq",
			"LotteryInfoRes",
			block = true
		},
		{
			"LotteryShopInfoReq",
			"LotteryShopInfoRes",
			block = true
		},
		{
			"LotteryGodShopBuyReq",
			"LotteryGodShopBuyRes",
			block = true
		},
		{
			"LotteryCommonShopBuyReq",
			"LotteryCommonShopBuyRes",
			block = true
		},
		{
			"LotteryGodShopInfoReq",
			"LotteryGodShopInfoRes",
			block = true
		},
		{
			"LotterySelectWishPetReq",
			"LotterySelectWishPetRes",
			block = true
		},
		{
			"PM_UnlockLotteryPoolInGroupReq",
			"PM_UnlockLotteryPoolInGroupRes",
			block = true
		},
		{
			"PM_LotterySelectPrizeInfoReq",
			"PM_LotterySelectPrizeInfoRes",
			block = true
		},
		{
			"PM_LotterySelectPrizeSetPosReq",
			"PM_LotterySelectPrizeSetPosRes",
			block = true
		},
		{
			"PM_LotterySelectPrizeResetReq",
			"PM_LotterySelectPrizeResetRes",
			block = true
		},
		{
			"PM_LotterySelectUpPetReq",
			"PM_LotterySelectUpPetRes",
			block = true
		},
		{
			"PM_LotteryResetUpPetReq",
			"PM_LotteryResetUpPetRes",
			block = true
		},
		{
			"PM_LotterySelectUpPrizeReq",
			"PM_LotterySelectUpPrizeRes",
			block = true
		},
		[255] = "LotteryExtension"
	},
	[51] = {
		{
			"GenOrderNoReq",
			"GenOrderNoRes",
			block = true
		},
		{
			"NotifyPayResultRes"
		},
		[255] = "PayExtension"
	},
	[52] = {
		{
			"RM_OpenRankingMatchReq",
			"RM_OpenRankingMatchRes",
			block = true
		},
		{
			"RM_AutoSetDefenseFormReq",
			"RM_AutoSetDefenseFormRes",
			block = true
		},
		{
			"RM_SetDefenseFormReq",
			"RM_SetDefenseFormRes",
			block = true
		},
		{
			"RM_BeginMatchingReq",
			"RM_BeginMatchingRes",
			block = true
		},
		{
			"RM_CancelMatchingReq",
			"RM_CancelMatchingRes",
			block = true
		},
		{
			"RM_ReadyFightReq",
			"RM_ReadyFightRes",
			block = true
		},
		[255] = "RankingMatchExtension",
		[8] = {
			"RM_LeaveGameReq",
			"RM_LeaveGameRes",
			block = true
		},
		[9] = {
			"RM_GetBattleRecordReq",
			"RM_GetBattleRecordRes",
			block = true
		},
		[11] = {
			"PM_GetRMLegendRankReq",
			"PM_GetRMLegendRankRes",
			block = true
		},
		[12] = {
			"PM_GetRMDefenseDetailReq",
			"PM_GetRMDefenseDetailRes",
			block = true
		},
		[13] = {
			"PM_GetRMPetRaceRankReq",
			"PM_GetRMPetRaceRankRes",
			block = true
		},
		[14] = {
			"RM_GetMyDefenseFormReq",
			"RM_GetMyDefenseFormRes",
			block = true
		},
		[15] = {
			"RM_GetBattleVideoReq",
			"RM_GetBattleVideoRes",
			block = true
		},
		[16] = {
			"RM_GetMyDeclarationReq",
			"RM_GetMyDeclarationRes",
			block = true
		},
		[17] = {
			"RM_SetMyDeclarationReq",
			"RM_SetMyDeclarationRes",
			block = true
		},
		[18] = {
			"RM_GetAllInformationReq",
			"RM_GetAllInformationRes",
			block = true
		},
		[19] = {
			"RM_GetAllTaskReq",
			"RM_GetAllTaskRes",
			block = true
		},
		[20] = {
			"RM_GainTaskPrizeReq",
			"RM_GainTaskPrizeRes",
			block = true
		},
		[21] = {
			"RM_CheckLastSeasonPrizeReq",
			"RM_CheckLastSeasonPrizeRes",
			block = true
		},
		[22] = {
			"RM_RefreshMyLocalRankReq",
			"RM_RefreshMyLocalRankRes",
			block = true
		},
		[23] = {
			"RM_BanPetReq",
			"RM_BanPetRes",
			block = true
		},
		[24] = {
			"RM_GetBanPetInfoReq",
			"RM_GetBanPetInfoRes",
			block = true
		},
		[101] = {
			"RM_NotifyBeginGameRes"
		},
		[102] = {
			"RM_NotifyMatchingOverTimeRes"
		},
		[103] = {
			"RM_NotifyOpReadyFight"
		},
		[104] = {
			"RM_NotifyGameResult"
		},
		[105] = {
			"RM_NotifyMatchFailRes"
		}
	},
	[53] = {
		{
			"PM_StrengthInfoReq",
			"PM_StrengthInfoRes",
			block = true
		},
		{
			"PM_StrengthBuyReq",
			"PM_StrengthBuyRes",
			block = true
		},
		{
			"PM_StrengthGetFreeReq",
			"PM_StrengthGetFreeRes",
			block = true
		},
		{
			"PM_StrengthCompensateReq",
			"PM_StrengthCompensateRes",
			block = true
		},
		[255] = "StrengthExtension",
		[10] = {
			"PM_NotifyStrengthChangeRes"
		}
	},
	[54] = {
		{
			"GetChapterProgressReq",
			"GetChapterProgressRes"
		},
		[255] = "PlotChallengeExtension",
		[4] = {
			"ChallengeReq",
			"ChallengeRes",
			block = true
		},
		[7] = {
			"GainChapterPrizeReq",
			"GainChapterPrizeRes",
			block = true
		},
		[8] = {
			"NotifyAfterChallengeRes"
		},
		[9] = {
			"GetChapterStageInfosReq",
			"GetChapterStageInfosRes",
			block = true
		},
		[10] = {
			"PCLG_SweepsByTimesReq",
			"PCLG_SweepsByTimesRes",
			block = true
		},
		[11] = {
			"PCLG_SweepAutoReq",
			"PCLG_SweepAutoRes",
			block = true
		},
		[12] = {
			"GainPreciousBoxPrizeReq",
			"GainPreciousBoxPrizeRes",
			block = true
		},
		[13] = {
			"ZdlSecKillReq",
			"ZdlSecKillRes",
			block = true
		},
		[14] = {
			"PCLG_GetRewardMultiplyTimesReq",
			"PCLG_GetRewardMultiplyTimesRes",
			block = true
		}
	},
	[55] = {
		{
			"PM_RuneSuitInfoReq",
			"PM_RuneSuitInfoRes",
			block = true
		},
		[255] = "RuneExtension",
		[3] = {
			"PM_RunePetEquipSuitReq",
			"PM_RunePetEquipSuitRes",
			block = true
		},
		[4] = {
			"PM_RunePetUnEquipSuitReq",
			"PM_RunePetUnEquipSuitRes",
			block = true
		},
		[5] = {
			"PM_RuneInstallReq",
			"PM_RuneInstallRes",
			block = true
		},
		[6] = {
			"PM_RuneUninstallReq",
			"PM_RuneUninstallRes",
			block = true
		},
		[7] = {
			"PM_RuneLevelUpReq",
			"PM_RuneLevelUpRes",
			block = true
		},
		[8] = {
			"PM_RuneLockReq",
			"PM_RuneLockRes",
			block = true
		},
		[9] = {
			"PM_RuneUnLockReq",
			"PM_RuneUnLockRes",
			block = true
		},
		[10] = {
			"PM_RuneDecomposeReq",
			"PM_RuneDecomposeRes",
			block = true
		},
		[11] = {
			"PM_RuneOneKeyInstallReq",
			"PM_RuneOneKeyInstallRes",
			block = true
		},
		[12] = {
			"PM_RuneBatchEquipSuitReq",
			"PM_RuneBatchEquipSuitRes",
			block = true
		},
		[13] = {
			"PM_RuneOneKeyUninstallReq",
			"PM_RuneOneKeyUninstallRes",
			block = true
		},
		[14] = {
			"PM_RuneDiamondLevelUpReq",
			"PM_RuneDiamondLevelUpRes",
			block = true
		},
		[20] = {
			"PM_notifyRuneChangedRes"
		},
		[21] = {
			"PM_notifyRuneSuitChangedRes"
		}
	},
	[56] = {
		{
			"PM_ExpeditionGetInfoReq",
			"PM_ExpeditionGetInfoRes",
			block = true
		},
		{
			"PM_ExpeditionDoGridEventReq",
			"PM_ExpeditionDoGridEventRes",
			block = true
		},
		{
			"PM_ExpeditionReviveAllPetReq",
			"PM_ExpeditionReviveAllPetRes",
			block = true
		},
		{
			"PM_ExpeditionSelectGridReq",
			"PM_ExpeditionSelectGridRes",
			block = true
		},
		{
			"PM_ExpeditionSetFormReq",
			"PM_ExpeditionSetFormRes",
			block = true
		},
		{
			"PM_ExpeditionDoEventOverRes"
		},
		{
			"PM_ExpeditionNextLevelReq",
			"PM_ExpeditionNextLevelRes",
			block = true
		},
		{
			"PM_ExpeditionGetFormReq",
			"PM_ExpeditionGetFormRes",
			block = true
		},
		[255] = "ExpeditionExtension",
		[10] = {
			"PM_ExpeditionSweepLevelReq",
			"PM_ExpeditionSweepLevelRes",
			block = true
		},
		[11] = {
			"PM_ExpeditionDoSweepEventReq",
			"PM_ExpeditionDoSweepEventRes",
			block = true
		},
		[12] = {
			"PM_ExpeditionGetWeeklyInfoReq",
			"PM_ExpeditionGetWeeklyInfoRes",
			block = true
		},
		[13] = {
			"PM_ExpeditionOneKeySweepReq",
			"PM_ExpeditionOneKeySweepRes",
			block = true
		}
	},
	[58] = {
		{
			"PM_ChallengeProcessInfoReq",
			"PM_ChallengeProcessInfoRes",
			block = true
		},
		{
			"PM_LegendChallengeInfoReq",
			"PM_LegendChallengeInfoRes",
			block = true
		},
		{
			"PM_ChallengeReq",
			"PM_ChallengeRes",
			block = true
		},
		[255] = "LegendChallengeExtension",
		[5] = {
			"PM_BuyIndependentTimesReq",
			"PM_BuyIndependentTimesRes",
			block = true
		},
		[6] = {
			"SweepsByTimesReq",
			"SweepsByTimesRes",
			block = true
		},
		[7] = {
			"SweepAutoReq",
			"SweepAutoRes",
			block = true
		},
		[8] = {
			"LegendChallengeTimesInfoReq",
			"LegendChallengeTimesInfoRes",
			block = true
		},
		[10] = {
			"NotifyAfterChallengeRes"
		},
		[11] = {
			"LegendChallengeTreasureInfoReq",
			"LegendChallengeTreasureInfoRes",
			block = true
		},
		[12] = {
			"LegendChallengeGainTreasureReq",
			"LegendChallengeGainTreasureRes",
			block = true
		},
		[13] = {
			"LegendChallengeSetFormReq",
			"LegendChallengeSetFormRes",
			block = true
		},
		[14] = {
			"LegendChallengeFormReq",
			"LegendChallengeFormRes",
			block = true
		}
	},
	[59] = {
		{
			"EQM_LoadAllEquipmentsReq",
			"EQM_LoadAllEquipmentsRes",
			block = true
		},
		{
			"EQM_EquipReq",
			"EQM_EquipRes",
			block = true
		},
		{
			"EQM_UpgradeReq",
			"EQM_UpgradeRes",
			block = true
		},
		{
			"EQM_OneKeyEquipReq",
			"EQM_OneKeyEquipRes",
			block = true
		},
		{
			"EQM_OneKeyUnloadReq",
			"EQM_OneKeyUnloadRes",
			block = true
		},
		{
			"EQM_UnloadReq",
			"EQM_UnloadRes",
			block = true
		},
		{
			"EQM_NotifyEquipmentsChangeRes"
		},
		{
			"EQM_BreakoutReq",
			"EQM_BreakoutRes",
			block = true
		},
		{
			"EQM_SetAutoDecomposeReq",
			"EQM_SetAutoDecomposeRes",
			block = true
		},
		{
			"EQM_BatchBreakoutReq",
			"EQM_BatchBreakoutRes",
			block = true
		},
		[255] = "EquipmentExtension"
	},
	[60] = {
		{
			"PM_TimeWheelDecomposeReq",
			"PM_TimeWheelDecomposeRes",
			block = true
		},
		{
			"PM_TimeWheelResetReq",
			"PM_TimeWheelResetRes",
			block = true
		},
		{
			"PM_TimeWheelRevertReq",
			"PM_TimeWheelRevertRes",
			block = true
		},
		{
			"PM_TimeWheelGetDecomposeWhenLotteryReq",
			"PM_TimeWheelGetDecomposeWhenLotteryRes",
			block = true
		},
		{
			"PM_TimeWheelSetDecomposeWhenLotteryReq",
			"PM_TimeWheelSetDecomposeWhenLotteryRes",
			block = true
		},
		{
			"PM_TimeWheelGetResetStrengthenInfoReq",
			"PM_TimeWheelGetResetStrengthenInfoRes",
			block = true
		},
		{
			"PM_DecomposeOverFlowPetReq",
			"PM_DecomposeOverFlowPetRes",
			block = true
		},
		{
			"PM_DecomposeOverFlowItemReq",
			"PM_DecomposeOverFlowItemRes",
			block = true
		},
		{
			"PM_DecomposeOverFlowPetBatchReq",
			"PM_DecomposeOverFlowPetBatchRes",
			block = true
		},
		[255] = "TimeWheelExtension"
	},
	[61] = {
		{
			"PM_PowerCrystalGetInfoReq",
			"PM_PowerCrystalGetInfoRes",
			block = true
		},
		{
			"PM_PowerCrystalPutInSlotReq",
			"PM_PowerCrystalPutInSlotRes",
			block = true
		},
		{
			"PM_PowerCrystalTakeOutOfSlotReq",
			"PM_PowerCrystalTakeOutOfSlotRes",
			block = true
		},
		{
			"PM_PowerCrystalClearSlotCdReq",
			"PM_PowerCrystalClearSlotCdRes",
			block = true
		},
		{
			"PM_PowerCrystalUnlockSlotReq",
			"PM_PowerCrystalUnlockSlotRes",
			block = true
		},
		[255] = "PowerCrystalExtension"
	},
	[62] = {
		{
			"BC_ProcessInfoReq",
			"BC_ProcessInfoRes",
			block = true
		},
		{
			"BC_ChallengeReq",
			"BC_ChallengeRes",
			block = true
		},
		[255] = "BattleCollegeExtension",
		[10] = {
			"BC_NotifyAfterChallengeRes"
		}
	},
	[65] = {
		{
			"ExchangeTabInfoReq",
			"ExchangeTabInfoRes",
			block = true
		},
		{
			"ExchangeReq",
			"ExchangeRes",
			block = true
		},
		{
			"ExchangeRefreshReq",
			"ExchangeRefreshRes",
			block = true
		},
		{
			"ExchangeAllOpenedTabIdsReq",
			"ExchangeAllOpenedTabIdsRes",
			block = true
		},
		[255] = "ExchangeExtension"
	},
	[66] = {
		{
			"MCLG_InfoReq",
			"MCLG_InfoRes",
			block = true
		},
		{
			"MCLG_ChallengeReq",
			"MCLG_ChallengeRes",
			block = true
		},
		{
			"MCLG_DailyTaskRewardReq",
			"MCLG_DailyTaskRewardRes",
			block = true
		},
		{
			"MCLG_OneKeyDailyTaskRewardReq",
			"MCLG_OneKeyDailyTaskRewardRes",
			block = true
		},
		{
			"MCLG_SweepsByTimesReq",
			"MCLG_SweepsByTimesRes",
			block = true
		},
		[255] = "MaterialChallengeExtension",
		[7] = {
			"MCLG_SimpleProgressInfoReq",
			"MCLG_SimpleProgressInfoRes",
			block = true
		},
		[8] = {
			"MCLG_ChallengeBalanceReq",
			"MCLG_ChallengeBalanceRes",
			block = true
		},
		[9] = {
			"MCLG_BuyChallengeTimesReq",
			"MCLG_BuyChallengeTimesRes",
			block = true
		},
		[10] = {
			"MCLG_NotifyAfterChallengeRes"
		},
		[11] = {
			"MCLG_GetRewardMultiplyTimesReq",
			"MCLG_GetRewardMultiplyTimesRes",
			block = true
		},
		[101] = {
			"MCLG_NotifyBaseMultiplyTimesChangeRes"
		}
	},
	[67] = {
		{
			"GetMyPetDispatchInfoReq",
			"GetMyPetDispatchInfoRes",
			block = true
		},
		{
			"DispatchPetsReq",
			"DispatchPetsRes",
			block = true
		},
		{
			"GainTaskPrizeReq",
			"GainTaskPrizeRes",
			block = true
		},
		{
			"GainBoxPrizeReq",
			"GainBoxPrizeRes",
			block = true
		},
		{
			"RefreshTaskReq",
			"RefreshTaskRes",
			block = true
		},
		{
			"RefreshBoxReq",
			"RefreshBoxRes",
			block = true
		},
		[255] = "PetDispatchExtension"
	},
	[68] = {
		{
			"GetAllPayShopBuyTimesReq",
			"GetAllPayShopBuyTimesRes",
			block = true
		},
		[255] = "PayShopExtension",
		[3] = {
			"GetConsumeGiftInfoReq",
			"GetConsumeGiftInfoRes",
			block = true
		},
		[4] = {
			"GainConsumeGiftReq",
			"GainConsumeGiftRes",
			block = true
		},
		[5] = {
			"GetAccConsumeGiftInfoReq",
			"GetAccConsumeGiftInfoRes",
			block = true
		},
		[6] = {
			"GainAccConsumeGiftReq",
			"GainAccConsumeGiftRes",
			block = true
		},
		[7] = {
			"GetLevelTimeMachineInfoReq",
			"GetLevelTimeMachineInfoRes",
			block = true
		},
		[8] = {
			"UseLevelTimeMachineReq",
			"UseLevelTimeMachineRes",
			block = true
		},
		[9] = {
			"BuyItemReq",
			"BuyItemRes",
			block = true
		},
		[10] = {
			"BatchBuyItemReq",
			"BatchBuyItemRes",
			block = true
		},
		[11] = {
			"GetDiscountGiftInfoReq",
			"GetDiscountGiftInfoRes",
			block = true
		},
		[12] = {
			"GainDiscountGiftReq",
			"GainDiscountGiftRes",
			block = true
		},
		[13] = {
			"OneKeyGainDiscountGiftReq",
			"OneKeyGainDiscountGiftRes",
			block = true
		},
		[101] = {
			"NotifyPayShopItemBuySucRes"
		},
		[102] = {
			"NotifyLevelTimeMachineUseSucRes"
		}
	},
	[69] = {
		[255] = "MonthCardExtension",
		[3] = {
			"PM_MonthCardGainDailyPrizeReq",
			"PM_MonthCardGainDailyPrizeRes",
			block = true
		},
		[4] = {
			"PM_NotifyMonthCardBuySucRes"
		},
		[5] = {
			"PM_NotifyMonthCardsBuySucRes"
		}
	},
	[70] = {
		{
			"PM_WorldBossInfoReq",
			"PM_WorldBossInfoRes",
			block = true
		},
		{
			"PM_WorldBossSimulateChallengeReq",
			"PM_WorldBossSimulateChallengeRes",
			block = true
		},
		{
			"PM_WorldBossChallengeReq",
			"PM_WorldBossChallengeRes",
			block = true
		},
		{
			"PM_WorldBossBuyTimesReq",
			"PM_WorldBossBuyTimesRes",
			block = true
		},
		{
			"PM_WorldBossRankInfoReq",
			"PM_WorldBossRankInfoRes",
			block = true
		},
		{
			"PM_WorldBossClearLockReq",
			"PM_WorldBossClearLockRes",
			block = true
		},
		{
			"PM_WorldBossHisotryReq",
			"PM_WorldBossHisotryRes",
			block = true
		},
		[255] = "WorldBossExtension",
		[10] = {
			"PM_NotifyAfterChallengeRes"
		}
	},
	[71] = {
		{
			"PM_PassportGetInfoReq",
			"PM_PassportGetInfoRes",
			block = true
		},
		{
			"PM_PassportGainPrizeReq",
			"PM_PassportGainPrizeRes",
			block = true
		},
		{
			"PM_PassportOneKeyGainPrizeReq",
			"PM_PassportOneKeyGainPrizeRes",
			block = true
		},
		{
			"PM_PassportBuyProgressReq",
			"PM_PassportBuyProgressRes",
			block = true
		},
		{
			"PM_NotifyPassportPayBuyCertSucRes"
		},
		{
			"PM_PassportGainExtraPrizeReq",
			"PM_PassportGainExtraPrizeRes",
			block = true
		},
		{
			"PM_BuyPassportReq",
			"PM_BuyPassportRes",
			block = true
		},
		{
			"PM_GainPayAllPrizeReq",
			"PM_GainPayAllPrizeRes",
			block = true
		},
		[255] = "PassportExtension",
		[10] = {
			"PM_PassportViewReq",
			"PM_PassportViewRes",
			block = true
		},
		[11] = {
			"PM_PassportGetAllUserValidPermanentActsReq",
			"PM_PassportGetAllUserValidPermanentActsRes",
			block = true
		}
	},
	[72] = {
		{
			"PM_GetNinePlaceProcessInfoReq",
			"PM_GetNinePlaceProcessInfoRes",
			block = true
		},
		{
			"PM_NinePlaceChallengeReq",
			"PM_NinePlaceChallengeRes",
			block = true
		},
		{
			"PM_NinePlaceChallengeEndRes"
		},
		[255] = "NinePlaceExtension"
	},
	[74] = {
		{
			"MountInfoReq",
			"MountInfoRes",
			block = true
		},
		{
			"MountUnlockReq",
			"MountUnlockRes",
			block = true
		},
		{
			"MountChangeReq",
			"MountChangeRes",
			block = true
		},
		{
			"MountLevelUpReq",
			"MountLevelUpRes",
			block = true
		},
		{
			"MountBreachReq",
			"MountBreachRes",
			block = true
		},
		{
			"MountSelectActiveMountReq",
			"MountSelectActiveMountRes",
			block = true
		},
		{
			"OneClickDevelopMountReq",
			"OneClickDevelopMountRes",
			block = true
		},
		[255] = "MountExtension",
		[10] = {
			"NotifyMountChangedRes"
		},
		[20] = {
			"MountInviteTeamReq",
			"MountInviteTeamRes",
			block = true
		},
		[21] = {
			"MountAgreeTeamReq",
			"MountAgreeTeamRes",
			block = true
		},
		[22] = {
			"MountLeaveTeamReq",
			"MountLeaveTeamRes",
			block = true
		},
		[23] = {
			"NotifyTeamMountInvitedRes"
		},
		[24] = {
			"NotifyTeamMountChangedRes"
		}
	},
	[76] = {
		{
			"PM_TrainerCourseGetInfoReq",
			"PM_TrainerCourseGetInfoRes",
			block = true
		},
		{
			"PM_GainTrainerCoursePrizeReq",
			"PM_GainTrainerCoursePrizeRes",
			block = true
		},
		{
			"PM_GainTrainerCourseScorePrizeReq",
			"PM_GainTrainerCourseScorePrizeRes",
			block = true
		},
		[255] = "TrainerCourseExtension"
	},
	[77] = {
		{
			"GetJackpotDrawInfoReq",
			"GetJackpotDrawInfoRes",
			block = true
		},
		{
			"JackpotDrawReq",
			"JackpotDrawRes",
			block = true
		},
		[255] = "JackpotExtension"
	},
	[78] = {
		{
			"ST_GetMyStarTeamInfoReq",
			"ST_GetMyStarTeamInfoRes",
			block = true
		},
		{
			"ST_GainPrizeReq",
			"ST_GainPrizeRes",
			block = true
		},
		[255] = "StarTeamExtension"
	},
	[79] = {
		{
			"PM_PetCommentUserInfoReq",
			"PM_PetCommentUserInfoRes",
			block = true
		},
		{
			"PM_PetCommentInfoReq",
			"PM_PetCommentInfoRes",
			block = true
		},
		{
			"PM_SendPetCommentReq",
			"PM_SendPetCommentRes",
			block = true
		},
		{
			"PM_PetCommentLikeReq",
			"PM_PetCommentLikeRes",
			block = true
		},
		{
			"PM_PetCommentReportReq",
			"PM_PetCommentReportRes",
			block = true
		},
		[255] = "PetCommentExtension"
	},
	[80] = {
		{
			"PM_GetScratchUserInfoReq",
			"PM_GetScratchUserInfoRes",
			block = true
		},
		{
			"PM_ScratchExchangeReq",
			"PM_ScratchExchangeRes",
			block = true
		},
		{
			"PM_ScratchSelectBigPrizeReq",
			"PM_ScratchSelectBigPrizeRes",
			block = true
		},
		{
			"PM_ScratchDigReq",
			"PM_ScratchDigRes",
			block = true
		},
		{
			"PM_ScratchResetReq",
			"PM_ScratchResetRes",
			block = true
		},
		{
			"PM_ScratchSwitchPrizeReq",
			"PM_ScratchSwitchPrizeRes",
			block = true
		},
		[255] = "ScratchExtension"
	},
	[81] = {
		{
			"PM_GetMyMonopolyInfoReq",
			"PM_GetMyMonopolyInfoRes",
			block = true
		},
		{
			"PM_MonopolyDiceReq",
			"PM_MonopolyDiceRes",
			block = true
		},
		{
			"PM_BuyDiceTimesReq",
			"PM_BuyDiceTimesRes",
			block = true
		},
		[255] = "MonopolyExtension"
	},
	[82] = {
		{
			"PM_GetMyAllPayTemptInfoReq",
			"PM_GetMyAllPayTemptInfoRes",
			block = true
		},
		[255] = "PayTemptExtension",
		[101] = {
			"PM_NotifyNewGiftRes"
		},
		[102] = {
			"PM_NotifyBuyGiftRes"
		}
	},
	[83] = {
		{
			"PM_AnnuityGainWeeklyPrizeReq",
			"PM_AnnuityGainWeeklyPrizeRes",
			block = true
		},
		{
			"PM_AnnuityGainFixedPrizeReq",
			"PM_AnnuityGainFixedPrizeRes",
			block = true
		},
		{
			"PM_GetUserAnnuityInfoReq",
			"PM_GetUserAnnuityInfoRes",
			block = true
		},
		[255] = "AnnuityExtension",
		[5] = {
			"PM_ActivateAnnuityReq",
			"PM_ActivateAnnuityRes",
			block = true
		},
		[6] = {
			"PM_AnnuityGainMonthPrizeReq",
			"PM_AnnuityGainMonthPrizeRes",
			block = true
		},
		[7] = {
			"PM_AnnuityGainProgressPrizeReq",
			"PM_AnnuityGainProgressPrizeRes",
			block = true
		},
		[8] = {
			"PM_AnnuityGetRankInfoReq",
			"PM_AnnuityGetRankInfoRes",
			block = true
		},
		[9] = {
			"PM_AnnuityGainSpaceProgressPrizeReq",
			"PM_AnnuityGainSpaceProgressPrizeRes",
			block = true
		},
		[10] = {
			"PM_AnnuityGainForwardPayPrizeReq",
			"PM_AnnuityGainForwardPayPrizeRes",
			block = true
		},
		[11] = {
			"PM_AnnuityExchangeReq",
			"PM_AnnuityExchangeRes",
			block = true
		},
		[101] = {
			"PM_AnnuityBuyGiftSuccess"
		}
	},
	[84] = {
		{
			"PM_GetAllShopItemInfoReq",
			"PM_GetAllShopItemInfoRes",
			block = true
		},
		{
			"PM_BuyShopItemReq",
			"PM_BuyShopItemRes",
			block = true
		},
		[255] = "ActivityShopExtension"
	},
	[85] = {
		{
			"PM_GetVipInfoReq",
			"PM_GetVipInfoRes",
			block = true
		},
		{
			"PM_GainVipDailyBonusReq",
			"PM_GainVipDailyBonusRes",
			block = true
		},
		{
			"PM_GainVipOnceFreeBonusReq",
			"PM_GainVipFreeBonusRes",
			block = true
		},
		{
			"PM_GainVipFreeBonusRes",
			block = true
		},
		{
			"PM_VipExpDailyChangeRes",
			block = true
		},
		[255] = "VipExtension"
	},
	[86] = {
		{
			"PM_LoadAllHeadItemReq",
			"PM_LoadAllHeadItemRes",
			block = true
		},
		{
			"PM_ChangeHeadIconReq",
			"PM_ChangeHeadIconRes",
			block = true
		},
		{
			"PM_ChangeHeadFrameReq",
			"PM_ChangeHeadFrameRes",
			block = true
		},
		{
			"PM_notifyHeadIconChangeRes"
		},
		{
			"PM_notifyHeadFrameChangeRes"
		},
		[255] = "HeadItemExtension"
	},
	[87] = {
		{
			"WishingWellInfoReq",
			"WishingWellInfoRes",
			block = true
		},
		{
			"WishingWellDrawReq",
			"WishingWellDrawRes",
			block = true
		},
		{
			"WishingWellShopBuyReq",
			"WishingWellShopBuyRes",
			block = true
		},
		{
			"WishingWellBroadcastReq",
			"WishingWellBroadcastRes",
			block = true
		},
		[255] = "WishingWellExtension",
		[101] = {
			"NotifyWishingWellShopBuySucRes"
		}
	},
	[88] = {
		{
			"PM_GetInfoReq",
			"PM_GetInfoRes",
			block = true
		},
		{
			"PM_BuyReq",
			"PM_BuyRes",
			block = true
		},
		{
			"PM_StartGameReq",
			"PM_StartGameRes",
			block = true
		},
		{
			"PM_ReliveReq",
			"PM_ReliveRes",
			block = true
		},
		{
			"PM_EndGameReq",
			"PM_EndGameRes",
			block = true
		},
		{
			"PM_GetRankInfoReq",
			"PM_GetRankInfoRes",
			block = true
		},
		[255] = "FlyingNuoExtension"
	},
	[90] = {
		{
			"PM_LoadAllPetSkinInfoReq",
			"PM_LoadAllPetSkinInfoRes",
			block = true
		},
		{
			"PM_UsePetSkinReq",
			"PM_UsePetSkinRes",
			block = true
		},
		{
			"PM_ChangePetSkinBodyTypeReq",
			"PM_ChangePetSkinBodyTypeRes",
			block = true
		},
		{
			"PM_BatchUsePetSkinReq",
			"PM_BatchUsePetSkinRes",
			block = true
		},
		{
			"PM_SetPetSkinOtherNameReq",
			"PM_SetPetSkinOtherNameRes",
			block = true
		},
		[255] = "PetSkinExtension",
		[101] = {
			"PM_NotifySkinInfoChangedRes"
		},
		[102] = {
			"PM_NotifyPresentSkinRes"
		}
	},
	[91] = {
		{
			"InfiniteFightInfoReq",
			"InfiniteFightInfoRes",
			block = true
		},
		{
			"SetInfiniteFightFormReq",
			"SetInfiniteFightFormRes",
			block = true
		},
		{
			"GetInfiniteFightFormReq",
			"GetInfiniteFightFormRes",
			block = true
		},
		{
			"InfiniteFightBuffReq",
			"InfiniteFightBuffRes",
			block = true
		},
		{
			"InfiniteStartFightReq",
			"InfiniteStartFightRes",
			block = true
		},
		{
			"InfiniteContinueFightReq",
			"InfiniteContinueFightRes",
			block = true
		},
		{
			"NotifyInfiniteFightEndRes"
		},
		{
			"InfiniteSweepReq",
			"InfiniteSweepRes",
			block = true
		},
		{
			"InfiniteOneKeyFightReq",
			"InfiniteOneKeyFightRes",
			block = true
		},
		[255] = "InfiniteFightExtension"
	},
	[92] = {
		{
			"PM_LoadAllDecorationReq",
			"PM_LoadAllDecorationRes",
			block = true
		},
		{
			"PM_EquipDecorationReq",
			"PM_EquipDecorationRes",
			block = true
		},
		{
			"PM_UnloadDecorationReq",
			"PM_UnloadDecorationRes",
			block = true
		},
		{
			"PM_UpgradeDecorationReq",
			"PM_UpgradeDecorationRes",
			block = true
		},
		{
			"PM_DecomposeDecorationReq",
			"PM_DecomposeDecorationRes",
			block = true
		},
		{
			"PM_SetChcekBoxStatusReq",
			"PM_SetChcekBoxStatusRes",
			block = true
		},
		[255] = "DecorationExtension",
		[101] = {
			"PM_NotifyDecorationsChangeRes"
		}
	},
	[93] = {
		{
			"PM_NewHandCardInfoReq",
			"PM_NewHandCardInfoRes",
			block = true
		},
		{
			"PM_NotifyNewHandCardBuySucRes"
		},
		[255] = "NewHandCardExtension"
	},
	[94] = {
		{
			"PM_NewTreasureInfoReq",
			"PM_NewTreasureInfoRes",
			block = true
		},
		{
			"PM_NewTreasureFinishDigReq",
			"PM_NewTreasureFinishDigRes",
			block = true
		},
		{
			"PM_NewTreasurePrizeReq",
			"PM_NewTreasurePrizeRes",
			block = true
		},
		{
			"PM_NewTreasureDirectGainPrizeReq",
			"PM_NewTreasureDirectGainPrizeRes",
			block = true
		},
		[255] = "NewTreasureExtension",
		[10] = {
			"PM_NewTreasureNotifyStartDigRes"
		}
	},
	[95] = {
		{
			"PM_GetScopeConsumeInfoReq",
			"PM_GetScopeConsumeInfoRes",
			block = true
		},
		{
			"PM_ScopeConsumeGainGiftReq",
			"PM_ScopeConsumeGainGiftRes",
			block = true
		},
		[255] = "ScopeConsumeExtension"
	},
	[97] = {
		{
			"PetCollegeProcessInfoReq",
			"PetCollegeProcessInfoRes",
			block = true
		},
		{
			"PetCollegeChallengeReq",
			"PetCollegeChallengeRes",
			block = true
		},
		[255] = "PetCollegeExtension",
		[10] = {
			"NotifyAfterChallengeRes"
		}
	},
	[98] = {
		{
			"PM_HTGetInfoReq",
			"PM_HTGetInfoRes",
			block = true
		},
		{
			"PM_HTUpdateVerifiedZdlReq",
			"PM_HTUpdateVerifiedZdlRes",
			block = true
		},
		{
			"PM_HTChallengeBossReq",
			"PM_HTChallengeBossRes",
			block = true
		},
		{
			"PM_HTSaveFormReq",
			"PM_HTSaveFormRes",
			block = true
		},
		[255] = "HeroTrialExtension",
		[10] = {
			"PM_HTChallengeEndRes"
		}
	},
	[99] = {
		{
			"GetUserUniversalHundredLotteryInfoReq",
			"GetUserUniversalHundredLotteryInfoRes",
			block = true
		},
		{
			"GainTitlePrizeReq",
			"GainTitlePrizeRes",
			block = true
		},
		[255] = "UniversalHundredLotteryExtension"
	},
	[100] = {
		{
			"PM_TimeLimitRankGetTopInfoReq",
			"PM_TimeLimitRankGetTopInfoRes",
			block = true
		},
		{
			"PM_TimeLimitRankGetProgressInfoReq",
			"PM_TimeLimitRankGetProgressInfoRes",
			block = true
		},
		{
			"PM_TimeLimitRankGainProgressPrizeReq",
			"PM_TimeLimitRankGainProgressPrizeRes",
			block = true
		},
		[255] = "TimeLimitRankExtension"
	},
	[101] = {
		{
			"PM_LoadAllBadgeReq",
			"PM_LoadAllBadgeRes",
			block = true
		},
		[255] = "BadgeExtension",
		[3] = {
			"PM_notifyGainBadgeRes"
		},
		[4] = {
			"PM_ComposeOrUpgradeBadgeReq",
			"PM_ComposeOrUpgradeBadgeRes",
			block = true
		},
		[5] = {
			"PM_GetBadgeUpgradeLogsReq",
			"PM_GetBadgeUpgradeLogsRes",
			block = true
		}
	},
	[102] = {
		{
			"PM_GFGetChatInfoReq",
			"PM_GFGetChatInfoRes",
			block = true
		},
		{
			"PM_GFSelfChatReq",
			"PM_GFSelfChatRes",
			block = true
		},
		{
			"PM_GFGetRaceBookInfoReq",
			"PM_GFGetRaceBookInfoRes",
			block = true
		},
		{
			"PM_GFViewStoryReq",
			"PM_GFViewStoryRes",
			block = true
		},
		{
			"PM_GFGetEventInfoReq",
			"PM_GFGetEventInfoRes",
			block = true
		},
		{
			"PM_GFHandleEventReq",
			"PM_GFHandleEventRes",
			block = true
		},
		{
			"PM_GFGainPrizeReq",
			"PM_GFGainPrizeRes",
			block = true
		},
		{
			"PM_GFOneKeyGainPrizeReq",
			"PM_GFOneKeyGainPrizeRes",
			block = true
		},
		[255] = "GoodFeelingExtension",
		[101] = {
			"PM_GFNotifyAfterHandleEventRes"
		}
	},
	[104] = {
		{
			"Arena3v3InfoReq",
			"Arena3v3InfoRes",
			block = true
		},
		{
			"Arena3v3CurZoneInReq",
			"Arena3v3CurZoneInRes",
			block = true
		},
		{
			"Arena3v3RefreshTargetsReq",
			"Arena3v3RefreshTargetsRes",
			block = true
		},
		{
			"Arena3v3ChallengeReq",
			"Arena3v3ChallengeRes",
			block = true
		},
		{
			"Arena3v3TopDetailReq",
			"Arena3v3TopDetailRes",
			block = true
		},
		{
			"Arena3v3AchievePrizeInfoReq",
			"Arena3v3AchievePrizeInfoRes",
			block = true
		},
		{
			"Arena3v3GainAchievePrizeReq",
			"Arena3v3GainAchievePrizeRes",
			block = true
		},
		{
			"Arena3v3MyDefenseFormationReq",
			"Arena3v3FormationRes",
			block = true
		},
		{
			"Arena3v3OtherFormationReq",
			"Arena3v3FormationRes",
			block = true
		},
		{
			"Arena3v3SetMyDefenseFormationReq",
			"Arena3v3SetMyDefenseFormationRes",
			block = true
		},
		{
			"MyArena3v3ChallengeRecordsReq",
			"MyArena3v3ChallengeRecordsRes",
			block = true
		},
		{
			"Arena3v3VideoReq",
			"Arena3v3VideoRes",
			block = true
		},
		{
			"Arena3v3BuyChallengeItemReq",
			"Arena3v3BuyChallengeItemRes",
			block = true
		},
		{
			"Arena3v3MyAttackFormationReq",
			"Arena3v3FormationRes",
			block = true
		},
		{
			"Arena3v3SetMyAttackFormationReq",
			"Arena3v3SetMyAttackFormationRes",
			block = true
		},
		{
			"Arena3v3GainHangUpPrizeReq",
			"Arena3v3GainHangUpPrizeRes",
			block = true
		},
		[255] = "Arena3v3Extension"
	},
	[105] = {
		{
			"PM_LoadAllThronesReq",
			"PM_LoadAllThronesRes",
			block = true
		},
		{
			"PM_GetThronePanelOtherInfoReq",
			"PM_GetThronePanelOtherInfoRes",
			block = true
		},
		{
			"PM_UpgradeThroneReq",
			"PM_UpgradeThroneRes",
			block = true
		},
		{
			"PM_GainThroneDailyPrizeReq",
			"PM_GainThroneDailyPrizeRes",
			block = true
		},
		{
			"PM_GainThroneAchievementPrizeReq",
			"PM_GainThroneAchievementPrizeRes",
			block = true
		},
		{
			"PM_OneClickUpgradeThroneReq",
			"PM_OneClickUpgradeThroneRes",
			block = true
		},
		[255] = "ThroneExtension",
		[101] = {
			"PM_NotifyThronesChangeRes"
		}
	},
	[106] = {
		{
			"PM_TCGetInfoReq",
			"PM_TCGetInfoRes",
			block = true
		},
		{
			"PM_TCActivateNotesReq",
			"PM_TCActivateNotesRes",
			block = true
		},
		{
			"PM_TCGainDailyPrizeReq",
			"PM_TCGainDailyPrizeRes",
			block = true
		},
		{
			"PM_TCGainProgressPrizeReq",
			"PM_TCGainProgressPrizeRes",
			block = true
		},
		{
			"PM_TCSearchDesireReq",
			"PM_TCSearchDesireRes",
			block = true
		},
		[255] = "TimeCapsuleExtension"
	},
	[107] = {
		{
			"PM_MonthSignInGetInfoReq",
			"PM_MonthSignInGetInfoRes",
			block = true
		},
		{
			"PM_GainMonthSignInPrizeReq",
			"PM_GainMonthSignInPrizeRes",
			block = true
		},
		[255] = "MonthSignInExtension"
	},
	[108] = {
		{
			"PM_AssistInfoReq",
			"PM_AssistInfoRes",
			block = true
		},
		{
			"PM_AssistUpgradePowerReq",
			"PM_AssistUpgradePowerRes",
			block = true
		},
		{
			"PM_AssistUpgradeTeamReq",
			"PM_AssistUpgradeTeamRes",
			block = true
		},
		{
			"PM_AssistSetPetPositionReq",
			"PM_AssistSetPetPositionRes",
			block = true
		},
		{
			"PM_AssistOneClickUpgradeTeamReq",
			"PM_AssistOneClickUpgradeTeamRes",
			block = true
		},
		{
			"PM_AssistOneClickDeployReq",
			"PM_AssistOneClickDeployRes",
			block = true
		},
		[255] = "AssistExtension",
		[100] = {
			"PM_NotifyPetPositionDropRes"
		}
	},
	[109] = {
		{
			"PM_LoadAllHoshigamiReq",
			"PM_LoadAllHoshigamiRes",
			block = true
		},
		{
			"PM_EquipHoshigamiReq",
			"PM_EquipHoshigamiRes",
			block = true
		},
		{
			"PM_UnloadHoshigamiReq",
			"PM_UnloadHoshigamiRes",
			block = true
		},
		{
			"PM_UpgradeHoshigamiReq",
			"PM_UpgradeHoshigamiRes",
			block = true
		},
		{
			"PM_DecomposeHoshigamisReq",
			"PM_DecomposeHoshigamisRes",
			block = true
		},
		{
			"PM_GetAllHoshigamiPrefabSuitReq",
			"PM_GetAllHoshigamiPrefabSuitRes",
			block = true
		},
		{
			"PM_SaveHoshigamiPrefabSuitReq",
			"PM_SaveHoshigamiPrefabSuitRes",
			block = true
		},
		{
			"PM_UseHoshigamiPrefabSuitReq",
			"PM_UseHoshigamiPrefabSuitRes",
			block = true
		},
		[255] = "HoshigamiExtension",
		[101] = {
			"PM_NotifyHoshigamisChangeRes"
		}
	},
	[110] = {
		{
			"ShareTaskInfoReq",
			"ShareTaskInfoRes",
			block = true
		},
		{
			"ShareTaskRefreshBossInfoReq",
			"ShareTaskRefreshBossInfoRes",
			block = true
		},
		{
			"ShareTaskGainDiscoveryRewardReq",
			"ShareTaskGainDiscoveryRewardRes",
			block = true
		},
		{
			"ShareTaskChallengeMyBossReq",
			"ShareTaskChallengeMyBossRes",
			block = true
		},
		{
			"ShareTaskAssistListReq",
			"ShareTaskAssistListRes",
			block = true
		},
		{
			"ShareTaskOtherBossInfoReq",
			"ShareTaskOtherBossInfoRes",
			block = true
		},
		{
			"ShareTaskChallengeOtherBossReq",
			"ShareTaskChallengeOtherBossRes",
			block = true
		},
		{
			"ShareTaskStopTriggerInfoReq",
			"ShareTaskStopTriggerInfoRes",
			block = true
		},
		{
			"ShareTaskStopTriggerChangeReq",
			"ShareTaskStopTriggerChangeRes",
			block = true
		},
		[255] = "ShareTaskExtension",
		[20] = {
			"NotifyTriggerShareTaskRes"
		}
	},
	[111] = {
		{
			"PM_OperationPlotInfoReq",
			"PM_OperationPlotInfoRes",
			block = true
		},
		{
			"PM_OperationPlotChallengeReq",
			"PM_OperationPlotChallengeRes",
			block = true
		},
		{
			"PM_OperationPlotChallengeEndRes"
		},
		{
			"PM_OperationPlotSweepsByTimesReq",
			"PM_OperationPlotSweepsByTimesRes",
			block = true
		},
		{
			"PM_OperationPlotSweepAutoReq",
			"PM_OperationPlotSweepAutoRes",
			block = true
		},
		{
			"PM_OperationPlotGainBuffPrizeReq",
			"PM_OperationPlotGainBuffPrizeRes",
			block = true
		},
		[255] = "OperationPlotExtension"
	},
	[114] = {
		{
			"PM_HCGetInfoReq",
			"PM_HCGetInfoRes",
			block = true
		},
		{
			"PM_HCFirstOpenFuncReq",
			"PM_HCFirstOpenFuncRes",
			block = true
		},
		{
			"PM_HCFirstOpenGuardReq",
			"PM_HCFirstOpenGuardRes",
			block = true
		},
		{
			"PM_HCGainDailyEnergyReq",
			"PM_HCGainDailyEnergyRes",
			block = true
		},
		{
			"PM_HCSaveFormReq",
			"PM_HCSaveFormRes",
			block = true
		},
		{
			"PM_HCChallengeGuardReq",
			"PM_HCChallengeGuardRes",
			block = true
		},
		{
			"PM_HCTrialReq",
			"PM_HCTrialRes",
			block = true
		},
		{
			"PM_HCGainFinalPrizeReq",
			"PM_HCGainFinalPrizeRes",
			block = true
		},
		{
			"PM_HCGetRankInfoReq",
			"PM_HCGetRankInfoRes",
			block = true
		},
		[255] = "HolyChallengeExtension",
		[101] = {
			"PM_HCChallengeEndRes"
		}
	},
	[115] = {
		{
			"PM_PetVerifyInfoReq",
			"PM_PetVerifyInfoRes",
			block = true
		},
		{
			"PM_SetPetVerifyReq",
			"PM_SetPetVerifyRes",
			block = true
		},
		[255] = "PetVerifyBuffExtension"
	},
	[116] = {
		{
			"PM_GetShareLinkDataReq",
			"PM_GetShareLinkDataRes",
			block = true
		},
		{
			"PM_GainShareLinkPrizeReq",
			"PM_GainShareLinkPrizeRes",
			block = true
		},
		[255] = "ShareLinkExtension"
	},
	[117] = {
		{
			"PM_LoadAllFillerReq",
			"PM_LoadAllFillerRes",
			block = true
		},
		{
			"PM_EquipFillerReq",
			"PM_EquipFillerRes",
			block = true
		},
		{
			"PM_UnloadFillerReq",
			"PM_UnloadFillerRes",
			block = true
		},
		{
			"PM_UpgradeSlotReq",
			"PM_UpgradeSlotRes",
			block = true
		},
		{
			"PM_OneKeyEquipFillersReq",
			"PM_OneKeyEquipFillersRes",
			block = true
		},
		{
			"PM_OneKeyUnloadReq",
			"PM_OneKeyUnloadRes",
			block = true
		},
		{
			"PM_SetStarGodAutoDecomposeReq",
			"PM_SetStarGodAutoDecomposeRes",
			block = true
		},
		{
			"PM_StarGodUnbindRaceIdReq",
			"PM_StarGodUnbindRaceIdRes",
			block = true
		},
		[255] = "StarGodPlusExtension",
		[101] = {
			"PM_NotifyFillersChangeRes"
		}
	},
	[118] = {
		{
			"PM_TimedChallengeGetExchangeInfoReq",
			"PM_TimedChallengeGetExchangeInfoRes",
			block = true
		},
		{
			"PM_TimedChallengeDoExchangeReq",
			"PM_TimedChallengeDoExchangeRes",
			block = true
		},
		{
			"PM_TimedChallengeGetPetRankReq",
			"PM_TimedChallengeGetPetRankRes",
			block = true
		},
		{
			"PM_TimedChallengeGetDamageRankReq",
			"PM_TimedChallengeGetDamageRankRes",
			block = true
		},
		{
			"PM_TimedChallengeGetDamageVideoReq",
			"PM_TimedChallengeGetDamageVideoRes",
			block = true
		},
		[255] = "TimedChallengeExtension"
	},
	[119] = {
		{
			"PM_TimedChallengeCircleFightInfoReq",
			"PM_TimedChallengeCircleFightInfoRes",
			block = true
		},
		{
			"PM_TimedChallengeCircleFightReq",
			"PM_TimedChallengeCircleFightRes",
			block = true
		},
		{
			"PM_TimedChallengeCircleSweepReq",
			"PM_TimedChallengeCircleSweepRes",
			block = true
		},
		[255] = "TimedChallengeCircleFightExtension",
		[5] = {
			"PM_TimedChallengeCircleFightFinishRes",
			block = true
		},
		[8] = {
			"PM_TimedChallengeCircleResetChallengeReq",
			"PM_TimedChallengeCircleResetChallengeRes",
			block = true
		}
	},
	[120] = {
		{
			"PM_TimedChallengeAccumulateInfoReq",
			"PM_TimedChallengeAccumulateInfoRes",
			block = true
		},
		{
			"PM_TimedChallengeAccumulateFightReq",
			"PM_TimedChallengeAccumulateFightRes",
			block = true
		},
		{
			"PM_TimedChallengeAccumulateRandomBuffReq",
			"PM_TimedChallengeAccumulateRandomBuffRes",
			block = true
		},
		{
			"PM_TimedChallengeAccumulateFightFinishRes",
			block = true
		},
		[255] = "TimedChallengeAccumulateExtension"
	},
	[121] = {
		{
			"PM_GetMyCurCampaignThemeInfoReq",
			"PM_GetMyCurCampaignThemeInfoRes",
			block = true
		},
		{
			"PM_GainCampaignThemeGiftReq",
			"PM_GainCampaignThemeGiftRes",
			block = true
		},
		[255] = "CampaignThemeExtension",
		[102] = {
			"PM_NotifyCampaignThemeBuyGiftRes"
		}
	},
	[122] = {
		{
			"PM_ActivitySummaryInviteInfoReq",
			"PM_ActivitySummaryInviteInfoRes",
			block = true
		},
		{
			"PM_ActivitySummaryAcceptInviteReq",
			"PM_ActivitySummaryAcceptInviteRes",
			block = true
		},
		{
			"PM_ActivitySummaryGetTaskInfosReq",
			"PM_ActivitySummaryGetTaskInfosRes",
			block = true
		},
		{
			"PM_ActivitySummaryGainTaskPrizeReq",
			"PM_ActivitySummaryGainTaskPrizeRes",
			block = true
		},
		{
			"PM_ActivitySummaryGainProgressPrizeReq",
			"PM_ActivitySummaryGainProgressPrizeRes",
			block = true
		},
		{
			"PM_ActivitySummaryFinishStoryReq",
			"PM_ActivitySummaryFinishStoryRes",
			block = true
		},
		{
			"PM_ActivitySummaryLotteryReq",
			"PM_ActivitySummaryLotteryRes",
			block = true
		},
		{
			"PM_ActivitySummaryGainLotteryProgressPrizeReq",
			"PM_ActivitySummaryGainLotteryProgressPrizeRes",
			block = true
		},
		{
			"PM_GetActivityPluginProgressInfoReq",
			"PM_GetActivityPluginProgressInfoRes",
			block = true
		},
		{
			"PM_GainActivityPluginProgressPrizeReq",
			"PM_GainActivityPluginProgressPrizeRes",
			block = true
		},
		[255] = "ActivitySummaryExtension"
	},
	[124] = {
		{
			"PM_OperationCheckInGetInfoReq",
			"PM_OperationCheckInGetInfoRes",
			block = true
		},
		{
			"PM_OperationCheckInGainPrizeReq",
			"PM_OperationCheckInGainPrizeRes",
			block = true
		},
		[255] = "OperationCheckInExtension"
	},
	[125] = {
		{
			"PM_AresActivityGetRecordReq",
			"PM_AresActivityGetRecordRes",
			block = true
		},
		{
			"PM_AresActivityGetInfoReq",
			"PM_AresActivityGetInfoRes",
			block = true
		},
		{
			"PM_AresActivityGainPrizeReq",
			"PM_AresActivityGainPrizeRes",
			block = true
		},
		[255] = "AresActivityExtension"
	},
	[126] = {
		{
			"PM_LongYanXiXiSkinGainRes"
		},
		[255] = "LongYanXiXiSkinExtension"
	},
	[127] = {
		{
			"PM_GetCurJigsawInfoReq",
			"PM_GetCurJigsawInfoRes",
			block = true
		},
		{
			"PM_GainJigsawTaskPrizeReq",
			"PM_GainJigsawTaskPrizeRes",
			block = true
		},
		{
			"PM_GainJigsawCollectPrizeReq",
			"PM_GainJigsawCollectPrizeRes",
			block = true
		},
		{
			"PM_UnlockJigsawPieceReq",
			"PM_UnlockJigsawPieceRes",
			block = true
		},
		[255] = "JigsawExtension"
	},
	[128] = {
		{
			"PM_TimedChallengeGetInfoReq",
			"PM_TimedChallengeGetInfoRes",
			block = true
		},
		{
			"PM_TimedChallengeStartGameReq",
			"PM_TimedChallengeStartGameRes",
			block = true
		},
		{
			"PM_TimedChallengeEndGameReq",
			"PM_TimedChallengeEndGameRes",
			block = true
		},
		[255] = "TimedChallengeGameExtension"
	},
	[129] = {
		{
			"PM_UnBindTokenReq",
			"PM_UnBindTokenRes",
			block = true
		},
		{
			"PM_PushTokenReq",
			"PM_PushTokenRes",
			block = true
		},
		[255] = "XingeExtension"
	},
	[130] = {
		{
			"PM_CarveUpLotteryGetInfoReq",
			"PM_CarveUpLotteryGetInfoRes",
			block = true
		},
		[255] = "CarveUpDiamondLotteryExtension",
		[3] = {
			"PM_CarveUpLotteryNormalDrawReq",
			"PM_CarveUpLotteryNormalDrawRes",
			block = true
		},
		[4] = {
			"PM_CarveUpLotteryBigDrawReq",
			"PM_CarveUpLotteryBigDrawRes",
			block = true
		},
		[5] = {
			"PM_CarveUpLotteryBigPrizeHitListReq",
			"PM_CarveUpLotteryBigPrizeHitListRes",
			block = true
		},
		[6] = {
			"PM_CarveUpLotteryJinLiPointsRankReq",
			"PM_CarveUpLotteryJinLiPointsRankRes",
			block = true
		}
	},
	[131] = {
		{
			"PM_CampaignConsumeGetInfoReq",
			"PM_CampaignConsumeGetInfoRes",
			block = true
		},
		{
			"PM_CampaignConsumeGainPrizeReq",
			"PM_CampaignConsumeGainPrizeRes",
			block = true
		},
		{
			"PM_CampaignSignPanelReq",
			"PM_CampaignSignPanelRes",
			block = true
		},
		{
			"PM_CampaignConsumeMixSelectReq",
			"PM_CampaignConsumeMixSelectRes",
			block = true
		},
		{
			"PM_CampaignConsumeRankInfoReq",
			"PM_CampaignConsumeRankInfoRes",
			block = true
		},
		{
			"PM_CampaignConsumeOneKeyGainPrizeReq",
			"PM_CampaignConsumeOneKeyGainPrizeRes",
			block = true
		},
		[255] = "CampaignConsumeExtension"
	},
	[132] = {
		{
			"PM_CakeSiginGetInfoReq",
			"PM_CakeSiginGetInfoRes",
			block = true
		},
		{
			"PM_EatCakeReq",
			"PM_EatCakeRes",
			block = true
		},
		[255] = "CakeSiginExtension"
	},
	[133] = {
		{
			"PM_AskFightReq",
			"PM_AskFightRes",
			block = true
		},
		{
			"PM_CancelFightReq",
			"PM_CancelFightRes",
			block = true
		},
		{
			"PM_GetRequestFightInfoReq",
			"PM_GetRequestFightInfoRes",
			block = true
		},
		{
			"PM_RefuseFightReq",
			"PM_RefuseFightRes",
			block = true
		},
		{
			"PM_AcceptFightReq",
			"PM_AcceptFightRes",
			block = true
		},
		{
			"PM_SetDefenseFormReq",
			"PM_SetDefenseFormRes",
			block = true
		},
		{
			"PM_ReadyFightReq",
			"PM_ReadyFightRes",
			block = true
		},
		{
			"PM_LeaveGameReq",
			"PM_LeaveGameRes",
			block = true
		},
		{
			"PM_GetBattleRecordReq",
			"PM_GetBattleRecordRes",
			block = true
		},
		{
			"PM_GetBattleVideoReq",
			"PM_GetBattleVideoRes",
			block = true
		},
		{
			"PM_GetShareBattleResultReq",
			"PM_GetShareBattleResultRes",
			block = true
		},
		{
			"PM_FightSwitchInfoReq",
			"PM_FightSwitchInfoRes",
			block = true
		},
		{
			"PM_SetSwitchReq",
			"PM_SetSwitchRes",
			block = true
		},
		{
			"PM_RefuseAllFightReq",
			"PM_RefuseAllFightRes",
			block = true
		},
		[255] = "QieCuoExtension",
		[101] = {
			"PM_NotifyReceiveFightAskRes"
		},
		[102] = {
			"PM_NotifyCancelFightRes"
		},
		[103] = {
			"PM_NotifyFightRefusedRes"
		},
		[104] = {
			"PM_NotifyFightStartRes"
		},
		[105] = {
			"PM_NotifyOpDefenseReadyRes"
		},
		[106] = {
			"PM_NotifyChangeToAttackRes"
		},
		[107] = {
			"PM_NotifyOpReadyFightRes"
		},
		[108] = {
			"PM_NotifyGameResultRes"
		},
		[109] = {
			"PM_NotifyFightAskFail"
		},
		[110] = {
			"PM_NotifyFightAcceptFail"
		}
	},
	[134] = {
		{
			"PM_FlipTouchGetInfoReq",
			"PM_FlipTouchGetInfoRes",
			block = true
		},
		{
			"PM_FlipTouchGainOutPrizeReq",
			"PM_FlipTouchGainOutPrizeRes",
			block = true
		},
		{
			"PM_FlipTouchStartGameReq",
			"PM_FlipTouchStartGameRes",
			block = true
		},
		{
			"PM_FlipTouchIntoNextStageReq",
			"PM_FlipTouchIntoNextStageRes",
			block = true
		},
		{
			"PM_FlipTouchIncreaseStageTimeReq",
			"PM_FlipTouchIncreaseStageTimeRes",
			block = true
		},
		{
			"PM_FlipTouchEndGameReq",
			"PM_FlipTouchEndGameRes",
			block = true
		},
		{
			"PM_FlipTouchGainGlobalPrizeReq",
			"PM_FlipTouchGainGlobalPrizeRes",
			block = true
		},
		[255] = "FlipTouchExtension"
	},
	[135] = {
		{
			"PM_TimedChallengeMiYaInfoReq",
			"PM_TimedChallengeMiYaInfoRes",
			block = true
		},
		{
			"PM_TimedChallengeMiYaGainDailyPrizeReq",
			"PM_TimedChallengeMiYaGainDailyPrizeRes",
			block = true
		},
		{
			"PM_TimedChallengeMiYaRandomModeReq",
			"PM_TimedChallengeMiYaRandomModeRes",
			block = true
		},
		{
			"PM_TimedChallengeMiYaProcessModeReq",
			"PM_TimedChallengeMiYaProcessModeRes",
			block = true
		},
		{
			"PM_TimedChallengeMiYaEventFinishRes",
			block = true
		},
		{
			"PM_TimedChallengeMiYaBuyAwakenGoodsRes",
			block = true
		},
		[255] = "TimedChallengeMiYaExtension"
	},
	[136] = {
		{
			"PM_LuckyDrawGetInfoReq",
			"PM_LuckyDrawGetInfoRes",
			block = true
		},
		{
			"PM_LuckyDrawReq",
			"PM_LuckyDrawRes",
			block = true
		},
		{
			"PM_LuckyDrawBuyItemReq",
			"PM_LuckyDrawBuyItemRes",
			block = true
		},
		{
			"PM_LuckyDrawGainProcessPirzeReq",
			"PM_LuckyDrawGainProcessPirzeRes",
			block = true
		},
		{
			"PM_LuckyDrawRankViewReq",
			"PM_LuckyDrawRankViewRes",
			block = true
		},
		[255] = "LuckyDrawExtension"
	},
	[137] = {
		{
			"PM_GetGiftInfoReq",
			"PM_GetGiftInfoRes",
			block = true
		},
		{
			"PM_NotifyBuyGiftRes"
		},
		[255] = "ZeroPayExtension"
	},
	[138] = {
		{
			"PM_PayTrussGetInfoReq",
			"PM_PayTrussGetInfoRes",
			block = true
		},
		{
			"PM_PayTrussNotifyPaySucRes"
		},
		[255] = "PayTrussExtension"
	},
	[139] = {
		{
			"PM_GameECollectionGetInfoReq",
			"PM_GameECollectionGetInfoRes",
			block = true
		},
		{
			"PM_GameECollectionBuyTimesReq",
			"PM_GameECollectionBuyTimesRes",
			block = true
		},
		[255] = "GameCollectionExtension"
	},
	[140] = {
		{
			"PM_FindTheFalseStartGameReq",
			"PM_FindTheFalseStartGameRes",
			block = true
		},
		{
			"PM_FindTheFalseEndGameReq",
			"PM_FindTheFalseEndGameRes",
			block = true
		},
		[255] = "FindTheFalseExtension"
	},
	[141] = {
		{
			"PM_TiaoYiTiaoStartGameReq",
			"PM_TiaoYiTiaoStartGameRes",
			block = true
		},
		{
			"PM_TiaoYiTiaoEndGameReq",
			"PM_TiaoYiTiaoEndGameRes",
			block = true
		},
		[255] = "TiaoYiTiaoExtension"
	},
	[142] = {
		{
			"PM_FlappyBirdStartGameReq",
			"PM_FlappyBirdStartGameRes",
			block = true
		},
		{
			"PM_FlappyBirdEndGameReq",
			"PM_FlappyBirdEndGameRes",
			block = true
		},
		{
			"PM_FlappyBirdReviveReq",
			"PM_FlappyBirdReviveRes",
			block = true
		},
		[255] = "FlappyBirdExtension"
	},
	[143] = {
		{
			"PM_ConsumeLotteryGetInfoReq",
			"PM_ConsumeLotteryGetInfoRes",
			block = true
		},
		{
			"PM_ConsumeLotteryDrawReq",
			"PM_ConsumeLotteryDrawRes",
			block = true
		},
		{
			"PM_ConsumeLotteryGetAddressInfoReq",
			"PM_ConsumeLotteryGetAddressInfoRes",
			block = true
		},
		{
			"PM_ConsumeLotteryUpdateAddressInfoReq",
			"PM_ConsumeLotteryUpdateAddressInfoRes",
			block = true
		},
		[255] = "ConsumeLotteryExtension"
	},
	[144] = {
		{
			"PM_SeekPetInfoReq",
			"PM_SeekPetInfoRes",
			block = true
		},
		{
			"PM_SeekPetReq",
			"PM_SeekPetRes",
			block = true
		},
		{
			"PM_SeekPetRefreshReq",
			"PM_SeekPetRefreshRes",
			block = true
		},
		{
			"PM_SeekPetDirectlyReq",
			"PM_SeekPetDirectlyRes",
			block = true
		},
		{
			"PM_SeekPetChallengeReq",
			"PM_SeekPetChallengeRes",
			block = true
		},
		[255] = "SeekPetExtension",
		[10] = {
			"NotifyAfterChallengeRes"
		}
	},
	[145] = {
		{
			"PM_DreamIslanTaskGetInfoReq",
			"PM_DreamIslanTaskGetInfoRes",
			block = true
		},
		{
			"PM_GainDreamIslandTaskPrizeReq",
			"PM_GainDreamIslandTaskPrizeRes",
			block = true
		},
		{
			"PM_GainDreamIslanTaskScorePrizeReq",
			"PM_GainDreamIslanTaskScorePrizeRes",
			block = true
		},
		[255] = "DreamIslanTaskExtension"
	},
	[146] = {
		{
			"PM_GashaponGetDiamondNumReq",
			"PM_GashaponGetDiamondNumRes",
			block = true
		},
		{
			"PM_GashaponGetRankInfosReq",
			"PM_GashaponGetRankInfosRes",
			block = true
		},
		{
			"PM_GashaponDrawReq",
			"PM_GashaponDrawRes",
			block = true
		},
		[255] = "GashaponExtension"
	},
	[147] = {
		{
			"PM_AiXinMMClgGetInfoReq",
			"PM_AiXinMMClgGetInfoRes",
			block = true
		},
		{
			"PM_AiXinMMClgChallengeReq",
			"PM_AiXinMMClgChallengeRes",
			block = true
		},
		[255] = "AiXinMMClgExtension",
		[101] = {
			"PM_AiXinMMClgChallengeEndRes"
		}
	},
	[148] = {
		{
			"PM_DuoLaMMClgGetInfoReq",
			"PM_DuoLaMMClgGetInfoRes",
			block = true
		},
		{
			"PM_DuoLaMMClgBuyPieceReq",
			"PM_DuoLaMMClgBuyPieceRes",
			block = true
		},
		{
			"PM_DuoLaMMClgBuyGameTimesReq",
			"PM_DuoLaMMClgBuyGameTimesRes",
			block = true
		},
		{
			"PM_DuoLaMMClgStartGameReq",
			"PM_DuoLaMMClgStartGameRes",
			block = true
		},
		{
			"PM_DuoLaMMClgReliveReq",
			"PM_DuoLaMMClgReliveRes",
			block = true
		},
		{
			"PM_DuoLaMMClgEndGameReq",
			"PM_DuoLaMMClgEndGameRes",
			block = true
		},
		{
			"PM_DuoLaMMClgOpenEvolveReq",
			"PM_DuoLaMMClgOpenEvolveRes",
			block = true
		},
		[255] = "DuoLaMMClgExtension",
		[101] = {
			"PM_DuoLaMMClgEvolveSucRes"
		}
	},
	[149] = {
		{
			"PM_GetFamilyTechInfoReq",
			"PM_GetFamilyTechInfoRes",
			block = true
		},
		[255] = "FamilyTechExtension",
		[3] = {
			"PM_UpgradeFamilyTechReq",
			"PM_UpgradeFamilyTechRes",
			block = true
		},
		[100] = {
			"PM_NotifyFamilyTechChangeRes"
		}
	},
	[150] = {
		{
			"PM_LoadHasRentPetReq",
			"PM_LoadHasRentPetRes",
			block = true
		},
		{
			"PM_LeasePetGetInfoReq",
			"PM_LeasePetGetInfoRes",
			block = true
		},
		{
			"PM_LeasePetReq",
			"PM_LeasePetRes",
			block = true
		},
		{
			"PM_RentPetReq",
			"PM_RentPetRes",
			block = true
		},
		{
			"PM_NotifyRentPetUseTimesChangeRes"
		},
		{
			"PM_SetRentPetFormReq",
			"PM_SetRentPetFormRes",
			block = true
		},
		{
			"PM_PetLeaseTakeOffPetReq",
			"PM_PetLeaseTakeOffPetRes",
			block = true
		},
		[255] = "PetLeaseExtension"
	},
	[151] = {
		{
			"PM_GetTeamPlayProgressInfoReq",
			"PM_GetTeamPlayProgressInfoRes",
			block = true
		},
		{
			"PM_ViewMemberZdlInfoListReq",
			"PM_ViewMemberZdlInfoListRes",
			block = true
		},
		{
			"PM_ViewFamilyTeamPlayRankReq",
			"PM_ViewFamilyTeamPlayRankRes",
			block = true
		},
		{
			"PM_TeamPlayFightReq",
			"PM_TeamPlayFightRes",
			block = true
		},
		{
			"PM_TeamPlayPracticeReq",
			"PM_TeamPlayPracticeRes",
			block = true
		},
		{
			"PM_ViewMemberDamageListReq",
			"PM_ViewMemberDamageListRes",
			block = true
		},
		{
			"PM_TeamPlaySmallGameStartReq",
			"PM_TeamPlaySmallGameStartRes",
			block = true
		},
		{
			"PM_TeamPlaySmallGameEndReq",
			"PM_TeamPlaySmallGameEndRes",
			block = true
		},
		{
			"PM_CheckTeamPlayBossValidReq",
			"PM_CheckTeamPlayBossValidRes",
			block = true
		},
		{
			"PM_ChooseTeamPlayWarZoneReq",
			"PM_ChooseTeamPlayWarZoneRes",
			block = true
		},
		{
			"PM_GetFamilyZoneRnakReq",
			"PM_GetFamilyZoneRnakRes",
			block = true
		},
		{
			"PM_GetFamilyZoneInfoReq",
			"PM_GetFamilyZoneInfoRes",
			block = true
		},
		[255] = "FamilyTeamPlayExtension",
		[100] = {
			"PM_NotifyAfterTeamPlayBattleRes"
		}
	},
	[152] = {
		{
			"PM_AnHeiMMChallengeGetInfoReq",
			"PM_AnHeiMMChallengeGetInfoRes",
			block = true
		},
		{
			"PM_AnHeiMMChallengeGainDailyPrizeReq",
			"PM_AnHeiMMChallengeGainDailyPrizeRes",
			block = true
		},
		{
			"PM_AnHeiMMChallengeBuyTimesReq",
			"PM_AnHeiMMChallengeBuyTimesRes",
			block = true
		},
		{
			"PM_AnHeiMMChallengeChooseModeReq",
			"PM_AnHeiMMChallengeChooseModeRes",
			block = true
		},
		{
			"PM_AnHeiMMChallengeReChooseRuleReq",
			"PM_AnHeiMMChallengeReChooseRuleRes",
			block = true
		},
		{
			"PM_AnHeiMMChallengeChallengeReq",
			"PM_AnHeiMMChallengeChallengeRes",
			block = true
		},
		{
			"PM_AnHeiMMChallengeConfirmResultReq",
			"PM_AnHeiMMChallengeConfirmResultRes",
			block = true
		},
		{
			"PM_AnHeiMMChallengeGiveUpReq",
			"PM_AnHeiMMChallengeGiveUpRes",
			block = true
		},
		[255] = "AnHeiMMChallengeExtension",
		[101] = {
			"PM_AnHeiMMChallengeChallengeEndRes"
		}
	},
	[153] = {
		{
			"GetGiftInfoReq",
			"GetGiftInfoRes",
			block = true
		},
		{
			"PM_NotifyBuyGiftRes"
		},
		[255] = "NewZeroPayExtension"
	},
	[154] = {
		{
			"SF_ScuffleInfoReq",
			"SF_ScuffleInfoRes",
			block = true
		},
		{
			"SF_StartMatchingReq",
			"SF_StartMatchingRes",
			block = true
		},
		{
			"SF_CancelMatchingReq",
			"SF_CancelMatchingRes",
			block = true
		},
		{
			"SF_LeaveGameReq",
			"SF_LeaveGameRes",
			block = true
		},
		{
			"SF_BanPetReq",
			"SF_BanPetRes",
			block = true
		},
		{
			"SF_SetFormReq",
			"SF_SetFormRes",
			block = true
		},
		{
			"SF_AchievePrizeInfoReq",
			"SF_AchievePrizeInfoRes",
			block = true
		},
		{
			"SF_GainAchievePrizeReq",
			"SF_GainAchievePrizeRes",
			block = true
		},
		{
			"SF_DailyTaskInfoReq",
			"SF_DailyTaskInfoRes",
			block = true
		},
		{
			"SF_GainDailyTaskReq",
			"SF_GainDailyTaskRes",
			block = true
		},
		{
			"SF_GetBattleRecordReq",
			"SF_GetBattleRecordRes",
			block = true
		},
		{
			"SF_GetBattleVideoReq",
			"SF_GetBattleVideoRes",
			block = true
		},
		{
			"SF_GetRankInfoReq",
			"SF_GetRankInfoRes",
			block = true
		},
		{
			"SF_GetAllSeasonInfoReq",
			"SF_GetAllSeasonInfoRes",
			block = true
		},
		{
			"SF_RefreshMyRankReq",
			"SF_RefreshMyRankRes",
			block = true
		},
		[255] = "ScuffleExtension",
		[101] = {
			"SF_NotifyMatchingOverTimeRes"
		},
		[102] = {
			"SF_NotifyMatchFailRes"
		},
		[103] = {
			"SF_NotifyGameStartRes"
		},
		[104] = {
			"SF_NotifyOpBanFinishRes"
		},
		[105] = {
			"SF_NotfiyStartSetFormRes"
		},
		[106] = {
			"SF_NotifiyOpReadyFightRes"
		},
		[107] = {
			"SF_NotifyGameEndRes"
		}
	},
	[155] = {
		{
			"PM_ComposeEquipmentReq",
			"PM_ComposeEquipmentRes",
			block = true
		},
		{
			"PM_DecompseEquipmentReq",
			"PM_DecompseEquipmentRes",
			block = true
		},
		{
			"PM_ComposeThroneReq",
			"PM_ComposeThroneRes",
			block = true
		},
		{
			"PM_ComposeStarGodFillerReq",
			"PM_ComposeStarGodFillerRes",
			block = true
		},
		{
			"PM_GetComposeTimesReq",
			"PM_GetComposeTimesRes",
			block = true
		},
		[255] = "EquipmentComposeExtension"
	},
	[156] = {
		{
			"PM_PursueDreamGetInfoReq",
			"PM_PursueDreamGetInfoRes",
			block = true
		},
		{
			"PM_PursueDreamChallengeReq",
			"PM_PursueDreamChallengeRes",
			block = true
		},
		{
			"PM_PursueDreamSetFormsReq",
			"PM_PursueDreamSetFormsRes",
			block = true
		},
		{
			"PM_PursueDreamGetFormsReq",
			"PM_PursueDreamGetFormsRes",
			block = true
		},
		{
			"PM_PursueDreamGetRanksReq",
			"PM_PursueDreamGetRanksRes",
			block = true
		},
		{
			"PM_PursueDreamGainDailyBonusReq",
			"PM_PursueDreamGainDailyBonusRes",
			block = true
		},
		[255] = "PursueDreamExtension"
	},
	[157] = {
		{
			"GetActivityInfoReq",
			"GetActivityInfoRes",
			block = true
		},
		{
			"GainDailyPrizeReq",
			"GainDailyPrizeRes",
			block = true
		},
		{
			"GainMassPrizeReq",
			"GainMassPrizeRes",
			block = true
		},
		[255] = "PoolPreHeatExtension"
	},
	[158] = {
		{
			"GetPayInfoReq",
			"GetPayInfoRes",
			block = true
		},
		{
			"GainExGiftReq",
			"GainExGiftRes",
			block = true
		},
		{
			"PM_NotifyBuyGiftRes"
		},
		[255] = "DiscountAccruingPayExtension"
	},
	[159] = {
		{
			"PM_GetActivityInfoReq",
			"PM_GetActivityInfoRes",
			block = true
		},
		{
			"GainPrizeReq",
			"GainPrizeRes",
			block = true
		},
		[255] = "ConsumeDiamondGiftExtension"
	},
	[161] = {
		{
			"PM_GetMaterialRecoverInfosReq",
			"PM_GetMaterialRecoverInfosRes",
			block = true
		},
		{
			"PM_GainMaterialRecoverReq",
			"PM_GainMaterialRecoverRes",
			block = true
		},
		[255] = "MaterialRecoverExtension"
	},
	[162] = {
		{
			"PM_GetAnnuityAccLotteryInfoReq",
			"PM_GetAnnuityAccLotteryInfoRes",
			block = true
		},
		[255] = "AnnuityAccumulateLotteryExtension",
		[3] = {
			"AnnuityAccumulateLotteryDrawReq",
			"AnnuityAccumulateLotteryDrawRes",
			block = true
		}
	},
	[163] = {
		{
			"PM_GetEnergyInfoReq",
			"PM_GetEnergyInfoRes",
			block = true
		},
		{
			"PM_GetAllEnergyInfoReq",
			"PM_GetAllEnergyInfoRes",
			block = true
		},
		{
			"PM_BuyEnergyReq",
			"PM_BuyEnergyRes",
			block = true
		},
		[255] = "EnergyExtension",
		[10] = {
			"PM_NotifyEnergyChangeRes"
		}
	},
	[164] = {
		{
			"PM_RegressGetActInfoReq",
			"PM_RegressGetActInfoRes",
			block = true
		},
		{
			"PM_RegressGetSignInInfoReq",
			"PM_RegressGetSignInInfoRes",
			block = true
		},
		{
			"PM_RegressGetTaskInfoReq",
			"PM_RegressGetTaskInfoRes",
			block = true
		},
		{
			"PM_RegressGetShopInfoReq",
			"PM_RegressGetShopInfoRes",
			block = true
		},
		[10] = {
			"PM_RegressGetPrivilegeInfoReq",
			"PM_RegressGetPrivilegeInfoRes",
			block = true
		},
		{
			"PM_RegressGainSignInPrizeReq",
			"PM_RegressGainSignInPrizeRes",
			block = true
		},
		{
			"PM_RegressGainTaskPrizeReq",
			"PM_RegressGainTaskPrizeRes",
			block = true
		},
		{
			"PM_RegressGainTaskScorePrizeReq",
			"PM_RegressGainTaskScorePrizeRes",
			block = true
		},
		{
			"PM_RegressBuyShopItemReq",
			"PM_RegressBuyShopItemRes",
			block = true
		},
		{
			"PM_RegressSetOpenReq",
			"PM_RegressSetOpenRes",
			block = true
		},
		[255] = "RegressExtension",
		[11] = {
			"PM_RegressGainGoldenDiamondCardReq",
			"PM_RegressGainGoldenDiamondCardRes",
			block = true
		},
		[101] = {
			"PM_NotifyRegressBuyGiftRes"
		}
	},
	[165] = {
		{
			"PM_LightKingChallengeGetInfoReq",
			"PM_LightKingChallengeGetInfoRes",
			block = true
		},
		{
			"PM_LightKingChallengeSetFormReq",
			"PM_LightKingChallengeSetFormRes",
			block = true
		},
		{
			"PM_LightKingChallengeGetFormReq",
			"PM_LightKingChallengeGetFormRes",
			block = true
		},
		{
			"PM_LightKingChallengeUpgradeReq",
			"PM_LightKingChallengeUpgradeRes",
			block = true
		},
		{
			"PM_LightKingChallengeFightReq",
			"PM_LightKingChallengeFightRes",
			block = true
		},
		{
			"PM_LightKingChallengeGainProgressPrizeReq",
			"PM_LightKingChallengeGainProgressPrizeRes",
			block = true
		},
		{
			"PM_LightKingChallengeBuyTimesReq",
			"PM_LightKingChallengeBuyTimesRes",
			block = true
		},
		{
			"PM_LightKingChallengeCheatReq",
			"PM_LightKingChallengeCheatRes",
			block = true
		},
		{
			"PM_LightKingChallengeGetRanksReq",
			"PM_LightKingChallengeGetRanksRes",
			block = true
		},
		{
			"PM_LightKingChallengeAfterFightRes"
		},
		[255] = "LightKingChallengeExtension"
	},
	[166] = {
		{
			"PM_DailyRechargeInfoReq",
			"PM_DailyRechargeInfoRes",
			block = true
		},
		{
			"PM_GainDailyRechargePrizeReq",
			"PM_GainDailyRechargePrizeRes",
			block = true
		},
		[255] = "DailyRechargeExtension"
	},
	[167] = {
		{
			"PM_VacationPowerSurgeGetInfoReq",
			"PM_VacationPowerSurgeGetInfoRes",
			block = true
		},
		{
			"PM_VacationPowerSurgeGainProgressPrizeReq",
			"PM_VacationPowerSurgeGainProgressPrizeRes",
			block = true
		},
		{
			"PM_VacationPowerSurgeOnePassReq",
			"PM_VacationPowerSurgeOnePassRes",
			block = true
		},
		{
			"PM_VacationPowerSurgeGainTaskPrizeReq",
			"PM_VacationPowerSurgeGainTaskPrizeRes",
			block = true
		},
		{
			"PM_VacationPowerSurgeNotifyTaskInfosRes"
		},
		[255] = "VacationPowerSurgeExtension"
	},
	[168] = {
		{
			"PM_FengBaoBaoClgGetInfoReq",
			"PM_FengBaoBaoClgGetInfoRes",
			block = true
		},
		{
			"PM_FengBaoBaoChallengeSetFormReq",
			"PM_FengBaoBaoChallengeSetFormRes",
			block = true
		},
		{
			"PM_FengBaoBaoChallengeGetFormReq",
			"PM_FengBaoBaoChallengeGetFormRes",
			block = true
		},
		{
			"PM_FengBaoBaoClgStartGameReq",
			"PM_FengBaoBaoClgStartGameRes",
			block = true
		},
		[255] = "FengBaoBaoChallengeExtension",
		[6] = {
			"PM_FengBaoBaoClgEndGameReq",
			"PM_FengBaoBaoClgEndGameRes",
			block = true
		},
		[7] = {
			"PM_FengBaoBaoClgBuyTimesReq",
			"PM_FengBaoBaoClgBuyTimesRes",
			block = true
		},
		[9] = {
			"PM_FengBaoBaoClgFightReq",
			"PM_FengBaoBaoClgFightRes",
			block = true
		}
	},
	[170] = {
		{
			"PM_BuryPitGameGetInfoReq",
			"PM_BuryPitGameGetInfoRes",
			block = true
		},
		{
			"PM_BuryPitGameStartGameReq",
			"PM_BuryPitGameStartGameRes",
			block = true
		},
		{
			"PM_BuryPitGameEndGameReq",
			"PM_BuryPitGameEndGameRes",
			block = true
		},
		{
			"PM_BuryPitGameBuyGameTimesReq",
			"PM_BuryPitGameBuyGameTimesRes",
			block = true
		},
		{
			"PM_BuryPitGameGainScorePrizeReq",
			"PM_BuryPitGameGainScorePrizeRes",
			block = true
		},
		{
			"PM_BuryPitGameGetRankInfoReq",
			"PM_BuryPitGameGetRankInfoRes",
			block = true
		},
		[255] = "BuryPitGameExtension"
	},
	[171] = {
		{
			"PM_ElizabethClgGetInfoReq",
			"PM_ElizabethClgGetInfoRes",
			block = true
		},
		{
			"PM_ElizabethClgStartGameReq",
			"PM_ElizabethClgStartGameRes",
			block = true
		},
		{
			"PM_ElizabethClgEndGameReq",
			"PM_ElizabethClgEndGameRes",
			block = true
		},
		{
			"PM_ElizabethClgBuyTimesReq",
			"PM_ElizabethClgBuyTimesRes",
			block = true
		},
		{
			"PM_ElizabethClgReliveReq",
			"PM_ElizabethClgReliveRes",
			block = true
		},
		{
			"PM_ElizabethClgGainPrizeReq",
			"PM_ElizabethClgGainPrizeRes",
			block = true
		},
		[255] = "ElizabethChallengeExtension"
	},
	[172] = {
		{
			"PM_DarkDragonPreheatGetInfoReq",
			"PM_DarkDragonPreheatGetInfoRes",
			block = true
		},
		{
			"PM_DarkDragonPreheatGainTaskPrizeReq",
			"PM_DarkDragonPreheatGainTaskPrizeRes",
			block = true
		},
		{
			"PM_DarkDragonPreheatGainProgressPrizeReq",
			"PM_DarkDragonPreheatGainProgressPrizeRes",
			block = true
		},
		{
			"PM_DarkDragonPreheatFinishStoryReq",
			"PM_DarkDragonPreheatFinishStoryRes",
			block = true
		},
		[255] = "DarkDragonPreheatExtension"
	},
	[173] = {
		{
			"PM_GetMirrorTrialInfoReq",
			"PM_GetMirrorTrialInfoRes",
			block = true
		},
		{
			"PM_MirrorTrialFightReq",
			"PM_MirrorTrialFightRes",
			block = true
		},
		{
			"PM_MirrorTrialGainPrizeReq",
			"PM_MirrorTrialGainPrizeRes",
			block = true
		},
		{
			"PM_MirrorTrialBuyScoreReq",
			"PM_MirrorTrialBuyScoreRes",
			block = true
		},
		[255] = "MirrorTrialExtension",
		[100] = {
			"PM_MirrorTrialNotifyFightResult"
		},
		[101] = {
			"PM_MirrorTrialNotifyPaySucRes"
		}
	},
	[174] = {
		{
			"PM_NGGetActInfoReq",
			"PM_NGGetActInfoRes",
			block = true
		},
		{
			"PM_NGGetGameRecordReq",
			"PM_NGGetGameRecordRes",
			block = true
		},
		{
			"PM_NGGainScorePrizeReq",
			"PM_NGGainScorePrizeRes",
			block = true
		},
		{
			"PM_NGGetRankInfoReq",
			"PM_NGGetRankInfoRes",
			block = true
		},
		{
			"PM_NGBeginMatchReq",
			"PM_NGBeginMatchRes",
			block = true
		},
		{
			"PM_NGCancelMatchReq",
			"PM_NGCancelMatchRes",
			block = true
		},
		{
			"PM_NGGuessNumberReq",
			"PM_NGGuessNumberRes",
			block = true
		},
		{
			"PM_NGLeaveGameReq",
			"PM_NGLeaveGameRes",
			block = true
		},
		{
			"PM_NGSendChatMsgReq",
			"PM_NGSendChatMsgRes",
			block = true
		},
		{
			"PM_NGGainProgressPrizeReq",
			"PM_NGGainProgressPrizeRes",
			block = true
		},
		[255] = "NumberGameExtension",
		[101] = {
			"PM_NGNotifyGameStartRes"
		},
		[102] = {
			"PM_NGNotifyGameOperationRes"
		},
		[104] = {
			"PM_NGNotifyGameEndRes"
		},
		[105] = {
			"PM_NGNotifyMatchFailRes"
		},
		[106] = {
			"PM_NGNotifyOtherOperationRes"
		}
	},
	[175] = {
		{
			"PM_TheOutcastChallengeInfoReq",
			"PM_TheOutcastChallengeInfoRes",
			block = true
		},
		{
			"PM_TheOutcastChallengeReq",
			"PM_TheOutcastChallengeRes",
			block = true
		},
		{
			"PM_TheOutcastChallengeGameReq",
			"PM_TheOutcastChallengeGameRes",
			block = true
		},
		{
			"PM_TheOutcastChallengeEndGameReq",
			"PM_TheOutcastChallengeEndGameRes",
			block = true
		},
		{
			"PM_TheOutcastChallengeRankInfoReq",
			"PM_TheOutcastChallengeRankInfoRes",
			block = true
		},
		[255] = "TheOutcastChallengeExtension",
		[10] = {
			"PM_NotifyAfterChallengeRes"
		}
	},
	[176] = {
		{
			"PM_LuoTianDaJiaoGetInfoReq",
			"PM_LuoTianDaJiaoGetInfoRes",
			block = true
		},
		[255] = "LuoTianDaJiaoExtension",
		[4] = {
			"PM_LuoTianDaJiaoUpgradeReq",
			"PM_LuoTianDaJiaoUpgradeRes",
			block = true
		},
		[5] = {
			"PM_LuoTianDaJiaoChoiceReq",
			"PM_LuoTianDaJiaoChoiceRes",
			block = true
		},
		[6] = {
			"PM_LuoTianDaJiaoFightReq",
			"PM_LuoTianDaJiaoFightRes",
			block = true
		},
		[7] = {
			"PM_LuoTianDaJiaoGainPrizeReq",
			"PM_LuoTianDaJiaoGainPrizeRes",
			block = true
		},
		[10] = {
			"PM_LuoTianDaJiaoAfterFightRes"
		}
	},
	[177] = {
		{
			"PM_GetHistoryInfoReq",
			"PM_GetHistoryInfoRes",
			block = true
		},
		{
			"PM_SendFlowerReq",
			"PM_SendFlowerRes",
			block = true
		},
		{
			"PM_SupportFlowerReq",
			"PM_SupportFlowerRes",
			block = true
		},
		{
			"PM_GetFlowerSendRankReq",
			"PM_GetFlowerSendRankRes",
			block = true
		},
		{
			"PM_GetFlowerCharmRankReq",
			"PM_GetFlowerCharmRankRes",
			block = true
		},
		{
			"PM_GetFlowerRecordReq",
			"PM_GetFlowerRecordRes",
			block = true
		},
		{
			"PM_GetIndividualRankReq",
			"PM_GetIndividualRankRes",
			block = true
		},
		[255] = "SendFlowerExtension",
		[100] = {
			"PM_NotifyReceiveFlowerRes"
		}
	},
	[178] = {
		{
			"PM_SceneAnswerInfoReq",
			"PM_SceneAnswerInfoRes",
			block = true
		},
		{
			"PM_SceneAnswerReq",
			"PM_SceneAnswerRes"
		},
		{
			"PM_SceneAnswerGainScorePrizeReq",
			"PM_SceneAnswerGainScorePrizeRes",
			block = true
		},
		{
			"PM_SceneAnswerSeekHelpReq",
			"PM_SceneAnswerSeekHelpRes",
			block = true
		},
		[255] = "SceneAnswerExtension",
		[10] = {
			"PM_NotifyNewQuestionRes"
		},
		[11] = {
			"PM_NotifyQuestionResult"
		}
	},
	[179] = {
		{
			"PM_PuzzleJigsawGetInfoReq",
			"PM_PuzzleJigsawGetInfoRes",
			block = true
		},
		{
			"PM_PuzzleJigsawStartGameReq",
			"PM_PuzzleJigsawStartGameRes",
			block = true
		},
		{
			"PM_PuzzleJigsawEndGameReq",
			"PM_PuzzleJigsawEndGameRes",
			block = true
		},
		{
			"PM_PuzzleJigsawGainPrizeReq",
			"PM_PuzzleJigsawGainPrizeRes",
			block = true
		},
		{
			"PM_PuzzleJigsawGainFinalPrizeReq",
			"PM_PuzzleJigsawGainFinalPrizeRes",
			block = true
		},
		[255] = "PuzzleJigsawExtension"
	},
	[180] = {
		{
			"PM_DarkDragonInfoReq",
			"PM_DarkDragonInfoRes",
			block = true
		},
		{
			"PM_DarkDragonStageInfoReq",
			"PM_DarkDragonStageInfoRes",
			block = true
		},
		{
			"PM_DarkDragonChallengeReq",
			"PM_DarkDragonChallengeRes",
			block = true
		},
		{
			"PM_DarkDragonRankInfoReq",
			"PM_DarkDragonRankInfoRes",
			block = true
		},
		[255] = "DarkDragonExtension",
		[10] = {
			"PM_NotifyChallengeEndRes"
		}
	},
	[181] = {
		{
			"PM_SelfSelectInfoReq",
			"PM_SelfSelectInfoRes",
			block = true
		},
		{
			"PM_SelfSelectGainDailyPrizeReq",
			"PM_SelfSelectGainDailyPrizeRes",
			block = true
		},
		[255] = "SelfSelectExtension",
		[100] = {
			"PM_NotifySelfSelectBuySucRes"
		}
	},
	[182] = {
		{
			"PM_DarkDragonKnifeGetInfoReq",
			"PM_DarkDragonKnifeGetInfoRes",
			block = true
		},
		{
			"PM_DarkDragonKnifeGainPrizeReq",
			"PM_DarkDragonKnifeGainPrizeRes",
			block = true
		},
		{
			"PM_DarkDragonKnifeStartGameReq",
			"PM_DarkDragonKnifeStartGameRes",
			block = true
		},
		{
			"PM_DarkDragonKnifeEndGameReq",
			"PM_DarkDragonKnifeEndGameRes",
			block = true
		},
		{
			"PM_DarkDragonKnifeBuyTimesReq",
			"PM_DarkDragonKnifeBuyTimesRes",
			block = true
		},
		{
			"PM_DarkDragonKnifeExchangeReq",
			"PM_DarkDragonKnifeExchangeRes",
			block = true
		},
		{
			"PM_DarkDragonKnifeChangePropReq",
			"PM_DarkDragonKnifeChangePropRes",
			block = true
		},
		[255] = "DarkDragonKnifeExtension"
	},
	[183] = {
		{
			"PM_IKCGetInfoReq",
			"PM_IKCGetInfoRes",
			block = true
		},
		[255] = "IceKingChallengeExtension",
		[3] = {
			"PM_IKCGetChallengeInfoReq",
			"PM_IKCGetChallengeInfoRes",
			block = true
		},
		[4] = {
			"PM_IKCGainDailyPrizeReq",
			"PM_IKCGainDailyPrizeRes",
			block = true
		},
		[5] = {
			"PM_IKCGainProgressPrizeReq",
			"PM_IKCGainProgressPrizeRes",
			block = true
		},
		[6] = {
			"PM_IKCChallengeStageReq",
			"PM_IKCChallengeStageRes",
			block = true
		},
		[7] = {
			"PM_IKCSweepStageReq",
			"PM_IKCSweepStageRes",
			block = true
		},
		[101] = {
			"PM_IKCChallengeEndRes"
		}
	},
	[184] = {
		{
			"PM_LNCGetMainBoardInfoReq",
			"PM_LNCGetMainBoardInfoRes",
			block = true
		},
		{
			"PM_LNCGetChallengeBoardInfoReq",
			"PM_LNCGetChallengeBoardInfoRes",
			block = true
		},
		{
			"PM_LNCGetChallengeInfoReq",
			"PM_LNCGetChallengeInfoRes",
			block = true
		},
		[255] = "LongNvChallengeExtension",
		[6] = {
			"PM_LNCChallengeStageReq",
			"PM_LNCChallengeStageRes",
			block = true
		},
		[7] = {
			"PM_LNCSweepReq",
			"PM_LNCSweepRes",
			block = true
		},
		[8] = {
			"PM_LNCBuyChallengeTimesReq",
			"PM_LNCBuyChallengeTimesRes",
			block = true
		},
		[101] = {
			"PM_LNCChallengeEndRes"
		}
	},
	[185] = {
		{
			"PM_WaterDarkTowerGetInfoReq",
			"PM_WaterDarkTowerGetInfoRes",
			block = true
		},
		{
			"PM_WaterDarkTowerFightReq",
			"PM_WaterDarkTowerFightRes",
			block = true
		},
		{
			"PM_WaterDarkTowerBuyTimesReq",
			"PM_WaterDarkTowerBuyTimesRes",
			block = true
		},
		{
			"PM_WaterDarkTowerGetRankInfoReq",
			"PM_WaterDarkTowerGetRankInfoRes",
			block = true
		},
		{
			"PM_WaterDarkTowerSetFormReq",
			"PM_WaterDarkTowerSetFormRes",
			block = true
		},
		{
			"PM_WaterDarkTowerGetFormReq",
			"PM_WaterDarkTowerGetFormRes",
			block = true
		},
		[255] = "WaterDarkTowerExtension",
		[10] = {
			"PM_WaterDarkTowerAfterFightRes"
		}
	},
	[186] = {
		{
			"PM_PayRaceStrengthenInfoReq",
			"PM_PayRaceStrengthenInfoRes",
			block = true
		},
		[255] = "PayRaceStrengthenExtension",
		[101] = {
			"NotifyPayRaceStrengthenSucRes"
		}
	},
	[187] = {
		{
			"PM_ThrowingGameGetInfoReq",
			"PM_ThrowingGameGetInfoRes",
			block = true
		},
		{
			"PM_ThrowingGameStartGameReq",
			"PM_ThrowingGameStartGameRes",
			block = true
		},
		{
			"PM_ThrowingGameEndGameReq",
			"PM_ThrowingGameEndGameRes",
			block = true
		},
		{
			"PM_ThrowingGameBuyTimesReq",
			"PM_ThrowingGameBuyTimesRes",
			block = true
		},
		[255] = "ThrowingGameExtension"
	},
	[188] = {
		{
			"PM_CynthiaChallengeGetInfoReq",
			"PM_CynthiaChallengeGetInfoRes",
			block = true
		},
		{
			"PM_CynthiaChallengeFightReq",
			"PM_CynthiaChallengeFightRes",
			block = true
		},
		{
			"PM_CynthiaChallengeSweepReq",
			"PM_CynthiaChallengeSweepRes",
			block = true
		},
		{
			"PM_CynthiaChallengeUpgradeReq",
			"PM_CynthiaChallengeUpgradeRes",
			block = true
		},
		[255] = "CynthiaChallengeExtension",
		[10] = {
			"PM_CynthiaChallengeAfterFightRes"
		}
	},
	[189] = {
		[255] = "WishListExtension",
		[2] = {
			"PM_GetWishListInfoReq",
			"PM_GetWishListInfoRes",
			block = true
		},
		[3] = {
			"PM_SendWishReq",
			"PM_SendWishRes",
			block = true
		},
		[4] = {
			"PM_GainWishPrizeReq",
			"PM_GainWishPrizeRes",
			block = true
		}
	},
	[190] = {
		{
			"PM_MoYanPreheatGetInfoReq",
			"PM_MoYanPreheatGetInfoRes",
			block = true
		},
		{
			"PM_MoYanPreheatUnlockReq",
			"PM_MoYanPreheatUnlockRes",
			block = true
		},
		{
			"PM_MoYanPreheatStartGameReq",
			"PM_MoYanPreheatStartGameRes",
			block = true
		},
		{
			"PM_MoYanPreheatEndGameReq",
			"PM_MoYanPreheatEndGameRes",
			block = true
		},
		{
			"PM_MoYanPreheatBuyTimesReq",
			"PM_MoYanPreheatBuyTimesRes",
			block = true
		},
		[255] = "MoYanPreheatExtension"
	},
	[191] = {
		{
			"PM_MirrorChallengeInfoReq",
			"PM_MirrorChallengeInfoRes",
			block = true
		},
		{
			"PM_MirrorChallengeReq",
			"PM_MirrorChallengeRes",
			block = true
		},
		{
			"PM_MirrorChallengeUseBuffReq",
			"PM_MirrorChallengeUseBuffRes",
			block = true
		},
		{
			"PM_MirrorChallengeAllStageScoreReq",
			"PM_MirrorChallengeAllStageScoreRes",
			block = true
		},
		{
			"PM_MirrorChallengeRankReq",
			"PM_MirrorChallengeRankRes",
			block = true
		},
		{
			"PM_MirrorChallengeClearMirrorReq",
			"PM_MirrorChallengeClearMirrorRes",
			block = true
		},
		{
			"PM_MirrorChallengeGainDailyPrizeReq",
			"PM_MirrorChallengeGainDailyPrizeRes",
			block = true
		},
		[255] = "MirrorChallengeExtension",
		[10] = {
			"NotifyMirrorChallengeEndRes"
		}
	},
	[192] = {
		{
			"PM_GoldenDiamondCardGetInfoReq",
			"PM_GoldenDiamondCardGetInfoRes",
			block = true
		},
		{
			"PM_GoldenDiamondCardGainDailyPrizeReq",
			"PM_GoldenDiamondCardGainDailyPrizeRes",
			block = true
		},
		{
			"PM_GoldenDiamondCardInfo",
			block = true
		},
		{
			"PM_NotifyGoldenDiamondPrivilegeChangeRes",
			block = true
		},
		[255] = "GoldenDiamondCardExtension"
	},
	[193] = {
		{
			"PM_PlotReviewGetInfoReq",
			"PM_PlotReviewGetInfoRes",
			block = true
		},
		{
			"PM_PlotReviewGainPrizeReq",
			"PM_PlotReviewGainPrizeRes",
			block = true
		},
		[255] = "PlotReviewExtension"
	},
	[194] = {
		{
			"PM_TMWCGetSummonsInfoReq",
			"PM_TMWCGetSummonsInfoRes",
			block = true
		},
		{
			"PM_TMWCGetChallengeInfoReq",
			"PM_TMWCGetChallengeInfoRes",
			block = true
		},
		{
			"PM_TMWCGetSingleChallengeInfoReq",
			"PM_TMWCGetSingleChallengeInfoRes",
			block = true
		},
		{
			"PM_TMWCSelectSummonReq",
			"PM_TMWCSelectSummonRes",
			block = true
		},
		{
			"PM_TMWCGetFormReq",
			"PM_TMWCGetFormRes",
			block = true
		},
		{
			"PM_TMWCSetFormReq",
			"PM_TMWCSetFormRes",
			block = true
		},
		{
			"PM_TMWCChallengeStageReq",
			"PM_TMWCChallengeStageRes",
			block = true
		},
		{
			"PM_TMWCBuyChallengeTimesReq",
			"PM_TMWCBuyChallengeTimesRes",
			block = true
		},
		{
			"PM_TMWCGainProgressPrizeReq",
			"PM_TMWCGainProgressPrizeRes",
			block = true
		},
		[255] = "TianManWangChallengeExtension",
		[101] = {
			"PM_TMWCChallengeEndRes"
		}
	},
	[195] = {
		{
			"PM_EquipmentPoolDrawReq",
			"PM_EquipmentPoolDrawRes",
			block = true
		},
		{
			"PM_EquipmentPoolInfoReq",
			"PM_EquipmentPoolInfoRes",
			block = true
		},
		[255] = "EquipmentPoolExtension"
	},
	[196] = {
		{
			"PM_PerfectRuleFightGetInfoReq",
			"PM_PerfectRuleFightGetInfoRes",
			block = true
		},
		{
			"PM_PerfectRuleFightGainDailyPrizeReq",
			"PM_PerfectRuleFightGainDailyPrizeRes",
			block = true
		},
		{
			"PM_PerfectRuleFightBuyTimesReq",
			"PM_PerfectRuleFightBuyTimesRes",
			block = true
		},
		{
			"PM_PerfectRuleFightChooseModeReq",
			"PM_PerfectRuleFightChooseModeRes",
			block = true
		},
		{
			"PM_PerfectRuleFightReChooseRuleReq",
			"PM_PerfectRuleFightReChooseRuleRes",
			block = true
		},
		{
			"PM_PerfectRuleFightChallengeReq",
			"PM_PerfectRuleFightChallengeRes",
			block = true
		},
		{
			"PM_PerfectRuleFightConfirmResultReq",
			"PM_PerfectRuleFightConfirmResultRes",
			block = true
		},
		{
			"PM_PerfectRuleFightGiveUpReq",
			"PM_PerfectRuleFightGiveUpRes",
			block = true
		},
		{
			"PM_PerfectRuleFightGainProgressPrizeReq",
			"PM_PerfectRuleFightGainProgressPrizeRes",
			block = true
		},
		[255] = "PerfectRuleFightExtension",
		[101] = {
			"PM_PerfectRuleFightChallengeEndRes"
		}
	},
	[197] = {
		{
			"PM_MakingMoonCakeInfoReq",
			"PM_MakingMoonCakeInfoRes",
			block = true
		},
		{
			"PM_MakingMoonCakeStartGameReq",
			"PM_MakingMoonCakeStartGameRes",
			block = true
		},
		{
			"PM_MakingMoonCakeEndGameReq",
			"PM_MakingMoonCakeEndGameRes",
			block = true
		},
		{
			"PM_MakingMoonCakeBuyTimesReq",
			"PM_MakingMoonCakeBuyTimesRes",
			block = true
		},
		{
			"PM_MakingMoonCakeReceiveCumulativePrizeReq",
			"PM_MakingMoonCakeReceiveCumulativePrizeRes",
			block = true
		},
		{
			"PM_MakingMoonCakeReceiveAllPrizeReq",
			"PM_MakingMoonCakeReceiveAllPrizeRes",
			block = true
		},
		{
			"PM_MakingMoonCakeGainRoleProgressPrizeReq",
			"PM_MakingMoonCakeGainRoleProgressPrizeRes",
			block = true
		},
		[255] = "MakingMoonCakeExtension"
	},
	[198] = {
		{
			"PM_ImageFragmentCollectionInfoReq",
			"PM_ImageFragmentCollectionInfoRes",
			block = true
		},
		{
			"PM_ImageFragmentCollectionActiveFragmentReq",
			"PM_ImageFragmentCollectionActiveFragmentRes",
			block = true
		},
		{
			"PM_ImageFragmentCollectionReceiveImagePrizeReq",
			"PM_ImageFragmentCollectionReceiveImagePrizeRes",
			block = true
		},
		{
			"PM_ImageFragmentCollectionMassReq",
			"PM_ImageFragmentCollectionMassRes",
			block = true
		},
		{
			"PM_ImageFragmentCollectionReceiveMassPrizeReq",
			"PM_ImageFragmentCollectionReceiveMassPrizeRes",
			block = true
		},
		[255] = "ImageFragmentCollectionExtension"
	},
	[199] = {
		{
			"PM_PCGetMainBoardInfoReq",
			"PM_PCGetMainBoardInfoRes",
			block = true
		},
		{
			"PM_PCGetChallengeBoardInfoReq",
			"PM_PCGetChallengeBoardInfoRes",
			block = true
		},
		{
			"PM_PCGetChallengeBossInfoReq",
			"PM_PCGetChallengeBossInfoRes",
			block = true
		},
		{
			"PM_PCChallengeStageReq",
			"PM_PCChallengeStageRes",
			block = true
		},
		{
			"PM_PCSetNewTurnsReq",
			"PM_PCSetNewTurnsRes",
			block = true
		},
		{
			"PM_PCBuyChallengeTimesReq",
			"PM_PCBuyChallengeTimesRes",
			block = true
		},
		{
			"PM_PCGetHellRankInfoReq",
			"PM_PCGetHellRankInfoRes",
			block = true
		},
		[255] = "PupilChallengeExtension",
		[101] = {
			"PM_PCChallengeEndRes"
		}
	},
	[200] = {
		{
			"PM_MYCGetProgressInfoReq",
			"PM_MYCGetProgressInfoRes",
			block = true
		},
		{
			"PM_MYCGetChallengeInfoReq",
			"PM_MYCGetChallengeInfoRes",
			block = true
		},
		{
			"PM_MYCGetSingleChallengeInfoReq",
			"PM_MYCGetSingleChallengeInfoRes",
			block = true
		},
		{
			"PM_MYCGainProgressPrizeReq",
			"PM_MYCGainProgressPrizeRes",
			block = true
		},
		{
			"PM_MYCSweepReq",
			"PM_MYCSweepRes",
			block = true
		},
		{
			"PM_MYCChallengeStageReq",
			"PM_MYCChallengeStageRes",
			block = true
		},
		{
			"PM_MYCResetChallengeReq",
			"PM_MYCResetChallengeRes",
			block = true
		},
		{
			"PM_MYCBuyChallengeTimesReq",
			"PM_MYCBuyChallengeTimesRes",
			block = true
		},
		[255] = "MoYanChallengeExtension",
		[101] = {
			"PM_MYCChallengeEndRes"
		}
	},
	[201] = {
		{
			"PM_RecommendFormGetInfoReq",
			"PM_RecommendFormGetInfoRes",
			block = true
		},
		{
			"PM_RecommendFormUpdateZdlReq",
			"PM_RecommendFormUpdateZdlRes",
			block = true
		},
		{
			"PM_RecommendFormViewRankReq",
			"PM_RecommendFormViewRankRes",
			block = true
		},
		[255] = "RecommendFormExtension"
	},
	[202] = {
		{
			"PM_AceTeamGetInfoReq",
			"PM_AceTeamGetInfoRes",
			block = true
		},
		{
			"PM_AceTeamMatchFightReq",
			"PM_AceTeamMatchFightRes",
			block = true
		},
		{
			"PM_AceTeamCancelMatchReq",
			"PM_AceTeamCancelMatchRes",
			block = true
		},
		{
			"PM_AceTeamFightBossReq",
			"PM_AceTeamFightBossRes",
			block = true
		},
		{
			"PM_AceTeamSetMatchFormReq",
			"PM_AceTeamSetMatchFormRes",
			block = true
		},
		{
			"PM_AceTeamBuyMatchTimesReq",
			"PM_AceTeamBuyMatchTimesRes",
			block = true
		},
		[255] = "AceTeamExtension",
		[10] = {
			"PM_AceTeamViewMedalRankReq",
			"PM_AceTeamViewMedalRankRes",
			block = true
		},
		[11] = {
			"PM_AceTeamViewTeamPowerRankReq",
			"PM_AceTeamViewTeamPowerRankRes",
			block = true
		},
		[20] = {
			"PM_AceTeamChangeTeamReq",
			"PM_AceTeamChangeTeamRes",
			block = true
		},
		[21] = {
			"PM_AceTeamLoadPetsReq",
			"PM_AceTeamLoadPetsRes",
			block = true
		},
		[22] = {
			"PM_AceTeamEquipmentLvReq",
			"PM_AceTeamEquipmentLvRes",
			block = true
		},
		[23] = {
			"PM_AceTeamChangeStarGodPlusReq",
			"PM_AceTeamChangeStarGodPlusRes",
			block = true
		},
		[24] = {
			"PM_AceTeamStarGodPlusLvUpReq",
			"PM_AceTeamStarGodPlusLvUpRes",
			block = true
		},
		[25] = {
			"PM_AceTeamSkillLvUpReq",
			"PM_AceTeamSkillLvUpRes",
			block = true
		},
		[26] = {
			"PM_AceTeamAwakenLvUpReq",
			"PM_AceTeamAwakenLvUpRes",
			block = true
		},
		[27] = {
			"PM_AceTeamBuyPointReq",
			"PM_AceTeamBuyPointRes",
			block = true
		},
		[28] = {
			"PM_AceTeamHolyStripeLevelUpReq",
			"PM_AceTeamHolyStripeLevelUpRes",
			block = true
		},
		[29] = {
			"PM_AceTeamHoyStripeChangeSuitReq",
			"PM_AceTeamHoyStripeChangeSuitRes",
			block = true
		},
		[30] = {
			"PM_AceTeamSourceTraceUnlockEffectReq",
			"PM_AceTeamSourceTraceUnlockEffectRes",
			block = true
		},
		[31] = {
			"PM_AceTeamSourceTraceSelectEffectReq",
			"PM_AceTeamSourceTraceSelectEffectRes",
			block = true
		},
		[100] = {
			"PM_AceTeamNotifyMatchOvertimeRes"
		},
		[101] = {
			"PM_AceTeamNotifyMatchFightFinishRes"
		},
		[102] = {
			"PM_AceTeamNotifyMatchFailRes"
		},
		[105] = {
			"PM_AceTeamNotifyFightBossFinishRes"
		},
		[103] = {
			"PM_NotifyAceTeamPetChangedRes"
		},
		[104] = {
			"PM_NotifyAceTeamPointChangeRes"
		}
	},
	[203] = {
		{
			"PM_NoahChallengeInfoReq",
			"PM_NoahChallengeInfoRes",
			block = true
		},
		{
			"PM_NoahChallengeReq",
			"PM_NoahChallengeRes",
			block = true
		},
		{
			"PM_NoahChallengeResetReq",
			"PM_NoahChallengeResetRes",
			block = true
		},
		{
			"PM_NoahChallengeBaseInfoReq",
			"PM_NoahChallengeBaseInfoRes",
			block = true
		},
		[255] = "NoahChallengeExtension",
		[10] = {
			"PM_NoahChallengeEndRes"
		},
		[11] = {
			"PM_NoahChallengeBuyEndRes"
		}
	},
	[204] = {
		{
			"PM_GetSkinVoteCountsReq",
			"PM_GetSkinVoteCountsRes",
			block = true
		},
		{
			"PM_SkinVoteReq",
			"PM_SkinVoteRes",
			block = true
		},
		{
			"PM_GainYearVersionPrizeReq",
			"PM_GainYearVersionPrizeRes",
			block = true
		},
		[255] = "SkinVoteExtension"
	},
	[205] = {
		{
			"PM_RIGetRegressUserInfoReq",
			"PM_RIGetRegressUserInfoRes",
			block = true
		},
		{
			"PM_RIGetInviteUserInfoReq",
			"PM_RIGetInviteUserInfoRes",
			block = true
		},
		{
			"PM_RIGainTaskPrizeReq",
			"PM_RIGainTaskPrizeRes",
			block = true
		},
		{
			"PM_RIGainInvitePrizeReq",
			"PM_RIGainInvitePrizeRes",
			block = true
		},
		{
			"PM_RIUseCodeReq",
			"PM_RIUseCodeRes",
			block = true
		},
		{
			"PM_RIGetTaskInviteInfoReq",
			"PM_RIGetTaskInviteInfoRes",
			block = true
		},
		{
			"PM_RIAcceptTaskInviteReq",
			"PM_RIAcceptTaskInviteRes",
			block = true
		},
		[255] = "RegressInviteExtension"
	},
	[206] = {
		{
			"PM_TreasureBasinGetInfoReq",
			"PM_TreasureBasinGetInfoRes",
			block = true
		},
		{
			"PM_TreasureBasinMakeMoneyReq",
			"PM_TreasureBasinMakeMoneyRes",
			block = true
		},
		[255] = "TreasureBasinExtension"
	},
	[207] = {
		{
			"PM_KamuiResetInfoReq",
			"PM_KamuiResetInfoRes",
			block = true
		},
		{
			"PM_ActiveKamuiReq",
			"PM_ActiveKamuiRes",
			block = true
		},
		{
			"PM_ResetKamuiReq",
			"PM_ResetKamuiRes",
			block = true
		},
		{
			"PM_ConfirmResetKamuiReq",
			"PM_ConfirmResetKamuiRes",
			block = true
		},
		[255] = "KamuiExtension"
	},
	[209] = {
		{
			"PM_PetGrowthPathGetInfoReq",
			"PM_PetGrowthPathGetInfoRes",
			block = true
		},
		{
			"PM_PetGrowthPathGainPetReq",
			"PM_PetGrowthPathGainPetRes",
			block = true
		},
		{
			"PM_PetGrowthPathGetTaskInfosReq",
			"PM_PetGrowthPathGetTaskInfosRes",
			block = true
		},
		{
			"PM_PetGrowthPathGainTaskPrizeReq",
			"PM_PetGrowthPathGainTaskPrizeRes",
			block = true
		},
		{
			"PM_PetGrowthPathStrengthenReq",
			"PM_PetGrowthPathStrengthenRes",
			block = true
		},
		[255] = "PetGrowthPathExtension"
	},
	[210] = {
		{
			"PM_NianNianBenefitsInfoReq",
			"PM_NianNianBenefitsInfoRes",
			block = true
		},
		{
			"PM_NianNianBenefitsUpgradeReq",
			"PM_NianNianBenefitsUpgradeRes",
			block = true
		},
		{
			"PM_NianNianBenefitsGainDailPrizeReq",
			"PM_NianNianBenefitsGainDailPrizeRes",
			block = true
		},
		{
			"PM_NianNianBenefitsRefineReq",
			"PM_NianNianBenefitsRefineRes",
			block = true
		},
		{
			"PM_NianNianBenefitsAchievementPrizeReq",
			"PM_NianNianBenefitsAchievementPrizeRes",
			block = true
		},
		[255] = "NianNianBenefitsExtension"
	},
	[211] = {
		{
			"PM_SingleRechargeGetInfoReq",
			"PM_SingleRechargeGetInfoRes",
			block = true
		},
		{
			"PM_SingleRechargeGainPrizeReq",
			"PM_SingleRechargeGainPrizeRes",
			block = true
		},
		[255] = "SingleRechargeExtension"
	},
	[212] = {
		{
			"PM_DaysRechargeGetInfoReq",
			"PM_DaysRechargeGetInfoRes",
			block = true
		},
		{
			"PM_DaysRechargeGainPrizeReq",
			"PM_DaysRechargeGainPrizeRes",
			block = true
		},
		[255] = "DaysRechargeExtension"
	},
	[213] = {
		{
			"PM_NianChallengeInfoReq",
			"PM_NianChallengeInfoRes",
			block = true
		},
		{
			"PM_NianChallengeReq",
			"PM_NianChallengeRes",
			block = true
		},
		{
			"PM_NianChallengeBuyTimesReq",
			"PM_NianChallengeBuyTimesRes",
			block = true
		},
		{
			"PM_NianChallengeGetBuffReq",
			"PM_NianChallengeGetBuffRes",
			block = true
		},
		{
			"PM_NianChallengeGainProcessPrizeReq",
			"PM_NianChallengeGainProcessPrizeRes",
			block = true
		},
		[255] = "NianChallengeExtension",
		[10] = {
			"PM_NotifyNianChallengeEndRes"
		}
	},
	[215] = {
		{
			"PM_ICGetMainBoardInfoReq",
			"PM_ICGetMainBoardInfoRes",
			block = true
		},
		{
			"PM_ICGetChallengeBoardInfoReq",
			"PM_ICGetChallengeBoardInfoRes",
			block = true
		},
		{
			"PM_ICChallengeReq",
			"PM_ICChallengeRes",
			block = true
		},
		{
			"PM_ICSetNewRoundsReq",
			"PM_ICSetNewRoundsRes",
			block = true
		},
		{
			"PM_ICIntegrateReq",
			"PM_ICIntegrateRes",
			block = true
		},
		{
			"PM_ICAddBuffLevelReq",
			"PM_ICAddBuffLevelRes",
			block = true
		},
		[255] = "IntegrationChallengeExtension",
		[101] = {
			"PM_ICChallengeEndRes"
		},
		[102] = {
			"PM_ICBuyEndRes"
		}
	},
	[216] = {
		{
			"PM_HalloweenSceneMonsterGetInfoReq",
			"PM_HalloweenSceneMonsterGetInfoRes",
			block = true
		},
		{
			"PM_HalloweenSceneMonsterChallengeReq",
			"PM_HalloweenSceneMonsterChallengeRes",
			block = true
		},
		{
			"PM_HalloweenSceneMonsterGainPrizeReq",
			"PM_HalloweenSceneMonsterGainPrizeRes",
			block = true
		},
		[255] = "HalloweenSceneMonsterExtension",
		[10] = {
			"PM_HalloweenSceneMonsterChallengeEndRes"
		}
	},
	[217] = {
		{
			"PM_HalloweenBossChallengeGetInfoReq",
			"PM_HalloweenBossChallengeGetInfoRes",
			block = true
		},
		{
			"PM_HalloweenBossChallengeReq",
			"PM_HalloweenBossChallengeRes",
			block = true
		},
		{
			"PM_HalloweenBossChallengeGainDailyPrizeReq",
			"PM_HalloweenBossChallengeGainDailyPrizeRes",
			block = true
		},
		{
			"PM_HalloweenBossChallengeGainDamagePrizeReq",
			"PM_HalloweenBossChallengeGainDamagePrizeRes",
			block = true
		},
		{
			"PM_HalloweenBossChallengeRankReq",
			"PM_HalloweenBossChallengeRankRes",
			block = true
		},
		[255] = "HalloweenBossChallengeExtension",
		[10] = {
			"PM_HalloweenBossChallengeEndRes"
		}
	},
	[218] = {
		{
			"PM_TimedChallengeRankingScoreInfoReq",
			"PM_TimedChallengeRankingScoreInfoRes",
			block = true
		},
		{
			"PM_TimedChallengeRankingScoreFightReq",
			"PM_TimedChallengeRankingScoreFightRes",
			block = true
		},
		{
			"PM_TimedChallengeRankingScoreBuffFightReq",
			"PM_TimedChallengeRankingScoreBuffFightRes",
			block = true
		},
		{
			"PM_TimedChallengeRankingScoreBuyBossTimesReq",
			"PM_TimedChallengeRankingScoreBuyBossTimesRes",
			block = true
		},
		{
			"PM_TimedChallengeRankingScoreBuyBuffTimesReq",
			"PM_TimedChallengeRankingScoreBuyBuffTimesRes",
			block = true
		},
		{
			"PM_TimedChallengeRankingScoreGainPrizeReq",
			"PM_TimedChallengeRankingScoreGainPrizeRes",
			block = true
		},
		{
			"PM_TimedChallengeRankingScoreViewTotalRankReq",
			"PM_TimedChallengeRankingScoreViewTotalRankRes",
			block = true
		},
		{
			"PM_TimedChallengeRankingScoreViewDailyRankReq",
			"PM_TimedChallengeRankingScoreViewDailyRankRes",
			block = true
		},
		[255] = "TimedChallengeRankingScoreExtension",
		[10] = {
			"PM_TimedChallengeRankingScoreNotifyBossFightSucRes"
		},
		[11] = {
			"PM_TimedChallengeRankingScoreNotifyBuffFightSucRes"
		}
	},
	[219] = {
		{
			"PM_GetMonopolySaleGiftInfoReq",
			"PM_GetMonopolySaleGiftInfoRes",
			block = true
		},
		{
			"PM_NotifyBuyMonopolySaleGiftRes"
		},
		[255] = "MonopolySaleExtension"
	},
	[220] = {
		{
			"PM_StarGodPlusExchangeInfoReq",
			"PM_StarGodPlusExchangeInfoRes",
			block = true
		},
		{
			"PM_StarGodPlusExchangeReq",
			"PM_StarGodPlusExchangeRes",
			block = true
		},
		[255] = "StarGodPlusExchangeExtension"
	},
	[221] = {
		{
			"PM_SMTGetActInfoReq",
			"PM_SMTGetActInfoRes",
			block = true
		},
		{
			"PM_SMTChooseSummonMasterReq",
			"PM_SMTChooseSummonMasterRes",
			block = true
		},
		{
			"PM_SMTSweepReq",
			"PM_SMTSweepRes",
			block = true
		},
		[255] = "SummonMasterTowerExtension",
		[5] = {
			"PM_SMTBuyGameTimesReq",
			"PM_SMTBuyGameTimesRes",
			block = true
		},
		[6] = {
			"PM_SMTGainFirstPassPrizeReq",
			"PM_SMTGainFirstPassPrizeRes",
			block = true
		},
		[7] = {
			"PM_SMTGetRankInfoReq",
			"PM_SMTGetRankInfoRes",
			block = true
		},
		[8] = {
			"PM_SMTGetGameInfoReq",
			"PM_SMTGetGameInfoRes",
			block = true
		},
		[9] = {
			"PM_SMTDoGridEventReq",
			"PM_SMTDoGridEventRes",
			block = true
		},
		[101] = {
			"PM_SMTDoGridEventEndRes"
		}
	},
	[222] = {
		{
			"PM_PreheatSaleGetInfoReq",
			"PM_PreheatSaleGetInfoRes",
			block = true
		},
		{
			"PM_PreheatSaleBuyEndRes"
		},
		[255] = "PreheatSaleExtension"
	},
	[223] = {
		{
			"PM_AnthenaBlessGetInfoReq",
			"PM_AnthenaBlessGetInfoRes",
			block = true
		},
		{
			"PM_AnthenaBlessGainPrizeReq",
			"PM_AnthenaBlessGainPrizeRes",
			block = true
		},
		[255] = "AthenaBlessExtension"
	},
	[224] = {
		{
			"PM_WaterLightHeroTowerInfoReq",
			"PM_WaterLightHeroTowerInfoRes",
			block = true
		},
		{
			"PM_WaterLightHeroTowerPowerChallengeReq",
			"PM_WaterLightHeroTowerPowerChallengeRes",
			block = true
		},
		{
			"PM_WaterLightHeroTowerWisdomChallengeReq",
			"PM_WaterLightHeroTowerWisdomChallengeRes",
			block = true
		},
		{
			"PM_WaterLightHeroTowerBuyTimesReq",
			"PM_WaterLightHeroTowerBuyTimesRes",
			block = true
		},
		{
			"PM_WaterLightHeroTowerGainPrizeReq",
			"PM_WaterLightHeroTowerGainPrizeRes",
			block = true
		},
		{
			"PM_WaterLightHeroTowerOnKeyPassWisdomReq",
			"PM_WaterLightHeroTowerOnKeyPassWisdomRes",
			block = true
		},
		{
			"PM_WaterLightHeroTowerGainBuffReq",
			"PM_WaterLightHeroTowerGainBuffRes",
			block = true
		},
		{
			"PM_WaterLightHeroTowerOnKeyPassWisdomStageReq",
			"PM_WaterLightHeroTowerOnKeyPassWisdomStageRes",
			block = true
		},
		[255] = "WaterLightHeroTowerExtension",
		[11] = {
			"PM_NotifyPowerTowerFightEndRes"
		},
		[12] = {
			"PM_NotifyWisdomTowerFightEndRes"
		}
	},
	[225] = {
		{
			"PM_PartyPrizeGetInfoReq",
			"PM_PartyPrizeGetInfoRes",
			block = true
		},
		{
			"PM_PartyPrizeGainPrizeReq",
			"PM_PartyPrizeGainPrizeRes",
			block = true
		},
		{
			"PM_PartyPrizeGainAccumulatePrizeReq",
			"PM_PartyPrizeGainAccumulatePrizeRes",
			block = true
		},
		{
			"PM_PartyPrizeGainDailyPrizeReq",
			"PM_PartyPrizeGainDailyPrizeRes",
			block = true
		},
		[255] = "PartyPrizeExtension"
	},
	[226] = {
		{
			"PM_MakeGiftGetInfoReq",
			"PM_MakeGiftGetInfoRes",
			block = true
		},
		{
			"PM_MakeGiftMakeReq",
			"PM_MakeGiftMakeRes",
			block = true
		},
		{
			"PM_MakeGiftGainPrizeReq",
			"PM_MakeGiftGainPrizeRes",
			block = true
		},
		[255] = "MakeGiftExtension"
	},
	[227] = {
		{
			"PM_DreamYouthGetTaskInfosReq",
			"PM_DreamYouthGetTaskInfosRes",
			block = true
		},
		{
			"PM_DreamYouthGainTaskPrizeReq",
			"PM_DreamYouthGainTaskPrizeRes",
			block = true
		},
		{
			"PM_GetDreamYouthStrengthenInfoReq",
			"PM_GetDreamYouthStrengthenInfoRes",
			block = true
		},
		{
			"PM_DreamYouthStrengthenReq",
			"PM_DreamYouthStrengthenRes",
			block = true
		},
		[255] = "DreamYouthExtension"
	},
	[228] = {
		{
			"PM_CIGetActInfoReq",
			"PM_CIGetActInfoRes",
			block = true
		},
		{
			"PM_CIGetInviteListReq",
			"PM_CIGetInviteListRes",
			block = true
		},
		{
			"PM_CIUseCodeReq",
			"PM_CIUseCodeRes",
			block = true
		},
		{
			"PM_CIGainPrizeReq",
			"PM_CIGainPrizeRes",
			block = true
		},
		{
			"PM_CIGainTypePrizeReq",
			"PM_CIGainTypePrizeRes",
			block = true
		},
		[255] = "CampaignInviteExtension",
		[101] = {
			"PM_CINotifyNewInviteRes"
		}
	},
	[231] = {
		{
			"PM_XiaoNuoSummaryGetInfoReq",
			"PM_XiaoNuoSummaryGetInfoRes",
			block = true
		},
		{
			"PM_XiaoNuoSummaryGainPrizeReq",
			"PM_XiaoNuoSummaryGainPrizeRes",
			block = true
		},
		{
			"PM_XiaoNuoSummaryLikeReq",
			"PM_XiaoNuoSummaryLikeRes",
			block = true
		},
		{
			"PM_XiaoNuoSummaryGainWeekPrizeReq",
			"PM_XiaoNuoSummaryGainWeekPrizeRes",
			block = true
		},
		{
			"PM_XiaoNuoSummaryBuyDaysReq",
			"PM_XiaoNuoSummaryBuyDaysRes",
			block = true
		},
		{
			"PM_XiaoNuoSummaryGainDailyPrizeReq",
			"PM_XiaoNuoSummaryGainDailyPrizeRes",
			block = true
		},
		[255] = "XiaoNuoSummaryExtension",
		[101] = {
			"PM_XiaoNuoBuyEndRes"
		}
	},
	[233] = {
		{
			"PM_MoonShadowKingChallengeGetInfoReq",
			"PM_MoonShadowKingChallengeGetInfoRes",
			block = true
		},
		{
			"PM_MoonShadowKingChallengeGetStageInfoReq",
			"PM_MoonShadowKingChallengeGetStageInfoRes",
			block = true
		},
		{
			"PM_MoonShadowKingChallengeReq",
			"PM_MoonShadowKingChallengeRes",
			block = true
		},
		{
			"PM_MoonShadowKingChallengeGainScorePrizeReq",
			"PM_MoonShadowKingChallengeGainScorePrizeRes",
			block = true
		},
		[255] = "MoonShadowKingChallengeExtension",
		[10] = {
			"PM_MoonShadowKingChallengeEndRes"
		}
	},
	[234] = {
		{
			"PM_GetAnnualFeeInfoReq",
			"PM_GetAnnualFeeInfoRes",
			block = true
		},
		{
			"PM_AnnualFeeStartGameReq",
			"PM_AnnualFeeStartGameRes",
			block = true
		},
		{
			"PM_AnnualFeeEndGameReq",
			"PM_AnnualFeeEndGameRes",
			block = true
		},
		{
			"PM_GainAnnualFeePrizeReq",
			"PM_GainAnnualFeePrizeRes",
			block = true
		},
		{
			"PM_AnnualFeeUnlockReq",
			"PM_AnnualFeeUnlockRes",
			block = true
		},
		[255] = "AnnualFeePreheatExtension"
	},
	[235] = {
		{
			"PM_BigCastChallengeGetInfoReq",
			"PM_BigCastChallengeGetInfoRes",
			block = true
		},
		{
			"PM_BigCastChallengeSetFormReq",
			"PM_BigCastChallengeSetFormRes",
			block = true
		},
		{
			"PM_BigCastChallengeFightReq",
			"PM_BigCastChallengeFightRes",
			block = true
		},
		{
			"PM_BigCastChallengeChooseBuffReq",
			"PM_BigCastChallengeChooseBuffRes",
			block = true
		},
		{
			"PM_BigCastChallengeLotteryReq",
			"PM_BigCastChallengeLotteryRes",
			block = true
		},
		{
			"PM_BigCastChallengeGainWinStreakPrizeReq",
			"PM_BigCastChallengeGainWinStreakPrizeRes",
			block = true
		},
		{
			"PM_BigCastChallengeViewRankReq",
			"PM_BigCastChallengeViewRankRes",
			block = true
		},
		[255] = "BigCastChallengeExtension"
	},
	[236] = {
		{
			"PM_ChristmasGatherGetInfoReq",
			"PM_ChristmasGatherGetInfoRes",
			block = true
		},
		{
			"PM_ChristmasGatherGainMaterialReq",
			"PM_ChristmasGatherGainMaterialRes",
			block = true
		},
		{
			"PM_ChristmasGatherGainProgressPrizeReq",
			"PM_ChristmasGatherGainProgressPrizeRes",
			block = true
		},
		[255] = "ChristmasGatherExtension"
	},
	[237] = {
		{
			"PM_ActivityPayStrengthenInfoReq",
			"PM_ActivityPayStrengthenInfoRes",
			block = true
		},
		{
			"PM_CommonBuyItemReq",
			"PM_CommonBuyItemRes",
			block = true
		},
		{
			"PM_ActivityBuyItemReq",
			"PM_ActivityBuyItemRes",
			block = true
		},
		{
			"PM_CommonStrengthenTimesLimitInfoReq",
			"PM_CommonStrengthenTimesLimitInfoRes",
			block = true
		},
		[255] = "PayStrengthenExtension",
		[101] = {
			"PM_NotifyCommonPayStrengthenSucRes"
		},
		[102] = {
			"PM_NotifyActivityPayStrengthenSucRes"
		}
	},
	[238] = {
		{
			"PM_AnnuitySignInGetInfoReq",
			"PM_AnnuitySignInGetInfoRes",
			block = true
		},
		{
			"PM_AnnuitySignInGainPrizeReq",
			"PM_AnnuitySignInGainPrizeRes",
			block = true
		},
		{
			"PM_AnnuitySignInGainPrizeOnekeyReq",
			"PM_AnnuitySignInGainPrizeOnekeyRes",
			block = true
		},
		{
			"PM_AnnuitySignInCostReq",
			"PM_AnnuitySignInCostRes",
			block = true
		},
		[255] = "AnnuitySignInExtension"
	},
	[239] = {
		{
			"PM_GetAnnualFeeSkinInfoReq",
			"PM_GetAnnualFeeSkinInfoRes",
			block = true
		},
		{
			"PM_AnnualFeeLotteryReq",
			"PM_AnnualFeeLotteryRes",
			block = true
		},
		[255] = "AnnualFeeSkinExtension"
	},
	[240] = {
		{
			"PM_CKUGetBreachFormInfoReq",
			"PM_CKUGetBreachFormInfoRes",
			block = true
		},
		{
			"PM_CKUGetDailyTaskInfoReq",
			"PM_CKUGetDailyTaskInfoRes",
			block = true
		},
		{
			"PM_CKUDoBreachFormTaskReq",
			"PM_CKUDoBreachFormTaskRes",
			block = true
		},
		{
			"PM_CKUDoDailyTaskReq",
			"PM_CKUDoDailyTaskRes",
			block = true
		},
		[255] = "ChuangKongUnionExtension",
		[101] = {
			"PM_CKUBreachFormEndRes"
		},
		[102] = {
			"PM_CKUDailyTaskEndRes"
		}
	},
	[241] = {
		{
			"NewHandWelfareGetInfoReq",
			"NewHandWelfareGetInfoRes",
			block = true
		},
		{
			"NewHandWelfareGainSignInPrizeReq",
			"NewHandWelfareGainSignInPrizeRes",
			block = true
		},
		{
			"NewHandWelfareGainOnlinePrizeReq",
			"NewHandWelfareGainOnlinePrizeRes",
			block = true
		},
		{
			"NewHandWelfareGainZdlPrizeReq",
			"NewHandWelfareGainZdlPrizeRes",
			block = true
		},
		{
			"NewHandWelfareOneKeyGainOnlinePrizeReq",
			"NewHandWelfareOneKeyGainOnlinePrizeRes",
			block = true
		},
		{
			"NewHandWelfareOneKeyGainZdlPrizeReq",
			"NewHandWelfareOneKeyGainZdlPrizeRes",
			block = true
		},
		{
			"PM_NotifyNewHandWelfarePaySucRes"
		},
		{
			"NewHandWelfareGetBoundInfoReq",
			"NewHandWelfareGetBoundInfoRes",
			block = true
		},
		{
			"NewHandWelfareSubmitFormZdlReq",
			"NewHandWelfareSubmitFormZdlRes",
			block = true
		},
		{
			"NewHandWelfareGainBoundPrizeReq",
			"NewHandWelfareGainBoundPrizeRes",
			block = true
		},
		[255] = "NewHandWelfareExtension"
	},
	[242] = {
		{
			"PM_SummaryProgressGetInfoReq",
			"PM_SummaryProgressGetInfoRes",
			block = true
		},
		{
			"PM_SummaryProgressGainPrizeReq",
			"PM_SummaryProgressGainPrizeRes",
			block = true
		},
		[255] = "SummaryProgressExtension"
	},
	[243] = {
		{
			"PM_TrainerCourseNewGetInfoReq",
			"PM_TrainerCourseNewGetInfoRes",
			block = true
		},
		{
			"PM_GainTrainerCourseNewPrizeReq",
			"PM_GainTrainerCourseNewPrizeRes",
			block = true
		},
		{
			"PM_GainTrainerCourseScoreNewPrizeReq",
			"PM_GainTrainerCourseScoreNewPrizeRes",
			block = true
		},
		[255] = "TrainerCourseNewExtension"
	},
	[244] = {
		{
			"PM_AllReturnGetInfoReq",
			"PM_AllReturnGetInfoRes",
			block = true
		},
		{
			"PM_AllReturnBuyReq",
			"PM_AllReturnBuyRes",
			block = true
		},
		[255] = "AllReturnExtension"
	},
	[245] = {
		{
			"PM_DragonTrialGetInfoReq",
			"PM_DragonTrialGetInfoRes",
			block = true
		},
		{
			"PM_DragonTrialSetFirstTrialFormReq",
			"PM_DragonTrialSetFirstTrialFormRes",
			block = true
		},
		{
			"PM_DragonTrialFirstFightReq",
			"PM_DragonTrialFirstFightRes",
			block = true
		},
		{
			"PM_DragonTrialSetDreamTrialFormReq",
			"PM_DragonTrialSetDreamTrialFormRes",
			block = true
		},
		{
			"PM_DragonTrialSecondFightReq",
			"PM_DragonTrialSecondFightRes",
			block = true
		},
		{
			"PM_DragonTrialBuyTimesReq",
			"PM_DragonTrialBuyTimesRes",
			block = true
		},
		{
			"PM_DragonTrialGainDailyTaskPrizeReq",
			"PM_DragonTrialGainDailyTaskPrizeRes",
			block = true
		},
		{
			"PM_DragonTrialGainCultivateTaskPrizeReq",
			"PM_DragonTrialGainCultivateTaskPrizeRes",
			block = true
		},
		{
			"PM_DragonTrialViewRankReq",
			"PM_DragonTrialViewRankRes",
			block = true
		},
		{
			"PM_DragonTrialFirstTrialFightFinishRes",
			block = true
		},
		{
			"PM_DragonTrialSecondTrialFightFinishRes",
			block = true
		},
		{
			"PM_DragonTrialValidatePetStrengthenReq",
			"PM_DragonTrialValidatePetStrengthenRes",
			block = true
		},
		[255] = "DragonTrialExtension"
	},
	[246] = {
		{
			"PM_LightDarkDragonInfoReq",
			"PM_LightDarkDragonInfoRes",
			block = true
		},
		{
			"PM_LightDarkDragonChallengeReq",
			"PM_LightDarkDragonChallengeRes",
			block = true
		},
		{
			"PM_LightDarkDragonGetBuffReq",
			"PM_LightDarkDragonGetBuffRes",
			block = true
		},
		{
			"PM_LightDarkDragonSweepReq",
			"PM_LightDarkDragonSweepRes",
			block = true
		},
		{
			"PM_LightDarkDragonGainDailySignPrizeReq",
			"PM_LightDarkDragonGainDailySignPrizeRes",
			block = true
		},
		[255] = "LightDarkDragonExtension",
		[101] = {
			"PM_NotifyLightDarkDragonChallengeResultRes"
		}
	},
	[247] = {
		{
			"PM_VerificationTaskPrizeGetInfoReq",
			"PM_VerificationTaskPrizeGetInfoRes",
			block = true
		},
		{
			"PM_VerificationTaskPrizeVerifyTaskReq",
			"PM_VerificationTaskPrizeVerifyTaskRes",
			block = true
		},
		{
			"PM_VerificationTaskPrizeGainPrizeReq",
			"PM_VerificationTaskPrizeGainPrizeRes",
			block = true
		},
		[255] = "VerificationTaskPrizeExtension"
	},
	[248] = {
		{
			"PM_GetRedPackInfoReq",
			"PM_GetRedPackInfoRes",
			block = true
		},
		[255] = "SpringRedPackExtension",
		[3] = {
			"PM_GainSpringRedPackReq",
			"PM_GainSpringRedPackRes",
			block = true
		},
		[4] = {
			"PM_GetRedPackLogsReq",
			"PM_GetRedPackLogsRes",
			block = true
		}
	},
	[249] = {
		{
			"PM_GodLotteryGetInfoReq",
			"PM_GodLotteryGetInfoRes",
			block = true
		},
		{
			"PM_GodLotteryDoneReq",
			"PM_GodLotteryDoneRes",
			block = true
		},
		[255] = "GodLotteryExtension"
	},
	[250] = {
		{
			"PM_GGACGetActivityInfoReq",
			"PM_GGACGetActivityInfoRes",
			block = true
		},
		{
			"PM_GGACGainProgressPrizeReq",
			"PM_GGACGainProgressPrizeRes",
			block = true
		},
		[255] = "GodGemAccConsumeExtension",
		[4] = {
			"PM_GGACChangeRecipientInfoReq",
			"PM_GGACChangeRecipientInfoRes",
			block = true
		},
		[5] = {
			"PM_GGACGetRankInfoReq",
			"PM_GGACGetRankInfoRes",
			block = true
		},
		[6] = {
			"PM_GGACGetCostRankInfoReq",
			"PM_GGACGetCostRankInfoRes",
			block = true
		},
		[7] = {
			"PM_GGACOneKeyGainPrizeReq",
			"PM_GGACOneKeyGainPrizeRes",
			block = true
		}
	},
	[251] = {
		{
			"PM_PetAwakenVerificationGetInfoReq",
			"PM_PetAwakenVerificationGetInfoRes",
			block = true
		},
		{
			"PM_PetAwakenVerificationGainPrizeReq",
			"PM_PetAwakenVerificationGainPrizeRes",
			block = true
		},
		[255] = "PetAwakenVerificationExtension"
	},
	[252] = {
		{
			"PM_GodLotteryGetTasksReq",
			"PM_GodLotteryGetTasksRes",
			block = true
		},
		{
			"PM_GodLotteryGainPrizeReq",
			"PM_GodLotteryGainPrizeRes",
			block = true
		},
		[255] = "GodLotteryTaskExtension"
	},
	[253] = {
		{
			"PM_PayTrussGodGemInfoReq",
			"PM_PayTrussGodGemInfoRes",
			block = true
		},
		{
			"PM_PayTrussGodGemBuyReq",
			"PM_PayTrussGodGemBuyRes",
			block = true
		},
		[255] = "PayTrussGodGemExtension"
	},
	[254] = {
		{
			"PM_GoddessGetInfoReq",
			"PM_GoddessGetInfoRes",
			block = true
		},
		{
			"PM_GoddessTouchReq",
			"PM_GoddessTouchRes",
			block = true
		},
		{
			"PM_GoddessSendFlowerReq",
			"PM_GoddessSendFlowerRes",
			block = true
		},
		{
			"PM_GoddessChatReq",
			"PM_GoddessChatRes",
			block = true
		},
		{
			"PM_GoddessViewRankReq",
			"PM_GoddessViewRankRes",
			block = true
		},
		{
			"PM_GoddessGainPrizeReq",
			"PM_GoddessGainPrizeRes",
			block = true
		},
		[255] = "GoddessExtension",
		[11] = {
			"PM_GoddessStartGameReq",
			"PM_GoddessStartGameRes",
			block = true
		},
		[12] = {
			"PM_GoddessEndGameReq",
			"PM_GoddessEndGameRes",
			block = true
		},
		[13] = {
			"PM_GoddessReliveReq",
			"PM_GoddessReliveRes",
			block = true
		}
	},
	[255] = {
		{
			"PM_JEGetTaskInfoReq",
			"PM_JEGetTaskInfoRes",
			block = true
		},
		{
			"PM_JEGainTaskPrizeReq",
			"PM_JEGainTaskPrizeRes",
			block = true
		},
		{
			"PM_JEGetPictureInfoReq",
			"PM_JEGetPictureInfoRes",
			block = true
		},
		{
			"PM_JEActivateJigsawReq",
			"PM_JEActivateJigsawRes",
			block = true
		},
		{
			"PM_JEGainGroupPrizeReq",
			"PM_JEGainGroupPrizeRes",
			block = true
		},
		{
			"PM_JEGainBigPrizeReq",
			"PM_JEGainBigPrizeRes",
			block = true
		},
		{
			"PM_JEGiveGiftReq",
			"PM_JEGiveGiftRes",
			block = true
		},
		[255] = "JigsawExchangeExtension"
	},
	[256] = {
		{
			"PM_InfiniteFutureInfoReq",
			"PM_InfiniteFutureInfoRes",
			block = true
		},
		{
			"PM_InfiniteFutureChallengeReq",
			"PM_InfiniteFutureChallengeRes",
			block = true
		},
		{
			"PM_InfiniteFutureResetReq",
			"PM_InfiniteFutureResetRes",
			block = true
		},
		{
			"PM_InfiniteFutureGetBuffReq",
			"PM_InfiniteFutureGetBuffRes",
			block = true
		},
		{
			"PM_InfiniteFutureSelectBuffReq",
			"PM_InfiniteFutureSelectBuffRes",
			block = true
		},
		[255] = "InfiniteFutureExtension",
		[11] = {
			"PM_NotifyInfiniteFutureChallengeEndRes"
		}
	},
	[257] = {
		{
			"PM_GoddessGloryGetMainInfoReq",
			"PM_GoddessGloryGetMainInfoRes",
			block = true
		},
		{
			"PM_GoddessGloryGetInfoReq",
			"PM_GoddessGloryGetInfoRes",
			block = true
		},
		{
			"PM_GoddessGlorySelectPetReq",
			"PM_GoddessGlorySelectPetRes",
			block = true
		},
		{
			"PM_GoddessGlorySetFormReq",
			"PM_GoddessGlorySetFormRes",
			block = true
		},
		{
			"PM_GoddessGloryGetFormReq",
			"PM_GoddessGloryGetFormRes",
			block = true
		},
		{
			"PM_GoddessGloryDoEventReq",
			"PM_GoddessGloryDoEventRes",
			block = true
		},
		{
			"PM_GoddessGloryResetReq",
			"PM_GoddessGloryResetRes",
			block = true
		},
		{
			"PM_GoddessGloryGetTaskInfoReq",
			"PM_GoddessGloryGetTaskInfoRes",
			block = true
		},
		{
			"PM_GoddessGloryGainPrizeReq",
			"PM_GoddessGloryGainPrizeRes",
			block = true
		},
		{
			"PM_GoddessGloryViewRankReq",
			"PM_GoddessGloryViewRankRes",
			block = true
		},
		{
			"PM_GoddessGloryDoEventOverRes"
		},
		{
			"PM_GoddessGloryGetWeeklyTasksReq",
			"PM_GoddessGloryGetWeeklyTasksRes",
			block = true
		},
		{
			"PM_GoddessGloryGainWeeklyPrizeReq",
			"PM_GoddessGloryGainWeeklyPrizeRes",
			block = true
		},
		[255] = "GoddessGloryExtension"
	},
	[258] = {
		{
			"PM_GoddessCollectorGetInfoReq",
			"PM_GoddessCollectorGetInfoRes",
			block = true
		},
		{
			"PM_GoddessCollectorGainPrizeReq",
			"PM_GoddessCollectorGainPrizeRes",
			block = true
		},
		{
			"PM_GoddessCollectorVerifyPetsReq",
			"PM_GoddessCollectorVerifyPetsRes",
			block = true
		},
		{
			"PM_GoddessCollectorRankReq",
			"PM_GoddessCollectorRankRes",
			block = true
		},
		[255] = "GoddessCollectorExtension"
	},
	[259] = {
		{
			"PM_GVGetInfoReq",
			"PM_GVGetInfoRes",
			block = true
		},
		{
			"PM_GVBuyVoteItemReq",
			"PM_GVBuyVoteItemRes",
			block = true
		},
		{
			"PM_GVVoteReq",
			"PM_GVVoteRes",
			block = true
		},
		[255] = "GoddessVoteExtension"
	},
	[260] = {
		{
			"PM_FoodNotesGetInfoReq",
			"PM_FoodNotesGetInfoRes",
			block = true
		},
		{
			"PM_FoodNotesCookReq",
			"PM_FoodNotesCookRes",
			block = true
		},
		[255] = "FoodNotesExtension",
		[4] = {
			"PM_FoodNotesGainPrizeReq",
			"PM_FoodNotesGainPrizeRes",
			block = true
		}
	},
	[261] = {
		{
			"PM_XingJiangFormulaInfoReq",
			"PM_XingJiangFormulaInfoRes",
			block = true
		},
		{
			"PM_XingJiangFormulaChallengeReq",
			"PM_XingJiangFormulaChallengeRes",
			block = true
		},
		{
			"PM_XingJiangFormulaResetReq",
			"PM_XingJiangFormulaResetRes",
			block = true
		},
		{
			"PM_XingJiangFormulaSignInReq",
			"PM_XingJiangFormulaSignInRes",
			block = true
		},
		{
			"PM_XingJiangFormulaTaskReq",
			"PM_XingJiangFormulaTaskRes",
			block = true
		},
		[255] = "XingJiangFormulaExtension",
		[101] = {
			"PM_NotifyXingJiangFormulaChallengeEndRes"
		}
	},
	[262] = {
		{
			"PM_XingJiangFutureInfoReq",
			"PM_XingJiangFutureInfoRes",
			block = true
		},
		{
			"PM_XingJiangFutureChallengeReq",
			"PM_XingJiangFutureChallengeRes",
			block = true
		},
		[255] = "XingJiangFutureExtension",
		[101] = {
			"PM_NotifyXingJiangFutureChallengeResultRes"
		}
	},
	[263] = {
		{
			"PM_RRMGetMapInfoReq",
			"PM_RRMGetMapInfoRes",
			block = true
		},
		{
			"PM_RRMGetTaskInfoReq",
			"PM_RRMGetTaskInfoRes",
			block = true
		},
		{
			"PM_RRMUnlockLineReq",
			"PM_RRMUnlockLineRes",
			block = true
		},
		{
			"PM_RRMGainProgressPrizeReq",
			"PM_RRMGainProgressPrizeRes",
			block = true
		},
		{
			"PM_RRMGainImpressPrizeReq",
			"PM_RRMGainImpressPrizeRes",
			block = true
		},
		[255] = "RoleRelationMapExtension"
	},
	[264] = {
		{
			"PM_GoddessWakenGetInfoReq",
			"PM_GoddessWakenGetInfoRes",
			block = true
		},
		{
			"PM_GoddessWakenInjectPowerReq",
			"PM_GoddessWakenInjectPowerRes",
			block = true
		},
		{
			"PM_GoddessWakenGainTaskPrizeReq",
			"PM_GoddessWakenGainTaskPrizeRes",
			block = true
		},
		{
			"PM_GoddessWakenGainProgressPrizeReq",
			"PM_GoddessWakenGainProgressPrizeRes",
			block = true
		},
		[255] = "GoddessWakenExtension"
	},
	[265] = {
		{
			"PM_Recap21GetInfoReq",
			"PM_Recap21GetInfoRes",
			block = true
		},
		{
			"PM_Recap21GainLetterPrizeReq",
			"PM_Recap21GainLetterPrizeRes",
			block = true
		},
		{
			"PM_Recap21GainEditionPrizeReq",
			"PM_Recap21GainEditionPrizeRes",
			block = true
		},
		[255] = "Recap2021Extension"
	},
	[266] = {
		{
			"PM_AnnualCompetitionGainTicketReq",
			"PM_AnnualCompetitionGainTicketRes",
			block = true
		},
		{
			"PM_AnnualCompetitionParticipateReq",
			"PM_AnnualCompetitionParticipateRes",
			block = true
		},
		{
			"PM_AnnualCompetitionGetInfoReq",
			"PM_AnnualCompetitionGetInfoRes",
			block = true
		},
		{
			"PM_AnnualCompetitionSetSysPetReq",
			"PM_AnnualCompetitionSetSysPetRes",
			block = true
		},
		{
			"PM_AnnualCompetitionSetFormReq",
			"PM_AnnualCompetitionSetFormRes",
			block = true
		},
		{
			"PM_AnnualCompetitionMatchFightReq",
			"PM_AnnualCompetitionMatchFightRes",
			block = true
		},
		{
			"PM_AnnualCompetitionCancelMatchReq",
			"PM_AnnualCompetitionCancelMatchRes",
			block = true
		},
		{
			"PM_AnnualCompetitionSetBuffReq",
			"PM_AnnualCompetitionSetBuffRes",
			block = true
		},
		{
			"PM_AnnualCompetitionGetTaskInfoReq",
			"PM_AnnualCompetitionGetTaskInfoRes",
			block = true
		},
		{
			"PM_AnnualCompetitionGainTaskPrizeReq",
			"PM_AnnualCompetitionGainTaskPrizeRes",
			block = true
		},
		{
			"PM_AnnualCompetitionViewRankReq",
			"PM_AnnualCompetitionViewRankRes",
			block = true
		},
		{
			"PM_AnnualCompetitionGiveUpReq",
			"PM_AnnualCompetitionGiveUpRes",
			block = true
		},
		{
			"PM_AnnualComptitionReplaceCreepsReq",
			"PM_AnnualComptitionReplaceCreepsRes",
			block = true
		},
		[255] = "AnnualCompetitionExtension",
		[15] = {
			"PM_AnnualCompetitionBanPetInfoReq",
			"PM_AnnualCompetitionBanPetInfoRes",
			block = true
		},
		[16] = {
			"PM_AnnualCompetitionBanPetReq",
			"PM_AnnualCompetitionBanPetRes",
			block = true
		},
		[100] = {
			"PM_AnnualCompetitionMatchFightResultRes"
		},
		[101] = {
			"PM_AnnualCompetitionMatchFailRes"
		},
		[102] = {
			"PM_AnnualCompetitionMatchOvertimeRes"
		}
	},
	[267] = {
		{
			"PM_PJGetTaskInfoReq",
			"PM_PJGetTaskInfoRes",
			block = true
		},
		{
			"PM_PJGainTaskPrizeReq",
			"PM_PJGainTaskPrizeRes",
			block = true
		},
		{
			"PM_PJGetPosterInfoReq",
			"PM_PJGetPosterInfoRes",
			block = true
		},
		{
			"PM_PJActivateJigsawReq",
			"PM_PJActivateJigsawRes",
			block = true
		},
		{
			"PM_PJGainBigPrizeReq",
			"PM_PJGainBigPrizeRes",
			block = true
		},
		{
			"PM_PJLotteryReq",
			"PM_PJLotteryRes",
			block = true
		},
		[255] = "PosterJigsawExtension"
	},
	[268] = {
		{
			"PM_MiXiXiChallengeInfoReq",
			"PM_MiXiXiChallengeInfoRes",
			block = true
		},
		{
			"PM_MiXiXiChallengeReq",
			"PM_MiXiXiChallengeRes",
			block = true
		},
		{
			"PM_MiXiXiGainBuffReq",
			"PM_MiXiXiGainBuffRes",
			block = true
		},
		[255] = "MiXiXiChallengeExtension",
		[101] = {
			"PM_NotifyChallengeEndRes"
		}
	},
	[269] = {
		{
			"PM_GetGuessGameInfoReq",
			"PM_GetGuessGameInfoRes",
			block = true
		},
		{
			"PM_GainGuessGamePersonPrizeReq",
			"PM_GainGuessGamePersonPrizeRes",
			block = true
		},
		{
			"PM_GainGuessGameGlobalPrizeReq",
			"PM_GainGuessGameGlobalPrizeRes",
			block = true
		},
		{
			"PM_GuessGameMatchReq",
			"PM_GuessGameMatchRes",
			block = true
		},
		{
			"PM_GuessGameCancelMatchReq",
			"PM_GuessGameCancelMatchRes",
			block = true
		},
		{
			"PM_GuessGameGuessPictureReq",
			"PM_GuessGameGuessPictureRes",
			block = true
		},
		{
			"PM_GuessGameLeaveGameReq",
			"PM_GuessGameLeaveGameRes",
			block = true
		},
		[255] = "GuessGameExtension",
		[101] = {
			"PM_GuessGameAbortRes"
		},
		[102] = {
			"PM_GuessGameGameStartRes"
		},
		[103] = {
			"PM_GuessGameNextProblemRes"
		},
		[104] = {
			"PM_GuessGamePlayerGuessRes"
		},
		[105] = {
			"PM_GuessGameNotifyLeaveGameRes"
		},
		[106] = {
			"PM_GuessGameEndRes"
		},
		[107] = {
			"PM_GuessGameQueueChangeRes"
		}
	},
	[270] = {
		{
			"PM_SendGoddessFlowerGetInfoReq",
			"PM_SendGoddessFlowerGetInfoRes",
			block = true
		},
		{
			"PM_SendGoddessFlowerReq",
			"PM_SendGoddessFlowerRes",
			block = true
		},
		{
			"PM_SendGoddessFlowerGainProgressPrizeReq",
			"PM_SendGoddessFlowerGainProgressPrizeRes",
			block = true
		},
		[255] = "SendGoddessFlowerExtension"
	},
	[271] = {
		{
			"PM_GuessBoxGameGetInfoReq",
			"PM_GuessBoxGameGetInfoRes",
			block = true
		},
		{
			"PM_GuessBoxGameStartGameReq",
			"PM_GuessBoxGameStartGameRes",
			block = true
		},
		[255] = "GuessBoxGameExtension",
		[4] = {
			"PM_GuessBoxGameEndGameReq",
			"PM_GuessBoxGameEndGameRes",
			block = true
		},
		[5] = {
			"PM_GuessBoxGameGainScorePrizeReq",
			"PM_GuessBoxGameGainScorePrizeRes",
			block = true
		},
		[6] = {
			"PM_GuessBoxGameRankInfoReq",
			"PM_GuessBoxGameRankInfoRes",
			block = true
		}
	},
	[272] = {
		{
			"PM_ACGetMakeCakeInfoReq",
			"PM_ACGetMakeCakeInfoRes",
			block = true
		},
		{
			"PM_ACGainMakeCakePersonalPrizeReq",
			"PM_ACGainMakeCakePersonalPrizeRes",
			block = true
		},
		{
			"PM_ACGainMakeCakeWorldPrizeReq",
			"PM_ACGainMakeCakeWorldPrizeRes",
			block = true
		},
		{
			"PM_ACStartMakeCakeReq",
			"PM_ACStartMakeCakeRes",
			block = true
		},
		{
			"PM_ACEndMakeCakeReq",
			"PM_ACEndMakeCakeRes",
			block = true
		},
		{
			"PM_ACGetRankInfoReq",
			"PM_ACGetRankInfoRes",
			block = true
		},
		{
			"PM_ACMakeCakeAddPipeReq",
			"PM_ACMakeCakeAddPipeRes",
			block = true
		},
		[255] = "AnniversaryCakeExtension",
		[11] = {
			"PM_ACGetEatCakeInfoReq",
			"PM_ACGetEatCakeInfoRes",
			block = true
		},
		[12] = {
			"PM_ACGainEatCakePrizeReq",
			"PM_ACGainEatCakePrizeRes",
			block = true
		},
		[13] = {
			"PM_ACStartEatCakeReq",
			"PM_ACStartEatCakeRes",
			block = true
		},
		[14] = {
			"PM_ACEndEatCakeReq",
			"PM_ACEndEatCakeRes",
			block = true
		},
		[15] = {
			"PM_ACGainEatCakeWorldPrizeReq",
			"PM_ACGainEatCakeWorldPrizeRes",
			block = true
		}
	},
	[273] = {
		{
			"PM_AnniversaryPreheatInfoReq",
			"PM_AnniversaryPreheatInfoRes",
			block = true
		},
		{
			"PM_AnniversaryPreheatDanMuReq",
			"PM_AnniversaryPreheatDanMuRes",
			block = true
		},
		{
			"PM_AnniversaryPreheatSendDanmuReq",
			"PM_AnniversaryPreheatSendDanmuRes",
			block = true
		},
		{
			"PM_AnniversaryPreheatSuccessShareReq",
			"PM_AnniversaryPreheatSuccessShareRes",
			block = true
		},
		{
			"PM_AnniversaryPreheatGainSharePrizeReq",
			"PM_AnniversaryPreheatGainSharePrizeRes",
			block = true
		},
		{
			"PM_AnniversaryPreheatGainProgressPrizeReq",
			"PM_AnniversaryPreheatGainProgressPrizeRes",
			block = true
		},
		{
			"PM_AnniversaryPreheatDanmuSwitchReq",
			"PM_AnniversaryPreheatDanmuSwitchRes",
			block = true
		},
		[255] = "AnniversaryPreheatExtension"
	},
	[274] = {
		{
			"PM_EventTaskSummaryGetInfoReq",
			"PM_EventTaskSummaryGetInfoRes",
			block = true
		},
		{
			"PM_EventTaskSummaryGainTaskPrizeReq",
			"PM_EventTaskSummaryGainTaskPrizeRes",
			block = true
		},
		{
			"PM_EventTaskSummaryViewReq",
			"PM_EventTaskSummaryViewRes",
			block = true
		},
		[255] = "EventTaskSummaryExtension"
	},
	[275] = {
		{
			"PM_AssembleOrderInfoReq",
			"PM_AssembleOrderInfoRes",
			block = true
		},
		{
			"PM_AssembleOrderGainInvitePrizeReq",
			"PM_AssembleOrderGainInvitePrizeRes",
			block = true
		},
		{
			"PM_AssembleOrderGainRegressionPrizeReq",
			"PM_AssembleOrderGainRegressionPrizeRes",
			block = true
		},
		[255] = "AssembleOrderExtension"
	},
	[276] = {
		{
			"PM_JiActivityInfoReq",
			"PM_JiActivityInfoRes",
			block = true
		},
		{
			"PM_GainJiActivityActivePrizeReq",
			"PM_GainJiActivityActivePrizeRes",
			block = true
		},
		{
			"PM_GainJiActivityPlotPrizeReq",
			"PM_GainJiActivityPlotPrizeRes",
			block = true
		},
		[255] = "JiActivityExtension"
	},
	[277] = {
		{
			"PM_FireWorksDisplayGetInfoReq",
			"PM_FireWorksDisplayGetInfoRes",
			block = true
		},
		{
			"PM_FireWorksDisplaySetOffReq",
			"PM_FireWorksDisplaySetOffRes",
			block = true
		},
		{
			"PM_FireWorksDisplayGainNormalPrizeReq",
			"PM_FireWorksDisplayGainNormalPrizeRes",
			block = true
		},
		{
			"PM_FireWorksDisplayGainWorldPrizeReq",
			"PM_FireWorksDisplayGainWorldPrizeRes",
			block = true
		},
		[255] = "FireWorksDisplayExtension"
	},
	[278] = {
		{
			"PM_FirstAnnualWelfareGetInfoReq",
			"PM_FirstAnnualWelfareGetInfoRes",
			block = true
		},
		{
			"PM_FirstAnnualWelfareGainFreeGoldenCardReq",
			"PM_FirstAnnualWelfareGainFreeGoldenCardRes",
			block = true
		},
		{
			"PM_FirstAnnualWelfareExchangeReq",
			"PM_FirstAnnualWelfareExchangeRes",
			block = true
		},
		{
			"PM_FirstAnnualWelfareGainPetSkinReq",
			"PM_FirstAnnualWelfareGainPetSkinRes",
			block = true
		},
		[255] = "FirstAnnualWelfareExtension"
	},
	[279] = {
		{
			"PM_AnniversaryPublicityGetInfoReq",
			"PM_AnniversaryPublicityGetInfoRes",
			block = true
		},
		{
			"PM_AnniversaryPublicityGainPrizeReq",
			"PM_AnniversaryPublicityGainPrizeRes",
			block = true
		},
		[255] = "AnniversaryPublicityExtension"
	},
	[280] = {
		{
			"PM_ForceSlideGetInfoReq",
			"PM_ForceSlideGetInfoRes",
			block = true
		},
		[255] = "ForceSlideExtension"
	},
	[281] = {
		{
			"PM_FamilySummonCommandGetInfoReq",
			"PM_FamilySummonCommandGetInfoRes",
			block = true
		},
		{
			"PM_FamilySummonCommandGainPrizeReq",
			"PM_FamilySummonCommandGainPrizeRes",
			block = true
		},
		{
			"PM_FamilySummonCommandViewFamilyRankReq",
			"PM_FamilySummonCommandViewFamilyRankRes",
			block = true
		},
		{
			"PM_FamilySummonCommandViewMemberRankReq",
			"PM_FamilySummonCommandViewMemberRankRes",
			block = true
		},
		[255] = "FamilySummonCommandExtension"
	},
	[282] = {
		{
			"PM_StorySummaryInfoReq",
			"PM_StorySummaryInfoRes",
			block = true
		},
		{
			"PM_StorySummaryFightOrViewReq",
			"PM_StorySummaryFightOrViewRes",
			block = true
		},
		[255] = "StorySummaryExtension",
		[101] = {
			"PM_NotifyStorySummaryFightEndRes"
		}
	},
	[283] = {
		{
			"PM_MonthCardPackGetInfoReq",
			"PM_MonthCardPackGetInfoRes",
			block = true
		},
		[255] = "MonthCardPackExtension"
	},
	[284] = {
		{
			"PM_FamilyTaskInfoReq",
			"PM_FamilyTaskInfoRes",
			block = true
		},
		{
			"PM_FamilyTaskGainPrizeReq",
			"PM_FamilyTaskGainPrizeRes",
			block = true
		},
		[255] = "FamilyTaskExtension"
	},
	[285] = {
		{
			"PM_FamilyMedalGetMedalListReq",
			"PM_FamilyMedalGetMedalListRes",
			block = true
		},
		{
			"PM_FamilyMedalSetMedalWallReq",
			"PM_FamilyMedalSetMedalWallRes",
			block = true
		},
		{
			"PM_FamilyMedalViewRankReq",
			"PM_FamilyMedalViewRankRes",
			block = true
		},
		{
			"PM_FamilyMedalgetChatMedalsReq",
			"PM_FamilyMedalGetChatMedalsRes",
			block = true
		},
		[255] = "FamilyMedalExtension"
	},
	[286] = {
		{
			"PM_WeakPathfindingInfoReq",
			"PM_WeakPathfindingInfoRes",
			block = true
		},
		{
			"PM_WeakPathFindingStartFindReq",
			"PM_WeakPathFindingStartFindRes",
			block = true
		},
		{
			"PM_WeakPathFindingStartGameReq",
			"PM_WeakPathFindingStartGameRes",
			block = true
		},
		{
			"PM_WeakPathFindingEndGameReq",
			"PM_WeakPathFindingEndGameRes",
			block = true
		},
		{
			"PM_WeakPathFindingGainPrizeReq",
			"PM_WeakPathFindingGainPrizeRes",
			block = true
		},
		[255] = "WeakPathfindingExtension"
	},
	[287] = {
		{
			"PM_HirePetInfoReq",
			"PM_HirePetInfoRes",
			block = true
		},
		[255] = "PetHireExtension",
		[4] = {
			"PM_SetHirePetFormReq",
			"PM_SetHirePetFormRes",
			block = true
		},
		[10] = {
			"PM_NotifyHirePetChangedRes"
		}
	},
	[288] = {
		{
			"PM_MPPGetActInfoReq",
			"PM_MPPGetActInfoRes",
			block = true
		},
		{
			"PM_MPPGetGameInfoReq",
			"PM_MPPGetGameInfoRes",
			block = true
		},
		{
			"PM_MPPSaveLocationReq",
			"PM_MPPSaveLocationRes",
			block = true
		},
		{
			"PM_MPPGainDailyPrizeReq",
			"PM_MPPGainDailyPrizeRes",
			block = true
		},
		{
			"PM_MPPDoGridEventReq",
			"PM_MPPDoGridEventRes",
			block = true
		},
		{
			"PM_MPPGetBuffInfoReq",
			"PM_MPPGetBuffInfoRes",
			block = true
		},
		{
			"PM_MPPUpgradeBuffReq",
			"PM_MPPUpgradeBuffRes",
			block = true
		},
		{
			"PM_MPPGainStagePrizeReq",
			"PM_MPPGainStagePrizeRes",
			block = true
		},
		{
			"PM_ResetBuffReq",
			"PM_ResetBuffRes",
			block = true
		},
		{
			"PM_MPPUnlockStoryReq",
			"PM_MPPUnlockStoryRes",
			block = true
		},
		[255] = "MaintainPowerPillaExtension",
		[101] = {
			"PM_MPPDoGridEventEndRes"
		}
	},
	[289] = {
		{
			"PM_GodLongYanChallengeGetInfoReq",
			"PM_GodLongYanChallengeGetInfoRes",
			block = true
		},
		{
			"PM_GodLongYanChallengeUpgradeBuffReq",
			"PM_GodLongYanChallengeUpgradeBuffRes",
			block = true
		},
		{
			"PM_GodLongYanChallengeFightReq",
			"PM_GodLongYanChallengeFightRes",
			block = true
		},
		{
			"PM_GodLongYanChallengeStartGameReq",
			"PM_GodLongYanChallengeStartGameRes",
			block = true
		},
		{
			"PM_GodLongYanChallengeEndGameReq",
			"PM_GodLongYanChallengeEndGameRes",
			block = true
		},
		{
			"PM_GodLongYanChallengeResetBuffReq",
			"PM_GodLongYanChallengeResetBuffRes",
			block = true
		},
		[255] = "GodLongYanChallengeExtension",
		[101] = {
			"PM_GodLongYanChallengeFinishRes"
		},
		[102] = {
			"PM_GodLongYanChallengeOneKeyPassRes"
		}
	},
	[290] = {
		{
			"PM_CrazyPartnerInfoReq",
			"PM_CrazyPartnerInfoRes",
			block = true
		},
		{
			"PM_CrazyPartnerChallengeReq",
			"PM_CrazyPartnerChallengeRes",
			block = true
		},
		{
			"PM_CrazyPartnerGainPrizeReq",
			"PM_CrazyPartnerGainPrizeRes",
			block = true
		},
		{
			"PM_CrazyPartnerDailyRankReq",
			"PM_CrazyPartnerDailyRankRes",
			block = true
		},
		{
			"PM_CrazyPartnerTotalRankReq",
			"PM_CrazyPartnerTotalRankRes",
			block = true
		},
		[255] = "CrazyPartnerExtension",
		[10] = {
			"PM_CrazyPartnerNotifyChallengeEndRes"
		}
	},
	[291] = {
		{
			"PM_DressSellGetInfoReq",
			"PM_DressSellGetInfoRes",
			block = true
		},
		{
			"PM_DressSellBuyReq",
			"PM_DressSellBuyRes",
			block = true
		},
		{
			"PM_DressSellNotifySucRes"
		},
		[255] = "DressSellExtension"
	},
	[292] = {
		{
			"PM_PowerLandGetInfoReq",
			"PM_PowerLandGetInfoRes",
			block = true
		},
		{
			"PM_PowerLandRefreshReq",
			"PM_PowerLandRefreshRes",
			block = true
		},
		{
			"PM_PowerLandStartChallengeReq",
			"PM_PowerLandStartChallengeRes",
			block = true
		},
		{
			"PM_PowerLandChallengeReq",
			"PM_PowerLandChallengeRes",
			block = true
		},
		{
			"PM_PowerLandRefreshShopReq",
			"PM_PowerLandRefreshShopRes",
			block = true
		},
		{
			"PM_PowerLandSetFormReq",
			"PM_PowerLandSetFormRes",
			block = true
		},
		[255] = "PowerLandExtension",
		[11] = {
			"PM_PowerLandStageOverRes"
		}
	},
	[293] = {
		{
			"PM_ExploreUnderInfoReq",
			"PM_ExploreUnderInfoRes",
			block = true
		},
		{
			"PM_ExploreUnderDiceReq",
			"PM_ExploreUnderDiceRes",
			block = true
		},
		{
			"PM_ExploreUnderDoEventReq",
			"PM_ExploreUnderDoEventRes",
			block = true
		},
		{
			"PM_ExploreUnderDialogueFightReq",
			"PM_ExploreUnderDialogueFightRes",
			block = true
		},
		[255] = "ExploreUnderExtension",
		[100] = {
			"PM_NotifyEventInfoChanged"
		}
	},
	[294] = {
		{
			"PM_GetFirePowerContestInfoReq",
			"PM_GetFirePowerContestInfoRes",
			block = true
		},
		{
			"PM_FPCGetGameRecordReq",
			"PM_FPCGetGameRecordRes",
			block = true
		},
		{
			"PM_FPCGainScorePrizeReq",
			"PM_FPCGainScorePrizeRes",
			block = true
		},
		{
			"PM_FPCBeginMatchReq",
			"PM_FPCBeginMatchRes",
			block = true
		},
		{
			"PM_FPCGameBeginReq",
			"PM_FPCGameBeginRes",
			block = true
		},
		{
			"PM_FPCCancelMatchReq",
			"PM_FPCCancelMatchRes",
			block = true
		},
		{
			"PM_FPCPreLaunchReq",
			"PM_FPCPreLaunchRes"
		},
		{
			"PM_FPCLaunchReq",
			"PM_FPCLaunchRes"
		},
		{
			"PM_FPCAskNextStageReq",
			"PM_FPCAskNextStageRes"
		},
		{
			"PM_FPCLeaveGameReq",
			"PM_FPCLeaveGameRes",
			block = true
		},
		{
			"PM_FPCSweepReq",
			"PM_FPCSweepRes",
			block = true
		},
		[255] = "FirePowerContestExtension",
		[100] = {
			"PM_FPCNotifyMatchSucRes"
		},
		[101] = {
			"PM_FPCNotifyGameStartRes"
		},
		[102] = {
			"PM_FPCNotifyGamePreLaunchRes"
		},
		[103] = {
			"PM_FPCNotifyGameAfterLaunchRes"
		},
		[104] = {
			"PM_FPCNextStageRes"
		},
		[105] = {
			"PM_FPCNotifyGameEndRes"
		},
		[106] = {
			"PM_FPCAbortRes"
		},
		[107] = {
			"PM_FPCNotifyLeaveGameRes"
		}
	},
	[295] = {
		{
			"PM_FamilyBattleGetRegistrationInfoReq",
			"PM_FamilyBattleGetRegistrationInfoRes",
			block = true
		},
		{
			"PM_FamilyBattleRegisteringReq",
			"PM_FamilyBattleRegisteringRes",
			block = true
		},
		{
			"PM_FamilyBattleGetFormationReq",
			"PM_FamilyBattleGetFormationRes",
			block = true
		},
		{
			"PM_FamilyBattleSetFormationReq",
			"PM_FamilyBattleSetFormationRes",
			block = true
		},
		{
			"PM_FamilyBattleGetDivinePillarInfoReq",
			"PM_FamilyBattleGetDivinePillarInfoRes",
			block = true
		},
		{
			"PM_FamilyBattleViewDivinePillarTierFormationInfoReq",
			"PM_FamilyBattleViewDivinePillarTierFormationInfoRes",
			block = true
		},
		{
			"PM_FamilyBattleAdjustReq",
			"PM_FamilyBattleAdjustRes",
			block = true
		},
		{
			"PM_FamilyBattleGetInfoReq",
			"PM_FamilyBattleGetInfoRes",
			block = true
		},
		{
			"PM_FamilyBattleChallengeNestReq",
			"PM_FamilyBattleChallengeNestRes",
			block = true
		},
		{
			"PM_FamilyBattleGetDivinePillarChanglleInfoReq",
			"PM_FamilyBattleGetDivinePillarChanglleInfoRes",
			block = true
		},
		{
			"PM_FamilyBattleChallengeDivinePillarReq",
			"PM_FamilyBattleChallengeDivinePillarRes",
			block = true
		},
		{
			"PM_FamilyBattleSetFlagReq",
			"PM_FamilyBattleSetFlagRes",
			block = true
		},
		{
			"PM_FamilyBattleGetReportInfoReq",
			"PM_FamilyBattleGetReportInfoRes",
			block = true
		},
		{
			"PM_FamilyBattleViewRankReq",
			"PM_FamilyBattleViewRankRes",
			block = true
		},
		{
			"PM_FamilyBattleViewUserRankReq",
			"PM_FamilyBattleViewUserRankRes",
			block = true
		},
		{
			"PM_FamilyBattleGetNestInfoReq",
			"PM_FamilyBattleGetNestInfoRes",
			block = true
		},
		[255] = "FamilyBattleExtension",
		[100] = {
			"PM_FamilyBattleChallengeNestResult"
		},
		[101] = {
			"PM_FamilyBattleChallengeDivinePillarResult"
		}
	},
	[296] = {
		{
			"PM_DressDiscountGetInfoReq",
			"PM_DressDiscountGetInfoRes",
			block = true
		},
		{
			"PM_DressDiscountBuyReq",
			"PM_DressDiscountBuyRes",
			block = true
		},
		{
			"PM_DressDiscountNotifySucRes"
		},
		{
			"PM_DressDisscountGainCollectPrizeReq",
			"PM_DressDisscountGainCollectPrizeRes",
			block = true
		},
		[255] = "DressDiscountExtension"
	},
	[297] = {
		{
			"PM_HelpDragonMomGetInfoReq",
			"PM_HelpDragonMomGetInfoRes",
			block = true
		},
		{
			"PM_HelpDragonMomChallengeReq",
			"PM_HelpDragonMomChallengeRes",
			block = true
		},
		{
			"PM_HelpDragonMomSelfAwardReq",
			"PM_HelpDragonMomSelfAwardRes",
			block = true
		},
		{
			"PM_HelpDragonMomWorldAwardReq",
			"PM_HelpDragonMomWorldAwardRes",
			block = true
		},
		[255] = "HelpDragonMomExtension"
	},
	[298] = {
		{
			"PM_SuppressGameGetInfoReq",
			"PM_SuppressGameGetInfoRes",
			block = true
		},
		{
			"PM_SuppressGameStartGameReq",
			"PM_SuppressGameStartGameRes",
			block = true
		},
		{
			"PM_SuppressGameEndGameReq",
			"PM_SuppressGameEndGameRes",
			block = true
		},
		{
			"PM_SuppressGameGetTaskInfoReq",
			"PM_SuppressGameGetTaskInfoRes",
			block = true
		},
		{
			"PM_SuppressGameGainPrizeReq",
			"PM_SuppressGameGainPrizeRes",
			block = true
		},
		[255] = "SuppressGameExtension"
	},
	[299] = {
		{
			"PM_TutorMainInfoReq",
			"PM_TutorMainInfoRes",
			block = true
		},
		{
			"PM_TutorRecommendReq",
			"PM_TutorRecommendRes",
			block = true
		},
		{
			"PM_TutorSearchReq",
			"PM_TutorSearchRes",
			block = true
		},
		{
			"PM_TutorSendRequestReq",
			"PM_TutorSendRequestRes",
			block = true
		},
		{
			"PM_TutorReceivedRequestReq",
			"PM_TutorReceivedRequestRes",
			block = true
		},
		{
			"PM_TutorHandleRequestReq",
			"PM_TutorHandleRequestRes",
			block = true
		},
		{
			"PM_TutorRelieveReq",
			"PM_TutorRelieveRes",
			block = true
		},
		{
			"PM_TutorTeacherTaskInfoReq",
			"PM_TutorTeacherTaskInfoRes",
			block = true
		},
		{
			"PM_TutorTeacherPublishGrowUpTaskReq",
			"PM_TutorTeacherPublishGrowUpTaskRes",
			block = true
		},
		{
			"PM_TutorGainFinishPublishPrizeReq",
			"PM_TutorGainFinishPublishPrizeRes",
			block = true
		},
		{
			"PM_TutorStudentTaskInfoReq",
			"PM_TutorStudentTaskInfoRes",
			block = true
		},
		{
			"PM_TutorStudentGainBaseTaskPrizeReq",
			"PM_TutorStudentGainBaseTaskPrizeRes",
			block = true
		},
		{
			"PM_TutorStudentGainGrowthTaskPrizeReq",
			"PM_TutorStudentGainGrowthTaskPrizeRes",
			block = true
		},
		{
			"PM_TutorStudentGainProgressPrizeReq",
			"PM_TutorStudentGainProgressPrizeRes",
			block = true
		},
		{
			"PM_TutorPuzzleInfoReq",
			"PM_TutorPuzzleInfoRes",
			block = true
		},
		{
			"PM_TutorActivePuzzleReq",
			"PM_TutorActivePuzzleRes",
			block = true
		},
		{
			"PM_TutorGainPuzzlePrizeReq",
			"PM_TutorGainPuzzlePrizeRes",
			block = true
		},
		{
			"PM_TutorTeacherPetHireInfoReq",
			"PM_TutorTeacherPetHireInfoRes",
			block = true
		},
		{
			"PM_TutorTeacherSetHirePetReq",
			"PM_TutorTeacherSetHirePetRes",
			block = true
		},
		{
			"PM_TutorGainTeacherHirePetPrizeReq",
			"PM_TutorGainTeacherHirePetPrizeRes",
			block = true
		},
		{
			"PM_TutorStudentPetHireInfoReq",
			"PM_TutorStudentPetHireInfoRes",
			block = true
		},
		{
			"PM_TutorStudentHirePetReq",
			"PM_TutorStudentHirePetRes",
			block = true
		},
		{
			"PM_TutorTeacherProgressPrizeInfoReq",
			"PM_TutorTeacherProgressPrizeInfoRes",
			block = true
		},
		{
			"PM_TutorGainTeacherProgressPrizeReq",
			"PM_TutorGainTeacherProgressPrizeRes",
			block = true
		},
		{
			"PM_TutorTeacherGainStudentBaseTaskInfoReq",
			"PM_TutorTeacherGainStudentBaseTaskInfoRes",
			block = true
		},
		{
			"PM_TutorTeacherGainStudentGrowthTaskInfoReq",
			"PM_TutorTeacherGainStudentGrowthTaskInfoRes",
			block = true
		},
		{
			"PM_TutorLoadRedPointReq",
			"PM_TutorLoadRedPointRes",
			block = true
		},
		{
			"PM_NotifyTutorRedPointChangedRes"
		},
		{
			"PM_TutorTeacherSwitchAutoPublishGrowUpTaskReq",
			"PM_TutorTeacherSwitchAutoPublishGrowUpTaskRes",
			block = true
		},
		{
			"PM_TutorStudentZdlPrizeInfoReq",
			"PM_TutorStudentZdlPrizeInfoRes",
			block = true
		},
		{
			"PM_TutorStudentGainZdlPrizeReq",
			"PM_TutorStudentGainZdlPrizeRes",
			block = true
		},
		{
			"PM_TutorStudentNewPuzzleInfoReq",
			"PM_TutorStudentNewPuzzleInfoRes",
			block = true
		},
		{
			"PM_TutorStudentNewPuzzleActiveReq",
			"PM_TutorStudentNewPuzzleActiveRes",
			block = true
		},
		{
			"PM_TutorStudentNewPuzzleGainPrizeReq",
			"PM_TutorStudentNewPuzzleGainPrizeRes",
			block = true
		},
		{
			"PM_TutorTeacherMonthlyRankInfoReq",
			"PM_TutorTeacherMonthlyRankInfoRes",
			block = true
		},
		{
			"PM_TutorTeacherRankInfoReq",
			"PM_TutorTeacherRankInfoRes",
			block = true
		},
		[255] = "TutorSystemExtension",
		[102] = {
			"PM_NotifyEstablishTutorRelationRes"
		},
		[103] = {
			"PM_NotifyTutorRelieveRes"
		},
		[104] = {
			"PM_NotifyTutorReceivedTeacherRequestRes"
		},
		[105] = {
			"PM_NotifyTutorReceivedStudentRequestRes"
		},
		[106] = {
			"PM_NotifyTutorStudentFinishTutorRes"
		},
		[107] = {
			"PM_NotifyTutorClassmateEstablishRes"
		},
		[108] = {
			"PM_NotifyTutorClassmateRelieveRes"
		},
		[109] = {
			"PM_NotifyTutorClassmateFinishRes"
		}
	},
	[300] = {
		{
			"PM_FamilySeasonRankViewRankReq",
			"PM_FamilySeasonRankViewRankRes",
			block = true
		},
		{
			"PM_FamilySeasonRankViewNewRankReq",
			"PM_FamilySeasonRankViewNewRankRes",
			block = true
		},
		[255] = "FamilySeasonRankExtension"
	},
	[301] = {
		{
			"PM_GodDiShiTianGetInfoReq",
			"PM_GodDiShiTianGetInfoRes",
			block = true
		},
		{
			"PM_GodDiShiTianChallengeReq",
			"PM_GodDiShiTianChallengeRes",
			block = true
		},
		{
			"PM_GodDiShiTianQuickPassReq",
			"PM_GodDiShiTianQuickPassRes",
			block = true
		},
		[255] = "GodDiShiTianExtension",
		[5] = {
			"PM_GodDiShiTianSetScoreReq",
			"PM_GodDiShiTianSetScoreRes",
			block = true
		},
		[101] = {
			"PM_GodDiShiTianStageOverRes"
		}
	},
	[302] = {
		{
			"PM_TimeServerPetGainGetInfoReq",
			"PM_TimeServerPetGainGetInfoRes"
		},
		{
			"PM_TimeServerPetGainGetProgressPrizeReq",
			"PM_TimeServerPetGainGetProgressPrizeRes",
			block = true
		},
		[255] = "TimeServerPetGainExtension"
	},
	[303] = {
		{
			"PM_VillainPetTrialGetInfoReq",
			"PM_VillainPetTrialGetInfoRes",
			block = true
		},
		{
			"PM_VillainPetTrialGetRankInfoReq",
			"PM_VillainPetTrialGetRankInfoRes",
			block = true
		},
		{
			"PM_VillainPetTrialChallengeReq",
			"PM_VillainPetTrialChallengeRes",
			block = true
		},
		{
			"PM_VillainPetTrialGetSpiritLineInfoReq",
			"PM_VillainPetTrialGetSpiritLineInfoRes",
			block = true
		},
		{
			"PM_VillainPetTrialChangeSpiritLineReq",
			"PM_VillainPetTrialChangeSpiritLineRes",
			block = true
		},
		{
			"PM_VillainPetTrialGainPrizeReq",
			"PM_VillainPetTrialGainPrizeRes",
			block = true
		},
		[255] = "VillainPetTrialExtension"
	},
	[304] = {
		{
			"PM_LingWenGetInfoReq",
			"PM_LingWenGetInfoRes",
			block = true
		},
		{
			"PM_LingWenSetFormReq",
			"PM_LingWenSetFormRes",
			block = true
		},
		{
			"PM_LingWenFightReq",
			"PM_LingWenFightRes",
			block = true
		},
		{
			"PM_LingWenGetFormReq",
			"PM_LingWenGetFormRes",
			block = true
		},
		{
			"PM_LingWenReadyReq",
			"PM_LingWenReadyRes",
			block = true
		},
		{
			"PM_LingWenSweepReq",
			"PM_LingWenSweepRes",
			block = true
		},
		[255] = "LingWenExtension",
		[10] = {
			"PM_LingWenNotifySingleFightFinish"
		},
		[11] = {
			"PM_LingWenNotifyGroupFightFinish"
		},
		[12] = {
			"PM_LingWenNotifyEnd"
		},
		[13] = {
			"PM_LingWenGameStart"
		}
	},
	[305] = {
		{
			"PM_HolyStripeLoadAllReq",
			"PM_HolyStripeLoadAllRes",
			block = true
		},
		{
			"PM_HolyStripeEquipReq",
			"PM_HolyStripeEquipRes",
			block = true
		},
		{
			"PM_HolyStripeUnloadReq",
			"PM_HolyStripeUnloadRes",
			block = true
		},
		{
			"PM_HolyStripeSmeltReq",
			"PM_HolyStripeSmeltRes",
			block = true
		},
		{
			"PM_HolyStripeSetSmeltInfoReq",
			"PM_HolyStripeSetSmeltInfoRes",
			block = true
		},
		{
			"PM_HolyStripeStrengthenReq",
			"PM_HolyStripeStrengthenRes",
			block = true
		},
		{
			"PM_HolyStripeQuenchingReq",
			"PM_HolyStripeQuenchingRes",
			block = true
		},
		{
			"PM_HolyStripeUnloadAllReq",
			"PM_HolyStripeUnloadAllRes",
			block = true
		},
		{
			"PM_HolyStripeLockOperationReq",
			"PM_HolyStripeLockOperationRes",
			block = true
		},
		{
			"PM_HolyStripeReplaceQuenchingDataReq",
			"PM_HolyStripeReplaceQuenchingDataRes",
			block = true
		},
		{
			"PM_SuitGetInfoReq",
			"PM_SuitGetInfoRes",
			block = true
		},
		{
			"PM_ModifySuitGroupReq",
			"PM_ModifySuitGroupRes",
			block = true
		},
		{
			"PM_DeleteSuitGroupReq",
			"PM_DeleteSuitGroupRes",
			block = true
		},
		{
			"PM_ModifySuitReq",
			"PM_ModifySuitRes",
			block = true
		},
		{
			"PM_DeleteSuitReq",
			"PM_DeleteSuitRes",
			block = true
		},
		{
			"PM_HolyStripeWearSuitReq",
			"PM_HolyStripeWearSuitRes",
			block = true
		},
		{
			"PM_SetHolyStripeAutoDecomposeReq",
			"PM_SetHolyStripeAutoDecomposeRes",
			block = true
		},
		{
			"PM_HolyStripeChangeReadyToDiscardReq",
			"PM_HolyStripeChangeReadyToDiscardRes",
			block = true
		},
		[255] = "HolyStripeExtension",
		[100] = {
			"PM_HolyStripeChangeRes"
		},
		[101] = {
			"PM_NotifySuitGroupInfoChangeRes"
		},
		[102] = {
			"PM_NotifySuitInfoChangeRes"
		}
	},
	[306] = {
		{
			"PM_ActorGainGetInfoReq",
			"PM_ActorGainGetInfoRes",
			block = true
		},
		{
			"PM_ActorGainChallengeReq",
			"PM_ActorGainChallengeRes",
			block = true
		},
		{
			"PM_ActorGainGetTaskAwardReq",
			"PM_ActorGainGetTaskAwardRes",
			block = true
		},
		{
			"PM_ActorGainGetProgressAwardReq",
			"PM_ActorGainGetProgressAwardRes",
			block = true
		},
		{
			"PM_ActorGainDamageRankReq",
			"PM_ActorGainDamageRankRes",
			block = true
		},
		[255] = "ActorGainExtension",
		[101] = {
			"PM_ActorGainStageOverRes"
		}
	},
	[307] = {
		{
			"PM_FT_QueryTeamsReq",
			"PM_FT_QueryTeamsRes",
			block = true
		},
		{
			"PM_FT_JoinTeamReq",
			"PM_FT_JoinTeamRes",
			block = true
		},
		{
			"PM_FT_QuickJoinReq",
			"PM_FT_QuickJoinRes",
			block = true
		},
		{
			"PM_FT_CreateTeamReq",
			"PM_FT_CreateTeamRes",
			block = true
		},
		{
			"PM_GetOnlineFamilyMembersReq",
			"PM_GetOnlineFamilyMembersRes",
			block = true
		},
		{
			"PM_FT_LeaveTeamReq",
			"PM_FT_LeaveTeamRes",
			block = true
		},
		{
			"PM_FT_ReadyReq",
			"PM_FT_ReadyRes",
			block = true
		},
		{
			"PM_FT_KickReq",
			"PM_FT_KickRes",
			block = true
		},
		{
			"PM_FT_ChatReq",
			"PM_FT_ChatRes",
			block = true
		},
		[255] = "FormTeamExtension",
		[11] = {
			"PM_FT_InviteReq",
			"PM_FT_InviteRes",
			block = true
		},
		[12] = {
			"PM_FT_LoadTabInfoReq",
			"PM_FT_LoadTabInfoRes",
			block = true
		},
		[13] = {
			"PM_FT_ReformInReq",
			"PM_FT_ReformInRes",
			block = true
		},
		[14] = {
			"PM_FT_QueryBuddiesZdlReq",
			"PM_FT_QueryBuddiesZdlRes",
			block = true
		},
		[100] = {
			"PM_FT_NotifyQueryTeamsRes"
		},
		[101] = {
			"PM_FT_NotifyQuickJoinRes"
		},
		[102] = {
			"PM_FT_NotifyJoinTeamRes"
		},
		[103] = {
			"PM_FT_NotifyCreateTeamRes"
		},
		[104] = {
			"PM_FT_NotifyTeamChangeRes"
		},
		[105] = {
			"PM_FT_NotifyInviteApplyRes"
		},
		[106] = {
			"PM_FT_NotifyReadyRes"
		},
		[107] = {
			"PM_FT_NotifyStartRes"
		},
		[108] = {
			"PM_FT_NotifyBeKickRes"
		},
		[109] = {
			"PM_FT_NotifyChatRes"
		},
		[110] = {
			"PM_FT_NotifyReformInRes"
		}
	},
	[308] = {
		{
			"PM_TutorActivityFormInfoReq",
			"PM_TutorActivityFormInfoRes",
			block = true
		},
		{
			"PM_TutorActivityGainFormPrizeReq",
			"PM_TutorActivityGainFormPrizeRes",
			block = true
		},
		[255] = "TutorActvityExtension"
	},
	[309] = {
		{
			"PM_GetZdlRampageCompetitionReq",
			"PM_GetZdlRampageCompetitionRes",
			block = true
		},
		{
			"PM_ZdlRampageCompetitionGainPrizeReq",
			"PM_ZdlRampageCompetitionGainPrizeRes",
			block = true
		},
		{
			"PM_ZdlRampageCompetitionRankReq",
			"PM_ZdlRampageCompetitionRankRes",
			block = true
		},
		[255] = "ZdlRampageCompetition"
	},
	[310] = {
		{
			"PM_SummerLotteryGetInfoReq",
			"PM_SummerLotteryGetInfoRes",
			block = true
		},
		{
			"PM_SummerLotteryDrawReq",
			"PM_SummerLotteryDrawRes",
			block = true
		},
		{
			"PM_SummerLotteryGetTaskInfoReq",
			"PM_SummerLotteryGetTaskInfoRes",
			block = true
		},
		{
			"PM_SummerLotteryGainTaskPrizeReq",
			"PM_SummerLotteryGainTaskPrizeRes",
			block = true
		},
		{
			"PM_SummerLotteryGainProgressPrizeReq",
			"PM_SummerLotteryGainProgressPrizeRes",
			block = true
		},
		{
			"PM_SummerLotteryViewReq",
			"PM_SummerLotteryViewRes",
			block = true
		},
		[255] = "SummerLotteryExtension"
	},
	[311] = {
		{
			"PM_ActivitySummaryStatisticsGetInfoReq",
			"PM_ActivitySummaryStatisticsGetInfoRes",
			block = true
		},
		[255] = "ActivitySummaryStatisticsExtension"
	},
	[312] = {
		{
			"PM_StarGodChallengeGetInfoReq",
			"PM_StarGodChallengeGetInfoRes",
			block = true
		},
		{
			"PM_StarGodChallengeSingleFightReq",
			"PM_StarGodChallengeSingleFightRes",
			block = true
		},
		{
			"PM_StarGodChallengeSweepReq",
			"PM_StarGodChallengeSweepRes",
			block = true
		},
		{
			"PM_StarGodChallengeGetFormReq",
			"PM_StarGodChallengeGetFormRes",
			block = true
		},
		{
			"PM_StarGodChallengeSetFormReq",
			"PM_StarGodChallengeSetFormRes",
			block = true
		},
		{
			"PM_StarGodChallengeReadyReq",
			"PM_StarGodChallengeReadyRes",
			block = true
		},
		[255] = "StarGodChallengeExtension",
		[100] = {
			"PM_StarGodChallengeSingleFightResultRes"
		},
		[101] = {
			"PM_StarGodChallengeGroupFightResultRes"
		},
		[102] = {
			"PM_StarGodChallengeNotifyEndRes"
		},
		[103] = {
			"PM_StarGodChallengeNotifyGameStartRes"
		}
	},
	[313] = {
		{
			"PM_HuarongRoadGetInfoReq",
			"PM_HuarongRoadGetInfoRes",
			block = true
		},
		{
			"PM_HuarongRoadPassReq",
			"PM_HuarongRoadPassRes",
			block = true
		},
		{
			"PM_HuarongRoadIncreaseSecondReq",
			"PM_HuarongRoadIncreaseSecondRes",
			block = true
		},
		{
			"PM_HuarongRoadBuyQuickPassReq",
			"PM_HuarongRoadBuyQuickPassRes",
			block = true
		},
		[255] = "HuarongRoadExtension"
	},
	[314] = {
		{
			"PM_SaintKnightRuiGetInfoReq",
			"PM_SaintKnightRuiGetInfoRes",
			block = true
		},
		{
			"PM_SaintKnightRuiPlayStageReq",
			"PM_SaintKnightRuiPlayStageRes",
			block = true
		},
		[255] = "SaintKnightRuiExtension",
		[101] = {
			"PM_SaintKnightRuiBattleWinRes"
		}
	},
	[315] = {
		{
			"PM_SaintKnightTianGetInfoReq",
			"PM_SaintKnightTianGetInfoRes",
			block = true
		},
		{
			"PM_SaintKnightTianPlayStageReq",
			"PM_SaintKnightTianPlayStageRes",
			block = true
		},
		{
			"PM_SaintKnightTianGetPrizeReq",
			"PM_SaintKnightTianGetPrizeRes",
			block = true
		},
		{
			"PM_SaintKnightTianGetFormReq",
			"PM_SaintKnightTianGetFormRes",
			block = true
		},
		{
			"PM_SaintKnightTianSetFormReq",
			"PM_SaintKnightTianSetFormRes",
			block = true
		},
		{
			"PM_SaintKnightTianStartGameReq",
			"PM_SaintKnightTianStartGameRes",
			block = true
		},
		{
			"PM_SaintKnightTianEndGameReq",
			"PM_SaintKnightTianEndGameRes",
			block = true
		},
		{
			"PM_SaintKnightTianGetGamePrizeReq",
			"PM_SaintKnightTianGetGamePrizeRes",
			block = true
		},
		[255] = "SaintKnightTianExtension"
	},
	[316] = {
		{
			"PM_CollectionTasksGetInfoReq",
			"PM_CollectionTasksGetInfoRes",
			block = true
		},
		{
			"PM_CollectionTasksGetRankInfoReq",
			"PM_CollectionTasksGetRankInfoRes",
			block = true
		},
		{
			"PM_CollectionTasksGainPrizeReq",
			"PM_CollectionTasksGainPrizeRes",
			block = true
		},
		{
			"PM_SK_GetPersonTaskReq",
			"PM_SK_GetPersonTaskRes",
			block = true
		},
		{
			"PM_SK_GainPersonTaskPrizeReq",
			"PM_SK_GainPersonTaskPrizeRes",
			block = true
		},
		{
			"PM_WorldTasksGetInfoReq",
			"PM_WorldTasksGetInfoRes",
			block = true
		},
		{
			"PM_WorldTasksGainPrizeReq",
			"PM_WorldTasksGainPrizeRes",
			block = true
		},
		{
			"PM_SKVerifyFormZdlReq",
			"PM_SKVerifyFormZdlRes",
			block = true
		},
		{
			"PM_SKGainVerifyPrizeReq",
			"PM_SKGainVerifyPrizeRes",
			block = true
		},
		{
			"PM_SK_GainTeamPrizeReq",
			"PM_SK_GainTeamPrizeRes",
			block = true
		},
		{
			"PM_SK_JoinTeamReq",
			"PM_SK_JoinTeamRes",
			block = true
		},
		[255] = "SaintKnightTasksExtension"
	},
	[317] = {
		{
			"PM_FestiveFlowerInfoReq",
			"PM_FestiveFlowerInfoRes",
			block = true
		},
		{
			"PM_FestiveFlowerFlowerInfoReq",
			"PM_FestiveFlowerFlowerInfoRes",
			block = true
		},
		{
			"PM_FestiveFlowerFlowerGetRankReq",
			"PM_FestiveFlowerFlowerGetRankRes",
			block = true
		},
		{
			"PM_FestiveFlowerBuyFlowerReq",
			"PM_FestiveFlowerBuyFlowerRes",
			block = true
		},
		{
			"PM_FestiveFlowerGainPrizeReq",
			"PM_FestiveFlowerGainPrizeRes",
			block = true
		},
		[255] = "FestiveFlowerExtension",
		[100] = {
			"PM_NotifyGainFreeFlowerRes"
		}
	},
	[318] = {
		{
			"PM_LWExploreGetInfoReq",
			"PM_LWExploreGetInfoRes",
			block = true
		},
		{
			"PM_LWExploreStartGameReq",
			"PM_LWExploreStartGameRes",
			block = true
		},
		{
			"PM_LWExploreEndGameReq",
			"PM_LWExploreEndGameRes",
			block = true
		},
		{
			"PM_LWExploreBuyCountReq",
			"PM_LWExploreBuyCountRes",
			block = true
		},
		{
			"PM_LWExploreOneKeyReq",
			"PM_LWExploreOneKeyRes",
			block = true
		},
		[255] = "LingWenExploreExtension",
		[10] = {
			"PM_LWExploreNotifyExplore"
		}
	},
	[319] = {
		{
			"PM_SaintKnightCardGetInfoReq",
			"PM_SaintKnightCardGetInfoRes",
			block = true
		},
		{
			"PM_SaintKnightCardGetRankInfoReq",
			"PM_SaintKnightCardGetRankInfoRes",
			block = true
		},
		{
			"PM_SaintKnightCardDrawReq",
			"PM_SaintKnightCardDrawRes",
			block = true
		},
		{
			"PM_SaintKnightCardGetRecordReq",
			"PM_SaintKnightCardGetRecordRes",
			block = true
		},
		{
			"PM_SaintKnightCardGainExPrizeReq",
			"PM_SaintKnightCardGainExPrizeRes",
			block = true
		},
		{
			"PM_SaintKnightCardGainBuyReq",
			"PM_SaintKnightCardGainBuyRes",
			block = true
		},
		{
			"PM_SaintKnightCardNotifyRes"
		},
		[255] = "SaintKnightCardExtension"
	},
	[320] = {
		{
			"PM_SaintKnightMoInfoReq",
			"PM_SaintKnightMoInfoRes",
			block = true
		},
		{
			"PM_SaintKnightMoGainPrizeReq",
			"PM_SaintKnightMoGainPrizeRes",
			block = true
		},
		[255] = "SaintKnightMoExtension"
	},
	[321] = {
		{
			"PM_GroupRechargeInfoReq",
			"PM_GroupRechargeInfoRes",
			block = true
		},
		{
			"PM_GroupRechargeRequestListReq",
			"PM_GroupRechargeRequestListRes",
			block = true
		},
		{
			"PM_GroupRechargeInviteBuddyListReq",
			"PM_GroupRechargeInviteBuddyListRes",
			block = true
		},
		{
			"PM_GroupRechargeSendRequestReq",
			"PM_GroupRechargeSendRequestRes",
			block = true
		},
		{
			"PM_GroupRechargeHandlerRequestReq",
			"PM_GroupRechargeHandlerRequestRes",
			block = true
		},
		{
			"PM_GroupRechargePersonalMatchingReq",
			"PM_GroupRechargePersonalMatchingRes",
			block = true
		},
		{
			"PM_GroupRechargeTeamMatchingReq",
			"PM_GroupRechargeTeamMatchingRes",
			block = true
		},
		{
			"PM_GroupRechargeCancelMatchingReq",
			"PM_GroupRechargeCancelMatchingRes",
			block = true
		},
		{
			"PM_GroupRechargeGainPersonalPrizeReq",
			"PM_GroupRechargeGainPersonalPrizeRes",
			block = true
		},
		{
			"PM_GroupRechargeOneKeyGainPersonalPrzieReq",
			"PM_GroupRechargeOneKeyGainPersonalPrzieRes",
			block = true
		},
		{
			"PM_GroupRechargeGainTeamPrizeReq",
			"PM_GroupRechargeGainTeamPrizeRes",
			block = true
		},
		{
			"PM_GroupRechargeOneKeyGainTeamPrizeReq",
			"PM_GroupRechargeOneKeyGainTeamPrizeRes",
			block = true
		},
		{
			"PM_GroupRechargePersonalRankReq",
			"PM_GroupRechargePersonalRankRes",
			block = true
		},
		{
			"PM_GroupRechargeTeamRankReq",
			"PM_GroupRechargeTeamRankRes",
			block = true
		},
		{
			"PM_GroupRechargeFirstTeamInfoReq",
			"PM_GroupRechargeFirstTeamInfoRes",
			block = true
		},
		[255] = "GroupRechargeExtension",
		[101] = {
			"PM_NotifyReceivedRequestRes"
		},
		[102] = {
			"PM_NotifySomeOneJoinTeamRes"
		},
		[103] = {
			"PM_NotifyJoinTeamRes"
		},
		[104] = {
			"PM_NotifyMatchingSuccessRes"
		},
		[105] = {
			"PM_NotifyMatchingFailRes"
		}
	},
	[322] = {
		{
			"PM_AssistanceBoxGetInfoReq",
			"PM_AssistanceBoxGetInfoRes",
			block = true
		},
		{
			"PM_AssistanceBoxInviteReq",
			"PM_AssistanceBoxInviteRes",
			block = true
		},
		{
			"PM_AssistanceBoxGetRecordReq",
			"PM_AssistanceBoxGetRecordRes",
			block = true
		},
		{
			"PM_AssistanceBoxHelpReq",
			"PM_AssistanceBoxHelpRes",
			block = true
		},
		{
			"PM_AssistanceBoxGainPrizeReq",
			"PM_AssistanceBoxGainPrizeRes",
			block = true
		},
		{
			"PM_AssistanceBoxGetOtherInfoReq",
			"PM_AssistanceBoxGetOtherInfoRes",
			block = true
		},
		[255] = "AssistanceBoxExtension",
		[10] = {
			"PM_AssistanceBoxTrigger"
		},
		[11] = {
			"PM_AssistanceBoxInvite"
		},
		[12] = {
			"PM_AssistanceBoxBeHelp"
		}
	},
	[323] = {
		{
			"PM_BasicBenefitsGetInfoReq",
			"PM_BasicBenefitsGetInfoRes",
			block = true
		},
		{
			"PM_BasicBenefitsGainStrengthPrizeReq",
			"PM_BasicBenefitsGainStrengthPrizeRes",
			block = true
		},
		{
			"PM_BasicBenefitsGainPrizeReq",
			"PM_BasicBenefitsGainPrizeRes",
			block = true
		},
		{
			"PM_BasicBenefitsCompensateReq",
			"PM_BasicBenefitsCompensateRes",
			block = true
		},
		[255] = "BasicBenefitsExtension"
	},
	[324] = {
		{
			"PM_PetTitleGetPetTitlesReq",
			"PM_PetTitleGetPetTitlesRes",
			block = true
		},
		{
			"PM_PetTitleChangeReq",
			"PM_PetTitleChangeRes",
			block = true
		},
		{
			"PM_PetTitleGainNotifyRes"
		},
		[255] = "PetTitleExtension"
	},
	[325] = {
		{
			"PM_UpcomingActivityGetInfoReq",
			"PM_UpcomingActivityGetInfoRes",
			block = true
		},
		{
			"PM_UpcomingActivityLikeReq",
			"PM_UpcomingActivityLikeRes",
			block = true
		},
		{
			"PM_UpcomingActivityGainPrizeReq",
			"PM_UpcomingActivityGainPrizeRes",
			block = true
		},
		{
			"PM_UpcomingUnlockInfoReq",
			"PM_UpcomingUnlockInfoRes",
			block = true
		},
		{
			"PM_UpcomingUnlockReq",
			"PM_UpcomingUnlockRes",
			block = true
		},
		{
			"PM_UpcomingGainUnlockPersonPrizeReq",
			"PM_UpcomingGainUnlockPersonPrizeRes",
			block = true
		},
		{
			"PM_UpcomingGainUnlockWorldPrizeReq",
			"PM_UpcomingGainUnlockWorldPrizeRes",
			block = true
		},
		[255] = "UpcomingActivityExtension"
	},
	[326] = {
		{
			"PM_ColorfulLanternGetInfoReq",
			"PM_ColorfulLanternGetInfoRes",
			block = true
		},
		{
			"PM_ColorfulLanternActivateReq",
			"PM_ColorfulLanternActivateRes",
			block = true
		},
		[255] = "ColorfulLanternExtension"
	},
	[327] = {
		{
			"PM_ByteDanceTransferInfoReq",
			"PM_ByteDanceTransferInfoRes",
			block = true
		},
		{
			"PM_ByteDanceTransferCreateTokenReq",
			"PM_ByteDanceTransferCreateTokenRes",
			block = true
		},
		[255] = "ByteDanceTransferExtension",
		[10] = {
			"PM_ByteDanceTransferNotifyInfoRes"
		}
	},
	[328] = {
		{
			"PM_WeeklyBigBoxGetInfoReq",
			"PM_WeeklyBigBoxGetInfoRes",
			block = true
		},
		{
			"PM_WeeklyBigBoxStartGameReq",
			"PM_WeeklyBigBoxStartGameRes",
			block = true
		},
		{
			"PM_WeeklyBigBoxEndGameReq",
			"PM_WeeklyBigBoxEndGameRes",
			block = true
		},
		{
			"PM_WeeklyBigBoxOpenRedPackageReq",
			"PM_WeeklyBigBoxOpenRedPackageRes",
			block = true
		},
		[255] = "WeeklyBigBoxExtension"
	},
	[329] = {
		{
			"PM_GodARuiShiChallengeInfoReq",
			"PM_GodARuiShiChallengeInfoRes",
			block = true
		},
		{
			"PM_GodARuiShiChallengeSkipReq",
			"PM_GodARuiShiChallengeSkipRes",
			block = true
		},
		{
			"PM_GodARuiShiChallengeStageReq",
			"PM_GodARuiShiChallengeStageRes",
			block = true
		},
		{
			"PM_GodARuiShiChallengeBossReq",
			"PM_GodARuiShiChallengeBossRes",
			block = true
		},
		{
			"PM_GodARuiShiChallengeOneKeyPassReq",
			"PM_GodARuiShiChallengeOneKeyPassRes",
			block = true
		},
		[255] = "GodARuiShiChallengeExtension",
		[101] = {
			"PM_NotifyGodARuiShiChallengeStageEndRes"
		},
		[102] = {
			"PM_NotifyGodARuiShiChallengeBossEndRes"
		}
	},
	[330] = {
		{
			"PM_BuddyPetLeaseGetHirePetInfoReq",
			"PM_BuddyPetLeaseGetHirePetInfoRes",
			block = true
		},
		{
			"PM_BuddyPetLeaseGetBuddyPetInfoReq",
			"PM_BuddyPetLeaseGetBuddyPetInfoRes",
			block = true
		},
		{
			"PM_BuddyPetLeaseHireReq",
			"PM_BuddyPetLeaseHireRes",
			block = true
		},
		{
			"PM_BuddyPetLeaseGetRentOutInfoReq",
			"PM_BuddyPetLeaseGetRentOutInfoRes",
			block = true
		},
		{
			"PM_BuddyPetLeaseRentOutReq",
			"PM_BuddyPetLeaseRentOutRes",
			block = true
		},
		{
			"PM_BuddyPetLeaseGainPrizeReq",
			"PM_BuddyPetLeaseGainPrizeRes",
			block = true
		},
		[255] = "BuddyPetLeaseExtension"
	},
	[331] = {
		{
			"PM_QingGuChallengeGetInfoReq",
			"PM_QingGuChallengeGetInfoRes",
			block = true
		},
		{
			"PM_QingGuChallengeReq",
			"PM_QingGuChallengeRes",
			block = true
		},
		{
			"PM_QingGuChallengeResetReq",
			"PM_QingGuChallengeResetRes",
			block = true
		},
		{
			"PM_QingGuChallengeGainPrizeReq",
			"PM_QingGuChallengeGainPrizeRes",
			block = true
		},
		[255] = "QingGuChallengeExtension",
		[10] = {
			"PM_QingGuChallengeResultRes"
		}
	},
	[332] = {
		{
			"PM_CollectingRaceInfoReq",
			"PM_CollectingRaceInfoRes",
			block = true
		},
		{
			"PM_CollectingRaceGainPrizeReq",
			"PM_CollectingRaceGainPrizeRes",
			block = true
		},
		[255] = "CollectingRaceExtension"
	},
	[333] = {
		{
			"PM_CollectClothesInfoReq",
			"PM_CollectClothesInfoRes",
			block = true
		},
		{
			"PM_CollectClothesGainPrizeReq",
			"PM_CollectClothesGainPrizeRes",
			block = true
		},
		[255] = "CollectClothesExtension"
	},
	[334] = {
		{
			"PM_HolidayGiftGetInfoReq",
			"PM_HolidayGiftGetInfoRes",
			block = true
		},
		{
			"PM_HolidayGiftGainPrizeReq",
			"PM_HolidayGiftGainPrizeRes",
			block = true
		},
		[255] = "HolidayGiftExtension"
	},
	[336] = {
		{
			"PM_CB_GetInfoReq",
			"PM_CB_GetInfoRes",
			block = true
		},
		{
			"PM_CB_SelectCampReq",
			"PM_CB_SelectCampRes",
			block = true
		},
		{
			"PM_CB_GetPlayInfoReq",
			"PM_CB_GetPlayInfoRes",
			block = true
		},
		{
			"PM_CB_DonateCoinsReq",
			"PM_CB_DonateCoinsRes",
			block = true
		},
		{
			"PM_CB_StartGameReq",
			"PM_CB_StartGameRes",
			block = true
		},
		{
			"PM_CB_EndGameReq",
			"PM_CB_EndGameRes",
			block = true
		},
		{
			"PM_CB_FindReq",
			"PM_CB_FindRes",
			block = true
		},
		{
			"PM_CB_FightReq",
			"PM_CB_FightRes",
			block = true
		},
		{
			"PM_CB_BuyTimeReq",
			"PM_CB_BuyTimeRes",
			block = true
		},
		{
			"PM_CB_GetRankInfoReq",
			"PM_CB_GetRankInfoRes",
			block = true
		},
		{
			"PM_CB_GainCampPrizeReq",
			"PM_CB_GainCampPrizeRes",
			block = true
		},
		{
			"PM_CB_GetTaskInfoReq",
			"PM_CB_GetTaskInfoRes",
			block = true
		},
		{
			"PM_CB_GainTaskPrizeReq",
			"PM_CB_GainTaskPrizeRes",
			block = true
		},
		{
			"PM_CB_BuyDonateTimesReq",
			"PM_CB_BuyDonateTimesRes",
			block = true
		},
		{
			"PM_CB_ViewReq",
			"PM_CB_ViewRes",
			block = true
		},
		[255] = "CampBattleExtension",
		[101] = {
			"PM_CB_NotifyFightRes"
		}
	},
	[337] = {
		{
			"PM_CantoneseOperaIntroduceGetInfoReq",
			"PM_CantoneseOperaIntroduceGetInfoRes",
			block = true
		},
		{
			"PM_CantoneseOperaIntroduceGainPrizeReq",
			"PM_CantoneseOperaIntroduceGainPrizeRes",
			block = true
		},
		{
			"PM_CantoneseOperaIntroduceGoReq",
			"PM_CantoneseOperaIntroduceGoRes",
			block = true
		},
		[255] = "CantoneseOperaIntroduceExtension"
	},
	[338] = {
		{
			"PM_TQKingDragonGetInfoReq",
			"PM_TQKingDragonGetInfoRes",
			block = true
		},
		{
			"PM_TQKingDragonBossClgReq",
			"PM_TQKingDragonBossClgRes",
			block = true
		},
		{
			"PM_TQKingDragonBossGetPrizeReq",
			"PM_TQKingDragonBossGetPrizeRes",
			block = true
		},
		{
			"PM_TQKingDragonBossBuyReq",
			"PM_TQKingDragonBossBuyRes",
			block = true
		},
		{
			"PM_TQKingDragonResultConfirmReq",
			"PM_TQKingDragonResultConfirmRes",
			block = true
		},
		{
			"PM_TQKingDragonUnitClgReq",
			"PM_TQKingDragonUnitClgRes",
			block = true
		},
		{
			"PM_TQKingDragonUnitResetReq",
			"PM_TQKingDragonUnitResetRes",
			block = true
		},
		{
			"PM_TQKingDragonStageClgReq",
			"PM_TQKingDragonStageClgRes",
			block = true
		},
		{
			"PM_TQKingDragonStageResetReq",
			"PM_TQKingDragonStageResetRes",
			block = true
		},
		{
			"PM_TQKingDragonStageForcePrizeReq",
			"PM_TQKingDragonStageForcePrizeRes",
			block = true
		},
		[255] = "TianQiKingDragonExtension",
		[15] = {
			"PM_TQKingDragonBossRankReq",
			"PM_TQKingDragonBossRankRes",
			block = true
		},
		[16] = {
			"PM_TQKingDragonBossSweepReq",
			"PM_TQKingDragonBossSweepRes",
			block = true
		},
		[17] = {
			"PM_TQKingDragonGetLoginTaskPrizeReq",
			"PM_TQKingDragonGetLoginTaskPrizeRes",
			block = true
		},
		[99] = {
			"PM_TQKingDragonUnitBattleEndRes"
		},
		[98] = {
			"PM_TQKingDragonStageBattleWinRes"
		}
	},
	[339] = {
		{
			"CS_ScuffleInfoReq",
			"CS_ScuffleInfoRes",
			block = true
		},
		{
			"CS_StartMatchingReq",
			"CS_StartMatchingRes",
			block = true
		},
		{
			"CS_CancelMatchingReq",
			"CS_CancelMatchingRes",
			block = true
		},
		{
			"CS_LeaveGameReq",
			"CS_LeaveGameRes",
			block = true
		},
		{
			"CS_BanPetReq",
			"CS_BanPetRes",
			block = true
		},
		{
			"CS_SetFormReq",
			"CS_SetFormRes",
			block = true
		},
		{
			"CS_AchievePrizeInfoReq",
			"CS_AchievePrizeInfoRes",
			block = true
		},
		{
			"CS_GainAchievePrizeReq",
			"CS_GainAchievePrizeRes",
			block = true
		},
		{
			"CS_BuyTimesReq",
			"CS_BuyTimesRes",
			block = true
		},
		[255] = "CampScuffleExtension",
		[11] = {
			"CS_GetBattleRecordReq",
			"CS_GetBattleRecordRes",
			block = true
		},
		[12] = {
			"CS_GetBattleVideoReq",
			"CS_GetBattleVideoRes",
			block = true
		},
		[13] = {
			"CS_GetRankInfoReq",
			"CS_GetRankInfoRes",
			block = true
		},
		[101] = {
			"CS_NotifyMatchingOverTimeRes"
		},
		[102] = {
			"CS_NotifyMatchFailRes"
		},
		[103] = {
			"CS_NotifyGameStartRes"
		},
		[104] = {
			"CS_NotifyOpBanFinishRes"
		},
		[105] = {
			"CS_NotfiyStartSetFormRes"
		},
		[106] = {
			"CS_NotifiyOpReadyFightRes"
		},
		[107] = {
			"CS_NotifyGameEndRes"
		}
	},
	[341] = {
		{
			"PM_CantonOperaRoadGetInfoReq",
			"PM_CantonOperaRoadGetInfoRes",
			block = true
		},
		{
			"PM_CantonOperaRoadAnswerReq",
			"PM_CantonOperaRoadAnswerRes",
			block = true
		},
		[6] = {
			"PM_CantonOperaRoadAnswerInfoReq",
			"PM_CantonOperaRoadAnswerInfoRes",
			block = true
		},
		{
			"PM_CantonOperaRoadJigsawInfoReq",
			"PM_CantonOperaRoadJigsawInfoRes",
			block = true
		},
		{
			"PM_CantonOperaRoadJigsawClgReq",
			"PM_CantonOperaRoadJigsawClgRes",
			block = true
		},
		{
			"PM_CantonOperaRoadLightUpReq",
			"PM_CantonOperaRoadLightUpRes",
			block = true
		},
		[255] = "CantonOperaRoadExtension",
		[11] = {
			"PM_CantonOperaRoadBossInfoReq",
			"PM_CantonOperaRoadBossInfoRes",
			block = true
		},
		[12] = {
			"PM_CantonOperaRoadBossClgReq",
			"PM_CantonOperaRoadBossClgRes",
			block = true
		},
		[13] = {
			"PM_CantonOperaRoadBossFormReq",
			"PM_CantonOperaRoadBossFormRes",
			block = true
		},
		[14] = {
			"PM_CantonOperaRoadBossRankReq",
			"PM_CantonOperaRoadBossRankRes",
			block = true
		},
		[21] = {
			"PM_CantonOperaRoadPvGetPrizeReq",
			"PM_CantonOperaRoadPvGetPrizeRes",
			block = true
		},
		[99] = {
			"PM_CantonOperaRoadAnswerSceneExitRes"
		},
		[98] = {
			"PM_CantonOperaRoadJigsawBattleEndRes"
		},
		[97] = {
			"PM_CantonOperaRoadBossBattleEndRes"
		},
		[96] = {
			"PM_CantonOperaRoadAnswerPrizeNotifyRes"
		}
	},
	[343] = {
		{
			"PM_CashBackInfoReq",
			"PM_CashBackInfoRes",
			block = true
		},
		{
			"PM_CashBackGainPrizeReq",
			"PM_CashBackGainPrizeRes",
			block = true
		},
		[255] = "CashBackExtension"
	},
	[344] = {
		{
			"PM_AresMom_GetInfoReq",
			"PM_AresMom_GetInfoRes",
			block = true
		},
		{
			"PM_AresMom_FightReq",
			"PM_AresMom_FightRes",
			block = true
		},
		{
			"PM_AresMom_GainPrizeReq",
			"PM_AresMom_GainPrizeRes",
			block = true
		},
		{
			"PM_AresMom_UnlockReq",
			"PM_AresMom_UnlockRes",
			block = true
		},
		{
			"PM_AresMom_BuyTimesReq",
			"PM_AresMom_BuyTimesRes",
			block = true
		},
		[255] = "AresMomExtension",
		[101] = {
			"PM_AresMom_NotifyFightRes"
		}
	},
	[345] = {
		{
			"PM_DragonRespectChallengeInfoReq",
			"PM_DragonRespectChallengeInfoRes",
			block = true
		},
		{
			"PM_ExtremeChallengeInfoReq",
			"PM_ExtremeChallengeInfoRes",
			block = true
		},
		{
			"PM_ExtremeChallengeReq",
			"PM_ExtremeChallengeRes",
			block = true
		},
		{
			"PM_ExtremeChallengeRestReq",
			"PM_ExtremeChallengeRestRes",
			block = true
		},
		[11] = {
			"PM_NotifyExtremeChallengeEndRes"
		},
		{
			"PM_UniversalChallengeInfoReq",
			"PM_UniversalChallengeInfoRes",
			block = true
		},
		{
			"PM_GetSingleChallengeInfoReq",
			"PM_GetSingleChallengeInfoRes",
			block = true
		},
		{
			"PM_UniversalChallengeReq",
			"PM_UniversalChallengeRes",
			block = true
		},
		{
			"PM_UniversalChallengeSettlementReq",
			"PM_UniversalChallengeSettlementRes",
			block = true
		},
		[12] = {
			"PM_NotifyUniversalChallengeEndRes"
		},
		{
			"PM_UniversalChallengeFusionReq",
			"PM_UniversalChallengeFusionRes",
			block = true
		},
		[255] = "DragonRespectChallengeExtension"
	},
	[346] = {
		{
			"PM_PartyGetInfoReq",
			"PM_PartyGetInfoRes",
			block = true
		},
		{
			"PM_PartyGainPrizeReq",
			"PM_PartyGainPrizeRes",
			block = true
		},
		[255] = "PartyExtension"
	},
	[347] = {
		{
			"PM_PotluckDinnerInfoReq",
			"PM_PotluckDinnerInfoRes",
			block = true
		},
		{
			"PM_PotluckDinnerGainPrizeReq",
			"PM_PotluckDinnerGainPrizeRes",
			block = true
		},
		[255] = "PotluckDinnerExtension"
	},
	[348] = {
		{
			"XiaoNuoAssistantInfoReq",
			"XiaoNuoAssistantInfoRes",
			block = true
		},
		[255] = "XiaoNuoAssistantExtension"
	},
	[349] = {
		{
			"PM_LiuDaoGetInfoReq",
			"PM_LiuDaoGetInfoRes",
			block = true
		},
		{
			"PM_LiuDaoRefreshStageReq",
			"PM_LiuDaoRefreshStageRes",
			block = true
		},
		{
			"PM_LiuDaoChallengeReq",
			"PM_LiuDaoChallengeRes",
			block = true
		},
		{
			"PM_LiuDaoGetTaskInfoReq",
			"PM_LiuDaoGetTaskInfoRes",
			block = true
		},
		{
			"PM_LiuDaoGainTaskPrizeReq",
			"PM_LiuDaoGainTaskPrizeRes",
			block = true
		},
		{
			"PM_LiuDaoGainProgressPrizeReq",
			"PM_LiuDaoGainProgressPrizeRes",
			block = true
		},
		[255] = "LiuDaoExtension",
		[101] = {
			"PM_LiuDaoNotifyChallengeRes"
		}
	},
	[350] = {
		{
			"PM_PuzzleGameGetInfoReq",
			"PM_PuzzleGameGetInfoRes",
			block = true
		},
		{
			"PM_PuzzleGameStartGameReq",
			"PM_PuzzleGameStartGameRes",
			block = true
		},
		{
			"PM_PuzzleGameEndGameReq",
			"PM_PuzzleGameEndGameRes",
			block = true
		},
		{
			"PM_PuzzleGameGainJigsawPrizeReq",
			"PM_PuzzleGameGainJigsawPrizeRes",
			block = true
		},
		{
			"PM_PuzzleGameGainProgressPrizeReq",
			"PM_PuzzleGameGainProgressPrizeRes",
			block = true
		},
		[255] = "PuzzleGameExtension"
	},
	[351] = {
		{
			"PM_PartyGiftGetInfoReq",
			"PM_PartyGiftGetInfoRes",
			block = true
		},
		[255] = "PartyGiftExtension",
		[10] = {
			"PM_PartyGiftnotifyGiftRes"
		}
	},
	[354] = {
		{
			"PM_QingGuGiftInfoReq",
			"PM_QingGuGiftInfoRes",
			block = true
		},
		{
			"PM_QingGuGiftBuyReq",
			"PM_QingGuGiftBuyRes",
			block = true
		},
		[255] = "QingGuGiftExtension"
	},
	[355] = {
		{
			"PM_BountyPKGetInfoReq",
			"PM_BountyPKGetInfoRes",
			block = true
		},
		{
			"PM_BountyPKMatchReq",
			"PM_BountyPKMatchRes",
			block = true
		},
		{
			"PM_BountyPKCancelMatchReq",
			"PM_BountyPKCancelMatchRes",
			block = true
		},
		{
			"PM_BountyPKSetFormReq",
			"PM_BountyPKSetFormRes",
			block = true
		},
		{
			"PM_BountyPKSetBetReq",
			"PM_BountyPKSetBetRes",
			block = true
		},
		{
			"PM_BountyPKRetreatReq",
			"PM_BountyPKRetreatRes",
			block = true
		},
		[255] = "BountyPKCompeteExtension",
		[11] = {
			"PM_BountyPKDailyPrizeReq",
			"PM_BountyPKDailyPrizeRes",
			block = true
		},
		[12] = {
			"PM_BountyPKDailyTaskPrizeReq",
			"PM_BountyPKDailyTaskPrizeRes",
			block = true
		},
		[13] = {
			"PM_BountyPKGetRecordReq",
			"PM_BountyPKGetRecordRes",
			block = true
		},
		[14] = {
			"PM_BountyPKGetRankInfoReq",
			"PM_BountyPKGetRankInfoRes",
			block = true
		},
		[16] = {
			"PM_BountyPKGetBattleVideoReq",
			"PM_BountyPKGetBattleVideoRes",
			block = true
		},
		[101] = {
			"PM_BountyPKNotifyMatchingOverTimeRes"
		},
		[100] = {
			"PM_BountyPKNotifyMatchFailRes"
		},
		[99] = {
			"PM_BountyPKNotifyGameStartRes"
		},
		[98] = {
			"PM_BountyPKNotifyGameEndRes"
		},
		[97] = {
			"PM_BountyPKNotifyRoundStartRes"
		},
		[96] = {
			"PM_BountyPKNotifyShowFormRes"
		},
		[95] = {
			"PM_BountyPKNotifySetFormRes"
		}
	},
	[356] = {
		{
			"PM_NewSummonPetObtainGetInfoReq",
			"PM_NewSummonPetObtainGetInfoRes",
			block = true
		},
		{
			"PM_NewSummonPetObtainGainPrizeReq",
			"PM_NewSummonPetObtainGainPrizeRes",
			block = true
		},
		{
			"PM_NewSummonPetObtainGetPlayerInfoReq",
			"PM_NewSummonPetObtainGetPlayerInfoRes",
			block = true
		},
		{
			"PM_NewSummonPetObtainGameEndReq",
			"PM_NewSummonPetObtainGameEndRes",
			block = true
		},
		{
			"PM_NewSummonPetObtainGainTaskScoreReq",
			"PM_NewSummonPetObtainGainTaskScoreRes",
			block = true
		},
		{
			"PM_NewSummonPetObtainGetBalanceTierReq",
			"PM_NewSummonPetObtainGetBalanceTierRes",
			block = true
		},
		{
			"PM_NewSummonPetObtainChallengeReq",
			"PM_NewSummonPetObtainChallengeRes",
			block = true
		},
		{
			"PM_NewSummonPetObtainGetBalanceInfoReq",
			"PM_NewSummonPetObtainGetBalanceInfoRes",
			block = true
		},
		[255] = "NewSummonPetObtainExtension",
		[10] = {
			"PM_NewSummonPetObtainChallengeResultRes"
		}
	},
	[357] = {
		{
			"PM_ThreeMatchesGameInfoReq",
			"PM_ThreeMatchesGameInfoRes",
			block = true
		},
		[255] = "ThreeMatchesGameExtension"
	},
	[358] = {
		{
			"PM_XiuNuoBrotherhoodInfoReq",
			"PM_XiuNuoBrotherhoodInfoRes",
			block = true
		},
		{
			"PM_XiuNuoBrotherhoodStartMoveReq",
			"PM_XiuNuoBrotherhoodStartMoveRes",
			block = true
		},
		{
			"PM_XiuNuoBrotherhoodEndMoveReq",
			"PM_XiuNuoBrotherhoodEndMoveRes",
			block = true
		},
		{
			"PM_XiuNuoBrotherhoodFightReq",
			"PM_XiuNuoBrotherhoodFightRes",
			block = true
		},
		{
			"PM_XiuNuoBrotherhoodResetReq",
			"PM_XiuNuoBrotherhoodResetRes",
			block = true
		},
		{
			"PM_XiuNuoBrotherhoodUpgradeBuffReq",
			"PM_XiuNuoBrotherhoodUpgradeBuffRes",
			block = true
		},
		[255] = "XiuNuoBrotherhoodExtension",
		[98] = {
			"PM_XiuNuoBrotherhoodBossBattleEndRes"
		}
	},
	[359] = {
		{
			"PM_SMPVEInitMapReq",
			"PM_SMPVEInitMapRes",
			block = true
		},
		{
			"PM_SMPVELoadMapInfoReq",
			"PM_SMPVELoadMapInfoRes"
		},
		{
			"PM_SMPVESwitchCurTeamReq",
			"PM_SMPVESwitchCurTeamRes",
			block = true
		},
		{
			"PM_SMPVETeamMoveReq",
			"PM_SMPVETeamMoveRes"
		},
		{
			"PM_SMPVEMarkMapPointReq",
			"PM_SMPVEMarkMapPointRes",
			block = true
		},
		[255] = "SeasonModePveExtension",
		[7] = {
			"PM_SMPVENotifyTeamLockRes"
		},
		[8] = {
			"PM_SMPVEPathRouterMoveReq",
			"PM_SMPVEPathRouterMoveRes",
			block = true
		},
		[10] = {
			"PM_SMPVEHandleEventReq",
			"PM_SMPVEHandleEventRes",
			block = true
		},
		[11] = {
			"PM_SMPVEEventInfoReq",
			"PM_SMPVEEventInfoRes",
			block = true
		},
		[15] = {
			"PM_SMPVETeamStrengthInfoReq",
			"PM_SMPVETeamStrengthInfoRes",
			block = true
		},
		[16] = {
			"PM_NotifySMPVEStrengthChangeRes"
		},
		[21] = {
			"PM_SMPVEPushBossPhaseReq",
			"PM_SMPVEPushBossPhaseRes",
			block = true
		},
		[22] = {
			"PM_NotifySMPVEBossPhaseNextStepRes"
		},
		[23] = {
			"PM_SMPVEBossDoppelgangerResetTeamReq",
			"PM_SMPVEBossDoppelgangerResetTeamRes",
			block = true
		},
		[42] = {
			"PM_SMPVEGetRankInfoReq",
			"PM_SMPVEGetRankInfoRes",
			block = true
		},
		[45] = {
			"PM_SMPVESeasonInfoReq",
			"PM_SMPVESeasonInfoRes",
			block = true
		},
		[46] = {
			"PM_SMPVESeasonInitReq",
			"PM_SMPVESeasonInitRes",
			block = true
		},
		[51] = {
			"PM_SMPVEGetMainCampInfoReq",
			"PM_SMPVEGetMainCampInfoRes",
			block = true
		},
		[52] = {
			"PM_SMPVEUpgradeCampLvReq",
			"PM_SMPVEUpgradeCampLvRes",
			block = true
		},
		[53] = {
			"PM_SMPVEGainHangingPrizeReq",
			"PM_SMPVEGainHangingPrizeRes",
			block = true
		},
		[54] = {
			"PM_SMPVEChangePetGuardReq",
			"PM_SMPVEChangePetGuardRes",
			block = true
		},
		[55] = {
			"PM_SMPVETriggerHangingStartTimeReq",
			"PM_SMPVETriggerHangingStartTimeRes",
			block = true
		},
		[57] = {
			"PM_SMPVEUpgradeTeamLvReq",
			"PM_SMPVEUpgradeTeamLvRes",
			block = true
		},
		[59] = {
			"PM_SMPVEGetTotemPoleInfoReq",
			"PM_SMPVEGetTotemPoleInfoRes",
			block = true
		},
		[60] = {
			"PM_SMPVEUpgradeTotemPoleItemReq",
			"PM_SMPVEUpgradeTotemPoleItemRes",
			block = true
		},
		[61] = {
			"PM_SMPVEUpgradeMainTotemPoleReq",
			"PM_SMPVEUpgradeMainTotemPoleRes",
			block = true
		},
		[63] = {
			"PM_SMPVEGetPetPalaceInfoReq",
			"PM_SMPVEGetPetPalaceInfoRes",
			block = true
		},
		[64] = {
			"PM_SMPVEChangeHirePetReq",
			"PM_SMPVEChangeHirePetRes",
			block = true
		},
		[66] = {
			"PM_SMPVEGetBudgeInfoReq",
			"PM_SMPVEGetBudgeInfoRes",
			block = true
		},
		[71] = {
			"PM_SMPVECalPetStrengthInfoReq",
			"PM_SMPVECalPetStrengthInfoRes",
			block = true
		}
	},
	[360] = {
		{
			"PM_BrotherGroupInfoReq",
			"PM_BrotherGroupInfoRes",
			block = true
		},
		{
			"PM_BrotherGroupRequestListReq",
			"PM_BrotherGroupRequestListRes",
			block = true
		},
		{
			"PM_BrotherGroupSendRequestReq",
			"PM_BrotherGroupSendRequestRes",
			block = true
		},
		{
			"PM_BrotherGroupHandlerRequestReq",
			"PM_BrotherGroupHandlerRequestRes",
			block = true
		},
		{
			"PM_BrotherGroupPersonalMatchingReq",
			"PM_BrotherGroupPersonalMatchingRes",
			block = true
		},
		{
			"PM_BrotherGroupTeamMatchingReq",
			"PM_BrotherGroupTeamMatchingRes",
			block = true
		},
		{
			"PM_BrotherGroupCancelMatchingReq",
			"PM_BrotherGroupCancelMatchingRes",
			block = true
		},
		{
			"PM_BrotherGroupGainPersonalPrizeReq",
			"PM_BrotherGroupGainPersonalPrizeRes",
			block = true
		},
		{
			"PM_BrotherGroupGetTaskInfoReq",
			"PM_BrotherGroupGetTaskInfoRes",
			block = true
		},
		{
			"PM_BrotherGroupGainTaskPrizeReq",
			"PM_BrotherGroupGainTaskPrizeRes",
			block = true
		},
		[255] = "BrotherGroupExtension",
		[101] = {
			"PM_BG_NotifyReceivedRequestRes"
		},
		[102] = {
			"PM_BG_NotifyTeamInfoChangeRes"
		},
		[103] = {
			"PM_BG_NotifyMatchingSuccessRes"
		},
		[104] = {
			"PM_BG_NotifyMatchingFailRes"
		}
	},
	[361] = {
		{
			"PM_SecondSaleInfoReq",
			"PM_SecondSaleInfoRes",
			block = true
		},
		{
			"PM_SecondSaleBuyReq",
			"PM_SecondSaleBuyRes",
			block = true
		},
		[255] = "SecondSaleExtension"
	},
	[362] = {
		{
			"PM_GetPuzzleInfoReq",
			"PM_GetPuzzleInfoRes",
			block = true
		},
		{
			"PM_ActivatePuzzleReq",
			"PM_ActivatePuzzleRes",
			block = true
		},
		{
			"PM_GainGroupPrizeReq",
			"PM_GainGroupPrizeRes",
			block = true
		},
		{
			"PM_GainBigPrizeReq",
			"PM_GainBigPrizeRes",
			block = true
		},
		[255] = "PuzzleLightExtension"
	},
	[363] = {
		{
			"PM_FreePayStoreGetInfoReq",
			"PM_FreePayStoreGetInfoRes",
			block = true
		},
		{
			"PM_FreePayStoreBuyReq",
			"PM_FreePayStoreBuyRes",
			block = true
		},
		{
			"PM_FreePayStoreGetRanTextReq",
			"PM_FreePayStoreGetRanTextRes",
			block = true
		},
		[255] = "FreePayStoreExtension"
	},
	[364] = {
		{
			"PM_AnswerProblemUnlockPlotInfoReq",
			"PM_AnswerProblemUnlockPlotInfoRes",
			block = true
		},
		{
			"PM_AnswerProblemUnlockPlotGainPrizeReq",
			"PM_AnswerProblemUnlockPlotGainPrizeRes",
			block = true
		},
		{
			"PM_AnswerProblemUnlockPlotStartAnswerReq",
			"PM_AnswerProblemUnlockPlotStartAnswerRes",
			block = true
		},
		{
			"PM_AnswerProblemUnlockPlotAnswerReq",
			"PM_AnswerProblemUnlockPlotAnswerRes",
			block = true
		},
		{
			"PM_AnswerProblemUnlockPlotAnswerEndReq",
			"PM_AnswerProblemUnlockPlotAnswerEndRes",
			block = true
		},
		{
			"PM_AnswerProblemUnlockPlotResultRes"
		},
		{
			"PM_AnswerProblemSelectTypeReq",
			"PM_AnswerProblemSelectTypeRes",
			block = true
		},
		[255] = "AnswerProblemUnlockPlotExtension"
	},
	[365] = {
		{
			"PM_BrotherHoodPanelInfoReq",
			"PM_BrotherHoodPanelInfoRes",
			block = true
		},
		{
			"PM_BrotherHoodSinglePlotPlanReq",
			"PM_BrotherHoodSinglePlotPlanRes",
			block = true
		},
		{
			"PM_BrotherHoodSplicePlotReq",
			"PM_BrotherHoodSplicePlotRes",
			block = true
		},
		{
			"PM_BrotherHoodRewardProcessReq",
			"PM_BrotherHoodRewardProcessRes",
			block = true
		},
		[255] = "BrotherHoodExtension"
	},
	[366] = {
		{
			"PM_SkinLotteryPanelInfoReq",
			"PM_SkinLotteryPanelInfoRes",
			block = true
		},
		{
			"PM_SkinLotteryRecordsReq",
			"PM_SkinLotteryRecordsRes",
			block = true
		},
		{
			"PM_SkinLotteryReq",
			"PM_SkinLotteryRes",
			block = true
		},
		{
			"PM_SkinLotteryGetProcessRewardReq",
			"PM_SkinLotteryGetProcessRewardRes",
			block = true
		},
		{
			"PM_SkinLotteryRankReq",
			"PM_SkinLotteryRankRes",
			block = true
		},
		{
			"PM_SkinLotteryFreeChargeRankReq",
			"PM_SkinLotteryFreeChargeRankRes",
			block = true
		},
		[255] = "SkinLotteryExtension"
	},
	[367] = {
		{
			"PM_SMPVEWarOrderInfoReq",
			"PM_SMPVEWarOrderInfoRes",
			block = true
		},
		{
			"PM_SMPVEWarOrderBuyLevelReq",
			"PM_SMPVEWarOrderBuyLevelRes",
			block = true
		},
		{
			"PM_SMPVEWarOrderGainPrizeReq",
			"PM_SMPVEWarOrderGainPrizeRes",
			block = true
		},
		{
			"PM_SMPVEWarOrderOneKeyGainPrizeReq",
			"PM_SMPVEWarOrderOneKeyGainPrizeRes",
			block = true
		},
		{
			"PM_SMPVEWarOrderTaskInfoReq",
			"PM_SMPVEWarOrderTaskInfoRes",
			block = true
		},
		{
			"PM_SMPVEWarOrderGainTaskPrizeReq",
			"PM_SMPVEWarOrderGainTaskPrizeRes",
			block = true
		},
		{
			"PM_SMPVEWarOrderLotteryReq",
			"PM_SMPVEWarOrderLotteryRes",
			block = true
		},
		{
			"PM_SMPVENotifyBuyWarOrderRes"
		},
		{
			"PM_SMPVEWarOrderGainFinalPrizeReq",
			"PM_SMPVEWarOrderGainFinalPrizeRes",
			block = true
		},
		{
			"PM_SMPVEWarOrderRecoverReq",
			"PM_SMPVEWarOrderRecoverRes",
			block = true
		},
		[255] = "SeasonModeWarOrderExtension"
	},
	[368] = {
		{
			"PM_PeakTournamentGetQualifierInfoReq",
			"PM_PeakTournamentGetQualifierInfoRes",
			block = true
		},
		{
			"PM_PeakTournamentQualifierFightReq",
			"PM_PeakTournamentQualifierFightRes",
			block = true
		},
		{
			"PM_PeakTournamentQualifierRecordsReq",
			"PM_PeakTournamentQualifierRecordsRes",
			block = true
		},
		{
			"PM_PeakTournamentQualifierRankInfoReq",
			"PM_PeakTournamentQualifierRankInfoRes",
			block = true
		},
		{
			"PM_PeakTournamentQualifierTaskInfoReq",
			"PM_PeakTournamentQualifierTaskInfoRes",
			block = true
		},
		{
			"PM_PeakTournamentGainQualifierTaskPrizeReq",
			"PM_PeakTournamentGainQualifierTaskPrizeRes",
			block = true
		},
		{
			"PM_PeakTournamentQualifierVideoReq",
			"PM_PeakTournamentQualifierVideoRes",
			block = true
		},
		[255] = "PeakTournamentExtension",
		[49] = {
			"PM_PeakTournamentKnockoutGetParticipationInfoReq",
			"PM_PeakTournamentKnockoutGetParticipationInfoRes",
			block = true
		},
		[50] = {
			"PM_PeakTournamentKnockoutGetMyScheduleInfoReq",
			"PM_PeakTournamentKnockoutGetMyScheduleInfoRes",
			block = true
		},
		[51] = {
			"PM_PeakTournamentKnockoutGetMyBattleRecordsReq",
			"PM_PeakTournamentKnockoutGetMyBattleRecordsRes",
			block = true
		},
		[52] = {
			"PM_PeakTournamentKnockoutGetBattleVideoReq",
			"PM_PeakTournamentKnockoutGetBattleVideoRes",
			block = true
		},
		[53] = {
			"PM_PeakTournamentSetFormReq",
			"PM_PeakTournamentSetFormRes",
			block = true
		},
		[54] = {
			"PM_PeakTournamentGetFormReq",
			"PM_PeakTournamentFormRes",
			block = true
		},
		[55] = {
			"PM_PeakTournamentKnockoutGetGuessInfoReq",
			"PM_PeakTournamentKnockoutGetGuessInfoRes",
			block = true
		},
		[56] = {
			"PM_PeakTournamentKnockoutGuessReq",
			"PM_PeakTournamentKnockoutGuessRes",
			block = true
		},
		[57] = {
			"PM_PeakTournamentKnockoutGainGuessCoinReq",
			"PM_PeakTournamentKnockoutGainGuessCoinRes",
			block = true
		},
		[58] = {
			"PM_PeakTournamentKnockoutGainGuessRecordReq",
			"PM_PeakTournamentKnockoutGainGuessRecordRes",
			block = true
		},
		[60] = {
			"PM_PeakTournamentKnockoutGetGroupStageInfoReq",
			"PM_PeakTournamentKnockoutGetGroupStageInfoRes",
			block = true
		},
		[61] = {
			"PM_PeakTournamentKnockoutGetTopViewReq",
			"PM_PeakTournamentKnockoutGetTopViewRes",
			block = true
		},
		[62] = {
			"PM_PeakTournamentKudosReq",
			"PM_PeakTournamentKudosRes",
			block = true
		},
		[63] = {
			"PM_PeakTournamentBanPetReq",
			"PM_PeakTournamentBanPetRes",
			block = true
		},
		[64] = {
			"PM_PeakTournamentBanPetInfoReq",
			"PM_PeakTournamentBanPetInfoRes",
			block = true
		}
	},
	[369] = {
		{
			"PM_MiyaChallengeGetInfoReq",
			"PM_MiyaChallengeGetInfoRes",
			block = true
		},
		{
			"PM_MiyaChallengeGetStageInfoReq",
			"PM_MiyaChallengeGetStageInfoRes",
			block = true
		},
		{
			"PM_MiyaChallengeBuyAndRandomReq",
			"PM_MiyaChallengeBuyAndRandomRes",
			block = true
		},
		{
			"PM_MiyaChallengeChoiceReq",
			"PM_MiyaChallengeChoiceRes",
			block = true
		},
		{
			"PM_MiyaChallengeBossReq",
			"PM_MiyaChallengeBossRes",
			block = true
		},
		{
			"PM_MiyaBossChallengeEndRes"
		},
		{
			"PM_MiyaFormChallengeReq",
			"PM_MiyaFormChallengeRes",
			block = true
		},
		{
			"PM_MiyaFormChallengeEndRes"
		},
		[255] = "MiyaChallengeExtension"
	},
	[370] = {
		{
			"PM_PriceBreakDiscountGetInfoReq",
			"PM_PriceBreakDiscountGetInfoRes",
			block = true
		},
		{
			"PM_PriceBreakDiscountBuyReq",
			"PM_PriceBreakDiscountBuyRes",
			block = true
		},
		{
			"PM_PriceBreakDiscountSaveCartReq",
			"PM_PriceBreakDiscountSaveCartRes",
			block = true
		},
		[255] = "PriceBreakDiscountExtension"
	},
	[371] = {
		{
			"PM_XiaoNuoBirthdayGetInfoReq",
			"PM_XiaoNuoBirthdayGetInfoRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayStartNormalGameReq",
			"PM_XiaoNuoBirthdayStartNormalGameRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayEndNormalGameReq",
			"PM_XiaoNuoBirthdayEndNormalGameRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayStartCrazyGameReq",
			"PM_XiaoNuoBirthdayStartCrazyGameRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayEndCrazyGameReq",
			"PM_XiaoNuoBirthdayEndCrazyGameRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayBuyPlayNumReq",
			"PM_XiaoNuoBirthdayBuyPlayNumRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayGameProgressPrizeReq",
			"PM_XiaoNuoBirthdayGameProgressPrizeRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayOpenGiftReq",
			"PM_XiaoNuoBirthdayOpenGiftRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdayGetRankReq",
			"PM_XiaoNuoBirthdayGetRankRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdaySweepNormalGameReq",
			"PM_XiaoNuoBirthdaySweepNormalGameRes",
			block = true
		},
		{
			"PM_XiaoNuoBirthdaySweepCrazyGameReq",
			"PM_XiaoNuoBirthdaySweepCrazyGameRes",
			block = true
		},
		[255] = "XiaoNuoBirthdayGiftExtension"
	},
	[372] = {
		{
			"PM_BirthdayWishesUserInfoReq",
			"PM_BirthdayWishesUserInfoRes",
			block = true
		},
		{
			"PM_BirthdayWishesSendWishReq",
			"PM_BirthdayWishesSendWishRes",
			block = true
		},
		{
			"PM_BirthdayWishesGiftOpenReq",
			"PM_BirthdayWishesGiftOpenRes",
			block = true
		},
		{
			"PM_BirthdayWishesGiveFriendReq",
			"PM_BirthdayWishesGiveFriendRes",
			block = true
		},
		{
			"PM_BirthdayWishesGiveAndGetRecordReq",
			"PM_BirthdayWishesGiveAndGetRecordRes",
			block = true
		},
		{
			"PM_BirthdayWishesUserRedPointSetReq",
			"PM_BirthdayWishesUserRedPointSetRes",
			block = true
		},
		{
			"PM_BirthdayWishesPutOutWishListReq",
			"PM_BirthdayWishesPutOutWishListRes",
			block = true
		},
		{
			"PM_BirthdayWishesRepealWishListReq",
			"PM_BirthdayWishesRepealWishListRes",
			block = true
		},
		{
			"PM_BirthdayWishesGetAllWishListReq",
			"PM_BirthdayWishesGetAllWishListRes",
			block = true
		},
		{
			"PM_BirthdayWishesGetWishListRecordReq",
			"PM_BirthdayWishesGetWishListRecordRes",
			block = true
		},
		{
			"PM_BirthdayWishesFinishBuddyWishListReq",
			"PM_BirthdayWishesFinishBuddyWishListRes",
			block = true
		},
		{
			"PM_BirthadyWishesGainCollectPrizeReq",
			"PM_BirthadyWishesGainCollectPrizeRes",
			block = true
		},
		{
			"PM_BirthadyWishesGainGivePrizeReq",
			"PM_BirthadyWishesGainGivePrizeRes",
			block = true
		},
		[255] = "BirthdayWishesExtension"
	},
	[373] = {
		{
			"PM_PsychicImproveGetInfoReq",
			"PM_PsychicImproveGetInfoRes",
			block = true
		},
		{
			"PM_PsychicImproveHirePetReq",
			"PM_PsychicImproveHirePetRes",
			block = true
		},
		[255] = "PsychicImproveExtension"
	},
	[376] = {
		{
			"PM_BirthdayCakeInfoReq",
			"PM_BirthdayCakeInfoRes",
			block = true
		},
		{
			"PM_BirthdayCakeTaskInfoReq",
			"PM_BirthdayCakeTaskInfoRes",
			block = true
		},
		{
			"PM_BirthdayCakeTaskGetRewardReq",
			"PM_BirthdayCakeTaskGetRewardRes",
			block = true
		},
		{
			"PM_BirthdayCakeMakeReq",
			"PM_BirthdayCakeMakeRes",
			block = true
		},
		{
			"PM_BirthdayCakeWorldProgressValueReq",
			"PM_BirthdayCakeWorldProgressValueRes",
			block = true
		},
		{
			"PM_BirthdayCakeCarveUpReq",
			"PM_BirthdayCakeCarveUpRes",
			block = true
		},
		{
			"PM_BirthdayCakeBuyReq",
			"PM_BirthdayCakeBuyRes",
			block = true
		},
		{
			"PM_BirthdayCakeCarveUpRecordReq",
			"PM_BirthdayCakeCarveUpRecordRes",
			block = true
		},
		{
			"PM_BirthdayCakeWorldProgressRewardReq",
			"PM_BirthdayCakeWorldProgressRewardRes",
			block = true
		},
		[255] = "BirthdayCakeExtension"
	},
	[377] = {
		{
			"PM_PeakReturnGetInfoReq",
			"PM_PeakReturnGetInfoRes",
			block = true
		},
		{
			"PM_PeakReturnGainPrizeReq",
			"PM_PeakReturnGainPrizeRes",
			block = true
		},
		[255] = "PeakReturnExtension"
	},
	[378] = {
		{
			"PM_IntoTheCarWishTreeInfoReq",
			"PM_IntoTheCarWishTreeInfoRes",
			block = true
		},
		{
			"PM_IntoTheCarSelectWishPrizeReq",
			"PM_IntoTheCarSelectWishPrizeRes",
			block = true
		},
		{
			"PM_IntoTheCarWishTreeGainPrizeReq",
			"PM_IntoTheCarWishTreeGainPrizeRes",
			block = true
		},
		{
			"PM_IntoTheCarGameInfoReq",
			"PM_IntoTheCarGameInfoRes",
			block = true
		},
		{
			"PM_IntoTheCarStartGameReq",
			"PM_IntoTheCarStartGameRes",
			block = true
		},
		{
			"PM_IntoTheCarEndGameReq",
			"PM_IntoTheCarEndGameRes",
			block = true
		},
		{
			"PM_IntoTheCarUnLockLabelReq",
			"PM_IntoTheCarUnLockLabelRes",
			block = true
		},
		{
			"PM_IntoTheCarGetUnLockLabelsReq",
			"PM_IntoTheCarGetUnLockLabelsRes",
			block = true
		},
		{
			"PM_IntoTheCarSweepGameReq",
			"PM_IntoTheCarSweepGameRes",
			block = true
		},
		[255] = "IntoTheCarExtension"
	},
	[379] = {
		{
			"PM_WheelFortuneInfoReq",
			"PM_WheelFortuneInfoRes",
			block = true
		},
		{
			"PM_WheelFortuneDrawReq",
			"PM_WheelFortuneDrawRes",
			block = true
		},
		{
			"PM_WheelFortuneRecordsReq",
			"PM_WheelFortuneRecordsRes",
			block = true
		},
		[255] = "WheelFortuneExtension"
	},
	[381] = {
		{
			"PM_FamilyRedPacketGetTaskInfoReq",
			"PM_FamilyRedPacketGetTaskInfoRes",
			block = true
		},
		{
			"PM_FamilyRedPacketSendRedPacketReq",
			"PM_FamilyRedPacketSendRedPacketRes",
			block = true
		},
		{
			"PM_FamilyRedPacketGetListReq",
			"PM_FamilyRedPacketGetListRes",
			block = true
		},
		{
			"PM_FamilyRedPacketGainReq",
			"PM_FamilyRedPacketGainRes",
			block = true
		},
		{
			"PM_FamilyRedPacketGetGainRecordReq",
			"PM_FamilyRedPacketGetGainRecordRes",
			block = true
		},
		[255] = "FamilyRedPacketExtension"
	},
	[382] = {
		{
			"PM_LinkageLotterygetInfoReq",
			"PM_LinkageLotterygetInfoRes",
			block = true
		},
		{
			"PM_LinkageLotteryRandReq",
			"PM_LinkageLotteryRandRes",
			block = true
		},
		{
			"PM_LinkageLotteryBuyLotteryReq",
			"PM_LinkageLotteryBuyLotteryRes",
			block = true
		},
		[255] = "LinkageLotteryExtension"
	},
	[383] = {
		{
			"PM_RichManGetInfoReq",
			"PM_RichManGetInfoRes",
			block = true
		},
		{
			"PM_RichManWalkReq",
			"PM_RichManWalkRes",
			block = true
		},
		{
			"PM_RichManActionReq",
			"PM_RichManActionRes",
			block = true
		},
		{
			"PM_RichManEditMapReq",
			"PM_RichManEditMapRes",
			block = true
		},
		{
			"PM_RichManDefendSetFormReq",
			"PM_RichManDefendSetFormRes",
			block = true
		},
		{
			"PM_RichManResourcePrizeReq",
			"PM_RichManResourcePrizeRes",
			block = true
		},
		{
			"PM_RichManGetTotalResourceReq",
			"PM_RichManGetTotalResourceRes",
			block = true
		},
		[255] = "RichManExtension",
		[11] = {
			"PM_RichManAttackMatchReq",
			"PM_RichManAttackMatchRes",
			block = true
		},
		[12] = {
			"PM_RichManAttackWalkReq",
			"PM_RichManAttackWalkRes",
			block = true
		},
		[13] = {
			"PM_RichManAttackFightReq",
			"PM_RichManAttackFightRes",
			block = true
		},
		[14] = {
			"PM_RichManRevengeReq",
			"PM_RichManRevengeRes",
			block = true
		},
		[15] = {
			"PM_RichManAttackSetFormReq",
			"PM_RichManAttackSetFormRes",
			block = true
		},
		[21] = {
			"PM_RichManGetRecordReq",
			"PM_RichManGetRecordRes",
			block = true
		},
		[22] = {
			"PM_RichManGetRankReq",
			"PM_RichManGetRankRes",
			block = true
		},
		[101] = {
			"PM_RichManFightResultRes"
		}
	},
	[384] = {
		{
			"PM_MakeSnowmanGetInfoReq",
			"PM_MakeSnowmanGetInfoRes",
			block = true
		},
		{
			"PM_MakeSnowmanGainProgressPrizeReq",
			"PM_MakeSnowmanGainProgressPrizeRes",
			block = true
		},
		[255] = "MakeSnowmanExtension"
	},
	[385] = {
		{
			"PM_AFP2023GetInfoReq",
			"PM_AFP2023GetInfoRes",
			block = true
		},
		{
			"PM_AFP2023MoveReq",
			"PM_AFP2023MoveRes",
			block = true
		},
		{
			"PM_AFP2023DoEventReq",
			"PM_AFP2023DoEventRes",
			block = true
		},
		{
			"PM_AFP2023CollateClueReq",
			"PM_AFP2023CollateClueRes",
			block = true
		},
		{
			"PM_AFP2023GainPersonPrizeReq",
			"PM_AFP2023GainPersonPrizeRes",
			block = true
		},
		{
			"PM_AFP2023GainProgressPrizeReq",
			"PM_AFP2023GainProgressPrizeRes",
			block = true
		},
		[255] = "AnnualFeePreheat2023Extension",
		[10] = {
			"PM_AFP2023NotifyEventFinishRes"
		}
	},
	[386] = {
		{
			"PM_GodHyurChallengeScoreInfoReq",
			"PM_GodHyurChallengeScoreInfoRes",
			block = true
		},
		{
			"PM_GodHyurChallengeOneKeyPassReq",
			"PM_GodHyurChallengeOneKeyPassRes",
			block = true
		},
		{
			"PM_GodHyurLimitChallengeInfoReq",
			"PM_GodHyurLimitChallengeInfoRes",
			block = true
		},
		{
			"PM_GodHyurWholePeopleChallengeInfoReq",
			"PM_GodHyurWholePeopleChallengeInfoRes",
			block = true
		},
		{
			"PM_GodHyurLimitChallengeReq",
			"PM_GodHyurLimitChallengeRes",
			block = true
		},
		{
			"PM_GodHyurWholePeopleChallengeReq",
			"PM_GodHyurWholePeopleChallengeRes",
			block = true
		},
		{
			"PM_GodHyurLimitChallengeResetReq",
			"PM_GodHyurLimitChallengeResetRes",
			block = true
		},
		{
			"PM_GodHyurLimitChallengeOverlapReq",
			"PM_GodHyurLimitChallengeOverlapRes",
			block = true
		},
		{
			"PM_GodHyurLimitChallengeFormReq",
			"PM_GodHyurLimitChallengeFormRes",
			block = true
		},
		[255] = "GodHyurChallengeExtension",
		[101] = {
			"PM_NotifyGodHyurLimitChallengeEndRes"
		},
		[102] = {
			"PM_NotifyGodHyurWholePeopleChallengeEndRes"
		}
	},
	[387] = {
		{
			"PM_DancingLionJumpGetInfoReq",
			"PM_DancingLionJumpGetInfoRes",
			block = true
		},
		{
			"PM_DancingLionJumpGameStartReq",
			"PM_DancingLionJumpGameStartRes",
			block = true
		},
		{
			"PM_DancingLionJumpGameEndReq",
			"PM_DancingLionJumpGameEndRes",
			block = true
		},
		{
			"PM_DancingLionJumpGetRankReq",
			"PM_DancingLionJumpGetRankRes",
			block = true
		},
		[255] = "DancingLionJumpExtension"
	},
	[388] = {
		{
			"PM_KingsExchangeGetInfoReq",
			"PM_KingsExchangeGetInfoRes",
			block = true
		},
		{
			"PM_KingsExchangeTaskGainReq",
			"PM_KingsExchangeTaskGainRes",
			block = true
		},
		{
			"PM_KingsExchangeGetPrizeReq",
			"PM_KingsExchangeGetPrizeRes",
			block = true
		},
		{
			"PM_KingsExchangeSelectListReq",
			"PM_KingsExchangeSelectListRes",
			block = true
		},
		[255] = "YuanXiaoKingsExchangeExtension"
	},
	[389] = {
		{
			"PM_CorrectPrincipleChallengeGetInfoReq",
			"PM_CorrectPrincipleChallengeGetInfoRes",
			block = true
		},
		{
			"PM_CorrectPrincipleChallengeFightReq",
			"PM_CorrectPrincipleChallengeFightRes",
			block = true
		},
		{
			"PM_CorrectPrincipleChallengeNotifyFightEndRes"
		},
		[255] = "CorrectPrincipleChallengeExtension"
	},
	[390] = {
		{
			"PM_TopUpLotteryGetInfoReq",
			"PM_TopUpLotteryGetInfoRes",
			block = true
		},
		{
			"PM_TopUpLotterySetBigPrizeReq",
			"PM_TopUpLotterySetBigPrizeRes",
			block = true
		},
		{
			"PM_TopUpLotteryRandReq",
			"PM_TopUpLotteryRandRes",
			block = true
		},
		[255] = "TopUpLotteryExtension"
	},
	[391] = {
		{
			"PM_SMPVEGetMapBuffInfoReq",
			"PM_SMPVEGetMapBuffInfoRes",
			block = true
		},
		{
			"PM_SMPVEEmakiFragmentInfosReq",
			"PM_SMPVEEmakiFragmentInfosRes",
			block = true
		},
		{
			"PM_SMPVEFindKeyInfoReq",
			"PM_SMPVEFindKeyInfoRes",
			block = true
		},
		{
			"PM_SMPVENotifyPointOccupiedRes"
		},
		[255] = "SeasonModePvePlusExtension",
		[31] = {
			"PM_GetSMPVESingleTeamCutePetInfoReq",
			"PM_GetSMPVESingleTeamCutePetInfoRes",
			block = true
		},
		[32] = {
			"PM_ChangeSMPVESinglePetCutePetInfoReq",
			"PM_ChangeSMPVESinglePetCutePetInfoRes",
			block = true
		},
		[33] = {
			"PM_GetSMPVEAllTeamCutePetInfoReq",
			"PM_GetSMPVEAllTeamCutePetInfoRes",
			block = true
		},
		[40] = {
			"PM_SMGVEGroupInfoReq",
			"PM_SMGVEGroupInfoRes",
			block = true
		},
		[41] = {
			"PM_SMGVEGroupInviteBuddyListReq",
			"PM_SMGVEGroupInviteBuddyListRes",
			block = true
		},
		[42] = {
			"PM_SMGVEGroupInviteListReq",
			"PM_SMGVEGroupInviteListRes",
			block = true
		},
		[43] = {
			"PM_SMGVESendGroupInviteReq",
			"PM_SMGVESendGroupInviteRes",
			block = true
		},
		[44] = {
			"PM_SMGVEHandleGroupInviteReq",
			"PM_SMGVEHandleGroupInviteRes",
			block = true
		},
		[45] = {
			"PM_SMGVEGroupReadyReq",
			"PM_SMGVEGroupReadyRes",
			block = true
		},
		[46] = {
			"PM_SMGVEGroupLeaveReq",
			"PM_SMGVEGroupLeaveRes",
			block = true
		},
		[47] = {
			"PM_SMGVEDetermineCreatePveGameModeReq",
			"PM_SMGVEDetermineCreatePveGameModeRes",
			block = true
		},
		[50] = {
			"PM_SMGVETeammateTeamInfoReq",
			"PM_SMGVETeammateTeamInfoRes",
			block = true
		},
		[51] = {
			"PM_SMGVEGainTeammateSharePrizeReq",
			"PM_SMGVEGainTeammateSharePrizeRes",
			block = true
		},
		[52] = {
			"PM_SMGVETeammateAllTeamInfoReq",
			"PM_SMGVETeammateAllTeamInfoRes",
			block = true
		},
		[53] = {
			"PM_SMPVENotifyTeammateMoveRes"
		},
		[101] = {
			"PM_NotifySMPVEMapBuffChangedRes"
		},
		[102] = {
			"PM_NotifySMPVEGainHirePetRes"
		},
		[110] = {
			"PM_NotifySMGVEReceiveGroupInviteRes"
		},
		[111] = {
			"PM_NotifySMGVESuccessCreateGroupRes"
		},
		[112] = {
			"PM_NotifySMGVEGroupDisbandRes"
		},
		[113] = {
			"PM_NotifySMGVESuccessCreateGVERoomRes"
		},
		[114] = {
			"PM_NotifySMGVEOpReadyRes"
		}
	},
	[392] = {
		{
			"PM_WakingLionGameGetInfoReq",
			"PM_WakingLionGameGetInfoRes",
			block = true
		},
		{
			"PM_WakingLionGameStartGameReq",
			"PM_WakingLionGameStartGameRes",
			block = true
		},
		{
			"PM_WakingLionGameEndGameReq",
			"PM_WakingLionGameEndGameRes",
			block = true
		},
		{
			"PM_WakingLionGameGainPrizeReq",
			"PM_WakingLionGameGainPrizeRes",
			block = true
		},
		{
			"PM_WakingLionGameChallengeReq",
			"PM_WakingLionGameChallengeRes",
			block = true
		},
		[255] = "WakingLionGameExtension",
		[101] = {
			"PM_WakingLionGameChallengeEndRes"
		}
	},
	[393] = {
		{
			"PM_XiuMumChallengeGetInfoReq",
			"PM_XiuMumChallengeGetInfoRes",
			block = true
		},
		{
			"PM_XiuMumChallengeSubmitMapReq",
			"PM_XiuMumChallengeSubmitMapRes",
			block = true
		},
		{
			"PM_XiuMumChallengeReq",
			"PM_XiuMumChallengeRes",
			block = true
		},
		[255] = "XiuMumChallengeExtension",
		[10] = {
			"PM_XiuMumChallengeResultRes"
		}
	},
	[394] = {
		{
			"PM_KingCiYuanGetInfoReq",
			"PM_KingCiYuanGetInfoRes",
			block = true
		},
		{
			"PM_KingCiYuanBossGetPrizeReq",
			"PM_KingCiYuanBossGetPrizeRes",
			block = true
		},
		{
			"PM_KingCiYuanBossChallengeReq",
			"PM_KingCiYuanBossChallengeRes",
			block = true
		},
		{
			"PM_KingCiYuanBossBuyCountReq",
			"PM_KingCiYuanBossBuyCountRes",
			block = true
		},
		[255] = "KingCiYuanChallengeExtension",
		[11] = {
			"PM_KingCiYuanStageActionReq",
			"PM_KingCiYuanStageActionRes",
			block = true
		},
		[12] = {
			"PM_KingCiYuanStageResetReq",
			"PM_KingCiYuanStageResetRes",
			block = true
		},
		[13] = {
			"PM_KingCiYuanStageChangeBuffReq",
			"PM_KingCiYuanStageChangeBuffRes",
			block = true
		},
		[14] = {
			"PM_KingCiYuanFightResultConfirmReq",
			"PM_KingCiYuanFightResultConfirmRes",
			block = true
		},
		[21] = {
			"PM_KingCiYuanBossChallengeEndRes"
		},
		[22] = {
			"PM_KingCiYuanStageFightRes"
		}
	},
	[395] = {
		{
			"PM_CaiQingDrawGetInfoReq",
			"PM_CaiQingDrawGetInfoRes",
			block = true
		},
		{
			"PM_CaiQingDrawPrizeReq",
			"PM_CaiQingDrawPrizeRes",
			block = true
		},
		[255] = "CaiQingDrawExtension"
	},
	[397] = {
		{
			"PM_LandlordsPKInfoReq",
			"PM_LandlordsPKInfoRes",
			block = true
		},
		{
			"PM_LandlordsPKGetDailySuppluGainReq",
			"PM_LandlordsPKGetDailySuppluGainRes",
			block = true
		},
		{
			"PM_LandlordsPKGetOnlineTimeSupplyGainReq",
			"PM_LandlordsPKGetOnlineTimeSupplyGainRes",
			block = true
		},
		{
			"PM_LandlordsPKRankViewReq",
			"PM_LandlordsPKRankViewRes",
			block = true
		},
		{
			"PM_LandlordsPKGetBattleRecordReq",
			"PM_LandlordsPKGetBattleRecordRes",
			block = true
		},
		[255] = "LandlordsPKExtension",
		[7] = {
			"PM_LandlordsPKGetBattleVideoReq",
			"PM_LandlordsPKGetBattleVideoRes",
			block = true
		},
		[8] = {
			"PM_LandlordsPKMatchReq",
			"PM_LandlordsPKMatchRes",
			block = true
		},
		[9] = {
			"PM_LandlordsPKCancelMatchReq",
			"PM_LandlordsPKCancelMatchRes",
			block = true
		},
		[10] = {
			"PM_LandlordsPKLandlordReq",
			"PM_LandlordsPKLandlordRes",
			block = true
		},
		[11] = {
			"PM_LandlordsPKFormSetReq",
			"PM_LandlordsPKFormSetRes",
			block = true
		},
		[12] = {
			"PM_LandlordsPKChatReq",
			"PM_LandlordsPKChatRes",
			block = true
		},
		[13] = {
			"PM_LandlordsPKGetOnlineTimeSupplyGainInfoReq",
			"PM_LandlordsPKGetOnlineTimeSupplyGainInfoRes",
			block = true
		},
		[90] = {
			"PM_LandlordsPKNotifyDealCardRes"
		},
		[91] = {
			"PM_LandlordsPKNotifyLandlordsAckRes"
		},
		[92] = {
			"PM_LandlordsPKNotifyLandlordsCofirmRes"
		},
		[93] = {
			"PM_LandlordsPKNotifyLandlordsFormSetRes"
		},
		[94] = {
			"PM_LandlordsPKNotifyLandlordsFormShowRes"
		},
		[95] = {
			"PM_LandlordsPKNotifyBattleResultRes"
		},
		[96] = {
			"PM_LandlordsPKNotifyMatchingOverTimeRes"
		},
		[97] = {
			"PM_LandlordsPKNotifyMatchFailRes"
		},
		[98] = {
			"PM_LandlordsPKNotifyChatRes"
		}
	},
	[398] = {
		{
			"PM_QiXiSendGiftGetInfoReq",
			"PM_QiXiSendGiftGetInfoRes",
			block = true
		},
		{
			"PM_QiXiSendGiftSendReq",
			"PM_QiXiSendGiftSendRes",
			block = true
		},
		{
			"PM_QiXiSendGiftGetRomanceRankReq",
			"PM_QiXiSendGiftGetRomanceRankRes",
			block = true
		},
		{
			"PM_QiXiSendGiftGetSugarRankReq",
			"PM_QiXiSendGiftGetSugarRankRes",
			block = true
		},
		[255] = "QiXiSendGiftExtension"
	},
	[399] = {
		{
			"PM_QiChallengeGetInfoReq",
			"PM_QiChallengeGetInfoRes",
			block = true
		},
		{
			"PM_QiChallengeAllSealReq",
			"PM_QiChallengeAllSealRes",
			block = true
		},
		{
			"PM_QiChallengeAllReq",
			"PM_QiChallengeAllRes",
			block = true
		},
		{
			"PM_QiChallengeExtremeResetReq",
			"PM_QiChallengeExtremeResetRes",
			block = true
		},
		{
			"PM_QiChallengeExtremeReq",
			"PM_QiChallengeExtremeRes",
			block = true
		},
		[255] = "QiChallengeExtension",
		[10] = {
			"PM_QiChallengeAllResultRes"
		},
		[11] = {
			"PM_QiChallengeExtremeResultRes"
		}
	},
	[400] = {
		{
			"PM_ASheChallengeInfoReq",
			"PM_ASheChallengeInfoRes",
			block = true
		},
		{
			"PM_ASheChallengeBattleReq",
			"PM_ASheChallengeBattleRes",
			block = true
		},
		{
			"PM_ASheChallengeSelectBuffReq",
			"PM_ASheChallengeSelectBuffRes",
			block = true
		},
		{
			"PM_ASheChallengeRefreshReq",
			"PM_ASheChallengeRefreshRes",
			block = true
		},
		[255] = "ASheChallengeExtension",
		[10] = {
			"PM_NotifyASheChallengeBattleFinishRes",
			block = true
		}
	},
	[401] = {
		{
			"PM_BirthdaySportsWishesGetInfoReq",
			"PM_BirthdaySportsWishesGetInfoRes",
			block = true
		},
		{
			"PM_BirthdaySportsWishesHirePetReq",
			"PM_BirthdaySportsWishesHirePetRes",
			block = true
		},
		[255] = "BirthdaySportsWishesExtension"
	},
	[403] = {
		{
			"PM_RestoreGloryGetInfoReq",
			"PM_RestoreGloryGetInfoRes",
			block = true
		},
		{
			"PM_RestoreGloryGainSpacePrizeReq",
			"PM_RestoreGloryGainSpacePrizeRes",
			block = true
		},
		{
			"PM_RestoreGloryReq",
			"PM_RestoreGloryRes",
			block = true
		},
		[255] = "RestoreGloryExtension"
	},
	[404] = {
		{
			"PM_YiShiChallengeInfoReq",
			"PM_YiShiChallengeInfoRes",
			block = true
		},
		{
			"PM_YiShiChallengeReq",
			"PM_YiShiChallengeRes",
			block = true
		},
		{
			"PM_YiShiChallengeStageUnlockReq",
			"PM_YiShiChallengeStageUnlockRes",
			block = true
		},
		{
			"PM_YiShiChallengeUpgradeBuffReq",
			"PM_YiShiChallengeUpgradeBuffRes",
			block = true
		},
		[255] = "YiShiChallengeExtension",
		[101] = {
			"PM_Notify_YiShiChallengeEndRes"
		}
	},
	[405] = {
		{
			"PM_GroupRedPackGetInfoReq",
			"PM_GroupRedPackGetInfoRes",
			block = true
		},
		{
			"PM_GroupRedPackGrapReq",
			"PM_GroupRedPackGrapRes",
			block = true
		},
		{
			"PM_GroupRedPackGetRecordsReq",
			"PM_GroupRedPackGetRecordsRes",
			block = true
		},
		{
			"PM_GroupRedPackSendReq",
			"PM_GroupRedPackSendRes",
			block = true
		},
		{
			"PM_GroupRedPackGetRankInfoReq",
			"PM_GroupRedPackGetRankInfoRes",
			block = true
		},
		[255] = "GroupRedPackExtension",
		[10] = {
			"PM_NotifyNewGroupRedPacksRes"
		}
	},
	[406] = {
		{
			"PM_GuardCityGetInfoReq",
			"PM_GuardCityGetInfoRes",
			block = true
		},
		{
			"PM_GuardCityChallengeReq",
			"PM_GuardCityChallengeRes",
			block = true
		},
		{
			"PM_GuardCityRefreshReq",
			"PM_GuardCityRefreshRes",
			block = true
		},
		{
			"PM_GuardCityGetPrizeInfoReq",
			"PM_GuardCityGetPrizeInfoRes",
			block = true
		},
		{
			"PM_GuardCityGainPrizeReq",
			"PM_GuardCityGainPrizeRes",
			block = true
		},
		{
			"PM_GuardCityGetReportInfoReq",
			"PM_GuardCityGetReportInfoRes",
			block = true
		},
		{
			"PM_GuardCityConveneFriendReq",
			"PM_GuardCityConveneFriendRes",
			block = true
		},
		{
			"PM_GuardCityViewSeekHelpReq",
			"PM_GuardCityViewSeekHelpRes",
			block = true
		},
		{
			"PM_GuardCityViewFriendScoreReq",
			"PM_GuardCityViewFriendScoreRes",
			block = true
		},
		{
			"PM_GuardCityGainFriendPrizeReq",
			"PM_GuardCityGainFriendPrizeRes",
			block = true
		},
		{
			"PM_GuardCityGainProgressPrizeReq",
			"PM_GuardCityGainProgressPrizeRes",
			block = true
		},
		{
			"PM_GuardCityViewRankReq",
			"PM_GuardCityViewRankRes",
			block = true
		},
		{
			"PM_GuardCityBuyStrengthReq",
			"PM_GuardCityBuyStrengthRes",
			block = true
		},
		[255] = "GuardCityExtension",
		[100] = {
			"PM_GuardCityChallengeResultRes",
			block = true
		}
	},
	[407] = {
		{
			"PM_GoddessContestInfoReq",
			"PM_GoddessContestInfoRes",
			block = true
		},
		[255] = "GoddessContestExtension",
		[4] = {
			"PM_GoddessContestJoinFansGroupReq",
			"PM_GoddessContestJoinFansGroupRes",
			block = true
		},
		[5] = {
			"PM_GoddessContestGetFansGroupInfoReq",
			"PM_GoddessContestGetFansGroupInfoRes",
			block = true
		},
		[6] = {
			"PM_GoddessContestGoddessVoteReq",
			"PM_GoddessContestGoddessVoteRes",
			block = true
		},
		[8] = {
			"PM_GoddessContestGetCampaignListReq",
			"PM_GoddessContestGetCampaignListRes",
			block = true
		},
		[9] = {
			"PM_GoddessContestDirectorVoteReq",
			"PM_GoddessContestDirectorVoteRes",
			block = true
		},
		[10] = {
			"PM_GoddessContestDirectorCampaignReq",
			"PM_GoddessContestDirectorCampaignRes",
			block = true
		},
		[11] = {
			"PM_GoddessContestCampaignSearchReq",
			"PM_GoddessContestCampaignSearchRes",
			block = true
		},
		[12] = {
			"PM_GoddessContestPromptReq",
			"PM_GoddessContestPromptRes",
			block = true
		},
		[13] = {
			"PM_GoddessContestReviseDeclarationReq",
			"PM_GoddessContestReviseDeclarationRes",
			block = true
		},
		[14] = {
			"PM_GoddessContestGetRankViewReq",
			"PM_GoddessContestGetRankViewRes",
			block = true
		},
		[15] = {
			"PM_GoddessContestGetCardInfoReq",
			"PM_GoddessContestGetCardInfoRes",
			block = true
		},
		[16] = {
			"PM_GoddessContestSetCardReq",
			"PM_GoddessContestSetCardRes",
			block = true
		},
		[17] = {
			"PM_GoddessContestFlopReq",
			"PM_GoddessContestFlopRes",
			block = true
		}
	},
	[408] = {
		{
			"PM_DisorderDragonChallengeGetInfoReq",
			"PM_DisorderDragonChallengeGetInfoRes",
			block = true
		},
		{
			"PM_DisorderDragonChallengeAllReq",
			"PM_DisorderDragonChallengeAllRes",
			block = true
		},
		{
			"PM_DisorderDragonChallengeExtremeReq",
			"PM_DisorderDragonChallengeExtremeRes",
			block = true
		},
		[255] = "DisorderDragonChallengeExtension",
		[10] = {
			"PM_DisorderDragonChallengeAllResultRes"
		},
		[11] = {
			"PM_DisorderDragonChallengeExtremeResultRes"
		}
	},
	[410] = {
		{
			"PM_FemalePsychicChallengeInfoReq",
			"PM_FemalePsychicChallengeInfoRes",
			block = true
		},
		{
			"PM_FemalePsychicChallengeReq",
			"PM_FemalePsychicChallengeRes",
			block = true
		},
		{
			"PM_FemalePsychicChallengeConformResultReq",
			"PM_FemalePsychicChallengeConformResultRes",
			block = true
		},
		{
			"PM_FemalePsychicChallengeUpgradeSignInBuffReq",
			"PM_FemalePsychicChallengeUpgradeSignInBuffRes",
			block = true
		},
		[255] = "FemalePsychicChallengeExtension",
		[10] = {
			"PM_NotifyFemalePsychicChallengeFinishRes",
			block = true
		}
	},
	[411] = {
		{
			"PM_HolyLightGetInfoReq",
			"PM_HolyLightGetInfoRes",
			block = true
		},
		{
			"PM_HolyLightGoReq",
			"PM_HolyLightGoRes",
			block = true
		},
		{
			"PM_HolyLightRandCreepsReq",
			"PM_HolyLightRandCreepsRes",
			block = true
		},
		{
			"PM_HolyLightChoiceCreepsReq",
			"PM_HolyLightChoiceCreepsRes",
			block = true
		},
		{
			"PM_HolyLightChallengeReq",
			"PM_HolyLightChallengeRes",
			block = true
		},
		{
			"PM_HolyLightChallengeResultRes"
		},
		{
			"PM_HolyLightGetRankReq",
			"PM_HolyLightGetRankRes",
			block = true
		},
		[255] = "HolyLightExtension"
	},
	[412] = {
		{
			"PM_FriendBargainGetInfoReq",
			"PM_FriendBargainGetInfoRes",
			block = true
		},
		{
			"PM_FriendBargainChatReq",
			"PM_FriendBargainChatRes",
			block = true
		},
		{
			"PM_FriendBargainBuyReq",
			"PM_FriendBargainBuyRes",
			block = true
		},
		{
			"PM_FriendBargainReduceReq",
			"PM_FriendBargainReduceRes",
			block = true
		},
		{
			"PM_FriendBargainFindReq",
			"PM_FriendBargainFindRes",
			block = true
		},
		[255] = "FriendBargainExtension"
	},
	[413] = {
		{
			"PM_DualDragonChallengeGetInfoReq",
			"PM_DualDragonChallengeGetInfoRes",
			block = true
		},
		{
			"PM_DualDragonUniversalChallengeReq",
			"PM_DualDragonUniversalChallengeRes",
			block = true
		},
		{
			"PM_DualDragonBuyUniversalChallengeTimesReq",
			"PM_DualDragonBuyUniversalChallengeTimesRes",
			block = true
		},
		{
			"PM_DualDragonExtremeChallengeReq",
			"PM_DualDragonExtremeChallengeRes",
			block = true
		},
		{
			"PM_DualDragonResetExtremeReq",
			"PM_DualDragonResetExtremeRes",
			block = true
		},
		{
			"PM_DualDragonGainPrizeExtremeReq",
			"PM_DualDragonGainPrizeExtremeRes",
			block = true
		},
		[255] = "DualDragonChallengeExtension",
		[100] = {
			"PM_NotifyDualDragonUniversalChallengeRes"
		},
		[101] = {
			"PM_NotifyDualDragonExtremeChallengeRes"
		}
	},
	[414] = {
		{
			"PM_LoadAllUniquePropsReq",
			"PM_LoadAllUniquePropsRes",
			block = true
		},
		{
			"PM_UseUniquePropReq",
			"PM_UseUniquePropRes",
			block = true
		},
		{
			"PM_notifyUniquePropChangeRes"
		},
		{
			"PM_GetOtherUniquePropsReq",
			"PM_GetOtherUniquePropsRes",
			block = true
		},
		{
			"PM_UniquePropsSetTopReq",
			"PM_UniquePropsSetTopRes",
			block = true
		},
		[255] = "UniquePropExtension"
	},
	[415] = {
		{
			"PM_BabyBusGetInfoReq",
			"PM_BabyBusGetInfoRes",
			block = true
		},
		{
			"PM_BabyBusWalkReq",
			"PM_BabyBusWalkRes",
			block = true
		},
		{
			"PM_BabyBusGainPrizeReq",
			"PM_BabyBusGainPrizeRes",
			block = true
		},
		[255] = "BabyBusExtension"
	},
	[416] = {
		{
			"PM_ScratchLotteryInfoReq",
			"PM_ScratchLotteryInfoRes",
			block = true
		},
		{
			"PM_ScratchLotteryDigReq",
			"PM_ScratchLotteryDigRes",
			block = true
		},
		[255] = "ScratchLotteryExtension"
	},
	[417] = {
		{
			"PM_GoldenTenGetInfoReq",
			"PM_GoldenTenGetInfoRes",
			block = true
		},
		{
			"PM_GoldenTenBecomeLeaderReq",
			"PM_GoldenTenBecomeLeaderRes",
			block = true
		},
		{
			"PM_GoldenTenBecomeFollowerReq",
			"PM_GoldenTenBecomeFollowerRes",
			block = true
		},
		{
			"PM_GoldenTenGainPrizeReq",
			"PM_GoldenTenGainPrizeRes",
			block = true
		},
		[255] = "GoldendTenExtension"
	},
	[418] = {
		{
			"PM_GloryTowerGetInfoReq",
			"PM_GloryTowerGetInfoRes",
			block = true
		},
		{
			"PM_GloryTowerGetFormReq",
			"PM_GloryTowerGetFormRes",
			block = true
		},
		{
			"PM_GloryTowerSaveFormReq",
			"PM_GloryTowerSaveFormRes",
			block = true
		},
		{
			"PM_GloryTowerChallengeReq",
			"PM_GloryTowerChallengeRes",
			block = true
		},
		{
			"PM_GloryTowerGetRankViewReq",
			"PM_GloryTowerGetRankViewRes",
			block = true
		},
		[255] = "GloryTowerExtension",
		[99] = {
			"PM_GloryTowerNotifyChallengeEndRes"
		}
	},
	[419] = {
		{
			"PM_SuperGhostLotteryGetInfoReq",
			"PM_SuperGhostLotteryGetInfoRes",
			block = true
		},
		{
			"PM_SuperGhostLotterySelectBigPrizeReq",
			"PM_SuperGhostLotterySelectBigPrizeRes",
			block = true
		},
		{
			"PM_SuperGhostLotteryDrawReq",
			"PM_SuperGhostLotteryDrawRes",
			block = true
		},
		[255] = "SuperGhostLotteryExtension"
	},
	[420] = {
		{
			"PM_AnniversaryKoiGetInfoReq",
			"PM_AnniversaryKoiGetInfoRes",
			block = true
		},
		{
			"PM_AnniversaryKoiLotteryReq",
			"PM_AnniversaryKoiLotteryRes",
			block = true
		},
		{
			"PM_AnniversaryKoiGetRecordsReq",
			"PM_AnniversaryKoiGetRecordsRes",
			block = true
		},
		{
			"PM_AnniversaryKoiRankViewReq",
			"PM_AnniversaryKoiRankViewRes",
			block = true
		},
		[255] = "AnniversaryKoiExtension",
		[10] = {
			"PM_AnniversaryKoiNotifyLuckNumberRes"
		}
	},
	[421] = {
		{
			"PM_GeneralWorldProgressGetInfoReq",
			"PM_GeneralWorldProgressGetInfoRes",
			block = true
		},
		{
			"PM_GeneralWorldProgressGainReq",
			"PM_GeneralWorldProgressGainRes",
			block = true
		},
		[255] = "GeneralWorldProgressExtension"
	},
	[422] = {
		{
			"PM_SunWuKongChallengeGetInfoReq",
			"PM_SunWuKongChallengeGetInfoRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeReq",
			"PM_SunWuKongChallengeRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeDoHiddenTaskReq",
			"PM_SunWuKongChallengeDoHiddenTaskRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeStartGameReq",
			"PM_SunWuKongChallengeStartGameRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeEndGameReq",
			"PM_SunWuKongChallengeEndGameRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeGetCimeliaInfoReq",
			"PM_SunWuKongChallengeGetCimeliaInfoRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeUpgradeCimeliaReq",
			"PM_SunWuKongChallengeUpgradeCimeliaRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeResetCimeliaReq",
			"PM_SunWuKongChallengeResetCimeliaRes",
			block = true
		},
		{
			"PM_SunWuKongChallengeGainDailyPrizeReq",
			"PM_SunWuKongChallengeGainDailyPrizeRes",
			block = true
		},
		[255] = "SunWuKongChallengeExtension",
		[101] = {
			"PM_SunWuKongChallengeResultRes"
		}
	},
	[423] = {
		{
			"PM_ProjectAshInfoReq",
			"PM_ProjectAshInfoRes",
			block = true
		},
		{
			"PM_ProjectAshGainPrizeReq",
			"PM_ProjectAshGainPrizeRes",
			block = true
		},
		{
			"PM_ProjectAshStage1LotteryReq",
			"PM_ProjectAshStage1LotteryRes",
			block = true
		},
		{
			"PM_ProjectAshStage2ChallengeReq",
			"PM_ProjectAshStage2ChallengeRes",
			block = true
		},
		[255] = "ProjectAshExtension",
		[6] = {
			"PM_ProjectAshStage2GetRankInfoReq",
			"PM_ProjectAshStage2GetRankInfoRes",
			block = true
		},
		[7] = {
			"PM_NotifyProjectAshStage2ChallengeEndRes"
		}
	},
	[424] = {
		{
			"PM_VersionForesightGetInfoReq",
			"PM_VersionForesightGetInfoRes",
			block = true
		},
		{
			"PM_VersionForesightShakeDiceReq",
			"PM_VersionForesightShakeDiceRes",
			block = true
		},
		{
			"PM_VersionForesightGainBoxPrizeReq",
			"PM_VersionForesightGainBoxPrizeRes",
			block = true
		},
		[255] = "VersionForesightExtension"
	},
	[425] = {
		{
			"PM_LBFInfoReq",
			"PM_LBFInfoRes",
			block = true
		},
		{
			"PM_LBFUnlockPackagePosReq",
			"PM_LBFUnlockPackagePosRes",
			block = true
		},
		{
			"PM_LBFAdjustPackageReq",
			"PM_LBFAdjustPackageRes",
			block = true
		},
		{
			"PM_LBFStartMatchReq",
			"PM_LBFStartMatchRes",
			block = true
		},
		{
			"PM_LBFCancelMatchReq",
			"PM_LBFCancelMatchRes",
			block = true
		},
		{
			"PM_LBFLeaveGameReq",
			"PM_LBFLeaveGameRes",
			block = true
		},
		{
			"PM_LBFSelectInitialPetReq",
			"PM_LBFSelectInitialPetRes",
			block = true
		},
		{
			"PM_LBFSelectInitialBuffReq",
			"PM_LBFSelectInitialBuffRes",
			block = true
		},
		{
			"PM_LBFStartBattleMatchReq",
			"PM_LBFStartBattleMatchRes",
			block = true
		},
		{
			"PM_LBFSetFirstStepFormationReq",
			"PM_LBFSetFirstStepFormationRes",
			block = true
		},
		{
			"PM_LBFSetSecondStepFormationReq",
			"PM_LBFSetSecondStepFormationRes",
			block = true
		},
		{
			"PM_LBFSelectBattleBuffReq",
			"PM_LBFSelectBattleBuffRes",
			block = true
		},
		{
			"PM_LBFSelectBattleSpoilsReq",
			"PM_LBFSelectBattleSpoilsRes",
			block = true
		},
		{
			"PM_LBFSelectSpoilsReq",
			"PM_LBFSelectSpoilsRes",
			block = true
		},
		{
			"PM_LBFSimpleBattleRecordReq",
			"PM_LBFSimpleBattleRecordRes",
			block = true
		},
		{
			"PM_LBFBattleRecordReq",
			"PM_LBFBattleRecordRes",
			block = true
		},
		{
			"PM_LBFGetBattleVideoReq",
			"PM_LBFGetBattleVideoRes",
			block = true
		},
		[255] = "LotusBattleFieldExtension",
		[101] = {
			"PM_LBFNotifyMatchingOverTimeRes"
		},
		[102] = {
			"PM_LBFNotifyMatchFailRes"
		},
		[103] = {
			"PM_LBFNotifyGameStartRes"
		},
		[104] = {
			"PM_LBFNotifySelectPetFinishRes"
		},
		[105] = {
			"PM_LBFNotifyEnterBattleFieldRes"
		},
		[106] = {
			"PM_LBFNotifyBattleFieldChangedRes"
		},
		[107] = {
			"PM_LBFNotifyForceStartMatchRes"
		},
		[108] = {
			"PM_LBFNotifyStartBattleRes"
		},
		[109] = {
			"PM_LBFNotifyOpFinishSetFormationRes"
		},
		[110] = {
			"PM_LBFNotifyEnterNextSetFormationRes"
		},
		[111] = {
			"PM_LBFNotifyEnterSelectBuffRes"
		},
		[112] = {
			"PM_LBFNotifyFightResultRes"
		},
		[113] = {
			"PM_LBFNotifySelectBattleSpoilsOverTimeRes"
		},
		[114] = {
			"PM_LBFNotifySelectBattleSpoilsSuccessRes"
		},
		[115] = {
			"PM_LBFNotifyGameEndRes"
		}
	},
	[426] = {
		{
			"PM_YuHuiChallengeGetInfoReq",
			"PM_YuHuiChallengeGetInfoRes",
			block = true
		},
		{
			"PM_YuHuiChallengeFightReq",
			"PM_YuHuiChallengeFightRes",
			block = true
		},
		{
			"PM_YuHuiChallengeResetReq",
			"PM_YuHuiChallengeResetRes",
			block = true
		},
		{
			"PM_YuHuiChallengeUpgradeSignInBuffReq",
			"PM_YuHuiChallengeUpgradeSignInBuffRes",
			block = true
		},
		[255] = "YuHuiChallengeExtension",
		[99] = {
			"PM_YuHuiChallengeFightEndRes"
		}
	},
	[427] = {
		{
			"PM_PetCardLotteryGetInfoReq",
			"PM_PetCardLotteryGetInfoRes",
			block = true
		},
		{
			"PM_PetCardLotterySelectCardReq",
			"PM_PetCardLotterySelectCardRes",
			block = true
		},
		{
			"PM_PetCardLotteryGainPrizeReq",
			"PM_PetCardLotteryGainPrizeRes",
			block = true
		},
		[255] = "PetCardLotteryExtension"
	},
	[428] = {
		{
			"PM_RedLotusGalaGetInfoReq",
			"PM_RedLotusGalaGetInfoRes",
			block = true
		},
		{
			"PM_RedLotusGalaStartGameReq",
			"PM_RedLotusGalaStartGameRes",
			block = true
		},
		{
			"PM_RedLotusGalaEndGameReq",
			"PM_RedLotusGalaEndGameRes",
			block = true
		},
		{
			"PM_RedLotusGalaGainPrizeReq",
			"PM_RedLotusGalaGainPrizeRes",
			block = true
		},
		{
			"PM_RedLotusGalaBuyTimesReq",
			"PM_RedLotusGalaBuyTimesRes",
			block = true
		},
		[255] = "RedLotusGalaExtension"
	},
	[429] = {
		{
			"PM_CollectSummoningGetInfoReq",
			"PM_CollectSummoningGetInfoRes",
			block = true
		},
		{
			"PM_CollectSummoningGainPrizeReq",
			"PM_CollectSummoningGainPrizeRes",
			block = true
		},
		[255] = "CollectSummoningExtension"
	},
	[430] = {
		{
			"PM_FuyaoGetInfoReq",
			"PM_FuyaoGetInfoRes",
			block = true
		},
		{
			"PM_FuyaoCommonChallengeReq",
			"PM_FuyaoCommonChallengeRes",
			block = true
		},
		{
			"PM_FuyaoExtremeChallengeReq",
			"PM_FuyaoExtremeChallengeRes",
			block = true
		},
		[255] = "FuyaoChallengeExtension",
		[101] = {
			"PM_FuyaoNotifyCommonChallengeResultRes"
		},
		[102] = {
			"PM_FuyaoNotifyExtremeChallengeResultRes"
		}
	},
	[431] = {
		{
			"PM_FireDimensionClgInfoReq",
			"PM_FireDimensionClgInfoRes",
			block = true
		},
		{
			"PM_FireDimensionChallengeReq",
			"PM_FireDimensionChallengeRes",
			block = true
		},
		{
			"PM_FireDimensionClgBanReq",
			"PM_FireDimensionClgBanRes",
			block = true
		},
		{
			"PM_FireDimensionClgResetReq",
			"PM_FireDimensionClgResetRes",
			block = true
		},
		{
			"PM_FireDimensionClgUpgradeSignInBuffReq",
			"PM_FireDimensionClgUpgradeSignInBuffRes",
			block = true
		},
		[255] = "FireDimensionChallengeExtension",
		[10] = {
			"PM_FireDimensionClgFightEndRes"
		}
	},
	[432] = {
		{
			"PM_ThroneEquipmentReplaceReq",
			"PM_ThroneEquipmentReplaceRes",
			block = true
		},
		[255] = "ThroneEquipmentReplaceExtension"
	},
	[433] = {
		{
			"PM_MasterFormViewFormReq",
			"PM_MasterFormViewFormRes",
			block = true
		},
		{
			"PM_MasterFormGetMyFormReq",
			"PM_MasterFormGetMyFormRes",
			block = true
		},
		{
			"PM_MasterFormGetCollectionFormReq",
			"PM_MasterFormGetCollectionFormRes",
			block = true
		},
		{
			"PM_MasterFormgetCommentsReq",
			"PM_MasterFormgetCommentsRes",
			block = true
		},
		{
			"PM_MasterFormKudoFormReq",
			"PM_MasterFormKudoFormRes",
			block = true
		},
		{
			"PM_MasterFormKudoCommentReq",
			"PM_MasterFormKudoCommentRes",
			block = true
		},
		{
			"PM_MasterFormSubmitFormReq",
			"PM_MasterFormSubmitFormRes",
			block = true
		},
		{
			"PM_MasterFormRevokeReq",
			"PM_MasterFormRevokeRes",
			block = true
		},
		{
			"PM_MasterFormCollectReq",
			"PM_MasterFormCollectRes",
			block = true
		},
		{
			"PM_MasterFormCancelCollectReq",
			"PM_MasterFormCancelCollectRes",
			block = true
		},
		{
			"PM_MasterFormGetBaseInfoReq",
			"PM_MasterFormGetBaseInfoRes",
			block = true
		},
		{
			"PM_MasterFormCommentReq",
			"PM_MasterFormCommentRes",
			block = true
		},
		{
			"PM_MasterFormNotifyCommnetRes"
		},
		{
			"PM_MasterFormNotifySubmitFormRes"
		},
		[255] = "MasterFormExtension"
	},
	[434] = {
		{
			"PM_CompetitionKingInfoReq",
			"PM_CompetitionKingInfoRes",
			block = true
		},
		{
			"PM_CompetitionKingGainPrizeReq",
			"PM_CompetitionKingGainPrizeRes",
			block = true
		},
		{
			"PM_CompetitionKingGetRankInfoReq",
			"PM_CompetitionKingGetRankInfoRes",
			block = true
		},
		[255] = "CompetitionKingExtension"
	},
	[435] = {
		{
			"PM_EnterGameLoadInfoReq",
			"PM_EnterGameLoadInfoResp",
			block = true
		},
		{
			"PM_LoadEverGainedCutePetRaceReq",
			"PM_LoadEverGainedCutePetRaceResp",
			block = true
		},
		{
			"PM_LoadCutePetInteractInfoReq",
			"PM_LoadCutePetInteractInfoResp",
			block = true
		},
		{
			"PM_OpenGardenLoadInfoReq",
			"PM_OpenGardenLoadInfoResp",
			block = true
		},
		{
			"PM_OpenGuestHouseLoadInfoReq",
			"PM_OpenGuestHouseLoadInfoResp",
			block = true
		},
		{
			"PM_LoadAdventureBuildingInfoReq",
			"PM_LoadAdventureBuildingInfoResp",
			block = true
		},
		{
			"PM_LoadCutePetCommunityNewsReq",
			"PM_LoadCutePetCommunityNewsResp",
			block = true
		},
		{
			"PM_LoadTravelInfoReq",
			"PM_LoadTravelInfoResp",
			block = true
		},
		{
			"PM_LoadBuddyTravelInfoReq",
			"PM_LoadBuddyTravelInfoResp",
			block = true
		},
		[255] = "CutePetGardenExtension",
		[20] = {
			"PM_CutePetLvlUpReq",
			"PM_CutePetLvlUpResp",
			block = true
		},
		[21] = {
			"PM_CutePetStarUpReq",
			"PM_CutePetStarUpResp",
			block = true
		},
		[22] = {
			"PM_CutePetQualityUpReq",
			"PM_CutePetQualityUpResp",
			block = true
		},
		[23] = {
			"PM_CutePetEquipOnPetReq",
			"PM_CutePetEquipOnPetResp",
			block = true
		},
		[24] = {
			"PM_CutePetUnloadFromPetReq",
			"PM_CutePetUnloadFromPetResp",
			block = true
		},
		[25] = {
			"PM_ReleaseCutePetReq",
			"PM_ReleaseCutePetResp",
			block = true
		},
		[26] = {
			"PM_CutePetRenameReq",
			"PM_CutePetRenameResp",
			block = true
		},
		[27] = {
			"PM_SetCutePetFollowStateReq",
			"PM_SetCutePetFollowStateResp",
			block = true
		},
		[28] = {
			"PM_SetCutePetGardenShowStateReq",
			"PM_SetCutePetGardenShowStateResp",
			block = true
		},
		[29] = {
			"PM_SetMyCurIllusionCutePetRaceReq",
			"PM_SetMyCurIllusionCutePetRaceResp",
			block = true
		},
		[30] = {
			"PM_HappinessInteractReq",
			"PM_HappinessInteractResp",
			block = true
		},
		[31] = {
			"PM_GainHappinessInteractPrizeReq",
			"PM_GainHappinessInteractPrizeResp",
			block = true
		},
		[32] = {
			"PM_LvlUpGardenReq",
			"PM_LvlUpGardenResp",
			block = true
		},
		[33] = {
			"PM_ViewGuestHouseSlotCutePetReq",
			"PM_ViewGuestHouseSlotCutePetResp",
			block = true
		},
		[34] = {
			"PM_GainOrFreeGuestHouseSlotCutePetReq",
			"PM_GainOrFreeGuestHouseSlotCutePetResp",
			block = true
		},
		[35] = {
			"PM_SpeedUpGuestHouseSlotReq",
			"PM_SpeedUpGuestHouseSlotResp",
			block = true
		},
		[36] = {
			"PM_LvlUpAdventureBuildingReq",
			"PM_LvlUpAdventureBuildingResp",
			block = true
		},
		[37] = {
			"PM_PutCutePet2AdventureBuildingReq",
			"PM_PutCutePet2AdventureBuildingResp",
			block = true
		},
		[38] = {
			"PM_TakeBackCutePetFromAdventureBuildingReq",
			"PM_TakeBackCutePetFromAdventureBuildingResp",
			block = true
		},
		[39] = {
			"PM_GainSingleBuildingOutputResReq",
			"PM_GainSingleBuildingOutputResResp",
			block = true
		},
		[40] = {
			"PM_GainAllBuildingOutputResReq",
			"PM_GainAllBuildingOutputResResp",
			block = true
		},
		[41] = {
			"PM_PublishCommunityNewsReq",
			"PM_PublishCommunityNewsResp",
			block = true
		},
		[42] = {
			"PM_CutePetTravelMySelfPairingReq",
			"PM_CutePetTravelMySelfPairingResp",
			block = true
		},
		[43] = {
			"PM_CutePetTravelInviteBuddyPairingReq",
			"PM_CutePetTravelInviteBuddyPairingResp",
			block = true
		},
		[44] = {
			"PM_CutePetTravelCancelBuddyPairingReq",
			"PM_CutePetTravelCancelBuddyPairingResp",
			block = true
		},
		[45] = {
			"PM_CutePetTravelReceiverHandleInviteMsgReq",
			"PM_CutePetTravelReceiverHandleInviteMsgResp",
			block = true
		},
		[46] = {
			"PM_CutePetTravelReceiverPutPairingCutePetReq",
			"PM_CutePetTravelReceiverPutPairingCutePetResp",
			block = true
		},
		[47] = {
			"PM_CutePetTravelInviterConfirmPairingReq",
			"PM_CutePetTravelInviterConfirmPairingResp",
			block = true
		},
		[48] = {
			"PM_UnLockIllusionCutePetRaceReq",
			"PM_UnLockIllusionCutePetRaceResp",
			block = true
		},
		[49] = {
			"PM_StrengthInitialPropReq",
			"PM_StrengthInitialPropResp",
			block = true
		},
		[50] = {
			"PM_SetCutePetLockStateReq",
			"PM_SetCutePetLockStateResp",
			block = true
		},
		[51] = {
			"PM_BatchGainGuestHouseSlotCutePetReq",
			"PM_BatchGainGuestHouseSlotCutePetResp",
			block = true
		},
		[52] = {
			"PM_CutePetTravelInfoReq",
			"PM_CutePetTravelInfoRes",
			block = true
		},
		[53] = {
			"PM_PresetCutePetInfoReq",
			"PM_PresetCutePetInfoRes",
			block = true
		},
		[54] = {
			"PM_AddPresetCuteReq",
			"PM_AddPresetCuteRes",
			block = true
		},
		[55] = {
			"PM_RemovePresetCutePetReq",
			"PM_RemovePresetCutePetRes",
			block = true
		},
		[56] = {
			"PM_SetPresetPublicReq",
			"PM_SetPresetPublicRes",
			block = true
		},
		[57] = {
			"PM_QuickPairingTravelReq",
			"PM_QuickPairingTravelRes",
			block = true
		},
		[58] = {
			"PM_CutePetChangeReadyToDiscardReq",
			"PM_CutePetChangeReadyToDiscardRes",
			block = true
		},
		[100] = {
			"PM_NotifyCutePetChangedResp"
		},
		[101] = {
			"PM_NotifyReceiveNewInvitePairingMsgResp"
		},
		[102] = {
			"PM_NotifyReceiverRespInviteMsgResp"
		},
		[103] = {
			"PM_NotifyReceiverHasReadyResp"
		},
		[104] = {
			"PM_NotifyCancelPairingResp"
		},
		[105] = {
			"PM_NotifyInviterConfirmPairingResp"
		},
		[106] = {
			"PM_NotifyCutePetIllusionChangedResp"
		},
		[107] = {
			"PM_NotifyCasterQuickPairingTravelResultRes"
		},
		[108] = {
			"PM_NotifyReceiverQuickPairingTravelResultRes"
		}
	},
	[438] = {
		{
			"PM_RebateMallPeriod1InfoReq",
			"PM_RebateMallPeriod1InfoRes",
			block = true
		},
		{
			"PM_RebateMallPeriod2InfoReq",
			"PM_RebateMallPeriod2InfoRes",
			block = true
		},
		{
			"PM_RebateMallGainPrizeReq",
			"PM_RebateMallGainPrizeRes",
			block = true
		},
		{
			"PM_RebateMallBuyReq",
			"PM_RebateMallBuyRes",
			block = true
		},
		[255] = "RebateMallExtension"
	},
	[439] = {
		{
			"PM_KMMChallengeGetCommonInfoReq",
			"PM_KMMChallengeGetCommonInfoRes",
			block = true
		},
		{
			"PM_KMMChallengeCommonChallengeReq",
			"PM_KMMChallengeCommonChallengeRes",
			block = true
		},
		{
			"PM_KMMChallengeGetSocrePrizeReq",
			"PM_KMMChallengeGetSocrePrizeRes",
			block = true
		},
		{
			"PM_KMMChallengeResetRandomInfoReq",
			"PM_KMMChallengeResetRandomInfoRes",
			block = true
		},
		{
			"PM_KMMChallengeGetExtremeInfoReq",
			"PM_KMMChallengeGetExtremeInfoRes",
			block = true
		},
		{
			"PM_KMMChallengeExtremeChallengeReq",
			"PM_KMMChallengeExtremeChallengeRes",
			block = true
		},
		{
			"PM_KMMChallengeResetGuardStageReq",
			"PM_KMMChallengeResetGuardStageRes",
			block = true
		},
		{
			"PM_KMMChallengeGainPassPrizeReq",
			"PM_KMMChallengeGainPassPrizeRes",
			block = true
		},
		[255] = "KingMengMengChallengeExtension",
		[10] = {
			"PM_KMMChallengeNotifyCommonChallengeRes"
		},
		[11] = {
			"PM_KMMChallengeNotifyExtremeChallengeRes"
		}
	},
	[440] = {
		{
			"PM_DuoLaGameInfoReq",
			"PM_DuoLaGameInfoRes",
			block = true
		},
		{
			"PM_DuoLaGameStartGameReq",
			"PM_DuoLaGameStartGameRes",
			block = true
		},
		{
			"PM_DuoLaGameEndGameReq",
			"PM_DuoLaGameEndGameRes",
			block = true
		},
		{
			"PM_DuoLaGameSweepReq",
			"PM_DuoLaGameSweepRes",
			block = true
		},
		[255] = "DuoLaGameExtension"
	},
	[441] = {
		{
			"PM_PlanetariumGameInfoReq",
			"PM_PlanetariumGameInfoRes",
			block = true
		},
		{
			"PM_PlanetariumGameStartGameReq",
			"PM_PlanetariumGameStartGameRes",
			block = true
		},
		{
			"PM_PlanetariumGameEndGameReq",
			"PM_PlanetariumGameEndGameRes",
			block = true
		},
		{
			"PM_PlanetariumGameGainPrizeReq",
			"PM_PlanetariumGameGainPrizeRes",
			block = true
		},
		[255] = "PlanetariumGameExtension"
	},
	[442] = {
		{
			"PM_AXMMGameGetInfoReq",
			"PM_AXMMGameGetInfoRes",
			block = true
		},
		{
			"PM_AXMMGameStartGameReq",
			"PM_AXMMGameStartGameRes",
			block = true
		},
		{
			"PM_AXMMGameEndGameReq",
			"PM_AXMMGameEndGameRes",
			block = true
		},
		{
			"PM_AXMMGameGetGamePrizeReq",
			"PM_AXMMGameGetGamePrizeRes",
			block = true
		},
		[255] = "AXMMGameExtension"
	},
	[443] = {
		{
			"PM_SeekFoodInfoReq",
			"PM_SeekFoodInfoRes",
			block = true
		},
		{
			"PM_SeekFoodDispatchReq",
			"PM_SeekFoodDispatchRes",
			block = true
		},
		{
			"PM_SeekFoodGainDispatchReq",
			"PM_SeekFoodGainDispatchRes",
			block = true
		},
		{
			"PM_SeekFoodFightBossReq",
			"PM_SeekFoodFightBossRes",
			block = true
		},
		{
			"PM_SeekFoodGainPrizeReq",
			"PM_SeekFoodGainPrizeRes",
			block = true
		},
		[255] = "SeekFoodExtension",
		[10] = {
			"PM_NotifySeekFoodFightBossEndRes"
		}
	},
	[444] = {
		{
			"PM_TC_QueryTeamsReq",
			"PM_TC_QueryTeamsRes",
			block = true
		},
		{
			"PM_TC_JoinTeamReq",
			"PM_TC_JoinTeamRes",
			block = true
		},
		{
			"PM_TC_QuickJoinReq",
			"PM_TC_QuickJoinRes",
			block = true
		},
		{
			"PM_TC_CreateTeamReq",
			"PM_TC_CreateTeamRes",
			block = true
		},
		[255] = "TrainCampQieCuoExtension",
		[6] = {
			"PM_TC_LeaveTeamReq",
			"PM_TC_LeaveTeamRes",
			block = true
		},
		[7] = {
			"PM_TC_ReadyReq",
			"PM_TC_ReadyRes",
			block = true
		},
		[8] = {
			"PM_TC_KickReq",
			"PM_TC_KickRes",
			block = true
		},
		[9] = {
			"PM_TC_ChatReq",
			"PM_TC_ChatRes",
			block = true
		},
		[14] = {
			"PM_TC_RefuseInviteReq",
			"PM_TC_RefuseInviteRes",
			block = true
		},
		[16] = {
			"PM_TC_SetDefenseFormReq",
			"PM_TC_SetDefenseFormRes",
			block = true
		},
		[17] = {
			"PM_TC_ReadyFightReq",
			"PM_TC_ReadyFightRes",
			block = true
		},
		[18] = {
			"PM_TC_LeaveGameReq",
			"PM_TC_LeaveGameRes",
			block = true
		},
		[19] = {
			"PM_TC_GetBattleRecordReq",
			"PM_TC_GetBattleRecordRes",
			block = true
		},
		[20] = {
			"PM_TC_GetBattleVideoReq",
			"PM_TC_GetBattleVideoRes",
			block = true
		},
		[21] = {
			"PM_TC_GetShareBattleResultReq",
			"PM_TC_GetShareBattleResultRes",
			block = true
		},
		[22] = {
			"PM_TC_FightSwitchInfoReq",
			"PM_TC_FightSwitchInfoRes",
			block = true
		},
		[23] = {
			"PM_TC_SetSwitchReq",
			"PM_TC_SetSwitchRes",
			block = true
		},
		[24] = {
			"PM_TC_CancelReadyReq",
			"PM_TC_CancelReadyRes",
			block = true
		},
		[50] = {
			"PM_TC_PveReq",
			"PM_TC_PveRes",
			block = true
		},
		[51] = {
			"PM_TC_NotifyPveRes"
		},
		[52] = {
			"PM_TC_ReformInReq",
			"PM_TC_ReformInRes",
			block = true
		},
		[80] = {
			"PM_TC_NotifyQueryTeamsRes"
		},
		[81] = {
			"PM_TC_NotifyQuickJoinRes"
		},
		[82] = {
			"PM_TC_NotifyJoinTeamRes"
		},
		[83] = {
			"PM_TC_NotifyCreateTeamRes"
		},
		[84] = {
			"PM_TC_NotifyTeamChangeRes"
		},
		[85] = {
			"PM_TC_NotifyBeInviteRes"
		},
		[86] = {
			"PM_TC_NotifyReadyRes"
		},
		[87] = {
			"PM_TC_NotifyBeKickRes"
		},
		[88] = {
			"PM_TC_NotifyChatRes"
		},
		[89] = {
			"PM_TC_NotifyRefuseInviteRes"
		},
		[90] = {
			"PM_TC_NotifyReadyFailRes"
		},
		[91] = {
			"PM_TC_NotifyCancelReadyRes"
		},
		[92] = {
			"PM_TC_NotifyBack2ReformRes"
		},
		[100] = {
			"PM_TC_NotifyTeamSucRes"
		},
		[101] = {
			"PM_TC_NotifyStartRes"
		},
		[102] = {
			"PM_TC_NotifyOpDefenseReadyRes"
		},
		[103] = {
			"PM_TC_NotifyChangeToAttackRes"
		},
		[104] = {
			"PM_TC_NotifyOpReadyFightRes"
		},
		[105] = {
			"PM_TC_NotifyGameResultRes"
		}
	},
	[445] = {
		{
			"PM_SummerHolidaysCheckInGetInfoReq",
			"PM_SummerHolidaysCheckInGetInfoRes",
			block = true
		},
		{
			"PM_SummerHolidaysCheckInStampReq",
			"PM_SummerHolidaysCheckInStampRes",
			block = true
		},
		{
			"PM_SummerHolidaysCheckInGainPrizeReq",
			"PM_SummerHolidaysCheckInGainPrizeRes",
			block = true
		},
		[255] = "SummerHolidaysCheckInExtension"
	},
	[446] = {
		{
			"PM_HolyDarkMMChallengeInfoReq",
			"PM_HolyDarkMMChallengeInfoRes",
			block = true
		},
		{
			"PM_HolyDarkMMChallengeReq",
			"PM_HolyDarkMMChallengeRes",
			block = true
		},
		{
			"PM_HolyDarkMMChallengeResetReq",
			"PM_HolyDarkMMChallengeResetRes",
			block = true
		},
		{
			"PM_HolyDarkMMChallengeUpgradeSignInBuffReq",
			"PM_HolyDarkMMChallengeUpgradeSignInBuffRes",
			block = true
		},
		[255] = "HolyDarkMMChallengeExtension",
		[10] = {
			"PM_NotifyHolyDarkMMChallengeEndRes"
		}
	},
	[447] = {
		{
			"PM_DreamPainterInfoReq",
			"PM_DreamPainterInfoRes",
			block = true
		},
		{
			"PM_DreamPainterVoteReq",
			"PM_DreamPainterVoteRes",
			block = true
		},
		[255] = "DreamPainterExtension"
	},
	[448] = {
		{
			"PM_WorldProgressPrizeGetInfoReq",
			"PM_WorldProgressPrizeGetInfoRes",
			block = true
		},
		{
			"PM_WorldProgressPrizeGainPrizeReq",
			"PM_WorldProgressPrizeGainPrizeRes",
			block = true
		},
		{
			"PM_WorldProgressOneClickGainPrizeReq",
			"PM_WorldProgressOneClickGainPrizeRes",
			block = true
		},
		[255] = "WorldProgressPrizeExtension"
	},
	[449] = {
		{
			"PM_ACInfoReq",
			"PM_ACInfoRes",
			block = true
		},
		{
			"PM_ACStartMatchReq",
			"PM_ACStartMatchRes",
			block = true
		},
		{
			"PM_ACCancelMatchReq",
			"PM_ACCancelMatchRes",
			block = true
		},
		{
			"PM_ACLeaveGameReq",
			"PM_ACLeaveGameRes",
			block = true
		},
		{
			"PM_ACSelectInitBuffReq",
			"PM_ACSelectInitBuffRes",
			block = true
		},
		{
			"PM_ACBuyPetReq",
			"PM_ACBuyPetRes",
			block = true
		},
		{
			"PM_ACRefreshShopReq",
			"PM_ACRefreshShopRes",
			block = true
		},
		{
			"PM_ACLockShopReq",
			"PM_ACLockShopRes",
			block = true
		},
		{
			"PM_ACSellPetReq",
			"PM_ACSellPetRes",
			block = true
		},
		{
			"PM_ACSetFormationReq",
			"PM_ACSetFormationRes",
			block = true
		},
		{
			"PM_ACSelectBuffReq",
			"PM_ACSelectBuffRes",
			block = true
		},
		{
			"PM_ACSelectFullStarBuffReq",
			"PM_ACSelectFullStarBuffRes",
			block = true
		},
		{
			"PM_ACGetBattleRecordReq",
			"PM_ACGetBattleRecordRes",
			block = true
		},
		{
			"PM_ACRankInfoReq",
			"PM_ACRankInfoRes",
			block = true
		},
		[255] = "AutoChessExtension",
		[101] = {
			"PM_ACNotifyMatchingOverTimeRes"
		},
		[102] = {
			"PM_ACNotifyMatchFailRes"
		},
		[103] = {
			"PM_ACNotifyGameStartRes"
		},
		[104] = {
			"PM_ACNotifyRefreshPetShopRes"
		},
		[105] = {
			"PM_ACNotifyAfterPetChangedRes"
		},
		[106] = {
			"PM_ACNotifyNextRoundRes"
		},
		[107] = {
			"PM_ACNotifySelectFullStarBuffRes"
		},
		[108] = {
			"PM_ACNotifyGameEndRes"
		},
		[109] = {
			"PM_ACNotifyResultCodeRes"
		},
		[110] = {
			"PM_ACNotifyInitBuffInfoChangedRes"
		},
		[111] = {
			"PM_ACNotifySelectedBuffRes"
		}
	},
	[450] = {
		{
			"PM_WeeklyGroupGetInfoReq",
			"PM_WeeklyGroupGetInfoRes",
			block = true
		},
		{
			"PM_WeeklyGroupGainPrizeReq",
			"PM_WeeklyGroupGainPrizeRes",
			block = true
		},
		{
			"PM_WeeklyGroupInviteReq",
			"PM_WeeklyGroupInviteRes",
			block = true
		},
		{
			"PM_WeeklyGroupJoinTeamReq",
			"PM_WeeklyGroupJoinTeamRes",
			block = true
		},
		{
			"PM_WeeklyGroupRankViewReq",
			"PM_WeeklyGroupRankViewRes",
			block = true
		},
		{
			"PM_WeeklyGroupGainPersonPrizeReq",
			"PM_WeeklyGroupGainPersonPrizeRes",
			block = true
		},
		[255] = "WeeklyGroupExtension",
		[10] = {
			"PM_NotifyIniviteMsgRes"
		},
		[11] = {
			"PM_NotifyNewTeamStateRes"
		}
	},
	[451] = {
		{
			"PM_TeshamuGetInfoReq",
			"PM_TeshamuGetInfoRes",
			block = true
		},
		{
			"PM_TeshamuChallengeReq",
			"PM_TeshamuChallengeRes",
			block = true
		},
		{
			"PM_TeshamuResetReq",
			"PM_TeshamuResetRes",
			block = true
		},
		{
			"PM_TeshamuNotifyChallengeResultRes",
			block = true
		},
		{
			"PM_TeshamuUpgradeSignInBuffReq",
			"PM_TeshamuUpgradeSignInBuffRes",
			block = true
		},
		[255] = "TeshamuChallengeExtension"
	},
	[452] = {
		{
			"PM_TunTianClgGetInfoReq",
			"PM_TunTianClgGetInfoRes",
			block = true
		},
		{
			"PM_TunTianNormalClgFightReq",
			"PM_TunTianNormalClgFightRes",
			block = true
		},
		{
			"PM_TunTianRefreshNormalClgMonsterReq",
			"PM_TunTianRefreshNormalClgMonsterRes",
			block = true
		},
		{
			"PM_TunTianGainNormalClgProgressPrizeReq",
			"PM_TunTianGainNormalClgProgressPrizeRes",
			block = true
		},
		{
			"PM_TunTianExtremeClgFightReq",
			"PM_TunTianExtremeClgFightRes",
			block = true
		},
		{
			"PM_TunTianExtremeClgUseNewStageScoreReq",
			"PM_TunTianExtremeClgUseNewStageScoreRes",
			block = true
		},
		{
			"PM_TunTianGainExtremeClgPrizeReq",
			"PM_TunTianGainExtremeClgPrizeRes",
			block = true
		},
		[255] = "TunTianChallengeExtension",
		[101] = {
			"PM_TunTianNotifyNormalClgFightResultRes"
		},
		[102] = {
			"PM_TunTianNotifyExtremeClgFightResultRes"
		}
	},
	[453] = {
		{
			"PM_TunTianHelpGetInfoReq",
			"PM_TunTianHelpGetInfoRes",
			block = true
		},
		{
			"PM_TunTianHelpLotteryReq",
			"PM_TunTianHelpLotteryRes",
			block = true
		},
		[255] = "TunTianHelpExtension"
	},
	[454] = {
		{
			"PM_PackDiscountGetInfoReq",
			"PM_PackDiscountGetInfoRes",
			block = true
		},
		{
			"PM_PackDiscountNotifyPaySucRes"
		},
		[255] = "PackDiscountExtension"
	},
	[455] = {
		{
			"PM_HolyWaterOrderInfoReq",
			"PM_HolyWaterOrderInfoRes",
			block = true
		},
		{
			"PM_HolyWaterOrderSelectPetsReq",
			"PM_HolyWaterOrderSelectPetsRes",
			block = true
		},
		{
			"PM_HolyWaterOrderChallengeReq",
			"PM_HolyWaterOrderChallengeRes",
			block = true
		},
		{
			"PM_HolyWaterOrderResetReq",
			"PM_HolyWaterOrderResetRes",
			block = true
		},
		{
			"PM_HolyWaterOrderConfirmRecordReq",
			"PM_HolyWaterOrderConfirmRecordRes",
			block = true
		},
		{
			"PM_HolyWaterOrderActivityRankReq",
			"PM_HolyWaterOrderActivityRankRes",
			block = true
		},
		{
			"PM_HolyWaterOrderDailyRankReq",
			"PM_HolyWaterOrderDailyRankRes",
			block = true
		},
		[255] = "HolyWaterOrderChallengeExtension",
		[101] = {
			"PM_HolyWaterOrderNotifyChallengeResultRes",
			block = true
		}
	},
	[456] = {
		{
			"PM_FanRuiClgGetInfoReq",
			"PM_FanRuiClgGetInfoRes",
			block = true
		},
		{
			"PM_FanRuiClgFightThemeLifeReq",
			"PM_FanRuiClgFightThemeLifeRes",
			block = true
		},
		{
			"PM_FanRuiClgFightThemeDestinyReq",
			"PM_FanRuiClgFightThemeDestinyRes",
			block = true
		},
		{
			"PM_FanRuiClgFightThemeControlReq",
			"PM_FanRuiClgFightThemeControlRes",
			block = true
		},
		{
			"PM_FanRuiClgResetThemeControlStageReq",
			"PM_FanRuiClgResetThemeControlStageRes",
			block = true
		},
		[255] = "FanRuiChallengeExtension",
		[101] = {
			"PM_FanRuiNotifyThemeLifeFightResultRes"
		},
		[102] = {
			"PM_FanRuiNotifyThemeDestinyFightResultRes"
		},
		[103] = {
			"PM_FanRuiNotifyThemeControlFightResultRes"
		}
	},
	[457] = {
		{
			"PM_NeverLandInfoReq",
			"PM_NeverLandInfoRes",
			block = true
		},
		{
			"PM_NeverLandChallengeReq",
			"PM_NeverLandChallengeRes",
			block = true
		},
		{
			"PM_NeverLandUpgradeBuffLvReq",
			"PM_NeverLandUpgradeBuffLvRes",
			block = true
		},
		{
			"PM_NeverLandGetRankReq",
			"PM_NeverLandGetRankRes",
			block = true
		},
		[255] = "NeverLandExtension",
		[101] = {
			"PM_NeverLandNotifyChallengeResultRes",
			block = true
		}
	},
	[458] = {
		{
			"PM_EternalDragonInfoReq",
			"PM_EternalDragonInfoRes",
			block = true
		},
		{
			"PM_EternalDragonWaterReq",
			"PM_EternalDragonWaterRes",
			block = true
		},
		{
			"PM_EternalDragonStartGameReq",
			"PM_EternalDragonStartGameRes",
			block = true
		},
		{
			"PM_EternalDragonEndGameReq",
			"PM_EternalDragonEndGameRes",
			block = true
		},
		{
			"PM_EternalDragonCuttingReq",
			"PM_EternalDragonCuttingRes",
			block = true
		},
		{
			"PM_EternalDragonGainPrizeReq",
			"PM_EternalDragonGainPrizeRes",
			block = true
		},
		[255] = "EternalDragonExtension"
	},
	[459] = {
		{
			"PM_EternalFarmInfoReq",
			"PM_EternalFarmInfoRes",
			block = true
		},
		{
			"PM_EternalFarmSowReq",
			"PM_EternalFarmSowRes",
			block = true
		},
		{
			"PM_EternalFarmHarvestReq",
			"PM_EternalFarmHarvestRes",
			block = true
		},
		{
			"PM_EternalFarmUseFertilizerReq",
			"PM_EternalFarmUseFertilizerRes",
			block = true
		},
		{
			"PM_EternalFarmGainTodayPrizeReq",
			"PM_EternalFarmGainTodayPrizeRes",
			block = true
		},
		{
			"PM_EternalFarmShopReq",
			"PM_EternalFarmShopRes",
			block = true
		},
		{
			"PM_EternalFarmGainPrizeReq",
			"PM_EternalFarmGainPrizeRes",
			block = true
		},
		{
			"PM_EternalFarmOneKeySowReq",
			"PM_EternalFarmOneKeySowRes",
			block = true
		},
		{
			"PM_EternalFarmOneKeySellReq",
			"PM_EternalFarmOneKeySellRes",
			block = true
		},
		[255] = "EternalFarmExtension"
	},
	[460] = {
		{
			"PM_EternalChallengeInfoReq",
			"PM_EternalChallengeInfoRes",
			block = true
		},
		{
			"PM_EternalChallengeBuyPetReq",
			"PM_EternalChallengeBuyPetRes",
			block = true
		},
		{
			"PM_EternalChallengeUpgradeBuffReq",
			"PM_EternalChallengeUpgradeBuffRes",
			block = true
		},
		{
			"PM_EternalChallengeFightReq",
			"PM_EternalChallengeFightRes",
			block = true
		},
		[255] = "EternalChallengeExtension",
		[10] = {
			"PM_NotifyEternalChallengeFightEndRes"
		}
	},
	[461] = {
		{
			"PM_PurchaseLimitInfoReq",
			"PM_PurchaseLimitInfoRes",
			block = true
		},
		{
			"PM_PurchaseLimitBuyReq",
			"PM_PurchaseLimitBuyRes",
			block = true
		},
		[255] = "PurchaseLimitExtension"
	},
	[462] = {
		{
			"PM_FanRuiLotteryGetInfoReq",
			"PM_FanRuiLotteryGetInfoRes",
			block = true
		},
		{
			"PM_FanRuiLotteryLotteryReq",
			"PM_FanRuiLotteryLotteryRes",
			block = true
		},
		{
			"PM_FanRuiLotteryStartGameReq",
			"PM_FanRuiLotteryStartGameRes",
			block = true
		},
		{
			"PM_FanRuiLotteryEndGameReq",
			"PM_FanRuiLotteryEndGameRes",
			block = true
		},
		{
			"PM_FanRuiLotteryExchangeReq",
			"PM_FanRuiLotteryExchangeRes",
			block = true
		},
		{
			"PM_FanRuiLotteryExitGameReq",
			"PM_FanRuiLotteryExitGameRes",
			block = true
		},
		[255] = "FanRuiLotteryExtension"
	},
	[463] = {
		{
			"PM_DragonPoolGetInfoReq",
			"PM_DragonPoolGetInfoRes",
			block = true
		},
		{
			"PM_DragonPoolTouchReq",
			"PM_DragonPoolTouchRes",
			block = true
		},
		{
			"PM_DragonPoolChatReq",
			"PM_DragonPoolChatRes",
			block = true
		},
		{
			"PM_DragonPoolWeedReq",
			"PM_DragonPoolWeedRes",
			block = true
		},
		{
			"PM_DragonPoolGainPrizeReq",
			"PM_DragonPoolGainPrizeRes",
			block = true
		},
		{
			"PM_DragonPoolNextEggReq",
			"PM_DragonPoolNextEggRes",
			block = true
		},
		[255] = "DragonPoolExtension"
	},
	[464] = {
		{
			"PM_DF_GetMyFormReq",
			"PM_DF_GetMyFormRes",
			block = true
		},
		{
			"PM_DF_SaveFormReq",
			"PM_DF_SaveFormRes",
			block = true
		},
		{
			"PM_DF_RefreshFormListReq",
			"PM_DF_RefreshFormListRes",
			block = true
		},
		{
			"PM_DF_GetOtherFormReq",
			"PM_DF_GetOtherFormRes",
			block = true
		},
		{
			"PM_DF_ChallengeReq",
			"PM_DF_ChallengeRes",
			block = true
		},
		[255] = "TrainCampDefenseFormExtension",
		[101] = {
			"PM_DF_NotifyChallengeResultRes",
			block = true
		}
	},
	[465] = {
		{
			"PM_EHolyDragonClgGetInfoReq",
			"PM_EHolyDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_EHolyDragonClgForwardReq",
			"PM_EHolyDragonClgForwardRes",
			block = true
		},
		{
			"PM_EHolyDragonClgFightRiverMonsterReq",
			"PM_EHolyDragonClgFightRiverMonsterRes",
			block = true
		},
		{
			"PM_EHolyDragonClgFightLandMonsterReq",
			"PM_EHolyDragonClgFightLandMonsterRes",
			block = true
		},
		{
			"PM_EHolyDragonClgUseItemOnLandReq",
			"PM_EHolyDragonClgUseItemOnLandRes",
			block = true
		},
		{
			"PM_EHolyDragonClgResetStageReq",
			"PM_EHolyDragonClgResetStageRes",
			block = true
		},
		[255] = "EternalHolyDragonChallengeExtension",
		[101] = {
			"PM_EHolyDragonClgNotifyFightRiverMonsterRes"
		},
		[102] = {
			"PM_EHolyDragonClgNotifyFightLandMonsterRes"
		}
	},
	[466] = {
		{
			"PM_DivineCiYuanGetInfoReq",
			"PM_DivineCiYuanGetInfoRes",
			block = true
		},
		{
			"PM_DivineCiYuanGainPrizeReq",
			"PM_DivineCiYuanGainPrizeRes",
			block = true
		},
		{
			"PM_DivineCiYuanGainSelectBuffReq",
			"PM_DivineCiYuanGainSelectBuffRes",
			block = true
		},
		{
			"PM_DivineCiYuanExtremeChallengeReq",
			"PM_DivineCiYuanExtremeChallengeRes",
			block = true
		},
		{
			"PM_DivineCiYuanExtremeResetReq",
			"PM_DivineCiYuanExtremeResetRes",
			block = true
		},
		{
			"PM_DivineCiYuanUniversalChallengeReq",
			"PM_DivineCiYuanUniversalChallengeRes",
			block = true
		},
		{
			"PM_DivineCiYuanUniversalOneKeyPassReq",
			"PM_DivineCiYuanUniversalOneKeyPassRes",
			block = true
		},
		{
			"PM_DivineCiYuanUniversalSignInReq",
			"PM_DivineCiYuanUniversalSignInRes",
			block = true
		},
		{
			"PM_DivineCiYuanUniversalOneKeySignInReq",
			"PM_DivineCiYuanUniversalOneKeySignInRes",
			block = true
		},
		[255] = "DivineCiYuanChallengeExtension",
		[100] = {
			"PM_Notify_DivineCiYuanExtremeChallengeRes"
		},
		[101] = {
			"PM_Notify_DivineCiYuanUniversalChallengeRes"
		}
	},
	[467] = {
		{
			"PM_LinkGameInfoReq",
			"PM_LinkGameInfoRes",
			block = true
		},
		{
			"PM_LinkGameStartGameReq",
			"PM_LinkGameStartGameRes",
			block = true
		},
		{
			"PM_LinkGameEndGameReq",
			"PM_LinkGameEndGameRes",
			block = true
		},
		{
			"PM_LinkGameRankReq",
			"PM_LinkGameRankRes",
			block = true
		},
		[255] = "LinkGameExtension"
	},
	[468] = {
		{
			"PM_KunLunCommonClgInfoReq",
			"PM_KunLunCommonClgInfoRes",
			block = true
		},
		{
			"PM_KunLunCommonClgFightReq",
			"PM_KunLunCommonClgFightRes",
			block = true
		},
		{
			"PM_KunLunExtremeClgInfoReq",
			"PM_KunLunExtremeClgInfoRes",
			block = true
		},
		{
			"PM_KunLunExtremeClgSetCardReq",
			"PM_KunLunExtremeClgSetCardRes",
			block = true
		},
		{
			"PM_KunLunExtremeClgResetStageReq",
			"PM_KunLunExtremeClgResetStageRes",
			block = true
		},
		{
			"PM_KunLunExtremeClgFightReq",
			"PM_KunLunExtremeClgFightRes",
			block = true
		},
		[255] = "KunLunChallengeExtension",
		[11] = {
			"PM_NotifyKunLunCommonClgFightEndRes"
		},
		[12] = {
			"PM_NotifyKunLunExtremeClgFightEndRes"
		}
	},
	[469] = {
		{
			"PM_WaterTianYanGetInfoReq",
			"PM_WaterTianYanGetInfoRes",
			block = true
		},
		{
			"PM_WaterTianYanUpgradeBuffReq",
			"PM_WaterTianYanUpgradeBuffRes",
			block = true
		},
		{
			"PM_WaterTianYanBuildingStageChallengeReq",
			"PM_WaterTianYanBuildingStageChallengeRes",
			block = true
		},
		{
			"PM_WaterTianYanRefreshBuildingStageListReq",
			"PM_WaterTianYanRefreshBuildingStageListRes",
			block = true
		},
		{
			"PM_WaterTianYanMainStageChallengeReq",
			"PM_WaterTianYanMainStageChallengeRes",
			block = true
		},
		{
			"PM_WaterTianYanResetMainStageReq",
			"PM_WaterTianYanResetMainStageRes",
			block = true
		},
		[255] = "WaterTianYanExtension",
		[100] = {
			"PM_Notify_WaterTianYanBuildingStageChallengeRes"
		},
		[101] = {
			"PM_Notify_WaterTianYanMainStageChallengeRes"
		}
	},
	[470] = {
		{
			"PM_CiYuanHolyDragonClgGetInfoReq",
			"PM_CiYuanHolyDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_CiYuanHolyDragonClgFightReq",
			"PM_CiYuanHolyDragonClgFightRes",
			block = true
		},
		{
			"PM_CiYuanHolyDragonClgGetHistoryRankReq",
			"PM_CiYuanHolyDragonClgGetHistoryRankRes",
			block = true
		},
		{
			"PM_CiYuanHolyDragonClgGetDailyRankReq",
			"PM_CiYuanHolyDragonClgGetDailyRankRes",
			block = true
		},
		[255] = "CiYuanHolyDragonClgExtension",
		[101] = {
			"PM_CiYuanHolyDragonClgNotifyFightResultRes"
		}
	},
	[471] = {
		{
			"PM_GuessLanternGetInfoReq",
			"PM_GuessLanternGetInfoRes",
			block = true
		},
		{
			"PM_GuessLanternIncProgressReq",
			"PM_GuessLanternIncProgressRes",
			block = true
		},
		{
			"PM_GuessLanternGainPrizeReq",
			"PM_GuessLanternGainPrizeRes",
			block = true
		},
		[255] = "GuessLanternExtension"
	},
	[472] = {
		{
			"PM_KingJiChallengeGetInfoReq",
			"PM_KingJiChallengeGetInfoRes",
			block = true
		},
		{
			"PM_KingJiChallengeChallengeReq",
			"PM_KingJiChallengeChallengeRes",
			block = true
		},
		{
			"PM_KingJiChallengeGainPrizeReq",
			"PM_KingJiChallengeGainPrizeRes",
			block = true
		},
		{
			"PM_KingJiChallengeResetReq",
			"PM_KingJiChallengeResetRes",
			block = true
		},
		{
			"PM_KingJiChallengeSaveResultReq",
			"PM_KingJiChallengeSaveResultRes",
			block = true
		},
		[255] = "KingJiChallengeExtension",
		[10] = {
			"PM_KingJiChallengeNotifyChallengeRes"
		}
	},
	[473] = {
		{
			"PM_TourArenaGameInfoReq",
			"PM_TourArenaGameInfoRes",
			block = true
		},
		{
			"PM_TourArenaGameStartGameReq",
			"PM_TourArenaGameStartGameRes",
			block = true
		},
		{
			"PM_TourArenaGameEndGameReq",
			"PM_TourArenaGameEndGameRes",
			block = true
		},
		{
			"PM_TourArenaGameGainPrizeReq",
			"PM_TourArenaGameGainPrizeRes",
			block = true
		},
		{
			"PM_TourArenaGameTotalRankReq",
			"PM_TourArenaGameTotalRankRes",
			block = true
		},
		{
			"PM_TourArenaGameRankReq",
			"PM_TourArenaGameRankRes",
			block = true
		},
		{
			"PM_TourArenaFightInfoReq",
			"PM_TourArenaFightInfoRes",
			block = true
		},
		{
			"PM_TourArenaFightGainPrizeReq",
			"PM_TourArenaFightGainPrizeRes",
			block = true
		},
		{
			"PM_TourArenaFightTotalRankReq",
			"PM_TourArenaFightTotalRankRes",
			block = true
		},
		{
			"PM_TourArenaFightGainPeriodPrizeReq",
			"PM_TourArenaFightGainPeriodPrizeRes",
			block = true
		},
		{
			"PM_TourArenaPeriodRankReq",
			"PM_TourArenaPeriodRankRes",
			block = true
		},
		{
			"PM_TourArenaZoneInfoReq",
			"PM_TourArenaZoneInfoRes",
			block = true
		},
		{
			"PM_TourArenaZoneBindingReq",
			"PM_TourArenaZoneBindingRes",
			block = true
		},
		{
			"PM_TourArenaZoneSelectBindingReq",
			"PM_TourArenaZoneSelectBindingRes",
			block = true
		},
		{
			"PM_TourArenaGameStageInfoReq",
			"PM_TourArenaGameStageInfoRes",
			block = true
		},
		[255] = "TourArenaExtension"
	},
	[474] = {
		{
			"PM_RCQualityConvertReq",
			"PM_RCQualityConvertRes",
			block = true
		},
		{
			"PM_RCDefineConvertReq",
			"PM_RCDefineConvertRes",
			block = true
		},
		{
			"PM_ResourceConvertGetInfoReq",
			"PM_ResourceConvertGetInfoRes",
			block = true
		},
		[255] = "ResourceConversionExtension"
	},
	[475] = {
		{
			"PM_EleSparkGetRegisterInfoReq",
			"PM_EleSparkGetRegisterInfoRes",
			block = true
		},
		{
			"PM_EleSparkRegisterReq",
			"PM_EleSparkRegisterRes",
			block = true
		},
		{
			"PM_EleSparkGetInfoReq",
			"PM_EleSparkGetInfoRes",
			block = true
		},
		{
			"PM_EleSparkGetMyFormsReq",
			"PM_EleSparkGetMyFormsRes",
			block = true
		},
		{
			"PM_EleSparkSetMyFormsReq",
			"PM_EleSparkSetMyFormsRes",
			block = true
		},
		[255] = "ElementSparkExtension",
		[20] = {
			"PM_EleSparkGetOtherGuardInfoReq",
			"PM_EleSparkGetOtherGuardInfoRes",
			block = true
		},
		[21] = {
			"PM_EleSparkGetMyGuardInfoReq",
			"PM_EleSparkGetMyGuardInfoRes",
			block = true
		},
		[22] = {
			"PM_EleSparkUpgradeGuardReq",
			"PM_EleSparkUpgradeGuardRes",
			block = true
		},
		[23] = {
			"PM_EleSparkSendGuardDefenseFormReq",
			"PM_EleSparkSendGuardDefenseFormRes",
			block = true
		},
		[24] = {
			"PM_EleSparkGetGuardRecordReq",
			"PM_EleSparkGetGuardRecordRes",
			block = true
		},
		[25] = {
			"PM_EleSparkChallengeDefenseFormReq",
			"PM_EleSparkChallengeDefenseFormRes",
			block = true
		},
		[26] = {
			"PM_EleSparkChallengeBossReq",
			"PM_EleSparkChallengeBossRes",
			block = true
		},
		[27] = {
			"PM_EleSparkRevokeDefenseFormReq",
			"PM_EleSparkRevokeDefenseFormRes",
			block = true
		},
		[40] = {
			"PM_EleSparkGetSparkInfoReq",
			"PM_EleSparkGetSparkInfoRes",
			block = true
		},
		[41] = {
			"PM_EleSparkBuyPetReq",
			"PM_EleSparkBuyPetRes",
			block = true
		},
		[42] = {
			"PM_EleSparkRefreshMapInfoReq",
			"PM_EleSparkRefreshMapInfoRes",
			block = true
		},
		[61] = {
			"PM_EleSparkGetCampInfoReq",
			"PM_EleSparkGetCampInfoRes",
			block = true
		},
		[62] = {
			"PM_EleSparkAddTagReq",
			"PM_EleSparkAddTagRes",
			block = true
		},
		[63] = {
			"PM_EleSparkModifyTagReq",
			"PM_EleSparkModifyTagRes",
			block = true
		},
		[64] = {
			"PM_EleSparkModifyBoardReq",
			"PM_EleSparkModifyBoardRes",
			block = true
		},
		[65] = {
			"PM_EleSparkModifyMinDefenseFormZdlReq",
			"PM_EleSparkModifyMinDefenseFormZdlRes",
			block = true
		},
		[66] = {
			"PM_EleSparkPublishCommandReq",
			"PM_EleSparkPublishCommandRes",
			block = true
		},
		[67] = {
			"PM_EleSparkGetCampRankReq",
			"PM_EleSparkGetCampRankRes",
			block = true
		},
		[68] = {
			"PM_EleSparkGetPersonRankReq",
			"PM_EleSparkGetPersonRankRes",
			block = true
		},
		[69] = {
			"PM_EleSparkGetResourceInfoReq",
			"PM_EleSparkGetResourceInfoRes",
			block = true
		},
		[70] = {
			"PM_EleSparkGainResourceReq",
			"PM_EleSparkGainResourceRes",
			block = true
		},
		[71] = {
			"PM_EleSparkExitReq",
			"PM_EleSparkExitRes",
			block = true
		},
		[101] = {
			"PM_EleSparkNotifyGuardInfoChangeRes"
		},
		[102] = {
			"PM_EleSparkNotifyMapInfoChangeRes"
		},
		[103] = {
			"PM_EleSparkNotifyCommanderChangeRes"
		}
	},
	[476] = {
		{
			"PM_ShenJiChallengeGetInfoReq",
			"PM_ShenJiChallengeGetInfoRes",
			block = true
		},
		{
			"PM_ShenJiChallengeSelectClgReq",
			"PM_ShenJiChallengeSelectClgRes",
			block = true
		},
		{
			"PM_ShenJiChallengeBossClgReq",
			"PM_ShenJiChallengeBossClgRes",
			block = true
		},
		{
			"PM_ShenJiChallengeResetBossStageReq",
			"PM_ShenJiChallengeResetBossStageRes",
			block = true
		},
		{
			"PM_ShenJiChallengeGainPrizeReq",
			"PM_ShenJiChallengeGainPrizeRes",
			block = true
		},
		[255] = "ShenJiChallengeExtension",
		[10] = {
			"PM_KingJiChallengeNotifySelectClgRes"
		},
		[11] = {
			"PM_KingJiChallengeNotifyBossClgRes"
		}
	},
	[477] = {
		{
			"PM_FanTianClgGetInfoReq",
			"PM_FanTianClgGetInfoRes",
			block = true
		},
		{
			"PM_FanTianClgFightReq",
			"PM_FanTianClgFightRes",
			block = true
		},
		{
			"PM_FanTianClgGainProgressPrizeReq",
			"PM_FanTianClgGainProgressPrizeRes",
			block = true
		},
		[255] = "FanTianChallengeExtension",
		[101] = {
			"PM_FanTianClgNotifyFightResultRes"
		}
	},
	[478] = {
		{
			"PM_DivineKingDragonGetInfoReq",
			"PM_DivineKingDragonGetInfoRes",
			block = true
		},
		{
			"PM_DivineKingDragonChallengeReq",
			"PM_DivineKingDragonChallengeRes",
			block = true
		},
		{
			"PM_DivineKingDragonGainPrizeReq",
			"PM_DivineKingDragonGainPrizeRes",
			block = true
		},
		{
			"PM_DivineKingDragonResetReq",
			"PM_DivineKingDragonResetRes",
			block = true
		},
		[255] = "DivineKingDragonExtension",
		[10] = {
			"PM_DivineKingDragonNotifyChallengeRes"
		}
	},
	[479] = {
		{
			"PM_DragonKingClgGetInfoReq",
			"PM_DragonKingClgGetInfoRes",
			block = true
		},
		{
			"PM_DragonKingClgFightReq",
			"PM_DragonKingClgFightRes",
			block = true
		},
		{
			"PM_DragonKingClgGainProgressPrizeReq",
			"PM_DragonKingClgGainProgressPrizeRes",
			block = true
		},
		{
			"PM_DragonKingClgGetRankReq",
			"PM_DragonKingClgGetRankRes"
		},
		[255] = "DragonKingChallengeExtension",
		[101] = {
			"PM_DragonKingClgNotifyFightResultRes"
		}
	},
	[480] = {
		[255] = "SeasonModePveTeamExtension",
		[101] = {
			"PM_GetSMPVEAllTeamInfoReq",
			"PM_GetSMPVEAllTeamInfoRes",
			block = true
		},
		[102] = {
			"PM_GetSMPVECommonPetPackageReq",
			"PM_GetSMPVECommonPetPackageRes",
			block = true
		},
		[103] = {
			"PM_SaveSMPSinglePetPackageReq",
			"PM_SaveSMPSinglePetPackageRes",
			block = true
		},
		[104] = {
			"PM_ResetSMPVEAllTeamInfoReq",
			"PM_ResetSMPVEAllTeamInfoRes",
			block = true
		},
		[105] = {
			"PM_SaveSMPVESingleTeamFormReq",
			"PM_SaveSMPVESingleTeamFormRes",
			block = true
		},
		[106] = {
			"PM_SaveSMPVESingleTeamFormSummonInfoReq",
			"PM_SaveSMPVESingleTeamFormSummonInfoRes",
			block = true
		},
		[107] = {
			"PM_BuySMPVEPackageTimesReq",
			"PM_BuySMPVEPackageTimesRes",
			block = true
		},
		[109] = {
			"PM_GetSMPVESingleTeamHolyStripesInfoReq",
			"PM_GetSMPVESingleTeamHolyStripesInfoRes",
			block = true
		},
		[110] = {
			"PM_ChangeSMPVESinglePetHolyStripesInfoReq",
			"PM_ChangeSMPVESinglePetHolyStripesInfoRes",
			block = true
		},
		[111] = {
			"PM_GetSMPVEAllTeamHolyStripesInfoReq",
			"PM_GetSMPVEAllTeamHolyStripesInfoRes",
			block = true
		},
		[112] = {
			"PM_SMPVENotifyTeamZdlChangedRes"
		},
		[113] = {
			"PM_SMPVEPetChangeTipInfoReq",
			"PM_SMPVEPetChangeTipInfoRes",
			block = true
		},
		[114] = {
			"PM_NotifySMPVEUnlockTeamRes"
		},
		[115] = {
			"PM_NotifyTeamHeadRaceIdChanged"
		}
	},
	[481] = {
		{
			"PM_DivineNuoYaClgGetInfoReq",
			"PM_DivineNuoYaClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineNuoYaClgNormalFightReq",
			"PM_DivineNuoYaClgNormalFightRes",
			block = true
		},
		{
			"PM_DivineNuoYaClgSignInGainBuffReq",
			"PM_DivineNuoYaClgSignInGainBuffRes",
			block = true
		},
		{
			"PM_DivineNuoYaClgGainNormalPrizeReq",
			"PM_DivineNuoYaClgGainNormalPrizeRes",
			block = true
		},
		{
			"PM_DivineNuoYaClgSelectPetsReq",
			"PM_DivineNuoYaClgSelectPetsRes",
			block = true
		},
		{
			"PM_DivineNuoYaClgExtremeFightReq",
			"PM_DivineNuoYaClgExtremeFightRes",
			block = true
		},
		{
			"PM_DivineNuoYaClgGainExtremePrizeReq",
			"PM_DivineNuoYaClgGainExtremePrizeRes",
			block = true
		},
		{
			"PM_DivineNuoYaExtremeClgResetStageReq",
			"PM_DivineNuoYaExtremeClgResetStageRes",
			block = true
		},
		[255] = "DivineNuoYaChallengeExtension",
		[101] = {
			"PM_DivineNuoYaClgNotifyNormalFightResultRes"
		},
		[102] = {
			"PM_DivineNuoYaClgNotifyExtremeFightResultRes"
		}
	},
	[482] = {
		{
			"PM_WuDiClgGetInfoReq",
			"PM_WuDiClgGetInfoRes",
			block = true
		},
		{
			"PM_WuDiClgExtremeFightReq",
			"PM_WuDiClgExtremeFightRes",
			block = true
		},
		{
			"PM_WuDiClgExtremeFightConfirmReq",
			"PM_WuDiClgExtremeFightConfirmRes",
			block = true
		},
		{
			"PM_WuDiClgResetExtremeClgReq",
			"PM_WuDiClgResetExtremeClgRes",
			block = true
		},
		{
			"PM_WuDiClgGainExtremePrizeReq",
			"PM_WuDiClgGainExtremePrizeRes",
			block = true
		},
		{
			"PM_WuDiClgNormalFightReq",
			"PM_WuDiClgNormalFightRes",
			block = true
		},
		{
			"PM_WuDiClgGainNormalProgressPrizeReq",
			"PM_WuDiClgGainNormalProgressPrizeRes",
			block = true
		},
		[255] = "WuDiChallengeExtension",
		[101] = {
			"PM_WuDiClgNotifyExtremeFightResultRes"
		},
		[102] = {
			"PM_WuDiClgNotifyNormalFightResultRes"
		}
	},
	[483] = {
		{
			"GB_GiftBoxGetInfoReq",
			"GB_GiftBoxGetInfoRes",
			block = true
		},
		{
			"GB_GiftBoxOpenBoxReq",
			"GB_GiftBoxOpenBoxRes",
			block = true
		},
		{
			"GB_GiftBoxShareLuckReq",
			"GB_GiftBoxShareLuckRes",
			block = true
		},
		{
			"GB_GiftBoxGainLuckReq",
			"GB_GiftBoxGainLuckRes",
			block = true
		},
		{
			"GB_GiftBoxShareListReq",
			"GB_GiftBoxShareListRes",
			block = true
		},
		{
			"GB_GiftBoxGainSharePrizeReq",
			"GB_GiftBoxGainSharePrizeRes",
			block = true
		},
		[255] = "GiftBoxExtension"
	},
	[485] = {
		{
			"PM_2048InfoReq",
			"PM_2048InfoRes",
			block = true
		},
		{
			"PM_2048StartGameReq",
			"PM_2048StartGameRes",
			block = true
		},
		{
			"PM_2048EndGameReq",
			"PM_2048EndGameRes",
			block = true
		},
		{
			"PM_2048EndRankReq",
			"PM_2048EndRankRes",
			block = true
		},
		{
			"PM_2048OpenHangingEfficiencyReq",
			"PM_2048OpenHangingEfficiencyRes",
			block = true
		},
		{
			"PM_2048ExtremeGainPrizeReq",
			"PM_2048ExtremeGainPrizeRes",
			block = true
		},
		{
			"PM_2048ExtremeRankReq",
			"PM_2048ExtremeRankRes"
		},
		[255] = "Game2048Extension"
	},
	[486] = {
		{
			"PM_KingNuoYaChallengeInfoReq",
			"PM_KingNuoYaChallengeInfoRes",
			block = true
		},
		{
			"PM_KingNuoYaChallengeReq",
			"PM_KingNuoYaChallengeRes",
			block = true
		},
		[255] = "KingNuoYaChallengeExtension",
		[10] = {
			"PM_NotifyKingNuoYaChallengeFinishRes"
		}
	},
	[487] = {
		{
			"PM_DestroyEvilGetInfoReq",
			"PM_DestroyEvilGetInfoRes",
			block = true
		},
		{
			"PM_DestroyEvilChallengeReq",
			"PM_DestroyEvilChallengeRes",
			block = true
		},
		{
			"PM_DestroyEvilRefreshMonsterReq",
			"PM_DestroyEvilRefreshMonsterRes",
			block = true
		},
		{
			"PM_DestroyEvilGetReportInfoReq",
			"PM_DestroyEvilGetReportInfoRes",
			block = true
		},
		{
			"PM_DestroyEvilConveneBuddyReq",
			"PM_DestroyEvilConveneBuddyRes",
			block = true
		},
		{
			"PM_DestroyEvilViewBuddyScoreReq",
			"PM_DestroyEvilViewBuddyScoreRes",
			block = true
		},
		{
			"PM_DestroyEvilGainBuddyPrizeReq",
			"PM_DestroyEvilGainBuddyPrizeRes",
			block = true
		},
		[255] = "DestroyEvilExtension",
		[9] = {
			"PM_DestroyEvilBuyTicketReq",
			"PM_DestroyEvilBuyTicketRes",
			block = true
		},
		[10] = {
			"PM_DestroyEvilGetRecommendListReq",
			"PM_DestroyEvilGetRecommendListRes",
			block = true
		},
		[11] = {
			"PM_DestroyEvilSetPublicBossReq",
			"PM_DestroyEvilSetPublicBossRes",
			block = true
		},
		[12] = {
			"PM_DestroyEvilBuyStrengthReq",
			"PM_DestroyEvilBuyStrengthRes",
			block = true
		},
		[13] = {
			"PM_DestroyEvilSelectDifficultyReq",
			"PM_DestroyEvilSelectDifficultyRes",
			block = true
		},
		[15] = {
			"PM_DestroyEvilViewHelpRankReq",
			"PM_DestroyEvilViewHelpRankRes",
			block = true
		}
	},
	[488] = {
		{
			"PM_TimeGateInfoReq",
			"PM_TimeGateInfoRes",
			block = true
		},
		{
			"PM_TimeGateSelectOpenReq",
			"PM_TimeGateSelectOpenRes",
			block = true
		},
		[255] = "TimeGateExtension"
	},
	[489] = {
		{
			"PM_DragonXiuerGetInfoReq",
			"PM_DragonXiuerGetInfoRes",
			block = true
		},
		{
			"PM_DragonXiuerChallengeDestroyModeReq",
			"PM_DragonXiuerChallengeDestroyModeRes",
			block = true
		},
		{
			"PM_DragonXiuerResetDestroyModeTeamReq",
			"PM_DragonXiuerResetDestroyModeTeamRes",
			block = true
		},
		{
			"PM_DragonXiuerChallengeSoulModeReq",
			"PM_DragonXiuerChallengeSoulModeRes",
			block = true
		},
		[255] = "DragonXiuerExtension",
		[100] = {
			"PM_Notify_DragonXiuerDestroyModeRes"
		},
		[101] = {
			"PM_Notify_DragonXiuerSoulModeRes"
		}
	},
	[490] = {
		{
			"PM_GetScopePlusConsumeInfoReq",
			"PM_GetScopePlusConsumeInfoRes",
			block = true
		},
		{
			"PM_ScopeConsumePlusGainGiftReq",
			"PM_ScopeConsumePlusGainGiftRes",
			block = true
		},
		{
			"PM_ScopeConsumePlusGainSignPrizeReq",
			"PM_ScopeConsumePlusGainSignPrizeRes",
			block = true
		},
		[255] = "ScopeConsumePlusExtension"
	},
	[491] = {
		{
			"PM_PinGameInfoReq",
			"PM_PinGameInfoRes",
			block = true
		},
		{
			"PM_PinGameStartGameReq",
			"PM_PinGameStartGameRes",
			block = true
		},
		{
			"PM_PinGameEndGameReq",
			"PM_PinGameEndGameRes",
			block = true
		},
		{
			"PM_PinGameRecoverReq",
			"PM_PinGameRecoverRes",
			block = true
		},
		{
			"PM_PinGameGainPrizeReq",
			"PM_PinGameGainPrizeRes",
			block = true
		},
		{
			"PM_PinGameSweepReq",
			"PM_PinGameSweepRes",
			block = true
		},
		[255] = "PinGameExtension"
	},
	[492] = {
		{
			"PM_NewYearPrayGetInfoReq",
			"PM_NewYearPrayGetInfoRes",
			block = true
		},
		{
			"PM_NewYearPrayDoPrayReq",
			"PM_NewYearPrayDoPrayRes",
			block = true
		},
		{
			"PM_NewYearPrayGainProgressPrizeReq",
			"PM_NewYearPrayGainProgressPrizeRes",
			block = true
		},
		[255] = "NewYearPrayExtension"
	},
	[493] = {
		{
			"PM_HitBossGetInfoReq",
			"PM_HitBossGetInfoRes",
			block = true
		},
		{
			"PM_HitBossFightReq",
			"PM_HitBossFightRes",
			block = true
		},
		{
			"PM_HitBossGainPrizeReq",
			"PM_HitBossGainPrizeRes",
			block = true
		},
		{
			"PM_HitBossGetRankInfoReq",
			"PM_HitBossGetRankInfoRes",
			block = true
		},
		[255] = "HitBossExtension",
		[100] = {
			"PM_Notify_HitbossFightRes"
		}
	},
	[494] = {
		{
			"PM_WishTreeBottleInfoReq",
			"PM_WishTreeBottleInfoRes",
			block = true
		},
		{
			"PM_WishTreeBottleViewReq",
			"PM_WishTreeBottleViewRes",
			block = true
		},
		{
			"PM_WishTreeBottleLikeReq",
			"PM_WishTreeBottleLikeRes",
			block = true
		},
		{
			"PM_WishTreeBottleSendReq",
			"PM_WishTreeBottleSendRes",
			block = true
		},
		[255] = "WishTreeBottleExtension"
	},
	[495] = {
		{
			"PM_DivineXiuErClgGetInfoReq",
			"PM_DivineXiuErClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineXiuErClgNormalFightReq",
			"PM_DivineXiuErClgNormalFightRes",
			block = true
		},
		{
			"PM_DivineXiuErClgExtremeFightReq",
			"PM_DivineXiuErClgExtremeFightRes",
			block = true
		},
		{
			"PM_DivineXiuErExtremeFightConfirmReq",
			"PM_DivineXiuErExtremeFightConfirmRes",
			block = true
		},
		{
			"PM_DivineXiuErResetExtremeClgStageReq",
			"PM_DivineXiuErResetExtremeClgStageRes",
			block = true
		},
		{
			"PM_DivineXiuErGainNormalClgPrizeReq",
			"PM_DivineXiuErGainNormalClgPrizeRes",
			block = true
		},
		{
			"PM_DivineXiuErGainExtremeClgPrizeReq",
			"PM_DivineXiuErGainExtremeClgPrizeRes",
			block = true
		},
		[255] = "DivineXiuErChallengeExtension",
		[101] = {
			"PM_DivineXiuErClgNotifyNormalFightResultRes"
		},
		[102] = {
			"PM_DivineXiuErClgNotifyExtremeFightResultRes"
		}
	},
	[496] = {
		{
			"PM_NewBreachFormationInfoReq",
			"PM_NewBreachFormationInfoRes",
			block = true
		},
		{
			"PM_NewBreachFormationChallengeReq",
			"PM_NewBreachFormationChallengeRes",
			block = true
		},
		{
			"PM_NewBreachFormationGainScorePrizeReq",
			"PM_NewBreachFormationGainScorePrizeRes",
			block = true
		},
		{
			"PM_NewBreachFormationRankViewReq",
			"PM_NewBreachFormationRankViewRes",
			block = true
		},
		[255] = "NewBreachFormationExtension",
		[10] = {
			"PM_NewBreachFormationNotifyChallengeRes"
		}
	},
	[497] = {
		{
			"PM_HonorTowerInfoReq",
			"PM_HonorTowerInfoRes",
			block = true
		},
		{
			"PM_HonorTowerChallengeReq",
			"PM_HonorTowerChallengeRes",
			block = true
		},
		{
			"PM_HonorTowerSelectRecallChallengeReq",
			"PM_HonorTowerSelectRecallChallengeRes",
			block = true
		},
		{
			"PM_HonorTowerRankViewReq",
			"PM_HonorTowerRankViewRes",
			block = true
		},
		[255] = "HonorTowerExtension",
		[10] = {
			"PM_NotifyHonorTowerChallengeFinishRes"
		}
	},
	[498] = {
		{
			"PM_GodDarkDragonInfoReq",
			"PM_GodDarkDragonInfoRes",
			block = true
		},
		{
			"PM_GodDarkDragonBuffChallengeReq",
			"PM_GodDarkDragonBuffChallengeRes",
			block = true
		},
		{
			"PM_GodDarkDragonBuffConfirmReq",
			"PM_GodDarkDragonBuffConfirmRes",
			block = true
		},
		{
			"PM_GodDarkDragonMainChallengeReq",
			"PM_GodDarkDragonMainChallengeRes",
			block = true
		},
		{
			"PM_GodDarkDragonGainPrizeReq",
			"PM_GodDarkDragonGainPrizeRes",
			block = true
		},
		[255] = "GodDarkDragonExtension",
		[10] = {
			"PM_NotifyGodDarkDragonBuffChallengeEndRes"
		},
		[11] = {
			"PM_NotifyGodDarkDragonMainChallengeEndRes"
		}
	},
	[499] = {
		{
			"PM_ElemeInfoReq",
			"PM_ElemeInfoRes",
			block = true
		},
		{
			"PM_ElemeRefreshOrderReq",
			"PM_ElemeRefreshOrderRes",
			block = true
		},
		{
			"PM_ElemeTakeOrderReq",
			"PM_ElemeTakeOrderRes",
			block = true
		},
		{
			"PM_ElemeFightReq",
			"PM_ElemeFightRes",
			block = true
		},
		{
			"PM_ElemeGainPrizeReq",
			"PM_ElemeGainPrizeRes",
			block = true
		},
		[255] = "ElemeExtension",
		[10] = {
			"PM_NotifyElemeFightFinishRes"
		}
	},
	[500] = {
		{
			"PM_FarnasClgGetInfoReq",
			"PM_FarnasClgGetInfoRes",
			block = true
		},
		{
			"PM_FarnasClgExtremeFightReq",
			"PM_FarnasClgExtremeFightRes",
			block = true
		},
		{
			"PM_FarnasClgResetExtremeClgReq",
			"PM_FarnasClgResetExtremeClgRes",
			block = true
		},
		{
			"PM_FarnasClgGainExtremePrizeReq",
			"PM_FarnasClgGainExtremePrizeRes",
			block = true
		},
		{
			"PM_FarnasClgNormalFightReq",
			"PM_FarnasClgNormalFightRes",
			block = true
		},
		{
			"PM_FarnasGainNormalClgProgressPrizeReq",
			"PM_FarnasGainNormalClgProgressPrizeRes",
			block = true
		},
		[255] = "FarnasChallengeExtension",
		[101] = {
			"PM_FarnasClgNotifyExtremeFightResultRes"
		},
		[102] = {
			"PM_FarnasClgNotifyNormalFightResultRes"
		}
	},
	[501] = {
		{
			"PM_FamilyHounding_GetInfoReq",
			"PM_FamilyHounding_GetInfoRes",
			block = true
		},
		[255] = "FamilyHoundingExtension",
		[3] = {
			"PM_FamilyHounding_ViewFamilyRankReq",
			"PM_FamilyHounding_ViewFamilyRankRes",
			block = true
		},
		[4] = {
			"PM_FamilyHounding_ViewPersonRankReq",
			"PM_FamilyHounding_ViewPersonRankRes",
			block = true
		},
		[5] = {
			"PM_FamilyHounding_FightReq",
			"PM_FamilyHounding_FightRes",
			block = true
		},
		[6] = {
			"PM_FamilyHounding_PracticeReq",
			"PM_FamilyHounding_PracticeRes",
			block = true
		},
		[101] = {
			"PM_FamilyHounding_NotifyFightResultRes",
			block = true
		},
		[102] = {
			"PM_FamilyHounding_NotifyPracticeResultRes",
			block = true
		}
	},
	[502] = {
		{
			"PM_Cube_JoinReq",
			"PM_Cube_JoinRes",
			block = true
		},
		{
			"PM_Cube_SwitchChannelReq",
			"PM_Cube_SwitchChannelRes",
			block = true
		},
		{
			"PM_Cube_GetAllChannelInfosReq",
			"PM_Cube_GetAllChannelInfosRes",
			block = true
		},
		{
			"PM_Cube_SetVariablesReq",
			"PM_Cube_SetVariablesRes"
		},
		{
			"PM_Cube_MoveReq",
			"PM_Cube_MoveRes"
		},
		{
			"PM_Cube_ExitReq",
			"PM_Cube_ExitRes"
		},
		[255] = "CubeExtension",
		[101] = {
			"PM_Cube_NotifyJoinResultRes"
		},
		[102] = {
			"PM_Cube_NotifyOtherEnterRes"
		},
		[103] = {
			"PM_Cube_NotifyLeaveRes"
		},
		[104] = {
			"PM_Cube_NotifyMoveRes"
		},
		[105] = {
			"PM_Cube_NotifyVariablesUpdateRes"
		},
		[107] = {
			"PM_Cube_NotifyExitRes"
		}
	},
	[503] = {
		{
			"PM_FamilyParty_GainIdlePrizeReq",
			"PM_FamilyParty_GainIdlePrizeRes",
			block = true
		},
		{
			"PM_FamilyParty_AnswerQuestionReq",
			"PM_FamilyParty_AnswerQuestionRes",
			block = true
		},
		[255] = "FamilyPartyExtension",
		[100] = {
			"PM_FamilyParty_NotifyPartyBeginRes",
			block = true
		},
		[101] = {
			"PM_FamilyParty_NotifyNextQuestionRes",
			block = true
		},
		[102] = {
			"PM_FamilyParty_NotifyQuestionResultRes",
			block = true
		},
		[103] = {
			"PM_FamilyParty_NotifyOptionInfoChangeRes",
			block = true
		},
		[104] = {
			"PM_FamilyParty_NotifyPartyEndRes",
			block = true
		}
	},
	[505] = {
		{
			"PM_NightFeastBossClgGetInfoReq",
			"PM_NightFeastBossClgGetInfoRes",
			block = true
		},
		{
			"PM_NightFeastBossClgFight4BuffReq",
			"PM_NightFeastBossClgFight4BuffRes",
			block = true
		},
		{
			"PM_NightFeastBossClgFightBossReq",
			"PM_NightFeastBossClgFightBossRes",
			block = true
		},
		{
			"PM_NightFeastBossClgLvlUpBuffReq",
			"PM_NightFeastBossClgLvlUpBuffRes",
			block = true
		},
		{
			"PM_NightFeastBossClgResetBuffReq",
			"PM_NightFeastBossClgResetBuffRes",
			block = true
		},
		{
			"PM_NightFeastBossClgGainProgressPrizeReq",
			"PM_NightFeastBossClgGainProgressPrizeRes",
			block = true
		},
		{
			"PM_NightFeastBossClgGetRankReq",
			"PM_NightFeastBossClgGetRankRes",
			block = true
		},
		[255] = "NightFeastBossChallengeExtension",
		[101] = {
			"PM_NightFeastBossClgFight4BuffNotifyFightResultRes"
		},
		[102] = {
			"PM_NightFeastBossClgFightBossNotifyFightResultRes"
		}
	},
	[506] = {
		{
			"PM_XiaYinGetInfoReq",
			"PM_XiaYinGetInfoRes",
			block = true
		},
		{
			"PM_XiaYinChallengeReq",
			"PM_XiaYinChallengeRes",
			block = true
		},
		{
			"PM_XiaYinGainProgressPrizeReq",
			"PM_XiaYinGainProgressPrizeRes",
			block = true
		},
		{
			"PM_XiaYinUpgradeSignInBuffReq",
			"PM_XiaYinUpgradeSignInBuffRes",
			block = true
		},
		[255] = "XiaYinExtension",
		[100] = {
			"PM_Notify_XiaYinChallengeRes"
		}
	},
	[507] = {
		{
			"PM_DivineDragonAryaClgGetInfoReq",
			"PM_DivineDragonAryaClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineDragonAryaClgFightReq",
			"PM_DivineDragonAryaClgFightRes",
			block = true
		},
		{
			"PM_DivineDragonAryaClgGetGodRankReq",
			"PM_DivineDragonAryaClgGetGodRankRes",
			block = true
		},
		{
			"PM_DivineDragonAryaClgGetDailyRankReq",
			"PM_DivineDragonAryaClgGetDailyRankRes",
			block = true
		},
		[255] = "DivineDragonAryaClgExtension",
		[101] = {
			"PM_DivineDragonAryaClgNotifyFightResultRes"
		}
	},
	[508] = {
		{
			"PM_PickUpIdeaGetInfoReq",
			"PM_PickUpIdeaGetInfoRes",
			block = true
		},
		{
			"PM_PickUpIdeaStartGameReq",
			"PM_PickUpIdeaStartGameRes",
			block = true
		},
		{
			"PM_PickUpIdeaEndGameReq",
			"PM_PickUpIdeaEndGameRes",
			block = true
		},
		{
			"PM_PickUpIdeaGainProgressPrizeReq",
			"PM_PickUpIdeaGainProgressPrizeRes",
			block = true
		},
		{
			"PM_PickUpIdeaGetRankInfoReq",
			"PM_PickUpIdeaGetRankInfoRes",
			block = true
		},
		{
			"PM_PickUpIdeaReliveReq",
			"PM_PickUpIdeaReliveRes",
			block = true
		},
		[255] = "PickUpIdeaExtension"
	},
	[509] = {
		[100] = {
			"PM_ThreeEliminationGetInfo4RedPointReq",
			"PM_ThreeEliminationGetInfo4RedPointRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameOpenFuncReq",
			"PM_ThreeEliminationGameOpenFuncRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameCloseFuncReq",
			"PM_ThreeEliminationGameCloseFuncRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameLvlUpPlayerReq",
			"PM_ThreeEliminationGameLvlUpPlayerRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameUnLockBuffReq",
			"PM_ThreeEliminationGameUnLockBuffRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameSetBuffUsingReq",
			"PM_ThreeEliminationGameSetBuffUsingRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameGetRankReq",
			"PM_ThreeEliminationGameGetRankRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameMoveStepReq",
			"PM_ThreeEliminationGameMoveStepRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameFightReq",
			"PM_ThreeEliminationGameFightRes",
			block = true
		},
		{
			"PM_ThreeEliminationGameGainHangUpPrizeReq",
			"PM_ThreeEliminationGameGainHangUpPrizeRes",
			block = true
		},
		[255] = "ThreeEliminationGameExtension"
	},
	[510] = {
		{
			"PM_ElizabethGameGetInfoReq",
			"PM_ElizabethGameGetInfoRes",
			block = true
		},
		{
			"PM_ElizabethGameStartGameReq",
			"PM_ElizabethGameStartGameRes",
			block = true
		},
		{
			"PM_ElizabethGameEndGameReq",
			"PM_ElizabethGameEndGameRes",
			block = true
		},
		{
			"PM_ElizabethGameBuyTimesReq",
			"PM_ElizabethGameBuyTimesRes",
			block = true
		},
		{
			"PM_ElizabethGameReliveReq",
			"PM_ElizabethGameReliveRes",
			block = true
		},
		{
			"PM_ElizabethGameGainPrizeReq",
			"PM_ElizabethGameGainPrizeRes",
			block = true
		},
		{
			"PM_ElizabethGameQuitGameReq",
			"PM_ElizabethGameQuitGameRes",
			block = true
		},
		[255] = "ElizabethGameExtension"
	},
	[511] = {
		{
			"PM_EmpressClgGetInfoReq",
			"PM_EmpressClgGetInfoRes",
			block = true
		},
		{
			"PM_EmpressExtremeFightReq",
			"PM_EmpressExtremeFightRes",
			block = true
		},
		{
			"PM_EmpressResetExtremeClgStageReq",
			"PM_EmpressResetExtremeClgStageRes",
			block = true
		},
		{
			"PM_EmpressClgGainExtremePrizeReq",
			"PM_EmpressClgGainExtremePrizeRes",
			block = true
		},
		{
			"PM_EmpressNormalFightReq",
			"PM_EmpressNormalFightRes",
			block = true
		},
		{
			"PM_EmpressGainNormalClgProgressPrizeReq",
			"PM_EmpressGainNormalClgProgressPrizeRes",
			block = true
		},
		[255] = "EmpressChallengeExtension",
		[101] = {
			"PM_EmpressNotifyExtremeFightResultRes"
		},
		[102] = {
			"PM_EmpressNotifyNormalFightResultRes"
		}
	},
	[512] = {
		{
			"PM_NewFamilyBattleGetRegistrationReq",
			"PM_NewFamilyBattleGetRegistrationRes",
			block = true
		},
		{
			"PM_NewFamilyBattleRegisteringReq",
			"PM_NewFamilyBattleRegisteringRes",
			block = true
		},
		{
			"PM_NewFamilyBattleGetFormReq",
			"PM_NewFamilyBattleGetFormRes",
			block = true
		},
		{
			"PM_NewFamilyBattleSetFormReq",
			"PM_NewFamilyBattleSetFormRes",
			block = true
		},
		{
			"PM_NewFamilyBattleGetDivinePillarFormReq",
			"PM_NewFamilyBattleGetDivinePillarFormRes",
			block = true
		},
		{
			"PM_NewFamilyBattleGetFormDetailReq",
			"PM_NewFamilyBattleGetFormDetailRes",
			block = true
		},
		{
			"PM_NewFamilyBattleAdjustReq",
			"PM_NewFamilyBattleAdjustRes",
			block = true
		},
		{
			"PM_NewFamilyBattleGetDivinePillarMapReq",
			"PM_NewFamilyBattleGetDivinePillarMapRes",
			block = true
		},
		{
			"PM_NewFamilyBattleGetDivinePillarInfoReq",
			"PM_NewFamilyBattleGetDivinePillarInfoRes",
			block = true
		},
		{
			"PM_NewFamilyBattleFightDivinePillarReq",
			"PM_NewFamilyBattleFightDivinePillarRes",
			block = true
		},
		{
			"PM_NewFamilyBattleReportReq",
			"PM_NewFamilyBattleReportRes",
			block = true
		},
		{
			"PM_NewFamilyBattleVideoReq",
			"PM_NewFamilyBattleVideoRes",
			block = true
		},
		{
			"PM_NewFamilyBattleChallengeNestReq",
			"PM_NewFamilyBattleChallengeNestRes",
			block = true
		},
		{
			"PM_NewFamilyBattleSetFlagReq",
			"PM_NewFamilyBattleSetFlagRes",
			block = true
		},
		{
			"PM_NewFamilyBattleRankViewReq",
			"PM_NewFamilyBattleRankViewRes",
			block = true
		},
		{
			"PM_NewFamilyBattleGetSpaceGroupInfoReq",
			"PM_NewFamilyBattleGetSpaceGroupInfoRes",
			block = true
		},
		[255] = "NewFamilyBattleExtension",
		[101] = {
			"PM_NewFamilyBattleChallengeNestResult"
		}
	},
	[513] = {
		{
			"PM_DragonDishitianGetInfoReq",
			"PM_DragonDishitianGetInfoRes",
			block = true
		},
		{
			"PM_DragonDishitianChallengeReq",
			"PM_DragonDishitianChallengeRes",
			block = true
		},
		{
			"PM_DragonDishitianChargeReq",
			"PM_DragonDishitianChargeRes",
			block = true
		},
		[255] = "DragonDishitianExtension",
		[100] = {
			"PM_Notify_DragonDishitianChallengeRes"
		}
	},
	[514] = {
		{
			"PM_DivineSuperDragonClgGetInfoReq",
			"PM_DivineSuperDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineSuperDragonClgBuffStageFightReq",
			"PM_DivineSuperDragonClgBuffStageFightRes",
			block = true
		},
		{
			"PM_DivineSuperDragonClgSuperStageFightReq",
			"PM_DivineSuperDragonClgSuperStageFightRes",
			block = true
		},
		[255] = "DivineSuperDragonClgExtension",
		[101] = {
			"PM_DivineSuperDragonClgNotifyBuffStageFightResultRes"
		},
		[102] = {
			"PM_DivineSuperDragonClgNotifySuperStageFightResultRes"
		}
	},
	[515] = {
		{
			"PM_TarotLotteryInfoReq",
			"PM_TarotLotteryInfoRes",
			block = true
		},
		{
			"PM_TarotLotteryDrawReq",
			"PM_TarotLotteryDrawRes",
			block = true
		},
		{
			"PM_TarotLotteryGainProgressReq",
			"PM_TarotLotteryGainProgressRes",
			block = true
		},
		[255] = "TarotLotteryExtension"
	},
	[516] = {
		{
			"PM_DivineGodDragonClgInfoReq",
			"PM_DivineGodDragonClgInfoRes",
			block = true
		},
		{
			"PM_DivineGodDragonChallengeReq",
			"PM_DivineGodDragonChallengeRes",
			block = true
		},
		{
			"PM_DivineGodDragonGainPrizeReq",
			"PM_DivineGodDragonGainPrizeRes",
			block = true
		},
		{
			"PM_DivineGodDragonGetRankReq",
			"PM_DivineGodDragonGetRankRes",
			block = true
		},
		[255] = "DivineGodDragonClgExtension",
		[10] = {
			"PM_NotifyDivineGodDragonChallengeEndRes"
		}
	},
	[517] = {
		{
			"PM_KingIsaacClgInfoReq",
			"PM_KingIsaacClgInfoRes",
			block = true
		},
		{
			"PM_KingIsaacClgChallengeReq",
			"PM_KingIsaacClgChallengeRes",
			block = true
		},
		[255] = "KingIsaacClgExtension",
		[10] = {
			"PM_NotifyKingIsaacClgChallengeEndRes"
		}
	},
	[518] = {
		{
			"PM_SummonMasterJiGetInfoReq",
			"PM_SummonMasterJiGetInfoRes",
			block = true
		},
		{
			"PM_SummonMasterJiChallengeExtremeReq",
			"PM_SummonMasterJiChallengeExtremeRes",
			block = true
		},
		{
			"PM_SummonMasterJiResetExtremeReq",
			"PM_SummonMasterJiResetExtremeRes",
			block = true
		},
		{
			"PM_SummonMasterJiChallengeNormalReq",
			"PM_SummonMasterJiChallengeNormalRes",
			block = true
		},
		{
			"PM_SummonMasterJiOneKeyPassNormalReq",
			"PM_SummonMasterJiOneKeyPassNormalRes",
			block = true
		},
		[255] = "SummonMasterJiExtension",
		[100] = {
			"PM_Notify_SummonMasterJiChallengeExtremeRes"
		},
		[101] = {
			"PM_Notify_SummonMasterJiChallengeNormalRes"
		}
	},
	[519] = {
		{
			"PM_TripleMatchesGameGetInfoReq",
			"PM_TripleMatchesGameGetInfoRes",
			block = true
		},
		{
			"PM_TripleMatchesGameStartGameReq",
			"PM_TripleMatchesGameStartGameRes",
			block = true
		},
		{
			"PM_TripleMatchesGameEndGameReq",
			"PM_TripleMatchesGameEndGameRes",
			block = true
		},
		{
			"PM_TripleMatchesGameBuyStepReq",
			"PM_TripleMatchesGameBuyStepRes",
			block = true
		},
		{
			"PM_TripleMatchesGameRankViewReq",
			"PM_TripleMatchesGameRankViewRes",
			block = true
		},
		{
			"PM_TripleMatchesGameGainPrizeReq",
			"PM_TripleMatchesGameGainPrizeRes",
			block = true
		},
		{
			"PM_TripleMatchesGameSweepReq",
			"PM_TripleMatchesGameSweepRes",
			block = true
		},
		[255] = "TripleMatchesGameExtension"
	},
	[520] = {
		{
			"PM_KingSpaceDragonClgGetInfoReq",
			"PM_KingSpaceDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_KingSpaceDragonClgFightReq",
			"PM_KingSpaceDragonClgFightRes",
			block = true
		},
		{
			"PM_KingSpaceDragonClgFightConfirmReq",
			"PM_KingSpaceDragonClgFightConfirmRes",
			block = true
		},
		[255] = "KingSpaceDragonClgExtension",
		[101] = {
			"PM_KingSpaceDragonClgNotifyFightResultRes"
		}
	},
	[521] = {
		{
			"PM_DPClgGetUniversalInfoReq",
			"PM_DPClgGetUniversalInfoRes",
			block = true
		},
		{
			"PM_DPClgUniversalChallengeReq",
			"PM_DPClgUniversalChallengeRes",
			block = true
		},
		{
			"PM_DPClgHatchReq",
			"PM_DPClgHatchRes",
			block = true
		},
		{
			"PM_DPClgDecHatchTimeReq",
			"PM_DPClgDecHatchTimeRes",
			block = true
		},
		{
			"PM_DPClgGainHatchPetReq",
			"PM_DPClgGainHatchPetRes",
			block = true
		},
		{
			"PM_DPClgSelectPetReq",
			"PM_DPClgSelectPetRes",
			block = true
		},
		{
			"PM_DPClgGetExtremeInfoReq",
			"PM_DPClgGetExtremeInfoRes",
			block = true
		},
		{
			"PM_DPClgExtremeChallengeReq",
			"PM_DPClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_DPClgResetReq",
			"PM_DPClgResetRes",
			block = true
		},
		{
			"PM_DPClgNotifyUniversalChallengeRes"
		},
		{
			"PM_DPClgNotifyExtremeChallengeRes"
		},
		[255] = "DragonPsychicClgExtension"
	},
	[522] = {
		{
			"PM_DivineAsheslessDragonGetInfoReq",
			"PM_DivineAsheslessDragonGetInfoRes",
			block = true
		},
		{
			"PM_DivineAsheslessDragonChallengeReq",
			"PM_DivineAsheslessDragonChallengeRes",
			block = true
		},
		[255] = "DivineAsheslessDragonExtension",
		[100] = {
			"PM_Notify_DivineAsheslessDragonChallengeRes"
		}
	},
	[523] = {
		{
			"PM_KindergartenGetInfoReq",
			"PM_KindergartenGetInfoRes",
			block = true
		},
		{
			"PM_KindergartenOpenClassReq",
			"PM_KindergartenOpenClassRes",
			block = true
		},
		{
			"PM_KindergartenViewResultReq",
			"PM_KindergartenViewResultRes",
			block = true
		},
		{
			"PM_KindergartenUnlockFacilityReq",
			"PM_KindergartenUnlockFacilityRes",
			block = true
		},
		{
			"PM_KindergartenGainItemReq",
			"PM_KindergartenGainItemRes",
			block = true
		},
		{
			"PM_KindergartenUnlockAutoFunctionReq",
			"PM_KindergartenUnlockAutoFunctionRes",
			block = true
		},
		{
			"PM_KindergartenSetAutoReq",
			"PM_KindergartenSetAutoRes",
			block = true
		},
		{
			"PM_KindergartenGetJobInfoReq",
			"PM_KindergartenGetJobInfoRes",
			block = true
		},
		{
			"PM_KindergartenAddStudentReq",
			"PM_KindergartenAddStudentRes",
			block = true
		},
		{
			"PM_KindergartenRankViewReq",
			"PM_KindergartenRankViewRes",
			block = true
		},
		[255] = "KindergartenExtension"
	},
	[524] = {
		{
			"PM_RelationPowerGetInfoReq",
			"PM_RelationPowerGetInfoRes",
			block = true
		},
		{
			"PM_RelationPowerVerifyReq",
			"PM_RelationPowerVerifyRes",
			block = true
		},
		{
			"PM_RelationPowerGainTaskPrizeReq",
			"PM_RelationPowerGainTaskPrizeRes",
			block = true
		},
		[255] = "RelationPowerExtension"
	},
	[525] = {
		{
			"PM_DivineLongYanChallengeInfoReq",
			"PM_DivineLongYanChallengeInfoRes",
			block = true
		},
		{
			"PM_DivineLongYanPowerChallengeReq",
			"PM_DivineLongYanPowerChallengeRes",
			block = true
		},
		{
			"PM_DivineLongYanUpgradeLevelReq",
			"PM_DivineLongYanUpgradeLevelRes",
			block = true
		},
		{
			"PM_DivineLongYanUpgradeSkillReq",
			"PM_DivineLongYanUpgradeSkillRes",
			block = true
		},
		{
			"PM_DivineLongYanLineChallengeReq",
			"PM_DivineLongYanLineChallengeRes",
			block = true
		},
		[255] = "DivineLongYanChallengeExtension",
		[11] = {
			"PM_NotifyDivineLongYanPowerClgFinsihRes"
		},
		[12] = {
			"PM_NotifyDivineLongYanLineClgFinsihRes"
		}
	},
	[526] = {
		{
			"PM_YearScratchInfoReq",
			"PM_YearScratchInfoRes",
			block = true
		},
		{
			"PM_YearScratchGainPrizeReq",
			"PM_YearScratchGainPrizeRes",
			block = true
		},
		{
			"PM_YearScratchGainGodGemReq",
			"PM_YearScratchGainGodGemRes",
			block = true
		},
		[255] = "YearScratchExtension"
	},
	[527] = {
		{
			"PM_DivineKingOrderClgGetInfoReq",
			"PM_DivineKingOrderClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineKingOrderClgFightReq",
			"PM_DivineKingOrderClgFightRes",
			block = true
		},
		{
			"PM_DivineKingOrderClgFightConfirmReq",
			"PM_DivineKingOrderClgFightConfirmRes",
			block = true
		},
		{
			"PM_DivineKingOrderClgResetReq",
			"PM_DivineKingOrderClgResetRes",
			block = true
		},
		[255] = "DivineKingOrderClgExtension",
		[101] = {
			"PM_DivineKingOrderClgNotifyFightResultRes"
		}
	},
	[528] = {
		{
			"PM_BestDragonSoulInfoReq",
			"PM_BestDragonSoulInfoRes",
			block = true
		},
		{
			"PM_BestDragonSoulStartGameReq",
			"PM_BestDragonSoulStartGameRes",
			block = true
		},
		{
			"PM_BestDragonSoulEndGameReq",
			"PM_BestDragonSoulEndGameRes",
			block = true
		},
		{
			"PM_BestDragonSoulGainPrizeReq",
			"PM_BestDragonSoulGainPrizeRes",
			block = true
		},
		{
			"PM_BestDragonSoulLikeReq",
			"PM_BestDragonSoulLikeRes",
			block = true
		},
		[255] = "BestDragonSoulExtension"
	},
	[529] = {
		{
			"PM_DivineXingJiangClgGetInfoReq",
			"PM_DivineXingJiangClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineXingJiangClgFightReq",
			"PM_DivineXingJiangClgFightRes",
			block = true
		},
		{
			"PM_DivineXingJiangClgPlayGameReq",
			"PM_DivineXingJiangClgPlayGameRes",
			block = true
		},
		[255] = "DivineXingJiangClgExtension",
		[101] = {
			"PM_DivineXingJiangClgNotifyFightResultRes"
		}
	},
	[530] = {
		{
			"PM_ShowDown_SetWishListReq",
			"PM_ShowDown_SetWishListRes",
			block = true
		},
		{
			"PM_ShowDown_RollPetsReq",
			"PM_ShowDown_RollPetsRes",
			block = true
		},
		[255] = "ShowDownQualifyAndTeamExtension",
		[4] = {
			"PM_ShowDown_ConfirmPetsReq",
			"PM_ShowDown_ConfirmPetsRes",
			block = true
		},
		[5] = {
			"PM_ShowDown_SetFormReq",
			"PM_ShowDown_SetFormRes",
			block = true
		},
		[6] = {
			"PM_ShowDown_ResetPetsAndFormReq",
			"PM_ShowDown_ResetPetsAndFormRes",
			block = true
		},
		[7] = {
			"PM_ShowDown_GainDailyGuessItemReq",
			"PM_ShowDown_GainDailyGuessItemRes",
			block = true
		},
		[8] = {
			"PM_ShowDownTeam_GetPlayerViewReq",
			"PM_ShowDownTeam_GetPlayerViewRes",
			block = true
		},
		[20] = {
			"PM_ShowDownQualify_StartMatchingReq",
			"PM_ShowDownQualify_StartMatchingRes",
			block = true
		},
		[21] = {
			"PM_ShowDownQualify_CancelMatchingReq",
			"PM_ShowDownQualify_CancelMatchingRes",
			block = true
		},
		[22] = {
			"PM_ShowDownQualify_GetQualifyRankReq",
			"PM_ShowDownQualify_GetQualifyRankRes",
			block = true
		},
		[23] = {
			"PM_ShowDownQualify_NotifyMatchBattleResultRes"
		},
		[24] = {
			"PM_ShowDownQualify_GetQualifyBattleVideoReq",
			"PM_ShowDownQualify_GetQualifyBattleVideoRes",
			block = true
		},
		[30] = {
			"PM_ShowDownQualify_NotifyMatchFailRes"
		},
		[41] = {
			"PM_ShowDownTeam_SetMyTeamInfoReq",
			"PM_ShowDownTeam_SetMyTeamInfoRes",
			block = true
		},
		[42] = {
			"PM_ShowDownTeam_GetOtherGroupInfoReq",
			"PM_ShowDownTeam_GetOtherGroupInfoRes",
			block = true
		},
		[43] = {
			"PM_ShowDownTeam_GetTeamMemberInfoReq",
			"PM_ShowDownTeam_GetTeamMemberInfoRes",
			block = true
		},
		[44] = {
			"PM_ShowDownTeam_SendEnlistMsgReq",
			"PM_ShowDownTeam_SendEnlistMsgRes",
			block = true
		},
		[45] = {
			"PM_ShowDownTeam_GetMyTeamApplyListReq",
			"PM_ShowDownTeam_GetMyTeamApplyListRes",
			block = true
		},
		[46] = {
			"PM_ShowDownTeam_GetOrRefreshTeamListReq",
			"PM_ShowDownTeam_GetOrRefreshTeamListRes",
			block = true
		},
		[47] = {
			"PM_ShowDownTeam_SearchTeamReq",
			"PM_ShowDownTeam_SearchTeamRes",
			block = true
		},
		[48] = {
			"PM_ShowDownTeam_QuickJoinReq",
			"PM_ShowDownTeam_QuickJoinRes",
			block = true
		},
		[49] = {
			"PM_ShowDownTeam_JoinReq",
			"PM_ShowDownTeam_JoinRes",
			block = true
		},
		[50] = {
			"PM_ShowDownTeam_HandleApplyReq",
			"PM_ShowDownTeam_HandleApplyRes",
			block = true
		},
		[80] = {
			"PM_ShowDown_NotifyJoinTeamRes"
		}
	},
	[531] = {
		{
			"PM_DragonKingARuiShiClgInfoReq",
			"PM_DragonKingARuiShiClgInfoRes",
			block = true
		},
		{
			"PM_DragonKingARuiShiClgChallengeReq",
			"PM_DragonKingARuiShiClgChallengeRes",
			block = true
		},
		[255] = "DragonKingARuiShiClgExtension",
		[10] = {
			"PM_NotifyDragonKingARuiShiClgChallengeEndRes"
		}
	},
	[532] = {
		{
			"PM_CollectingSkinGetInfoReq",
			"PM_CollectingSkinGetInfoRes",
			block = true
		},
		{
			"PM_CollectingSkinGainProgressPrizeReq",
			"PM_CollectingSkinGainProgressPrizeRes",
			block = true
		},
		{
			"PM_CollectingSkinGainSkinPrizeReq",
			"PM_CollectingSkinGainSkinPrizeRes",
			block = true
		},
		{
			"PM_CollectingSkinGainItemPrizeReq",
			"PM_CollectingSkinGainItemPrizeRes",
			block = true
		},
		{
			"PM_CollectingSkinItemRankInfoReq",
			"PM_CollectingSkinItemRankInfoRes",
			block = true
		},
		[255] = "CollectingSkinExtension"
	},
	[533] = {
		{
			"PM_ShowDown_GetQualifyMainInfoReq",
			"PM_ShowDown_GetQualifyMainInfoRes",
			block = true
		},
		{
			"PM_ShowDown_GetTeamMainInfoReq",
			"PM_ShowDown_GetTeamMainInfoRes",
			block = true
		},
		{
			"PM_ShowDown_GetMainInfoReq",
			"PM_ShowDown_GetMainInfoRes",
			block = true
		},
		{
			"PM_ShowDown_GetScheduleInfoReq",
			"PM_ShowDown_GetScheduleInfoRes",
			block = true
		},
		{
			"PM_ShowDownKnockout_GetBattleOrderReq",
			"PM_ShowDownKnockout_GetBattleOrderRes",
			block = true
		},
		{
			"PM_ShowDownKnockout_AdjustBattleOrderReq",
			"PM_ShowDownKnockout_AdjustBattleOrderRes",
			block = true
		},
		{
			"PM_ShowDown_GetGuessRecordReq",
			"PM_ShowDown_GetGuessRecordRes",
			block = true
		},
		{
			"PM_ShowDown_GuessReq",
			"PM_ShowDown_GuessRes",
			block = true
		},
		{
			"PM_ShowDown_GetDisplayInfoReq",
			"PM_ShowDown_GetDisplayInfoRes",
			block = true
		},
		{
			"PM_ShowDown_GetBattleRecordsReq",
			"PM_ShowDown_GetBattleRecordsRes",
			block = true
		},
		{
			"PM_ShowDown_GetFinalMatchBattleVideoReq",
			"PM_ShowDown_GetFinalMatchBattleVideoRes",
			block = true
		},
		{
			"PM_ShowDown_GetGroupMatchBattleDetailReq",
			"PM_ShowDown_GetGroupMatchBattleDetailRes",
			block = true
		},
		{
			"PM_ShowDown_FinalMatchGuessReq",
			"PM_ShowDown_FinalMatchGuessRes",
			block = true
		},
		{
			"PM_ShowDown_GetStepInfoReq",
			"PM_ShowDown_GetStepInfoRes",
			block = true
		},
		{
			"PM_ShowDown_NotifyStepChangeRes",
			block = true
		},
		{
			"PM_ShowDown_GetJoyModeInfoReq",
			"PM_ShowDown_GetJoyModeInfoRes",
			block = true
		},
		[255] = "ShowDownExtension"
	},
	[534] = {
		{
			"PM_DivineDiShiTianClgInfoReq",
			"PM_DivineDiShiTianClgInfoRes",
			block = true
		},
		{
			"PM_DivineDiShiTianChallengeNormalReq",
			"PM_DivineDiShiTianChallengeNormalRes",
			block = true
		},
		{
			"PM_DivineDiShiTianClgRefreshLimitReq",
			"PM_DivineDiShiTianClgRefreshLimitRes",
			block = true
		},
		{
			"PM_DivineDiShiTianClgGainNormalPrizeReq",
			"PM_DivineDiShiTianClgGainNormalPrizeRes",
			block = true
		},
		{
			"PM_DivineDiShiTianClgChallengeExtremeReq",
			"PM_DivineDiShiTianClgChallengeExtremeRes",
			block = true
		},
		{
			"PM_DivineDiShiTianClgExtremeResetReq",
			"PM_DivineDiShiTianClgExtremeResetRes",
			block = true
		},
		{
			"PM_DivineDiShiTianClgExtremeGainPrizeReq",
			"PM_DivineDiShiTianClgExtremeGainPrizeRes",
			block = true
		},
		[255] = "DivineDiShiTianClgExtension",
		[10] = {
			"PM_NotifyDivineDiShiTianClgNormalFinishRes"
		},
		[11] = {
			"PM_NotifyDivineDiShiTianClgExtremeFinishRes"
		}
	},
	[535] = {
		{
			"PM_StarScratchInfoReq",
			"PM_StarScratchInfoRes",
			block = true
		},
		{
			"PM_StarScratchBuyReq",
			"PM_StarScratchBuyRes",
			block = true
		},
		{
			"PM_StarScratchGainReq",
			"PM_StarScratchGainRes",
			block = true
		},
		{
			"PM_StarScratchRefreshBroadcastReq",
			"PM_StarScratchRefreshBroadcastRes",
			block = true
		},
		[255] = "StarScratchExtension"
	},
	[536] = {
		{
			"PM_ScriptKillingInfoReq",
			"PM_ScriptKillingInfoRes",
			block = true
		},
		{
			"PM_ScriptKillingGainClueReq",
			"PM_ScriptKillingGainClueRes",
			block = true
		},
		{
			"PM_ScriptKillingUseActionPointReq",
			"PM_ScriptKillingUseActionPointRes",
			block = true
		},
		{
			"PM_ScriptKillingFormulaReq",
			"PM_ScriptKillingFormulaRes",
			block = true
		},
		{
			"PM_ScriptKillingSuspectReq",
			"PM_ScriptKillingSuspectRes",
			block = true
		},
		{
			"PM_ScriptKillingGainPrizeReq",
			"PM_ScriptKillingGainPrizeRes",
			block = true
		},
		{
			"PM_ScriptKillingRankReq",
			"PM_ScriptKillingRankRes",
			block = true
		},
		{
			"PM_ScriptKillingGainStagingClueReq",
			"PM_ScriptKillingGainStagingClueRes",
			block = true
		},
		[255] = "ScriptKillingExtension"
	},
	[537] = {
		{
			"PM_ARuiShiDragonGameInfoReq",
			"PM_ARuiShiDragonGameInfoRes",
			block = true
		},
		{
			"PM_ARuiShiDragonGameStartReq",
			"PM_ARuiShiDragonGameStartRes",
			block = true
		},
		{
			"PM_ARuiShiDragonGameEndReq",
			"PM_ARuiShiDragonGameEndRes",
			block = true
		},
		{
			"PM_ARuiShiDragonGameGainPrizeReq",
			"PM_ARuiShiDragonGameGainPrizeRes",
			block = true
		},
		[255] = "ARuiShiDragonGameExtension"
	},
	[538] = {
		{
			"PM_DivineAresMomGetInfoReq",
			"PM_DivineAresMomGetInfoRes",
			block = true
		},
		{
			"PM_DivineAresMomUpgradeBuffReq",
			"PM_DivineAresMomUpgradeBuffRes",
			block = true
		},
		{
			"PM_DivineAresMomChallengeReq",
			"PM_DivineAresMomChallengeRes",
			block = true
		},
		[255] = "DivineAresMomExtension",
		[100] = {
			"PM_Notify_DivineAresMomChallengeEndRes",
			block = true
		}
	},
	[539] = {
		{
			"PM_MusicGameInfoReq",
			"PM_MusicGameInfoRes",
			block = true
		},
		{
			"PM_MusicGameStartReq",
			"PM_MusicGameStartRes",
			block = true
		},
		{
			"PM_MusicGameEndReq",
			"PM_MusicGameEndRes",
			block = true
		},
		{
			"PM_MusicGameGainPrizeReq",
			"PM_MusicGameGainPrizeRes",
			block = true
		},
		{
			"PM_MusicGameSweepReq",
			"PM_MusicGameSweepRes",
			block = true
		},
		[255] = "MusicGameExtension"
	},
	[540] = {
		{
			"PM_KingKaYaGetInfoReq",
			"PM_KingKaYaGetInfoRes",
			block = true
		},
		{
			"PM_KingKaYaExtremeChallengeReq",
			"PM_KingKaYaExtremeChallengeRes",
			block = true
		},
		{
			"PM_KingKaYaResetExtremeStageReq",
			"PM_KingKaYaResetExtremeStageRes",
			block = true
		},
		{
			"PM_KingKaYaNormalChallengeReq",
			"PM_KingKaYaNormalChallengeRes",
			block = true
		},
		{
			"PM_KingKaYaGainProgressPrizeReq",
			"PM_KingKaYaGainProgressPrizeRes",
			block = true
		},
		[255] = "KingKaYaExtension",
		[100] = {
			"PM_Notify_KingKaYaExtremeChallengeEndRes",
			block = true
		},
		[101] = {
			"PM_Notify_KingKaYaNormalChallengeEndRes",
			block = true
		}
	},
	[541] = {
		{
			"PM_DivineQingGuClgGetInfoReq",
			"PM_DivineQingGuClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineQingGuClgFightReq",
			"PM_DivineQingGuClgFightRes",
			block = true
		},
		[255] = "DivineQingGuClgExtension",
		[101] = {
			"PM_DivineQingGuClgNotifyFightResultRes"
		}
	},
	[542] = {
		{
			"PM_RichManXPlanInfoReq",
			"PM_RichManXPlanInfoRes",
			block = true
		},
		{
			"PM_RichManXPlanDiceReq",
			"PM_RichManXPlanDiceRes",
			block = true
		},
		{
			"PM_RichManXPlanRunReq",
			"PM_RichManXPlanRunRes",
			block = true
		},
		{
			"PM_RichManXPlanEventReq",
			"PM_RichManXPlanEventRes",
			block = true
		},
		{
			"PM_RichManXPlanWorkInfoReq",
			"PM_RichManXPlanWorkInfoRes",
			block = true
		},
		{
			"PM_RichManXPlanWorkGainReq",
			"PM_RichManXPlanWorkGainRes",
			block = true
		},
		{
			"PM_RichManXPlanWorkUnlockReq",
			"PM_RichManXPlanWorkUnlockRes",
			block = true
		},
		{
			"PM_RichManXPlanWorkSetPetReq",
			"PM_RichManXPlanWorkSetPetRes",
			block = true
		},
		{
			"PM_RichManXPlanWorkPetStarLevelUpReq",
			"PM_RichManXPlanWorkPetStarLevelUpRes",
			block = true
		},
		[255] = "RichManXPlanExtension",
		[20] = {
			"PM_NotifyRichManXPlanScoreChangeRes"
		},
		[21] = {
			"PM_NotifyRichManXPlanPetChangeRes"
		}
	},
	[543] = {
		{
			"PM_WuWenClgGetInfoReq",
			"PM_WuWenClgGetInfoRes",
			block = true
		},
		{
			"PM_WuWenClgFightReq",
			"PM_WuWenClgFightRes",
			block = true
		},
		{
			"PM_WuWenClgFightConfirmReq",
			"PM_WuWenClgFightConfirmRes",
			block = true
		},
		{
			"PM_WuWenClgResetPhaseReq",
			"PM_WuWenClgResetPhaseRes",
			block = true
		},
		{
			"PM_WuWenClgUpgradeSignInBuffReq",
			"PM_WuWenClgUpgradeSignInBuffRes",
			block = true
		},
		[255] = "WuWenClgExtension",
		[101] = {
			"PM_WuWenClgNotifyFightResultRes"
		}
	},
	[544] = {
		{
			"PM_LingShenConveneGetInfoReq",
			"PM_LingShenConveneGetInfoRes",
			block = true
		},
		{
			"PM_LingShenConveneUnlockReq",
			"PM_LingShenConveneUnlockRes",
			block = true
		},
		{
			"PM_LingShenConveneGainProgressPrizeReq",
			"PM_LingShenConveneGainProgressPrizeRes",
			block = true
		},
		{
			"PM_LingShenConveneGainPrizeReq",
			"PM_LingShenConveneGainPrizeRes",
			block = true
		},
		[255] = "LingShenConveneExtension"
	},
	[545] = {
		{
			"PM_DuoLaMMGameGetInfoReq",
			"PM_DuoLaMMGameGetInfoRes",
			block = true
		},
		{
			"PM_DuoLaMMGameBuyGameTimesReq",
			"PM_DuoLaMMGameBuyGameTimesRes",
			block = true
		},
		{
			"PM_DuoLaMMGameStartGameReq",
			"PM_DuoLaMMGameStartGameRes",
			block = true
		},
		{
			"PM_DuoLaMMGameReliveReq",
			"PM_DuoLaMMGameReliveRes",
			block = true
		},
		{
			"PM_DuoLaMMGameEndGameReq",
			"PM_DuoLaMMGameEndGameRes",
			block = true
		},
		[255] = "DuoLaMMGameExtension"
	},
	[546] = {
		{
			"PM_LingShenClgGetInfoReq",
			"PM_LingShenClgGetInfoRes",
			block = true
		},
		{
			"PM_LingShenClgGainDamagePrizeReq",
			"PM_LingShenClgGainDamagePrizeRes",
			block = true
		},
		{
			"PM_LingShenClgSetPreFormReq",
			"PM_LingShenClgSetPreFormRes",
			block = true
		},
		{
			"PM_LingShenClgSetFormReq",
			"PM_LingShenClgSetFormRes",
			block = true
		},
		{
			"PM_LingShenClgReadyReq",
			"PM_LingShenClgReadyRes",
			block = true
		},
		[255] = "LingShenChallengeExtension",
		[10] = {
			"PM_LingShenClgNotifyStartRes"
		},
		[11] = {
			"PM_LingShenClgNotifyFormChangeRes"
		},
		[12] = {
			"PM_LingShenClgNotifyReadyRes"
		},
		[13] = {
			"PM_LingShenClgNotifyResultRes"
		}
	},
	[547] = {
		{
			"PM_XPlanArchivesInfoReq",
			"PM_XPlanArchivesInfoRes",
			block = true
		},
		{
			"PM_XPlanArchivesFinishReq",
			"PM_XPlanArchivesFinishRes",
			block = true
		},
		{
			"PM_XPlanArchivesGainPrizeReq",
			"PM_XPlanArchivesGainPrizeRes",
			block = true
		},
		[255] = "XPlanArchivesExtension"
	},
	[548] = {
		{
			"PM_MiracleFindTreasureGetInfoReq",
			"PM_MiracleFindTreasureGetInfoRes",
			block = true
		},
		{
			"PM_MiracleFindTreasureLotteryReq",
			"PM_MiracleFindTreasureLotteryRes",
			block = true
		},
		{
			"PM_MiracleFindTreasureFinishDigReq",
			"PM_MiracleFindTreasureFinishDigRes",
			block = true
		},
		{
			"PM_MiracleFindTreasureDirectGainPrizeReq",
			"PM_MiracleFindTreasureDirectGainPrizeRes",
			block = true
		},
		{
			"PM_MiracleFindTreasureStartDigReq",
			"PM_MiracleFindTreasureStartDigRes",
			block = true
		},
		[255] = "MiracleFindTreasureExtension"
	},
	[549] = {
		{
			"PM_MiracleMultipliedGetInfoReq",
			"PM_MiracleMultipliedGetInfoRes",
			block = true
		},
		{
			"PM_MiracleMultipliedUnlockReq",
			"PM_MiracleMultipliedUnlockRes",
			block = true
		},
		{
			"PM_MiracleMultipliedGainPrizeReq",
			"PM_MiracleMultipliedGainPrizeRes",
			block = true
		},
		[255] = "MiracleMultipliedExtension"
	},
	[550] = {
		{
			"PM_DivineMiRuiKeClgGetInfoReq",
			"PM_DivineMiRuiKeClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineMiRuiKeClgFightReq",
			"PM_DivineMiRuiKeClgFightRes",
			block = true
		},
		[255] = "DivineMiRuiKeClgExtension",
		[101] = {
			"PM_DivineMiRuiKeClgNotifyFightResultRes"
		}
	},
	[551] = {
		{
			"PM_MiracleNuoYaClgGetInfoReq",
			"PM_MiracleNuoYaClgGetInfoRes",
			block = true
		},
		{
			"PM_MiracleNuoYaExtremeClgReq",
			"PM_MiracleNuoYaExtremeClgRes",
			block = true
		},
		{
			"PM_MiracleNuoYaExtremeClgConfirmReq",
			"PM_MiracleNuoYaExtremeClgConfirmRes",
			block = true
		},
		{
			"PM_MiracleNuoYaResetExtremeClgReq",
			"PM_MiracleNuoYaResetExtremeClgRes",
			block = true
		},
		{
			"PM_MiracleNuoYaNormalClgReq",
			"PM_MiracleNuoYaNormalClgRes",
			block = true
		},
		{
			"PM_MiracleNuoYaGainNormalClgProgressPrizeReq",
			"PM_MiracleNuoYaGainNormalClgProgressPrizeRes",
			block = true
		},
		[255] = "MiracleNuoYaClgExtension",
		[101] = {
			"PM_MiracleNuoYaNotifyExtremeClgResultRes"
		},
		[102] = {
			"PM_MiracleNuoYaNotifyNormalClgClgResultRes"
		}
	},
	[552] = {
		{
			"PM_MiracleHeroInfoReq",
			"PM_MiracleHeroInfoRes",
			block = true
		},
		{
			"PM_MiracleHeroRankInfoReq",
			"PM_MiracleHeroRankInfoRes",
			block = true
		},
		{
			"PM_MiracleHeroUpgradePositionReq",
			"PM_MiracleHeroUpgradePositionRes",
			block = true
		},
		{
			"PM_MiracleHeroGetFormationReq",
			"PM_MiracleHeroGetFormationRes",
			block = true
		},
		{
			"PM_MiracleHeroSetFormationReq",
			"PM_MiracleHeroSetFormationRes",
			block = true
		},
		{
			"PM_MiracleHeroChallengeReq",
			"PM_MiracleHeroChallengeRes",
			block = true
		},
		{
			"PM_NotifyMiracleHeroChallengeEndRes"
		},
		[255] = "MiracleHeroExtension",
		[101] = {
			"PM_NotifyMiracleHeroBattleReadyStart"
		},
		[102] = {
			"PM_MiracleHeroBattleStartReq",
			"PM_MiracleHeroBattleStartRes",
			block = true
		},
		[103] = {
			"PM_MiracleHeroSyncBattleReq",
			"PM_MiracleHeroSyncBattleRes",
			block = true
		}
	},
	[553] = {
		{
			"PM_AngelPowerGetInfoReq",
			"PM_AngelPowerGetInfoRes",
			block = true
		},
		{
			"PM_AngelPowerChallengeReq",
			"PM_AngelPowerChallengeRes",
			block = true
		},
		[255] = "AngelPowerExtension",
		[100] = {
			"PM_Notify_AngelPowerChallengeEndRes",
			block = true
		}
	},
	[554] = {
		{
			"PM_FormPredictionGetInfoReq",
			"PM_FormPredictionGetInfoRes",
			block = true
		},
		{
			"PM_FormPredictionSetFormReq",
			"PM_FormPredictionSetFormRes",
			block = true
		},
		{
			"PM_FormPredictionGainPrizeReq",
			"PM_FormPredictionGainPrizeRes",
			block = true
		},
		{
			"PM_FormPredictionGetSelectRatioReq",
			"PM_FormPredictionGetSelectRatioRes",
			block = true
		},
		{
			"PM_FormPredictionRankViewReq",
			"PM_FormPredictionRankViewRes",
			block = true
		},
		[255] = "FormPredictionExtension"
	},
	[555] = {
		{
			"PM_JiuClgGetInfoReq",
			"PM_JiuClgGetInfoRes",
			block = true
		},
		{
			"PM_JiuClgNormalFightReq",
			"PM_JiuClgNormalFightRes",
			block = true
		},
		{
			"PM_JiuClgExtremeFightReq",
			"PM_JiuClgExtremeFightRes",
			block = true
		},
		{
			"PM_JiuClgExtremeFightConfirmReq",
			"PM_JiuClgExtremeFightConfirmRes",
			block = true
		},
		{
			"PM_JiuClgResetExtremePhaseReq",
			"PM_JiuClgResetExtremePhaseRes",
			block = true
		},
		[255] = "JiuClgExtension",
		[101] = {
			"PM_JiuClgNotifyNormalFightResultRes"
		},
		[102] = {
			"PM_JiuClgNotifyExtremeFightResultRes"
		}
	},
	[556] = {
		{
			"PM_DivineJieShenClgGetInfoReq",
			"PM_DivineJieShenClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineJieShenClgExtremeChallengeReq",
			"PM_DivineJieShenClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_DivineJieShenClgResetExtremeStageReq",
			"PM_DivineJieShenClgResetExtremeStageRes",
			block = true
		},
		{
			"PM_DivineJieShenClgNormalRandomTrialReq",
			"PM_DivineJieShenClgNormalRandomTrialRes",
			block = true
		},
		{
			"PM_DivineJieShenClgNormalStartGameReq",
			"PM_DivineJieShenClgNormalStartGameRes",
			block = true
		},
		{
			"PM_DivineJieShenClgNormalFinishGameReq",
			"PM_DivineJieShenClgNormalFinishGameRes",
			block = true
		},
		{
			"PM_DivineJieShenClgNormalChallengeStageReq",
			"PM_DivineJieShenClgNormalChallengeStageRes",
			block = true
		},
		{
			"PM_DivineJieShenClgNormalChallengeBossReq",
			"PM_DivineJieShenClgNormalChallengeBossRes",
			block = true
		},
		[255] = "DivineJieShenClgExtension",
		[100] = {
			"PM_Notify_DivineJieShenClgExtremeChallengeEndRes",
			block = true
		},
		[101] = {
			"PM_Notify_DivineJieShenClgNormalChallengeStageEndRes",
			block = true
		},
		[102] = {
			"PM_Notify_DivineJieShenClgNormalChallengeBossEndRes",
			block = true
		}
	},
	[557] = {
		{
			"PM_PsychicedTowerInfoReq",
			"PM_PsychicedTowerInfoRes",
			block = true
		},
		{
			"PM_PsychicedTowerChallengeReq",
			"PM_PsychicedTowerChallengeRes",
			block = true
		},
		{
			"PM_PsychicedTowerGainBuffReq",
			"PM_PsychicedTowerGainBuffRes",
			block = true
		},
		{
			"PM_PsychicedTowerRankInfoReq",
			"PM_PsychicedTowerRankInfoRes",
			block = true
		},
		{
			"PM_PsychicedTowerTotalRankInfoReq",
			"PM_PsychicedTowerTotalRankInfoRes",
			block = true
		},
		[255] = "PsychicedTowerExtension",
		[10] = {
			"PM_NotifyPsychicedTowerChallengeFinishRes"
		}
	},
	[558] = {
		{
			"PM_HeartOfJieShenClgGetInfoReq",
			"PM_HeartOfJieShenClgGetInfoRes",
			block = true
		},
		{
			"PM_HeartOfJieShenClgFightYiReq",
			"PM_HeartOfJieShenClgFightYiRes",
			block = true
		},
		{
			"PM_HeartOfJieShenClgFightChiReq",
			"PM_HeartOfJieShenClgFightChiRes",
			block = true
		},
		{
			"PM_HeartOfJieShenClgGetHistoryRankReq",
			"PM_HeartOfJieShenClgGetHistoryRankRes",
			block = true
		},
		{
			"PM_HeartOfJieShenClgGetDailyRankReq",
			"PM_HeartOfJieShenClgGetDailyRankRes",
			block = true
		},
		{
			"PM_HeartOfJieShenClgGetRankInfoV0926Req",
			"PM_HeartOfJieShenClgGetRankInfoV0926Res",
			block = true
		},
		[255] = "HeartOfJieShenClgExtension",
		[101] = {
			"PM_HeartOfJieShenClgNotifyFightYiResultRes"
		},
		[102] = {
			"PM_HeartOfJieShenClgNotifyFightChiResultRes"
		}
	},
	[559] = {
		{
			"PM_JieShenVsJiuGetInfoReq",
			"PM_JieShenVsJiuGetInfoRes",
			block = true
		},
		{
			"PM_JieShenVsJiuChooseTeamReq",
			"PM_JieShenVsJiuChooseTeamRes",
			block = true
		},
		{
			"PM_JieShenVsJiuStartGameReq",
			"PM_JieShenVsJiuStartGameRes",
			block = true
		},
		{
			"PM_JieShenVsJiuEndGameReq",
			"PM_JieShenVsJiuEndGameRes",
			block = true
		},
		{
			"PM_JieShenVsJiuGainPrizeReq",
			"PM_JieShenVsJiuGainPrizeRes",
			block = true
		},
		{
			"PM_JieShenVsJiuGainWorldProgressPrizeReq",
			"PM_JieShenVsJiuGainWorldProgressPrizeRes",
			block = true
		},
		[255] = "JieShenVsJiuExtension"
	},
	[561] = {
		{
			"PM_YCKGetInfoReq",
			"PM_YCKGetInfoRes",
			block = true
		},
		{
			"PM_YCKNotifyStepChangeRes"
		},
		{
			"PM_YCKGetVideoReq",
			"PM_YCKGetVideoRes",
			block = true
		},
		{
			"PM_YCKGetDefenseForamtionReq",
			"PM_YCKGetDefenseForamtionRes",
			block = true
		},
		{
			"PM_YCKSetDefenseForamtionReq",
			"PM_YCKSetDefenseForamtionRes",
			block = true
		},
		{
			"PM_YCKKnockoutGetFormationReq",
			"PM_YCKKnockoutGetFormationRes",
			block = true
		},
		{
			"PM_YCKKnockoutSetFormationReq",
			"PM_YCKKnockoutSetFormationRes",
			block = true
		},
		[255] = "YoungChampionKingExtension",
		[11] = {
			"PM_YCKGetQualifierInfoReq",
			"PM_YCKGetQualifierInfoRes",
			block = true
		},
		[14] = {
			"PM_YCKQualifierGetNewOpponentReq",
			"PM_YCKQualifierGetNewOpponentRes",
			block = true
		},
		[15] = {
			"PM_YCKQualifierFightReq",
			"PM_YCKQualifierFightRes",
			block = true
		},
		[16] = {
			"PM_YCKQualifierRecordsReq",
			"PM_YCKQualifierRecordsRes",
			block = true
		},
		[17] = {
			"PM_YCKQualifierRankInfoReq",
			"PM_YCKQualifierRankInfoRes",
			block = true
		},
		[18] = {
			"PM_YCKQualifierPetRaceRankReq",
			"PM_YCKQualifierPetRaceRankRes",
			block = true
		},
		[21] = {
			"PM_YCKMyKnockoutInfoReq",
			"PM_YCKMyKnockoutInfoRes",
			block = true
		},
		[22] = {
			"PM_YCKGetKnockoutScheduleReq",
			"PM_YCKGetKnockoutScheduleRes",
			block = true
		},
		[23] = {
			"PM_YCKGetGuessRecordReq",
			"PM_YCKGetGuessRecordRes",
			block = true
		},
		[24] = {
			"PM_YCKGuessReq",
			"PM_YCKGuessRes",
			block = true
		},
		[26] = {
			"PM_YCKGainGuessCoinReq",
			"PM_YCKGainGuessCoinRes",
			block = true
		},
		[25] = {
			"PM_YCKGetDisplayInfoReq",
			"PM_YCKGetDisplayInfoRes",
			block = true
		},
		[61] = {
			"PM_YCKKnockoutJoinRoomInfoReq",
			"PM_YCKKnockoutJoinRoomInfoRes",
			block = true
		},
		[62] = {
			"PM_YCKKnockoutInviteOpReq",
			"PM_YCKKnockoutInviteOpRes",
			block = true
		},
		[63] = {
			"PM_NotifyYCKKnockoutOpInvitedRes"
		},
		[64] = {
			"PM_YCKKnockoutJoinRoomReq",
			"PM_YCKKnockoutJoinRoomRes",
			block = true
		},
		[65] = {
			"PM_YCKKnockoutLeaveRoomReq",
			"PM_YCKKnockoutLeaveRoomRes",
			block = true
		},
		[66] = {
			"PM_NotifyYCKKnockoutOpJoinRoomRes"
		},
		[67] = {
			"PM_NotifyYCKKnockoutFightStartRes"
		},
		[68] = {
			"PM_YCKKnockoutSetGameFormationReq",
			"PM_YCKKnockoutSetGameFormationRes",
			block = true
		},
		[69] = {
			"PM_NotifyYCKKnockoutSetGameFormationFailRes"
		},
		[70] = {
			"PM_NotifyYCKKnockoutOpSetFormationFinishRes"
		},
		[71] = {
			"PM_NotifyYCKKnockoutTurnToNextGameRoundRes"
		},
		[72] = {
			"PM_NotifyYCKKnockoutGameEndRes"
		},
		[73] = {
			"PM_YCKKnockoutSyncRoomInfoReq",
			"PM_YCKKnockoutSyncRoomInfoRes",
			block = true
		}
	},
	[562] = {
		{
			"PM_RoguelikeGetInfoReq",
			"PM_RoguelikeGetInfoRes",
			block = true
		},
		{
			"PM_RoguelikeLvlUpGlobalBuffReq",
			"PM_RoguelikeLvlUpGlobalBuffRes",
			block = true
		},
		{
			"PM_RoguelikeResetGlobalBuffLvlReq",
			"PM_RoguelikeResetGlobalBuffLvlRes",
			block = true
		},
		{
			"PM_RoguelikeSetGlobalBuffOnOffReq",
			"PM_RoguelikeSetGlobalBuffOnOffRes",
			block = true
		},
		{
			"PM_RoguelikeSetRentPetUsingOrNotReq",
			"PM_RoguelikeSetRentPetUsingOrNotRes",
			block = true
		},
		{
			"PM_RoguelikeRerandomDropBuffReq",
			"PM_RoguelikeRerandomDropBuffRes",
			block = true
		},
		{
			"PM_RoguelikeSelectDropBuffReq",
			"PM_RoguelikeSelectDropBuffRes",
			block = true
		},
		{
			"PM_RoguelikeReShuffleDropBuffReq",
			"PM_RoguelikeReShuffleDropBuffRes",
			block = true
		},
		{
			"PM_RoguelikeGainNormalPrizeReq",
			"PM_RoguelikeGainNormalPrizeRes",
			block = true
		},
		{
			"PM_RoguelikeStartFightReq",
			"PM_RoguelikeStartFightRes",
			block = true
		},
		{
			"PM_RoguelikeContunieFightReq",
			"PM_RoguelikeContunieFightRes",
			block = true
		},
		{
			"PM_RoguelikeGetKillRankReq",
			"PM_RoguelikeGetKillRankRes",
			block = true
		},
		{
			"PM_RoguelikeGetPassRankReq",
			"PM_RoguelikeGetPassRankRes",
			block = true
		},
		[255] = "RoguelikeExtension",
		[101] = {
			"PM_RoguelikeNotifyFightResultRes"
		}
	},
	[563] = {
		{
			"PM_ChuangZhengliClgGetInfoReq",
			"PM_ChuangZhengliClgGetInfoRes",
			block = true
		},
		{
			"PM_ChuangZhengliClgChallengeReq",
			"PM_ChuangZhengliClgChallengeRes",
			block = true
		},
		{
			"PM_ChuangZhengliClgResetStageReq",
			"PM_ChuangZhengliClgResetStageRes",
			block = true
		},
		{
			"PM_ChuangZhengliClgUpgradeBuffReq",
			"PM_ChuangZhengliClgUpgradeBuffRes",
			block = true
		},
		[255] = "ChuangZhengliClgExtension",
		[100] = {
			"PM_Notify_ChuangZhengliClgChallengeEndRes",
			block = true
		}
	},
	[564] = {
		{
			"PM_DivineXiuNuoClgGetInfoReq",
			"PM_DivineXiuNuoClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineXiuNuoClgFightReq",
			"PM_DivineXiuNuoClgFightRes",
			block = true
		},
		{
			"PM_DivineXiuNuoClgResetStageReq",
			"PM_DivineXiuNuoClgResetStageRes",
			block = true
		},
		[255] = "DivineXiuNuoClgExtension",
		[101] = {
			"PM_DivineXiuNuoClgNotifyFightResultRes"
		}
	},
	[565] = {
		{
			"PM_ChuangJingRoadGetInfoReq",
			"PM_ChuangJingRoadGetInfoRes",
			block = true
		},
		{
			"PM_ChuangJingRoadGainProgressPrizeReq",
			"PM_ChuangJingRoadGainProgressPrizeRes",
			block = true
		},
		{
			"PM_ChuangJingRoadRankReq",
			"PM_ChuangJingRoadRankRes",
			block = true
		},
		[255] = "ChuangJingRoadExtension",
		[10] = {
			"PM_ChuangJingRoadPetInfoReq",
			"PM_ChuangJingRoadPetInfoRes",
			block = true
		},
		[11] = {
			"PM_ChuangJingRoadBuyPetReq",
			"PM_ChuangJingRoadBuyPetRes",
			block = true
		},
		[12] = {
			"PM_ChuangJingRoadUpgradeLevelReq",
			"PM_ChuangJingRoadUpgradeLevelRes",
			block = true
		},
		[13] = {
			"PM_ChuangJingRoadEquipmentLvReq",
			"PM_ChuangJingRoadEquipmentLvRes",
			block = true
		},
		[14] = {
			"PM_ChuangJingRoadStarGodPlusLvReq",
			"PM_ChuangJingRoadStarGodPlusLvRes",
			block = true
		},
		[15] = {
			"PM_ChuangJingRoadAwakenLvUpReq",
			"PM_ChuangJingRoadAwakenLvUpRes",
			block = true
		},
		[16] = {
			"PM_ChuangJingRoadHolyStripeLevelUpReq",
			"PM_ChuangJingRoadHolyStripeLevelUpRes",
			block = true
		},
		[20] = {
			"PM_ChuangJingRoadChallengeReq",
			"PM_ChuangJingRoadChallengeRes",
			block = true
		},
		[21] = {
			"PM_ChuangJingRoadBossChallengeReq",
			"PM_ChuangJingRoadBossChallengeRes",
			block = true
		},
		[22] = {
			"PM_ChuangJingRoadLightBossChallengeReq",
			"PM_ChuangJingRoadLightBossChallengeRes",
			block = true
		},
		[23] = {
			"PM_ChuangJingRoadWaterBossChallengeReq",
			"PM_ChuangJingRoadWaterBossChallengeRes",
			block = true
		},
		[24] = {
			"PM_ChuangJingRoadFireBossChallengeReq",
			"PM_ChuangJingRoadFireBossChallengeRes",
			block = true
		},
		[25] = {
			"PM_ChuangJingRoadGrassBossChallengeReq",
			"PM_ChuangJingRoadGrassBossChallengeRes",
			block = true
		},
		[26] = {
			"PM_ChuangJingRoadResetBossReq",
			"PM_ChuangJingRoadResetBossRes",
			block = true
		},
		[27] = {
			"PM_ChuangJingRoadFirstPassInfoReq",
			"PM_ChuangJingRoadFirstPassInfoRes",
			block = true
		},
		[101] = {
			"PM_NotifyChallengeFightEndRes"
		},
		[102] = {
			"PM_NotifyChallengeBossFightEndRes"
		},
		[103] = {
			"PM_NotifyChallengeLightBossFightEndRes"
		},
		[104] = {
			"PM_NotifyChallengeWaterBossFightEndRes"
		},
		[105] = {
			"PM_NotifyChallengeFireBossFightEndRes"
		},
		[106] = {
			"PM_NotifyChallengeGrassBossFightEndRes"
		}
	},
	[566] = {
		{
			"PM_JieShenEventGetInfoReq",
			"PM_JieShenEventGetInfoRes",
			block = true
		},
		{
			"PM_JieShenEventFinishGameReq",
			"PM_JieShenEventFinishGameRes",
			block = true
		},
		{
			"PM_JieShenEvnetGainTimelinePrizeReq",
			"PM_JieShenEvnetGainTimelinePrizeRes",
			block = true
		},
		{
			"PM_JieShenEvnetComboClueReq",
			"PM_JieShenEvnetComboClueRes",
			block = true
		},
		{
			"PM_JieShenEvnetGainCluePrizeReq",
			"PM_JieShenEvnetGainCluePrizeRes",
			block = true
		},
		[255] = "JieShenEventExtension"
	},
	[567] = {
		{
			"PM_DivineMiYaClgGetInfoReq",
			"PM_DivineMiYaClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineMiYaClgFightReq",
			"PM_DivineMiYaClgFightRes",
			block = true
		},
		{
			"PM_DivineMiYaClgSwitchStageReq",
			"PM_DivineMiYaClgSwitchStageRes",
			block = true
		},
		{
			"PM_DivineMiYaClgReset2StageReq",
			"PM_DivineMiYaClgReset2StageRes",
			block = true
		},
		{
			"PM_DivineMiYaClgGainDailyBuffReq",
			"PM_DivineMiYaClgGainDailyBuffRes",
			block = true
		},
		{
			"PM_DivineMiYaClgGainProgressPrizeReq",
			"PM_DivineMiYaClgGainProgressPrizeRes",
			block = true
		},
		[255] = "DivineMiYaClgExtension",
		[101] = {
			"PM_DivineMiYaClgNotifyFightResultRes"
		}
	},
	[568] = {
		{
			"PM_DivineBountyGetLotteryInfoReq",
			"PM_DivineBountyGetLotteryInfoRes",
			block = true
		},
		{
			"PM_DivineBountyLotteryReq",
			"PM_DivineBountyLotteryRes",
			block = true
		},
		{
			"PM_DivineBountyGetShopInfoReq",
			"PM_DivineBountyGetShopInfoRes",
			block = true
		},
		{
			"PM_DivineBountyBuyShopItemReq",
			"PM_DivineBountyBuyShopItemRes",
			block = true
		},
		[255] = "DivineBountyExtension"
	},
	[569] = {
		{
			"PM_DivineDakinosClgGetInfoReq",
			"PM_DivineDakinosClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineDakinosClgFightReq",
			"PM_DivineDakinosClgFightRes",
			block = true
		},
		{
			"PM_DivineDakinosClgUpgradeBuffReq",
			"PM_DivineDakinosClgUpgradeBuffRes",
			block = true
		},
		[255] = "DivineDakinosClgExtension",
		[10] = {
			"PM_DivineDakinosClgNotifyFightResultRes"
		}
	},
	[570] = {
		{
			"PM_PetActiveGetInfoReq",
			"PM_PetActiveGetInfoRes",
			block = true
		},
		{
			"PM_PetActiveGetUnlockReq",
			"PM_PetActiveGetUnlockRes",
			block = true
		},
		{
			"PM_PetActiveGetDirectBuyReq",
			"PM_PetActiveGetDirectBuyRes",
			block = true
		},
		{
			"PM_PetActiveGetExchangePropReq",
			"PM_PetActiveGetExchangePropRes",
			block = true
		},
		[255] = "PetActiveGetExtension"
	},
	[571] = {
		{
			"PM_DomainAdventureGetInfoReq",
			"PM_DomainAdventureGetInfoRes",
			block = true
		},
		{
			"PM_DomainAdventureLoadMapReq",
			"PM_DomainAdventureLoadMapRes",
			block = true
		},
		{
			"PM_DomainAdventureActionReq",
			"PM_DomainAdventureActionRes",
			block = true
		},
		{
			"PM_DomainAdventureGainGlobalPrizeReq",
			"PM_DomainAdventureGainGlobalPrizeRes",
			block = true
		},
		{
			"PM_DomainAdventureRankViewReq",
			"PM_DomainAdventureRankViewRes",
			block = true
		},
		[255] = "DomainAdventureExtension",
		[10] = {
			"PM_DomainAdventureNotifyActionRes"
		},
		[11] = {
			"PM_DomainAdventureOccupiedChangesRes"
		}
	},
	[572] = {
		{
			"PM_SummonMasterHopeClgGetInfoReq",
			"PM_SummonMasterHopeClgGetInfoRes",
			block = true
		},
		{
			"PM_SummonMasterHopeClgFightReq",
			"PM_SummonMasterHopeClgFightRes",
			block = true
		},
		{
			"PM_SummonMasterHopeClgGetGodRankReq",
			"PM_SummonMasterHopeClgGetGodRankRes",
			block = true
		},
		{
			"PM_SummonMasterHopeClgGetDailyRankReq",
			"PM_SummonMasterHopeClgGetDailyRankRes",
			block = true
		},
		[255] = "SummonMasterHopeClgExtension",
		[101] = {
			"PM_SummonMasterHopeClgNotifyFightResultRes"
		}
	},
	[573] = {
		{
			"PM_DivineKingCiYuanGetInfoReq",
			"PM_DivineKingCiYuanGetInfoRes",
			block = true
		},
		{
			"PM_DivineKingCiYuanFightReq",
			"PM_DivineKingCiYuanFightRes",
			block = true
		},
		{
			"PM_DivineKingCiYuanResetReq",
			"PM_DivineKingCiYuanResetRes",
			block = true
		},
		[255] = "DivineKingCiYuanExtension",
		[10] = {
			"PM_DivineKingCiYuanNotifyFightResultRes"
		}
	},
	[574] = {
		{
			"PM_NuoYaSisterExtremeClgInfoReq",
			"PM_NuoYaSisterExtremeClgInfoRes",
			block = true
		},
		{
			"PM_NuoYaSisterExtremeClgSeletPetReq",
			"PM_NuoYaSisterExtremeClgSeletPetRes",
			block = true
		},
		{
			"PM_NuoYaSisterExtremeClgReq",
			"PM_NuoYaSisterExtremeClgRes",
			block = true
		},
		{
			"PM_NuoYaSisterExtremeClgResetReq",
			"PM_NuoYaSisterExtremeClgResetRes",
			block = true
		},
		{
			"PM_NuoYaSisterCommonClgInfoReq",
			"PM_NuoYaSisterCommonClgInfoRes",
			block = true
		},
		{
			"PM_NuoYaSisterCommonClgReq",
			"PM_NuoYaSisterCommonClgRes",
			block = true
		},
		{
			"PM_NuoYaSisterCommonClgGainPrizeReq",
			"PM_NuoYaSisterCommonClgGainPrizeRes",
			block = true
		},
		{
			"PM_NuoYaSisterExtremeClgResultConfirmReq",
			"PM_NuoYaSisterExtremeClgResultConfirmRes",
			block = true
		},
		[255] = "NuoYaSisterClgExtension",
		[10] = {
			"PM_NotifyNuoYaSisterExtremeClgFinishRes"
		},
		[11] = {
			"PM_NotifyNuoYaSisterCommonClgFinishRes"
		}
	},
	[575] = {
		{
			"PM_CiYuanDragonNuoYaClgGetInfoReq",
			"PM_CiYuanDragonNuoYaClgGetInfoRes",
			block = true
		},
		{
			"PM_CiYuanDragonNuoYaClgFightReq",
			"PM_CiYuanDragonNuoYaClgFightRes",
			block = true
		},
		{
			"PM_CiYuanDragonNuoYaClgConfirmReq",
			"PM_CiYuanDragonNuoYaClgConfirmRes",
			block = true
		},
		{
			"PM_CiYuanDragonNuoYaClgResetStageReq",
			"PM_CiYuanDragonNuoYaClgResetStageRes",
			block = true
		},
		[255] = "CiYuanDragonNuoYaClgExtension",
		[101] = {
			"PM_CiYuanDragonNuoYaClgNotifyFightResultRes"
		}
	},
	[576] = {
		{
			"PM_WheelLotteryGetInfoReq",
			"PM_WheelLotteryGetInfoRes",
			block = true
		},
		{
			"PM_WheelLotteryLotteryReq",
			"PM_WheelLotteryLotteryRes",
			block = true
		},
		[255] = "WheelLotteryExtension"
	},
	[577] = {
		{
			"PM_DivineCoronateGetInfoReq",
			"PM_DivineCoronateGetInfoRes",
			block = true
		},
		{
			"PM_DivineCoronateStartGameReq",
			"PM_DivineCoronateStartGameRes",
			block = true
		},
		{
			"PM_DivineCoronateEndGameReq",
			"PM_DivineCoronateEndGameRes",
			block = true
		},
		{
			"PM_DivineCoronateGainPrizeReq",
			"PM_DivineCoronateGainPrizeRes",
			block = true
		},
		[255] = "DivineCoronateExtension"
	},
	[578] = {
		{
			"PM_BorrowPetGetActivityInfosReq",
			"PM_BorrowPetGetActivityInfosRes",
			block = true
		},
		{
			"PM_BorrowPetBorrowReq",
			"PM_BorrowPetBorrowRes",
			block = true
		},
		[255] = "BorrowPetExtension"
	},
	[579] = {
		{
			"BeastFightingChessInfoReq",
			"BeastFightingChessInfoRes",
			block = true
		},
		{
			"BeastFightingChessGainPrizeReq",
			"BeastFightingChessGainPrizeRes",
			block = true
		},
		{
			"BeastFightingChessFinishNewHandReq",
			"BeastFightingChessFinishNewHandRes",
			block = true
		},
		{
			"BeastFightingChessRecordReq",
			"BeastFightingChessRecordRes",
			block = true
		},
		{
			"BeastFightingChessRankReq",
			"BeastFightingChessRankRes",
			block = true
		},
		{
			"BeastFightingChessSelectSkillReq",
			"BeastFightingChessSelectSkillRes",
			block = true
		},
		{
			"BeastFightingChessMatchReq",
			"BeastFightingChessMatchRes",
			block = true
		},
		{
			"BeastFightingChessCancelMatchReq",
			"BeastFightingChessCancelMatchRes",
			block = true
		},
		{
			"BeastFightingChessMatchRobotReq",
			"BeastFightingChessMatchRobotRes",
			block = true
		},
		{
			"BeastFightingChessLeaveRoomReq",
			"BeastFightingChessLeaveRoomRes",
			block = true
		},
		{
			"BeastFightingChessReleaseSkillReq",
			"BeastFightingChessReleaseSkillRes",
			block = true
		},
		{
			"BeastFightingChessOpenChessReq",
			"BeastFightingChessOpenChessRes",
			block = true
		},
		{
			"BeastFightingChessMoveReq",
			"BeastFightingChessMoveRes",
			block = true
		},
		{
			"BeastFightingChessRequestTieReq",
			"BeastFightingChessRequestTieRes",
			block = true
		},
		{
			"BeastFightingChessHandleTieReq",
			"BeastFightingChessHandleTieRes",
			block = true
		},
		{
			"BeastFightingChessSendEmoticonReq",
			"BeastFightingChessSendEmoticonRes",
			block = true
		},
		[255] = "BeastFightingChessExtension",
		[101] = {
			"NotifyBeastFightingChessMatchOverTimeRes"
		},
		[102] = {
			"NotifyBeastFightingChessMatchFailRes"
		},
		[103] = {
			"NotifyBeastFightingChessMatchRobotFailRes"
		},
		[104] = {
			"NotifyBeastFightingChessStartGameRes"
		},
		[105] = {
			"NotifyBeastFightingChessActionRes"
		},
		[106] = {
			"NotifyBeastFightingChessOpRequestTieRes"
		},
		[107] = {
			"NotifyBeastFightingChessOpHandleTieRes"
		},
		[108] = {
			"NotifyBeastFightingChessOpEmoticonRes"
		},
		[109] = {
			"NotifyBeastFightingChessGameEndRes"
		},
		[110] = {
			"NotifyBeastFightingChessErrorRes"
		}
	},
	[581] = {
		{
			"PM_RoseClgGetInfoReq",
			"PM_RoseClgGetInfoRes",
			block = true
		},
		{
			"PM_RoseClgChallengeReq",
			"PM_RoseClgChallengeRes",
			block = true
		},
		{
			"PM_RoseClgResetReq",
			"PM_RoseClgResetRes",
			block = true
		},
		{
			"PM_RoseClgUpgradeBuffReq",
			"PM_RoseClgUpgradeBuffRes",
			block = true
		},
		[255] = "RoseClgExtension",
		[100] = {
			"PM_NotifyRoseClgChallengeEndRes",
			block = true
		}
	},
	[583] = {
		{
			"PM_ReviveElizabethGetInfoReq",
			"PM_ReviveElizabethGetInfoRes",
			block = true
		},
		{
			"PM_ReviveElizabethHandleFieldReq",
			"PM_ReviveElizabethHandleFieldRes",
			block = true
		},
		{
			"PM_ReviveElizabethGainPrizeReq",
			"PM_ReviveElizabethGainPrizeRes",
			block = true
		},
		{
			"PM_ReviveElizabethInjectSoulReq",
			"PM_ReviveElizabethInjectSoulRes",
			block = true
		},
		[255] = "ReviveElizabethExtension"
	},
	[584] = {
		{
			"PM_MiMengLiClgGetInfoReq",
			"PM_MiMengLiClgGetInfoRes",
			block = true
		},
		{
			"PM_MiMengLiClgSelectPetReq",
			"PM_MiMengLiClgSelectPetRes",
			block = true
		},
		{
			"PM_MiMengLiClgStageSelectTagReq",
			"PM_MiMengLiClgStageSelectTagRes",
			block = true
		},
		{
			"PM_MiMengLiClgStageNormalFightReq",
			"PM_MiMengLiClgStageNormalFightRes",
			block = true
		},
		{
			"PM_MiMengLiClgConfirmReq",
			"PM_MiMengLiClgConfirmRes",
			block = true
		},
		{
			"PM_MiMengLiClgBuyNUseShopGoodsReq",
			"PM_MiMengLiClgBuyNUseShopGoodsRes",
			block = true
		},
		{
			"PM_MiMengLiClgStageBossFightReq",
			"PM_MiMengLiClgStageBossFightRes",
			block = true
		},
		{
			"PM_MiMengLiClgResetClgReq",
			"PM_MiMengLiClgResetClgRes",
			block = true
		},
		[255] = "MiMengLiClgExtension",
		[101] = {
			"PM_MiMengLiClgNotifyStageNormalFightRes"
		}
	},
	[585] = {
		{
			"PM_KingArenaGetInfoReq",
			"PM_KingArenaGetInfoRes",
			block = true
		},
		{
			"PM_KingArenaFightReq",
			"PM_KingArenaFightRes",
			block = true
		},
		{
			"PM_KingArenaViewFormReq",
			"PM_KingArenaViewFormRes",
			block = true
		},
		{
			"PM_KingArenaSetDefenseFormReq",
			"PM_KingArenaSetDefenseFormRes",
			block = true
		},
		{
			"PM_KingArenaRefreshOpReq",
			"PM_KingArenaRefreshOpRes",
			block = true
		},
		{
			"PM_KingArenaBuyFightTimesReq",
			"PM_KingArenaBuyFightTimesRes",
			block = true
		},
		{
			"PM_KingArenaGainSeasonPrizeReq",
			"PM_KingArenaGainSeasonPrizeRes",
			block = true
		},
		{
			"PM_KingArenaResetZoneReq",
			"PM_KingArenaResetZoneRes",
			block = true
		},
		{
			"PM_KingArenaGetRecordsReq",
			"PM_KingArenaGetRecordsRes",
			block = true
		},
		{
			"PM_KingArenaBattleVideoReq",
			"PM_KingArenaBattleVideoRes",
			block = true
		},
		{
			"PM_KingArenaRankViewReq",
			"PM_KingArenaRankViewRes",
			block = true
		},
		{
			"PM_KingArenaPetRankViewReq",
			"PM_KingArenaPetRankViewRes",
			block = true
		},
		[255] = "KingArenaExtension"
	},
	[586] = {
		{
			"PM_DivineTSDragonLordClgGetInfoReq",
			"PM_DivineTSDragonLordClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineTSDragonLordClgChallengeReq",
			"PM_DivineTSDragonLordClgChallengeRes",
			block = true
		},
		{
			"PM_DivineTSDragonLordClgConfirmScoreReq",
			"PM_DivineTSDragonLordClgConfirmScoreRes",
			block = true
		},
		[255] = "DivineTSDragonLordClgExtension",
		[100] = {
			"PM_Notify_DivineTSDragonLordClgChallengeEndRes",
			block = true
		}
	},
	[587] = {
		{
			"PM_FameHallGetInfoReq",
			"PM_FameHallGetInfoRes",
			block = true
		},
		[255] = "FameHallExtension"
	},
	[588] = {
		{
			"PM_DragonAwakenGetInfoReq",
			"PM_DragonAwakenGetInfoRes",
			block = true
		},
		{
			"PM_DragonAwakenBuyPetReq",
			"PM_DragonAwakenBuyPetRes",
			block = true
		},
		{
			"PM_DragonAwakenUpgradeReq",
			"PM_DragonAwakenUpgradeRes",
			block = true
		},
		{
			"PM_DragonAwakenTrainingFightReq",
			"PM_DragonAwakenTrainingFightRes",
			block = true
		},
		{
			"PM_DragonAwakenConfirmResultReq",
			"PM_DragonAwakenConfirmResultRes",
			block = true
		},
		{
			"PM_DragonAwakenPhaseFightReq",
			"PM_DragonAwakenPhaseFightRes",
			block = true
		},
		{
			"PM_DragonAwakenRankViewReq",
			"PM_DragonAwakenRankViewRes",
			block = true
		},
		{
			"PM_DragonAwakenRandomFormReq",
			"PM_DragonAwakenRandomFormRes",
			block = true
		},
		[255] = "DragonAwakenExtension",
		[101] = {
			"PM_DragonAwakenNotifyTrainingRes"
		},
		[102] = {
			"PM_DragonAwakenNotifyPhaseFightRes"
		}
	},
	[589] = {
		{
			"PM_JiClgGetInfoReq",
			"PM_JiClgGetInfoRes",
			block = true
		},
		{
			"PM_JiClgNormalStageReq",
			"PM_JiClgNormalStageRes",
			block = true
		},
		{
			"PM_JiClgNormalBossReq",
			"PM_JiClgNormalBossRes",
			block = true
		},
		{
			"PM_JiClgExtremeStageReq",
			"PM_JiClgExtremeStageRes",
			block = true
		},
		{
			"PM_JiClgConfirmExtremeScoreReq",
			"PM_JiClgConfirmExtremeScoreRes",
			block = true
		},
		{
			"PM_JiClgGainPrizeReq",
			"PM_JiClgGainPrizeRes",
			block = true
		},
		[255] = "JiClgExtension",
		[100] = {
			"PM_Notify_JiClgNormalStageEndRes",
			block = true
		},
		[101] = {
			"PM_Notify_JiClgNormalBossEndRes",
			block = true
		},
		[102] = {
			"PM_Notify_JiClgExtremeStageEndRes",
			block = true
		}
	},
	[590] = {
		{
			"PM_DivineJiClgGetInfoReq",
			"PM_DivineJiClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineJiExtremeFightReq",
			"PM_DivineJiExtremeFightRes",
			block = true
		},
		{
			"PM_DivineJiResetExtremeClgStageReq",
			"PM_DivineJiResetExtremeClgStageRes",
			block = true
		},
		{
			"PM_DivineJiNormalFightReq",
			"PM_DivineJiNormalFightRes",
			block = true
		},
		{
			"PM_DivineJiGainNormalClgPrizeReq",
			"PM_DivineJiGainNormalClgPrizeRes",
			block = true
		},
		[255] = "DivineJiClgExtension",
		[101] = {
			"PM_DivineJiNotifyExtremeFightResultRes"
		},
		[102] = {
			"PM_DivineJiNotifyNormalFightResultRes"
		}
	},
	[591] = {
		{
			"PM_DisorderPowerGetInfoReq",
			"PM_DisorderPowerGetInfoRes",
			block = true
		},
		{
			"PM_DisorderPowerLotteryReq",
			"PM_DisorderPowerLotteryRes",
			block = true
		},
		{
			"PM_DisorderPowerFightReq",
			"PM_DisorderPowerFightRes",
			block = true
		},
		{
			"PM_DisorderPowerGainPrizeReq",
			"PM_DisorderPowerGainPrizeRes",
			block = true
		},
		[255] = "DisorderPowerExtension",
		[101] = {
			"PM_DisorderPowerNotifyFightRes"
		}
	},
	[592] = {
		{
			"PM_DivineDisorderDragonGetInfoReq",
			"PM_DivineDisorderDragonGetInfoRes",
			block = true
		},
		{
			"PM_DivineDisorderDragonFightReq",
			"PM_DivineDisorderDragonFightRes",
			block = true
		},
		[255] = "DivineDisorderDragonExtension",
		[101] = {
			"PM_DivineDisorderDragonNotifyFightRes"
		}
	},
	[593] = {
		{
			"PM_AoqiGodInfoReq",
			"PM_AoqiGodInfoRes",
			block = true
		},
		{
			"PM_AoqiGodSeekHelpReq",
			"PM_AoqiGodSeekHelpRes",
			block = true
		},
		{
			"PM_AoqiGodSeekHelpWallReq",
			"PM_AoqiGodSeekHelpWallRes",
			block = true
		},
		{
			"PM_AoqiGodRefreshHelpWallReq",
			"PM_AoqiGodRefreshHelpWallRes",
			block = true
		},
		{
			"PM_AoqiGodSearchSeekHelpItemReq",
			"PM_AoqiGodSearchSeekHelpItemRes",
			block = true
		},
		{
			"PM_AoqiGodGetHelpItemInfoReq",
			"PM_AoqiGodGetHelpItemInfoRes",
			block = true
		},
		{
			"PM_AoqiGodAcceptHelpItemReq",
			"PM_AoqiGodAcceptHelpItemRes",
			block = true
		},
		{
			"PM_AoqiGodGiveUpHelpItemReq",
			"PM_AoqiGodGiveUpHelpItemRes",
			block = true
		},
		{
			"PM_AoqiGodHelpRecordReq",
			"PM_AoqiGodHelpRecordRes",
			block = true
		},
		{
			"PM_AoqiGodRankReq",
			"PM_AoqiGodRankRes",
			block = true
		},
		{
			"PM_AoqiGodChallengeRankReq",
			"PM_AoqiGodChallengeRankRes",
			block = true
		},
		[13] = {
			"PM_AoqiGodChangeBuffSwitchReq",
			"PM_AoqiGodChangeBuffSwitchRes",
			block = true
		},
		{
			"PM_NotifyAoqiGodChallengeFinishRes"
		},
		[255] = "AoqiGodExtension"
	},
	[594] = {
		{
			"PM_WalkWithNoahGetInfoReq",
			"PM_WalkWithNoahGetInfoRes",
			block = true
		},
		{
			"PM_WalkWithNoahPlacePieceReq",
			"PM_WalkWithNoahPlacePieceRes",
			block = true
		},
		{
			"PM_WalkWithNoahGainPrizeReq",
			"PM_WalkWithNoahGainPrizeRes",
			block = true
		},
		[255] = "WalkWithNoahExtension"
	},
	[595] = {
		{
			"PM_DragonVeinNuoYaClgGetInfoReq",
			"PM_DragonVeinNuoYaClgGetInfoRes",
			block = true
		},
		{
			"PM_DragonVeinNuoYaClgDigReq",
			"PM_DragonVeinNuoYaClgDigRes",
			block = true
		},
		{
			"PM_DragonVeinNuoYaClgFightReq",
			"PM_DragonVeinNuoYaClgFightRes",
			block = true
		},
		{
			"PM_DragonVeinNuoYaClgGainBoxReq",
			"PM_DragonVeinNuoYaClgGainBoxRes",
			block = true
		},
		{
			"PM_DragonVeinNuoYaClgJump2NextStageReq",
			"PM_DragonVeinNuoYaClgJump2NextStageRes",
			block = true
		},
		[255] = "DragonVeinNuoYaClgExtension",
		[101] = {
			"PM_DragonVeinNuoYaClgNotifyFightResultRes"
		}
	},
	[596] = {
		{
			"PM_DSoulPredictGetInfoReq",
			"PM_DSoulPredictGetInfoRes",
			block = true
		},
		{
			"PM_DSoulPredictPredictReq",
			"PM_DSoulPredictPredictRes",
			block = true
		},
		{
			"PM_DSoulPredictVoteReq",
			"PM_DSoulPredictVoteRes",
			block = true
		},
		{
			"PM_DSoulPredictGainPrizeReq",
			"PM_DSoulPredictGainPrizeRes",
			block = true
		},
		[255] = "DSoulPredictExtension"
	},
	[597] = {
		{
			"PM_KingMoYanClgInfoReq",
			"PM_KingMoYanClgInfoRes",
			block = true
		},
		{
			"PM_KingMoYanClgChallengeReq",
			"PM_KingMoYanClgChallengeRes",
			block = true
		},
		{
			"PM_KingMoYanClgConfirmReq",
			"PM_KingMoYanClgConfirmRes",
			block = true
		},
		{
			"PM_KingMoYanClgResetReq",
			"PM_KingMoYanClgResetRes",
			block = true
		},
		[255] = "KingMoYanClgExtension",
		[10] = {
			"PM_NotifyKingMoYanClgFinishRes"
		}
	},
	[598] = {
		{
			"PM_DarknessSpringGetInfoReq",
			"PM_DarknessSpringGetInfoRes",
			block = true
		},
		{
			"PM_DarknessSpringUnlockReq",
			"PM_DarknessSpringUnlockRes",
			block = true
		},
		{
			"PM_DarknessSpringGainStage2PrizeReq",
			"PM_DarknessSpringGainStage2PrizeRes",
			block = true
		},
		[255] = "DarknessSpringExtension"
	},
	[599] = {
		{
			"PM_GuessPuzzleGetInfoReq",
			"PM_GuessPuzzleGetInfoRes",
			block = true
		},
		{
			"PM_GuessPuzzleFinishGridReq",
			"PM_GuessPuzzleFinishGridRes",
			block = true
		},
		{
			"PM_GuessPuzzleGainPrizeReq",
			"PM_GuessPuzzleGainPrizeRes",
			block = true
		},
		[255] = "GuessPuzzleExtension"
	},
	[600] = {
		{
			"PM_SnowmanCarInfoReq",
			"PM_SnowmanCarInfoRes",
			block = true
		},
		{
			"PM_SnowmanCarStartReq",
			"PM_SnowmanCarStartRes",
			block = true
		},
		{
			"PM_SnowmanCarEndReq",
			"PM_SnowmanCarEndRes",
			block = true
		},
		{
			"PM_SnowmanCarGainPrizeReq",
			"PM_SnowmanCarGainPrizeRes",
			block = true
		},
		[255] = "SnowmanCarExtension"
	},
	[601] = {
		{
			"PM_DivineWeiLeiTaClgNormalInfoReq",
			"PM_DivineWeiLeiTaClgNormalInfoRes",
			block = true
		},
		{
			"PM_DivineWeiLeiTaClgNormalChallengeReq",
			"PM_DivineWeiLeiTaClgNormalChallengeRes",
			block = true
		},
		{
			"PM_DivineWeiLeiTaClgGainPrizeReq",
			"PM_DivineWeiLeiTaClgGainPrizeRes",
			block = true
		},
		{
			"PM_DivineWeiLeiTaClgExtremeInfoReq",
			"PM_DivineWeiLeiTaClgExtremeInfoRes",
			block = true
		},
		{
			"PM_DivineWeiLeiTaClgExtremeChallengeReq",
			"PM_DivineWeiLeiTaClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_DivineWeiLeiTaClgExtremeConfirmReq",
			"PM_DivineWeiLeiTaClgExtremeConfirmRes",
			block = true
		},
		{
			"PM_DivineWeiLeiTaClgExtremeResetReq",
			"PM_DivineWeiLeiTaClgExtremeResetRes",
			block = true
		},
		[255] = "DivineWeiLeiTaClgExtension",
		[10] = {
			"PM_NotifyDivineWeiLeiTaNormalClgFinishRes"
		},
		[11] = {
			"PM_NotifyDivineWeiLeiTaExtremeClgFinishRes"
		}
	},
	[602] = {
		{
			"PM_UltimateWarGetMainInfoReq",
			"PM_UltimateWarGetMainInfoRes",
			block = true
		},
		{
			"PM_UltimateWarUpPetLevelReq",
			"PM_UltimateWarUpPetLevelRes",
			block = true
		},
		{
			"PM_UltimateWarFinishPlotReq",
			"PM_UltimateWarFinishPlotRes",
			block = true
		},
		{
			"PM_UltimateWarFirstStepInfoReq",
			"PM_UltimateWarFirstStepInfoRes",
			block = true
		},
		{
			"PM_UltimateWarDispatchReq",
			"PM_UltimateWarDispatchRes",
			block = true
		},
		{
			"PM_UltimateWarGainHangingPrizeReq",
			"PM_UltimateWarGainHangingPrizeRes",
			block = true
		},
		{
			"PM_UltimateWarSecondStepInfoReq",
			"PM_UltimateWarSecondStepInfoRes",
			block = true
		},
		{
			"PM_UltimateWarTowerFightReq",
			"PM_UltimateWarTowerFightRes",
			block = true
		},
		{
			"PM_UltimateWarContinueTowerFightReq",
			"PM_UltimateWarContinueTowerFightRes",
			block = true
		},
		{
			"PM_UltimateWarTowerBossFightReq",
			"PM_UltimateWarTowerBossFightRes",
			block = true
		},
		{
			"PM_UltimateWarGainTowerBossPrizeReq",
			"PM_UltimateWarGainTowerBossPrizeRes",
			block = true
		},
		{
			"PM_UltimateWarSubmitTowerBossFormReq",
			"PM_UltimateWarSubmitTowerBossFormRes",
			block = true
		},
		{
			"PM_UltimateWarThirdStepInfoReq",
			"PM_UltimateWarThirdStepInfoRes",
			block = true
		},
		{
			"PM_UltimateWarThirdStepFightReq",
			"PM_UltimateWarThirdStepFightRes",
			block = true
		},
		{
			"PM_UltimateWarThirdStepGainPrizeReq",
			"PM_UltimateWarThirdStepGainPrizeRes",
			block = true
		},
		{
			"PM_UltimateWarThirdStepCheckInReq",
			"PM_UltimateWarThirdStepCheckInRes",
			block = true
		},
		{
			"PM_UltimateWarRankViewReq",
			"PM_UltimateWarRankViewRes",
			block = true
		},
		{
			"PM_UltimateWarRecordReq",
			"PM_UltimateWarRecordRes",
			block = true
		},
		{
			"PM_UltimateWarVoteReq",
			"PM_UltimateWarVoteRes",
			block = true
		},
		[255] = "UltimateWarExtension",
		[101] = {
			"PM_UltimateWarNotifyTowerFightRes"
		},
		[102] = {
			"PM_UltimateWarNotifyTowerBossFightRes"
		},
		[103] = {
			"PM_UltimateWarNotifyThirdStepFightRes"
		}
	},
	[603] = {
		{
			"PM_AshlessLongYanGetInfoReq",
			"PM_AshlessLongYanGetInfoRes",
			block = true
		},
		{
			"PM_AshlessLongYanChallengeReq",
			"PM_AshlessLongYanChallengeRes",
			block = true
		},
		{
			"PM_AshlessLongYanConfirmScoreReq",
			"PM_AshlessLongYanConfirmScoreRes",
			block = true
		},
		{
			"PM_AshlessLongYanUseWoodReq",
			"PM_AshlessLongYanUseWoodRes",
			block = true
		},
		{
			"PM_AshlessLongYanStashOrTakeReq",
			"PM_AshlessLongYanStashOrTakeRes",
			block = true
		},
		{
			"PM_AshlessLongYanResetPhaseReq",
			"PM_AshlessLongYanResetPhaseRes",
			block = true
		},
		[255] = "AshlessLongYanExtension",
		[100] = {
			"PM_Notify_AshlessLongYanChallengeEndRes",
			block = true
		}
	},
	[604] = {
		{
			"PM_AoQiAttackForceInfoReq",
			"PM_AoQiAttackForceInfoRes",
			block = true
		},
		{
			"PM_AoQiAttackForceSetEquipmentReq",
			"PM_AoQiAttackForceSetEquipmentRes",
			block = true
		},
		{
			"PM_AoQiAttackForceChallengeStartGameReq",
			"PM_AoQiAttackForceChallengeStartGameRes",
			block = true
		},
		{
			"PM_AoQiAttackForceChallengeEndGameReq",
			"PM_AoQiAttackForceChallengeEndGameRes",
			block = true
		},
		{
			"PM_AoQiAttackForceChallengeSweepReq",
			"PM_AoQiAttackForceChallengeSweepRes",
			block = true
		},
		{
			"PM_AoQiAttackForceEndlessStartGameReq",
			"PM_AoQiAttackForceEndlessStartGameRes",
			block = true
		},
		{
			"PM_AoQiAttackForceEndlessEndGameReq",
			"PM_AoQiAttackForceEndlessEndGameRes",
			block = true
		},
		{
			"PM_AoQiAttackForceUpgradeEquipmentReq",
			"PM_AoQiAttackForceUpgradeEquipmentRes",
			block = true
		},
		{
			"PM_AoQiAttackForceRankInfoReq",
			"PM_AoQiAttackForceRankInfoRes",
			block = true
		},
		{
			"PM_AoQiAttackForceHeroChallengeStartGameReq",
			"PM_AoQiAttackForceHeroChallengeStartGameRes",
			block = true
		},
		{
			"PM_AoQiAttackForceHeroChallengeEndGameReq",
			"PM_AoQiAttackForceHeroChallengeEndGameRes",
			block = true
		},
		{
			"PM_AoQiAttackForceHeroChallengeSweepReq",
			"PM_AoQiAttackForceHeroChallengeSweepRes",
			block = true
		},
		{
			"PM_AoQiAttackForceHeroRankInfoReq",
			"PM_AoQiAttackForceHeroRankInfoRes",
			block = true
		},
		[255] = "AoQiAttackForceExtension"
	},
	[605] = {
		{
			"PM_GulasClgGetInfoReq",
			"PM_GulasClgGetInfoRes",
			block = true
		},
		{
			"PM_GulasClgChallengeReq",
			"PM_GulasClgChallengeRes",
			block = true
		},
		{
			"PM_GulasClgResetStageReq",
			"PM_GulasClgResetStageRes",
			block = true
		},
		{
			"PM_GulasClgUpgradeBuffReq",
			"PM_GulasClgUpgradeBuffRes",
			block = true
		},
		[255] = "GulasClgExtension",
		[100] = {
			"PM_Notify_GulasClgChallengeEndRes",
			block = true
		}
	},
	[606] = {
		{
			"PM_ImpressionStickersInfoReq",
			"PM_ImpressionStickersInfoRes",
			block = true
		},
		{
			"PM_Annuity2025ChangeRankInfoReq",
			"PM_Annuity2025ChangeRankInfoRes",
			block = true
		},
		{
			"PM_Annuity2025ChangeRankReq",
			"PM_Annuity2025ChangeRankRes",
			block = true
		},
		{
			"PM_ImpressionStickersPinReq",
			"PM_ImpressionStickersPinRes",
			block = true
		},
		[255] = "ImpressionStickersExtension"
	},
	[607] = {
		[255] = "WebOfficialPayExtension",
		[100] = {
			"PM_Notify_WebOfficialPaySuccessRes"
		}
	},
	[608] = {
		{
			"PM_LuckyMoneyGetInfoReq",
			"PM_LuckyMoneyGetInfoRes",
			block = true
		},
		{
			"PM_LuckyMoneyActEndReq",
			"PM_LuckyMoneyActEndRes",
			block = true
		},
		{
			"PM_LuckyMoneyGainProgressPrizeReq",
			"PM_LuckyMoneyGainProgressPrizeRes",
			block = true
		},
		[255] = "LuckyMoneyExtension"
	},
	[609] = {
		{
			"PM_StickCoupletGetInfoReq",
			"PM_StickCoupletGetInfoRes",
			block = true
		},
		{
			"PM_StickCoupletStartGameReq",
			"PM_StickCoupletStartGameRes",
			block = true
		},
		{
			"PM_StickCoupletEndGameReq",
			"PM_StickCoupletEndGameRes",
			block = true
		},
		{
			"PM_StickCoupletGainPrizeReq",
			"PM_StickCoupletGainPrizeRes",
			block = true
		},
		[255] = "StickCoupletExtension"
	},
	[610] = {
		{
			"PM_KingAshlessDragonClgGetInfoReq",
			"PM_KingAshlessDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_KingAshlessDragonClgChallengeReq",
			"PM_KingAshlessDragonClgChallengeRes",
			block = true
		},
		{
			"PM_KingAshlessDragonClgConfirmReq",
			"PM_KingAshlessDragonClgConfirmRes",
			block = true
		},
		{
			"PM_KingAshlessDragonClgResetReq",
			"PM_KingAshlessDragonClgResetRes",
			block = true
		},
		[255] = "KingAshlessDragonClgExtension",
		[100] = {
			"PM_NotifyKingAshlessDragonClgEndRes"
		}
	},
	[611] = {
		{
			"PM_LanternRiddleGetInfoReq",
			"PM_LanternRiddleGetInfoRes",
			block = true
		},
		{
			"PM_LanternRiddleStartGameReq",
			"PM_LanternRiddleStartGameRes",
			block = true
		},
		{
			"PM_LanternRiddleEndGameReq",
			"PM_LanternRiddleEndGameRes",
			block = true
		},
		{
			"PM_LanternRiddleGainPrizeReq",
			"PM_LanternRiddleGainPrizeRes",
			block = true
		},
		[255] = "LanternRiddleExtension"
	},
	[612] = {
		{
			"PM_SlackOffGameInfoReq",
			"PM_SlackOffGameInfoRes",
			block = true
		},
		{
			"PM_SlackOffGameStartReq",
			"PM_SlackOffGameStartRes",
			block = true
		},
		{
			"PM_SlackOffGameEndReq",
			"PM_SlackOffGameEndRes",
			block = true
		},
		{
			"PM_SlackOffGameGainPrizeReq",
			"PM_SlackOffGameGainPrizeRes",
			block = true
		},
		[255] = "SlackOffGameExtension"
	},
	[613] = {
		{
			"PM_HotSearchGetInfoReq",
			"PM_HotSearchGetInfoRes",
			block = true
		},
		{
			"PM_HotSearchGainPrizeReq",
			"PM_HotSearchGainPrizeRes",
			block = true
		},
		{
			"PM_HotSearchReplyReq",
			"PM_HotSearchReplyRes",
			block = true
		},
		{
			"PM_HotSearchKudosReq",
			"PM_HotSearchKudosRes",
			block = true
		},
		{
			"PM_HotSearchPresentReq",
			"PM_HotSearchPresentRes",
			block = true
		},
		[255] = "HotSearchExtension"
	},
	[614] = {
		{
			"PM_KunWuClgGetInfoReq",
			"PM_KunWuClgGetInfoRes",
			block = true
		},
		{
			"PM_KunWuNormalFightReq",
			"PM_KunWuNormalFightRes",
			block = true
		},
		{
			"PM_KunWuClgGainProgressPrizeReq",
			"PM_KunWuClgGainProgressPrizeRes",
			block = true
		},
		{
			"PM_KunWuExtremeFightReq",
			"PM_KunWuExtremeFightRes",
			block = true
		},
		{
			"PM_KunWuClgConfirmReq",
			"PM_KunWuClgConfirmRes",
			block = true
		},
		{
			"PM_KunWuResetExtremeClgPhaseReq",
			"PM_KunWuResetExtremeClgPhaseRes",
			block = true
		},
		[255] = "KunWuClgExtension",
		[100] = {
			"PM_NotifyKunWuNormalFightEndRes"
		},
		[101] = {
			"PM_NotifyKunWuExtremeFightEndRes"
		}
	},
	[615] = {
		{
			"PM_DivineEternalDragonClgGetInfoReq",
			"PM_DivineEternalDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineEternalDragonClgChallengeReq",
			"PM_DivineEternalDragonClgChallengeRes",
			block = true
		},
		{
			"PM_DivineEternalDragonClgResetStageReq",
			"PM_DivineEternalDragonClgResetStageRes",
			block = true
		},
		[255] = "DivineEternalDragonClgExtension",
		[100] = {
			"PM_Notify_DivineEternalDragonClgChallengeEndRes",
			block = true
		}
	},
	[616] = {
		{
			"PM_AnchorSimulatorGetInfoReq",
			"PM_AnchorSimulatorGetInfoRes",
			block = true
		},
		{
			"PM_AnchorSimulatorTrainReq",
			"PM_AnchorSimulatorTrainRes",
			block = true
		},
		{
			"PM_AnchorSimulatorRefreshBuffReq",
			"PM_AnchorSimulatorRefreshBuffRes",
			block = true
		},
		{
			"PM_AnchorSimulatorStartLiveReq",
			"PM_AnchorSimulatorStartLiveRes",
			block = true
		},
		{
			"PM_AnchorSimulatorRankViewReq",
			"PM_AnchorSimulatorRankViewRes",
			block = true
		},
		[255] = "AnchorSimulatorExtension"
	},
	[617] = {
		{
			"PM_SixArtDaoguanGetInfoReq",
			"PM_SixArtDaoguanGetInfoRes",
			block = true
		},
		{
			"PM_SixArtDaoguanStartFightReq",
			"PM_SixArtDaoguanStartFightRes",
			block = true
		},
		{
			"PM_SixArtDaoguanContinueFightReq",
			"PM_SixArtDaoguanContinueFightRes",
			block = true
		},
		{
			"PM_SixArtDaoguanRerandomDropBuffReq",
			"PM_SixArtDaoguanRerandomDropBuffRes",
			block = true
		},
		{
			"PM_SixArtDaoguanSelectDropBuffReq",
			"PM_SixArtDaoguanSelectDropBuffRes",
			block = true
		},
		{
			"PM_SixArtDaoguanReShuffleDropBuffReq",
			"PM_SixArtDaoguanReShuffleDropBuffRes",
			block = true
		},
		{
			"PM_SixArtDaoguanBuyRentPetReq",
			"PM_SixArtDaoguanBuyRentPetRes",
			block = true
		},
		{
			"PM_SixArtDaoguanRankReq",
			"PM_SixArtDaoguanRankRes",
			block = true
		},
		[255] = "SixArtDaoguanExtension",
		[10] = {
			"PM_SixArtDaoguanNotifyFightResultRes"
		}
	},
	[618] = {
		{
			"PM_ShareLotteryGetInfoReq",
			"PM_ShareLotteryGetInfoRes",
			block = true
		},
		{
			"PM_ShareLotteryLotteryReq",
			"PM_ShareLotteryLotteryRes",
			block = true
		},
		{
			"PM_ShareLotteryShareReq",
			"PM_ShareLotteryShareRes",
			block = true
		},
		{
			"PM_ShareLotteryGainPrizeReq",
			"PM_ShareLotteryGainPrizeRes",
			block = true
		},
		[255] = "ShareLotteryExtension"
	},
	[619] = {
		{
			"PM_KnowledgeAnswerInfoReq",
			"PM_KnowledgeAnswerInfoRes",
			block = true
		},
		{
			"PM_KnowledgeAnswerReq",
			"PM_KnowledgeAnswerRes"
		},
		{
			"PM_KnowledgeAnswerGainScorePrizeReq",
			"PM_KnowledgeAnswerGainScorePrizeRes",
			block = true
		},
		{
			"PM_KnowledgeAnswerSeekHelpReq",
			"PM_KnowledgeAnswerSeekHelpRes",
			block = true
		},
		{
			"PM_KnowledgeAnswerJoinRoomReq",
			"PM_KnowledgeAnswerJoinRoomRes",
			block = true
		},
		{
			"PM_KnowledgeAnswerLeaveRoomReq",
			"PM_KnowledgeAnswerLeaveRoomRes",
			block = true
		},
		[255] = "KnowledgeAnswerExtension",
		[10] = {
			"PM_NotifyKnowledgeAnswerNewQuestionRes"
		},
		[11] = {
			"PM_NotifyKnowledgeAnswerQuestionRes"
		},
		[12] = {
			"PM_NotifyKnowledgeAnswerRoomMembersRes"
		}
	},
	[620] = {
		{
			"PM_AoQiHeroInfoReq",
			"PM_AoQiHeroInfoRes",
			block = true
		},
		{
			"PM_AoQiHeroRankInfoReq",
			"PM_AoQiHeroRankInfoRes",
			block = true
		},
		{
			"PM_AoQiHeroUnlockPetReq",
			"PM_AoQiHeroUnlockPetRes",
			block = true
		},
		{
			"PM_AoQiHeroUpgradePositionReq",
			"PM_AoQiHeroUpgradePositionRes",
			block = true
		},
		{
			"PM_AoQiHeroCardListReq",
			"PM_AoQiHeroCardListRes",
			block = true
		},
		{
			"PM_AoQiHeroSetCardListReq",
			"PM_AoQiHeroSetCardListRes",
			block = true
		},
		{
			"PM_AoQiHeroNormalChallengeReq",
			"PM_AoQiHeroNormalChallengeRes",
			block = true
		},
		{
			"PM_NotifyAoQiHeroNormalChallengeEndRes"
		},
		{
			"PM_AoQiHeroEndlessChallengeReq",
			"PM_AoQiHeroEndlessChallengeRes",
			block = true
		},
		{
			"PM_NotifyAoQiHeroEndlessChallengeEndRes"
		},
		{
			"PM_AoQiHeroEndlessGainPrizeReq",
			"PM_AoQiHeroEndlessGainPrizeRes",
			block = true
		},
		{
			"PM_AoQiHeroPvPRecordReq",
			"PM_AoQiHeroPvPRecordRes",
			block = true
		},
		{
			"PM_AoQiHeroPvPSetDefFormationReq",
			"PM_AoQiHeroPvPSetDefFormationRes",
			block = true
		},
		{
			"PM_AoQiHeroPvPMatchReq",
			"PM_AoQiHeroPvPMatchRes",
			block = true
		},
		{
			"PM_AoQiHeroPvPCancelMatchReq",
			"PM_AoQiHeroPvPCancelMatchRes",
			block = true
		},
		{
			"PM_NotifyAoQiHeroPvPMailFailRes"
		},
		{
			"PM_NotifyAoQiHeroPvpGameStartRes"
		},
		{
			"PM_AoQiHeroPvPLeaveRoomReq",
			"PM_AoQiHeroPvPLeaveRoomRes",
			block = true
		},
		{
			"PM_AoQiHeroPvPFightStartReq",
			"PM_AoQiHeroPvPFightStartRes",
			block = true
		},
		{
			"PM_NotifyAoQiHeroPvPFightEndRes"
		},
		{
			"PM_NotifyAoQiHeroPvPRoomEndRes"
		},
		{
			"PM_AoQiHeroGainDailyPrizeReq",
			"PM_AoQiHeroGainDailyPrizeRes",
			block = true
		},
		[255] = "AoQiHeroExtension",
		[101] = {
			"PM_NotifyAoQiHeroBattleReadyStart"
		},
		[102] = {
			"PM_AoQiHeroBattleStartReq",
			"PM_AoQiHeroBattleStartRes",
			block = true
		},
		[103] = {
			"PM_AoQiHeroSyncBattleReq",
			"PM_AoQiHeroSyncBattleRes",
			block = true
		}
	},
	[621] = {
		{
			"PM_MilkDragonClgGetInfoReq",
			"PM_MilkDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_MilkDragonClgSignInReq",
			"PM_MilkDragonClgSignInRes",
			block = true
		},
		{
			"PM_MilkDragonClgPosLvlUpReq",
			"PM_MilkDragonClgPosLvlUpRes",
			block = true
		},
		{
			"PM_MilkDragonClgResetPosLvlReq",
			"PM_MilkDragonClgResetPosLvlRes",
			block = true
		},
		{
			"PM_MilkDragonFightReq",
			"PM_MilkDragonFightRes",
			block = true
		},
		[255] = "MilkDragonClgExtension",
		[100] = {
			"PM_NotifyMilkDragonFightEndRes"
		}
	},
	[622] = {
		{
			"PM_InflationMoneyGetInfoReq",
			"PM_InflationMoneyGetInfoRes",
			block = true
		},
		{
			"PM_InflationMoneyGainOncePrizeReq",
			"PM_InflationMoneyGainOncePrizeRes",
			block = true
		},
		{
			"PM_InflationMoneyGainProgressPrizeReq",
			"PM_InflationMoneyGainProgressPrizeRes",
			block = true
		},
		[255] = "InflationMoneyExtension"
	},
	[623] = {
		{
			"PM_GoddessCompetitionGetInfoReq",
			"PM_GoddessCompetitionGetInfoRes",
			block = true
		},
		{
			"PM_GoddessCompetitionVoteReq",
			"PM_GoddessCompetitionVoteRes",
			block = true
		},
		{
			"PM_GoddessCompetitionSendRedPackReq",
			"PM_GoddessCompetitionSendRedPackRes",
			block = true
		},
		{
			"PM_GoddessCompetitionGrabRedPackReq",
			"PM_GoddessCompetitionGrabRedPackRes",
			block = true
		},
		{
			"PM_GoddessCompetitionRedPackListReq",
			"PM_GoddessCompetitionRedPackListRes",
			block = true
		},
		{
			"PM_GoddessCompetitionRedPackInfoReq",
			"PM_GoddessCompetitionRedPackInfoRes",
			block = true
		},
		{
			"PM_GoddessCompetitionPopularityRankViewReq",
			"PM_GoddessCompetitionPopularityRankViewRes",
			block = true
		},
		{
			"PM_GoddessCompetitionRedPackRankViewReq",
			"PM_GoddessCompetitionRedPackRankViewRes",
			block = true
		},
		{
			"PM_GoddessCompetitionRedPackRecordReq",
			"PM_GoddessCompetitionRedPackRecordRes",
			block = true
		},
		{
			"PM_GoddessCompetitionSuperFansRankViewReq",
			"PM_GoddessCompetitionSuperFansRankViewRes",
			block = true
		},
		{
			"PM_GoddessCompetitionGainProgressPrizeReq",
			"PM_GoddessCompetitionGainProgressPrizeRes",
			block = true
		},
		{
			"PM_GoddessCompetitionUseDoubleCardReq",
			"PM_GoddessCompetitionUseDoubleCardRes",
			block = true
		},
		{
			"PM_GoddessCompetitionAllGoddessPopularityRankReq",
			"PM_GoddessCompetitionAllGoddessPopularityRankRes",
			block = true
		},
		[255] = "GoddessCompetitionExtension",
		[101] = {
			"PM_GoddessCompetitionDoubleCardRes"
		}
	},
	[624] = {
		{
			"PM_XiaoXiaoLeGameInfoReq",
			"PM_XiaoXiaoLeGameInfoRes",
			block = true
		},
		{
			"PM_XiaoXiaoLeGameStartGameReq",
			"PM_XiaoXiaoLeGameStartGameRes",
			block = true
		},
		{
			"PM_XiaoXiaoLeGameEndGameReq",
			"PM_XiaoXiaoLeGameEndGameRes",
			block = true
		},
		{
			"PM_XiaoXiaoLeGameOneKeyGainPrizeReq",
			"PM_XiaoXiaoLeGameOneKeyGainPrizeRes",
			block = true
		},
		{
			"PM_XiaoXiaoLeGameRankReq",
			"PM_XiaoXiaoLeGameRankRes",
			block = true
		},
		{
			"PM_XiaoXiaoLeGameSweepReq",
			"PM_XiaoXiaoLeGameSweepRes",
			block = true
		},
		[255] = "XiaoXiaoLeGameExtension"
	},
	[625] = {
		{
			"PM_DivineInfiniteFutureClgGetInfoReq",
			"PM_DivineInfiniteFutureClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineInfiniteFutureFightReq",
			"PM_DivineInfiniteFutureFightRes",
			block = true
		},
		{
			"PM_DivineInfiniteFutureClgConfirmReq",
			"PM_DivineInfiniteFutureClgConfirmRes",
			block = true
		},
		{
			"PM_DivineInfiniteFutureClgValidReq",
			"PM_DivineInfiniteFutureClgValidRes",
			block = true
		},
		[255] = "DivineInfiniteFutureClgExtension",
		[100] = {
			"PM_NotifyDivineInfiniteFutureFightEndRes"
		}
	},
	[626] = {
		{
			"PM_WisdomCourageClgBossInfoReq",
			"PM_WisdomCourageClgBossInfoRes",
			block = true
		},
		{
			"PM_WisdomCourageClgBossChallengeReq",
			"PM_WisdomCourageClgBossChallengeRes",
			block = true
		},
		[255] = "WisdomCourageClgExtension",
		[4] = {
			"PM_WisdomCourageClgBossRankInfoReq",
			"PM_WisdomCourageClgBossRankInfoRes",
			block = true
		},
		[5] = {
			"PM_WisdomCourageClgSupportInfoReq",
			"PM_WisdomCourageClgSupportInfoRes",
			block = true
		},
		[6] = {
			"PM_WisdomCourageClgSupportChallengeReq",
			"PM_WisdomCourageClgSupportChallengeRes",
			block = true
		},
		[7] = {
			"PM_WisdomCourageClgSupportConfirmReq",
			"PM_WisdomCourageClgSupportConfirmRes",
			block = true
		},
		[8] = {
			"PM_WisdomCourageClgSupportRankInfoReq",
			"PM_WisdomCourageClgSupportRankInfoRes",
			block = true
		},
		[9] = {
			"PM_WisdomCourageClgSupportResetReq",
			"PM_WisdomCourageClgSupportResetRes",
			block = true
		},
		[10] = {
			"PM_NotifyWisdomCourageClgBossChallengeFinishRes",
			block = true
		},
		[11] = {
			"PM_NotifyWisdomCourageClgSupportChallengeFinishRes",
			block = true
		}
	},
	[627] = {
		{
			"PM_DivineChenClgExtremeInfoReq",
			"PM_DivineChenClgExtremeInfoRes",
			block = true
		},
		{
			"PM_DivineChenClgExtremeClgReq",
			"PM_DivineChenClgExtremeClgRes",
			block = true
		},
		{
			"PM_DivineChenClgExtremeResetStageReq",
			"PM_DivineChenClgExtremeResetStageRes",
			block = true
		},
		{
			"PM_DivineChenClgNormalInfoReq",
			"PM_DivineChenClgNormalInfoRes",
			block = true
		},
		{
			"PM_DivineChenClgNormalClgReq",
			"PM_DivineChenClgNormalClgRes",
			block = true
		},
		{
			"PM_DivineChenClgNormalResetStageReq",
			"PM_DivineChenClgNormalResetStageRes",
			block = true
		},
		{
			"PM_DivineChenClgNormalGainPrizeReq",
			"PM_DivineChenClgNormalGainPrizeRes",
			block = true
		},
		[255] = "DivineChenClgExtension",
		[11] = {
			"PM_NotifyDivineChenClgExtremeClgEndRes"
		},
		[12] = {
			"PM_NotifyDivineChenClgNormalClgEndRes"
		}
	},
	[628] = {
		{
			"PM_DarkMoYanGameInfoReq",
			"PM_DarkMoYanGameInfoRes",
			block = true
		},
		{
			"PM_DarkMoYanGameStartGameReq",
			"PM_DarkMoYanGameStartGameRes",
			block = true
		},
		{
			"PM_DarkMoYanGameEndGameReq",
			"PM_DarkMoYanGameEndGameRes",
			block = true
		},
		{
			"PM_DarkMoYanGameSweepReq",
			"PM_DarkMoYanGameSweepRes",
			block = true
		},
		{
			"PM_DarkMoYanGameGainProgressPrizeReq",
			"PM_DarkMoYanGameGainProgressPrizeRes",
			block = true
		},
		[255] = "DarkMoYanGameExtension"
	},
	[629] = {
		{
			"PM_SurroundByDreamGirlInfoReq",
			"PM_SurroundByDreamGirlInfoRes",
			block = true
		},
		{
			"PM_SurroundByDreamGirlGainMoneyProgressPrizeReq",
			"PM_SurroundByDreamGirlGainMoneyProgressPrizeRes",
			block = true
		},
		{
			"PM_SurroundByDreamGirlInvestReq",
			"PM_SurroundByDreamGirlInvestRes",
			block = true
		},
		{
			"PM_SurroundByDreamGirlGetGirlTodayChatInfoReq",
			"PM_SurroundByDreamGirlGetGirlTodayChatInfoRes",
			block = true
		},
		{
			"PM_SurroundByDreamGirlChatReq",
			"PM_SurroundByDreamGirlChatRes",
			block = true
		},
		{
			"PM_SurroundByDreamGirlSelectAnswerReq",
			"PM_SurroundByDreamGirlSelectAnswerRes",
			block = true
		},
		{
			"PM_SurroundByDreamGirlPresentGiftReq",
			"PM_SurroundByDreamGirlPresentGiftRes",
			block = true
		},
		[255] = "SurroundByDreamGirlExtension"
	},
	[630] = {
		{
			"PM_DivineMiMengLiClgGetInfoReq",
			"PM_DivineMiMengLiClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineMiMengLiClgFightReq",
			"PM_DivineMiMengLiClgFightRes",
			block = true
		},
		{
			"PM_DivineMiMengLiClgConfirmReq",
			"PM_DivineMiMengLiClgConfirmRes",
			block = true
		},
		{
			"PM_DivineMiMengLiClgResetReq",
			"PM_DivineMiMengLiClgResetRes",
			block = true
		},
		[255] = "DivineMiMengLiClgExtension",
		[101] = {
			"PM_DivineMiMengLiNotifyFightRes"
		}
	},
	[631] = {
		{
			"PM_JudgmentDragonClgGetInfoReq",
			"PM_JudgmentDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_JudgmentDragonClgFightReq",
			"PM_JudgmentDragonClgFightRes",
			block = true
		},
		{
			"PM_JudgmentDragonClgResetReq",
			"PM_JudgmentDragonClgResetRes",
			block = true
		},
		[255] = "JudgmentDragonClgExtension",
		[101] = {
			"PM_JudgmentDragonNotifyFightRes"
		}
	},
	[632] = {
		{
			"PM_KingOfRadiantGoldClgInfoReq",
			"PM_KingOfRadiantGoldClgInfoRes",
			block = true
		},
		{
			"PM_KingOfRadiantGoldClgChallengeReq",
			"PM_KingOfRadiantGoldClgChallengeRes",
			block = true
		},
		{
			"PM_KingOfRadiantGoldClgUpgradeBuffReq",
			"PM_KingOfRadiantGoldClgUpgradeBuffRes",
			block = true
		},
		{
			"PM_KingOfRadiantGoldClgResetBuffReq",
			"PM_KingOfRadiantGoldClgResetBuffRes",
			block = true
		},
		{
			"PM_KingOfRadiantGoldClgOneKeyPassReq",
			"PM_KingOfRadiantGoldClgOneKeyPassRes",
			block = true
		},
		{
			"PM_KingOfRadiantGoldClgGainPetReq",
			"PM_KingOfRadiantGoldClgGainPetRes",
			block = true
		},
		[255] = "KingOfRadiantGoldClgExtension",
		[10] = {
			"PM_NotifyKingOfRadiantGoldClgFinishRes"
		}
	},
	[633] = {
		{
			"PM_DivineKingJiClgGetInfoReq",
			"PM_DivineKingJiClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineKingJiClgFightReq",
			"PM_DivineKingJiClgFightRes",
			block = true
		},
		{
			"PM_DivineKingJiClgConfirmReq",
			"PM_DivineKingJiClgConfirmRes",
			block = true
		},
		{
			"PM_DivineKingJiClgResetReq",
			"PM_DivineKingJiClgResetRes",
			block = true
		},
		[255] = "DivineKingJiClgExtension",
		[101] = {
			"PM_DivineKingJiClgNotifyFightRes"
		}
	},
	[634] = {
		{
			"PM_DivineKunLunClgGetInfoReq",
			"PM_DivineKunLunClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineKunLunClgNormalChallengeReq",
			"PM_DivineKunLunClgNormalChallengeRes",
			block = true
		},
		{
			"PM_DivineKunLunClgExtremeChallengeReq",
			"PM_DivineKunLunClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_DivineKunLunClgConfirmExtremeChallengeReq",
			"PM_DivineKunLunClgConfirmExtremeChallengeRes",
			block = true
		},
		{
			"PM_DivineKunLunClgGainNormalProgressPrizeReq",
			"PM_DivineKunLunClgGainNormalProgressPrizeRes",
			block = true
		},
		{
			"PM_DivineKunLunClgGainExtremePrizeReq",
			"PM_DivineKunLunClgGainExtremePrizeRes",
			block = true
		},
		[255] = "DivineKunLunClgExtension",
		[101] = {
			"PM_Notify_DivineKunLunClgNormalChallengeRes"
		},
		[102] = {
			"PM_Notify_DivineKunLunClgExtremeChallengeRes"
		}
	},
	[635] = {
		{
			"PM_LuYinJiaDeClgGetInfoReq",
			"PM_LuYinJiaDeClgGetInfoRes",
			block = true
		},
		{
			"PM_LuYinJiaDeClgFightReq",
			"PM_LuYinJiaDeClgFightRes",
			block = true
		},
		{
			"PM_LuYinJiaDeClgGodRankViewReq",
			"PM_LuYinJiaDeClgGodRankViewRes",
			block = true
		},
		{
			"PM_LuYinJiaDeClgDailyRankViewReq",
			"PM_LuYinJiaDeClgDailyRankViewRes",
			block = true
		},
		[255] = "LuYinJiaDeClgExtension",
		[101] = {
			"PM_LuYinJiaDeClgNotifyFightRes"
		}
	},
	[636] = {
		{
			"PM_LuyngardeInfoReq",
			"PM_LuyngardeInfoRes",
			block = true
		},
		{
			"PM_LuyngardeUpgradeReq",
			"PM_LuyngardeUpgradeRes",
			block = true
		},
		{
			"PM_LuyngardeChapter2BossInfoReq",
			"PM_LuyngardeChapter2BossInfoRes",
			block = true
		},
		{
			"PM_LuyngardeChapter2BossSimpleRankInfoReq",
			"PM_LuyngardeChapter2BossSimpleRankInfoRes",
			block = true
		},
		{
			"PM_LuyngardeChapter2BossClgReq",
			"PM_LuyngardeChapter2BossClgRes",
			block = true
		},
		{
			"PM_NotifyLuyngardeChapter2BossClgFinishRes"
		},
		{
			"PM_LuyngardeChapter2BossGainPrizeReq",
			"PM_LuyngardeChapter2BossGainPrizeRes",
			block = true
		},
		{
			"PM_LuyngardeChapter2BossRankInfoReq",
			"PM_LuyngardeChapter2BossRankInfoRes",
			block = true
		},
		{
			"PM_LuyngardeChapter3ExploreInfoReq",
			"PM_LuyngardeChapter3ExploreInfoRes",
			block = true
		},
		{
			"PM_LuyngardeChapter3ExploreSelectStarReq",
			"PM_LuyngardeChapter3ExploreSelectStarRes",
			block = true
		},
		{
			"PM_LuyngardeChapter3ExploreSelfClgReq",
			"PM_LuyngardeChapter3ExploreSelfClgRes",
			block = true
		},
		{
			"PM_LuyngardeChapter3ExploreSeekHelpReq",
			"PM_LuyngardeChapter3ExploreSeekHelpRes",
			block = true
		},
		{
			"PM_LuyngardeChapter3ExploreResetStarReq",
			"PM_LuyngardeChapter3ExploreResetStarRes",
			block = true
		},
		{
			"PM_LuyngardeChapter3ExploreHelpInfoReq",
			"PM_LuyngardeChapter3ExploreHelpInfoRes",
			block = true
		},
		[255] = "LuyngardeExtension",
		[16] = {
			"PM_LuyngardeChapter3ExploreHelpCenterReq",
			"PM_LuyngardeChapter3ExploreHelpCenterRes",
			block = true
		},
		[17] = {
			"PM_LuyngardeChapter3ExploreHelpClgReq",
			"PM_LuyngardeChapter3ExploreHelpClgRes",
			block = true
		},
		[19] = {
			"PM_LuyngardeChapter3ExploreRankInfoReq",
			"PM_LuyngardeChapter3ExploreRankInfoRes",
			block = true
		},
		[20] = {
			"PM_LuyngardeChapter4FinalInfoReq",
			"PM_LuyngardeChapter4FinalInfoRes",
			block = true
		},
		[21] = {
			"PM_LuyngardeChapter4FinalChallengeReq",
			"PM_LuyngardeChapter4FinalChallengeRes",
			block = true
		},
		[22] = {
			"PM_NotifyLuyngardeChapter4FinalClgFinishRes"
		},
		[23] = {
			"PM_LuyngardeChapter4FinalResetReq",
			"PM_LuyngardeChapter4FinalResetRes",
			block = true
		},
		[24] = {
			"PM_LuyngardeChapter4FinalRankInfoReq",
			"PM_LuyngardeChapter4FinalRankInfoRes",
			block = true
		},
		[25] = {
			"PM_LuyngardeChapter2BossGainKillPrizeReq",
			"PM_LuyngardeChapter2BossGainKillPrizeRes",
			block = true
		}
	},
	[637] = {
		{
			"PM_AnniversaryMarketGetInfoReq",
			"PM_AnniversaryMarketGetInfoRes",
			block = true
		},
		{
			"PM_AnniversaryMarketGetMyShareCodeReq",
			"PM_AnniversaryMarketGetMyShareCodeRes",
			block = true
		},
		{
			"PM_AnniversaryMarketGetOtherInfoReq",
			"PM_AnniversaryMarketGetOtherInfoRes",
			block = true
		},
		{
			"PM_AnniversaryMarketSellInMyMarketReq",
			"PM_AnniversaryMarketSellInMyMarketRes",
			block = true
		},
		{
			"PM_AnniversaryMarketSellInOtherMarketReq",
			"PM_AnniversaryMarketSellInOtherMarketRes",
			block = true
		},
		{
			"PM_AnniversaryMarketRefreshPrizePoolReq",
			"PM_AnniversaryMarketRefreshPrizePoolRes",
			block = true
		},
		{
			"PM_AnniversaryMarketConfirmRefreshReq",
			"PM_AnniversaryMarketConfirmRefreshRes",
			block = true
		},
		{
			"PM_AnniversaryMarketGainPrizePoolReq",
			"PM_AnniversaryMarketGainPrizePoolRes",
			block = true
		},
		[255] = "AnniversaryMarketExtension",
		[101] = {
			"PM_Notify_AnniversaryMarketOtherSellInMyMarketRes"
		}
	},
	[638] = {
		{
			"PM_DualTrialGetInfoReq",
			"PM_DualTrialGetInfoRes",
			block = true
		},
		{
			"PM_DualTrialBeginEventReq",
			"PM_DualTrialBeginEventRes",
			block = true
		},
		{
			"PM_DualTrialEndEventReq",
			"PM_DualTrialEndEventRes",
			block = true
		},
		{
			"PM_DualTrialVisitBlockReq",
			"PM_DualTrialVisitBlockRes",
			block = true
		},
		{
			"PM_DualTrialFightReq",
			"PM_DualTrialFightRes",
			block = true
		},
		{
			"PM_DualTrialGainPrizeReq",
			"PM_DualTrialGainPrizeRes",
			block = true
		},
		[255] = "DualTrialExtension",
		[101] = {
			"PM_DualTrialNotifyFightRes"
		}
	},
	[639] = {
		{
			"PM_DivineDualDragonClgGetInfoReq",
			"PM_DivineDualDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineDualDragonClgChallengeReq",
			"PM_DivineDualDragonClgChallengeRes",
			block = true
		},
		[255] = "DivineDualDragonClgExtension",
		[101] = {
			"PM_Notify_DivineDualDragonClgChallengeRes"
		}
	},
	[640] = {
		{
			"PM_ChopKingFirstClgInfoReq",
			"PM_ChopKingFirstClgInfoRes",
			block = true
		},
		{
			"PM_ChopKingFirstClgStartFightReq",
			"PM_ChopKingFirstClgStartFightRes",
			block = true
		},
		{
			"PM_ChopKingFirstClgContinueFightReq",
			"PM_ChopKingFirstClgContinueFightRes",
			block = true
		},
		{
			"PM_NotifyChopKingFirstClgFightResultRes"
		},
		{
			"PM_ChopKingRerandomDropBuffReq",
			"PM_ChopKingRerandomDropBuffRes",
			block = true
		},
		{
			"PM_ChopKingSelectDropBuffReq",
			"PM_ChopKingSelectDropBuffRes",
			block = true
		},
		{
			"PM_ChopKingReShuffleDropBuffReq",
			"PM_ChopKingReShuffleDropBuffRes",
			block = true
		},
		{
			"PM_ChopKingLoopClgInfoReq",
			"PM_ChopKingLoopClgInfoRes",
			block = true
		},
		{
			"PM_ChopKingLoopClgFightReq",
			"PM_ChopKingLoopClgFightRes",
			block = true
		},
		{
			"PM_NotifyChopKingLoopClgFightResultRes"
		},
		{
			"PM_ChopKingCircleClgInfoReq",
			"PM_ChopKingCircleClgInfoRes",
			block = true
		},
		{
			"PM_ChopKingCircleClgFightReq",
			"PM_ChopKingCircleClgFightRes",
			block = true
		},
		{
			"PM_NotifyChopKingCircleClgFightResultRes"
		},
		{
			"PM_ChopKingAgainstTwoClgInfoReq",
			"PM_ChopKingAgainstTwoClgInfoRes",
			block = true
		},
		{
			"PM_ChopKingAgainstTwoClgFightReq",
			"PM_ChopKingAgainstTwoClgFightRes",
			block = true
		},
		{
			"PM_ChopKingRankReq",
			"PM_ChopKingRankRes",
			block = true
		},
		[255] = "ChopKingExtension"
	},
	[641] = {
		{
			"PM_DivineKingNoahClgGetInfoReq",
			"PM_DivineKingNoahClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineKingNoahClgSetBanItemsReq",
			"PM_DivineKingNoahClgSetBanItemsRes",
			block = true
		},
		{
			"PM_DivineKingNoahClgFightReq",
			"PM_DivineKingNoahClgFightRes",
			block = true
		},
		[255] = "DivineKingNoahClgExtension",
		[101] = {
			"PM_DivineKingNoahClgNotifyFightRes"
		}
	},
	[642] = {
		{
			"PM_UltimateTrialGetInfoReq",
			"PM_UltimateTrialGetInfoRes",
			block = true
		},
		{
			"PM_UltimateTrialSignInReq",
			"PM_UltimateTrialSignInRes",
			block = true
		},
		{
			"PM_UltimateTrialGetTimeRankViewReq",
			"PM_UltimateTrialGetTimeRankViewRes",
			block = true
		},
		{
			"PM_UltimateTrialGetScoreRankViewReq",
			"PM_UltimateTrialGetScoreRankViewRes",
			block = true
		},
		[255] = "UltimateTrialExtension"
	},
	[643] = {
		{
			"PM_DivineInvincibleClgExtremeInfoReq",
			"PM_DivineInvincibleClgExtremeInfoRes",
			block = true
		},
		{
			"PM_DivineInvincibleClgExtremeFightReq",
			"PM_DivineInvincibleClgExtremeFightRes",
			block = true
		},
		{
			"PM_DivineInvincibleClgExtremeConfirmReq",
			"PM_DivineInvincibleClgExtremeConfirmRes",
			block = true
		},
		{
			"PM_DivineInvincibleClgExtremeResetReq",
			"PM_DivineInvincibleClgExtremeResetRes",
			block = true
		},
		{
			"PM_DivineInvincibleClgNormalInfoReq",
			"PM_DivineInvincibleClgNormalInfoRes",
			block = true
		},
		{
			"PM_DivineInvincibleClgNormalFightReq",
			"PM_DivineInvincibleClgNormalFightRes",
			block = true
		},
		{
			"PM_DivineInvincibleClgNormalGainPrizeReq",
			"PM_DivineInvincibleClgNormalGainPrizeRes",
			block = true
		},
		[255] = "DivineInvincibleClgExtension",
		[10] = {
			"PM_NotifyDivineInvincibleClgExtremeFightResultRes"
		},
		[11] = {
			"PM_NotifyDivineInvincibleClgNormalFightResultRes"
		}
	},
	[644] = {
		{
			"PM_GuardDestroyGetInfoReq",
			"PM_GuardDestroyGetInfoRes",
			block = true
		},
		{
			"PM_GuardDestroyChallengeReq",
			"PM_GuardDestroyChallengeRes",
			block = true
		},
		{
			"PM_GuardDestroyConfirmChallengeResultReq",
			"PM_GuardDestroyConfirmChallengeResultRes",
			block = true
		},
		{
			"PM_GuardDestroyGainBalancePrizeReq",
			"PM_GuardDestroyGainBalancePrizeRes",
			block = true
		},
		{
			"PM_GuardDestroyGainProgressPrizeReq",
			"PM_GuardDestroyGainProgressPrizeRes",
			block = true
		},
		{
			"PM_GuardDestroyGetRankViewReq",
			"PM_GuardDestroyGetRankViewRes",
			block = true
		},
		{
			"PM_GuardDestroyUpgradeSignInBuffReq",
			"PM_GuardDestroyUpgradeSignInBuffRes",
			block = true
		},
		[255] = "GuardDestroyExtension",
		[101] = {
			"PM_Notify_GuardDestroyChallengeRes"
		}
	},
	[645] = {
		{
			"PM_FruitNinjaGetInfoReq",
			"PM_FruitNinjaGetInfoRes",
			block = true
		},
		{
			"PM_FruitNinjaStartGameReq",
			"PM_FruitNinjaStartGameRes",
			block = true
		},
		{
			"PM_FruitNinjaEndGameReq",
			"PM_FruitNinjaEndGameRes",
			block = true
		},
		{
			"PM_FruitNinjaGainPrizeReq",
			"PM_FruitNinjaGainPrizeRes",
			block = true
		},
		{
			"PM_FruitNinjaViewRankReq",
			"PM_FruitNinjaViewRankRes",
			block = true
		},
		[255] = "FruitNinjaExtension"
	},
	[646] = {
		{
			"PM_DivineHaloGameInfoReq",
			"PM_DivineHaloGameInfoRes",
			block = true
		},
		{
			"PM_DivineHaloGameBuyTimesReq",
			"PM_DivineHaloGameBuyTimesRes",
			block = true
		},
		{
			"PM_DivineHaloGameStartGameReq",
			"PM_DivineHaloGameStartGameRes",
			block = true
		},
		{
			"PM_DivineHaloGameEndGameReq",
			"PM_DivineHaloGameEndGameRes",
			block = true
		},
		[255] = "DivineHaloGameExtension"
	},
	[647] = {
		{
			"PM_DivineMiZongClgGetInfoReq",
			"PM_DivineMiZongClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineMiZongClgFightReq",
			"PM_DivineMiZongClgFightRes",
			block = true
		},
		{
			"PM_DivineMiZongClgGainBuffItemReq",
			"PM_DivineMiZongClgGainBuffItemRes",
			block = true
		},
		{
			"PM_DivineMiZongClgUpgradeBuffReq",
			"PM_DivineMiZongClgUpgradeBuffRes",
			block = true
		},
		{
			"PM_DivineMiZongClgResetBuffReq",
			"PM_DivineMiZongClgResetBuffRes",
			block = true
		},
		{
			"PM_DivineMiZongClgGainPrizeReq",
			"PM_DivineMiZongClgGainPrizeRes",
			block = true
		},
		[255] = "DivineMiZongClgExtension",
		[101] = {
			"PM_DivineMiZongClgNotifyFightRes"
		}
	},
	[648] = {
		{
			"PM_DivineSKLieXinClgGetInfoReq",
			"PM_DivineSKLieXinClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineSKLieXinClgChallengeReq",
			"PM_DivineSKLieXinClgChallengeRes",
			block = true
		},
		[255] = "DivineSKLieXinClgExtension",
		[101] = {
			"PM_Notify_DivineSKLieXinClgChallengeRes"
		}
	},
	[649] = {
		{
			"PM_ClearStarGameInfoReq",
			"PM_ClearStarGameInfoRes",
			block = true
		},
		{
			"PM_ClearStarGameStartReq",
			"PM_ClearStarGameStartRes",
			block = true
		},
		{
			"PM_ClearStarGameEndReq",
			"PM_ClearStarGameEndRes",
			block = true
		},
		{
			"PM_ClearStarSweepReq",
			"PM_ClearStarSweepRes",
			block = true
		},
		[255] = "ClearStarGameExtension"
	},
	[650] = {
		{
			"PM_DivineSaintKnightFireGodInfoReq",
			"PM_DivineSaintKnightFireGodInfoRes",
			block = true
		},
		{
			"PM_DivineSaintKnightFireGodChallengeReq",
			"PM_DivineSaintKnightFireGodChallengeRes",
			block = true
		},
		{
			"PM_DivineSaintKnightFireGodNotifyChallengeRes"
		},
		[255] = "DivineSaintKnightFireGodExtension"
	},
	[651] = {
		{
			"PM_SaintKnightExpeditionInfoReq",
			"PM_SaintKnightExpeditionInfoRes",
			block = true
		},
		{
			"PM_SaintKnightExpeditionMiningReq",
			"PM_SaintKnightExpeditionMiningRes",
			block = true
		},
		{
			"PM_SaintKnightExpeditionUpgardeIslandReq",
			"PM_SaintKnightExpeditionUpgardeIslandRes",
			block = true
		},
		{
			"PM_SaintKnightExpeditionChallengeReq",
			"PM_SaintKnightExpeditionChallengeRes",
			block = true
		},
		{
			"PM_SaintKnightExpeditionBossChallengeReq",
			"PM_SaintKnightExpeditionBossChallengeRes",
			block = true
		},
		{
			"PM_SaintKnightExpeditionGainBossPrizeReq",
			"PM_SaintKnightExpeditionGainBossPrizeRes",
			block = true
		},
		{
			"PM_SaintKnightExpeditionStageRankInfoReq",
			"PM_SaintKnightExpeditionStageRankInfoRes",
			block = true
		},
		{
			"PM_SaintKnightExpeditionBossRankInfoReq",
			"PM_SaintKnightExpeditionBossRankInfoRes",
			block = true
		},
		[255] = "SaintKnightExpeditionExtension",
		[101] = {
			"PM_NotifySaintKnightExpeditionChallengeEndRes"
		},
		[102] = {
			"PM_NotifySaintKnightExpeditionBossChallengeEndRes"
		}
	},
	[652] = {
		{
			"PM_DivineTianShanClgGetInfoReq",
			"PM_DivineTianShanClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineTianShanClgExtremeFightReq",
			"PM_DivineTianShanClgExtremeFightRes",
			block = true
		},
		{
			"PM_DivineTianShanClgResetExtremeStageReq",
			"PM_DivineTianShanClgResetExtremeStageRes",
			block = true
		},
		{
			"PM_DivineTianShanClgNormalFightReq",
			"PM_DivineTianShanClgNormalFightRes",
			block = true
		},
		{
			"PM_DivineTianShanClgGainPrizeReq",
			"PM_DivineTianShanClgGainPrizeRes",
			block = true
		},
		[255] = "DivineTianShanClgExtension",
		[101] = {
			"PM_DivineTianShanClgExtremeFightNotifyRes"
		},
		[102] = {
			"PM_DivineTianShanClgNormalFightNotifyRes"
		}
	},
	[653] = {
		{
			"PM_SaintKnightRegressGetInfoReq",
			"PM_SaintKnightRegressGetInfoRes",
			block = true
		},
		{
			"PM_SaintKnightRegressGainPrizeReq",
			"PM_SaintKnightRegressGainPrizeRes",
			block = true
		},
		{
			"PM_SaintKnightRegressLotteryReq",
			"PM_SaintKnightRegressLotteryRes",
			block = true
		},
		{
			"PM_SaintKnightRegressFillMsgReq",
			"PM_SaintKnightRegressFillMsgRes",
			block = true
		},
		{
			"PM_SaintKnightRegressBindCodeReq",
			"PM_SaintKnightRegressBindCodeRes",
			block = true
		},
		{
			"PM_SaintKnightRegressOneKeyGainPrizeReq",
			"PM_SaintKnightRegressOneKeyGainPrizeRes",
			block = true
		},
		{
			"PM_SaintKnightRegressGetTaskInfoReq",
			"PM_SaintKnightRegressGetTaskInfoRes",
			block = true
		},
		[255] = "SaintKnightRegressExtension"
	},
	[654] = {
		{
			"PM_SignInBuffInfoReq",
			"PM_SignInBuffInfoRes",
			block = true
		},
		{
			"PM_UpgradeSignInBuffReq",
			"PM_UpgradeSignInBuffRes",
			block = true
		},
		{
			"PM_BatchSignInBuffInfoReq",
			"PM_BatchSignInBuffInfoRes",
			block = true
		},
		{
			"PM_BatchUpgradeSignInBuffReq",
			"PM_BatchUpgradeSignInBuffRes",
			block = true
		},
		[255] = "SignInBuffExtension"
	},
	[655] = {
		{
			"PM_ImmortalMovementInfoReq",
			"PM_ImmortalMovementInfoRes",
			block = true
		},
		{
			"PM_ImmortalMovementUnlockScoreReq",
			"PM_ImmortalMovementUnlockScoreRes",
			block = true
		},
		{
			"PM_ImmortalMovementChallengeReq",
			"PM_ImmortalMovementChallengeRes",
			block = true
		},
		{
			"PM_ImmortalMovementNotifyChallengeRes"
		},
		[255] = "ImmortalMovementExtension"
	},
	[656] = {
		{
			"PM_DivineEmpressClgGetInfoReq",
			"PM_DivineEmpressClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineEmpressNormalClgReq",
			"PM_DivineEmpressNormalClgRes",
			block = true
		},
		{
			"PM_DivineEmpressGainProgreePrizeReq",
			"PM_DivineEmpressGainProgreePrizeRes",
			block = true
		},
		{
			"PM_DivineEmpressResetNormalClgBuffReq",
			"PM_DivineEmpressResetNormalClgBuffRes",
			block = true
		},
		{
			"PM_DivineEmpressNotifyNormalClgRes"
		},
		{
			"PM_DivineEmpressNotifyExtremeClgRes"
		},
		{
			"PM_DivineEmpressExtremeClgReq",
			"PM_DivineEmpressExtremeClgRes",
			block = true
		},
		{
			"PM_DivineEmpressResetExtremeStageReq",
			"PM_DivineEmpressResetExtremeStageRes",
			block = true
		},
		[255] = "DivineEmpressChallengeExtension"
	},
	[657] = {
		{
			"PM_YinZhiClgInfoReq",
			"PM_YinZhiClgInfoRes",
			block = true
		},
		{
			"PM_YinZhiClgResetReq",
			"PM_YinZhiClgResetRes",
			block = true
		},
		{
			"PM_YinZhiClgChallengeReq",
			"PM_YinZhiClgChallengeRes",
			block = true
		},
		{
			"PM_YinZhiClgConfirmReq",
			"PM_YinZhiClgConfirmRes",
			block = true
		},
		[255] = "YinZhiClgExtension",
		[10] = {
			"PM_NotifyYinZhiClgChallengeFinshRes"
		}
	},
	[658] = {
		{
			"PM_IslandStationInfoReq",
			"PM_IslandStationInfoRes",
			block = true
		},
		{
			"PM_IslandStationRefreshShelfReq",
			"PM_IslandStationRefreshShelfRes",
			block = true
		},
		{
			"PM_IslandStationOneKeyFullFillReq",
			"PM_IslandStationOneKeyFullFillRes",
			block = true
		},
		{
			"PM_IslandStationPutOrChangeFoodReq",
			"PM_IslandStationPutOrChangeFoodRes",
			block = true
		},
		{
			"PM_IslandStationMakeFoodReq",
			"PM_IslandStationMakeFoodRes",
			block = true
		},
		{
			"PM_IslandStationStartGameReq",
			"PM_IslandStationStartGameRes",
			block = true
		},
		{
			"PM_IslandStationEndGameReq",
			"PM_IslandStationEndGameRes",
			block = true
		},
		{
			"PM_IslandStationGetBossInfoReq",
			"PM_IslandStationGetBossInfoRes",
			block = true
		},
		{
			"PM_IslandStationChallengeBossReq",
			"PM_IslandStationChallengeBossRes",
			block = true
		},
		{
			"PM_IslandStationResetChatReq",
			"PM_IslandStationResetChatRes",
			block = true
		},
		{
			"PM_IslandStationSelectAnswerReq",
			"PM_IslandStationSelectAnswerRes",
			block = true
		},
		{
			"PM_IslandStationGainCollectSkinPrizeReq",
			"PM_IslandStationGainCollectSkinPrizeRes",
			block = true
		},
		[255] = "IslandStationExtension",
		[101] = {
			"PM_Notify_IslandStationProfitRefresh",
			block = true
		},
		[102] = {
			"PM_Notify_IslandStationChallengeResult",
			block = true
		}
	},
	[659] = {
		{
			"PM_BoneDragonClgInfoReq",
			"PM_BoneDragonClgInfoRes",
			block = true
		},
		{
			"PM_BoneDragonClgSelectPetReq",
			"PM_BoneDragonClgSelectPetRes",
			block = true
		},
		{
			"PM_BoneDragonClgSelectFormationReq",
			"PM_BoneDragonClgSelectFormationRes",
			block = true
		},
		{
			"PM_BoneDragonClgRefreshFormationReq",
			"PM_BoneDragonClgRefreshFormationRes",
			block = true
		},
		{
			"PM_BoneDragonClgChallengeReq",
			"PM_BoneDragonClgChallengeRes",
			block = true
		},
		{
			"PM_BoneDragonClgConfirmReq",
			"PM_BoneDragonClgConfirmRes",
			block = true
		},
		{
			"PM_BoneDragonClgResetReq",
			"PM_BoneDragonClgResetRes",
			block = true
		},
		[255] = "BoneDragonClgExtension",
		[10] = {
			"PM_NotifyBoneDragonClgChallengeFinishRes"
		}
	},
	[660] = {
		{
			"PM_FreeScuffleGetInfoReq",
			"PM_FreeScuffleGetInfoRes",
			block = true
		},
		{
			"PM_FreeScuffleGainCoinReq",
			"PM_FreeScuffleGainCoinRes",
			block = true
		},
		{
			"PM_FreeScuffleUnlockBlockReq",
			"PM_FreeScuffleUnlockBlockRes",
			block = true
		},
		{
			"PM_FreeScuffleUpgradlePetReq",
			"PM_FreeScuffleUpgradlePetRes",
			block = true
		},
		{
			"PM_FreeScuffleLotteryReq",
			"PM_FreeScuffleLotteryRes",
			block = true
		},
		{
			"PM_FreeScuffleScheduleReq",
			"PM_FreeScuffleScheduleRes",
			block = true
		},
		[255] = "FreeScuffleExtension",
		[11] = {
			"PM_FreeScuffleTaskInfoReq",
			"PM_FreeScuffleTaskInfoRes",
			block = true
		},
		[12] = {
			"PM_FreeScuffleStartEasterEggGameReq",
			"PM_FreeScuffleStartEasterEggGameRes",
			block = true
		},
		[13] = {
			"PM_FreeScuffleEndEasterEggGameReq",
			"PM_FreeScuffleEndEasterEggGameRes",
			block = true
		},
		[14] = {
			"PM_FreeScuffleRandomEventLotteryReq",
			"PM_FreeScuffleRandomEventLotteryRes",
			block = true
		},
		[15] = {
			"PM_FreeScuffleDeliverPackageReq",
			"PM_FreeScuffleDeliverPackageRes",
			block = true
		},
		[16] = {
			"PM_FreeScuffleGainTaskPrizeReq",
			"PM_FreeScuffleGainTaskPrizeRes",
			block = true
		},
		[17] = {
			"PM_FreeScuffleExitInterfaceReq",
			"PM_FreeScuffleExitInterfaceRes",
			block = true
		},
		[18] = {
			"PM_FreeScuffleGainTaskProgressPrizeReq",
			"PM_FreeScuffleGainTaskProgressPrizeRes",
			block = true
		},
		[19] = {
			"PM_FreeScuffleResetNextPackageReq",
			"PM_FreeScuffleResetNextPackageRes"
		},
		[20] = {
			"PM_FreeScuffleEnterInterfaceReq",
			"PM_FreeScuffleEnterInterfaceRes"
		},
		[21] = {
			"PM_FreeScuffleBattleInfoReq",
			"PM_FreeScuffleBattleInfoRes",
			block = true
		},
		[22] = {
			"PM_FreeScuffleSetFormReq",
			"PM_FreeScuffleSetFormRes",
			block = true
		},
		[23] = {
			"PM_FreeScuffleChangeSkillReq",
			"PM_FreeScuffleChangeSkillRes",
			block = true
		},
		[24] = {
			"PM_FreeScuffleMatchReq",
			"PM_FreeScuffleMatchRes",
			block = true
		},
		[25] = {
			"PM_FreeScuffleBattleReq",
			"PM_FreeScuffleBattleRes",
			block = true
		},
		[26] = {
			"PM_FreeScuffleRankViewReq",
			"PM_FreeScuffleRankViewRes",
			block = true
		},
		[101] = {
			"PM_FreeScuffleBattleNotifyRes"
		},
		[102] = {
			"PM_FreeScuffleTaskNotifyRes"
		}
	},
	[661] = {
		{
			"PM_BoneDragonDungeonGetInfoReq",
			"PM_BoneDragonDungeonGetInfoRes",
			block = true
		},
		{
			"PM_BoneDragonDungeonGainProgressPrizeReq",
			"PM_BoneDragonDungeonGainProgressPrizeRes",
			block = true
		},
		{
			"PM_BoneDragonDungeonStartExploreReq",
			"PM_BoneDragonDungeonStartExploreRes",
			block = true
		},
		{
			"PM_BoneDragonDungeonExitOrResetReq",
			"PM_BoneDragonDungeonExitOrResetRes",
			block = true
		},
		{
			"PM_BoneDragonDungeonMoveReq",
			"PM_BoneDragonDungeonMoveRes",
			block = true
		},
		{
			"PM_BoneDragonDungeonHandleEventReq",
			"PM_BoneDragonDungeonHandleEventRes",
			block = true
		},
		{
			"PM_BoneDragonDungeonBuyPetReq",
			"PM_BoneDragonDungeonBuyPetRes",
			block = true
		},
		[255] = "BoneDragonDungeonExtension",
		[101] = {
			"PM_Notify_BoneDragonDungeonChallengeResult",
			block = true
		}
	},
	[662] = {
		{
			"PM_DivineIsaacClgInfoReq",
			"PM_DivineIsaacClgInfoRes",
			block = true
		},
		{
			"PM_DivineIsaacClgProducePuppetReq",
			"PM_DivineIsaacClgProducePuppetRes",
			block = true
		},
		{
			"PM_DivineIsaacClgResetReq",
			"PM_DivineIsaacClgResetRes",
			block = true
		},
		{
			"PM_DivineIsaacClgChallengeReq",
			"PM_DivineIsaacClgChallengeRes",
			block = true
		},
		[255] = "DivineIsaacClgExtension",
		[11] = {
			"PM_NotifyDivineIsaacClgChallengeFinishRes"
		}
	},
	[663] = {
		{
			"PM_CompanionMallGetInfoReq",
			"PM_CompanionMallGetInfoRes",
			block = true
		},
		{
			"PM_CompanionMallGainCompanionReq",
			"PM_CompanionMallGainCompanionRes",
			block = true
		},
		{
			"PM_CompanionMallGetAddressInfoReq",
			"PM_CompanionMallGetAddressInfoRes",
			block = true
		},
		{
			"PM_CompanionMallSubmitOrModifyAddressReq",
			"PM_CompanionMallSubmitOrModifyAddressRes",
			block = true
		},
		{
			"PM_CompanionMallGetRankInfoReq",
			"PM_CompanionMallGetRankInfoRes",
			block = true
		},
		{
			"PM_CompanionMallSelectAddressReq",
			"PM_CompanionMallSelectAddressRes",
			block = true
		},
		{
			"PM_CompanionMallDeleteAddressReq",
			"PM_CompanionMallDeleteAddressRes",
			block = true
		},
		[255] = "CompanionMallExtension",
		[101] = {
			"PM_Notify_CompanionMallPaySucResult",
			block = true
		}
	},
	[664] = {
		{
			"PM_StarHallInfoReq",
			"PM_StarHallInfoRes",
			block = true
		},
		{
			"PM_StarHallChallengeReq",
			"PM_StarHallChallengeRes",
			block = true
		},
		{
			"PM_StarHallResetReq",
			"PM_StarHallResetRes",
			block = true
		},
		{
			"PM_StarHallRankInfoReq",
			"PM_StarHallRankInfoRes",
			block = true
		},
		[255] = "StarHallExtension",
		[11] = {
			"PM_NotifyStarHallChallengeFinishRes"
		}
	},
	[665] = {
		{
			"PM_FinalEchoInfoReq",
			"PM_FinalEchoInfoRes",
			block = true
		},
		{
			"PM_FinalEchoChallengeReq",
			"PM_FinalEchoChallengeRes",
			block = true
		},
		{
			"PM_FinalEchoConfirmReq",
			"PM_FinalEchoConfirmRes",
			block = true
		},
		{
			"PM_FinalEchoResetReq",
			"PM_FinalEchoResetRes",
			block = true
		},
		{
			"PM_FinalEchoRankInfoReq",
			"PM_FinalEchoRankInfoRes",
			block = true
		},
		[255] = "FinalEchoExtension",
		[11] = {
			"PM_NotifyFinalEchoChallengeFinishRes"
		}
	},
	[666] = {
		{
			"PM_AwakenOathAncestorInfoReq",
			"PM_AwakenOathAncestorInfoRes",
			block = true
		},
		{
			"PM_AwakenOathAncestorUnlockPointReq",
			"PM_AwakenOathAncestorUnlockPointRes",
			block = true
		},
		{
			"PM_GainProgressPrizeReq",
			"PM_GainProgressPrizeRes",
			block = true
		},
		{
			"PM_AwakenOathAncestorChallengeReq",
			"PM_AwakenOathAncestorChallengeRes",
			block = true
		},
		{
			"PM_AwakenOathAncestorNotifyChallengeRes"
		},
		[255] = "AwakenOathAncestorExtension"
	},
	[667] = {
		{
			"PM_DemonDescendInfoReq",
			"PM_DemonDescendInfoRes",
			block = true
		},
		{
			"PM_DemonDescendUnlockBuffReq",
			"PM_DemonDescendUnlockBuffRes",
			block = true
		},
		{
			"PM_DemonDescendGainProgressPrizeReq",
			"PM_DemonDescendGainProgressPrizeRes",
			block = true
		},
		{
			"PM_DemonDescendCheckInReq",
			"PM_DemonDescendCheckInRes",
			block = true
		},
		{
			"PM_DemonDescendResetBuffReq",
			"PM_DemonDescendResetBuffRes",
			block = true
		},
		{
			"PM_DemonDescendStageChallengeReq",
			"PM_DemonDescendStageChallengeRes",
			block = true
		},
		{
			"PM_DemonDescendBossChallengeReq",
			"PM_DemonDescendBossChallengeRes",
			block = true
		},
		{
			"PM_DemonDescendNotifyStageChallengeRes"
		},
		{
			"PM_DemonDescendNotifyBossChallengeRes"
		},
		{
			"PM_DemonDescendRankViewReq",
			"PM_DemonDescendRankViewRes",
			block = true
		},
		[255] = "DemonDescendExtension"
	},
	[668] = {
		{
			"PM_FusionSoulGetInfoReq",
			"PM_FusionSoulGetInfoRes",
			block = true
		},
		{
			"PM_FusionSoulGainProgressPrizeReq",
			"PM_FusionSoulGainProgressPrizeRes",
			block = true
		},
		{
			"PM_FusionSoulStartDispatchReq",
			"PM_FusionSoulStartDispatchRes",
			block = true
		},
		{
			"PM_FusionSoulFinishDispatchReq",
			"PM_FusionSoulFinishDispatchRes",
			block = true
		},
		{
			"PM_FusionSoulBattleReq",
			"PM_FusionSoulBattleRes",
			block = true
		},
		{
			"PM_FusionSoulFinishMissionReq",
			"PM_FusionSoulFinishMissionRes",
			block = true
		},
		{
			"PM_FusionSoulSelectAnswerReq",
			"PM_FusionSoulSelectAnswerRes",
			block = true
		},
		{
			"PM_FusionSoulFinishFinalEventReq",
			"PM_FusionSoulFinishFinalEventRes",
			block = true
		},
		{
			"PM_FusionSoulCombineClueReq",
			"PM_FusionSoulCombineClueRes",
			block = true
		},
		[255] = "FusionSoulExtension",
		[101] = {
			"PM_Notify_FusionSoulChallengeResult",
			block = true
		},
		[102] = {
			"PM_Notify_FusionSoulClueGain",
			block = true
		}
	},
	[669] = {
		{
			"PM_TeenCKGlobalInfoReq",
			"PM_TeenCKGlobalInfoRes",
			block = true
		},
		{
			"PM_TeenCKNotifyStepChangeRes"
		},
		{
			"PM_TeenCKBattleRecordReq",
			"PM_TeenCKBattleRecordRes",
			block = true
		},
		{
			"PM_TeenCKBattleVideoReq",
			"PM_TeenCKBattleVideoRes",
			block = true
		},
		{
			"PM_TeenCKSelectPetReq",
			"PM_TeenCKSelectPetRes",
			block = true
		},
		{
			"PM_TeenCKGainGuessCoinReq",
			"PM_TeenCKGainGuessCoinRes",
			block = true
		},
		[255] = "TeenChampionKingExtension",
		[11] = {
			"PM_TeenCKQualifierInfoReq",
			"PM_TeenCKQualifierInfoRes",
			block = true
		},
		[12] = {
			"PM_TeenCKMatchReq",
			"PM_TeenCKMatchRes",
			block = true
		},
		[13] = {
			"PM_TeenCKCancelMatchReq",
			"PM_TeenCKCancelMatchRes",
			block = true
		},
		[14] = {
			"PM_NotifyTeenCKMatchFailRes"
		},
		[15] = {
			"PM_TeenCKQualifierRankViewReq",
			"PM_TeenCKQualifierRankViewRes",
			block = true
		},
		[16] = {
			"PM_TeenCKQualifierPetRankReq",
			"PM_TeenCKQualifierPetRankRes",
			block = true
		},
		[31] = {
			"PM_TeenCKMyKnockoutInfoReq",
			"PM_TeenCKMyKnockoutInfoRes",
			block = true
		},
		[32] = {
			"PM_TeenCKGetKnockoutScheduleReq",
			"PM_TeenCKGetKnockoutScheduleRes",
			block = true
		},
		[33] = {
			"PM_TeenCKKnockoutGuessRecordReq",
			"PM_TeenCKKnockoutGuessRecordRes",
			block = true
		},
		[34] = {
			"PM_TeenCKGuessKnockoutReq",
			"PM_TeenCKGuessKnockoutRes",
			block = true
		},
		[35] = {
			"PM_TeenCKGuessChampionshipReq",
			"PM_TeenCKGuessChampionshipRes",
			block = true
		},
		[36] = {
			"PM_TeenCKChangeGuessRankReq",
			"PM_TeenCKChangeGuessRankRes",
			block = true
		},
		[37] = {
			"PM_TeenCKChampionshipGuessRecordReq",
			"PM_TeenCKChampionshipGuessRecordRes",
			block = true
		},
		[38] = {
			"PM_TeenCKDisplayInfoReq",
			"PM_TeenCKDisplayInfoRes",
			block = true
		},
		[41] = {
			"PM_TeenCKKnockoutJoinRoomInfoReq",
			"PM_TeenCKKnockoutJoinRoomInfoRes",
			block = true
		},
		[42] = {
			"PM_TeenCKKnockoutInviteOpReq",
			"PM_TeenCKKnockoutInviteOpRes",
			block = true
		},
		[43] = {
			"PM_NotifyTeenCKKnockoutOpInvitedRes"
		},
		[44] = {
			"PM_TeenCKKnockoutJoinRoomReq",
			"PM_TeenCKKnockoutJoinRoomRes",
			block = true
		},
		[45] = {
			"PM_TeenCKKnockoutLeaveRoomReq",
			"PM_TeenCKKnockoutLeaveRoomRes",
			block = true
		},
		[46] = {
			"PM_NotifyTeenCKKnockoutOpJoinRoomRes"
		},
		[51] = {
			"PM_NotifyTeenCKFightStartRes"
		},
		[52] = {
			"PM_TeenCKSetGameFormReq",
			"PM_TeenCKSetGameFormRes",
			block = true
		},
		[53] = {
			"PM_NotifyTeenCKSetGameFormFailRes"
		},
		[54] = {
			"PM_NotifyTeenCKOpSetFormFinishRes"
		},
		[55] = {
			"PM_NotifyTeenCKTurnToNextGameRoundRes"
		},
		[56] = {
			"PM_NotifyTeenCKGameEndRes"
		},
		[57] = {
			"PM_TeenCKSyncRoomInfoReq",
			"PM_TeenCKSyncRoomInfoRes",
			block = true
		},
		[58] = {
			"PM_TeenCKNotifyRoomInfoRes",
			block = true
		},
		[59] = {
			"PM_TeenCKLeaveGameReq",
			"PM_TeenCKLeaveGameRes",
			block = true
		}
	},
	[670] = {
		{
			"PM_DivineYuHuiClgInfoReq",
			"PM_DivineYuHuiClgInfoRes",
			block = true
		},
		{
			"PM_DivineYuHuiClgChallengeReq",
			"PM_DivineYuHuiClgChallengeRes",
			block = true
		},
		[255] = "DivineYuHuiClgExtension",
		[4] = {
			"PM_DivineYuHuiClgResetReq",
			"PM_DivineYuHuiClgResetRes",
			block = true
		},
		[11] = {
			"PM_NotifyDivineYuHuiClgFinishRes"
		}
	},
	[671] = {
		{
			"PM_ShiZuDragonClgInfoReq",
			"PM_ShiZuDragonClgInfoRes",
			block = true
		},
		{
			"PM_ShiZuDragonClgChallengeReq",
			"PM_ShiZuDragonClgChallengeRes",
			block = true
		},
		[255] = "ShiZuDragonClgExtension",
		[4] = {
			"PM_ShiZuDragonClgResetReq",
			"PM_ShiZuDragonClgResetRes",
			block = true
		},
		[11] = {
			"PM_NotifyShiZuDragonClgFinishRes"
		}
	},
	[672] = {
		{
			"PM_DivineFuYaoClgInfoReq",
			"PM_DivineFuYaoClgInfoRes",
			block = true
		},
		{
			"PM_DivineFuYaoClgNormalChallengeReq",
			"PM_DivineFuYaoClgNormalChallengeRes",
			block = true
		},
		{
			"PM_NotifyFuYaoClgNormalChallengeFinishRes"
		},
		{
			"PM_DivineFuYaoClgExtremeChallengeReq",
			"PM_DivineFuYaoClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_DivineFuYaoClgExtremeConfirmReq",
			"PM_DivineFuYaoClgExtremeConfirmRes",
			block = true
		},
		{
			"PM_DivineFuYaoClgExtremeResetReq",
			"PM_DivineFuYaoClgExtremeResetRes",
			block = true
		},
		{
			"PM_NotifyFuYaoClgExtremeChallengeFinishRes"
		},
		[255] = "DivineFuYaoClgExtension"
	},
	[673] = {
		{
			"PM_TianYanMatchGetInfoReq",
			"PM_TianYanMatchGetInfoRes",
			block = true
		},
		{
			"PM_TianYanMatchSelectToyReq",
			"PM_TianYanMatchSelectToyRes",
			block = true
		},
		{
			"PM_TianYanMatchUpFriendshipReq",
			"PM_TianYanMatchUpFriendshipRes",
			block = true
		},
		{
			"PM_TianYanMatchSetWishToyReq",
			"PM_TianYanMatchSetWishToyRes",
			block = true
		},
		{
			"PM_TianYanMatchMatchReq",
			"PM_TianYanMatchMatchRes",
			block = true
		},
		{
			"PM_TianYanMatchCancelMatchReq",
			"PM_TianYanMatchCancelMatchRes",
			block = true
		},
		{
			"PM_TianYanMatchGenKeyReq",
			"PM_TianYanMatchGenKeyRes",
			block = true
		},
		{
			"PM_TianYanMatchMatchBuddyReq",
			"PM_TianYanMatchMatchBuddyRes",
			block = true
		},
		{
			"PM_TianYanMatchGainMatchPrizeReq",
			"PM_TianYanMatchGainMatchPrizeRes",
			block = true
		},
		{
			"PM_TianYanMatchGainManualPrizeReq",
			"PM_TianYanMatchGainManualPrizeRes",
			block = true
		},
		{
			"PM_TianYanMatchRankViewReq",
			"PM_TianYanMatchRankViewRes",
			block = true
		},
		[255] = "TianYanMatchExtension",
		[101] = {
			"PM_TianYanMatchNotifyMatchSucRes"
		},
		[102] = {
			"PM_TianYanMatchNotifyMatchFailRes"
		}
	},
	[674] = {
		{
			"PM_DivineTeshamuInfoReq",
			"PM_DivineTeshamuInfoRes",
			block = true
		},
		{
			"PM_DivineTeshamuResetFloorReq",
			"PM_DivineTeshamuResetFloorRes",
			block = true
		},
		{
			"PM_DivineTeshamuChallengeReq",
			"PM_DivineTeshamuChallengeRes",
			block = true
		},
		{
			"PM_DivineTeshamuNotifyChallengeRes"
		},
		{
			"PM_DivineTeshamuSaveReq",
			"PM_DivineTeshamuSaveRes",
			block = true
		},
		{
			"PM_DivineTeshamuAdvanceReq",
			"PM_DivineTeshamuAdvanceRes",
			block = true
		},
		[255] = "DivineTeshamuExtension"
	},
	[675] = {
		{
			"PM_LinkendlessGameInfoReq",
			"PM_LinkendlessGameInfoRes",
			block = true
		},
		{
			"PM_LinkendlessGameStartGameReq",
			"PM_LinkendlessGameStartGameRes",
			block = true
		},
		{
			"PM_LinkendlessGameEndGameReq",
			"PM_LinkendlessGameEndGameRes",
			block = true
		},
		{
			"PM_LinkendlessGameSweepReq",
			"PM_LinkendlessGameSweepRes",
			block = true
		},
		{
			"PM_LinkendlessGameGainProgressPrizeReq",
			"PM_LinkendlessGameGainProgressPrizeRes",
			block = true
		},
		[255] = "LinkendlessGameExtension"
	},
	[676] = {
		{
			"PM_HeartOfAoJiuClgGetInfoReq",
			"PM_HeartOfAoJiuClgGetInfoRes",
			block = true
		},
		{
			"PM_HeartOfAoJiuClgChallengeReq",
			"PM_HeartOfAoJiuClgChallengeRes",
			block = true
		},
		{
			"PM_HeartOfAoJiuClgConfirmReq",
			"PM_HeartOfAoJiuClgConfirmRes",
			block = true
		},
		{
			"PM_HeartOfAoJiuClgResetReq",
			"PM_HeartOfAoJiuClgResetRes",
			block = true
		},
		{
			"PM_HeartOfAoJiuClgGetRankInfoReq",
			"PM_HeartOfAoJiuClgGetRankInfoRes",
			block = true
		},
		{
			"PM_HeartOfAoJiuClgGetRankInfoV0926Req",
			"PM_HeartOfAoJiuClgGetRankInfoV0926Res",
			block = true
		},
		[255] = "HeartOfAoJiuClgExtension",
		[101] = {
			"PM_Notify_HeartOfAoJiuClgChallengeResult",
			block = true
		}
	},
	[677] = {
		{
			"DragonKingARuiShiHUDInfoReq",
			"DragonKingARuiShiHUDInfoRes",
			block = true
		},
		{
			"DragonKingARuiShiHUDGainPrizeReq",
			"DragonKingARuiShiHUDGainPrizeRes",
			block = true
		},
		[255] = "DragonKingARuiShiHUDExtension"
	},
	[678] = {
		{
			"PM_IceQibuGameInfoReq",
			"PM_IceQibuGameInfoRes",
			block = true
		},
		{
			"PM_IceQibuGameStartGameReq",
			"PM_IceQibuGameStartGameRes",
			block = true
		},
		{
			"PM_IceQibuGameEndGameReq",
			"PM_IceQibuGameEndGameRes",
			block = true
		},
		{
			"PM_IceQibuGameSweepReq",
			"PM_IceQibuGameSweepRes",
			block = true
		},
		[255] = "IceQibuGameExtension"
	},
	[679] = {
		{
			"PM_DivineTunTianClgGetInfoReq",
			"PM_DivineTunTianClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineTunTianClgExtremeChallengeReq",
			"PM_DivineTunTianClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_DivineTunTianClgExtremeConfirmReq",
			"PM_DivineTunTianClgExtremeConfirmRes",
			block = true
		},
		{
			"PM_DivineTunTianClgExtremeResetReq",
			"PM_DivineTunTianClgExtremeResetRes",
			block = true
		},
		{
			"PM_DivineTunTianClgNormalChallengeReq",
			"PM_DivineTunTianClgNormalChallengeRes",
			block = true
		},
		{
			"PM_DivineTunTianClgGainNormalProgressPrizeReq",
			"PM_DivineTunTianClgGainNormalProgressPrizeRes",
			block = true
		},
		[255] = "DivineTunTianClgExtension",
		[101] = {
			"PM_Notify_DivineTunTianClgExtremeChallengeResultRes"
		},
		[102] = {
			"PM_Notify_DivineTunTianClgNormalChallengeResultRes"
		}
	},
	[680] = {
		{
			"PM_PrinceLiyangInfoReq",
			"PM_PrinceLiyangInfoRes",
			block = true
		},
		{
			"PM_PrinceLiyangGainHangingReq",
			"PM_PrinceLiyangGainHangingRes",
			block = true
		},
		{
			"PM_PrinceLiyangUnlockBuildingReq",
			"PM_PrinceLiyangUnlockBuildingRes",
			block = true
		},
		{
			"PM_PrinceLiyangUpgradeBuildingReq",
			"PM_PrinceLiyangUpgradeBuildingRes",
			block = true
		},
		{
			"PM_PrinceLiyangHandleEventReq",
			"PM_PrinceLiyangHandleEventRes",
			block = true
		},
		{
			"PM_PrinceLiyangOneKeyGainPrizeReq",
			"PM_PrinceLiyangOneKeyGainPrizeRes",
			block = true
		},
		{
			"PM_NotifyPrinceLiyangChangeRes"
		},
		{
			"PM_PrinceLiyangRankInfoReq",
			"PM_PrinceLiyangRankInfoRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgInfoReq",
			"PM_PrinceLiyangClgInfoRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgSelectStarReq",
			"PM_PrinceLiyangClgSelectStarRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgSelfClgReq",
			"PM_PrinceLiyangClgSelfClgRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgSeekHelpReq",
			"PM_PrinceLiyangClgSeekHelpRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgResetStarReq",
			"PM_PrinceLiyangClgResetStarRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgHelpInfoReq",
			"PM_PrinceLiyangClgHelpInfoRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgHelpCenterReq",
			"PM_PrinceLiyangClgHelpCenterRes",
			block = true
		},
		{
			"PM_PrinceLiyangClgHelpClgReq",
			"PM_PrinceLiyangClgHelpClgRes",
			block = true
		},
		[255] = "PrinceLiyangExtension"
	},
	[681] = {
		{
			"PM_StarBattleInfoReq",
			"PM_StarBattleInfoRes",
			block = true
		},
		{
			"PM_StarBattlesetDefenseReq",
			"PM_StarBattlesetDefenseRes",
			block = true
		},
		{
			"PM_StarBattleStageChallengeReq",
			"PM_StarBattleStageChallengeRes",
			block = true
		},
		{
			"PM_StarBattleNotifyStageChallengeRes"
		},
		{
			"PM_StarBattleBossChallengeReq",
			"PM_StarBattleBossChallengeRes",
			block = true
		},
		{
			"PM_StarBattleNotifyBossChallengeRes"
		},
		{
			"PM_StarBattleSignInReq",
			"PM_StarBattleSignInRes",
			block = true
		},
		{
			"PM_StarBattleGainProgressPrizeReq",
			"PM_StarBattleGainProgressPrizeRes",
			block = true
		},
		{
			"PM_StarBattleRankViewReq",
			"PM_StarBattleRankViewRes",
			block = true
		},
		{
			"PM_StarBattleVerifyRaceReq",
			"PM_StarBattleVerifyRaceRes",
			block = true
		},
		{
			"PM_StarBattleOneClickGainDefensePrizeReq",
			"PM_StarBattleOneClickGainDefensePrizeRes",
			block = true
		},
		[255] = "StarBattleExtension"
	},
	[682] = {
		{
			"PM_DivineAoJiuClgGetInfoReq",
			"PM_DivineAoJiuClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineAoJiuClgExtremeClgReq",
			"PM_DivineAoJiuClgExtremeClgRes",
			block = true
		},
		{
			"PM_DivineAoJiuClgConfirmReq",
			"PM_DivineAoJiuClgConfirmRes",
			block = true
		},
		{
			"PM_DivineAoJiuClgNormalClgReq",
			"PM_DivineAoJiuClgNormalClgRes",
			block = true
		},
		{
			"PM_DivineAoJiuClgBuyPassReq",
			"PM_DivineAoJiuClgBuyPassRes",
			block = true
		},
		[255] = "DivineAoJiuClgExtension",
		[101] = {
			"PM_DivineAoJiuClgNotifyExtremeClgRes"
		},
		[102] = {
			"PM_DivineAoJiuClgNotifyNormalClgRes"
		}
	},
	[683] = {
		{
			"PM_DivineWaterTianYanClgGetInfoReq",
			"PM_DivineWaterTianYanClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineWaterTianYanClgFightReq",
			"PM_DivineWaterTianYanClgFightRes",
			block = true
		},
		{
			"PM_DivineWaterTianYanClgUnlockBuffReq",
			"PM_DivineWaterTianYanClgUnlockBuffRes",
			block = true
		},
		[255] = "DivineWaterTianYanClgExtension",
		[101] = {
			"PM_DivineWaterTianYanClgNotifyFightRes"
		}
	},
	[684] = {
		{
			"PM_MagicSchoolGetInfoReq",
			"PM_MagicSchoolGetInfoRes",
			block = true
		},
		{
			"PM_MagicSchoolVisitReq",
			"PM_MagicSchoolVisitRes",
			block = true
		},
		{
			"PM_MagicSchoolJoinCampReq",
			"PM_MagicSchoolJoinCampRes",
			block = true
		},
		{
			"PM_MagicSchoolSelectBuffReq",
			"PM_MagicSchoolSelectBuffRes",
			block = true
		},
		{
			"PM_MagicSchoolChallengeReq",
			"PM_MagicSchoolChallengeRes",
			block = true
		},
		{
			"PM_MagicSchoolGainLevelPrizeReq",
			"PM_MagicSchoolGainLevelPrizeRes",
			block = true
		},
		[255] = "MagicSchoolExtension",
		[101] = {
			"PM_Notify_MagicSchoolChallengeResult",
			block = true
		}
	},
	[685] = {
		{
			"PM_DivineZhongFeiClgExtremeInfoReq",
			"PM_DivineZhongFeiClgExtremeInfoRes",
			block = true
		},
		{
			"PM_DivineZhongFeiClgExtremeChallengeReq",
			"PM_DivineZhongFeiClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_NotifyDivineZhongFeiClgExtremeFinishRes"
		},
		{
			"PM_DivineZhongFeiClgExtremeConfirmReq",
			"PM_DivineZhongFeiClgExtremeConfirmRes",
			block = true
		},
		{
			"PM_DivineZhongFeiClgExtremeResetReq",
			"PM_DivineZhongFeiClgExtremeResetRes",
			block = true
		},
		{
			"PM_DivineZhongFeiClgNormalInfoReq",
			"PM_DivineZhongFeiClgNormalInfoRes",
			block = true
		},
		{
			"PM_DivineZhongFeiClgNormalChallengeReq",
			"PM_DivineZhongFeiClgNormalChallengeRes",
			block = true
		},
		{
			"PM_NotifyDivineZhongFeiClgNormalFinishRes"
		},
		{
			"PM_DivineZhongFeiClgNormalGainPrizeReq",
			"PM_DivineZhongFeiClgNormalGainPrizeRes",
			block = true
		},
		[255] = "DivineZhongFeiClgExtension"
	},
	[686] = {
		{
			"PM_PhantomSpaceGetInfoReq",
			"PM_PhantomSpaceGetInfoRes",
			block = true
		},
		{
			"PM_PhantomSpaceChallengeReq",
			"PM_PhantomSpaceChallengeRes",
			block = true
		},
		{
			"PM_PhantomSpaceResetReq",
			"PM_PhantomSpaceResetRes",
			block = true
		},
		{
			"PM_PhantomSpaceGetRankInfoReq",
			"PM_PhantomSpaceGetRankInfoRes",
			block = true
		},
		{
			"PM_PhantomSpaceGetEndlessInfoReq",
			"PM_PhantomSpaceGetEndlessInfoRes",
			block = true
		},
		{
			"PM_PhantomSpaceChallengeEndlessReq",
			"PM_PhantomSpaceChallengeEndlessRes",
			block = true
		},
		{
			"PM_PhantomSpaceResetEndlessReq",
			"PM_PhantomSpaceResetEndlessRes",
			block = true
		},
		[255] = "PhantomSpaceExtension",
		[101] = {
			"PM_Notify_PhantomSpaceChallengeResult",
			block = true
		},
		[102] = {
			"PM_Notify_PhantomSpaceEndlessChallengeResult",
			block = true
		}
	},
	[687] = {
		{
			"PM_DefendCarrotInfoReq",
			"PM_DefendCarrotInfoRes",
			block = true
		},
		{
			"PM_DefendCarrotUpgradeWeaponReq",
			"PM_DefendCarrotUpgradeWeaponRes",
			block = true
		},
		{
			"PM_DefendCarrotStartGameReq",
			"PM_DefendCarrotStartGameRes",
			block = true
		},
		{
			"PM_DefendCarrotEndGameReq",
			"PM_DefendCarrotEndGameRes",
			block = true
		},
		{
			"PM_DefendCarrotGainPrizeReq",
			"PM_DefendCarrotGainPrizeRes",
			block = true
		},
		{
			"PM_DefendCarrotMaterialClgStartGameReq",
			"PM_DefendCarrotMaterialClgStartGameRes",
			block = true
		},
		{
			"PM_DefendCarrotMaterialClgEndGameReq",
			"PM_DefendCarrotMaterialClgEndGameRes",
			block = true
		},
		{
			"PM_DefendCarrotRankInfoReq",
			"PM_DefendCarrotRankInfoRes",
			block = true
		},
		[255] = "DefendCarrotExtension"
	},
	[688] = {
		{
			"PM_DivineHopeInfoReq",
			"PM_DivineHopeInfoRes",
			block = true
		},
		{
			"PM_DivineHopeResetFloorReq",
			"PM_DivineHopeResetFloorRes",
			block = true
		},
		{
			"PM_DivineHopeChallengeReq",
			"PM_DivineHopeChallengeRes",
			block = true
		},
		{
			"PM_DivineHopeNotifyChallengeRes"
		},
		[255] = "DivineHopeExtension"
	},
	[689] = {
		{
			"PM_ParallelKingDragonInfoReq",
			"PM_ParallelKingDragonInfoRes",
			block = true
		},
		{
			"PM_ParallelKingDragonChallengeReq",
			"PM_ParallelKingDragonChallengeRes",
			block = true
		},
		{
			"PM_ParallelKingDragonNotifyChallengeRes"
		},
		[255] = "ParallelKingDragonExtension"
	},
	[690] = {
		{
			"PM_MSPvPInfoReq",
			"PM_MSPvPInfoRes",
			block = true
		},
		{
			"PM_MSPvPGetPresetFormationReq",
			"PM_MSPvPGetPresetFormationRes",
			block = true
		},
		{
			"PM_MSPvPSetPresetFormationReq",
			"PM_MSPvPSetPresetFormationRes",
			block = true
		},
		{
			"PM_MSPvPAskSwitchReq",
			"PM_MSPvPAskSwitchRes",
			block = true
		},
		{
			"PM_MSPvPAskHandleSwitchReq",
			"PM_MSPvPAskHandleSwitchRes",
			block = true
		},
		{
			"PM_MSPvPSetFormationReq",
			"PM_MSPvPSetFormationRes",
			block = true
		},
		{
			"PM_MSPvPSelectBuffReq",
			"PM_MSPvPSelectBuffRes",
			block = true
		},
		{
			"PM_MSPvPChatReq",
			"PM_MSPvPChatRes",
			block = true
		},
		{
			"PM_MSPvPRankInfoReq",
			"PM_MSPvPRankInfoRes",
			block = true
		},
		[255] = "MagicSchoolPvPExtension",
		[101] = {
			"PM_NotifyMSPvPMatchStartRes"
		},
		[102] = {
			"PM_NotifyMSPvPMatchOverTimeRes"
		},
		[103] = {
			"PM_NotifyMSPvPMatchFailRes"
		},
		[104] = {
			"PM_NotifyMSPvPGameStartRes"
		},
		[105] = {
			"PM_NotifyMSPvPAskSwitchPositionRes"
		},
		[106] = {
			"PM_NotifyMSPvPAskSwitchPositionResultRes"
		},
		[108] = {
			"PM_NotifyMsPvPWatchBattleResultRes"
		},
		[109] = {
			"PM_NotifyMsPvPStartSelectBuffRes"
		},
		[110] = {
			"PM_NotifyMsPvPFinishSelectBuffRes"
		},
		[111] = {
			"PM_NotifyMsPvPGameEndRes"
		},
		[112] = {
			"PM_NotifyMsPvPErrorRes"
		},
		[113] = {
			"PM_NotifyMsPvPChatRes"
		}
	},
	[691] = {
		{
			"PM_MagicContestGetInfoReq",
			"PM_MagicContestGetInfoRes",
			block = true
		},
		{
			"PM_MagicContestSetDefenseFormReq",
			"PM_MagicContestSetDefenseFormRes",
			block = true
		},
		{
			"PM_MagicContestStartMatchReq",
			"PM_MagicContestStartMatchRes",
			block = true
		},
		{
			"PM_MagicContestChallengeReq",
			"PM_MagicContestChallengeRes",
			block = true
		},
		{
			"PM_MagicContestSelectBuffReq",
			"PM_MagicContestSelectBuffRes",
			block = true
		},
		{
			"PM_MagicContestGetRankInfoReq",
			"PM_MagicContestGetRankInfoRes",
			block = true
		},
		[255] = "MagicContestExtension",
		[101] = {
			"PM_Notify_MagicContestChallengeResult",
			block = true
		}
	},
	[692] = {
		{
			"PM_ShowOffRankViewReq",
			"PM_ShowOffRankViewRes",
			block = true
		},
		[255] = "ShowOffRankExtension"
	},
	[693] = {
		{
			"PM_DivineKingSpaceDragonInfoReq",
			"PM_DivineKingSpaceDragonInfoRes",
			block = true
		},
		{
			"PM_DivineKingSpaceDragonResetFloorReq",
			"PM_DivineKingSpaceDragonResetFloorRes",
			block = true
		},
		{
			"PM_DivineKingSpaceDragonChallengeReq",
			"PM_DivineKingSpaceDragonChallengeRes",
			block = true
		},
		{
			"PM_DivineKingSpaceDragonNotifyChallengeRes"
		},
		[255] = "DivineKingSpaceDragonExtension"
	},
	[694] = {
		{
			"PM_SourceTraceUnlockNodeReq",
			"PM_SourceTraceUnlockNodeRes",
			block = true
		},
		{
			"PM_SourceTraceChangeEffectReq",
			"PM_SourceTraceChangeEffectRes",
			block = true
		},
		{
			"PM_SourceTraceOneKeyUnlockNodeReq",
			"PM_SourceTraceOneKeyUnlockNodeRes",
			block = true
		},
		[255] = "SourceTraceExtension"
	},
	[695] = {
		{
			"PM_DivineFarnasClgGetInfoReq",
			"PM_DivineFarnasClgGetInfoRes",
			block = true
		},
		{
			"PM_DivineFarnasClgExtremeFightReq",
			"PM_DivineFarnasClgExtremeFightRes",
			block = true
		},
		{
			"PM_DivineFarnasClgResetReq",
			"PM_DivineFarnasClgResetRes",
			block = true
		},
		{
			"PM_DivineFarnasClgNormalFightReq",
			"PM_DivineFarnasClgNormalFightRes",
			block = true
		},
		{
			"PM_DivineFarnasClgGainPrizeReq",
			"PM_DivineFarnasClgGainPrizeRes",
			block = true
		},
		[255] = "DivineFarnasClgExtension",
		[101] = {
			"PM_DivineFarnasClgExtremeFightNotifyRes"
		},
		[102] = {
			"PM_DivineFarnasClgNormalFightNotifyRes"
		}
	},
	[696] = {
		{
			"PM_MazeGameInfoReq",
			"PM_MazeGameInfoRes",
			block = true
		},
		{
			"PM_MazeGameStartGameReq",
			"PM_MazeGameStartGameRes",
			block = true
		},
		{
			"PM_MazeGameEndGameReq",
			"PM_MazeGameEndGameRes",
			block = true
		},
		[255] = "MazeGameExtension"
	},
	[697] = {
		{
			"PM_DoloresClgGetInfoReq",
			"PM_DoloresClgGetInfoRes",
			block = true
		},
		{
			"PM_DoloresClgChallengeReq",
			"PM_DoloresClgChallengeRes",
			block = true
		},
		{
			"PM_DoloresClgResetReq",
			"PM_DoloresClgResetRes",
			block = true
		},
		[255] = "DoloresClgExtension",
		[101] = {
			"PM_Notify_DoloresClgChallengeResultRes"
		}
	},
	[698] = {
		{
			"PM_OriginFightInfoReq",
			"PM_OriginFightInfoRes",
			block = true
		},
		{
			"PM_OriginFightCommonGodFavorReq",
			"PM_OriginFightCommonGodFavorRes",
			block = true
		},
		{
			"PM_OriginFightCollectTitanReq",
			"PM_OriginFightCollectTitanRes",
			block = true
		},
		{
			"PM_OriginFightBattleReq",
			"PM_OriginFightBattleRes",
			block = true
		},
		{
			"PM_OriginFightGainPrizeReq",
			"PM_OriginFightGainPrizeRes",
			block = true
		},
		[255] = "OriginFightExtension",
		[101] = {
			"PM_OriginFightNotifyBattleRes"
		}
	},
	[699] = {
		{
			"PM_DivineDarkKingDragonClgInfoReq",
			"PM_DivineDarkKingDragonClgInfoRes",
			block = true
		},
		{
			"PM_DivineDarkKingDragonClgChallengeReq",
			"PM_DivineDarkKingDragonClgChallengeRes",
			block = true
		},
		{
			"PM_DivineDarkKingDragonClgResetReq",
			"PM_DivineDarkKingDragonClgResetRes",
			block = true
		},
		{
			"PM_DivineDarkKingDragonClgConfirmReq",
			"PM_DivineDarkKingDragonClgConfirmRes",
			block = true
		},
		[255] = "DivineDarkKingDragonClgExtension",
		[10] = {
			"PM_NotifyDivineDarkKingDragonClgFinsihRes"
		}
	},
	[700] = {
		{
			"PM_ShadowDragonClgGetInfoReq",
			"PM_ShadowDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_ShadowDragonClgNowStageFightReq",
			"PM_ShadowDragonClgNowStageFightRes",
			block = true
		},
		{
			"PM_ShadowDragonClgResetAllStageReq",
			"PM_ShadowDragonClgResetAllStageRes",
			block = true
		},
		{
			"PM_ShadowDragonClgFuturePassStageFightReq",
			"PM_ShadowDragonClgFuturePassStageFightRes",
			block = true
		},
		{
			"PM_ShadowDragonClgSelectBuffReq",
			"PM_ShadowDragonClgSelectBuffRes",
			block = true
		},
		{
			"PM_ShadowDragonClgConfirmReq",
			"PM_ShadowDragonClgConfirmRes",
			block = true
		},
		[255] = "ShadowDragonClgExtension",
		[101] = {
			"PM_ShadowDragonClgNowStageFightNotifyRes"
		},
		[102] = {
			"PM_ShadowDragonClgFuturePassStageFightNotifyRes"
		}
	},
	[701] = {
		{
			"PM_GloryBattleInfoReq",
			"PM_GloryBattleInfoRes",
			block = true
		},
		{
			"PM_GloryBattleDrawGenreReq",
			"PM_GloryBattleDrawGenreRes",
			block = true
		},
		{
			"PM_GloryBattleSelectGenreReq",
			"PM_GloryBattleSelectGenreRes",
			block = true
		},
		{
			"PM_GloryBattleMatchFightReq",
			"PM_GloryBattleMatchFightRes",
			block = true
		},
		{
			"PM_GloryBattleCancelMatchReq",
			"PM_GloryBattleCancelMatchRes",
			block = true
		},
		{
			"PM_GloryBattleFightReq",
			"PM_GloryBattleFightRes",
			block = true
		},
		{
			"PM_GloryBattleGiveUpReq",
			"PM_GloryBattleGiveUpRes",
			block = true
		},
		{
			"PM_GloryBattleBuyTimesReq",
			"PM_GloryBattleBuyTimesRes"
		},
		{
			"PM_GloryBattleViewBtlReportReq",
			"PM_GloryBattleViewBtlReportRes",
			block = true
		},
		{
			"PM_GloryBattleRankViewReq",
			"PM_GloryBattleRankViewRes",
			block = true
		},
		{
			"PM_GloryBattleOperateHolyStripeReq",
			"PM_GloryBattleOperateHolyStripeRes",
			block = true
		},
		{
			"PM_GloryBattleSaveFormationReq",
			"PM_GloryBattleSaveFormationRes",
			block = true
		},
		[255] = "GloryBattleExtension",
		[20] = {
			"PM_GloryBattleRefreshShopReq",
			"PM_GloryBattleRefreshShopRes",
			block = true
		},
		[21] = {
			"PM_GloryBattleChangeLockStateReq",
			"PM_GloryBattleChangeLockStateRes",
			block = true
		},
		[22] = {
			"PM_GloryBattleBuyGoodsReq",
			"PM_GloryBattleBuyGoodsRes",
			block = true
		},
		[23] = {
			"PM_GloryBattleSalePetReq",
			"PM_GloryBattleSalePetRes",
			block = true
		},
		[101] = {
			"PM_GloryBattleNotifyFightRes"
		},
		[102] = {
			"PM_NotifyGloryBattleGainPetRes"
		},
		[103] = {
			"PM_NotifyGloryBattleIncExperiencePetRes"
		}
	},
	[702] = {
		{
			"PM_SurvivalKingInfoReq",
			"PM_SurvivalKingInfoRes",
			block = true
		},
		{
			"PM_SurvivalKingGetPresetReq",
			"PM_SurvivalKingGetPresetRes",
			block = true
		},
		{
			"PM_SurvivalKingSetPresetReq",
			"PM_SurvivalKingSetPresetRes",
			block = true
		},
		{
			"PM_SurvivalKingSignUpReq",
			"PM_SurvivalKingSignUpRes",
			block = true
		},
		{
			"PM_SurvivalKingBuyBuffReq",
			"PM_SurvivalKingBuyBuffRes",
			block = true
		},
		{
			"PM_SurvivalKingRoomInfoReq",
			"PM_SurvivalKingRoomInfoRes",
			block = true
		},
		{
			"PM_SurvivalKingRoomRecordReq",
			"PM_SurvivalKingRoomRecordRes",
			block = true
		},
		{
			"PM_SurvivalKingRecordLogReq",
			"PM_SurvivalKingRecordLogRes",
			block = true
		},
		{
			"PM_SurvivalKingRankInfoReq",
			"PM_SurvivalKingRankInfoRes",
			block = true
		},
		{
			"PM_SurvivalKingPrizeInfoReq",
			"PM_SurvivalKingPrizeInfoRes",
			block = true
		},
		{
			"PM_SurvivalKingGainPrizeReq",
			"PM_SurvivalKingGainPrizeRes",
			block = true
		},
		{
			"PM_SurvivalKingUpgradeLevelBuffReq",
			"PM_SurvivalKingUpgradeLevelBuffRes",
			block = true
		},
		[255] = "SurvivalKingExtension"
	},
	[703] = {
		{
			"PM_SurvivalKingSignInInfoReq",
			"PM_SurvivalKingSignInInfoRes",
			block = true
		},
		{
			"PM_SurvivalKingSignInReq",
			"PM_SurvivalKingSignInRes",
			block = true
		},
		{
			"PM_SurvivalKingSignInGainPrizeReq",
			"PM_SurvivalKingSignInGainPrizeRes",
			block = true
		},
		[255] = "SurvivalKingSignInExtension"
	},
	[704] = {
		{
			"PM_VRSpaceGetInfoReq",
			"PM_VRSpaceGetInfoRes",
			block = true
		},
		{
			"PM_VRSpaceSelectBuffReq",
			"PM_VRSpaceSelectBuffRes",
			block = true
		},
		{
			"PM_VRSpaceChallengeVirtualReq",
			"PM_VRSpaceChallengeVirtualRes",
			block = true
		},
		{
			"PM_VRSpaceConfirmVirtualResultReq",
			"PM_VRSpaceConfirmVirtualResultRes",
			block = true
		},
		{
			"PM_VRSpaceChallengeRealityReq",
			"PM_VRSpaceChallengeRealityRes",
			block = true
		},
		{
			"PM_VRSpaceResetRealityReq",
			"PM_VRSpaceResetRealityRes",
			block = true
		},
		{
			"PM_VRSpaceGetRankInfoReq",
			"PM_VRSpaceGetRankInfoRes",
			block = true
		},
		[255] = "VRSpaceExtension",
		[101] = {
			"PM_Notify_VRSpaceChallengeVirtualResult",
			block = true
		},
		[102] = {
			"PM_Notify_VRSpaceChallengeRealityResult",
			block = true
		}
	},
	[705] = {
		{
			"PM_OriginAgeLaunchGetInfoReq",
			"PM_OriginAgeLaunchGetInfoRes",
			block = true
		},
		{
			"PM_OriginAgeLaunchGainPrizeReq",
			"PM_OriginAgeLaunchGainPrizeRes",
			block = true
		},
		{
			"PM_OriginAgeLaunchBindCodeReq",
			"PM_OriginAgeLaunchBindCodeRes",
			block = true
		},
		[255] = "OriginAgeLaunchExtension"
	},
	[706] = {
		{
			"PM_OriginMaterialGameInfoReq",
			"PM_OriginMaterialGameInfoRes",
			block = true
		},
		{
			"PM_OriginMaterialGameStartReq",
			"PM_OriginMaterialGameStartRes",
			block = true
		},
		{
			"PM_OriginMaterialGameEndReq",
			"PM_OriginMaterialGameEndRes",
			block = true
		},
		{
			"PM_OriginMaterialGameGainPrizeReq",
			"PM_OriginMaterialGameGainPrizeRes",
			block = true
		},
		{
			"PM_OriginMaterialGameUnlockTalentReq",
			"PM_OriginMaterialGameUnlockTalentRes",
			block = true
		},
		{
			"PM_OriginMaterialGameReOpenSeasonReq",
			"PM_OriginMaterialGameReOpenSeasonRes",
			block = true
		},
		{
			"PM_OriginMaterialGameAllSeasonReq",
			"PM_OriginMaterialGameAllSeasonRes",
			block = true
		},
		{
			"PM_OriginMaterialGameOneKeyGainPrizeReq",
			"PM_OriginMaterialGameOneKeyGainPrizeRes",
			block = true
		},
		[255] = "OriginMaterialGameExtension"
	},
	[707] = {
		{
			"PM_OriginAsheClgGetInfoReq",
			"PM_OriginAsheClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginAsheClgChallengeReq",
			"PM_OriginAsheClgChallengeRes",
			block = true
		},
		{
			"PM_OriginAsheClgResetStageReq",
			"PM_OriginAsheClgResetStageRes",
			block = true
		},
		[255] = "OriginAsheClgExtension",
		[101] = {
			"PM_Notify_OriginAsheClgChallengeResultRes"
		}
	},
	[708] = {
		{
			"PM_OriginKingCiYuanDragonClgGetInfoReq",
			"PM_OriginKingCiYuanDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginKingCiYuanDragonClgFightReq",
			"PM_OriginKingCiYuanDragonClgFightRes",
			block = true
		},
		{
			"PM_OriginKingCiYuanDragonClgConfirmReq",
			"PM_OriginKingCiYuanDragonClgConfirmRes",
			block = true
		},
		{
			"PM_OriginKingCiYuanDragonClgResetReq",
			"PM_OriginKingCiYuanDragonClgResetRes",
			block = true
		},
		[255] = "OriginKingCiYuanDragonClgExtension",
		[101] = {
			"PM_OriginKingCiYuanDragonClgNotifyFightRes"
		}
	},
	[709] = {
		{
			"PM_NewEraNuoYaInfoReq",
			"PM_NewEraNuoYaInfoRes",
			block = true
		},
		{
			"PM_NewEraNuoYaResetFloorReq",
			"PM_NewEraNuoYaResetFloorRes",
			block = true
		},
		{
			"PM_NewEraNuoYaExtChallengeReq",
			"PM_NewEraNuoYaExtChallengeRes",
			block = true
		},
		{
			"PM_NewEraNuoYaNotifyExtChallengeRes"
		},
		{
			"PM_NewEraNuoYaSaveReq",
			"PM_NewEraNuoYaSaveRes",
			block = true
		},
		{
			"PM_NewEraNuoYaCommonChallengeReq",
			"PM_NewEraNuoYaCommonChallengeRes",
			block = true
		},
		{
			"PM_NewEraNuoYaNotifyCommonChallengeRes"
		},
		[255] = "NewEraNuoYaExtension"
	},
	[710] = {
		{
			"PM_DrawAndGuessInfoReq",
			"PM_DrawAndGuessInfoRes",
			block = true
		},
		{
			"PM_DrawAndGuessMatchReq",
			"PM_DrawAndGuessMatchRes",
			block = true
		},
		{
			"PM_DrawAndGuessCancelMatchReq",
			"PM_DrawAndGuessCancelMatchRes",
			block = true
		},
		{
			"PM_DrawAndGuessLeaveGameReq",
			"PM_DrawAndGuessLeaveGameRes",
			block = true
		},
		{
			"PM_DrawAndGuessSelectQuestionReq",
			"PM_DrawAndGuessSelectQuestionRes",
			block = true
		},
		{
			"PM_DrawAndGuessDrawReq",
			"PM_DrawAndGuessDrawRes",
			block = true
		},
		{
			"PM_DrawAndGuessAnswerReq",
			"PM_DrawAndGuessAnswerRes",
			block = true
		},
		{
			"PM_DrawAndGuessChatReq",
			"PM_DrawAndGuessChatRes",
			block = true
		},
		{
			"PM_DrawAndGuessGainPrizeReq",
			"PM_DrawAndGuessGainPrizeRes",
			block = true
		},
		{
			"PM_DrawAndGuessRankReq",
			"PM_DrawAndGuessRankRes",
			block = true
		},
		[255] = "DrawAndGuessExtension",
		[101] = {
			"PM_NotifyDrawAndGuessMatchOverTimeRes"
		},
		[102] = {
			"PM_NotifyDrawAndGuessMatchFailRes"
		},
		[103] = {
			"PM_NotifyDrawAndGuessGameStartRes"
		},
		[104] = {
			"PM_NotifyDrawAndGuessDrawStartRes"
		},
		[105] = {
			"PM_NotifyDrawAndGuessSyncDrawRes"
		},
		[106] = {
			"PM_NotifyDrawAndGuessAnswerResultRes"
		},
		[107] = {
			"PM_NotifyDrawAndGuessSelectQuestionStartRes"
		},
		[108] = {
			"PM_NotifyDrawAndGuessGameEndRes"
		},
		[109] = {
			"PM_NotifyDrawAndGuessChatRes"
		},
		[110] = {
			"PM_NotifyDrawAndGuessErrorRes"
		}
	},
	[711] = {
		{
			"PM_OriginXiuErInfoReq",
			"PM_OriginXiuErInfoRes",
			block = true
		},
		{
			"PM_OriginXiuErResetReq",
			"PM_OriginXiuErResetRes",
			block = true
		},
		{
			"PM_OriginXiuErChallengeReq",
			"PM_OriginXiuErChallengeRes",
			block = true
		},
		{
			"PM_OriginXiuErNotifyChallengeRes"
		},
		[255] = "OriginXiuErExtension"
	},
	[712] = {
		{
			"PM_OriginWelfareInfoReq",
			"PM_OriginWelfareInfoRes",
			block = true
		},
		{
			"PM_OriginWelfareLightUpReq",
			"PM_OriginWelfareLightUpRes",
			block = true
		},
		[255] = "OriginWelfareExtension"
	},
	[713] = {
		{
			"PM_OriginDragonNoahClgInfoReq",
			"PM_OriginDragonNoahClgInfoRes",
			block = true
		},
		{
			"PM_OriginDragonNoahClgResetReq",
			"PM_OriginDragonNoahClgResetRes",
			block = true
		},
		{
			"PM_OriginDragonNoahClgChallengeReq",
			"PM_OriginDragonNoahClgChallengeRes",
			block = true
		},
		{
			"PM_Notify_OriginDragonNoahClgChallengeRes"
		},
		[255] = "OriginDragonNoahClgExtension"
	},
	[714] = {
		{
			"PM_ArmorHeroInfoReq",
			"PM_ArmorHeroInfoRes",
			block = true
		},
		{
			"PM_ArmorHeroSummonReq",
			"PM_ArmorHeroSummonRes",
			block = true
		},
		{
			"PM_ArmorHeroGainTaskPrizeReq",
			"PM_ArmorHeroGainTaskPrizeRes",
			block = true
		},
		{
			"PM_ArmorHeroGainBookPrizeReq",
			"PM_ArmorHeroGainBookPrizeRes",
			block = true
		},
		{
			"PM_ArmorHeroGainSharePrizeReq",
			"PM_ArmorHeroGainSharePrizeRes",
			block = true
		},
		{
			"PM_ArmorHeroGainProgressPrizeReq",
			"PM_ArmorHeroGainProgressPrizeRes",
			block = true
		},
		{
			"PM_ArmorHeroChallengeReq",
			"PM_ArmorHeroChallengeRes",
			block = true
		},
		{
			"PM_ArmorHeroNotifyChallengeRes"
		},
		[255] = "ArmorHeroExtension"
	},
	[715] = {
		{
			"PM_FameHallVoteGetInfoReq",
			"PM_FameHallVoteGetInfoRes",
			block = true
		},
		{
			"PM_FameHallVoteReq",
			"PM_FameHallVoteRes",
			block = true
		},
		{
			"PM_FameHallVoteGainPrizeReq",
			"PM_FameHallVoteGainPrizeRes",
			block = true
		},
		[255] = "FameHallVoteExtension"
	},
	[716] = {
		{
			"PM_OriginPsychicJiInfoReq",
			"PM_OriginPsychicJiInfoRes",
			block = true
		},
		{
			"PM_OriginPsychicJiResetExtStageReq",
			"PM_OriginPsychicJiResetExtStageRes",
			block = true
		},
		{
			"PM_OriginPsyChicJiCommonClgReq",
			"PM_OriginPsyChicJiCommonClgRes",
			block = true
		},
		{
			"PM_OriginPsychicJiNotifyCommonClgRes"
		},
		{
			"PM_OriginPsyChicJiExtClgReq",
			"PM_OriginPsyChicJiExtClgRes",
			block = true
		},
		{
			"PM_OriginPsychicJiNotifyExtClgRes"
		},
		{
			"PM_OriginPsychicJiSaveReq",
			"PM_OriginPsychicJiSaveRes",
			block = true
		},
		[255] = "OriginPsychicJiExtension"
	},
	[717] = {
		{
			"PM_IdiomChainInfoReq",
			"PM_IdiomChainInfoRes",
			block = true
		},
		{
			"PM_IdiomChainGameStartReq",
			"PM_IdiomChainGameStartRes",
			block = true
		},
		{
			"PM_IdiomChainGameEndReq",
			"PM_IdiomChainGameEndRes",
			block = true
		},
		{
			"PM_IdiomChainGainPrizeReq",
			"PM_IdiomChainGainPrizeRes",
			block = true
		},
		[255] = "IdiomChainExtension"
	},
	[718] = {
		{
			"PM_BuddyLuckyBagGetInfoReq",
			"PM_BuddyLuckyBagGetInfoRes",
			block = true
		},
		{
			"PM_BuddyLuckyBagHelpOpenBagReq",
			"PM_BuddyLuckyBagHelpOpenBagRes",
			block = true
		},
		{
			"PM_BuddyLuckyBagGainCollectPrizeBagReq",
			"PM_BuddyLuckyBagGainCollectPrizeBagRes",
			block = true
		},
		{
			"PM_BuddyLuckyBagBuddyBagsReq",
			"PM_BuddyLuckyBagBuddyBagsRes",
			block = true
		},
		{
			"PM_BuddyLuckyBagGainLuckReq",
			"PM_BuddyLuckyBagGainLuckRes",
			block = true
		},
		{
			"PM_BuddyLuckyBagGainBagPrizeReq",
			"PM_BuddyLuckyBagGainBagPrizeRes",
			block = true
		},
		[255] = "BuddyLuckyBagExtension",
		[101] = {
			"PM_BuddyLuckyBagNotifyChangeRes"
		}
	},
	[719] = {
		{
			"PM_OriginGodDragonClgInfoReq",
			"PM_OriginGodDragonClgInfoRes",
			block = true
		},
		{
			"PM_OriginGodDragonClgChallengeReq",
			"PM_OriginGodDragonClgChallengeRes",
			block = true
		},
		{
			"PM_OriginGodDragonClgConfirmReq",
			"PM_OriginGodDragonClgConfirmRes",
			block = true
		},
		{
			"PM_OriginGodDragonEffectBuffReq",
			"PM_OriginGodDragonEffectBuffRes",
			block = true
		},
		{
			"PM_OriginGodDragonBacktrackReq",
			"PM_OriginGodDragonBacktrackRes",
			block = true
		},
		{
			"PM_OriginGodDragonResetReq",
			"PM_OriginGodDragonResetRes",
			block = true
		},
		[255] = "OriginGodDragonClgExtension",
		[10] = {
			"PM_NotifyOriginGodDragonChallengeFinishRes"
		}
	},
	[720] = {
		{
			"PM_StoryPrizeInfoReq",
			"PM_StoryPrizeInfoRes",
			block = true
		},
		{
			"PM_StoryPrizeGainPrizeReq",
			"PM_StoryPrizeGainPrizeRes",
			block = true
		},
		{
			"PM_StoryPrizeTotalInfoReq",
			"PM_StoryPrizeTotalInfoRes",
			block = true
		},
		[255] = "StoryPrizeExtension"
	},
	[721] = {
		{
			"PM_ElfKingPathInfoReq",
			"PM_ElfKingPathInfoRes",
			block = true
		},
		{
			"PM_ElfKingPahtClgReq",
			"PM_ElfKingPahtClgRes",
			block = true
		},
		{
			"PM_ElfKingPathNotifyClgRes"
		},
		[255] = "ElfKingPathExtension"
	},
	[722] = {
		{
			"PM_AnnualFubenInfoReq",
			"PM_AnnualFubenInfoRes",
			block = true
		},
		{
			"PM_AnnualFubenGainClueReq",
			"PM_AnnualFubenGainClueRes",
			block = true
		},
		{
			"PM_AnnualFubenFormulaReq",
			"PM_AnnualFubenFormulaRes",
			block = true
		},
		{
			"PM_AnnualFubenGainCluePrizeReq",
			"PM_AnnualFubenGainCluePrizeRes",
			block = true
		},
		{
			"PM_AnnualFubenStageChallengeReq",
			"PM_AnnualFubenStageChallengeRes",
			block = true
		},
		{
			"PM_AnnualFubenStageRankInfoReq",
			"PM_AnnualFubenStageRankInfoRes",
			block = true
		},
		{
			"PM_AnnualFubenStageResetReq",
			"PM_AnnualFubenStageResetRes",
			block = true
		},
		{
			"PM_AnnualFubenBossChallengeReq",
			"PM_AnnualFubenBossChallengeRes",
			block = true
		},
		{
			"PM_AnnualFubenGainBossPrizeReq",
			"PM_AnnualFubenGainBossPrizeRes",
			block = true
		},
		{
			"PM_AnnualFubenBossRankInfoReq",
			"PM_AnnualFubenBossRankInfoRes",
			block = true
		},
		{
			"PM_AnnualFubenSimpleStageChallengeReq",
			"PM_AnnualFubenSimpleStageChallengeRes",
			block = true
		},
		[255] = "AnnualFubenExtension",
		[21] = {
			"PM_NotifyAnnualFubenStageFinishRes"
		},
		[22] = {
			"PM_NotifyAnnualFubenBossFinishRes"
		},
		[23] = {
			"PM_NotifyAnnualFubenSimpleStageFinishRes"
		}
	},
	[723] = {
		{
			"PM_BindMobileGetInfoReq",
			"PM_BindMobileGetInfoRes",
			block = true
		},
		{
			"PM_BindMobileGetCaptchaReq",
			"PM_BindMobileGetCaptchaRes",
			block = true
		},
		{
			"PM_BindMobileBindReq",
			"PM_BindMobileBindRes",
			block = true
		},
		{
			"PM_BindMobileGainPrizeReq",
			"PM_BindMobileGainPrizeRes",
			block = true
		},
		[255] = "BindMobileExtension"
	},
	[724] = {
		{
			"PM_EmperorSubdueInfoReq",
			"PM_EmperorSubdueInfoRes",
			block = true
		},
		{
			"PM_EmperorSubdueStageClgReq",
			"PM_EmperorSubdueStageClgRes",
			block = true
		},
		{
			"PM_EmperorSubdueBossClgReq",
			"PM_EmperorSubdueBossClgRes",
			block = true
		},
		{
			"PM_EmperorSubdueResetReq",
			"PM_EmperorSubdueResetRes",
			block = true
		},
		{
			"PM_EmperorSubdueNotifyStageClgRes"
		},
		{
			"PM_EmperorSubdueNotifyBossClgRes"
		},
		{
			"PM_EmperorSubdueRankViewReq",
			"PM_EmperorSubdueRankViewRes",
			block = true
		},
		[255] = "EmperorSubdueExtension"
	},
	[725] = {
		{
			"PM_OriginKayaInfoReq",
			"PM_OriginKayaInfoRes",
			block = true
		},
		{
			"PM_OriginKayaClgReq",
			"PM_OriginKayaClgRes",
			block = true
		},
		[255] = "OriginKayaExtension",
		[4] = {
			"PM_OriginKayaResetReq",
			"PM_OriginKayaResetRes",
			block = true
		},
		[5] = {
			"PM_OriginKayaNotifyStageClgRes"
		}
	},
	[726] = {
		{
			"PM_OriginAresMomClgInfoReq",
			"PM_OriginAresMomClgInfoRes",
			block = true
		},
		{
			"PM_OriginAresMomClgExtremeChallengeReq",
			"PM_OriginAresMomClgExtremeChallengeRes",
			block = true
		},
		{
			"PM_OriginAresMomClgResetExtremeStageReq",
			"PM_OriginAresMomClgResetExtremeStageRes",
			block = true
		},
		{
			"PM_OriginAresMomClgNormalChallengeReq",
			"PM_OriginAresMomClgNormalChallengeRes",
			block = true
		},
		{
			"PM_OriginAresMomClgGainNormalPrizeReq",
			"PM_OriginAresMomClgGainNormalPrizeRes",
			block = true
		},
		[255] = "OriginAresMomClgExtension",
		[101] = {
			"PM_Notify_OriginAresMomClgExtremeChallengeRes"
		},
		[102] = {
			"PM_Notify_OriginAresMomClgNormalChallengeRes"
		}
	},
	[727] = {
		{
			"PM_OriginAruishiClgGetInfoReq",
			"PM_OriginAruishiClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginAruishiClgChallengeReq",
			"PM_OriginAruishiClgChallengeRes",
			block = true
		},
		[255] = "OriginAruishiClgExtension",
		[101] = {
			"PM_Notify_OriginAruishiClgChallengeResultRes"
		}
	},
	[728] = {
		{
			"PM_OriginEternalDragonClgGetInfoReq",
			"PM_OriginEternalDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginEternalDragonClgFightReq",
			"PM_OriginEternalDragonClgFightRes",
			block = true
		},
		{
			"PM_OriginEternalDragonClgUnlockComboReq",
			"PM_OriginEternalDragonClgUnlockComboRes",
			block = true
		},
		{
			"PM_OriginEternalDragonClgResetReq",
			"PM_OriginEternalDragonClgResetRes",
			block = true
		},
		[255] = "OriginEternalDragonClgExtension",
		[101] = {
			"PM_OriginEternalDragonClgFightNotifyRes"
		}
	},
	[729] = {
		{
			"PM_DragonManClgInfoReq",
			"PM_DragonManClgInfoRes",
			block = true
		},
		{
			"PM_DragonManClgChallengeReq",
			"PM_DragonManClgChallengeRes",
			block = true
		},
		[255] = "DragonManClgExtension",
		[101] = {
			"PM_Notify_DragonManClgChallengeRes"
		}
	},
	[730] = {
		{
			"PM_ArmorHeroLotteryInfoReq",
			"PM_ArmorHeroLotteryInfoRes",
			block = true
		},
		{
			"PM_ArmorHeroLotteryDrawReq",
			"PM_ArmorHeroLotteryDrawRes",
			block = true
		},
		{
			"PM_ArmorHeroLotteryGainPrizeReq",
			"PM_ArmorHeroLotteryGainPrizeRes",
			block = true
		},
		{
			"PM_ArmorHeroLotteryOneKeyGainPrizeReq",
			"PM_ArmorHeroLotteryOneKeyGainPrizeRes",
			block = true
		},
		[255] = "ArmorHeroLotteryExtension"
	},
	[731] = {
		{
			"PM_PinBallGetInfoReq",
			"PM_PinBallGetInfoRes",
			block = true
		},
		{
			"PM_PinBallStartGameReq",
			"PM_PinBallStartGameRes",
			block = true
		},
		{
			"PM_PinBallEndGameReq",
			"PM_PinBallEndGameRes",
			block = true
		},
		{
			"PM_PinBallGainPrizeReq",
			"PM_PinBallGainPrizeRes",
			block = true
		},
		{
			"PM_PinBallSweepReq",
			"PM_PinBallSweepRes",
			block = true
		},
		[255] = "PinBallExtension"
	},
	[732] = {
		{
			"PM_EndlessDarkClgGetInfoReq",
			"PM_EndlessDarkClgGetInfoRes",
			block = true
		},
		{
			"PM_EndlessDarkClgStartFightReq",
			"PM_EndlessDarkClgStartFightRes",
			block = true
		},
		{
			"PM_EndlessDarkClgContinueFightReq",
			"PM_EndlessDarkClgContinueFightRes",
			block = true
		},
		{
			"PM_EndlessDarkClgNotifyFightRes"
		},
		{
			"PM_EndlessDarkClgViewRankReq",
			"PM_EndlessDarkClgViewRankRes",
			block = true
		},
		{
			"PM_EndlessDarkClgUpgradeBuffReq",
			"PM_EndlessDarkClgUpgradeBuffRes",
			block = true
		},
		[255] = "EndlessDarkClgExtension"
	},
	[733] = {
		{
			"PM_PlantGodTreeGetInfoReq",
			"PM_PlantGodTreeGetInfoRes",
			block = true
		},
		{
			"PM_PlantGodTreePushStepReq",
			"PM_PlantGodTreePushStepRes",
			block = true
		},
		{
			"PM_PlantGodTreeDoEventReq",
			"PM_PlantGodTreeDoEventRes",
			block = true
		},
		{
			"PM_PlantGodTreeGainPrizeReq",
			"PM_PlantGodTreeGainPrizeRes",
			block = true
		},
		[255] = "PlantGodTreeExtension"
	},
	[734] = {
		{
			"PM_EternalCityInfoReq",
			"PM_EternalCityInfoRes",
			block = true
		},
		{
			"PM_EternalCityRecruitReq",
			"PM_EternalCityRecruitRes",
			block = true
		},
		{
			"PM_EternalCityRefreshPoolReq",
			"PM_EternalCityRefreshPoolRes",
			block = true
		},
		{
			"PM_EternalCityStageClgReq",
			"PM_EternalCityStageClgRes",
			block = true
		},
		{
			"PM_EternalCityBossClgReq",
			"PM_EternalCityBossClgRes",
			block = true
		},
		{
			"PM_EternalCityBuyBuildingReq",
			"PM_EternalCityBuyBuildingRes",
			block = true
		},
		{
			"PM_EternalCitySaleBuildingReq",
			"PM_EternalCitySaleBuildingRes",
			block = true
		},
		{
			"PM_EternalCityCraftBuildingReq",
			"PM_EternalCityCraftBuildingRes",
			block = true
		},
		{
			"PM_EternalCityPlaceBuildingReq",
			"PM_EternalCityPlaceBuildingRes",
			block = true
		},
		{
			"PM_EternalCityUnequipBuildingReq",
			"PM_EternalCityUnequipBuildingRes",
			block = true
		},
		{
			"PM_EternalCityMoveBuildingReq",
			"PM_EternalCityMoveBuildingRes",
			block = true
		},
		{
			"PM_EternalCityOperaPetReq",
			"PM_EternalCityOperaPetRes",
			block = true
		},
		{
			"PM_EternalCityGainProfitReq",
			"PM_EternalCityGainProfitRes",
			block = true
		},
		{
			"PM_EternalCityRankViewReq",
			"PM_EternalCityRankViewRes",
			block = true
		},
		{
			"PM_EternalCityOperaPoolReq",
			"PM_EternalCityOperaPoolRes",
			block = true
		},
		[255] = "EternalCityExtension",
		[101] = {
			"PM_EternalCityNotifyStageClgRes"
		},
		[102] = {
			"PM_EternalCityNotifyBossClgRes"
		},
		[103] = {
			"PM_EternalCityNotifyProsperityChangeRes"
		}
	},
	[735] = {
		{
			"PM_BeastRichManInfoReq",
			"PM_BeastRichManInfoRes",
			block = true
		},
		{
			"PM_BeastRichManGainDailyPrizeReq",
			"PM_BeastRichManGainDailyPrizeRes",
			block = true
		},
		{
			"PM_BeastRichManMoveReq",
			"PM_BeastRichManMoveRes",
			block = true
		},
		{
			"PM_BeastRichManHandleGridReq",
			"PM_BeastRichManHandleGridRes",
			block = true
		},
		{
			"PM_BeastRichManHandleEventReq",
			"PM_BeastRichManHandleEventRes",
			block = true
		},
		{
			"PM_BeastRichManUseCardReq",
			"PM_BeastRichManUseCardRes",
			block = true
		},
		{
			"PM_BeastRichManFightBeastReq",
			"PM_BeastRichManFightBeastRes",
			block = true
		},
		{
			"PM_BeastRichManGainHangingReq",
			"PM_BeastRichManGainHangingRes",
			block = true
		},
		{
			"PM_BeastRichManTotalRankInfoReq",
			"PM_BeastRichManTotalRankInfoRes",
			block = true
		},
		{
			"PM_BeastRichManSubRankInfoReq",
			"PM_BeastRichManSubRankInfoRes",
			block = true
		},
		{
			"PM_BeastRichManScoreRankInfoReq",
			"PM_BeastRichManScoreRankInfoRes",
			block = true
		},
		{
			"PM_BeastRichManBeastPrizeInfoReq",
			"PM_BeastRichManBeastPrizeInfoRes",
			block = true
		},
		{
			"PM_BeastRichManBeastGainPrizeReq",
			"PM_BeastRichManBeastGainPrizeRes",
			block = true
		},
		[255] = "BeastRichManExtension",
		[21] = {
			"PM_NotifyBeastRichManFightBeastFinishRes"
		},
		[22] = {
			"PM_BeastRichManScoreChangeRes"
		}
	},
	[736] = {
		{
			"PM_OriginKingMoYanClgGetInfoReq",
			"PM_OriginKingMoYanClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginKingMoYanClgSetItemReq",
			"PM_OriginKingMoYanClgSetItemRes",
			block = true
		},
		{
			"PM_OriginKingMoYanClgFightReq",
			"PM_OriginKingMoYanClgFightRes",
			block = true
		},
		{
			"PM_OriginKingMoYanClgResetReq",
			"PM_OriginKingMoYanClgResetRes",
			block = true
		},
		{
			"PM_OriginKingMoYanClgResetPointReq",
			"PM_OriginKingMoYanClgResetPointRes",
			block = true
		},
		[255] = "OriginKingMoYanClgExtension",
		[101] = {
			"PM_OriginKingMoYanClgFightNotifyRes"
		}
	},
	[737] = {
		{
			"PM_OriginFireDimensionInfoReq",
			"PM_OriginFireDimensionInfoRes",
			block = true
		},
		{
			"PM_OriginFireDimensionClgReq",
			"PM_OriginFireDimensionClgRes",
			block = true
		},
		{
			"PM_OriginFireDimensionResetReq",
			"PM_OriginFireDimensionResetRes",
			block = true
		},
		{
			"PM_OriginFireDimensionNotifyClgRes"
		},
		[255] = "OriginFireDimensionExtension"
	},
	[738] = {
		{
			"PM_OriginWeiLeiTaGetInfoReq",
			"PM_OriginWeiLeiTaGetInfoRes",
			block = true
		},
		{
			"PM_OriginWeiLeiTaExtremeChallengeReq",
			"PM_OriginWeiLeiTaExtremeChallengeRes",
			block = true
		},
		{
			"PM_OriginWeiLeiTaResetExtremeStageReq",
			"PM_OriginWeiLeiTaResetExtremeStageRes",
			block = true
		},
		{
			"PM_OriginWeiLeiTaNormalChallengeReq",
			"PM_OriginWeiLeiTaNormalChallengeRes",
			block = true
		},
		{
			"PM_OriginWeiLeiTaGainProgressPrizeReq",
			"PM_OriginWeiLeiTaGainProgressPrizeRes",
			block = true
		},
		[255] = "OriginWeiLeiTaExtension",
		[100] = {
			"PM_Notify_OriginWeiLeiTaExtremeChallengeEndRes",
			block = true
		},
		[101] = {
			"PM_Notify_OriginWeiLeiTaNormalChallengeEndRes",
			block = true
		}
	},
	[739] = {
		{
			"PM_DumplingFeastInfoReq",
			"PM_DumplingFeastInfoRes",
			block = true
		},
		{
			"PM_DumplingFeastRollDoughReq",
			"PM_DumplingFeastRollDoughRes",
			block = true
		},
		{
			"PM_DumplingFeastStuffFillingReq",
			"PM_DumplingFeastStuffFillingRes",
			block = true
		},
		{
			"PM_DumplingFeastBoilDumplingReq",
			"PM_DumplingFeastBoilDumplingRes",
			block = true
		},
		{
			"PM_DumplingFeastTakeOutDumplingReq",
			"PM_DumplingFeastTakeOutDumplingRes",
			block = true
		},
		{
			"PM_DumplingFeastGainDumplingReq",
			"PM_DumplingFeastGainDumplingRes",
			block = true
		},
		{
			"PM_DumplingFeastFeedReq",
			"PM_DumplingFeastFeedRes",
			block = true
		},
		{
			"PM_DumplingFeastGainDamageProgressReq",
			"PM_DumplingFeastGainDamageProgressRes",
			block = true
		},
		{
			"PM_DumplingFeastGainIntimacyProgressReq",
			"PM_DumplingFeastGainIntimacyProgressRes",
			block = true
		},
		{
			"PM_DumplingFeastBossClgReq",
			"PM_DumplingFeastBossClgRes",
			block = true
		},
		{
			"PM_DumplingFeastRankViewReq",
			"PM_DumplingFeastRankViewRes",
			block = true
		},
		{
			"PM_DumplingFeastOneClickMakeDumplingReq",
			"PM_DumplingFeastOneClickMakeDumplingRes",
			block = true
		},
		[255] = "DumplingFeastExtension",
		[101] = {
			"PM_DumplingFeastNotifyBossClgRes"
		}
	},
	[740] = {
		{
			"PM_OriginLongYanClgGetInfoReq",
			"PM_OriginLongYanClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginLongYanClgChallengeReq",
			"PM_OriginLongYanClgChallengeRes",
			block = true
		},
		[255] = "OriginLongYanClgExtension",
		[100] = {
			"PM_Notify_OriginLongYanClgChallengeEndRes",
			block = true
		}
	},
	[741] = {
		{
			"PM_OriginAshlessDragonGetInfoReq",
			"PM_OriginAshlessDragonGetInfoRes",
			block = true
		},
		{
			"PM_OriginAshlessDragonChallengeReq",
			"PM_OriginAshlessDragonChallengeRes",
			block = true
		},
		{
			"PM_OriginAshlessDragonConfirmReq",
			"PM_OriginAshlessDragonConfirmRes",
			block = true
		},
		{
			"PM_OriginAshlessDragonResetReq",
			"PM_OriginAshlessDragonResetRes",
			block = true
		},
		[255] = "OriginAshlessDragonExtension",
		[100] = {
			"PM_Notify_OriginAshlessDragonChallengeEndRes",
			block = true
		}
	},
	[742] = {
		{
			"PM_PinDaoDaoGetInfoReq",
			"PM_PinDaoDaoGetInfoRes",
			block = true
		},
		{
			"PM_PinDaoDaoHelpReduceReq",
			"PM_PinDaoDaoHelpReduceRes",
			block = true
		},
		{
			"PM_PinDaoDaoBuyGoodsReq",
			"PM_PinDaoDaoBuyGoodsRes",
			block = true
		},
		{
			"PM_PinDaoDaoPlayerInfoReq",
			"PM_PinDaoDaoPlayerInfoRes",
			block = true
		},
		{
			"PM_PinDaoDaoChatReq",
			"PM_PinDaoDaoChatRes",
			block = true
		},
		[255] = "PinDaoDaoExtension",
		[101] = {
			"PM_PinDaoDaoNotifyReduceRes"
		}
	},
	[743] = {
		{
			"PM_LanternFestivalGetInfoReq",
			"PM_LanternFestivalGetInfoRes",
			block = true
		},
		{
			"PM_LanternFestivalAnswerChannelQuestionPeq",
			"PM_LanternFestivalAnswerChannelQuestionPes",
			block = true
		},
		{
			"PM_LanternFestivalfinishPersionQuestionPeq",
			"PM_LanternFestivalfinishPersionQuestionPes",
			block = true
		},
		{
			"PM_LanternFestivalGainExtPrizeReq",
			"PM_LanternFestivalGainExtPrizeRes",
			block = true
		},
		{
			"PM_LanternFestivalExchangeCollectPrizeReq",
			"PM_LanternFestivalExchangeCollectPrizeRes",
			block = true
		},
		[255] = "LanternFestivalExtension"
	},
	[744] = {
		{
			"PM_PeakTowerInfoReq",
			"PM_PeakTowerInfoRes",
			block = true
		},
		{
			"PM_PeakTowerResetFloorReq",
			"PM_PeakTowerResetFloorRes",
			block = true
		},
		{
			"PM_PeakTowerBasicClgReq",
			"PM_PeakTowerBasicClgRes",
			block = true
		},
		{
			"PM_PeakTowerLegendClgReq",
			"PM_PeakTowerLegendClgRes",
			block = true
		},
		{
			"PM_PeakTowerVerifyRaceReq",
			"PM_PeakTowerVerifyRaceRes",
			block = true
		},
		{
			"PM_PeakTowerGainProgressPrizeReq",
			"PM_PeakTowerGainProgressPrizeRes",
			block = true
		},
		{
			"PM_PeakTowerLegendRankViewReq",
			"PM_PeakTowerLegendRankViewRes",
			block = true
		},
		{
			"PM_PeakTowerBasicRankViewReq",
			"PM_PeakTowerBasicRankViewRes",
			block = true
		},
		[255] = "PeakTowerExtension",
		[101] = {
			"PM_PeakTowerNotifyBasicClgRes"
		},
		[102] = {
			"PM_PeakTowerNotifyLegendClgRes"
		}
	},
	[745] = {
		{
			"PM_GodDailyRankGodRankViewReq",
			"PM_GodDailyRankGodRankViewRes",
			block = true
		},
		{
			"PM_GodDailyRankDailyRankViewReq",
			"PM_GodDailyRankDailyRankViewRes",
			block = true
		},
		[255] = "GodDailyRankExtension"
	},
	[746] = {
		{
			"PM_OriginOrderDragonClgGetInfoReq",
			"PM_OriginOrderDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginOrderDragonClgFightReq",
			"PM_OriginOrderDragonClgFightRes",
			block = true
		},
		{
			"PM_OriginOrderDragonClgResetReq",
			"PM_OriginOrderDragonClgResetRes",
			block = true
		},
		{
			"PM_OriginOrderDragonClgConfirmReq",
			"PM_OriginOrderDragonClgConfirmRes",
			block = true
		},
		[255] = "OriginOrderDragonClgExtension",
		[101] = {
			"PM_OriginOrderDragonClgNotifyFightRes"
		}
	},
	[747] = {
		{
			"PM_OriginKingOrderClgGetInfoReq",
			"PM_OriginKingOrderClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginKingOrderClgFightReq",
			"PM_OriginKingOrderClgFightRes",
			block = true
		},
		{
			"PM_OriginKingOrderClgResetReq",
			"PM_OriginKingOrderClgResetRes",
			block = true
		},
		{
			"PM_OriginKingOrderClgConfirmReq",
			"PM_OriginKingOrderClgConfirmRes",
			block = true
		},
		[255] = "OriginKingOrderClgExtension",
		[101] = {
			"PM_Notify_OriginKingOrderClgFightRes"
		}
	},
	[748] = {
		{
			"PM_OriginXingjiangInfoReq",
			"PM_OriginXingjiangInfoRes",
			block = true
		},
		{
			"PM_OriginXingjiangClgReq",
			"PM_OriginXingjiangClgRes",
			block = true
		},
		{
			"PM_OriginXingjiangResetReq",
			"PM_OriginXingjiangResetRes",
			block = true
		},
		{
			"PM_OriginXingjiangNotifyClgRes"
		},
		[255] = "OriginXingjiangExtension"
	},
	[749] = {
		{
			"PM_MahjongBattleInfoReq",
			"PM_MahjongBattleInfoRes",
			block = true
		},
		{
			"PM_MahjongBattleDrawGenreReq",
			"PM_MahjongBattleDrawGenreRes",
			block = true
		},
		{
			"PM_MahjongBattleSelectGenreReq",
			"PM_MahjongBattleSelectGenreRes",
			block = true
		},
		{
			"PM_MahjongBattleMatchFightReq",
			"PM_MahjongBattleMatchFightRes",
			block = true
		},
		{
			"PM_MahjongBattleCancelMatchReq",
			"PM_MahjongBattleCancelMatchRes",
			block = true
		},
		{
			"PM_MahjongBattleFightReq",
			"PM_MahjongBattleFightRes",
			block = true
		},
		{
			"PM_MahjongDrawMahjongReq",
			"PM_MahjongDrawMahjongRes",
			block = true
		},
		{
			"PM_MahjongBattleselectMahjongReq",
			"PM_MahjongBattleselectMahjongRes",
			block = true
		},
		{
			"PM_MahjongBattleDropMahjongReq",
			"PM_MahjongBattleDropMahjongRes",
			block = true
		},
		{
			"PM_MahjongBattleSummonReq",
			"PM_MahjongBattleSummonRes",
			block = true
		},
		{
			"PM_MahjongBattleSelectSummonPetReq",
			"PM_MahjongBattleSelectSummonPetRes",
			block = true
		},
		{
			"PM_MahjongBattleSelectSummonBuffReq",
			"PM_MahjongBattleSelectSummonBuffRes",
			block = true
		},
		{
			"PM_MahjongBattleDropPetReq",
			"PM_MahjongBattleDropPetRes",
			block = true
		},
		{
			"PM_MahjongBattleGiveUpReq",
			"PM_MahjongBattleGiveUpRes",
			block = true
		},
		{
			"PM_MahjongBattleViewBtlReportReq",
			"PM_MahjongBattleViewBtlReportRes",
			block = true
		},
		{
			"PM_MahjongBattleRankViewReq",
			"PM_MahjongBattleRankViewRes",
			block = true
		},
		{
			"PM_MahjongBattleRandomCarkLuckReq",
			"PM_MahjongBattleRandomCarkLuckRes",
			block = true
		},
		{
			"PM_MahjongBattleTeachFightReq",
			"PM_MahjongBattleTeachFightRes",
			block = true
		},
		{
			"PM_MahjongBattleShareBattleResultReq",
			"PM_MahjongBattleShareBattleResultRes",
			block = true
		},
		[255] = "MahjongBattleExtension",
		[101] = {
			"PM_MahjongBattleNotifyFightRes"
		},
		[102] = {
			"PM_MahjongBattleNotifyDrawMahjongRes"
		},
		[103] = {
			"PM_MahjongBattleNotifyTeachFightRes"
		}
	},
	[750] = {
		{
			"PM_YunJieDragonClgGetInfoReq",
			"PM_YunJieDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_YunJieDragonClgChallengeReq",
			"PM_YunJieDragonClgChallengeRes",
			block = true
		},
		{
			"PM_YunJieDragonClgOneKeyPassReq",
			"PM_YunJieDragonClgOneKeyPassRes",
			block = true
		},
		[255] = "YunJieDragonClgExtension",
		[100] = {
			"PM_Notify_YunJieDragonClgChallengeEndRes",
			block = true
		}
	},
	[751] = {
		{
			"PM_OriginDragonAryaClgGetInfoReq",
			"PM_OriginDragonAryaClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginDragonAryaClgChallengeReq",
			"PM_OriginDragonAryaClgChallengeRes",
			block = true
		},
		{
			"PM_OriginDragonAryaClgResetReq",
			"PM_OriginDragonAryaClgResetRes",
			block = true
		},
		{
			"PM_OriginDragonAryaClgViewAnnuityGodRankReq",
			"PM_OriginDragonAryaClgViewAnnuityGodRankRes",
			block = true
		},
		[255] = "OriginDragonAryaClgExtension",
		[101] = {
			"PM_Notify_OriginDragonAryaClgChallengeResultRes"
		}
	},
	[752] = {
		{
			"PM_GoddessTrialGetInfoReq",
			"PM_GoddessTrialGetInfoRes",
			block = true
		},
		{
			"PM_GoddessTrialFightReq",
			"PM_GoddessTrialFightRes",
			block = true
		},
		{
			"PM_GoddessTrialGainPrizeReq",
			"PM_GoddessTrialGainPrizeRes",
			block = true
		},
		{
			"PM_GoddessTrialRankViewReq",
			"PM_GoddessTrialRankViewRes",
			block = true
		},
		[255] = "GoddessTrialClgExtension",
		[101] = {
			"PM_GoddessTrialNormalFightRes"
		},
		[102] = {
			"PM_GoddessTrialSuperFightRes"
		},
		[103] = {
			"PM_GoddessTrialBossFightRes"
		}
	},
	[753] = {
		{
			"PM_OriginDiShiTianClgGetInfoReq",
			"PM_OriginDiShiTianClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginDiShiTianClgFightReq",
			"PM_OriginDiShiTianClgFightRes",
			block = true
		},
		{
			"PM_OriginDiShiTianClgResetReq",
			"PM_OriginDiShiTianClgResetRes",
			block = true
		},
		{
			"PM_OriginDiShiTianClgConfirmReq",
			"PM_OriginDiShiTianClgConfirmRes",
			block = true
		},
		[255] = "OriginDiShiTianClgExtension",
		[101] = {
			"PM_NotifyOriginDiShiTianClgFightRes"
		}
	},
	[754] = {
		{
			"PM_OriginPowersExtremeInfoReq",
			"PM_OriginPowersExtremeInfoRes",
			block = true
		},
		{
			"PM_OriginPowersExtremeChallengeReq",
			"PM_OriginPowersExtremeChallengeRes",
			block = true
		},
		{
			"PM_NotifyOriginPowersExtremeClgFinishRes"
		},
		{
			"PM_OriginPowersExtremeResetReq",
			"PM_OriginPowersExtremeResetRes",
			block = true
		},
		{
			"PM_OriginPowersCommonInfoReq",
			"PM_OriginPowersCommonInfoRes",
			block = true
		},
		{
			"PM_OriginPowersCommonFightReq",
			"PM_OriginPowersCommonFightRes",
			block = true
		},
		{
			"PM_NotifyPM_OriginPowersCommonClgFinishRes"
		},
		{
			"PM_OriginPowersCommonGainPrizeReq",
			"PM_OriginPowersCommonGainPrizeRes",
			block = true
		},
		[255] = "OriginPowersClgExtension"
	},
	[755] = {
		{
			"PM_OriginJiuClgInfoReq",
			"PM_OriginJiuClgInfoRes",
			block = true
		},
		{
			"PM_OriginJiuClgChallengeReq",
			"PM_OriginJiuClgChallengeRes",
			block = true
		},
		{
			"PM_NotifyOriginJiuClgChallengeFinishRes"
		},
		{
			"PM_OriginJiuClgBossChallengeReq",
			"PM_OriginJiuClgBossChallengeRes",
			block = true
		},
		{
			"PM_NotifyOriginJiuClgBossFinishRes"
		},
		{
			"PM_OriginJiuClgPhaseResetReq",
			"PM_OriginJiuClgPhaseResetRes",
			block = true
		},
		{
			"PM_OriginJiuClgResetReq",
			"PM_OriginJiuClgResetRes",
			block = true
		},
		[255] = "OriginJiuClgExtension"
	},
	[756] = {
		{
			"PM_BoccaccioClgGetInfoReq",
			"PM_BoccaccioClgGetInfoRes",
			block = true
		},
		{
			"PM_BoccaccioClgFightReq",
			"PM_BoccaccioClgFightRes",
			block = true
		},
		[255] = "BoccaccioClgExtension",
		[101] = {
			"PM_BoccaccioClgNotifyFightRes"
		}
	},
	[757] = {
		{
			"PM_SwordStormGetInfoReq",
			"PM_SwordStormGetInfoRes",
			block = true
		},
		{
			"PM_SwordStormChallengeReq",
			"PM_SwordStormChallengeRes",
			block = true
		},
		[255] = "SwordStormExtension",
		[101] = {
			"PM_Notify_SwordStormChallengeResultRes"
		}
	},
	[758] = {
		{
			"PM_BoccaccioChapterInfoReq",
			"PM_BoccaccioChapterInfoRes",
			block = true
		},
		{
			"PM_BoccaccioChapter1ClgReq",
			"PM_BoccaccioChapterClgRes",
			block = true
		},
		{
			"PM_BoccaccioChapter2ClgReq",
			"PM_BoccaccioChapterClgRes",
			block = true
		},
		{
			"PM_BoccaccioChapter3ClgReq",
			"PM_BoccaccioChapterClgRes",
			block = true
		},
		{
			"PM_BoccaccioChapter4ClgReq",
			"PM_BoccaccioChapterClgRes",
			block = true
		},
		{
			"PM_BoccaccioChapterOneClickGainProgressPrizeReq",
			"PM_BoccaccioChapterOneClickGainProgressPrizeRes",
			block = true
		},
		{
			"PM_BoccaccioChapter2RecoverySequenceReq",
			"PM_BoccaccioChapter2RecoverySequenceRes",
			block = true
		},
		{
			"PM_BoccaccioChapter2FindErrorWordReq",
			"PM_BoccaccioChapter2FindErrorWordRes",
			block = true
		},
		{
			"PM_BoccaccioChapter2ReplaceWordReq",
			"PM_BoccaccioChapter2ReplaceWordRes",
			block = true
		},
		{
			"PM_BoccaccioChapter3SignUpReq",
			"PM_BoccaccioChapter3SignUpRes",
			block = true
		},
		{
			"PM_BoccaccioChapter3SaveClgReq",
			"PM_BoccaccioChapter3SaveClgRes",
			block = true
		},
		{
			"PM_BoccaccioChapter4RankViewReq",
			"PM_BoccaccioChapter4RankViewRes",
			block = true
		},
		[255] = "BoccaccioChapterExtension",
		[100] = {
			"PM_BoccaccioChapterFirstClickReq",
			"PM_BoccaccioChapterFirstClickRes",
			block = true
		},
		[101] = {
			"PM_BoccaccioChapter1NotifyClgRes"
		},
		[102] = {
			"PM_BoccaccioChapter2NotifyClgRes"
		},
		[103] = {
			"PM_BoccaccioChapter3NotifyClgRes"
		},
		[104] = {
			"PM_BoccaccioChapter4NotifyClgRes"
		},
		[105] = {
			"PM_BoccaccioChapterUnlockPlotReq",
			"PM_BoccaccioChapterUnlockPlotRes"
		}
	},
	[759] = {
		{
			"PM_UpholdJusticeGetInfoReq",
			"PM_UpholdJusticeGetInfoRes",
			block = true
		},
		{
			"PM_UpholdJusticeDonateOrGainReq",
			"PM_UpholdJusticeDonateOrGainRes",
			block = true
		},
		{
			"PM_UpholdJusticeRankViewReq",
			"PM_UpholdJusticeRankViewRes",
			block = true
		},
		[255] = "UpholdJusticeExtension"
	},
	[760] = {
		{
			"PM_WandererPassGetInfoReq",
			"PM_WandererPassGetInfoRes",
			block = true
		},
		[255] = "WandererPassExtension",
		[101] = {
			"PM_Notify_WandererPassPaySucResult",
			block = true
		}
	},
	[761] = {
		{
			"PM_MCGetInfoReq",
			"PM_MCGetInfoRes",
			block = true
		},
		{
			"PM_MCNotifyStepChangeRes"
		},
		{
			"PM_MCGetBattleVideoReq",
			"PM_MCGetBattleVideoRes",
			block = true
		},
		{
			"PM_MCGetDefenseForamtionReq",
			"PM_MCGetDefenseForamtionRes",
			block = true
		},
		{
			"PM_MCSetDefenseForamtionReq",
			"PM_MCSetDefenseForamtionRes",
			block = true
		},
		{
			"PM_MCFinalsGetFormationReq",
			"PM_MCFinalsGetFormationRes",
			block = true
		},
		{
			"PM_MCFinalsSetFormationReq",
			"PM_MCFinalsSetFormationRes",
			block = true
		},
		{
			"PM_MCGetDisplayInfoReq",
			"PM_MCGetDisplayInfoRes",
			block = true
		},
		{
			"PM_MCGetFunForamtionReq",
			"PM_MCGetFunForamtionRes",
			block = true
		},
		{
			"PM_MCSetFunForamtionReq",
			"PM_MCSetFunForamtionRes",
			block = true
		},
		{
			"PM_MCGetQualifierInfoReq",
			"PM_MCGetQualifierInfoRes",
			block = true
		},
		[255] = "MartialContestExtension",
		[14] = {
			"PM_MCQualifierGetNewOpponentReq",
			"PM_MCQualifierGetNewOpponentRes",
			block = true
		},
		[15] = {
			"PM_MCQualifierFightReq",
			"PM_MCQualifierFightRes",
			block = true
		},
		[16] = {
			"PM_MCQualifierRecordsReq",
			"PM_MCQualifierRecordsRes",
			block = true
		},
		[17] = {
			"PM_MCQualifierRankInfoReq",
			"PM_MCQualifierRankInfoRes",
			block = true
		},
		[18] = {
			"PM_MCQualifierPetRaceRankReq",
			"PM_MCQualifierPetRaceRankRes",
			block = true
		},
		[21] = {
			"PM_MCFinalsInfoReq",
			"PM_MCFinalsInfoRes",
			block = true
		},
		[22] = {
			"PM_MCNotifyFinalsResultRes"
		},
		[23] = {
			"PM_MCFinalsResultReq",
			"PM_MCFinalsResultRes",
			block = true
		},
		[31] = {
			"PM_MCGetFinalsEquipInfoReq",
			"PM_MCGetFinalsEquipInfoRes",
			block = true
		},
		[32] = {
			"PM_MCUpgradeFinalsEquipReq",
			"PM_MCUpgradeFinalsEquipRes",
			block = true
		}
	},
	[762] = {
		{
			"PM_UniqueWorldGetInfoReq",
			"PM_UniqueWorldGetInfoRes",
			block = true
		},
		{
			"PM_UniqueWorldNewGameReq",
			"PM_UniqueWorldNewGameRes",
			block = true
		},
		{
			"PM_UniqueWorldMoveReq",
			"PM_UniqueWorldMoveRes",
			block = true
		},
		{
			"PM_UniqueWorldDoEventReq",
			"PM_UniqueWorldDoEventRes",
			block = true
		},
		{
			"PM_UniqueWorldFightReq",
			"PM_UniqueWorldFightRes",
			block = true
		},
		{
			"PM_UniqueWorldUseItemReq",
			"PM_UniqueWorldUseItemRes",
			block = true
		},
		{
			"PM_UniqueWorldGiveUpReq",
			"PM_UniqueWorldGiveUpRes",
			block = true
		},
		[255] = "UniqueWorldExtension",
		[101] = {
			"PM_UniqueWorldMapChangeRes"
		}
	},
	[763] = {
		{
			"PM_PosterStickerGainActivityGetInfoReq",
			"PM_PosterStickerGainActivityGetInfoRes",
			block = true
		},
		{
			"PM_PosterStickerGainActivityReq",
			"PM_PosterStickerGainActivityRes",
			block = true
		},
		[255] = "PosterStickersGainActivityExtension"
	},
	[765] = {
		{
			"PM_FiveYearRecapGetInfoReq",
			"PM_FiveYearRecapGetInfoRes",
			block = true
		},
		{
			"PM_FiveYearRecapGainLoginPrizeReq",
			"PM_FiveYearRecapGainLoginPrizeRes",
			block = true
		},
		{
			"PM_FiveYearRecapUnlockReq",
			"PM_FiveYearRecapUnlockRes",
			block = true
		},
		[255] = "FiveYearRecapExtension",
		[5] = {
			"PM_FiveYearRecapShareReq",
			"PM_FiveYearRecapShareRes",
			block = true
		}
	},
	[766] = {
		{
			"PM_OriginZhengliInfoReq",
			"PM_OriginZhengliInfoRes",
			block = true
		},
		{
			"PM_OriginZhengliClgReq",
			"PM_OriginZhengliClgRes",
			block = true
		},
		{
			"PM_OriginZhengliResetReq",
			"PM_OriginZhengliResetRes",
			block = true
		},
		{
			"PM_OriginZhengliSelectRouteReq",
			"PM_OriginZhengliSelectRouteRes",
			block = true
		},
		{
			"PM_OriginZhengliSaveClgReq",
			"PM_OriginZhengliSaveClgRes",
			block = true
		},
		{
			"PM_OriginZhengliNotifyClgRes"
		},
		[255] = "OriginZhengliExtension"
	},
	[767] = {
		{
			"PM_AngelInvestorGetInfoReq",
			"PM_AngelInvestorGetInfoRes",
			block = true
		},
		{
			"PM_AngelInvestorSignContractReq",
			"PM_AngelInvestorSignContractRes",
			block = true
		},
		{
			"PM_AngelInvestorUpgradeAngelReq",
			"PM_AngelInvestorUpgradeAngelRes",
			block = true
		},
		{
			"PM_AngelInvestorStartHangReq",
			"PM_AngelInvestorStartHangRes",
			block = true
		},
		{
			"PM_AngelInvestorGainHangRewardReq",
			"PM_AngelInvestorGainHangRewardRes",
			block = true
		},
		{
			"PM_AngelInvestorChallengeReq",
			"PM_AngelInvestorChallengeRes",
			block = true
		},
		[255] = "AngelInvestorExtension",
		[101] = {
			"PM_Notify_AngelInvestorChallengeResultRes"
		}
	},
	[768] = {
		{
			"PM_OriginAnInfoReq",
			"PM_OriginAnInfoRes",
			block = true
		},
		{
			"PM_OriginAnExtremeClgReq",
			"PM_OriginAnExtremeClgRes",
			block = true
		},
		{
			"PM_OriginAnNormalClgReq",
			"PM_OriginAnNormalClgRes",
			block = true
		},
		{
			"PM_OriginAnResetExtremeReq",
			"PM_OriginAnResetExtremeRes",
			block = true
		},
		{
			"PM_OriginAnGainNormalProgressReq",
			"PM_OriginAnGainNormalProgressRes",
			block = true
		},
		{
			"PM_OriginAnNotifyExtremeClgRes"
		},
		{
			"PM_OriginAnNotifyNormalClgRes"
		},
		[255] = "OriginAnExtension"
	},
	[769] = {
		{
			"PM_HexLineupGetInfoReq",
			"PM_HexLineupGetInfoRes",
			block = true
		},
		{
			"PM_HexLineupStartGameReq",
			"PM_HexLineupStartGameRes",
			block = true
		},
		{
			"PM_HexLineupEndGameReq",
			"PM_HexLineupEndGameRes",
			block = true
		},
		{
			"PM_HexLineupGainPrizeReq",
			"PM_HexLineupGainPrizeRes",
			block = true
		},
		{
			"PM_HexLineupSweepReq",
			"PM_HexLineupSweepRes",
			block = true
		},
		{
			"PM_HexLineupRankViewReq",
			"PM_HexLineupRankViewRes",
			block = true
		},
		[255] = "HexLineupExtension"
	},
	[770] = {
		{
			"PM_OriginTSDragonClgInfoReq",
			"PM_OriginTSDragonClgInfoRes",
			block = true
		},
		{
			"PM_OriginTSDragonChallengeReq",
			"PM_OriginTSDragonChallengeRes",
			block = true
		},
		{
			"PM_OriginTSDragonConfirmReq",
			"PM_OriginTSDragonConfirmRes",
			block = true
		},
		{
			"PM_OriginTSDragonResetReq",
			"PM_OriginTSDragonResetRes",
			block = true
		},
		[255] = "OriginTSDragonClgExtension",
		[10] = {
			"PM_NotifyTSDragonChallengeFinishRes"
		}
	},
	[771] = {
		{
			"PM_SkyPeakGetInfoReq",
			"PM_SkyPeakGetInfoRes",
			block = true
		},
		{
			"PM_SkyPeakGetStageInfoReq",
			"PM_SkyPeakGetStageInfoRes",
			block = true
		},
		{
			"PM_SkyPeakChallengeStageReq",
			"PM_SkyPeakChallengeStageRes",
			block = true
		},
		{
			"PM_SkyPeakChallengeBossReq",
			"PM_SkyPeakChallengeBossRes",
			block = true
		},
		{
			"PM_SkyPeakSweepReq",
			"PM_SkyPeakSweepRes",
			block = true
		},
		{
			"PM_SkyPeakUnlockBuffNodeReq",
			"PM_SkyPeakUnlockBuffNodeRes",
			block = true
		},
		{
			"PM_SkyPeakResetBuffReq",
			"PM_SkyPeakResetBuffRes",
			block = true
		},
		{
			"PM_SkyPeakGetRankInfoReq",
			"PM_SkyPeakGetRankInfoRes",
			block = true
		},
		[255] = "SkyPeakExtension",
		[101] = {
			"PM_Notify_SkyPeakStageChallengeResultRes"
		},
		[102] = {
			"PM_Notify_SkyPeakBossChallengeResultRes"
		}
	},
	[772] = {
		{
			"PM_BreachFormMasterGetInfoReq",
			"PM_BreachFormMasterGetInfoRes",
			block = true
		},
		{
			"PM_BreachFormMasterStageInfoReq",
			"PM_BreachFormMasterStageInfoRes",
			block = true
		},
		{
			"PM_BreachFormMasterFightReq",
			"PM_BreachFormMasterFightRes",
			block = true
		},
		{
			"PM_BreachFormMasterSetDefenseFormReq",
			"PM_BreachFormMasterSetDefenseFormRes",
			block = true
		},
		{
			"PM_BreachFormMasterRankViewReq",
			"PM_BreachFormMasterRankViewRes",
			block = true
		},
		{
			"PM_BreachFormMasterBattleReportReq",
			"PM_BreachFormMasterBattleReportRes",
			block = true
		},
		{
			"PM_BreachFormMasterBattleVideoReq",
			"PM_BreachFormMasterBattleVideoRes",
			block = true
		},
		[255] = "BreachFormMasterExtension",
		[101] = {
			"PM_BreachFormMasterFightNotifyRes"
		}
	},
	[773] = {
		{
			"PM_OriginDarkMMClgGetInfoReq",
			"PM_OriginDarkMMClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginDarkMMClgChallengeReq",
			"PM_OriginDarkMMClgChallengeRes",
			block = true
		},
		{
			"PM_OriginDarkMMClgResetReq",
			"PM_OriginDarkMMClgResetRes",
			block = true
		},
		[255] = "OriginDarkMMClgExtension",
		[101] = {
			"PM_Notify_OriginDarkMMClgChallengeResultRes"
		}
	},
	[774] = {
		{
			"PM_OriginKingMengMengClgGetInfoReq",
			"PM_OriginKingMengMengClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginKingMengMengClgExtremeFightReq",
			"PM_OriginKingMengMengClgExtremeFightRes",
			block = true
		},
		{
			"PM_OriginKingMengMengClgBossFightReq",
			"PM_OriginKingMengMengClgBossFightRes",
			block = true
		},
		{
			"PM_OriginKingMengMengClgConfirmReq",
			"PM_OriginKingMengMengClgConfirmRes",
			block = true
		},
		{
			"PM_OriginKingMengMengClgNormalFightReq",
			"PM_OriginKingMengMengClgNormalFightRes",
			block = true
		},
		{
			"PM_OriginKingMengMengClgResetReq",
			"PM_OriginKingMengMengClgResetRes",
			block = true
		},
		[255] = "OriginKingMengMengClgExtension",
		[101] = {
			"PM_OriginKingMengMengClgExtremeFightNotifyRes"
		},
		[102] = {
			"PM_OriginKingMengMengClgBossFightNotifyRes"
		},
		[103] = {
			"PM_OriginKingMengMengClgNormalFightNotifyRes"
		}
	},
	[775] = {
		{
			"PM_DreamTeamChapterGetInfoReq",
			"PM_DreamTeamChapterGetInfoRes",
			block = true
		},
		{
			"PM_DreamTeamChapterSmeltReq",
			"PM_DreamTeamChapterSmeltRes",
			block = true
		},
		{
			"PM_DreamTeamChapterChallengeReq",
			"PM_DreamTeamChapterChallengeRes",
			block = true
		},
		{
			"PM_DreamTeamChapterNotifyClgRes"
		},
		{
			"PM_DreamTeamChapterChallengeBossReq",
			"PM_DreamTeamChapterChallengeBossRes",
			block = true
		},
		{
			"PM_DreamTeamChapterNotifyBossClgRes"
		},
		{
			"PM_DreamTeamChapterRankViewReq",
			"PM_DreamTeamChapterRankViewRes",
			block = true
		},
		{
			"PM_DreamTeamChapterFirstClickReq",
			"PM_DreamTeamChapterFirstClickRes",
			block = true
		},
		{
			"PM_DreamTeamChapterAwakenMengMengReq",
			"PM_DreamTeamChapterAwakenMengMengRes",
			block = true
		},
		{
			"PM_DreamTeamChapterOneClickGainProgressPrizeReq",
			"PM_DreamTeamChapterOneClickGainProgressPrizeRes",
			block = true
		},
		[255] = "DreamTeamExtension"
	},
	[776] = {
		{
			"PM_OriginHotBloodedMMClgGetInfoReq",
			"PM_OriginHotBloodedMMClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginHotBloodedMMClgChallengeReq",
			"PM_OriginHotBloodedMMClgChallengeRes",
			block = true
		},
		[255] = "OriginHotBloodedMMClgExtension",
		[101] = {
			"PM_Notify_OriginHotBloodedMMClgChallengeResultRes"
		}
	},
	[777] = {
		{
			"PM_MMDrinkShopGetInfoReq",
			"PM_MMDrinkShopGetInfoRes",
			block = true
		},
		{
			"PM_MMDrinkShopStartMakeReq",
			"PM_MMDrinkShopStartMakeRes",
			block = true
		},
		{
			"PM_MMDrinkShopFinishMakeReq",
			"PM_MMDrinkShopFinishMakeRes",
			block = true
		},
		{
			"PM_MMDrinkShopGainPrizeReq",
			"PM_MMDrinkShopGainPrizeRes",
			block = true
		},
		[255] = "MMDrinkShopExtension"
	},
	[778] = {
		{
			"PM_GroupRegressGetInfoReq",
			"PM_GroupRegressGetInfoRes",
			block = true
		},
		{
			"PM_GroupRegressBindReq",
			"PM_GroupRegressBindRes",
			block = true
		},
		{
			"PM_GroupRegressGainProgressPrizeReq",
			"PM_GroupRegressGainProgressPrizeRes",
			block = true
		},
		{
			"PM_GroupRegressGainOncePrizeReq",
			"PM_GroupRegressGainOncePrizeRes",
			block = true
		},
		{
			"PM_GroupRegressGetTeamInfoReq",
			"PM_GroupRegressGetTeamInfoRes",
			block = true
		},
		[255] = "GroupRegressExtension",
		[101] = {
			"PM_GroupRegressNotifyNewMemberRes"
		}
	},
	[779] = {
		{
			"PM_OriginDuoLaGameGetInfoReq",
			"PM_OriginDuoLaGameGetInfoRes",
			block = true
		},
		{
			"PM_OriginDuoLaGameStartGameReq",
			"PM_OriginDuoLaGameStartGameRes",
			block = true
		},
		{
			"PM_OriginDuoLaGameEndGameReq",
			"PM_OriginDuoLaGameEndGameRes",
			block = true
		},
		[255] = "OriginDuoLaGameExtension"
	},
	[780] = {
		{
			"PM_MMTeamPassportGetInfoReq",
			"PM_MMTeamPassportGetInfoRes",
			block = true
		},
		[255] = "MMTeamPassportExtension",
		[3] = {
			"PM_MMTeamPassportGetTeamHallInfoReq",
			"PM_MMTeamPassportGetTeamHallInfoRes",
			block = true
		},
		[4] = {
			"PM_MMTeamPassportApplyJoinTeamReq",
			"PM_MMTeamPassportApplyJoinTeamRes",
			block = true
		},
		[5] = {
			"PM_MMTeamPassportApproveApplyReq",
			"PM_MMTeamPassportApproveApplyRes",
			block = true
		},
		[6] = {
			"PM_MMTeamPassportOpenApplyListReq",
			"PM_MMTeamPassportOpenApplyListRes",
			block = true
		},
		[7] = {
			"PM_MMTeamPassportGainTeamPrizeReq",
			"PM_MMTeamPassportGainTeamPrizeRes",
			block = true
		}
	},
	[781] = {
		{
			"PM_OriginAlchemyMengMengGetInfoReq",
			"PM_OriginAlchemyMengMengGetInfoRes",
			block = true
		},
		{
			"PM_OriginAlchemyMengMengResetReq",
			"PM_OriginAlchemyMengMengResetRes",
			block = true
		},
		{
			"PM_OriginAlchemyMengMengChallengeReq",
			"PM_OriginAlchemyMengMengChallengeRes",
			block = true
		},
		{
			"PM_OriginAlchemyMengMengSmeltReagentReq",
			"PM_OriginAlchemyMengMengSmeltReagentRes",
			block = true
		},
		{
			"PM_OriginAlchemyMengMengNotifyClgRes"
		},
		[255] = "OriginAlchemyMengMengExtension"
	},
	[782] = {
		{
			"PM_WorldCupGetInfoReq",
			"PM_WorldCupGetInfoRes",
			block = true
		},
		{
			"PM_WorldCupGainDailyPrizeReq",
			"PM_WorldCupGainDailyPrizeRes",
			block = true
		},
		{
			"PM_WorldCupBetReq",
			"PM_WorldCupBetRes",
			block = true
		},
		{
			"PM_WorldCupOneKeyGainPrizeReq",
			"PM_WorldCupOneKeyGainPrizeRes",
			block = true
		},
		{
			"PM_WorldCupRankInfoReq",
			"PM_WorldCupRankInfoRes",
			block = true
		},
		{
			"PM_WorldCupGuessTopThreeReq",
			"PM_WorldCupGuessTopThreeRes",
			block = true
		},
		{
			"PM_WorldCupGainTopThreePrizeReq",
			"PM_WorldCupGainTopThreePrizeRes",
			block = true
		},
		[255] = "WorldCupExtension"
	},
	[783] = {
		{
			"PM_GearGameInfoReq",
			"PM_GearGameInfoRes",
			block = true
		},
		{
			"PM_GearGameStartGameReq",
			"PM_GearGameStartGameRes",
			block = true
		},
		{
			"PM_GearGameEndGameReq",
			"PM_GearGameEndGameRes",
			block = true
		},
		[255] = "GearGameExtension"
	},
	[784] = {
		{
			"PM_RepairChannelGetInfoReq",
			"PM_RepairChannelGetInfoRes",
			block = true
		},
		{
			"PM_RepairChannelRepairNodeReq",
			"PM_RepairChannelRepairNodeRes",
			block = true
		},
		[255] = "RepairChannelExtension"
	},
	[785] = {
		{
			"PM_GoldenTowerLotteryGetInfoReq",
			"PM_GoldenTowerLotteryGetInfoRes",
			block = true
		},
		{
			"PM_GoldenTowerLotteryLotteryReq",
			"PM_GoldenTowerLotteryLotteryRes",
			block = true
		},
		[255] = "GoldenTowerLotteryExtension"
	},
	[786] = {
		{
			"PM_FishingGameGetInfoReq",
			"PM_FishingGameGetInfoRes",
			block = true
		},
		{
			"PM_FishingGameStartGameReq",
			"PM_FishingGameStartGameRes",
			block = true
		},
		{
			"PM_FishingGameEndGameReq",
			"PM_FishingGameEndGameRes",
			block = true
		},
		{
			"PM_FishingGameGainPrizeReq",
			"PM_FishingGameGainPrizeRes",
			block = true
		},
		{
			"PM_FishingGameAnnuitySweepReq",
			"PM_FishingGameAnnuitySweepRes",
			block = true
		},
		[255] = "FishingGameExtension"
	},
	[787] = {
		{
			"PM_OriginHolyChallengeGetInfoReq",
			"PM_OriginHolyChallengeGetInfoRes",
			block = true
		},
		{
			"PM_OriginHolyChallengeChallengeReq",
			"PM_OriginHolyChallengeChallengeRes",
			block = true
		},
		[255] = "OriginHolyChallengeExtension",
		[101] = {
			"PM_Notify_OriginHolyChallengeChallengeResultRes"
		}
	},
	[788] = {
		{
			"PM_HolyDragonTempleInfoReq",
			"PM_HolyDragonTempleInfoRes",
			block = true
		},
		{
			"PM_HolyDragonTempleChallengeReq",
			"PM_HolyDragonTempleChallengeRes",
			block = true
		},
		{
			"PM_HolyDragonTempleNotifyChallengeRes"
		},
		{
			"PM_HolyDragonTempleSignInReq",
			"PM_HolyDragonTempleSignInRes",
			block = true
		},
		[255] = "HolyDragonTempleExtension"
	},
	[789] = {
		{
			"PM_OriginLightDimensionInfoReq",
			"PM_OriginLightDimensionInfoRes",
			block = true
		},
		{
			"PM_OriginLightDimensionExtremeClgReq",
			"PM_OriginLightDimensionExtremeClgRes",
			block = true
		},
		{
			"PM_OriginLightDimensionNormalClgReq",
			"PM_OriginLightDimensionNormalClgRes",
			block = true
		},
		{
			"PM_OriginLightDimensionResetExtremeReq",
			"PM_OriginLightDimensionResetExtremeRes",
			block = true
		},
		[255] = "OriginLightDimensionExtension",
		[101] = {
			"PM_OriginLightDimensionNotifyExtremeClgRes"
		},
		[102] = {
			"PM_OriginLightDimensionNotifyNormalClgRes"
		}
	},
	[790] = {
		{
			"PM_HolyDragonFieldInfoReq",
			"PM_HolyDragonFieldInfoRes",
			block = true
		},
		{
			"PM_HolyDragonFieldChallengeReq",
			"PM_HolyDragonFieldChallengeRes",
			block = true
		},
		{
			"PM_HolyDragonFieldNotifyChallengeRes"
		},
		{
			"PM_HolyDragonFieldUpgradeBuffReq",
			"PM_HolyDragonFieldUpgradeBuffRes",
			block = true
		},
		{
			"PM_HolyDragonFieldRankViewReq",
			"PM_HolyDragonFieldRankViewRes",
			block = true
		},
		[255] = "HolyDragonFieldExtension"
	},
	[791] = {
		{
			"PM_AbyssGoldRushGetInfoReq",
			"PM_AbyssGoldRushGetInfoRes",
			block = true
		},
		{
			"PM_AbyssGoldRushPresetReq",
			"PM_AbyssGoldRushPresetRes",
			block = true
		},
		{
			"PM_AbyssGoldRushStartGameReq",
			"PM_AbyssGoldRushStartGameRes",
			block = true
		},
		{
			"PM_AbyssGoldRushPushStepReq",
			"PM_AbyssGoldRushPushStepRes",
			block = true
		},
		{
			"PM_AbyssGoldRushFightReq",
			"PM_AbyssGoldRushFightRes",
			block = true
		},
		{
			"PM_AbyssGoldRushFinishGameReq",
			"PM_AbyssGoldRushFinishGameRes",
			block = true
		},
		{
			"PM_AbyssGoldRushRankViewReq",
			"PM_AbyssGoldRushRankViewRes",
			block = true
		},
		{
			"PM_AbyssGoldRushUsePresetReq",
			"PM_AbyssGoldRushUsePresetRes",
			block = true
		},
		[255] = "AbyssGoldRushExtension",
		[101] = {
			"PM_AbyssGoldRushNotifyFightRes"
		}
	},
	[792] = {
		{
			"PM_XuChallengeInfoReq",
			"PM_XuChallengeInfoRes",
			block = true
		},
		{
			"PM_XuChallengeClgReq",
			"PM_XuChallengeClgRes",
			block = true
		},
		{
			"PM_XuChallengeResetReq",
			"PM_XuChallengeResetRes",
			block = true
		},
		{
			"PM_XuChallengeReplacePetReq",
			"PM_XuChallengeReplacePetRes",
			block = true
		},
		{
			"PM_XuChallengeNotifyClgRes"
		},
		[255] = "XuChallengeExtension"
	},
	[793] = {
		{
			"PM_ZdlVerifyInfoReq",
			"PM_ZdlVerifyInfoRes",
			block = true
		},
		{
			"PM_ZdlVerifyVerifyRaceReq",
			"PM_ZdlVerifyVerifyRaceRes",
			block = true
		},
		{
			"PM_ZdlVerifyGainProgressReq",
			"PM_ZdlVerifyGainProgressRes",
			block = true
		},
		[255] = "ZdlVerifyExtension"
	},
	[794] = {
		{
			"PM_CloudCutFanInfoReq",
			"PM_CloudCutFanInfoRes",
			block = true
		},
		{
			"PM_CloudCutFanBossClgReq",
			"PM_CloudCutFanBossClgRes",
			block = true
		},
		{
			"PM_CloudCutFanMakeFanReq",
			"PM_CloudCutFanMakeFanRes",
			block = true
		},
		{
			"PM_CloudCutFanUnLockFaceReq",
			"PM_CloudCutFanUnLockFaceRes",
			block = true
		},
		{
			"PM_CloudCutFanGetRewardPrizeReq",
			"PM_CloudCutFanGetRewardPrizeRes",
			block = true
		},
		[255] = "CloudCutFanExtension",
		[101] = {
			"PM_CloudCutFanNotifyBossClgRes"
		}
	},
	[795] = {
		{
			"PM_CiyuanSigninGetInfoReq",
			"PM_CiyuanSigninGetInfoRes",
			block = true
		},
		{
			"PM_CiyuanSigninGainPrizeReq",
			"PM_CiyuanSigninGainPrizeRes",
			block = true
		},
		{
			"PM_CiyuanSigninBuyMakeUpReq",
			"PM_CiyuanSigninBuyMakeUpRes",
			block = true
		},
		[255] = "CiyuanSigninExtension"
	},
	[796] = {
		{
			"PM_OriginGoldenDragonClgGetInfoReq",
			"PM_OriginGoldenDragonClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginGoldenDragonClgChallengeStageReq",
			"PM_OriginGoldenDragonClgChallengeStageRes",
			block = true
		},
		{
			"PM_OriginGoldenDragonClgGainPrizeReq",
			"PM_OriginGoldenDragonClgGainPrizeRes",
			block = true
		},
		{
			"PM_OriginGoldenDragonClgResetChallengeReq",
			"PM_OriginGoldenDragonClgResetChallengeRes",
			block = true
		},
		{
			"PM_OriginGoldenDragonClgConfirmReq",
			"PM_OriginGoldenDragonClgConfirmRes",
			block = true
		},
		[255] = "OriginGoldenDragonClgExtension",
		[101] = {
			"PM_OriginGoldenDragonClgNotifyStageResultRes"
		}
	},
	[797] = {
		{
			"PM_OriginDualDragonInfoReq",
			"PM_OriginDualDragonInfoRes",
			block = true
		},
		{
			"PM_OriginDualDragonChallengeReq",
			"PM_OriginDualDragonChallengeRes",
			block = true
		},
		{
			"PM_OriginDualDragonNotifyChallengeRes"
		},
		{
			"PM_OriginDualDragonResetStageReq",
			"PM_OriginDualDragonResetStageRes",
			block = true
		},
		[255] = "OriginDualDragonExtension"
	},
	[798] = {
		{
			"PM_OriginInfiniteFutureClgGetInfoReq",
			"PM_OriginInfiniteFutureClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginInfiniteFutureClgFightReq",
			"PM_OriginInfiniteFutureClgFightRes",
			block = true
		},
		{
			"PM_OriginInfiniteFutureClgResetReq",
			"PM_OriginInfiniteFutureClgResetRes",
			block = true
		},
		[255] = "OriginInfiniteFutureClgExtension",
		[101] = {
			"PM_OriginInfiniteFutureClgNotifyFightRes"
		}
	},
	[799] = {
		{
			"PM_OriginChenClgGetInfoReq",
			"PM_OriginChenClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginChenClgChallengeExtremeReq",
			"PM_OriginChenClgChallengeExtremeRes",
			block = true
		},
		{
			"PM_OriginChenClgConfirmExtremeReq",
			"PM_OriginChenClgConfirmExtremeRes",
			block = true
		},
		{
			"PM_OriginChenClgResetExtremeReq",
			"PM_OriginChenClgResetExtremeRes",
			block = true
		},
		{
			"PM_OriginChenClgChallengeNormalReq",
			"PM_OriginChenClgChallengeNormalRes",
			block = true
		},
		[255] = "OriginChenClgExtension",
		[101] = {
			"PM_Notify_OriginChenClgChallengeExtremeResultRes"
		},
		[102] = {
			"PM_Notify_OriginChenClgChallengeNormalResultRes"
		}
	},
	[800] = {
		{
			"PM_OriginMiMengLiInfoReq",
			"PM_OriginMiMengLiInfoRes",
			block = true
		},
		{
			"PM_OriginMiMengLiClgReq",
			"PM_OriginMiMengLiClgRes",
			block = true
		},
		[255] = "OriginMiMengLiExtension",
		[101] = {
			"PM_OriginMiMengLiNotifyClgRes"
		}
	},
	[801] = {
		{
			"PM_PanTaoFeastGetInfoReq",
			"PM_PanTaoFeastGetInfoRes",
			block = true
		},
		{
			"PM_PanTaoFeastMoveElementsReq",
			"PM_PanTaoFeastMoveElementsRes",
			block = true
		},
		{
			"PM_PanTaoFeastProduceElementReq",
			"PM_PanTaoFeastProduceElementRes",
			block = true
		},
		{
			"PM_PanTaoFeastMoveToStoreReq",
			"PM_PanTaoFeastMoveToStoreRes",
			block = true
		},
		{
			"PM_PanTaoFeastMergeElementsReq",
			"PM_PanTaoFeastMergeElementsRes",
			block = true
		},
		{
			"PM_PanTaoFeastAutoMergeReq",
			"PM_PanTaoFeastAutoMergeRes",
			block = true
		},
		{
			"PM_PanTaoFeastUseEnergyPackReq",
			"PM_PanTaoFeastUseEnergyPackRes",
			block = true
		},
		{
			"PM_PanTaoFeastCookDishReq",
			"PM_PanTaoFeastCookDishRes",
			block = true
		},
		{
			"PM_PanTaoFeastStashToGridReq",
			"PM_PanTaoFeastStashToGridRes",
			block = true
		},
		{
			"PM_PanTaoFeastDeleteGridElementReq",
			"PM_PanTaoFeastDeleteGridElementRes",
			block = true
		},
		{
			"PM_PanTaoFeastSubmitOrderReq",
			"PM_PanTaoFeastSubmitOrderRes",
			block = true
		},
		{
			"PM_PanTaoFeastGainRoundPrizeReq",
			"PM_PanTaoFeastGainRoundPrizeRes",
			block = true
		},
		{
			"PM_PanTaoFeastRepairBuildingReq",
			"PM_PanTaoFeastRepairBuildingRes",
			block = true
		},
		{
			"PM_PanTaoFeastGainBookPrizeReq",
			"PM_PanTaoFeastGainBookPrizeRes",
			block = true
		},
		{
			"PM_PanTaoFeastGainDailyGiftReq",
			"PM_PanTaoFeastGainDailyGiftRes",
			block = true
		},
		{
			"PM_PanTaoFeastGetRankInfoReq",
			"PM_PanTaoFeastGetRankInfoRes",
			block = true
		},
		[255] = "PanTaoFeastExtension",
		[101] = {
			"PM_PanTaoFeastNotifyChangeRes"
		}
	},
	[802] = {
		{
			"PM_SummerTreasureSnatchInfoReq",
			"PM_SummerTreasureSnatchInfoRes",
			block = true
		},
		{
			"PM_SummerTreasureSnatchPvpMatchReq",
			"PM_SummerTreasureSnatchPvpMatchRes",
			block = true
		},
		{
			"PM_SummerTreasureSnatchPvpFightReq",
			"PM_SummerTreasureSnatchPvpFightRes",
			block = true
		},
		{
			"PM_SummerTreasureSnatchBossClgReq",
			"PM_SummerTreasureSnatchBossClgRes",
			block = true
		},
		{
			"PM_SummerTreasureSnatchBuyItemReq",
			"PM_SummerTreasureSnatchBuyItemRes",
			block = true
		},
		{
			"PM_SummerTreasureSnatchPresetFormationReq",
			"PM_SummerTreasureSnatchPresetFormationRes",
			block = true
		},
		{
			"PM_SummerTreasureSnatchRankViewReq",
			"PM_SummerTreasureSnatchRankViewRes",
			block = true
		},
		[255] = "SummerTreasureSnatchExtension",
		[101] = {
			"PM_SummerTreasureSnatchNotifyBossClgRes"
		}
	},
	[803] = {
		{
			"PM_YoungArenaKingS3GetInfoReq",
			"PM_YoungArenaKingS3GetInfoRes",
			block = true
		},
		{
			"PM_YoungArenaKingS3NotifyStepChangeRes"
		},
		{
			"PM_YoungArenaKingS3GetVideoReq",
			"PM_YoungArenaKingS3GetVideoRes",
			block = true
		},
		{
			"PM_YoungArenaKingS3GetDefenseForamtionReq",
			"PM_YoungArenaKingS3GetDefenseForamtionRes",
			block = true
		},
		{
			"PM_YoungArenaKingS3SetDefenseForamtionReq",
			"PM_YoungArenaKingS3SetDefenseForamtionRes",
			block = true
		},
		[255] = "YoungArenaKingS3Extension",
		[11] = {
			"PM_YoungArenaKingS3GetQualifierInfoReq",
			"PM_YoungArenaKingS3GetQualifierInfoRes",
			block = true
		},
		[12] = {
			"PM_YoungArenaKingS3QualifierGetNewOpponentReq",
			"PM_YoungArenaKingS3QualifierGetNewOpponentRes",
			block = true
		},
		[13] = {
			"PM_YoungArenaKingS3QualifierFightReq",
			"PM_YoungArenaKingS3QualifierFightRes",
			block = true
		},
		[14] = {
			"PM_YoungArenaKingS3QualifierRecordsReq",
			"PM_YoungArenaKingS3QualifierRecordsRes",
			block = true
		},
		[15] = {
			"PM_YoungArenaKingS3QualifierRankInfoReq",
			"PM_YoungArenaKingS3QualifierRankInfoRes",
			block = true
		},
		[16] = {
			"PM_YoungArenaKingS3QualifierPetRaceRankReq",
			"PM_YoungArenaKingS3QualifierPetRaceRankRes",
			block = true
		},
		[21] = {
			"PM_YoungArenaKingS3MyKnockoutInfoReq",
			"PM_YoungArenaKingS3MyKnockoutInfoRes",
			block = true
		},
		[22] = {
			"PM_YoungArenaKingS3GetKnockoutScheduleReq",
			"PM_YoungArenaKingS3GetKnockoutScheduleRes",
			block = true
		},
		[23] = {
			"PM_YoungArenaKingS3GetDisplayInfoReq",
			"PM_YoungArenaKingS3GetDisplayInfoRes",
			block = true
		}
	},
	[804] = {
		{
			"PM_OriginDarkMoYanClgGetInfoReq",
			"PM_OriginDarkMoYanClgGetInfoRes",
			block = true
		},
		{
			"PM_OriginDarkMoYanClgSelectBuffCellReq",
			"PM_OriginDarkMoYanClgSelectBuffCellRes",
			block = true
		},
		{
			"PM_OriginDarkMoYanClgChallengeCellReq",
			"PM_OriginDarkMoYanClgChallengeCellRes",
			block = true
		},
		{
			"PM_OriginDarkMoYanClgConfirmLockPetReq",
			"PM_OriginDarkMoYanClgConfirmLockPetRes",
			block = true
		},
		{
			"PM_OriginDarkMoYanClgResetCurrentStageReq",
			"PM_OriginDarkMoYanClgResetCurrentStageRes",
			block = true
		},
		[255] = "OriginDarkMoYanClgExtension",
		[101] = {
			"PM_OriginDarkMoYanClgNotifyCellResultRes"
		}
	},
	[805] = {
		{
			"PM_FormationCollectInfoReq",
			"PM_FormationCollectInfoRes",
			block = true
		},
		{
			"PM_FormationCollectGetPrizeReq",
			"PM_FormationCollectGetPrizeRes",
			block = true
		},
		[255] = "FormationCollectExtension"
	},
	[29998] = {
		{
			"BB_RandomPersonReq",
			"BB_RandomPersonRes",
			block = true
		},
		{
			"BB_DeletePetReq",
			"BB_DeletePetRes",
			block = true
		},
		[255] = "BombermanExtension",
		[4] = {
			"BB_ForceOpenTaskReq",
			"BB_ForceOpenTaskRes",
			block = true
		},
		[5] = {
			"PM_GenData4PressureAccountReq",
			"PM_GenData4PressureAccountRes",
			block = true
		},
		[6] = {
			"PM_GenNewPet4PressureAccountReq",
			"PM_GenNewPet4PressureAccountRes",
			block = true
		},
		[7] = {
			"BB_SellMaterialsReq",
			"BB_SellMaterialsRes",
			block = true
		},
		[8] = {
			"BB_StepOverTaskStepReq",
			"BB_StepOverTaskStepRes",
			block = true
		},
		[9] = {
			"BB_SendMailReq",
			"BB_SendMailRes",
			block = true
		},
		[10] = {
			"BB_LongTimeReplyReq",
			"BB_LongTimeReplyRes",
			block = true
		},
		[11] = {
			"BB_SubmitBtlRecordReq",
			"BB_SubmitBtlRecordRes",
			block = true
		},
		[12] = {
			"BB_AddOnePetReq",
			"BB_AddOnePetRes",
			block = true
		},
		[13] = {
			"BB_ForceAwakenReq",
			"BB_ForceAwakenRes",
			block = true
		},
		[14] = {
			"BB_ForceUpgradeTalentReq",
			"BB_ForceUpgradeTalentRes",
			block = true
		},
		[16] = {
			"BB_ForceInstallOrUninstallRuneSuitReq",
			"BB_ForceInstallOrUninstallRuneSuitRes",
			block = true
		},
		[17] = {
			"BB_ForceLevelUpReq",
			"BB_ForceLevelUpRes",
			block = true
		},
		[18] = {
			"BB_DoSomeStrengthenPetReq",
			"BB_DoSomeStrengthenPetRes",
			block = true
		},
		[19] = {
			"BB_LotteryReq",
			"BB_LotteryRes",
			block = true
		},
		[20] = {
			"BB_ExpeditionEventReq",
			"BB_ExpeditionEventRes",
			block = true
		},
		[22] = {
			"BB_FakeFamilyDonateReq",
			"BB_FakeFamilyDonateRes",
			block = true
		},
		[23] = {
			"BB_TestChatPrivateReq",
			"BB_TestChatPrivateRes",
			block = true
		},
		[24] = {
			"BB_GenUserPetReq",
			"BB_GenUserPetRes",
			block = true
		},
		[25] = {
			"BB_PowerCrystalReq",
			"BB_PowerCrystalRes",
			block = true
		},
		[26] = {
			"BB_FakeSubmitRmRankReq",
			"BB_FakeSubmitRmRankRes",
			block = true
		},
		[27] = {
			"BB_FakeRmMatchingReq",
			"BB_FakeRmMatchingRes",
			block = true
		},
		[28] = {
			"BB_NotifyFakeRmMatchingEndRes"
		},
		[29] = {
			"BB_RefreshArenaChallengeTargetsReq",
			"BB_RefreshArenaChallengeTargetsRes",
			block = true
		},
		[30] = {
			"BB_TimeWheelRevertAllStrengthenReq",
			"BB_TimeWheelRevertAllStrengthenReq",
			block = true
		},
		[31] = {
			"BB_GenUserFormReq",
			"BB_GenUserFormRes",
			block = true
		},
		[32] = {
			"BB_RMRandomMatchingReq",
			"BB_RMRandomMatchingRes",
			block = true
		},
		[33] = {
			"BB_randomChallengeFamilyBossReq",
			"BB_randomChallengeFamilyBossReq",
			block = true
		},
		[34] = {
			"BB_AutoConvoyReq",
			"BB_AutoConvoyRes",
			block = true
		},
		[35] = {
			"BB_JackpotReq",
			"BB_JackpotRes",
			block = true
		},
		[36] = {
			"BB_Arena3v3InitFormReq",
			"BB_Arena3v3InitFormRes",
			block = true
		},
		[37] = {
			"BB_Arena3v3InfoReq",
			"BB_Arena3v3InfoRes",
			block = true
		},
		[38] = {
			"BB_Arena3v3FightReq",
			"BB_Arena3v3FightRes",
			block = true
		},
		[39] = {
			"BB_ShareTaskTriggerAndUploadReq",
			"BB_ShareTaskTriggerAndUploadRes",
			block = true
		},
		[40] = {
			"BB_ShareTaskTriggerAndFightReq",
			"BB_ShareTaskTriggerAndFightRes",
			block = true
		},
		[41] = {
			"BB_ShareTaskFightOtherBossReq",
			"BB_ShareTaskFightOtherBossRes",
			block = true
		}
	},
	[29999] = {
		{
			"PM_CreateBtlDemoReq",
			"PM_CreateBtlDemoRes",
			block = true
		},
		{
			"PM_CreateActionBtlDemoReq",
			"PM_CreateActionBtlDemoRes",
			block = true
		},
		{
			"PM_CustomBattleReq",
			"PM_CustomBattleRes",
			block = true
		},
		{
			"PM_CustomFightMonsterReq",
			"PM_CustomFightMonsterRes",
			block = true
		},
		{
			"PM_UserFightMonsterReq",
			"PM_UserFightMonsterRes",
			block = true
		},
		{
			"PM_ClearBattleCdReq",
			"PM_ClearBattleCdRes",
			block = true
		},
		{
			"PM_AddMaterialsReq",
			"PM_AddMaterialsRes",
			block = true
		},
		{
			"PM_SetOnlineTimeReq",
			"PM_SetOnlineTimeRes"
		},
		{
			"PM_DecMaterialsReq",
			"PM_DecMaterialsRes",
			block = true
		},
		{
			"PM_MultiCustomBattleReq",
			"PM_MultiCustomBattleRes",
			block = true
		},
		{
			"PM_NormalEvolveReq",
			"PM_NormalEvolveRes",
			block = true
		},
		{
			"PM_SendMailReq",
			"PM_SendMailRes",
			block = true
		},
		{
			"PM_EVEMonsterFightReq",
			"PM_EVEMonsterFightRes",
			block = true
		},
		{
			"PM_ViewUserFightMonsterBtlResultReq",
			"PM_ViewUserFightMonsterBtlResultRes",
			block = true
		},
		{
			"PM_RandomDelBuddyReq",
			"PM_RandomDelBuddyRes",
			block = true
		},
		{
			"PM_HandleABuddyRequestReq",
			"PM_HandleABuddyRequestRes",
			block = true
		},
		{
			"PM_StepOverTaskStepReq",
			"PM_StepOverTaskStepRes",
			block = true
		},
		{
			"PM_StepOverTaskReq",
			"PM_StepOverTaskRes",
			block = true
		},
		{
			"PM_SubmitRankReq",
			"PM_SubmitRankRes",
			block = true
		},
		{
			"PM_ViewRankReq",
			"PM_ViewRankRes",
			block = true
		},
		{
			"PM_GotoTaskStepReq",
			"PM_GotoTaskStepRes",
			block = true
		},
		{
			"PM_ChangeUserBanStateReq",
			"PM_ChangeUserBanStateRes",
			block = true
		},
		{
			"PM_ArenaChallengeReq",
			"PM_ArenaChallengeRes",
			block = true
		},
		{
			"PM_BgmSendBroadcastReq",
			"PM_BgmSendBroadcastRes",
			block = true
		},
		{
			"PM_BgmDeleteBroadcastReq",
			"PM_BgmDeleteBroadcastRes",
			block = true
		},
		[255] = "GMExtension",
		[27] = {
			"PM_TestBroadcastReq",
			"PM_TestBroadcastRes",
			block = true
		},
		[28] = {
			"PM_AddThreeHeroesPointReq",
			"PM_AddThreeHeroesPointReq",
			block = true
		},
		[29] = {
			"PM_LotterySimulateTimesReq",
			"PM_LotterySimulateTimesRes",
			block = true
		},
		[30] = {
			"PM_LotterySimulateTargetsReq",
			"PM_LotterySimulateTargetsRes",
			block = true
		},
		[31] = {
			"PM_PlotPassStageReq",
			"PM_PlotPassStageRes",
			block = true
		},
		[32] = {
			"PM_AddFamilyScoreReq",
			"PM_AddFamilyScoreRes",
			block = true
		},
		[33] = {
			"PM_ModifyDonateValueReq",
			"PM_ModifyDonateValueRes",
			block = true
		},
		[34] = {
			"PM_RefreshFamilyListReq",
			"PM_RefreshFamilyListRes",
			block = true
		},
		[35] = {
			"PM_DeleteAllEquipmentsReq",
			"PM_DeleteAllEquipmentsRes",
			block = true
		},
		[36] = {
			"PM_GetUserPetPropertyReq",
			"PM_GetUserPetPropertyRes",
			block = true
		},
		[37] = {
			"PM_DeletePetsReq",
			"PM_DeletePetsRes",
			block = true
		},
		[38] = {
			"PM_ResetFamilyBossClgTimesReq",
			"PM_ResetFamilyBossClgTimesRes",
			block = true
		},
		[39] = {
			"PM_FakeFinishPayOrderReq",
			"PM_FakeFinishPayOrderRes",
			block = true
		},
		[40] = {
			"PM_GenUserPetReq",
			"PM_GenUserPetRes",
			block = true
		},
		[41] = {
			"PM_RefreshKingRoadInfoReq",
			"PM_RefreshKingRoadInfoRes",
			block = true
		},
		[42] = {
			"PM_LotteryCycleReq",
			"PM_LotteryCycleRes",
			block = true
		},
		[43] = {
			"PM_GenTempLoginAuthCodeReq",
			"PM_GenTempLoginAuthCodeRes",
			block = true
		},
		[44] = {
			"PM_GmZooHatchSlotProcessReq",
			"PM_GmZooHatchSlotProcessRes",
			block = true
		},
		[45] = {
			"PM_EquipmentPoolSimulateTimesReq",
			"PM_LotterySimulateTimesRes",
			block = true
		},
		[46] = {
			"PM_SeasonModePveMapJumpReq",
			"PM_SeasonModePveMapJumpRes",
			block = true
		},
		[47] = {
			"PM_RejectShutdownServerReq",
			"PM_RejectShutdownServerRes",
			block = true
		},
		[48] = {
			"PM_GM_AddAllSsrAndSkinsReq",
			"PM_GM_AddAllSsrAndSkinsRes",
			block = true
		},
		[49] = {
			"PM_TestSplitMailContentReq",
			"PM_TestSplitMailContentRes",
			block = true
		},
		[50] = {
			"PM_GM_DomainAdventureIncProgressReq",
			"PM_GM_DomainAdventureIncProgressRes",
			block = true
		},
		[51] = {
			"PM_SurvivalKingOneKeySignUpReq",
			"PM_SurvivalKingOneKeySignUpRes",
			block = true
		},
		[52] = {
			"PM_SurvivalKingSimulateRoomReq",
			"PM_SurvivalKingSimulateRoomRes",
			block = true
		},
		[53] = {
			"PM_MahjongBattleCoverMahjongReq",
			"PM_MahjongBattleCoverMahjongRes",
			block = true
		},
		[54] = {
			"PM_MahjongBattleChangeDrawMahjongReq",
			"PM_MahjongBattleChangeDrawMahjongRes",
			block = true
		},
		[55] = {
			"PM_BattleKMPLogSwitchReq",
			"PM_BattleKMPLogSwitchRes",
			block = true
		},
		[56] = {
			"PM_NotifyBattleKMPLogIdRes"
		},
		[127] = {
			"PM_ReceivedShutdownServerRequestRes"
		}
	}
}

setglobal("setting_proto", setting_proto)

return setting_proto
