local var_0_0 = {}
local var_0_1 = {
	[5003] = {
		msgtype = 5004,
		func_name = "AuthReq",
		is_request = true
	},
	[5009] = {
		msgtype = 5010,
		func_name = "RealNameAuthReq",
		is_request = true
	},
	[7007] = {
		msgtype = 7008,
		func_name = "LoadDataReq",
		is_request = true
	},
	[7012] = {
		msgtype = 7013,
		func_name = "EnterReq",
		is_request = true
	},
	[7014] = {
		msgtype = 7015,
		func_name = "ChangeNameReq",
		is_request = true
	},
	[7018] = {
		msgtype = 7019,
		func_name = "TellDeviceReq",
		is_request = true
	},
	[7020] = {
		msgtype = 7021,
		func_name = "DailyNoticeReq",
		is_request = true
	},
	[7024] = {
		msgtype = 7025,
		func_name = "GetNewPlayerShipReq",
		is_request = true
	},
	[7026] = {
		msgtype = 7027,
		func_name = "IntensifyShipReq",
		is_request = true
	},
	[7028] = {
		msgtype = 7029,
		func_name = "IntensifySkillReq",
		is_request = true
	},
	[7030] = {
		msgtype = 7031,
		func_name = "ShipRenameReq",
		is_request = true
	},
	[7032] = {
		msgtype = 7033,
		func_name = "ChangeSecretaryReq",
		is_request = true
	},
	[7034] = {
		msgtype = 7035,
		func_name = "ResetSecretaryReq",
		is_request = true
	},
	[7036] = {
		msgtype = 7037,
		func_name = "ShipLockReq",
		is_request = true
	},
	[7038] = {
		msgtype = 7039,
		func_name = "ShipEquipReq",
		is_request = true
	},
	[7040] = {
		msgtype = 7041,
		func_name = "ShipRemoveEquipReq",
		is_request = true
	},
	[7042] = {
		msgtype = 7043,
		func_name = "ShipEquipRecordReq",
		is_request = true
	},
	[7044] = {
		msgtype = 7045,
		func_name = "UseEquipRecordReq",
		is_request = true
	},
	[7046] = {
		msgtype = 7047,
		func_name = "ShipRepairReq",
		is_request = true
	},
	[7048] = {
		msgtype = 7049,
		func_name = "QuickRepairReq",
		is_request = true
	},
	[7050] = {
		msgtype = 7051,
		func_name = "RubBackReq",
		is_request = true
	},
	[7052] = {
		msgtype = 7053,
		func_name = "ShipMarryReq",
		is_request = true
	},
	[7054] = {
		msgtype = 7055,
		func_name = "ShipChangeSkinReq",
		is_request = true
	},
	[7056] = {
		msgtype = 7057,
		func_name = "ShipEvoReq",
		is_request = true
	},
	[7058] = {
		msgtype = 7059,
		func_name = "ShipChangeTacticsReq",
		is_request = true
	},
	[7060] = {
		msgtype = 7061,
		func_name = "ShipChangeSkillReq",
		is_request = true
	},
	[7064] = {
		msgtype = 7065,
		func_name = "TeamSaveReq",
		is_request = true
	},
	[7066] = {
		msgtype = 7067,
		func_name = "TeamRenameReq",
		is_request = true
	},
	[7068] = {
		msgtype = 7069,
		func_name = "ShipSupplyReq",
		is_request = true
	},
	[7070] = {
		msgtype = 7071,
		func_name = "TeamSupplyReq",
		is_request = true
	},
	[7072] = {
		msgtype = 7073,
		func_name = "AllShipSupplyReq",
		is_request = true
	},
	[7074] = {
		msgtype = 7075,
		func_name = "TeamRepairReq",
		is_request = true
	},
	[7076] = {
		msgtype = 7077,
		func_name = "SupportLevelUpReq",
		is_request = true
	},
	[7078] = {
		msgtype = 7079,
		func_name = "SupportSupplyReq",
		is_request = true
	},
	[7080] = {
		msgtype = 7081,
		func_name = "ActiveAutoSupplyReq",
		is_request = true
	},
	[7085] = {
		msgtype = 7086,
		func_name = "EquipLockReq",
		is_request = true
	},
	[7087] = {
		msgtype = 7088,
		func_name = "GetLevelAwardReq",
		is_request = true
	},
	[7089] = {
		msgtype = 7090,
		func_name = "GetDailyAwardReq",
		is_request = true
	},
	[7091] = {
		msgtype = 7092,
		func_name = "GetOnceDailyAwardReq",
		is_request = true
	},
	[7093] = {
		msgtype = 7094,
		func_name = "GetLevelUpAwardReq",
		is_request = true
	},
	[7098] = {
		msgtype = 7099,
		func_name = "EnterMapReq",
		is_request = true
	},
	[7100] = {
		msgtype = 7101,
		func_name = "QuitMapReq",
		is_request = true
	},
	[7102] = {
		msgtype = 7103,
		func_name = "MapMoveReq",
		is_request = true
	},
	[7104] = {
		msgtype = 7105,
		func_name = "RoundAboutReq",
		is_request = true
	},
	[7106] = {
		msgtype = 7107,
		func_name = "StationPointReq",
		is_request = true
	},
	[7108] = {
		msgtype = 7109,
		func_name = "StationPointExitReq",
		is_request = true
	},
	[7110] = {
		msgtype = 7111,
		func_name = "StartBattleReq",
		is_request = true
	},
	[7112] = {
		msgtype = 7113,
		func_name = "StartNightBattleReq",
		is_request = true
	},
	[7114] = {
		msgtype = 7115,
		func_name = "QuitNightBattleReq",
		is_request = true
	},
	[7116] = {
		msgtype = 7117,
		func_name = "BattleFinishReq",
		is_request = true
	},
	[7118] = {
		msgtype = 7119,
		func_name = "ActiveShellingReq",
		is_request = true
	},
	[7121] = {
		msgtype = 7122,
		func_name = "CampaignTeamSaveReq",
		is_request = true
	},
	[7123] = {
		msgtype = 7124,
		func_name = "EnterCampaignReq",
		is_request = true
	},
	[7125] = {
		msgtype = 7126,
		func_name = "RefreshCampaignReq",
		is_request = true
	},
	[7127] = {
		msgtype = 7128,
		func_name = "CompleteNodeHideReq",
		is_request = true
	},
	[7129] = {
		msgtype = 7130,
		func_name = "CompleteNodeMissReq",
		is_request = true
	},
	[7132] = {
		msgtype = 7133,
		func_name = "ExpeditionStartReq",
		is_request = true
	},
	[7134] = {
		msgtype = 7135,
		func_name = "ExpeditionStopReq",
		is_request = true
	},
	[7136] = {
		msgtype = 7137,
		func_name = "ExpeditionFinishReq",
		is_request = true
	},
	[7139] = {
		msgtype = 7140,
		func_name = "CommitTaskReq",
		is_request = true
	},
	[7148] = {
		msgtype = 7149,
		func_name = "ShopBuyReq",
		is_request = true
	},
	[7150] = {
		msgtype = 7151,
		func_name = "MultiShopBuyReq",
		is_request = true
	},
	[7152] = {
		msgtype = 7153,
		func_name = "SpoilsBuyReq",
		is_request = true
	},
	[7154] = {
		msgtype = 7155,
		func_name = "MultiSpoilsBuyReq",
		is_request = true
	},
	[7156] = {
		msgtype = 7157,
		func_name = "VoucherShopBuyReq",
		is_request = true
	},
	[7159] = {
		msgtype = 7160,
		func_name = "UnlockStoryReq",
		is_request = true
	},
	[7161] = {
		msgtype = 7162,
		func_name = "ReadStoryReq",
		is_request = true
	},
	[7163] = {
		msgtype = 7164,
		func_name = "UnlockShipStoryReq",
		is_request = true
	},
	[7165] = {
		msgtype = 7166,
		func_name = "TokenUnlockStoryReq",
		is_request = true
	},
	[7168] = {
		msgtype = 7169,
		func_name = "GetMailReq",
		is_request = true
	},
	[7170] = {
		msgtype = 7171,
		func_name = "DeleteMailReq",
		is_request = true
	},
	[7172] = {
		msgtype = 7173,
		func_name = "GetAllMailReq",
		is_request = true
	},
	[7174] = {
		msgtype = 7175,
		func_name = "DeleteAllMailReq",
		is_request = true
	},
	[7176] = {
		msgtype = 7177,
		func_name = "LockMailReq",
		is_request = true
	},
	[7179] = {
		msgtype = 7180,
		func_name = "BuildShipReq",
		is_request = true
	},
	[7181] = {
		msgtype = 7182,
		func_name = "BuildEquipmentReq",
		is_request = true
	},
	[7183] = {
		msgtype = 7184,
		func_name = "GetBuildShipRewardReq",
		is_request = true
	},
	[7185] = {
		msgtype = 7186,
		func_name = "GetBuildEquipmentRewardReq",
		is_request = true
	},
	[7187] = {
		msgtype = 7188,
		func_name = "QuickBuildShipReq",
		is_request = true
	},
	[7189] = {
		msgtype = 7190,
		func_name = "QuickBuildEquipmentReq",
		is_request = true
	},
	[7191] = {
		msgtype = 7192,
		func_name = "BatchBuildShipReq",
		is_request = true
	},
	[7193] = {
		msgtype = 7194,
		func_name = "BatchBuildEquipmentReq",
		is_request = true
	},
	[7195] = {
		msgtype = 7196,
		func_name = "DecomposeShipReq",
		is_request = true
	},
	[7197] = {
		msgtype = 7198,
		func_name = "DecomposeEquipmentReq",
		is_request = true
	},
	[7199] = {
		msgtype = 7200,
		func_name = "UseItemBoxReq",
		is_request = true
	},
	[7202] = {
		msgtype = 7203,
		func_name = "ChangeRepairStyleReq",
		is_request = true
	},
	[7204] = {
		msgtype = 7205,
		func_name = "DecomposeCoreReq",
		is_request = true
	},
	[7207] = {
		msgtype = 7208,
		func_name = "CollectBuildRecordReq",
		is_request = true
	},
	[7209] = {
		msgtype = 7210,
		func_name = "DeleteBuildRecordReq",
		is_request = true
	},
	[7216] = {
		msgtype = 7217,
		func_name = "LockFurnitureReq",
		is_request = true
	},
	[7218] = {
		msgtype = 7219,
		func_name = "ResolveFurnitureReq",
		is_request = true
	},
	[7220] = {
		msgtype = 7221,
		func_name = "ShipEnterRoomReq",
		is_request = true
	},
	[7222] = {
		msgtype = 7223,
		func_name = "RecordRoomReq",
		is_request = true
	},
	[7224] = {
		msgtype = 7225,
		func_name = "ResetRecordReq",
		is_request = true
	},
	[7226] = {
		msgtype = 7227,
		func_name = "UseRecordReq",
		is_request = true
	},
	[7228] = {
		msgtype = 7229,
		func_name = "BuyFurnitureBoxReq",
		is_request = true
	},
	[7230] = {
		msgtype = 7231,
		func_name = "MultiBuyFurnitureBoxReq",
		is_request = true
	},
	[7232] = {
		msgtype = 7233,
		func_name = "LayoutRoomReq",
		is_request = true
	},
	[7234] = {
		msgtype = 7235,
		func_name = "getFurnitureCoollectRewardReq",
		is_request = true
	},
	[7236] = {
		msgtype = 7237,
		func_name = "AddExhibitionCollectReq",
		is_request = true
	},
	[7238] = {
		msgtype = 7239,
		func_name = "RemoveExhibitionCollectReq",
		is_request = true
	},
	[7240] = {
		msgtype = 7241,
		func_name = "UploadRecordReq",
		is_request = true
	},
	[7242] = {
		msgtype = 7243,
		func_name = "UserExhibitionReq",
		is_request = true
	},
	[7244] = {
		msgtype = 7245,
		func_name = "RacingReq",
		is_request = true
	},
	[7246] = {
		msgtype = 7247,
		func_name = "RoomExtendReq",
		is_request = true
	},
	[7248] = {
		msgtype = 7249,
		func_name = "RoomCropReq",
		is_request = true
	},
	[7250] = {
		msgtype = 7251,
		func_name = "DollMachineReq",
		is_request = true
	},
	[7252] = {
		msgtype = 7253,
		func_name = "RoomInteractReq",
		is_request = true
	},
	[7255] = {
		msgtype = 7256,
		func_name = "GetExhibitionReq",
		is_request = true
	},
	[7257] = {
		msgtype = 7258,
		func_name = "EvaluateExhibitionReq",
		is_request = true
	},
	[7260] = {
		msgtype = 7261,
		func_name = "ChangeChatHeadReq",
		is_request = true
	},
	[7263] = {
		msgtype = 7264,
		func_name = "ChangeMansionStyleReq",
		is_request = true
	},
	[7265] = {
		msgtype = 7266,
		func_name = "ChangeMusicReq",
		is_request = true
	},
	[7267] = {
		msgtype = 7268,
		func_name = "ResetMusicReq",
		is_request = true
	},
	[7269] = {
		msgtype = 7270,
		func_name = "ChangeSignatureReq",
		is_request = true
	},
	[7276] = {
		msgtype = 7277,
		func_name = "UseCookBookReq",
		is_request = true
	},
	[7278] = {
		msgtype = 7279,
		func_name = "UseFriendCookBookReq",
		is_request = true
	},
	[7280] = {
		msgtype = 7281,
		func_name = "SetCookBookReq",
		is_request = true
	},
	[7282] = {
		msgtype = 7283,
		func_name = "RemoveCookBookReq",
		is_request = true
	},
	[7284] = {
		msgtype = 7285,
		func_name = "SetCookStyleReq",
		is_request = true
	},
	[7286] = {
		msgtype = 7287,
		func_name = "SetChefReq",
		is_request = true
	},
	[7291] = {
		msgtype = 7292,
		func_name = "RequestAddFriendReq",
		is_request = true
	},
	[7293] = {
		msgtype = 7294,
		func_name = "AddFriendReq",
		is_request = true
	},
	[7295] = {
		msgtype = 7296,
		func_name = "RemoveFriendRequestReq",
		is_request = true
	},
	[7297] = {
		msgtype = 7298,
		func_name = "RemoveAllFriendRequestReq",
		is_request = true
	},
	[7299] = {
		msgtype = 7300,
		func_name = "RemoveFriendReq",
		is_request = true
	},
	[7301] = {
		msgtype = 7302,
		func_name = "RecommendReq",
		is_request = true
	},
	[7303] = {
		msgtype = 7304,
		func_name = "GetRecommendListReq",
		is_request = true
	},
	[7305] = {
		msgtype = 7306,
		func_name = "CancelFriendStateReq",
		is_request = true
	},
	[7307] = {
		msgtype = 7308,
		func_name = "TopFriendStateReq",
		is_request = true
	},
	[7311] = {
		msgtype = 7312,
		func_name = "SaveGarrisonReq",
		is_request = true
	},
	[7314] = {
		msgtype = 7315,
		func_name = "RefreshRivalReq",
		is_request = true
	},
	[7316] = {
		msgtype = 7317,
		func_name = "EnterManeuverReq",
		is_request = true
	},
	[7320] = {
		msgtype = 7321,
		func_name = "ClassroomExtendReq",
		is_request = true
	},
	[7322] = {
		msgtype = 7323,
		func_name = "ReplaceTeacherReq",
		is_request = true
	},
	[7324] = {
		msgtype = 7325,
		func_name = "StartStudyReq",
		is_request = true
	},
	[7326] = {
		msgtype = 7327,
		func_name = "StopStudyReq",
		is_request = true
	},
	[7331] = {
		msgtype = 7332,
		func_name = "ChangeRankSupportReq",
		is_request = true
	},
	[7333] = {
		msgtype = 7334,
		func_name = "ReadRankSupportReq",
		is_request = true
	},
	[7335] = {
		msgtype = 7336,
		func_name = "ActiveRankSupportReq",
		is_request = true
	},
	[7342] = {
		msgtype = 7343,
		func_name = "ChangeWallCollectionReq",
		is_request = true
	},
	[7344] = {
		msgtype = 7345,
		func_name = "ChangeDeskCollectionReq",
		is_request = true
	},
	[7346] = {
		msgtype = 7347,
		func_name = "ChangeMedalReq",
		is_request = true
	},
	[7348] = {
		msgtype = 7349,
		func_name = "UpgradeMedalReq",
		is_request = true
	},
	[7351] = {
		msgtype = 7352,
		func_name = "ChangeBoxroomStyleReq",
		is_request = true
	},
	[7354] = {
		msgtype = 7355,
		func_name = "SaveGuideReq",
		is_request = true
	},
	[7362] = {
		msgtype = 7363,
		func_name = "EnterSixthBigMapReq",
		is_request = true
	},
	[7364] = {
		msgtype = 7365,
		func_name = "EnterSixthMapReq",
		is_request = true
	},
	[7366] = {
		msgtype = 7367,
		func_name = "EnterSixthStoryReq",
		is_request = true
	},
	[7368] = {
		msgtype = 7369,
		func_name = "SixthMoveReq",
		is_request = true
	},
	[7370] = {
		msgtype = 7371,
		func_name = "SixthChooseReq",
		is_request = true
	},
	[7372] = {
		msgtype = 7373,
		func_name = "SixthTeamSaveReq",
		is_request = true
	},
	[7374] = {
		msgtype = 7375,
		func_name = "SixthQuitMapReq",
		is_request = true
	},
	[7376] = {
		msgtype = 7377,
		func_name = "SixthEnterPointReq",
		is_request = true
	},
	[7378] = {
		msgtype = 7379,
		func_name = "SixthCompleteMapReq",
		is_request = true
	},
	[7380] = {
		msgtype = 7381,
		func_name = "SixthShopBuyReq",
		is_request = true
	},
	[7382] = {
		msgtype = 7383,
		func_name = "MultiSixthShopBuyReq",
		is_request = true
	},
	[7384] = {
		msgtype = 7385,
		func_name = "SixthUseAdjutantSkillReq",
		is_request = true
	},
	[7386] = {
		msgtype = 7387,
		func_name = "SixthBuyTicketReq",
		is_request = true
	},
	[7388] = {
		msgtype = 7389,
		func_name = "SixthRefreshChooseReq",
		is_request = true
	},
	[7390] = {
		msgtype = 7391,
		func_name = "SixthChangeAdjutantReq",
		is_request = true
	},
	[7392] = {
		msgtype = 7393,
		func_name = "SixthBuyAdjutantExpReq",
		is_request = true
	},
	[7394] = {
		msgtype = 7395,
		func_name = "SixthGuideReq",
		is_request = true
	},
	[7396] = {
		msgtype = 7397,
		func_name = "SixthResetBigMapReq",
		is_request = true
	},
	[7399] = {
		msgtype = 7400,
		func_name = "UpgradeWorkshopReq",
		is_request = true
	},
	[7401] = {
		msgtype = 7402,
		func_name = "CreatePayOrderReq",
		is_request = true
	},
	[7404] = {
		msgtype = 7405,
		func_name = "OrderPayDoneReq",
		is_request = true
	},
	[7406] = {
		msgtype = 7407,
		func_name = "GetFirstRewardReq",
		is_request = true
	},
	[7411] = {
		msgtype = 7412,
		func_name = "EnterTowerReq",
		is_request = true
	},
	[7413] = {
		msgtype = 7414,
		func_name = "TowerGetRewardReq",
		is_request = true
	},
	[7415] = {
		msgtype = 7416,
		func_name = "TowerGetChipReq",
		is_request = true
	},
	[7417] = {
		msgtype = 7418,
		func_name = "TowerEquipChipReq",
		is_request = true
	},
	[7419] = {
		msgtype = 7420,
		func_name = "TowerChipInTransientReq",
		is_request = true
	},
	[7421] = {
		msgtype = 7422,
		func_name = "TowerDecomposeChipReq",
		is_request = true
	},
	[7423] = {
		msgtype = 7424,
		func_name = "TowerChipAbandonReq",
		is_request = true
	},
	[7425] = {
		msgtype = 7426,
		func_name = "TowerTransientEquipReq",
		is_request = true
	},
	[7427] = {
		msgtype = 7428,
		func_name = "TowerResetLevelReq",
		is_request = true
	},
	[7429] = {
		msgtype = 7430,
		func_name = "TowerBuyChipReq",
		is_request = true
	},
	[7431] = {
		msgtype = 7432,
		func_name = "TowerGetNewReq",
		is_request = true
	},
	[7435] = {
		msgtype = 7436,
		func_name = "ActivityDurationReq",
		is_request = true
	},
	[7441] = {
		msgtype = 7442,
		func_name = "SolidEnterMapReq",
		is_request = true
	},
	[7443] = {
		msgtype = 7444,
		func_name = "SolidEnterPointReq",
		is_request = true
	},
	[7445] = {
		msgtype = 7446,
		func_name = "SolidSaveTeamReq",
		is_request = true
	},
	[7447] = {
		msgtype = 7448,
		func_name = "SolidQuitMapReq",
		is_request = true
	},
	[7449] = {
		msgtype = 7450,
		func_name = "SolidGetAwardReq",
		is_request = true
	},
	[7455] = {
		msgtype = 7456,
		func_name = "ConcertoEnterMapReq",
		is_request = true
	},
	[7457] = {
		msgtype = 7458,
		func_name = "ConcertoMapMoveReq",
		is_request = true
	},
	[7459] = {
		msgtype = 7460,
		func_name = "ConcertoStationReq",
		is_request = true
	},
	[7461] = {
		msgtype = 7462,
		func_name = "ConcertoStationExitReq",
		is_request = true
	},
	[7463] = {
		msgtype = 7464,
		func_name = "ConcertoGetRewardReq",
		is_request = true
	},
	[7466] = {
		msgtype = 7467,
		func_name = "RecreationTeamSaveReq",
		is_request = true
	},
	[7468] = {
		msgtype = 7469,
		func_name = "RecreationShopBuyReq",
		is_request = true
	},
	[7470] = {
		msgtype = 7471,
		func_name = "RecreationEnterMapReq",
		is_request = true
	},
	[7472] = {
		msgtype = 7473,
		func_name = "RecreationMoveMapReq",
		is_request = true
	},
	[7475] = {
		msgtype = 7476,
		func_name = "ConcertoReadReq",
		is_request = true
	},
	[7481] = {
		msgtype = 7482,
		func_name = "OceanSaveTeamReq",
		is_request = true
	},
	[7483] = {
		msgtype = 7484,
		func_name = "OceanBuyReq",
		is_request = true
	},
	[7485] = {
		msgtype = 7486,
		func_name = "OceanResetBuyReq",
		is_request = true
	},
	[7487] = {
		msgtype = 7488,
		func_name = "OceanEnterMapReq",
		is_request = true
	},
	[7489] = {
		msgtype = 7490,
		func_name = "OceanMoveMapReq",
		is_request = true
	},
	[7491] = {
		msgtype = 7492,
		func_name = "OceanQuitMapReq",
		is_request = true
	},
	[7493] = {
		msgtype = 7494,
		func_name = "BuildRecordReq",
		is_request = true
	},
	[7495] = {
		msgtype = 7496,
		func_name = "LeaderboardReq",
		is_request = true
	},
	[7497] = {
		msgtype = 7498,
		func_name = "RedeemCodeReq",
		is_request = true
	},
	[7506] = {
		msgtype = 7507,
		func_name = "AbyssEnterMapReq",
		is_request = true
	},
	[7508] = {
		msgtype = 7509,
		func_name = "AbyssMoveMapReq",
		is_request = true
	},
	[7510] = {
		msgtype = 7511,
		func_name = "AbyssSaveTeamReq",
		is_request = true
	},
	[7512] = {
		msgtype = 7513,
		func_name = "AbyssAbyssSaveTeamReq",
		is_request = true
	},
	[7514] = {
		msgtype = 7515,
		func_name = "AbyssCombineReq",
		is_request = true
	},
	[7516] = {
		msgtype = 7517,
		func_name = "AbyssEvoReq",
		is_request = true
	},
	[7518] = {
		msgtype = 7519,
		func_name = "AbyssGetAwardReq",
		is_request = true
	},
	[7520] = {
		msgtype = 7521,
		func_name = "AbyssBossInfoReq",
		is_request = true
	},
	[7522] = {
		msgtype = 7523,
		func_name = "AbyssChooseBuffReq",
		is_request = true
	},
	[7524] = {
		msgtype = 7525,
		func_name = "AbyssQuitMapReq",
		is_request = true
	},
	[7526] = {
		msgtype = 7527,
		func_name = "AbyssGuideReq",
		is_request = true
	},
	[7528] = {
		msgtype = 7529,
		func_name = "AbyssAwardBoxReq",
		is_request = true
	},
	[7532] = {
		msgtype = 7533,
		func_name = "PushChooseBuffReq",
		is_request = true
	},
	[7534] = {
		msgtype = 7535,
		func_name = "PushBuyBuffReq",
		is_request = true
	},
	[7536] = {
		msgtype = 7537,
		func_name = "PushResetBuffReq",
		is_request = true
	},
	[7538] = {
		msgtype = 7539,
		func_name = "PushAddBuffReq",
		is_request = true
	},
	[7540] = {
		msgtype = 7541,
		func_name = "PushEnterMapReq",
		is_request = true
	},
	[7542] = {
		msgtype = 7543,
		func_name = "PushQuitMapReq",
		is_request = true
	},
	[7544] = {
		msgtype = 7545,
		func_name = "PushMapMoveReq",
		is_request = true
	},
	[7546] = {
		msgtype = 7547,
		func_name = "PushSetSupportFleetReq",
		is_request = true
	},
	[7550] = {
		msgtype = 7551,
		func_name = "BattleLogReq",
		is_request = true
	},
	[7553] = {
		msgtype = 7554,
		func_name = "SecretaryShipAdjustReq",
		is_request = true
	},
	[7555] = {
		msgtype = 7556,
		func_name = "SixthDecisiveBattleBuffReq",
		is_request = true
	},
	[7559] = {
		msgtype = 7560,
		func_name = "PushActivityGetInReq",
		is_request = true
	},
	[7561] = {
		msgtype = 7562,
		func_name = "PushActivityRefreshReq",
		is_request = true
	},
	[7563] = {
		msgtype = 7564,
		func_name = "SixthQuitBigMapReq",
		is_request = true
	},
	[7565] = {
		msgtype = 7566,
		func_name = "SoildChooseBuffReq",
		is_request = true
	},
	[7569] = {
		msgtype = 7570,
		func_name = "SeventhEnterMapReq",
		is_request = true
	},
	[7571] = {
		msgtype = 7572,
		func_name = "SeventhQuitMapReq",
		is_request = true
	},
	[7573] = {
		msgtype = 7574,
		func_name = "SeventhMapMoveReq",
		is_request = true
	},
	[7575] = {
		msgtype = 7576,
		func_name = "SeventhBigMapMoveReq",
		is_request = true
	},
	[7577] = {
		msgtype = 7578,
		func_name = "SeventhEnterEliteReq",
		is_request = true
	},
	[7579] = {
		msgtype = 7580,
		func_name = "SeventhEnterChaseReq",
		is_request = true
	},
	[7581] = {
		msgtype = 7582,
		func_name = "SeventhUpgradeBuffReq",
		is_request = true
	},
	[7583] = {
		msgtype = 7584,
		func_name = "SeventhResetBuffReq",
		is_request = true
	},
	[7585] = {
		msgtype = 7586,
		func_name = "SeventhGuideReq",
		is_request = true
	},
	[7588] = {
		msgtype = 7589,
		func_name = "SaveCustomCoverReq",
		is_request = true
	},
	[7596] = {
		msgtype = 7597,
		func_name = "AnswerBuyReq",
		is_request = true
	},
	[7598] = {
		msgtype = 7599,
		func_name = "AnswerResetBuyReq",
		is_request = true
	},
	[7600] = {
		msgtype = 7601,
		func_name = "AnswerGetAwardReq",
		is_request = true
	},
	[7602] = {
		msgtype = 7603,
		func_name = "AnswerRemindReq",
		is_request = true
	},
	[7604] = {
		msgtype = 7605,
		func_name = "AnswerQuestionReq",
		is_request = true
	},
	[7606] = {
		msgtype = 7607,
		func_name = "AnswerGuideReq",
		is_request = true
	},
	[7608] = {
		msgtype = 7609,
		func_name = "AnswerEnterMapReq",
		is_request = true
	},
	[7610] = {
		msgtype = 7611,
		func_name = "AnswerMoveMapReq",
		is_request = true
	},
	[7612] = {
		msgtype = 7613,
		func_name = "AnswerQuitMapReq",
		is_request = true
	},
	[7616] = {
		msgtype = 7617,
		func_name = "SolidExtendBuffNumReq",
		is_request = true
	},
	[7618] = {
		msgtype = 7619,
		func_name = "SolidExtendBuffStatusReq",
		is_request = true
	},
	[7620] = {
		msgtype = 7621,
		func_name = "ResearchTaskSubmitReq",
		is_request = true
	},
	[7622] = {
		msgtype = 7623,
		func_name = "GetResearchShipRewardReq",
		is_request = true
	},
	[7624] = {
		msgtype = 7625,
		func_name = "ResearchEquipSubmitReq",
		is_request = true
	},
	[7626] = {
		msgtype = 7627,
		func_name = "GetResearchEquipRewardReq",
		is_request = true
	},
	[7628] = {
		msgtype = 7629,
		func_name = "ResearchBoatIdReq",
		is_request = true
	},
	[7630] = {
		msgtype = 7631,
		func_name = "SeventhTreasureGetAwardReq",
		is_request = true
	},
	[7632] = {
		msgtype = 7633,
		func_name = "SolidInitBattleDataReq",
		is_request = true
	},
	[7634] = {
		msgtype = 7635,
		func_name = "CommitTaskAllReq",
		is_request = true
	},
	[7636] = {
		msgtype = 7637,
		func_name = "MultiShipChangeSkinReq",
		is_request = true
	},
	[7638] = {
		msgtype = 7639,
		func_name = "ChangeRoomStyleReq",
		is_request = true
	},
	[7640] = {
		msgtype = 7641,
		func_name = "ChangeStarSetReq",
		is_request = true
	},
	[7643] = {
		msgtype = 7644,
		func_name = "BVRAttackChangeReq",
		is_request = true
	},
	[7648] = {
		msgtype = 7649,
		func_name = "EighthEnterMapReq",
		is_request = true
	},
	[7650] = {
		msgtype = 7651,
		func_name = "EighthQuitMapReq",
		is_request = true
	},
	[7652] = {
		msgtype = 7653,
		func_name = "EighthMapMoveReq",
		is_request = true
	},
	[7654] = {
		msgtype = 7655,
		func_name = "EighthBigMapMoveReq",
		is_request = true
	},
	[7656] = {
		msgtype = 7657,
		func_name = "EighthEnemyMoveReq",
		is_request = true
	},
	[7658] = {
		msgtype = 7659,
		func_name = "EighthEnterEliteReq",
		is_request = true
	},
	[7660] = {
		msgtype = 7661,
		func_name = "EighthEnterChaseReq",
		is_request = true
	},
	[7662] = {
		msgtype = 7663,
		func_name = "EighthUpgradeBuffReq",
		is_request = true
	},
	[7664] = {
		msgtype = 7665,
		func_name = "EighthResetBuffReq",
		is_request = true
	},
	[7666] = {
		msgtype = 7667,
		func_name = "EighthGuideReq",
		is_request = true
	},
	[7668] = {
		msgtype = 7669,
		func_name = "EighthSupportFleetAtkReq",
		is_request = true
	},
	[7670] = {
		msgtype = 7671,
		func_name = "EighthSetSupPosReq",
		is_request = true
	},
	[7672] = {
		msgtype = 7673,
		func_name = "EighthEliteMoveReq",
		is_request = true
	},
	[7680] = {
		msgtype = 7681,
		func_name = "EnterMistBigMapReq",
		is_request = true
	},
	[7682] = {
		msgtype = 7683,
		func_name = "EnterMistMapReq",
		is_request = true
	},
	[7684] = {
		msgtype = 7685,
		func_name = "EnterMistStoryReq",
		is_request = true
	},
	[7686] = {
		msgtype = 7687,
		func_name = "MistMoveReq",
		is_request = true
	},
	[7688] = {
		msgtype = 7689,
		func_name = "MistChooseReq",
		is_request = true
	},
	[7690] = {
		msgtype = 7691,
		func_name = "MistTeamSaveReq",
		is_request = true
	},
	[7692] = {
		msgtype = 7693,
		func_name = "MistQuitMapReq",
		is_request = true
	},
	[7694] = {
		msgtype = 7695,
		func_name = "MistEnterPointReq",
		is_request = true
	},
	[7696] = {
		msgtype = 7697,
		func_name = "MistPointCompleteReq",
		is_request = true
	},
	[7698] = {
		msgtype = 7699,
		func_name = "MistCompleteMapReq",
		is_request = true
	},
	[7700] = {
		msgtype = 7701,
		func_name = "MistUseAdjutantSkillReq",
		is_request = true
	},
	[7702] = {
		msgtype = 7703,
		func_name = "MistBuyTicketReq",
		is_request = true
	},
	[7704] = {
		msgtype = 7705,
		func_name = "MistRefreshChooseReq",
		is_request = true
	},
	[7706] = {
		msgtype = 7707,
		func_name = "MistChangeAdjutantReq",
		is_request = true
	},
	[7708] = {
		msgtype = 7709,
		func_name = "MistBuyAdjutantExpReq",
		is_request = true
	},
	[7710] = {
		msgtype = 7711,
		func_name = "MistGuideReq",
		is_request = true
	},
	[7712] = {
		msgtype = 7713,
		func_name = "MistResetBigMapReq",
		is_request = true
	},
	[7714] = {
		msgtype = 7715,
		func_name = "MistGetAwardReq",
		is_request = true
	},
	[7717] = {
		msgtype = 7718,
		func_name = "MultiShipRepairReq",
		is_request = true
	},
	[7719] = {
		msgtype = 7720,
		func_name = "PushGuideReq",
		is_request = true
	},
	[7722] = {
		msgtype = 7723,
		func_name = "ChangeSecretaryDataReq",
		is_request = true
	},
	[7724] = {
		msgtype = 7725,
		func_name = "ChangeMiddleBrokenReq",
		is_request = true
	},
	[7726] = {
		msgtype = 7727,
		func_name = "ChangeRandSecretaryReq",
		is_request = true
	},
	[7728] = {
		msgtype = 7729,
		func_name = "SimulatedBuildReq",
		is_request = true
	},
	[7730] = {
		msgtype = 7731,
		func_name = "BindingPhoneReq",
		is_request = true
	},
	[7732] = {
		msgtype = 7733,
		func_name = "SensitiveWordsReq",
		is_request = true
	},
	[7742] = {
		msgtype = 7743,
		func_name = "NinthBuyReq",
		is_request = true
	},
	[7744] = {
		msgtype = 7745,
		func_name = "NinthResetBuyReq",
		is_request = true
	},
	[7746] = {
		msgtype = 7747,
		func_name = "NinthGetAwardReq",
		is_request = true
	},
	[7748] = {
		msgtype = 7749,
		func_name = "NinthGuideReq",
		is_request = true
	},
	[7750] = {
		msgtype = 7751,
		func_name = "NinthEnterMapReq",
		is_request = true
	},
	[7752] = {
		msgtype = 7753,
		func_name = "NinthMapMoveReq",
		is_request = true
	},
	[7754] = {
		msgtype = 7755,
		func_name = "NinthQuitMapReq",
		is_request = true
	},
	[7756] = {
		msgtype = 7757,
		func_name = "NinthMaxScoreLevelPassReq",
		is_request = true
	},
	[7759] = {
		msgtype = 7760,
		func_name = "AnswerMaxScoreLevelPassReq",
		is_request = true
	},
	[7762] = {
		msgtype = 7763,
		func_name = "SolidMaxScoreLevelPassReq",
		is_request = true
	},
	[7764] = {
		msgtype = 7765,
		func_name = "TokenRefreshReq",
		is_request = true
	},
	[7767] = {
		msgtype = 7768,
		func_name = "AnnouncementRefreshReq",
		is_request = true
	}
}
local var_0_2 = {
	[5001] = {
		is_request = false,
		func_name = "ChangeGateNotify",
		is_response = false
	},
	[5002] = {
		is_request = false,
		func_name = "RandomNotify",
		is_response = false
	},
	[5004] = {
		is_request = true,
		func_name = "AuthResp",
		is_response = true
	},
	[5005] = {
		is_request = false,
		func_name = "InOtherLocalLoginNotify",
		is_response = false
	},
	[5006] = {
		is_request = false,
		func_name = "PatchUpdateNotify",
		is_response = false
	},
	[5007] = {
		is_request = false,
		func_name = "ProtocolUpdateNotify",
		is_response = false
	},
	[5008] = {
		is_request = false,
		func_name = "SystemDataNotify",
		is_response = false
	},
	[5010] = {
		is_request = true,
		func_name = "RealNameAuthResp",
		is_response = true
	},
	[7001] = {
		is_request = false,
		func_name = "TellIPNotify",
		is_response = false
	},
	[7002] = {
		is_request = false,
		func_name = "ErrorCodeNotify",
		is_response = false
	},
	[7003] = {
		is_request = false,
		func_name = "DebugLogNotify",
		is_response = false
	},
	[7004] = {
		is_request = false,
		func_name = "LastTimeInfoNotify",
		is_response = false
	},
	[7005] = {
		is_request = false,
		func_name = "ReadyNotify",
		is_response = false
	},
	[7006] = {
		is_request = false,
		func_name = "LoadDataResultNotify",
		is_response = false
	},
	[7008] = {
		is_request = true,
		func_name = "LoadDataResp",
		is_response = true
	},
	[7009] = {
		is_request = false,
		func_name = "UserInfoUpdate",
		is_response = false
	},
	[7010] = {
		is_request = false,
		func_name = "ServerTimeNotify",
		is_response = false
	},
	[7011] = {
		is_request = false,
		func_name = "TellWaitEnterNotify",
		is_response = false
	},
	[7013] = {
		is_request = true,
		func_name = "EnterResp",
		is_response = true
	},
	[7015] = {
		is_request = true,
		func_name = "ChangeNameResp",
		is_response = true
	},
	[7016] = {
		is_request = false,
		func_name = "DailyAwardNotify",
		is_response = false
	},
	[7017] = {
		is_request = false,
		func_name = "OnceDailyAwardNotify",
		is_response = false
	},
	[7019] = {
		is_request = true,
		func_name = "TellDeviceResp",
		is_response = true
	},
	[7021] = {
		is_request = true,
		func_name = "DailyNoticeResp",
		is_response = true
	},
	[7022] = {
		is_request = false,
		func_name = "ShipInfoUpdate",
		is_response = false
	},
	[7023] = {
		is_request = false,
		func_name = "SkinInfoUpdate",
		is_response = false
	},
	[7025] = {
		is_request = true,
		func_name = "GetNewPlayerShipResp",
		is_response = true
	},
	[7027] = {
		is_request = true,
		func_name = "IntensifyShipResp",
		is_response = true
	},
	[7029] = {
		is_request = true,
		func_name = "IntensifySkillResp",
		is_response = true
	},
	[7031] = {
		is_request = true,
		func_name = "ShipRenameResp",
		is_response = true
	},
	[7033] = {
		is_request = true,
		func_name = "ChangeSecretaryResp",
		is_response = true
	},
	[7035] = {
		is_request = true,
		func_name = "ResetSecretaryResp",
		is_response = true
	},
	[7037] = {
		is_request = true,
		func_name = "ShipLockResp",
		is_response = true
	},
	[7039] = {
		is_request = true,
		func_name = "ShipEquipResp",
		is_response = true
	},
	[7041] = {
		is_request = true,
		func_name = "ShipRemoveEquipResp",
		is_response = true
	},
	[7043] = {
		is_request = true,
		func_name = "ShipEquipRecordResp",
		is_response = true
	},
	[7045] = {
		is_request = true,
		func_name = "UseEquipRecordResp",
		is_response = true
	},
	[7047] = {
		is_request = true,
		func_name = "ShipRepairResp",
		is_response = true
	},
	[7049] = {
		is_request = true,
		func_name = "QuickRepairResp",
		is_response = true
	},
	[7051] = {
		is_request = true,
		func_name = "RubBackResp",
		is_response = true
	},
	[7053] = {
		is_request = true,
		func_name = "ShipMarryResp",
		is_response = true
	},
	[7055] = {
		is_request = true,
		func_name = "ShipChangeSkinResp",
		is_response = true
	},
	[7057] = {
		is_request = true,
		func_name = "ShipEvoResp",
		is_response = true
	},
	[7059] = {
		is_request = true,
		func_name = "ShipChangeTacticsResp",
		is_response = true
	},
	[7061] = {
		is_request = true,
		func_name = "ShipChangeSkillResp",
		is_response = true
	},
	[7062] = {
		is_request = false,
		func_name = "TeamInfoUpdate",
		is_response = false
	},
	[7063] = {
		is_request = false,
		func_name = "SupportInfoUpdate",
		is_response = false
	},
	[7065] = {
		is_request = true,
		func_name = "TeamSaveResp",
		is_response = true
	},
	[7067] = {
		is_request = true,
		func_name = "TeamRenameResp",
		is_response = true
	},
	[7069] = {
		is_request = true,
		func_name = "ShipSupplyResp",
		is_response = true
	},
	[7071] = {
		is_request = true,
		func_name = "TeamSupplyResp",
		is_response = true
	},
	[7073] = {
		is_request = true,
		func_name = "AllShipSupplyResp",
		is_response = true
	},
	[7075] = {
		is_request = true,
		func_name = "TeamRepairResp",
		is_response = true
	},
	[7077] = {
		is_request = true,
		func_name = "SupportLevelUpResp",
		is_response = true
	},
	[7079] = {
		is_request = true,
		func_name = "SupportSupplyResp",
		is_response = true
	},
	[7081] = {
		is_request = true,
		func_name = "ActiveAutoSupplyResp",
		is_response = true
	},
	[7082] = {
		is_request = false,
		func_name = "ItemInfoUpdate",
		is_response = false
	},
	[7083] = {
		is_request = false,
		func_name = "EquipInfoUpdate",
		is_response = false
	},
	[7084] = {
		is_request = false,
		func_name = "EquipLockInfoUpdate",
		is_response = false
	},
	[7086] = {
		is_request = true,
		func_name = "EquipLockResp",
		is_response = true
	},
	[7088] = {
		is_request = true,
		func_name = "GetLevelAwardResp",
		is_response = true
	},
	[7090] = {
		is_request = true,
		func_name = "GetDailyAwardResp",
		is_response = true
	},
	[7092] = {
		is_request = true,
		func_name = "GetOnceDailyAwardResp",
		is_response = true
	},
	[7094] = {
		is_request = true,
		func_name = "GetLevelUpAwardResp",
		is_response = true
	},
	[7095] = {
		is_request = false,
		func_name = "CompleteMapNotify",
		is_response = false
	},
	[7096] = {
		is_request = false,
		func_name = "MapInfoUpdate",
		is_response = false
	},
	[7097] = {
		is_request = false,
		func_name = "BattleInfoUpdate",
		is_response = false
	},
	[7099] = {
		is_request = true,
		func_name = "EnterMapResp",
		is_response = true
	},
	[7101] = {
		is_request = true,
		func_name = "QuitMapResp",
		is_response = true
	},
	[7103] = {
		is_request = true,
		func_name = "MapMoveResp",
		is_response = true
	},
	[7105] = {
		is_request = true,
		func_name = "RoundAboutResp",
		is_response = true
	},
	[7107] = {
		is_request = true,
		func_name = "StationPointResp",
		is_response = true
	},
	[7109] = {
		is_request = true,
		func_name = "StationPointExitResp",
		is_response = true
	},
	[7111] = {
		is_request = true,
		func_name = "StartBattleResp",
		is_response = true
	},
	[7113] = {
		is_request = true,
		func_name = "StartNightBattleResp",
		is_response = true
	},
	[7115] = {
		is_request = true,
		func_name = "QuitNightBattleResp",
		is_response = true
	},
	[7117] = {
		is_request = true,
		func_name = "BattleFinishResp",
		is_response = true
	},
	[7119] = {
		is_request = true,
		func_name = "ActiveShellingResp",
		is_response = true
	},
	[7120] = {
		is_request = false,
		func_name = "CampaignInfoUpdate",
		is_response = false
	},
	[7122] = {
		is_request = true,
		func_name = "CampaignTeamSaveResp",
		is_response = true
	},
	[7124] = {
		is_request = true,
		func_name = "EnterCampaignResp",
		is_response = true
	},
	[7126] = {
		is_request = true,
		func_name = "RefreshCampaignResp",
		is_response = true
	},
	[7128] = {
		is_request = true,
		func_name = "CompleteNodeHideResp",
		is_response = true
	},
	[7130] = {
		is_request = true,
		func_name = "CompleteNodeMissResp",
		is_response = true
	},
	[7131] = {
		is_request = false,
		func_name = "ExpeditionInfoUpdate",
		is_response = false
	},
	[7133] = {
		is_request = true,
		func_name = "ExpeditionStartResp",
		is_response = true
	},
	[7135] = {
		is_request = true,
		func_name = "ExpeditionStopResp",
		is_response = true
	},
	[7137] = {
		is_request = true,
		func_name = "ExpeditionFinishResp",
		is_response = true
	},
	[7138] = {
		is_request = false,
		func_name = "TaskUpdate",
		is_response = false
	},
	[7140] = {
		is_request = true,
		func_name = "CommitTaskResp",
		is_response = true
	},
	[7141] = {
		is_request = false,
		func_name = "ShipArchiveUpdate",
		is_response = false
	},
	[7142] = {
		is_request = false,
		func_name = "EquipmentArchiveUpdate",
		is_response = false
	},
	[7143] = {
		is_request = false,
		func_name = "MusicArchiveUpdate",
		is_response = false
	},
	[7144] = {
		is_request = false,
		func_name = "FurnitureArchiveUpdate",
		is_response = false
	},
	[7145] = {
		is_request = false,
		func_name = "BuffArchiveUpdate",
		is_response = false
	},
	[7146] = {
		is_request = false,
		func_name = "ShopInfoUpdate",
		is_response = false
	},
	[7147] = {
		is_request = false,
		func_name = "SpoilsShopInfoUpdate",
		is_response = false
	},
	[7149] = {
		is_request = true,
		func_name = "ShopBuyResp",
		is_response = true
	},
	[7151] = {
		is_request = true,
		func_name = "MultiShopBuyResp",
		is_response = true
	},
	[7153] = {
		is_request = true,
		func_name = "SpoilsBuyResp",
		is_response = true
	},
	[7155] = {
		is_request = true,
		func_name = "MultiSpoilsBuyResp",
		is_response = true
	},
	[7157] = {
		is_request = true,
		func_name = "VoucherShopBuyResp",
		is_response = true
	},
	[7158] = {
		is_request = false,
		func_name = "StoryUpdate",
		is_response = false
	},
	[7160] = {
		is_request = true,
		func_name = "UnlockStoryResp",
		is_response = true
	},
	[7162] = {
		is_request = true,
		func_name = "ReadStoryResp",
		is_response = true
	},
	[7164] = {
		is_request = true,
		func_name = "UnlockShipStoryResp",
		is_response = true
	},
	[7166] = {
		is_request = true,
		func_name = "TokenUnlockStoryResp",
		is_response = true
	},
	[7167] = {
		is_request = false,
		func_name = "MailUpdate",
		is_response = false
	},
	[7169] = {
		is_request = true,
		func_name = "GetMailResp",
		is_response = true
	},
	[7171] = {
		is_request = true,
		func_name = "DeleteMailResp",
		is_response = true
	},
	[7173] = {
		is_request = true,
		func_name = "GetAllMailResp",
		is_response = true
	},
	[7175] = {
		is_request = true,
		func_name = "DeleteAllMailResp",
		is_response = true
	},
	[7177] = {
		is_request = true,
		func_name = "LockMailResp",
		is_response = true
	},
	[7178] = {
		is_request = false,
		func_name = "BuildInfoNotify",
		is_response = false
	},
	[7180] = {
		is_request = true,
		func_name = "BuildShipResp",
		is_response = true
	},
	[7182] = {
		is_request = true,
		func_name = "BuildEquipmentResp",
		is_response = true
	},
	[7184] = {
		is_request = true,
		func_name = "GetBuildShipRewardResp",
		is_response = true
	},
	[7186] = {
		is_request = true,
		func_name = "GetBuildEquipmentRewardResp",
		is_response = true
	},
	[7188] = {
		is_request = true,
		func_name = "QuickBuildShipResp",
		is_response = true
	},
	[7190] = {
		is_request = true,
		func_name = "QuickBuildEquipmentResp",
		is_response = true
	},
	[7192] = {
		is_request = true,
		func_name = "BatchBuildShipResp",
		is_response = true
	},
	[7194] = {
		is_request = true,
		func_name = "BatchBuildEquipmentResp",
		is_response = true
	},
	[7196] = {
		is_request = true,
		func_name = "DecomposeShipResp",
		is_response = true
	},
	[7198] = {
		is_request = true,
		func_name = "DecomposeEquipmentResp",
		is_response = true
	},
	[7200] = {
		is_request = true,
		func_name = "UseItemBoxResp",
		is_response = true
	},
	[7201] = {
		is_request = false,
		func_name = "RepairStyleUpdate",
		is_response = false
	},
	[7203] = {
		is_request = true,
		func_name = "ChangeRepairStyleResp",
		is_response = true
	},
	[7205] = {
		is_request = true,
		func_name = "DecomposeCoreResp",
		is_response = true
	},
	[7206] = {
		is_request = false,
		func_name = "BuildRecordUpdate",
		is_response = false
	},
	[7208] = {
		is_request = true,
		func_name = "CollectBuildRecordResp",
		is_response = true
	},
	[7210] = {
		is_request = true,
		func_name = "DeleteBuildRecordResp",
		is_response = true
	},
	[7211] = {
		is_request = false,
		func_name = "FurnitureUpdate",
		is_response = false
	},
	[7212] = {
		is_request = false,
		func_name = "FurnitureCollectUpdate",
		is_response = false
	},
	[7213] = {
		is_request = false,
		func_name = "RoomUpdate",
		is_response = false
	},
	[7214] = {
		is_request = false,
		func_name = "RoomRecordUpdate",
		is_response = false
	},
	[7215] = {
		is_request = false,
		func_name = "ExhibitionCollectUpdate",
		is_response = false
	},
	[7217] = {
		is_request = true,
		func_name = "LockFurnitureResp",
		is_response = true
	},
	[7219] = {
		is_request = true,
		func_name = "ResolveFurnitureResp",
		is_response = true
	},
	[7221] = {
		is_request = true,
		func_name = "ShipEnterRoomResp",
		is_response = true
	},
	[7223] = {
		is_request = true,
		func_name = "RecordRoomResp",
		is_response = true
	},
	[7225] = {
		is_request = true,
		func_name = "ResetRecordResp",
		is_response = true
	},
	[7227] = {
		is_request = true,
		func_name = "UseRecordResp",
		is_response = true
	},
	[7229] = {
		is_request = true,
		func_name = "BuyFurnitureBoxResp",
		is_response = true
	},
	[7231] = {
		is_request = true,
		func_name = "MultiBuyFurnitureBoxResp",
		is_response = true
	},
	[7233] = {
		is_request = true,
		func_name = "LayoutRoomResp",
		is_response = true
	},
	[7235] = {
		is_request = true,
		func_name = "getFurnitureCoollectRewardResp",
		is_response = true
	},
	[7237] = {
		is_request = true,
		func_name = "AddExhibitionCollectResp",
		is_response = true
	},
	[7239] = {
		is_request = true,
		func_name = "RemoveExhibitionCollectResp",
		is_response = true
	},
	[7241] = {
		is_request = true,
		func_name = "UploadRecordResp",
		is_response = true
	},
	[7243] = {
		is_request = true,
		func_name = "UserExhibitionResp",
		is_response = true
	},
	[7245] = {
		is_request = true,
		func_name = "RacingResp",
		is_response = true
	},
	[7247] = {
		is_request = true,
		func_name = "RoomExtendResp",
		is_response = true
	},
	[7249] = {
		is_request = true,
		func_name = "RoomCropResp",
		is_response = true
	},
	[7251] = {
		is_request = true,
		func_name = "DollMachineResp",
		is_response = true
	},
	[7253] = {
		is_request = true,
		func_name = "RoomInteractResp",
		is_response = true
	},
	[7254] = {
		is_request = false,
		func_name = "RacingBuffInfoUpdate",
		is_response = false
	},
	[7256] = {
		is_request = true,
		func_name = "GetExhibitionResp",
		is_response = true
	},
	[7258] = {
		is_request = true,
		func_name = "EvaluateExhibitionResp",
		is_response = true
	},
	[7259] = {
		is_request = false,
		func_name = "ChatHeadUpdate",
		is_response = false
	},
	[7261] = {
		is_request = true,
		func_name = "ChangeChatHeadResp",
		is_response = true
	},
	[7262] = {
		is_request = false,
		func_name = "MansionStyleUpdate",
		is_response = false
	},
	[7264] = {
		is_request = true,
		func_name = "ChangeMansionStyleResp",
		is_response = true
	},
	[7266] = {
		is_request = true,
		func_name = "ChangeMusicResp",
		is_response = true
	},
	[7268] = {
		is_request = true,
		func_name = "ResetMusicResp",
		is_response = true
	},
	[7270] = {
		is_request = true,
		func_name = "ChangeSignatureResp",
		is_response = true
	},
	[7271] = {
		is_request = false,
		func_name = "CookBookUpdate",
		is_response = false
	},
	[7272] = {
		is_request = false,
		func_name = "CookBuffInfoUpdate",
		is_response = false
	},
	[7273] = {
		is_request = false,
		func_name = "UseCookBookUpdate",
		is_response = false
	},
	[7274] = {
		is_request = false,
		func_name = "ChefCookBookUpdate",
		is_response = false
	},
	[7275] = {
		is_request = false,
		func_name = "CookStyleUpdate",
		is_response = false
	},
	[7277] = {
		is_request = true,
		func_name = "UseCookBookResp",
		is_response = true
	},
	[7279] = {
		is_request = true,
		func_name = "UseFriendCookBookResp",
		is_response = true
	},
	[7281] = {
		is_request = true,
		func_name = "SetCookBookResp",
		is_response = true
	},
	[7283] = {
		is_request = true,
		func_name = "RemoveCookBookResp",
		is_response = true
	},
	[7285] = {
		is_request = true,
		func_name = "SetCookStyleResp",
		is_response = true
	},
	[7287] = {
		is_request = true,
		func_name = "SetChefResp",
		is_response = true
	},
	[7288] = {
		is_request = false,
		func_name = "AllChefInfoUpdate",
		is_response = false
	},
	[7289] = {
		is_request = false,
		func_name = "FriendInfoUpdate",
		is_response = false
	},
	[7290] = {
		is_request = false,
		func_name = "FriendRequestInfoUpdate",
		is_response = false
	},
	[7292] = {
		is_request = true,
		func_name = "RequestAddFriendResp",
		is_response = true
	},
	[7294] = {
		is_request = true,
		func_name = "AddFriendResp",
		is_response = true
	},
	[7296] = {
		is_request = true,
		func_name = "RemoveFriendRequestResp",
		is_response = true
	},
	[7298] = {
		is_request = true,
		func_name = "RemoveAllFriendRequestResp",
		is_response = true
	},
	[7300] = {
		is_request = true,
		func_name = "RemoveFriendResp",
		is_response = true
	},
	[7302] = {
		is_request = true,
		func_name = "RecommendResp",
		is_response = true
	},
	[7304] = {
		is_request = true,
		func_name = "GetRecommendListResp",
		is_response = true
	},
	[7306] = {
		is_request = true,
		func_name = "CancelFriendStateResp",
		is_response = true
	},
	[7308] = {
		is_request = true,
		func_name = "TopFriendStateResp",
		is_response = true
	},
	[7309] = {
		is_request = false,
		func_name = "ManeuverInfoUpdate",
		is_response = false
	},
	[7310] = {
		is_request = false,
		func_name = "ManeuverFriendRivalInfoUpdate",
		is_response = false
	},
	[7312] = {
		is_request = true,
		func_name = "SaveGarrisonResp",
		is_response = true
	},
	[7313] = {
		is_request = false,
		func_name = "GrrisonUpdate",
		is_response = false
	},
	[7315] = {
		is_request = true,
		func_name = "RefreshRivalResp",
		is_response = true
	},
	[7317] = {
		is_request = true,
		func_name = "EnterManeuverResp",
		is_response = true
	},
	[7318] = {
		is_request = false,
		func_name = "ClassroomInfoUpdate",
		is_response = false
	},
	[7319] = {
		is_request = false,
		func_name = "TeacherInfoUpdate",
		is_response = false
	},
	[7321] = {
		is_request = true,
		func_name = "ClassroomExtendResp",
		is_response = true
	},
	[7323] = {
		is_request = true,
		func_name = "ReplaceTeacherResp",
		is_response = true
	},
	[7325] = {
		is_request = true,
		func_name = "StartStudyResp",
		is_response = true
	},
	[7327] = {
		is_request = true,
		func_name = "StopStudyResp",
		is_response = true
	},
	[7328] = {
		is_request = false,
		func_name = "SchoolOpenNotify",
		is_response = false
	},
	[7329] = {
		is_request = false,
		func_name = "RankTaskUpdate",
		is_response = false
	},
	[7330] = {
		is_request = false,
		func_name = "RankSupportInfoUpdate",
		is_response = false
	},
	[7332] = {
		is_request = true,
		func_name = "ChangeRankSupportResp",
		is_response = true
	},
	[7334] = {
		is_request = true,
		func_name = "ReadRankSupportResp",
		is_response = true
	},
	[7336] = {
		is_request = true,
		func_name = "ActiveRankSupportResp",
		is_response = true
	},
	[7337] = {
		is_request = false,
		func_name = "BoxroomWallUpdate",
		is_response = false
	},
	[7338] = {
		is_request = false,
		func_name = "BoxroomDeskUpdate",
		is_response = false
	},
	[7339] = {
		is_request = false,
		func_name = "BoxroomMedalUpdate",
		is_response = false
	},
	[7340] = {
		is_request = false,
		func_name = "MedalUpdate",
		is_response = false
	},
	[7341] = {
		is_request = false,
		func_name = "UnlockMedalUpdate",
		is_response = false
	},
	[7343] = {
		is_request = true,
		func_name = "ChangeWallCollectionResp",
		is_response = true
	},
	[7345] = {
		is_request = true,
		func_name = "ChangeDeskCollectionResp",
		is_response = true
	},
	[7347] = {
		is_request = true,
		func_name = "ChangeMedalResp",
		is_response = true
	},
	[7349] = {
		is_request = true,
		func_name = "UpgradeMedalResp",
		is_response = true
	},
	[7350] = {
		is_request = false,
		func_name = "BoxroomStyleUpdate",
		is_response = false
	},
	[7352] = {
		is_request = true,
		func_name = "ChangeBoxroomStyleResp",
		is_response = true
	},
	[7353] = {
		is_request = false,
		func_name = "GuideUpdate",
		is_response = false
	},
	[7355] = {
		is_request = true,
		func_name = "SaveGuideResp",
		is_response = true
	},
	[7356] = {
		is_request = false,
		func_name = "StatisticsInfoUpdate",
		is_response = false
	},
	[7357] = {
		is_request = false,
		func_name = "SixthBigMapInfoUpdate",
		is_response = false
	},
	[7358] = {
		is_request = false,
		func_name = "SixthMapInfoUpdate",
		is_response = false
	},
	[7359] = {
		is_request = false,
		func_name = "SixthInfoUpdate",
		is_response = false
	},
	[7360] = {
		is_request = false,
		func_name = "SixthCombatInfoUpdate",
		is_response = false
	},
	[7361] = {
		is_request = false,
		func_name = "SixthShopInfoUpdate",
		is_response = false
	},
	[7363] = {
		is_request = true,
		func_name = "EnterSixthBigMapResp",
		is_response = true
	},
	[7365] = {
		is_request = true,
		func_name = "EnterSixthMapResp",
		is_response = true
	},
	[7367] = {
		is_request = true,
		func_name = "EnterSixthStoryResp",
		is_response = true
	},
	[7369] = {
		is_request = true,
		func_name = "SixthMoveResp",
		is_response = true
	},
	[7371] = {
		is_request = true,
		func_name = "SixthChooseResp",
		is_response = true
	},
	[7373] = {
		is_request = true,
		func_name = "SixthTeamSaveResp",
		is_response = true
	},
	[7375] = {
		is_request = true,
		func_name = "SixthQuitMapResp",
		is_response = true
	},
	[7377] = {
		is_request = true,
		func_name = "SixthEnterPointResp",
		is_response = true
	},
	[7379] = {
		is_request = true,
		func_name = "SixthCompleteMapResp",
		is_response = true
	},
	[7381] = {
		is_request = true,
		func_name = "SixthShopBuyResp",
		is_response = true
	},
	[7383] = {
		is_request = true,
		func_name = "MultiSixthShopBuyResp",
		is_response = true
	},
	[7385] = {
		is_request = true,
		func_name = "SixthUseAdjutantSkillResp",
		is_response = true
	},
	[7387] = {
		is_request = true,
		func_name = "SixthBuyTicketResp",
		is_response = true
	},
	[7389] = {
		is_request = true,
		func_name = "SixthRefreshChooseResp",
		is_response = true
	},
	[7391] = {
		is_request = true,
		func_name = "SixthChangeAdjutantResp",
		is_response = true
	},
	[7393] = {
		is_request = true,
		func_name = "SixthBuyAdjutantExpResp",
		is_response = true
	},
	[7395] = {
		is_request = true,
		func_name = "SixthGuideResp",
		is_response = true
	},
	[7397] = {
		is_request = true,
		func_name = "SixthResetBigMapResp",
		is_response = true
	},
	[7398] = {
		is_request = false,
		func_name = "WorkshopInfoUpdate",
		is_response = false
	},
	[7400] = {
		is_request = true,
		func_name = "UpgradeWorkshopResp",
		is_response = true
	},
	[7402] = {
		is_request = true,
		func_name = "CreatePayOrderResp",
		is_response = true
	},
	[7403] = {
		is_request = false,
		func_name = "NewPayOrderNotify",
		is_response = false
	},
	[7405] = {
		is_request = true,
		func_name = "OrderPayDoneResp",
		is_response = true
	},
	[7407] = {
		is_request = true,
		func_name = "GetFirstRewardResp",
		is_response = true
	},
	[7408] = {
		is_request = false,
		func_name = "PaySucceedNotify",
		is_response = false
	},
	[7409] = {
		is_request = false,
		func_name = "TowerInfoUpdate",
		is_response = false
	},
	[7410] = {
		is_request = false,
		func_name = "ChipInfoUpdate",
		is_response = false
	},
	[7412] = {
		is_request = true,
		func_name = "EnterTowerResp",
		is_response = true
	},
	[7414] = {
		is_request = true,
		func_name = "TowerGetRewardResp",
		is_response = true
	},
	[7416] = {
		is_request = true,
		func_name = "TowerGetChipResp",
		is_response = true
	},
	[7418] = {
		is_request = true,
		func_name = "TowerEquipChipResp",
		is_response = true
	},
	[7420] = {
		is_request = true,
		func_name = "TowerChipInTransientResp",
		is_response = true
	},
	[7422] = {
		is_request = true,
		func_name = "TowerDecomposeChipResp",
		is_response = true
	},
	[7424] = {
		is_request = true,
		func_name = "TowerChipAbandonResp",
		is_response = true
	},
	[7426] = {
		is_request = true,
		func_name = "TowerTransientEquipResp",
		is_response = true
	},
	[7428] = {
		is_request = true,
		func_name = "TowerResetLevelResp",
		is_response = true
	},
	[7430] = {
		is_request = true,
		func_name = "TowerBuyChipResp",
		is_response = true
	},
	[7432] = {
		is_request = true,
		func_name = "TowerGetNewResp",
		is_response = true
	},
	[7433] = {
		is_request = false,
		func_name = "ActivityTaskUpdate",
		is_response = false
	},
	[7434] = {
		is_request = false,
		func_name = "EmergencyInfoUpdate",
		is_response = false
	},
	[7436] = {
		is_request = true,
		func_name = "ActivityDurationResp",
		is_response = true
	},
	[7437] = {
		is_request = false,
		func_name = "SolidMapInfoUpdate",
		is_response = false
	},
	[7438] = {
		is_request = false,
		func_name = "SolidAwardInfoUpdate",
		is_response = false
	},
	[7439] = {
		is_request = false,
		func_name = "SolidTeamInfoUpdate",
		is_response = false
	},
	[7440] = {
		is_request = false,
		func_name = "SolidInfoUpdate",
		is_response = false
	},
	[7442] = {
		is_request = true,
		func_name = "SolidEnterMapResp",
		is_response = true
	},
	[7444] = {
		is_request = true,
		func_name = "SolidEnterPointResp",
		is_response = true
	},
	[7446] = {
		is_request = true,
		func_name = "SolidSaveTeamResp",
		is_response = true
	},
	[7448] = {
		is_request = true,
		func_name = "SolidQuitMapResp",
		is_response = true
	},
	[7450] = {
		is_request = true,
		func_name = "SolidGetAwardResp",
		is_response = true
	},
	[7451] = {
		is_request = false,
		func_name = "ConcertoInfoUpdate",
		is_response = false
	},
	[7452] = {
		is_request = false,
		func_name = "ConcertoMapInfoUpdate",
		is_response = false
	},
	[7453] = {
		is_request = false,
		func_name = "RecreationShopInfoUpdate",
		is_response = false
	},
	[7454] = {
		is_request = false,
		func_name = "RecreationMapInfoUpdate",
		is_response = false
	},
	[7456] = {
		is_request = true,
		func_name = "ConcertoEnterMapResp",
		is_response = true
	},
	[7458] = {
		is_request = true,
		func_name = "ConcertoMapMoveResp",
		is_response = true
	},
	[7460] = {
		is_request = true,
		func_name = "ConcertoStationResp",
		is_response = true
	},
	[7462] = {
		is_request = true,
		func_name = "ConcertoStationExitResp",
		is_response = true
	},
	[7464] = {
		is_request = true,
		func_name = "ConcertoGetRewardResp",
		is_response = true
	},
	[7465] = {
		is_request = false,
		func_name = "RecreationOpenNotify",
		is_response = false
	},
	[7467] = {
		is_request = true,
		func_name = "RecreationTeamSaveResp",
		is_response = true
	},
	[7469] = {
		is_request = true,
		func_name = "RecreationShopBuyResp",
		is_response = true
	},
	[7471] = {
		is_request = true,
		func_name = "RecreationEnterMapResp",
		is_response = true
	},
	[7473] = {
		is_request = true,
		func_name = "RecreationMoveMapResp",
		is_response = true
	},
	[7474] = {
		is_request = false,
		func_name = "RecreationBuffRrwardNotify",
		is_response = false
	},
	[7476] = {
		is_request = true,
		func_name = "ConcertoReadResp",
		is_response = true
	},
	[7477] = {
		is_request = false,
		func_name = "OceanMapInfoUpdate",
		is_response = false
	},
	[7478] = {
		is_request = false,
		func_name = "OceanTeamInfoUpdate",
		is_response = false
	},
	[7479] = {
		is_request = false,
		func_name = "OceanBuffInfoUpdate",
		is_response = false
	},
	[7480] = {
		is_request = false,
		func_name = "OceanInfoUpdate",
		is_response = false
	},
	[7482] = {
		is_request = true,
		func_name = "OceanSaveTeamResp",
		is_response = true
	},
	[7484] = {
		is_request = true,
		func_name = "OceanBuyResp",
		is_response = true
	},
	[7486] = {
		is_request = true,
		func_name = "OceanResetBuyResp",
		is_response = true
	},
	[7488] = {
		is_request = true,
		func_name = "OceanEnterMapResp",
		is_response = true
	},
	[7490] = {
		is_request = true,
		func_name = "OceanMoveMapResp",
		is_response = true
	},
	[7492] = {
		is_request = true,
		func_name = "OceanQuitMapResp",
		is_response = true
	},
	[7494] = {
		is_request = true,
		func_name = "BuildRecordResp",
		is_response = true
	},
	[7496] = {
		is_request = true,
		func_name = "LeaderboardResp",
		is_response = true
	},
	[7498] = {
		is_request = true,
		func_name = "RedeemCodeResp",
		is_response = true
	},
	[7499] = {
		is_request = false,
		func_name = "AbyssShipInfoUpdate",
		is_response = false
	},
	[7500] = {
		is_request = false,
		func_name = "AbyssMapInfoUpdate",
		is_response = false
	},
	[7501] = {
		is_request = false,
		func_name = "AbyssInfoUpdate",
		is_response = false
	},
	[7502] = {
		is_request = false,
		func_name = "AbyssTeamInfoUpdate",
		is_response = false
	},
	[7503] = {
		is_request = false,
		func_name = "AbyssAbyssTeamInfoUpdate",
		is_response = false
	},
	[7504] = {
		is_request = false,
		func_name = "AbyssAwardUpdate",
		is_response = false
	},
	[7505] = {
		is_request = false,
		func_name = "AbyssBattleInfoUpdate",
		is_response = false
	},
	[7507] = {
		is_request = true,
		func_name = "AbyssEnterMapResp",
		is_response = true
	},
	[7509] = {
		is_request = true,
		func_name = "AbyssMoveMapResp",
		is_response = true
	},
	[7511] = {
		is_request = true,
		func_name = "AbyssSaveTeamResp",
		is_response = true
	},
	[7513] = {
		is_request = true,
		func_name = "AbyssAbyssSaveTeamResp",
		is_response = true
	},
	[7515] = {
		is_request = true,
		func_name = "AbyssCombineResp",
		is_response = true
	},
	[7517] = {
		is_request = true,
		func_name = "AbyssEvoResp",
		is_response = true
	},
	[7519] = {
		is_request = true,
		func_name = "AbyssGetAwardResp",
		is_response = true
	},
	[7521] = {
		is_request = true,
		func_name = "AbyssBossInfoResp",
		is_response = true
	},
	[7523] = {
		is_request = true,
		func_name = "AbyssChooseBuffResp",
		is_response = true
	},
	[7525] = {
		is_request = true,
		func_name = "AbyssQuitMapResp",
		is_response = true
	},
	[7527] = {
		is_request = true,
		func_name = "AbyssGuideResp",
		is_response = true
	},
	[7529] = {
		is_request = true,
		func_name = "AbyssAwardBoxResp",
		is_response = true
	},
	[7530] = {
		is_request = false,
		func_name = "PushBuffInfoUpdate",
		is_response = false
	},
	[7531] = {
		is_request = false,
		func_name = "PushInfoUpdate",
		is_response = false
	},
	[7533] = {
		is_request = true,
		func_name = "PushChooseBuffResp",
		is_response = true
	},
	[7535] = {
		is_request = true,
		func_name = "PushBuyBuffResp",
		is_response = true
	},
	[7537] = {
		is_request = true,
		func_name = "PushResetBuffResp",
		is_response = true
	},
	[7539] = {
		is_request = true,
		func_name = "PushAddBuffResp",
		is_response = true
	},
	[7541] = {
		is_request = true,
		func_name = "PushEnterMapResp",
		is_response = true
	},
	[7543] = {
		is_request = true,
		func_name = "PushQuitMapResp",
		is_response = true
	},
	[7545] = {
		is_request = true,
		func_name = "PushMapMoveResp",
		is_response = true
	},
	[7547] = {
		is_request = true,
		func_name = "PushSetSupportFleetResp",
		is_response = true
	},
	[7548] = {
		is_request = false,
		func_name = "PushSupportFleetUpdate",
		is_response = false
	},
	[7549] = {
		is_request = false,
		func_name = "DailyOnlineTimeLimitNotify",
		is_response = false
	},
	[7551] = {
		is_request = true,
		func_name = "BattleLogResp",
		is_response = true
	},
	[7552] = {
		is_request = false,
		func_name = "SecretaryShipAdjustUpdate",
		is_response = false
	},
	[7554] = {
		is_request = true,
		func_name = "SecretaryShipAdjustResp",
		is_response = true
	},
	[7556] = {
		is_request = true,
		func_name = "SixthDecisiveBattleBuffResp",
		is_response = true
	},
	[7557] = {
		is_request = false,
		func_name = "PushPointBuffUpdate",
		is_response = false
	},
	[7558] = {
		is_request = false,
		func_name = "PushTimeNotify",
		is_response = false
	},
	[7560] = {
		is_request = true,
		func_name = "PushActivityGetInResp",
		is_response = true
	},
	[7562] = {
		is_request = true,
		func_name = "PushActivityRefreshResp",
		is_response = true
	},
	[7564] = {
		is_request = true,
		func_name = "SixthQuitBigMapResp",
		is_response = true
	},
	[7566] = {
		is_request = true,
		func_name = "SoildChooseBuffResp",
		is_response = true
	},
	[7567] = {
		is_request = false,
		func_name = "SeventhInfoUpdate",
		is_response = false
	},
	[7568] = {
		is_request = false,
		func_name = "SeventhMapInfoUpdate",
		is_response = false
	},
	[7570] = {
		is_request = true,
		func_name = "SeventhEnterMapResp",
		is_response = true
	},
	[7572] = {
		is_request = true,
		func_name = "SeventhQuitMapResp",
		is_response = true
	},
	[7574] = {
		is_request = true,
		func_name = "SeventhMapMoveResp",
		is_response = true
	},
	[7576] = {
		is_request = true,
		func_name = "SeventhBigMapMoveResp",
		is_response = true
	},
	[7578] = {
		is_request = true,
		func_name = "SeventhEnterEliteResp",
		is_response = true
	},
	[7580] = {
		is_request = true,
		func_name = "SeventhEnterChaseResp",
		is_response = true
	},
	[7582] = {
		is_request = true,
		func_name = "SeventhUpgradeBuffResp",
		is_response = true
	},
	[7584] = {
		is_request = true,
		func_name = "SeventhResetBuffResp",
		is_response = true
	},
	[7586] = {
		is_request = true,
		func_name = "SeventhGuideResp",
		is_response = true
	},
	[7587] = {
		is_request = false,
		func_name = "CustomCoverNotify",
		is_response = false
	},
	[7589] = {
		is_request = true,
		func_name = "SaveCustomCoverResp",
		is_response = true
	},
	[7590] = {
		is_request = false,
		func_name = "AnswerMapInfoUpdate",
		is_response = false
	},
	[7591] = {
		is_request = false,
		func_name = "AnswerInfoUpdate",
		is_response = false
	},
	[7592] = {
		is_request = false,
		func_name = "AnswerQuestionUpdate",
		is_response = false
	},
	[7593] = {
		is_request = false,
		func_name = "AnswerBuffInfoNotify",
		is_response = false
	},
	[7594] = {
		is_request = false,
		func_name = "AnswerTaskInfoNotify",
		is_response = false
	},
	[7595] = {
		is_request = false,
		func_name = "AnswerAwardInfoNotify",
		is_response = false
	},
	[7597] = {
		is_request = true,
		func_name = "AnswerBuyResp",
		is_response = true
	},
	[7599] = {
		is_request = true,
		func_name = "AnswerResetBuyResp",
		is_response = true
	},
	[7601] = {
		is_request = true,
		func_name = "AnswerGetAwardResp",
		is_response = true
	},
	[7603] = {
		is_request = true,
		func_name = "AnswerRemindResp",
		is_response = true
	},
	[7605] = {
		is_request = true,
		func_name = "AnswerQuestionResp",
		is_response = true
	},
	[7607] = {
		is_request = true,
		func_name = "AnswerGuideResp",
		is_response = true
	},
	[7609] = {
		is_request = true,
		func_name = "AnswerEnterMapResp",
		is_response = true
	},
	[7611] = {
		is_request = true,
		func_name = "AnswerMoveMapResp",
		is_response = true
	},
	[7613] = {
		is_request = true,
		func_name = "AnswerQuitMapResp",
		is_response = true
	},
	[7614] = {
		is_request = false,
		func_name = "ResearchUpdate",
		is_response = false
	},
	[7615] = {
		is_request = false,
		func_name = "SolidExtendBuffUpdate",
		is_response = false
	},
	[7617] = {
		is_request = true,
		func_name = "SolidExtendBuffNumResp",
		is_response = true
	},
	[7619] = {
		is_request = true,
		func_name = "SolidExtendBuffStatusResp",
		is_response = true
	},
	[7621] = {
		is_request = true,
		func_name = "ResearchTaskSubmitResp",
		is_response = true
	},
	[7623] = {
		is_request = true,
		func_name = "GetResearchShipRewardResp",
		is_response = true
	},
	[7625] = {
		is_request = true,
		func_name = "ResearchEquipSubmitResp",
		is_response = true
	},
	[7627] = {
		is_request = true,
		func_name = "GetResearchEquipRewardResp",
		is_response = true
	},
	[7629] = {
		is_request = true,
		func_name = "ResearchBoatIdResp",
		is_response = true
	},
	[7631] = {
		is_request = true,
		func_name = "SeventhTreasureGetAwardResp",
		is_response = true
	},
	[7633] = {
		is_request = true,
		func_name = "SolidInitBattleDataResp",
		is_response = true
	},
	[7635] = {
		is_request = true,
		func_name = "CommitTaskAllResp",
		is_response = true
	},
	[7637] = {
		is_request = true,
		func_name = "MultiShipChangeSkinResp",
		is_response = true
	},
	[7639] = {
		is_request = true,
		func_name = "ChangeRoomStyleResp",
		is_response = true
	},
	[7641] = {
		is_request = true,
		func_name = "ChangeStarSetResp",
		is_response = true
	},
	[7642] = {
		is_request = false,
		func_name = "StarSetUpdate",
		is_response = false
	},
	[7644] = {
		is_request = true,
		func_name = "BVRAttackChangeResp",
		is_response = true
	},
	[7645] = {
		is_request = false,
		func_name = "BVRAttackChangeUpdate",
		is_response = false
	},
	[7646] = {
		is_request = false,
		func_name = "EighthInfoUpdate",
		is_response = false
	},
	[7647] = {
		is_request = false,
		func_name = "EighthMapInfoUpdate",
		is_response = false
	},
	[7649] = {
		is_request = true,
		func_name = "EighthEnterMapResp",
		is_response = true
	},
	[7651] = {
		is_request = true,
		func_name = "EighthQuitMapResp",
		is_response = true
	},
	[7653] = {
		is_request = true,
		func_name = "EighthMapMoveResp",
		is_response = true
	},
	[7655] = {
		is_request = true,
		func_name = "EighthBigMapMoveResp",
		is_response = true
	},
	[7657] = {
		is_request = true,
		func_name = "EighthEnemyMoveResp",
		is_response = true
	},
	[7659] = {
		is_request = true,
		func_name = "EighthEnterEliteResp",
		is_response = true
	},
	[7661] = {
		is_request = true,
		func_name = "EighthEnterChaseResp",
		is_response = true
	},
	[7663] = {
		is_request = true,
		func_name = "EighthUpgradeBuffResp",
		is_response = true
	},
	[7665] = {
		is_request = true,
		func_name = "EighthResetBuffResp",
		is_response = true
	},
	[7667] = {
		is_request = true,
		func_name = "EighthGuideResp",
		is_response = true
	},
	[7669] = {
		is_request = true,
		func_name = "EighthSupportFleetAtkResp",
		is_response = true
	},
	[7671] = {
		is_request = true,
		func_name = "EighthSetSupPosResp",
		is_response = true
	},
	[7673] = {
		is_request = true,
		func_name = "EighthEliteMoveResp",
		is_response = true
	},
	[7674] = {
		is_request = false,
		func_name = "EighthAtkEliteUpdate",
		is_response = false
	},
	[7675] = {
		is_request = false,
		func_name = "MistBigMapInfoUpdate",
		is_response = false
	},
	[7676] = {
		is_request = false,
		func_name = "MistMapInfoUpdate",
		is_response = false
	},
	[7677] = {
		is_request = false,
		func_name = "MistInfoUpdate",
		is_response = false
	},
	[7678] = {
		is_request = false,
		func_name = "MistCombatInfoUpdate",
		is_response = false
	},
	[7679] = {
		is_request = false,
		func_name = "MistShopInfoUpdate",
		is_response = false
	},
	[7681] = {
		is_request = true,
		func_name = "EnterMistBigMapResp",
		is_response = true
	},
	[7683] = {
		is_request = true,
		func_name = "EnterMistMapResp",
		is_response = true
	},
	[7685] = {
		is_request = true,
		func_name = "EnterMistStoryResp",
		is_response = true
	},
	[7687] = {
		is_request = true,
		func_name = "MistMoveResp",
		is_response = true
	},
	[7689] = {
		is_request = true,
		func_name = "MistChooseResp",
		is_response = true
	},
	[7691] = {
		is_request = true,
		func_name = "MistTeamSaveResp",
		is_response = true
	},
	[7693] = {
		is_request = true,
		func_name = "MistQuitMapResp",
		is_response = true
	},
	[7695] = {
		is_request = true,
		func_name = "MistEnterPointResp",
		is_response = true
	},
	[7697] = {
		is_request = true,
		func_name = "MistPointCompleteResp",
		is_response = true
	},
	[7699] = {
		is_request = true,
		func_name = "MistCompleteMapResp",
		is_response = true
	},
	[7701] = {
		is_request = true,
		func_name = "MistUseAdjutantSkillResp",
		is_response = true
	},
	[7703] = {
		is_request = true,
		func_name = "MistBuyTicketResp",
		is_response = true
	},
	[7705] = {
		is_request = true,
		func_name = "MistRefreshChooseResp",
		is_response = true
	},
	[7707] = {
		is_request = true,
		func_name = "MistChangeAdjutantResp",
		is_response = true
	},
	[7709] = {
		is_request = true,
		func_name = "MistBuyAdjutantExpResp",
		is_response = true
	},
	[7711] = {
		is_request = true,
		func_name = "MistGuideResp",
		is_response = true
	},
	[7713] = {
		is_request = true,
		func_name = "MistResetBigMapResp",
		is_response = true
	},
	[7715] = {
		is_request = true,
		func_name = "MistGetAwardResp",
		is_response = true
	},
	[7716] = {
		is_request = false,
		func_name = "MistAwardInfoUpdate",
		is_response = false
	},
	[7718] = {
		is_request = true,
		func_name = "MultiShipRepairResp",
		is_response = true
	},
	[7720] = {
		is_request = true,
		func_name = "PushGuideResp",
		is_response = true
	},
	[7721] = {
		is_request = false,
		func_name = "SecretaryInfoUpdate",
		is_response = false
	},
	[7723] = {
		is_request = true,
		func_name = "ChangeSecretaryDataResp",
		is_response = true
	},
	[7725] = {
		is_request = true,
		func_name = "ChangeMiddleBrokenResp",
		is_response = true
	},
	[7727] = {
		is_request = true,
		func_name = "ChangeRandSecretaryResp",
		is_response = true
	},
	[7729] = {
		is_request = true,
		func_name = "SimulatedBuildResp",
		is_response = true
	},
	[7731] = {
		is_request = true,
		func_name = "BindingPhoneResp",
		is_response = true
	},
	[7733] = {
		is_request = true,
		func_name = "SensitiveWordsResp",
		is_response = true
	},
	[7734] = {
		is_request = false,
		func_name = "NinthMaxScoreUpdate",
		is_response = false
	},
	[7735] = {
		is_request = false,
		func_name = "NinthLevelPassUpdate",
		is_response = false
	},
	[7736] = {
		is_request = false,
		func_name = "NinthMapInfoUpdate",
		is_response = false
	},
	[7737] = {
		is_request = false,
		func_name = "NinthInfoUpdate",
		is_response = false
	},
	[7738] = {
		is_request = false,
		func_name = "NinthBuffInfoNotify",
		is_response = false
	},
	[7739] = {
		is_request = false,
		func_name = "NinthTaskInfoUpdate",
		is_response = false
	},
	[7740] = {
		is_request = false,
		func_name = "NinthServerTaskInfoUpdate",
		is_response = false
	},
	[7741] = {
		is_request = false,
		func_name = "NinthAwardInfoNotify",
		is_response = false
	},
	[7743] = {
		is_request = true,
		func_name = "NinthBuyResp",
		is_response = true
	},
	[7745] = {
		is_request = true,
		func_name = "NinthResetBuyResp",
		is_response = true
	},
	[7747] = {
		is_request = true,
		func_name = "NinthGetAwardResp",
		is_response = true
	},
	[7749] = {
		is_request = true,
		func_name = "NinthGuideResp",
		is_response = true
	},
	[7751] = {
		is_request = true,
		func_name = "NinthEnterMapResp",
		is_response = true
	},
	[7753] = {
		is_request = true,
		func_name = "NinthMapMoveResp",
		is_response = true
	},
	[7755] = {
		is_request = true,
		func_name = "NinthQuitMapResp",
		is_response = true
	},
	[7757] = {
		is_request = true,
		func_name = "NinthMaxScoreLevelPassResp",
		is_response = true
	},
	[7758] = {
		is_request = false,
		func_name = "AnswerMaxScoreUpdate",
		is_response = false
	},
	[7760] = {
		is_request = true,
		func_name = "AnswerMaxScoreLevelPassResp",
		is_response = true
	},
	[7761] = {
		is_request = false,
		func_name = "SolidMaxScoreUpdate",
		is_response = false
	},
	[7763] = {
		is_request = true,
		func_name = "SolidMaxScoreLevelPassResp",
		is_response = true
	},
	[7765] = {
		is_request = true,
		func_name = "TokenRefreshResp",
		is_response = true
	},
	[7766] = {
		is_request = false,
		func_name = "TokenRefreshUpdate",
		is_response = false
	},
	[7768] = {
		is_request = true,
		func_name = "AnnouncementRefreshResp",
		is_response = true
	},
	[7769] = {
		is_request = false,
		func_name = "AnnouncementUpdate",
		is_response = false
	}
}

function var_0_0.getRequestMsgInfo(arg_1_0)
	if not var_0_1[arg_1_0] then
		return nil
	end

	return var_0_1[arg_1_0].func_name, var_0_1[arg_1_0].msgtype, var_0_1[arg_1_0].is_request
end

function var_0_0.checkResponseMsgInfo(arg_2_0)
	if not var_0_2[arg_2_0] then
		return
	end

	return var_0_2[arg_2_0].is_response, var_0_2[arg_2_0].is_request, var_0_2[arg_2_0].func_name
end

function var_0_0.get_version()
	return "2f4b1179254d248f05d5cf6d1dff45c0"
end

return var_0_0
